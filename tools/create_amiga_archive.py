import subprocess,os,glob,shutil,pathlib,zipfile

progdir = pathlib.Path(__file__).parent.parent.absolute()

# paraj lha from https://github.com/mras0/plha.git
# gadf from https://github.com/sphair/gadf

gamename = "rocnrope"
# JOTD path for cranker, adapt to whatever your path is :)
os.environ["PATH"] += os.pathsep+r"K:\progs\cli"

cmd_prefix = ["make","-f",os.path.join(progdir,"makefile.am")]

subprocess.check_call(cmd_prefix+["clean"],cwd=progdir /"src")

subprocess.check_call(cmd_prefix+["RELEASE_BUILD=1"],cwd=progdir /"src")
# create archive

outdir = progdir / "dist" / f"{gamename}_HD"

if os.path.isdir(outdir):
    shutil.rmtree(outdir)

outdir.mkdir(exist_ok=True,parents=True)

for file in ["readme.md",f"{gamename}_aga.slave",f"{gamename}_ocs.slave"]:
    shutil.copy(progdir / file,outdir)

assets = progdir /"assets"/"amiga"
shutil.copy(assets/"RocNRope_aga.info",outdir)
shutil.copy(assets/"RocNRope_ocs.info",outdir)
shutil.copy(assets/"boxart.jpg",outdir)




for ext in ["aga","ocs"]:
    exename = f"{gamename}_{ext}"
    shutil.copy(progdir/exename,outdir)
    subprocess.run(["cranker_windows.exe","-f",progdir/exename,"-o",progdir/f"{exename}.rnc"],check=True)

subprocess.run(cmd_prefix+["clean"],cwd=progdir/"src",check=True)

arcname = progdir / f"{gamename}_HD.lha"
arcname.unlink(missing_ok=True)
cmd = ["lha","-r","a",arcname,"*"]

subprocess.run(cmd,cwd=outdir.parent,check=True)

# create floppy
for ext in ["aga","ocs"]:
    exename = f"{gamename}_{ext}"
    shutil.move(progdir/f"{exename}.rnc",progdir/exename)

shutil.copy(assets/"disk.info",progdir)
adf_name = "RocNRope.adf"
cmd = ["gadf","-i","rocnrope","-a",adf_name,"-l","RocNRope","rocnrope_aga","rocnrope_ocs","readme.md","disk.info"]
subprocess.run(cmd,cwd=progdir)

# create a .zip for the floppy

with zipfile.ZipFile(progdir / "RocNRope_adf.zip",mode="w",compression=zipfile.ZIP_DEFLATED) as zf:
    zf.write(progdir/adf_name,arcname=adf_name)
os.remove(progdir/adf_name)