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



def get_possible_hw_sprites():
    sn = get_sprite_names()

    return set(k for k,v in sn.items() if "player" in v or v=="rock" or v=="ptero")

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

def set_names(rval,start,end,name):
    rval.update({i:name for i in range(start,end)})

def get_sprite_names():

    rval = dict()
    rval[9] = "zapper"
    rval[0x20] = "egg"
    set_names(rval,0xA,0x10,"harpoon")
    set_names(rval,0,9,"player")
    set_names(rval,0xD4,0xDC,"player_dead")
    set_names(rval,0x11,0x17,"player")
    set_names(rval,0x1B,0x20,"player")
    set_names(rval,0x18,0x1B,"ptero")
    set_names(rval,0x51,0x55,"rock")
    set_names(rval,0x59,0x5D,"ptero")
    set_names(rval,0x30,0x3A,"dino")
    set_names(rval,0x3D,0x40,"dino")
    set_names(rval,0x70,0x80,"dino")
    set_names(rval,0x40,0x4A,"score")
    set_names(rval,0xE0,0xE8,"score")
    set_names(rval,0x65,0x69,"dino")
    set_names(rval,0x4A,0x50,"dino")
    set_names(rval,0x80,0xD4,"bird")
    set_names(rval,0xEA,0xEC,"bird")
    set_names(rval,0xEC,0xEF,"feather")
    set_names(rval,0x3A,0x3C,"caveman")
    set_names(rval,0x25,0x30,"caveman")
    set_names(rval,0x69,0x70,"caveman")
    set_names(rval,0x60,0x65,"caveman")


    return rval

def mirror_name(i,n):

    return True

def get_mirror_sprites():
    """ return the index of the sprites that need mirroring
"""
    #return set(range(0x200))
    sprite_names = get_sprite_names()
    # TODO: tag all unknown to be able to filter with "mirror_name"
    rval = {i for i,n in sprite_names.items() if mirror_name(i,n)}
    # unknown: mirror to avoid trouble
    unknown = set(range(0x100))-set(sprite_names)
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

alphanum_tile_codes = set(range(0,10)) # | set(range(65-48,65+27-48))

if __name__ == "__main__":
    raise Exception("no main!")