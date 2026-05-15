from PIL import Image,ImageOps
import os,sys,bitplanelib


from shared import *

# this was a heartbreak. After quantizing colors, reducing all kinds of stuff, trying
# selective dynamic mirroring, it didn't get the expected memory reduction
#
# the scrolling scheme isn't optimal. Should have used corkscrew to save some chip. Here it consumes 2 or 3 times
# as many memory because of archaic lateral scrolling + restore buffer (for ECS) + double buffering
#
# no problems at all with AGA thanks to 2MB chip and dual playfield, but in ECS we need a lot more memory,
# even in 16 colors
#
# the only consolation is that 16 color mode is probably much faster

AGA_MODE = 0
ECS_MODE = 1


dirs = ["aga","ecs","ocs"]

sprite_names = get_sprite_names()

# all sprites are currently mirrored. It doesn't help reducing chipmem
# to less than 1MB and it fits in 2MB so never mind
mirror_sprites = get_mirror_sprites()

# no need to insert current orientation flag. Dynamic mirror (OPT_ACTIVE_IN_PLACE_MIRROR)
# is not activated
dynamic_mirror = False

possible_hw_sprites = set() #get_possible_hw_sprites()

magenta = (254,0,254)

NB_SPRITES = 0x100
NB_TILES = 0x200


dump_it = True

if dump_it:
    if not os.path.exists(dump_dir):
        os.mkdir(dump_dir)
        with open(os.path.join(dump_dir,".gitignore"),"w") as f:
            f.write("*")


plane_orientations = [("standard",lambda x:x),
("flip",ImageOps.flip),
("mirror",ImageOps.mirror),
("flip_mirror",lambda x:ImageOps.flip(ImageOps.mirror(x)))]


def load_tileset(image_name,palette_index,width,height,tileset_name,dumpdir,
dump=False,name_dict=None,cluts=None,tile_number=0,is_bob=False):

##    if isinstance(image_name,str):
##        full_image_path = os.path.join(this_dir,os.path.pardir,"sheets",
##                            tile_type,image_name)
##        tiles_1 = Image.open(full_image_path)
##    else:
    tiles_1 = image_name
    nb_rows = tiles_1.size[1] // height
    nb_cols = tiles_1.size[0] // width


    tileset_1 = []

    if dump:
        dump_subdir = os.path.join(dumpdir,tileset_name)
        if palette_index == 0 and tile_number == 0:
            ensure_empty(dump_subdir)

    palette = set()

    for j in range(nb_rows):
        for i in range(nb_cols):

            if cluts is not None and (tile_number not in cluts or palette_index not in cluts[tile_number]):
                # no clut declared for that tile
                tileset_1.append(None)
            else:

                img = Image.new("RGB",(width,height))
                img.paste(tiles_1,(-i*width,-j*height))
                if is_bob:
                    img = ImageOps.flip(img)

                # only consider colors of used tiles
                palette.update(set(bitplanelib.palette_extract(img)))


                tileset_1.append(img)
                # dump tiles
                if not is_bob and dump:
                    img = ImageOps.scale(img,5,resample=Image.Resampling.NEAREST)
                    if name_dict:
                        name = name_dict.get(tile_number,"unknown")
                    else:
                        name = "unknown"

                    img.save(os.path.join(dump_subdir,f"{name}_{tile_number:02x}_{palette_index:02x}.png"))
            tile_number += 1


    if is_bob:
        # rework & dump grouped / non grouped sprites
        # rework tiles which are grouped
        for tile_number,wtile in enumerate(tileset_1):

            if dump_it and wtile:
                img = ImageOps.scale(wtile,5,resample=Image.Resampling.NEAREST)
                if sprite_names:
                    name = sprite_names.get(tile_number,"unknown")
                else:
                    name = "unknown"

                img.save(os.path.join(dump_subdir,f"{name}_{tile_number:02x}_{palette_index:02x}.png"))


    return sorted(set(palette)),tileset_1,False

