..\assets\amiga\merge_used.py
..\assets\amiga\convert_graphics.py
6809to68k.py -O -i mot -o mit --code conv.s  --date-check -I rocnrope.inc rocnrope_6809.asm
..\tools\post_process.py
 goto skip_instrum
add_reg_log.py -s 6000 -e FF00 -p 1 rocnrope.68k
rem add_reg_log.py -c 91F9  -s A764 -e A7E6 -p 1 jailbreak.68k
rem add_reg_log.py -s 82DA -e 8326 -p 1 jailbreak.68k

:skip_instrum
rem m68k-amigaos-as --defsym __amiga__=1 rocnrope.68k -o rocnrope.o 2>&1
rem m68k-amigaos-ld -o test_exe rocnrope.o   > undefs.txt 2>&1
rem extract_undefined_symbols.py --debug-script mamedbg undefs.txt > undefs_todo.txt


