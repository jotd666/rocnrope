from PIL import Image,ImageOps
import os,sys,bitplanelib,subprocess,json,pathlib

this_dir = pathlib.Path(__file__).absolute().parent

data_dir = this_dir / ".." / ".."
src_dir = this_dir / ".." / ".." / "src" / "amiga"


sheets_path = this_dir / ".." / "sheets"
dump_dir = this_dir / "dumps"

used_sprite_cluts_file = this_dir / "used_sprite_cluts.json"
used_tile_cluts_file = this_dir / "used_tile_cluts.json"
used_graphics_dir = this_dir / "used_graphics"

NB_SPRITE_CLUTS = 16
NB_TILE_CLUTS = 16

def apply_color_replacement(sprite_set_list,quantized):
    """ change colors for list of tilesets (tiles, sprites)
    quantized: RGB => RGB color replacement dictionary
    """

    for sset in sprite_set_list:
        for tile in sset:
            if tile:
                bitplanelib.replace_color_from_dict(tile,quantized)

def quantize_palette(rgb_tuples,img_type,nb_quantize,transparent=None,dump_it=False):
    rgb_configs = set(rgb_tuples)

    nb_target_colors = nb_quantize
    if transparent:
        rgb_configs.remove(transparent)
        # remove black, white, we don't want it quantized
        immutable_colors = (transparent,(0,0,0))
    else:
        immutable_colors = ((0,0,0),)

    for c in immutable_colors:
        rgb_configs.discard(c)
        nb_quantize -= 1

    dump_graphics = False
    # now compose an image with the colors
    clut_img = Image.new("RGB",(len(rgb_configs),1))
    for i,rgb in enumerate(rgb_configs):
        #rgb_value = (rgb[0]<<16)+(rgb[1]<<8)+rgb[2]
        clut_img.putpixel((i,0),rgb)

    reduced_colors_clut_img = clut_img.quantize(colors=nb_quantize,dither=0).convert('RGB')

    # get the reduced palette
    reduced_palette = [reduced_colors_clut_img.getpixel((i,0)) for i,_ in enumerate(rgb_configs)]
    # apply rounding now, else possible color duplicates, which would be a pity
    reduced_palette = bitplanelib.palette_round(reduced_palette,0xF0)

    unique_reduced_img = Image.new("RGB",(len(rgb_configs),1))
    for i,rgb in enumerate(sorted(set(reduced_palette))):
        unique_reduced_img.putpixel((i,0),rgb)


    # now create a dictionary by associating the original & reduced colors
    rval = dict(zip(rgb_configs,reduced_palette))

    # add black & white & transparent back
    for c in immutable_colors:
        rval[c] = c


    if dump_it:  # debug it, create 2 rows, 1 non-quantized, and 1 quantized, separated by bloack
        s = clut_img.size
        ns = (s[0]*30,s[1]*30)
        clut_img = clut_img.resize(ns,resample=0)
        unique_reduced_img = unique_reduced_img.resize(ns,resample=0)
        whole_image = Image.new("RGB",(clut_img.size[0],clut_img.size[1]*5))
        whole_image.paste(clut_img,(0,0))
        reduced_colors_clut_img = reduced_colors_clut_img.resize(ns,resample=0)
        whole_image.paste(reduced_colors_clut_img,(0,clut_img.size[1]*2))
        whole_image.paste(unique_reduced_img,(0,clut_img.size[1]*4))

        whole_image.convert("P",dither=0).save(dump_dir / "{}_colors.png".format(img_type))

    result_nb = len(set(reduced_palette))
    if nb_quantize < result_nb:
        raise Exception(f"quantize: {img_type}: {nb_quantize} expected, found {result_nb}")
    # return it
    return rval