def add_hw_sprite(index,name,cluts=[0]):
    if isinstance(index,range):
        pass
    elif not isinstance(index,(list,tuple)):
        index = [index]
    for idx in index:
        sprite_names[idx] = name
        hw_sprite_cluts[idx] = cluts

def read_tileset(img_set_list,palette,plane_orientation_flags,cache,is_bob,nb_planes):
    next_cache_id = 1
    tile_table = []
    for n,img_set in enumerate(img_set_list):
        tile_entry = []
        for i,tile in enumerate(img_set):
            entry = dict()
            if tile:

                for b,(plane_name,plane_func) in zip(plane_orientation_flags,plane_orientations):
                    if b:

                        bitplane_sprite_data = None
                        actual_nb_planes = nb_planes
                        bitplane_data = None

                        wtile = plane_func(tile)

                        if is_bob:
                            if plane_name=="standard" or i in mirror_sprites:
                                actual_nb_planes += 1

                                # only 4 planes + mask => 5 planes
                                orig_wtile = wtile
                                y_start,wtile = bitplanelib.autocrop_y(wtile,mask_color=magenta)
                                height = wtile.size[1]
                                width = wtile.size[0]//8 + 2
                                bitplane_data = bitplanelib.palette_image2raw(wtile,None,palette,generate_mask=True,mask_color=magenta)
                                if i in possible_hw_sprites:
                                    # using original, uncropped bitplane data to create 16x16 or 16x32 hw sprite
                                    bitplane_sprite_data = bitplanelib.palette_image2attached_sprites(orig_wtile,None,palette,with_control_words=True)
                        else:
                            # 4 planes, no mask
                            height = 8
                            width = 1
                            y_start = 0
                            bitplane_data = bitplanelib.palette_image2raw(wtile,None,palette)

                        if bitplane_data:
                            plane_size = len(bitplane_data) // actual_nb_planes
                            bitplane_plane_ids = []
                            for j in range(actual_nb_planes):
                                offset = j*plane_size
                                bitplane = bitplane_data[offset:offset+plane_size]

                                cache_id = cache.get(bitplane)
                                if cache_id is not None:
                                    bitplane_plane_ids.append(cache_id)
                                else:
                                    if any(bitplane):
                                        cache[bitplane] = next_cache_id
                                        bitplane_plane_ids.append(next_cache_id)
                                        next_cache_id += 1
                                    else:
                                        bitplane_plane_ids.append(0)  # blank
                            entry[plane_name] = {"width":width,"height":height,"y_start":y_start,"bitplanes":bitplane_plane_ids}
                        if bitplane_sprite_data:
                            entry[plane_name]["sprdat"] = bitplane_sprite_data

            tile_entry.append(entry)

        tile_table.append(tile_entry)

    new_tile_table = [[[] for _ in range(NB_SPRITE_CLUTS if is_bob else NB_TILE_CLUTS)] for _ in range(len(tile_table[0]))]

    # reorder/transpose. We have 16 * 256 we need 256 * 16
    for i,u in enumerate(tile_table):
        for j,v in enumerate(u):
            new_tile_table[j][i] = v

    return new_tile_table


