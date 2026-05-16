import subprocess,os,struct,glob,tempfile
import shutil

from shared import *

gamename = "rocnrope"
sox = "sox"

sound_dir = this_dir / ".." / "sounds"

def convert(ocs):
    if not shutil.which("sox"):
        raise Exception("sox command not in path, please install it")
    # BTW convert wav to mp3: ffmpeg -i input.wav -codec:a libmp3lame -b:a 330k output.mp3

    out_dir = src_dir
    suffix = "_ocs" if ocs else ""

    outfile = os.path.join(out_dir,f"sounds{suffix}.68k")
    sndfile = os.path.join(out_dir,f"sound_entries{suffix}.68k")

    if ocs:
        hq_sample_rate = 8000
        lq_sample_rate = 6000
    else:
        hq_sample_rate = 16000
        lq_sample_rate = 10000


    sound_settings_dict = {
    #1 : {"channel":3,"priority":1,"sample_rate":lq_sample_rate}


}

    loop_channel = 2

    EMPTY_SND = "EMPTY_SND"
    dummy_sounds = [0,0x1E,
    0x1F,
    0x1D,0x1C,0x1B,0x1A,0x19,  # music indicators
    0x20,  # level 1
    0x21,  # level 2
    0x22,  # level 3
    0x23,  # level 4
    0x24,  # superpower
    0x2A,  # dead?
    0x2B, # ???
    0x27, # end of level?
    0x28, # level 4 complete
    0x29, # game over
    ]  # ATM no music



    sound_dict = {}
    sfx_list = set()
    # scan directory for speech
    for f in sound_dir.glob("*.wav"):
        sound_name = f.stem
        parts = sound_name.rsplit("_",maxsplit=1)
        if len(parts)>1:
            try:
                index = int(parts[1],16) - 0xD  # like MAME sound test
                if index not in dummy_sounds:
                    sfx_list.add(index)
                    # auto-declare according to name suffix
                    entry = f"{sound_name}_SND"
                    # fix channel to avoid overlap
                    extra_info = sound_settings_dict.get(index) or dict()

                    sfx_sample_rate = extra_info.get("sample_rate",lq_sample_rate if index>0x7F else hq_sample_rate)
                    sound_dict[entry] = {"channel":extra_info.get("channel",-1),
                    "priority":extra_info.get("priority",40),"index":index,"sample_rate":sfx_sample_rate}
            except ValueError:
                pass



    for v in sound_dict.values():
        if "channel" not in v:
            v["channel"] = 3

    music_volume = 20