def quantize_image_sets(sprite_set_list,max_used_nb_colors,image_type="image",remove_color=None,dump_it=False):

    pixels = []
    # temp extract palette
    sprite_palette = set()
    for imglist in sprite_set_list:
        for img in imglist:
            if img:
                sprite_palette.update(img.getdata())
                pixels += list(img.getdata())  # collect all pixels, not just the palette

    if remove_color:
        sprite_palette.remove(remove_color)
        pixels = [p for p in pixels if p != remove_color]

    if len(sprite_palette)>max_used_nb_colors:
        print(f"Too many colors in {image_type} tiles ({len(sprite_palette)}), quantizing")
        # if we specify 32 right away, the algorithm can provide less colors than 32, wasting entries
        # by attempting to quantize with higher values, we guarantee not to waste colors
        for overshoot in reversed(range(5)):
            attempt_nb_colors = max_used_nb_colors+overshoot
            sprite_replacement_dict = quantize_palette(set(pixels),image_type,attempt_nb_colors,dump_it=dump_it)
            new_sprite_palette = sorted(set(sprite_replacement_dict.values()))
            if len(new_sprite_palette)<=max_used_nb_colors:
                print(f"Quantization achieved {len(new_sprite_palette)} colors with start colors = {attempt_nb_colors}")
                sprite_palette = new_sprite_palette
                break
        else:
            raise Exception("quantize error")  # not really possible since we try 32 as last chance!

        apply_color_replacement(sprite_set_list,sprite_replacement_dict)

    return sorted(sprite_palette)

def get_possible_hw_sprites():
    return {0x100,0x14D}  # bullets

def palette_pad(palette,pad_nb):
    palette += (pad_nb-len(palette)) * [(0x10,0x20,0x30)]

def ensure_empty(d):
    if os.path.exists(d):
        for f in os.listdir(d):
            x = os.path.join(d,f)
            if os.path.isfile(x):
                os.remove(x)
    else:
        os.makedirs(d)

def ensure_exists(d):
    if os.path.exists(d):
        pass
    else:
        os.makedirs(d)

sr2 = lambda a,b : set(range(a,b,2))

player_sprite_pairs = ()
player_single_sprites = {}

group_sprite_pairs = (
sr2(0x1F0,0x200) | sr2(0x1A0,0x1B0) | sr2(0x1BA,0x1C0) | sr2(0x170,0x17A) |
{0x16C,0x7D,0x14E,0xCE,0X136,0x18D,0x19A,0x26,0x1EC,0x19C,0x1C0,0x11D,0X1C4,0x1EA,0x1B8,0xE8,0xE2,0x1E4,0x1D5,0x1E0,0x1E2,0x164,0x1DD,0x19E,0X41,0x44,0x34,0x30,0X17C,0x75,0x77,
0x46,0x60,0x62,0X4A,0x4C,0X1D8,0x54,0x56,0x1C8,0x1CA,0X1D0,0xD8,0x126,0X183,0x156,0x17A,0x17E,0x122,0x124,0x193} |
sr2(0x1B0,0x1B8)
)

#result = sorted({"0x"+x.split("_")[1] for x in os.listdir(r"K:\jff\AmigaHD\PROJETS\arcade_remakes\jail_break\assets\amiga\dumps\sprites\unknown\convict")})
#print(str(result).replace("'",""))

more_police = [0x136,0x154,0xf6,0xf7,0xfe,0xff,0x20,
0x21,0x22,0x2a,0x2b,0x2c,0x2d,0x38,0x4b,0x4d,0x4f,
0x50,0x52,0x53,0x53,0x55,0x58,0x59,0x5a,0x5b,0x5c,0x5d,
0x5e,0x5f,0x60,0x62,0x63,0x64,0x65,0x66,0x67,
0x68,0x69,0x76]
more_convict = [0x129, 0x12b, 0x12d, 0x1d5, 0x1df, 0x1ec, 0x1ee, 0x1ef, 0xef, 0xf0, 0xf1, 0xf2, 0xf8, 0xf9, 0xfa]

worker = [0x153,0x162,0x163,0x168,0x169,0xFC]

def set_names(rval,start,end,name):
    rval.update({i:name for i in range(start,end)})

