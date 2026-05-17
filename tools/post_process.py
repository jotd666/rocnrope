import re,pathlib

gamename = "rocnrope"

# game_specific: replace or remove I/O addresses
# if not done it will write in ROM here!!
input_dict = {
"mainlatch_8081":"",
"watchdog_8000":"",
"interrupt_vector_8182":"",
"interrupt_vector_8184":"",
"interrupt_vector_8186":"",
"interrupt_vector_8188":"",
"interrupt_vector_818a":"",
"interrupt_vector_818c":"",
"audio_8100":"sound_start",
"dsw1_3083":"read_dsw_1",
"dsw2_3000":"read_dsw_2",
"dsw3_3100":"read_dsw_3",
"port1_3081":"read_inputs_1",
"port2_3082":"read_inputs_2",
"system_3080":"read_system_inputs",
}

store_to_video = re.compile("GET_ADDRESS\s+(0x4[89ABCDEF]|video_ram_4)",flags=re.I)   # game_specific


# post-conversion automatic patches, allowing not to change the asm file by hand
tablere = re.compile("move.w\t#(\w*table_....),d(.)")
jmpre = re.compile("(j..)\s+\[a,(.)\]")
dreg_dict = {'a':'d0','b':'d1'}
areg_dict = {'x':'a2','y':'a3','u':'a4'}

jtre = re.compile("#jump_table_(\w+)")

def remove_instruction(lines,i):
    return change_instruction("",lines,i)

def remove_continuing_lines(lines,i):
    for j in range(i+1,i+4):
        if "[...]" in lines[j]:
            lines[j] = ""
        else:
            break


def get_line_address(line):
    try:
        toks = line.split("|")
        address = toks[1].strip(" [$").split(":")[0]
        return int(address,16)
    except (ValueError,IndexError):
        return None

def change_instruction(code,lines,i):
    line = lines[i]
    toks = line.split("|")
    if len(toks)==2:
        toks[0] = f"\t{code}"
        remove_continuing_lines(lines,i)
        return " | ".join(toks)
    return line

def remove_error(line):
    if "ERROR" in line:
        return ""
    else:
        raise Exception(f"No ERROR to remove in {line}")


def process_jump_table(line):
    m = jtre.search(line)
    if m:
        # move.w  #jump_table...,dX => lea jump_table...,aX works as X ranges from 2 to 4
        # in debug mode, leave register address
        line2 = line.replace("jump_table_","0x")
        line = f"""\t.ifndef\tRELEASE
{line2}\t.endif
""" + line.replace("move.w\t#","lea\t").replace(",d",",a")

    if "indirect j" in line:
        # grab original code in comments, dirty but works as long as converter
        # presents it like this
        comment = line.split('|')[1]
        nb_entries = ""
        m = re.search("\[nb_entries=(\d+)",comment)
        if m:
            nb_entries = m.group(1)


        orig_inst = line.split(":")[1].split("]")[0].replace('[','')
        # parse code: Jxx [R1,R2], R1 = A or B, R2 = X,Y,U
        toks = orig_inst.split()

        dreg,areg = toks[1].split(",")

        areg = areg_dict[areg]
        line = remove_error(line)
        macro = f"{toks[0].upper()}_{dreg.upper()}_INDEXED"
        line = f"""\t{macro}\t{areg},{nb_entries}  |{comment}
"""
    return line

def get_original_instruction(line):
    toks = line.split("| [")
    if len(toks)==1:
        return ""
    inst = toks[1][7:].split("]")[0]
    return inst


def remove_code(pattern,lines,i):
    if pattern in lines[i]:
        lines[i] = remove_instruction(lines,i)
        remove_continuing_lines(lines,i)
    return lines[i]

def subt(m):
    tn = m.group(1)
    rn = m.group(2)
    offset = tn.split("_")[-1]
    rval = f"""
\t.ifndef\tRELEASE
\tmove.w\t#0x{offset},d{rn}
\t.endif
\tlea\t{tn},a{rn}"""
    return rval

equates = []
global_symbols = []

this_dir = pathlib.Path(__file__).absolute().parent

source_dir = this_dir / "../src"


# various dirty but at least automatic patches applying on the converted code
with open(source_dir / "conv.s") as f:
    lines = list(f)

    for i,line in enumerate(lines):
        if " = " in line:
            equates.append(line)
            line = ""