##    sound_dict.update({
##    "LEVEL_COMPLETED_SND"      :{"index":0x40,"pattern":0x4,"volume":music_volume},
##    "LEVEL_START_SND"      :{"index":0x44,"pattern":0x1,"volume":music_volume},
##    "GAME_OVER_SND"      :{"index":0x45,"pattern":0x3,"volume":music_volume},
##    "INTRO_SND"      :{"index":0x43,"pattern":0x0,"volume":music_volume},
##    "GAME_COMPLETED_SND"      :{"index":0x41,"pattern":0x5,"volume":music_volume},
##    "HIGH_SCORE_SND"      :{"index":0x42,"pattern":0x9,"volume":music_volume},
##
##})


    with open(os.path.join(src_dir,"..",f"sounds{suffix}.inc"),"w") as f:
        for k,v in sorted(sound_dict.items(),key = lambda x:x[1]["index"]):
            f.write(f"\t.equ\t{k.upper()},  0x{v['index']:x}\n")

    max_sound = 0x40  # max(x["index"] for x in sound_dict.values())+1
    sound_table = [""]*max_sound
    sound_table_set_1 = ["\t.long\t0,0"]*max_sound

    for d in dummy_sounds:
        sound_table_set_1[d] = "\t.word\t3,0,0,0   | valid but muted"



    snd_header = rf"""
    # sound tables
    #
    # the "sound_table" table has 8 bytes per entry
    # first word: 0: no entry, 1: sample, 2: pattern from music module
    # second word: 0 except for music module: pattern number
    # longword: sample data pointer if sample, 0 if no entry and
    # 2 words: 0/1 noloop/loop followed by duration in ticks
    #
    # SOUND_ENTRY macro defines a ptplayer-compatible structure, with added the number
    # of ticks (PAL) giving the duration of the sample (offset 0xA)
    FXFREQBASE = 3579564

        .macro    SOUND_ENTRY    sound_name,size,channel,soundfreq,volume,priority,ticks
    \sound_name\()_sound:
        .long    \sound_name\()_raw
        .word   \size
        .word   FXFREQBASE/\soundfreq,\volume
        .byte    \channel
        .byte    \priority
        .word    \ticks
        .endm

    """

    def write_asm(contents,fw):
        n=0
        for c in contents:
            if n%16 == 0:
                fw.write("\n\t.byte\t0x{:x}".format(c))
            else:
                fw.write(",0x{:x}".format(c))
            n += 1
        fw.write("\n")

    music_module_label = f"{gamename}_tunes"

    raw_file = os.path.join(tempfile.gettempdir(),"out.raw")
    with open(sndfile,"w") as fst,open(outfile,"w") as fw:
        fst.write(snd_header)

        fw.write("\t.section\t.datachip\n")
        fw.write("\t.global\t{}\n".format(music_module_label))

        for wav_file,details in sound_dict.items():
            wav_name = os.path.basename(wav_file).lower()[:-4]
            if details.get("channel") is not None:
                fw.write("\t.global\t{}_raw\n".format(wav_name))


        for wav_entry,details in sound_dict.items():
            sound_index = details["index"]

            channel = details.get("channel")
            if channel is None:

                same_as = details.get("same_as")
                if same_as is None:
                    # if music loops, ticks are set to 1 so sound orders only can happen once (else music is started 50 times per second!!)

                    sound_table_set_1[sound_index] = "\t.word\t{},{},{}\n\t.byte\t{},{}".format(2,details["pattern"],0,details["volume"],int(details.get("loops",0)))
                else:
                    # aliased sound: reuse sample for a different sound index
                    wav_entry = same_as
                    details = sound_dict[same_as]
                    wav_name = os.path.basename(wav_entry).lower()[:-4]
                    wav = os.path.splitext(wav_name)[0]
                    sound_table_set_1[sound_index] = f"\t.word\t1,{int(details.get('loops',0))}\n\t.long\t{wav}_sound"
            else:
                wav_name = os.path.basename(wav_entry).lower()[:-4]
                wav_file = os.path.join(sound_dir,wav_name+".wav")

                def get_sox_cmd(sr,output):
                    return [sox,"--volume","2.5",wav_file,"--channels","1","-D","--bits","8","-r",str(sr),"--encoding","signed-integer",output]

                used_sampling_rate = details["sample_rate"]
                used_priority = details.get("priority",1)

                cmd = get_sox_cmd(used_sampling_rate,raw_file)

                subprocess.check_call(cmd)
                with open(raw_file,"rb") as f:
                    contents = f.read()

                # compute max amplitude so we can feed the sound chip with an amped sound sample
                # and reduce the replay volume. this gives better sound quality than replaying at max volume
                # (thanks no9 for the tip!)
                signed_data = [x if x < 128 else x-256 for x in contents]
                maxsigned = max(signed_data)
                minsigned = min(signed_data)

                amp_ratio = max(maxsigned,abs(minsigned))/32


                print(f"amp_ratio: {amp_ratio}")

                wav = os.path.splitext(wav_name)[0]
                if amp_ratio > 1:
                    print(f"{wav}: volume peaked {amp_ratio}")
                    amp_ratio = 1
                ticks = details.get("ticks")
                if not ticks:
                    ticks = int(len(signed_data)/used_sampling_rate*170)+1  # inflate time (else speech is too fast)
                sound_table[sound_index] = "    SOUND_ENTRY {},{},{},{},{},{},{}\n".format(wav,len(signed_data)//2,channel,
                            used_sampling_rate,int(64*amp_ratio),used_priority,ticks)
                sound_table_set_1[sound_index] = f"\t.word\t1,{int(details.get('loops',0))}\n\t.long\t{wav}_sound"

                if amp_ratio > 0:
                    maxed_contents = [int(x/amp_ratio) for x in signed_data]
                else:
                    maxed_contents = signed_data



                signed_contents = bytes([x if x >= 0 else 256+x for x in maxed_contents])
                # pre-pad with 0W, used by ptplayer for idling
                if signed_contents[0] != b'\x00' and signed_contents[1] != b'\x00':
                    # add zeroes
                    signed_contents = struct.pack(">H",0) + signed_contents

                contents = signed_contents
                # align on 16-bit
                if len(contents)%2:
                    contents += b'\x00'
                # pre-pad with 0W, used by ptplayer for idling
                if contents[0] != b'\x00' and contents[1] != b'\x00':
                    # add zeroes
                    contents = b'\x00\x00' + contents

                fw.write("{}_raw:   | {} bytes".format(wav,len(contents)))

                if len(contents)>65530:
                    raise Exception(f"Sound {wav_entry} is too long")
                write_asm(contents,fw)


        contents = bytes()
        # make sure next section will be aligned
        #with open(os.path.join(sound_dir,f"{gamename}_conv.mod"),"rb") as f:
        #    contents = f.read()

        fw.write("{}:".format(music_module_label))
        write_asm(contents,fw)
        fw.write("\t.align\t8\n")


        fst.writelines(sound_table)
        fst.write("\n\t.global\t{0}\n\n{0}:\n".format("sound_table"))
        for i,st in enumerate(sound_table_set_1):
            fst.write(st)
            fst.write(" | {}\n".format(i))


convert(ocs=False)
#convert(ocs=True)