def get_sprite_names():

    rval = dict()
    set_names(rval,0x188,0x197,"police_car")
    set_names(rval,0x1D0,0x1D4,"police_van")
    set_names(rval,0x1C3,0x1C4,"police_van")
    set_names(rval,0x182,0X185,"police_van")
    set_names(rval,0x18A,0X18D,"police_van")
    set_names(rval,0x1F0,0x200,"police_car")
    set_names(rval,0x140,0x145,"woman_and_baby")
    set_names(rval,0x148,0x14A,"woman_and_baby")
    set_names(rval,0xF4,0xF6,"killed_worker")

    rval[0x4E] = "rpg"
    rval[0x32] = "policeman"
    rval[0x3F] = "blank"
    rval[0x155] = "blank"
    rval[0x3A] = "police_car"
    rval[0x3B] = "police_car"
    rval[0x180] = "police_car"
    rval[0x100] = "bullet"
    rval[0x14d] = "bullet"
    rval.update({i:"policeman" for i in more_police})
    rval.update({i:"convict" for i in more_convict})
    rval.update({i:"worker" for i in worker})
    set_names(rval,0x101,0x103,"molotov")

    rval[0x10B] = "shell"
    rval[0x10C] = "shell"
    rval[0x126] = "dead_convict"
    rval[0x12A] = "dead_convict"
    rval[0x12C] = "dead_convict"
    set_names(rval,0x41,0x48,"biker")

    rval[0x1C6] = "barrel"
    rval[0x138] = "grenade"
    rval[0x139] = "grenade"
    rval[0x13a] = "grenade"
    rval[0x15f] = "score"
    rval[0x131] = "score"
    rval[0x12E] = "score"
    rval[0x12F] = "score"
    rval[0x4A] = "policeman_rpg"
    rval[0x4C] = "policeman_rpg"
    rval[0x51] = "policeman_rpg"
    rval[0x75] = "policeman_rpg"
    rval[0x77] = "policeman_rpg"
    rval[0x54] = "policeman_rpg"
    rval[0x56] = "policeman_rpg"

    rval[0x181] = "police_car"
    rval[0x1C8] = "garbage_truck"
    rval[0x1CA] = "garbage_truck"
    set_names(rval,0,0x20,"policeman")
    set_names(rval,0x158,0x15F,"policeman")
    set_names(rval,0x78,0x80,"policeman")
    set_names(rval,0x6A,0x73,"policeman")
    set_names(rval,0x23,0x2A,"policeman")
    set_names(rval,0x1A0,0x1B8,"manhole_cover")
    set_names(rval,0x1B8,0x1C0,"convict_in_manhole")
    set_names(rval,0X122,0x125,"policeman")
    set_names(rval,0x80,0xEB,"convict")
    set_names(rval,0xEB,0xEF,"prisoner")
    set_names(rval,0x1A8,0x1B0,"convict")
    set_names(rval,0x16E,0x170,"child")
    set_names(rval,0x160,0x162,"worker")
    set_names(rval,0x150,0x153,"worker")


    return rval

def mirror_name(i,n):
    # default: all are mirrored, unless obvious non-mirrored to save a few bytes
    if any(x in n for x in ["biker","garbage","barrel","police_car","police_van","score"]):
        return False
    return True

##    if any(x in n for x in ["blank"]):
##        return True
##    if i in [0x11a]:
##        return True
##    return False

def get_mirror_sprites():
    """ return the index of the sprites that need mirroring
"""
    #return set(range(0x200))
    sprite_names = get_sprite_names()
    # TODO: tag all unknown to be able to filter with "mirror_name"
    rval = {i for i,n in sprite_names.items() if mirror_name(i,n)}
    # unknown: mirror to avoid trouble
    unknown = set(range(0x200))-set(sprite_names)
    rval.update(unknown)

    return rval

def dump_asm_bytes(*args,**kwargs):
    bitplanelib.dump_asm_bytes(*args,**kwargs,mit_format=True)


def add_tile(table,index,cluts=[0]):
    if isinstance(index,range):
        pass
    elif not isinstance(index,(list,tuple)):
        index = [index]
    for idx in index:
        table[idx] = cluts


def ensure_empty(d):
    if os.path.exists(d):
        for f in os.listdir(d):
            os.remove(os.path.join(d,f))
    else:
        os.makedirs(d)

alphanum_tile_codes = set(range(0,10)) | set(range(65-48,65+27-48))   # wrong

if __name__ == "__main__":
    raise Exception("no main!")