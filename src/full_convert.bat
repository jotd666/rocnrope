..\assets\amiga\merge_used.py
..\assets\amiga\convert_graphics.py
6809to68k.py -i mot -o mit --code conv.s -I include.inc jailbreak_6809.asm
..\tools\post_process.py
goto skip_instrum
add_reg_log.py -s 8000 -e FF00 -p 1 jailbreak.68k
rem add_reg_log.py -c 91F9  -s A764 -e A7E6 -p 1 jailbreak.68k
rem add_reg_log.py -s 82DA -e 8326 -p 1 jailbreak.68k

:skip_instrum
rem m68k-amigaos-as --defsym MC68020=1 jailbreak.68k 2>&1