def doit(mode):
    nb_colors = 16

    xxx_src_dir = src_dir / dirs[mode]


    sprite_cluts = {}
    tile_cluts = {}

    try:
        with open(used_graphics_dir / "used_sprites","rb") as f:
            for index in range(NB_SPRITES):
                d = f.read(NB_SPRITE_CLUTS)
                cluts = [i for i,c in enumerate(d) if c]
                if cluts:
                    add_tile(sprite_cluts,index,cluts=cluts)
    except OSError:
        print("Cannot find used_sprites")



    try:
        with open(used_graphics_dir / "used_tiles","rb") as f:
            for index in range(NB_TILES):
                d = f.read(NB_TILE_CLUTS)
                cluts = [i for i,c in enumerate(d) if c]
                if cluts:
                    add_tile(tile_cluts,index,cluts=cluts)
    except OSError:
        pass

    # now gather all cluts used by letter/digit tiles, logging probably
    # missed some
    ##used_cluts = set()
    ##for atc in alphanum_tile_codes:
    ##    cluts = tile_cluts.get(atc)
    ##    if cluts:
    ##        used_cluts.update(cluts)
    ### now set cluts for all alphanum tiles
    ##for atc in alphanum_tile_codes:
    ##    tile_cluts[atc] = sorted(used_cluts)





    if dump_it:
        with open(dump_dir / "used_sprites.json","w") as f:
            sprite_cluts_dict = {hex(k):[hex(x) for x in v] for k,v in sprite_cluts.items() if v}
            json.dump(sprite_cluts_dict,f,indent=2)
        with open(dump_dir / "used_tiles.json","w") as f:
            tile_cluts_dict = {hex(k):[hex(x) for x in v] for k,v in tile_cluts.items() if v}
            json.dump(tile_cluts_dict,f,indent=2)



    sprite_sheet_dict = {i:Image.open(sheets_path / "sprites" / f"pal_{i:02x}.png") for i in range(16)}
    tile_sheet_dict = {i:Image.open(sheets_path / "tiles" / f"pal_{i:02x}.png") for i in range(16)}

    tile_palette = set()
    tile_set_list = []

    for i,tsd in tile_sheet_dict.items():
        tp,tile_set,_ = load_tileset(tsd,i,8,8,"tiles",dump_dir,dump=dump_it,
        cluts=tile_cluts,
        name_dict=None)
        tile_set_list.append(tile_set)
        tile_palette.update(tp)

    # pad
    tile_palette = sorted(tile_palette)
    print(f"Used tile colors: {len(tile_palette)}")

    tile_palette += (16-len(tile_palette)) * [(0x10,0x20,0x30)]

    sprite_palette = {magenta}
    sprite_set_list = [[] for _ in range(NB_SPRITE_CLUTS)]
    hw_sprite_set_list = []

    sprite_dump_dir = dump_dir / "sprites"

    for p in sprite_dump_dir.glob("*"):
        p.unlink()
    sprite_dump_dir.mkdir(exist_ok=True)

    cluts = sprite_cluts

    global_other_tile_failure = False
    for clut_index,tsd in sprite_sheet_dict.items():
        # BOBs

        sp,sprite_set,other_tile_failure = load_tileset(tsd,clut_index,16,16,"sprites",dump_dir,dump=dump_it,
        name_dict=sprite_names,cluts=sprite_cluts,is_bob=True)
        sprite_set_list[clut_index] = sprite_set
        sprite_palette.update(sp)
        global_other_tile_failure |= other_tile_failure

    if global_other_tile_failure:
        raise Exception("Some associated tiles weren't found")


    sprite_palette = sorted(sprite_palette)
    magi = sprite_palette.index(magenta)
    sprite_palette.pop(magi)
    # temporary: put magenta as first color to be able to decode the frames properly
    sprite_palette.insert(0,magenta)

    print(f"Used sprite colors: {len(sprite_palette)}")
    sprite_palette += (16-len(sprite_palette)) * [(0x10,0x20,0x30)]

    # sprite_set_list is now a 16x512 matrix of sprite tiles

        # Hardware sprites
    ##    cluts = hw_sprite_cluts
    ##    _,hw_sprite_set = load_tileset(tsd,i,16,"hw_sprites",dump_dir,dump=dump_it,name_dict=sprite_names,cluts=cluts)
    ##    hw_sprite_set_list.append(hw_sprite_set)


    full_palette = tile_palette+sprite_palette

    if mode == ECS_MODE:
        # merge
        full_palette = sorted(set(full_palette))
        nb_raw_colors = len(full_palette)
        if nb_raw_colors > nb_colors:
            print(f"too many colors {nb_raw_colors} for {nb_colors}, quantizing")
            full_list = sprite_set_list+tile_set_list
            # first, manual merge of colors, else automatic quantize makes a horrible result
            maroon = (153,85,34)
            manual_replacement_dict = {
            #(0,17,0):(0,0,51),
            #(17,0,17):(0,0,51)
            }

            # manual pre-processing to merge colors manually
            apply_color_replacement(full_list,manual_replacement_dict)
            # then quantize
            full_palette = quantize_image_sets(full_list,nb_colors,"sprites",remove_color=magenta,dump_it=True)

    #full_palette_rgb4 = {(x>>4,y>>4,z>>4) for x,y,z in full_palette}
    #actually_used_colors_rgb4 = {(x>>4,y>>4,z>>4) for x,y,z in actually_used_colors}
    #unused_colors = full_palette_rgb4 - actually_used_colors_rgb4
    #print([(hex(x<<4),hex(y<<4),hex(z<<4)) for x,y,z in unused_colors])

    # pad just in case we don't have 16+16 colors (but we have)
    full_palette += (nb_colors-len(full_palette)) * [(0x10,0x20,0x30)]



    tile_plane_cache = {}
    # 16 first colors, or 16 full colors (for OCS)
    tile_table = read_tileset(tile_set_list,full_palette[:16],[True,False,False,False],cache=tile_plane_cache, is_bob=False, nb_planes=4)

    bob_plane_cache = {}

    if mode == AGA_MODE:
        # 16 last colors!
        sprite_table = read_tileset(sprite_set_list,full_palette[16:],[True,False,True,False],cache=bob_plane_cache, is_bob=True, nb_planes=4)
    else:
        # ECS/OCS have only 1 palette
        sprite_table = read_tileset(sprite_set_list,full_palette,[True,False,True,False],cache=bob_plane_cache, is_bob=True, nb_planes=5 if mode==ECS_MODE else 4)


    if mode != ECS_MODE:
        # now that the sprites were decoded, put black as first color too (else for some priority reason
        # the background is magenta or whatever the color is)
        full_palette[16] = (0,0,0)

    palette_file = xxx_src_dir / "palette.68k"
    print(f"Creating {palette_file}")
    with palette_file.open("w") as f:
        bitplanelib.palette_dump(full_palette,f,bitplanelib.PALETTE_FORMAT_ASMGNU)




    with (xxx_src_dir / "graphics.68k").open("w") as f:
        f.write("\t.global\tcharacter_table\n")
        f.write("\t.global\thws_table\n")
        f.write("\t.global\tbob_table\n")

        f.write("character_table:\n")

        for i,tile_entry in enumerate(tile_table):
            f.write("\t.long\t")
            if tile_entry and any(tile_entry):
                f.write(f"tile_{i:02x}")
            else:
                f.write("0")
            f.write("\n")

        for i,tile_entry in enumerate(tile_table):
            if tile_entry and any(tile_entry):
                f.write(f"tile_{i:02x}:\n")
                for j,t in enumerate(tile_entry):
                    f.write("\t.long\t")
                    if t:
                        f.write(f"tile_{i:02x}_{j:02x}")
                    else:
                        f.write("0")
                    f.write("\n")


        for i,tile_entry in enumerate(tile_table):
            if tile_entry and any(tile_entry):
                for j,t in enumerate(tile_entry):
                    if t:
                        name = f"tile_{i:02x}_{j:02x}"

                        f.write(f"{name}:\n")
                        for orientation,_ in plane_orientations:
                            f.write("* orientation={}\n".format(orientation))
                            if orientation in t:
                                data = t[orientation]
                                for bitplane_id in data["bitplanes"]:
                                    f.write("\t.long\t")
                                    if bitplane_id:
                                        f.write(f"tile_plane_{bitplane_id:02d}")
                                    else:
                                        f.write("0")
                                    f.write("\n")
                                if len(t)==1:
                                    # optim: only standard
                                    break
                            else:
                                for _ in range(nb_planes):
                                    f.write("\t.long\t0\n")



        for k,v in tile_plane_cache.items():
            f.write(f"tile_plane_{v:02d}:")
            dump_asm_bytes(k,f)

        f.write("bob_table:\n")
        for i,tile_entry in enumerate(sprite_table):
            f.write("\t.long\t")
            if any(tile_entry):
                prefix = sprite_names.get(i,"bob")
                f.write(f"{prefix}_{i:02x}")
            else:
                f.write("0")
            f.write("\n")

        for i,tile_entry in enumerate(sprite_table):
            if any(tile_entry):
                prefix = sprite_names.get(i,"bob")
                f.write(f"{prefix}_{i:02x}:\n")
                for j,t in enumerate(tile_entry):
                    f.write("\t.long\t")
                    if t:
                        f.write(f"{prefix}_{i:02x}_{j:02x}")
                    else:
                        f.write("0")
                    f.write("\n")


        for i,tile_entry in enumerate(sprite_table):
            if tile_entry:
                prefix = sprite_names.get(i,"bob")
                for j,t in enumerate(tile_entry):
                    if t:
                        name = f"{prefix}_{i:02x}_{j:02x}"

                        f.write(f"{name}:\n")
                        height = 0

                        offset = 0
                        for orientation,_ in plane_orientations:
                            if orientation in t:
                                width = t[orientation]["width"]
                                height = t[orientation]["height"]
                                offset = t[orientation]["y_start"]
                                break
                        else:
                            raise Exception(f"height not found for {name}!!")

                        active_planes = 0
                        for j,bitplane_id in enumerate(t["standard"]["bitplanes"]):
                            if bitplane_id:
                                active_planes |= 1<<j

                        for orientation in ["standard","mirror"]:
                            if (orientation == "standard" or i in mirror_sprites):
                                f.write("* orientation={}\n".format(orientation))
                                f.write(f"\t.word\t{height},{width},{offset},0x{active_planes:x}\n")
                                bitplanes = t[orientation]["bitplanes"]

                                for bitplane_id in bitplanes:
                                    f.write("\t.long\t")
                                    if bitplane_id:
                                        f.write(f"bob_plane_{bitplane_id:02d}")
                                    else:
                                        f.write("0")
                                    f.write("\n")
                            elif orientation == "mirror":
                                f.write(f"\t.word\t-1  | no mirror declared\n")


        f.write("hws_table:\n")
        for i,tile_entry in enumerate(sprite_table):
            for orientation in ['standard','mirror']:
                f.write("\t.long\t")
                if any(t and "sprdat" in t.get(orientation,[]) for t in tile_entry):
                    prefix = sprite_names.get(i,"bob")
                    prefix = f"hws_{prefix}_{i:02x}_{orientation}"
                    f.write(prefix)
                else:
                    f.write("0")
                f.write("\n")

        # HW sprites clut declaration
        for i,tile_entry in enumerate(sprite_table):
            for orientation in ['standard','mirror']:
                if any(t and "sprdat" in t.get(orientation,[]) for t in tile_entry):
                    prefix = sprite_names.get(i,"bob")
                    f.write(f"hws_{prefix}_{i:02x}_{orientation}:\n")
                    for j,t in enumerate(tile_entry):
                        f.write("\t.long\t")
                        if t:
                            z = f"hws_{prefix}_{i:02x}_{j:02x}_{orientation}"
                            f.write(f"{z}_0,{z}_1")
                        else:
                            f.write("0,0")
                        f.write("\n")
        f.write("\n\t.section\t.datachip\n")

        for k,v in bob_plane_cache.items():
            if dynamic_mirror:
                # not needed if all sprites are mirrored
                f.write(f"\n\t.word\t0   | orientation flag (for in-place mirroring)\n")
            f.write(f"bob_plane_{v:02d}:")
            dump_asm_bytes(k,f)

        if possible_hw_sprites:
            for i,tile_entry in enumerate(sprite_table):
                for orientation in ['standard','mirror']:
                    if any(t and "sprdat" in t[orientation] for t in tile_entry):
                        prefix = sprite_names.get(i,"bob")
                        for j,t in enumerate(tile_entry):

                            if t:
                                data = t[orientation]["sprdat"]
                                for k,d in enumerate(data):
                                    f.write(f"hws_{prefix}_{i:02x}_{j:02x}_{orientation}_{k}:")
                                    bitplanelib.dump_asm_bytes(d,f,mit_format=True)
                                f.write("\n")

doit(mode=AGA_MODE)
#doit(mode=ECS_MODE)
