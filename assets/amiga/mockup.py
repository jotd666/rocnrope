from PIL import Image,ImageOps
import os,pathlib,struct

from shared import *


sprite_names = get_sprite_names()



def raw_to_code(raw):
    lsb = raw & 0xFF
    msb = raw >> 8


    base = ((lsb & 0x20) << 2) + (msb >> 1)
    if msb & 1:
        base += 0x100
    return base


def load_tileset(image_name,width,height,dump_prefix=""):
    full_image_path = sheets_path / "sprites" / image_name
    tiles_1 = Image.open(full_image_path)
    nb_rows = tiles_1.size[1] // height
    nb_cols = tiles_1.size[0] // width

    if dump_prefix:
        dumpdir = pathlib.Path("dumps")
        dumpdir.mkdir(exist_ok=True)

    tileset_1 = []
    k=0
    for j in range(nb_rows):
        for i in range(nb_cols):
            img = Image.new("RGB",(width,height))
            img.paste(tiles_1,(-i*width,-j*height))
            tileset_1.append(img)
            if dump_prefix:
                img = ImageOps.scale(img,5,resample=Image.Resampling.NEAREST)
                img.save(os.path.join(dumpdir,f"{dump_prefix}_{k:02x}.png"))
            k += 1

    return tileset_1

def loadtiles(i):
    return load_tileset(f"pal_{i:02x}.png",16,16)

tile_set = [loadtiles(i) for i in range(16)]


def process(the_dump,name_filter=None,hide_named_sprite=None):
    the_dump = pathlib.Path(the_dump)
    # in input, we use a MAME memory dump: save sprites,$A000,$400
    # (0x200 are read, but there's a kind of double buffering
    with open(the_dump,"rb") as f:
        mem_1000 = bytearray(f.read())

    m_spriteram = mem_1000

    result = Image.new("RGB",(256,256))

    print("*"*50)
    nb_active = 0


##        int const attr = m_spriteram[i + 1];    // attributes = ?tyxcccc
##        int const code = m_spriteram[i] + ((attr & 0x40) << 2);
##        int const color = attr & 0x0f;
##        int flipx = attr & 0x10;
##        int flipy = attr & 0x20;
##        int sx = m_spriteram[i + 2] - ((attr & 0x80) << 1);
##        int sy = m_spriteram[i + 3];

    for i in range(0XBC,-4,-4):
        attr = m_spriteram[i + 1]
        code = m_spriteram[i] + ((attr & 0x40) << 2)
        color = attr & 0x0f
        flipx = bool(attr & 0x10)
        flipy = bool(attr & 0x20)
        sx = m_spriteram[i + 2] - ((attr & 0x80) << 1)
        sy = m_spriteram[i + 3]

        if sy:
            im = tile_set[color][code]

            if flipy:
                im = ImageOps.flip(im)
            if flipx:
                im = ImageOps.mirror(im)

            name = sprite_names.get(code,"unknown")
            print(f"offs:{i:02x}, name: {name}, code:{code:02x}, flipx: {flipx}, flipy: {flipy}, color:{color:02x}, X:{sx}, Y:{sy}")
            result.paste(im,(sx,sy))
            nb_active += 1

    result.save(f"{the_dump.stem}.png")
    print(f"nb active: {nb_active}")


process(r"C:\Users\Public\Documents\Amiga Files\WinUAE\sprite_ram_1000")

