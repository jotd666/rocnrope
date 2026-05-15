import glob,os,re,pathlib,bitplanelib
from PIL import Image

this_dir = pathlib.Path(__file__).parent.absolute()

gfx_dir = pathlib.Path("level_3_after_forest")

for sn,ttype in ((1,"tiles"),(0,"sprites"),):
    outdir = this_dir / ttype
    outdir.mkdir(exist_ok=True)

    orig_name = f"gfx dev 0 set {sn} tiles * colors * pal *.png"
    for file in this_dir.glob(orig_name):
        print(file)
        new_name = re.sub(".* pal ","pal_",os.path.basename(file))
        img = Image.open(file)
        # replace magenta by 254,0,254 now that's the process, maybe it sucks
        bitplanelib.replace_color(img,{(255,0,255)},(254,0,254))
        img.save(outdir / new_name)
        file.unlink()