##        elif "review stray daa" in line:
##            line = """\tCLR_XC_FLAGS
##\tmove.b\t(a0),d6
##\tabcd\td6,d0
##"""

        address = get_line_address(line)

        line = process_jump_table(line)

        # pre-add video_address tag if we find a store instruction to an explicit 3000-3FFF address
        if store_to_video.search(line):
            line = line.rstrip() + " [video_address]\n"


        if "[unchecked_address" in line:
            # give me the original instruction
            line = line.replace("_ADDRESS","_UNCHECKED_ADDRESS")
        elif "[video_address" in line:
            # give me the original instruction
            line = line.replace("_ADDRESS","_UNCHECKED_ADDRESS")
            # if it's a write, insert a "VIDEO_DIRTY" macro after the write
            for j in range(i+1,len(lines)):
                next_line = lines[j]

                if "[...]" not in next_line:
                    break
                if ",(a0)" in next_line or "clr" in next_line or "MOVE_W_FROM_REG" in next_line:
                    if any(x in next_line for x in ["address_word","MOVE_W_FROM_REG"]):
                        lines[j] = next_line+"\tVIDEO_WORD_DIRTY | [...]\n"

                    else:
                        lines[j] = next_line+"\tVIDEO_BYTE_DIRTY | [...]\n"


        ###############################################
        # game_specific

        if address != 0x8423 and "move,player_status_05,d0" in line and "OP_W_ON_DP_ADDRESS" in line:
            line = change_instruction("jbsr\tchange_player_status",lines,i)

        if address in {0x6451,0x69FC}:
            line = remove_instruction(lines,i)

        if address == 0x6226:
            # remove self-test code
            for j in range(i,len(lines)):
                if lines[j].startswith('l_63f2'):
                    break
                lines[j] = ""
            line = ""

        elif address == 0X6F10:
            line = """\tmove.b\tstart_level,d0
\tjeq\t0f
\tGET_ADDRESS\t0x50C1
\tmove.b\td0,(a0)+
\tmove.b\td0,(a0)
0:
"""
        elif address == 0x6865:
            line = change_instruction("jra\tl_686d",lines,i)
        elif address == 0x6867:
            line = remove_instruction(lines,i)

        if "review pshu instruction" in line:
            line = remove_error(line)

        # process target stack tags
        if "[target_stack_" in line:
            if "_alloc]" in line or "_free]" in line:
                lines[i-2] = remove_error(lines[i-2])
                lines[i-1] = remove_error(lines[i-1])
            elif "_store]" in line or "_load]" in line or "_set]" in line:
                lines[i-1] = remove_error(lines[i-1])
            elif "_push]" in line:
                # re-convert from scratch
                original = get_original_instruction(line)
                args = original.split()[1]
                # there are only 3 cases here: a,b,x/b
                comment = f"  | [${address:04x}: pshs {args}] [target_stack_push]"
                if args in ["a","b"]:
                    reg = "d0" if args=="a" else "d1"
                    to_add = f"""\tsubq\t#1,d5{comment}
\tGET_REG_ADDRESS    0,d5  | [...]
\tmove.b\t{reg},(a0)    | [...]
"""
                else:
                    # x/b
                    to_add = f"""\tsubq\t#3,d5{comment}
\tGET_REG_ADDRESS    0,d5    | [...]
\tmove.b\td1,(a0)+    | [...]
\trol.w\t#8,d2    | [...]
\tmove.b\td2,(a0)+    | [...]
\trol.w\t#8,d2     | [...]
\tmove.b\td2,(a0)     | [...]
"""
                line = to_add
            elif "_pull]" in line:
                # re-convert from scratch
                original = get_original_instruction(line)
                args = original.split()[1]
                # there are only 3 cases here: a,b,x/b
                # and we don't need to restore the values, those were for parameter passing
                comment = f"  | [${address:04x}: puls {args}] [target_stack_pull]"
                if args in ["a","b"]:
                    reg = "d0" if args=="a" else "d1"
                    to_add = f"""\taddq\t#1,d5{comment}
"""
                else:
                    # x/b
                    to_add = f"""\taddq\t#3,d5{comment}
"""
                line = to_add

        if "review stray bcc/bcs test" in line:
            # try to process in a generic way
            prev = lines[i-4]
            if any(x in prev for x in ("sub.","add.","abcd")):
                lines[i-4] += "\tPUSH_SR\n"
                lines[i-2] += "\tPOP_SR\n"
                line = remove_error(line)
        elif "instruction rti" in line:
            line = change_instruction("rts",lines,i)

        # correct BCD scoring
        elif address in [0X6732,0x6739]:
            line = "\tPUSH_SR\n"+line
        elif "addx mix" in line:
            line = "\tPOP_SR\n"
        elif address == 0x841A:
            line = f"""\ttst.b\tinvincible_flag
\tjne\tl_842c  | any height is OK
{line}
"""

        elif address == 0xAECD:
            line = f"""\ttst.b\tinvincible_flag
\tjne\t0f
# don't reset invincible state
{line}
0:
"""
        elif address == 0x7714:
            line = f"""\ttst.b\tinvincible_flag
\tjeq\t0f
\tGET_ADDRESS\tplayer_state_51c0
\tmove.b\t#2,(a0)  | invincible (egg power)
0:
{line}
"""
        elif address in [0x71fb,0x7230]:
            # fix video dirty manually, PSHU code is good but does d0,-(a0)
            # and we need a0 to be correct when we call dirty
            lines[i+2] = "\tsubq\t#1,a0\n\tmove.b\td0,(a0)\n\tVIDEO_BYTE_DIRTY\n"
        elif address  == 0x71f6:
            # fix video dirty manually, PSHU code is good but does d0,-(a0)
            # and we need a0 to be correct when we call dirty
            lines[i+4] = "\tsubq\t#1,a0\n\tmove.b\td1,(a0)\n\tVIDEO_BYTE_DIRTY\n"

        # end game_specific
        ###############################################
        if "GET_ADDRESS" in line:
            val = line.split()[1]
            osd_call = input_dict.get(val)
            if osd_call is not None:
                orig = get_original_instruction(line).split()[0]
                b_source = orig=="ldb"

                if osd_call:
                    line = change_instruction(f"jbsr\tosd_{osd_call}",lines,i)
                    if b_source:
                        line = f"\texg\td0,d1\n{line}\texg\td0,d1\n"
                else:
                    line = remove_instruction(lines,i)
                lines[i+1] = remove_instruction(lines,i+1)

        if "[global]" in line:
            label = line.split(":")[0]
            global_symbols.append(label)

        lines[i] = line

with open(source_dir / "data.inc","w") as fw:
    fw.writelines(equates)

with open(source_dir / f"{gamename}.68k","w") as fw:

    fw.write(f"""\t.include "data.inc"
""")
    for g in global_symbols:
        fw.write(f"\t.global\t{g}\n")

    fw.writelines(lines)
    fw.write("""
change_player_status:
\tcmp.b\t#2,d0
\tjne\t0f
\ttst.b\tinvincible_flag
\tjeq\t0f
\trts
0:
\tOP_W_ON_DP_ADDRESS\tmove,player_status_05,d0
\trts
""")