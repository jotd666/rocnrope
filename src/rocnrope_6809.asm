;	map(0x3080, 0x3080).portr("SYSTEM");
;	map(0x3081, 0x3081).portr("P1");
;	map(0x3082, 0x3082).portr("P2");
;	map(0x3083, 0x3083).portr("DSW1");
;	map(0x3000, 0x3000).portr("DSW2");
;	map(0x3100, 0x3100).portr("DSW3");
;	map(0x4000, 0x402f).ram().share(m_spriteram[1]);
;	map(0x4030, 0x43ff).ram();
;	map(0x4400, 0x442f).ram().share(m_spriteram[0]);
;	map(0x4430, 0x47ff).ram();
;	map(0x4800, 0x4bff).ram().w(FUNC(rocnrope_state::colorram_w)).share(m_colorram);
;	map(0x4c00, 0x4fff).ram().w(FUNC(rocnrope_state::videoram_w)).share(m_videoram);
;	map(0x5000, 0x5fff).ram();
;	map(0x8000, 0x8000).w("watchdog", FUNC(watchdog_timer_device::reset_w));
;	map(0x8080, 0x8087).w("mainlatch", FUNC(ls259_device::write_d0));
;	map(0x8100, 0x8100).w("timeplt_audio", FUNC(timeplt_audio_device::sound_data_w));
;	map(0x8182, 0x818d).w(FUNC(rocnrope_state::interrupt_vector_w));
;	map(0x6000, 0xffff).rom();
;	map(0xfff2, 0xfffd).ram().share(m_vectors);


mainlatch_8087 = $8087
watchdog_8000 = $8000
system_3080 = $3080
port1_3081 = $3081
port2_3082 = $3082
dsw1_3083 = $3083
dsw2_3000 = $3000
dsw3_3100 = $3100
interrupt_vector_8182 = $8182
color_ram_4800 = $4800

6000: 4F             CLRA
6001: B7 02 05       STA    mainlatch_8087
6004: 6E AF 80 9C    JMP    $6226,PCR
6008: 9E 30          LDX    $18
600A: ED 09          STD    ,X++
600C: 8C 79 B7       CMPX   #$513F
600F: 23 21          BLS    $6014
6011: 8E D3 82       LDX    #$5100
6014: 9F 3A          STX    $18
6016: 39             RTS
6017: 6D 22          TST    $A,X
6019: 27 8F          BEQ    $6022
601B: 6A 22          DEC    $A,X
601D: 39             RTS
601E: EC 2C          LDD    ,Y
6020: ED 29          STD    $B,X
6022: 10 AE 29       LDY    $B,X
6025: A6 22          LDA    ,Y+
6027: 81 D7          CMPA   #$FF
6029: 27 7B          BEQ    $601E
602B: A7 25          STA    $D,X
602D: A6 86          LDA    $E,X
602F: 84 2D          ANDA   #$0F
6031: AA 22          ORA    ,Y+
6033: A7 2C          STA    $E,X
6035: E6 22          LDB    ,Y+
6037: E7 22          STB    $A,X
6039: 10 AF 83       STY    $B,X
603C: 39             RTS
603D: 48             ASLA
603E: 0D A8          TST    $20
6040: 27 24          BEQ    $6048
6042: 0D D1          TST    $53
6044: 27 20          BEQ    $6048
6046: 31 AA          LEAY   $8,Y
6048: EC 8E          LDD    A,Y
604A: ED 83          STD    $B,X
604C: 39             RTS

604D: 84 F7          ANDA   #$7F
604F: 10 8E DD 7D    LDY    #$FFFF
6053: 10 AF A3       STY    ,X++
6056: 8C D3 17       CMPX   #$513F
6059: 23 8B          BLS    $605E
605B: 8E 79 28       LDX    #$5100
605E: 9F 92          STX    $1A
6060: 8E 42 F6       LDX    #jump_table_6074
6063: AD B4          JSR    [A,X]		; [indirect_jump]
6065: 4F             CLRA
6066: B7 02 AA       STA    $8082
6069: 9E 92          LDX    $1A
606B: EC AC          LDD    ,X
606D: 48             ASLA
606E: 24 55          BCC    $604D
6070: 8D 00          BSR    $6094
6072: 20 73          BRA    $6065


6090: 4C             INCA
6091: 10 EC CD       LDD    $F,U
6094: 0D 00          TST    $22
6096: 27 B3          BEQ    $60C9
6098: D6 67          LDB    $4F
609A: C5 87          BITB   #$0F
609C: 27 03          BEQ    $60C9
609E: C5 98          BITB   #$10
60A0: 27 30          BEQ    $60B4
60A2: 8E CE 7D       LDX    #$4C5F
60A5: 0D A2          TST    $20
60A7: 27 2B          BEQ    $60AC
60A9: 8E C6 57       LDX    #$4EDF
60AC: 86 38          LDA    #$10
60AE: A7 0C          STA    ,X
60B0: A7 AA A2       STA    $20,X
60B3: 39             RTS
60B4: 8E 6E DD       LDX    #$4C5F
60B7: C6 29          LDB    #$01
60B9: 0D A8          TST    $20
60BB: 27 2C          BEQ    $60C1
60BD: 8E C6 57       LDX    #$4EDF
60C0: 5C             INCB
60C1: E7 06          STB    ,X
60C3: C6 02          LDB    #$20
60C5: E7 0A A2       STB    $20,X
60C8: 39             RTS
60C9: 39             RTS
60CA: 86 D8          LDA    #$50
60CC: 1F A3          TFR    A,DP
60CE: 8E D8 22       LDX    #$5000	; DP in ram start
60D1: 6F 02          CLR    ,X+
60D3: 6F A2          CLR    ,X+
60D5: 6F 02          CLR    ,X+
60D7: 6F A8          CLR    ,X+
60D9: 8C D7 77       CMPX   #$5FFF
60DC: 23 DB          BLS    $60D1
60DE: 32 0C          LEAS   ,X
60E0: 8E 73 82       LDX    #$5100
60E3: 9F 38          STX    $1A
60E5: 9F 9A          STX    $18
60E7: CC D7 D7       LDD    #$FFFF
60EA: ED 09          STD    ,X++
60EC: ED A9          STD    ,X++
60EE: 8C D9 1D       CMPX   #$513F
60F1: 23 75          BLS    $60EA
60F3: CE 6A 22       LDU    #color_ram_4800
60F6: 8E 82 28       LDX    #$0000
60F9: 31 0C          LEAY   ,X
60FB: 4F             CLRA
60FC: C6 A8          LDB    #$80
60FE: 36 BA          PSHU   Y,X,A
6100: 36 10          PSHU   Y,X,A
6102: 36 B0          PSHU   Y,X,A
6104: 36 20          PSHU   A
6106: 5A             DECB
6107: 26 DD          BNE    $60FE
6109: CC C4 88       LDD    #$4C00
610C: FD 68 48       STD    $40C0
610F: FD 62 C2       STD    $40E0
6112: 8E D3 62       LDX    #$5140
6115: 9F 9E          STX    $1C
6117: 9F 36          STX    $1E
6119: B6 B8 0B       LDA    dsw1_3083
611C: 43             COMA
611D: 97 A6          STA    $2E
611F: B6 12 22       LDA    dsw2_3000
6122: 43             COMA
6123: 97 0D          STA    $2F
6125: B6 B3 82       LDA    dsw3_3100
6128: 43             COMA
6129: 97 B8          STA    $30
612B: 96 06          LDA    $2E
612D: 84 87          ANDA   #$0F
612F: 81 2D          CMPA   #$0F
6131: 26 86          BNE    $6137
6133: C6 23          LDB    #$01
6135: D7 D3          STB    $51
6137: 48             ASLA
6138: 8E D7 28       LDX    #$FFA0
613B: EC AE          LDD    A,X
613D: DD AF          STD    $27
613F: 96 0C          LDA    $2E
6141: 84 72          ANDA   #$F0
6143: 44             LSRA
6144: 44             LSRA
6145: 44             LSRA
6146: 8E 7D E8       LDX    #$FFC0
6149: EC 0E          LDD    A,X
614B: DD 04          STD    $2C
614D: 96 A7          LDA    $2F
614F: 84 21          ANDA   #$03
6151: 8E E0 80       LDX    #$6202
6154: A6 A4          LDA    A,X
6156: 97 D2          STA    $50
6158: 0F 7B          CLR    $53
615A: 96 A7          LDA    $2F
615C: 85 2C          BITA   #$04
615E: 26 8C          BNE    $6164
6160: C6 23          LDB    #$01
6162: D7 D1          STB    $53
6164: 96 0D          LDA    $2F
6166: 84 FA          ANDA   #$78
6168: 44             LSRA
6169: 44             LSRA
616A: 44             LSRA
616B: 97 65          STA    $4D
616D: 8E 77 68       LDX    #$FFE0
6170: A6 A4          LDA    A,X
6172: 97 D7          STA    $55
6174: 96 0D          LDA    $2F
6176: 84 02          ANDA   #$80
6178: 49             ROLA
6179: 49             ROLA
617A: 97 DA          STA    $52
617C: 96 18          LDA    $30
617E: 84 8F          ANDA   #$07
6180: 10 8E E0 84    LDY    #$6206
6184: 48             ASLA
6185: EC 24          LDD    A,Y
6187: DD 71          STD    $59
6189: 96 B8          LDA    $30
618B: 84 10          ANDA   #$38
618D: 44             LSRA
618E: 44             LSRA
618F: 10 8E 40 94    LDY    #$6216
6193: EC 84          LDD    A,Y
6195: DD D5          STD    $57
6197: 96 18          LDA    $30
6199: 49             ROLA
619A: 49             ROLA
619B: 49             ROLA
619C: 1F A1          TFR    A,B
619E: 84 89          ANDA   #$01
61A0: 97 74          STA    $56
61A2: C4 80          ANDB   #$02
61A4: 44             LSRA
61A5: D7 D9          STB    $5B
61A7: CC 58 88       LDD    #$70A0
61AA: FD 09 AA       STD    interrupt_vector_8182
61AD: FD 09 0C       STD    $8184
61B0: FD A3 04       STD    $8186
61B3: FD A3 AA       STD    $8188
61B6: FD 03 A2       STD    $818A
61B9: FD 09 04       STD    $818C
61BC: 10 8E E9 72    LDY    #$61FA
61C0: 8E 73 E2       LDX    #$5160
61C3: EC 86          LDD    ,Y
61C5: EE A0          LDU    $2,Y
61C7: ED A9          STD    ,X++
61C9: EF 09          STU    ,X++
61CB: EC 0C          LDD    $4,Y
61CD: EE AE          LDU    $6,Y
61CF: ED A3          STD    ,X++
61D1: EF 03          STU    ,X++
61D3: 8C 73 BD       CMPX   #$519F
61D6: 23 69          BLS    $61C3
61D8: AE 8C          LDX    ,Y
61DA: A6 AA          LDA    $2,Y
61DC: 9F 8E          STX    $A6
61DE: 97 20          STA    $A8
61E0: 4F             CLRA
61E1: B7 02 00       STA    $8082
61E4: B7 A3 82       STA    audio_8100
61E7: B7 A8 A9       STA    $8081
61EA: 12             NOP
61EB: 12             NOP
61EC: 12             NOP
61ED: 4C             INCA
61EE: B7 08 A3       STA    $8081
61F1: B7 02 05       STA    mainlatch_8087
61F4: 1C CD          ANDCC  #$EF
61F6: 6E 0F D6 43    JMP    $6065,PCR

6226: 8E C5 28       LDX    #$4700                                       
6229: 4F             CLRA
622A: 5F             CLRB
622B: A7 A8          STA    ,X+
622D: 4C             INCA
622E: 5A             DECB
622F: 26 D8          BNE    $622B
6231: 30 0B 7D 22    LEAX   -$0100,X
6235: A1 02          CMPA   ,X+
6237: 10 26 28 7D    LBNE   $6330
623B: 4C             INCA
623C: 5A             DECB
623D: 26 7E          BNE    $6235
623F: CE 65 22       LDU    #$4700
6242: 8E CA 22       LDX    #color_ram_4800
6245: AF 46          STX    ,U
6247: CC 30 28       LDD    #$1800
624A: ED CA          STD    $2,U
624C: CC 29 AB       LDD    #$0123
624F: ED 66          STD    $4,U
6251: 32 0F 82 21    LEAS   $6258,PCR
6255: 7E E0 62       JMP    $62E0
6258: CC 6D EF       LDD    #$4567
625B: ED 6C          STD    $4,U
625D: 32 05 88 21    LEAS   $6264,PCR
6261: 7E E0 62       JMP    $62E0
6264: CC AB 29       LDD    #$89AB
6267: ED 6C          STD    $4,U
6269: 32 05 88 2B    LEAS   $6270,PCR
626D: 7E EA 68       JMP    $62E0
6270: CC EF 6D       LDD    #$CDEF
6273: ED 66          STD    $4,U
6275: 32 0F 82 2B    LEAS   $627C,PCR
6279: 7E EA 68       JMP    $62E0
627C: CC 7D 22       LDD    #$55AA
627F: ED 66          STD    $4,U
6281: 32 0F 82 21    LEAS   $6288,PCR
6285: 7E E0 62       JMP    $62E0
6288: CE 78 88       LDU    #$5000
628B: 8E 68 28       LDX    #$4000
628E: AF 4C          STX    ,U
6290: CC 26 E2       LDD    #$0460
6293: ED 60          STD    $2,U
6295: CC 83 A1       LDD    #$0123
6298: ED 6C          STD    $4,U
629A: 32 05 28 2B    LEAS   $62A1,PCR
629E: 7E EA C2       JMP    $62E0
62A1: CC C7 E5       LDD    #$4567
62A4: ED 66          STD    $4,U
62A6: 32 0F 28 2B    LEAS   $62AD,PCR
62AA: 7E EA C8       JMP    $62E0
62AD: CC 01 23       LDD    #$89AB
62B0: ED 66          STD    $4,U
62B2: 32 0F 22 21    LEAS   $62B9,PCR
62B6: 7E E0 C8       JMP    $62E0
62B9: CC 45 67       LDD    #$CDEF
62BC: ED 6C          STD    $4,U
62BE: 32 05 22 21    LEAS   $62C5,PCR
62C2: 7E E0 C2       JMP    $62E0
62C5: CC D7 28       LDD    #$55AA
62C8: ED 6C          STD    $4,U
62CA: 32 05 28 2B    LEAS   $62D1,PCR
62CE: 7E EA C2       JMP    $62E0
62D1: CC 28 D7       LDD    #$AA55
62D4: ED 66          STD    $4,U
62D6: 32 0F 28 2B    LEAS   $62DD,PCR
62DA: 7E EA C8       JMP    $62E0
62DD: 16 89 9A       LBRA   $63F2
62E0: AE E6          LDX    ,U
62E2: 10 AE 60       LDY    $2,U
62E5: EC C6          LDD    $4,U
62E7: ED 6E          STD    $6,U
62E9: C6 89          LDB    #$01
62EB: A6 6E          LDA    $6,U
62ED: A8 CF          EORA   $7,U
62EF: 43             COMA
62F0: 48             ASLA
62F1: 48             ASLA
62F2: A9 C5          ADCA   $7,U
62F4: A7 65          STA    $7,U
62F6: A6 C4          LDA    $6,U
62F8: A9 6E          ADCA   $6,U
62FA: A7 CE          STA    $6,U
62FC: A6 6F          LDA    $7,U
62FE: A7 08          STA    ,X+
6300: F7 A2 82       STB    watchdog_8000
6303: 31 1D          LEAY   -$1,Y
6305: 26 66          BNE    $62EB
6307: AE EC          LDX    ,U
6309: 10 AE CA       LDY    $2,U
630C: EC 6C          LDD    $4,U
630E: ED CE          STD    $6,U
6310: A6 64          LDA    $6,U
6312: A8 C5          EORA   $7,U
6314: 43             COMA
6315: 48             ASLA
6316: 48             ASLA
6317: A9 6F          ADCA   $7,U
6319: A7 CF          STA    $7,U
631B: A6 6E          LDA    $6,U
631D: A9 CE          ADCA   $6,U
631F: A7 64          STA    $6,U
6321: A6 C5          LDA    $7,U
6323: A1 A2          CMPA   ,X+
6325: 26 8B          BNE    $6330
6327: F7 A8 28       STB    watchdog_8000
632A: 31 B7          LEAY   -$1,Y
632C: 26 CA          BNE    $6310
632E: 6E 6C          JMP    ,S
6330: 8C 62 82       CMPX   #$4000
6333: 24 27          BCC    $633A
6335: 8E E1 27       LDX    #$63A5
6338: 20 1D          BRA    $636F
633A: 8C CC 28       CMPX   #$4400
633D: 24 8D          BCC    $6344
633F: 8E 41 8D       LDX    #$63AF
6342: 20 A9          BRA    $636F
6344: 8C 6A 82       CMPX   #color_ram_4800
6347: 24 2D          BCC    $634E
6349: 8E EB 31       LDX    #$63B9
634C: 20 09          BRA    $636F
634E: 8C D8 22       CMPX   #$5000
6351: 24 87          BCC    $6358
6353: 8E 41 E1       LDX    #$63C3
6356: 20 95          BRA    $636F
6358: 8C 70 88       CMPX   #$5800
635B: 24 2D          BCC    $6362
635D: 8E EB 45       LDX    #$63CD
6360: 20 2F          BRA    $636F
6362: 8C E2 22       CMPX   #$6000
6365: 24 87          BCC    $636C
6367: 8E 4B FF       LDX    #$63D7
636A: 20 8B          BRA    $636F
636C: 8E 4B 2D       LDX    #$63A5
636F: C6 32          LDB    #$10
6371: 33 06          LEAU   ,X
6373: 8E 6A 22       LDX    #color_ram_4800
6376: 86 83          LDA    #$01
6378: E7 A8          STB    ,X+
637A: B7 08 28       STA    watchdog_8000
637D: 8C C3 77       CMPX   #$4BFF
6380: 23 D4          BLS    $6378
6382: 8E CE 22       LDX    #$4C00
6385: E7 02          STB    ,X+
6387: B7 A8 28       STA    watchdog_8000
638A: 8C C7 D7       CMPX   #$4FFF
638D: 23 7E          BLS    $6385
638F: 8E 6E 48       LDX    #$4C6A
6392: C6 88          LDB    #$0A
6394: A6 E2          LDA    ,U+
6396: A7 06          STA    ,X
6398: 30 A0 A8       LEAX   $20,X
639B: 5A             DECB
639C: 26 DE          BNE    $6394
639E: C6 89          LDB    #$01
63A0: F7 A2 82       STB    watchdog_8000
63A3: 20 D9          BRA    $63A0
63A5: 00 93          NEG    $11
63A7: 9F 38          STX    $10
63A9: 38 98          XANDCC #$10
63AB: 98 37          EORA   $1F
63AD: 0D AC          TST    $24
63AF: 97 30          STA    $12
63B1: 38 92          XANDCC #$10
63B3: 83 32 32       SUBD   #$1010
63B6: 9D A7          JSR    $25
63B8: 0C 37          INC    $1F
63BA: 9A 92          ORA    $1A
63BC: 38 2A          XANDCC #$02
63BE: 98 98          EORA   $10
63C0: 3D             MUL
63C1: 07 A6          ASR    $24
63C3: A4 00          ANDA   $2,Y
63C5: 33 9F          LEAU   -$3,X
63C7: 92 38          SBCA   $10
63C9: 38 97          XANDCC #$1F
63CB: AD 0C          JSR    $4,Y
63CD: 0F AA          CLR    $22
63CF: 99 3F          ADCA   $1D
63D1: 32 83          LEAS   $1,X
63D3: 92 3D          SBCA   $1F
63D5: 07 A6          ASR    $24
63D7: A5 0A          BITA   $2,Y
63D9: 39             RTS
63DA: 95 98          BITA   $10
63DC: 2A 38          BPL    $63EE
63DE: 97 AD          STA    $25
63E0: 06 69          ROR    $4B
63E2: C8 E0          EORB   #$62
63E4: 26 23          BNE    $63E7
63E6: 8D 8E          BSR    $63F4
63E8: 2C 50          BGE    $6462
63EA: 80 89          SUBA   #$01
63EC: 23 5D          BLS    $6463
63EE: 9B 97          ADDA   $1F
63F0: 21 43          BRN    $6453
63F2: 8E CA 22       LDX    #color_ram_4800
63F5: CC 8C 83       LDD    #$0E01
63F8: A7 A8          STA    ,X+
63FA: F7 08 28       STB    watchdog_8000
63FD: 8C C3 77       CMPX   #$4BFF
6400: 23 D4          BLS    $63F8
6402: 8E CE 22       LDX    #$4C00
6405: 86 9A          LDA    #$18
6407: A7 A8          STA    ,X+
6409: F7 08 88       STB    watchdog_8000
640C: 8C 67 77       CMPX   #$4FFF
640F: 23 D4          BLS    $6407
6411: 8E C2 82       LDX    #$4000
6414: C6 12          LDB    #$30
6416: 6F 02          CLR    ,X+
6418: 5A             DECB
6419: 26 73          BNE    $6416
641B: 8E 6C 28       LDX    #$4400
641E: C6 B8          LDB    #$30
6420: 6F A2          CLR    ,X+
6422: 5A             DECB
6423: 26 D9          BNE    $6420
6425: 86 87          LDA    #$05
6427: C6 29          LDB    #$01
6429: 8E 88 88       LDX    #$0000
642C: F7 A8 88       STB    watchdog_8000
642F: 30 3D          LEAX   -$1,X
6431: 26 7B          BNE    $642C
6433: 4A             DECA
6434: 26 D1          BNE    $6429
6436: 6E 0F D4 B8    JMP    $60CA,PCR
643A: 86 94          LDA    #$1C
643C: 97 58          STA    $70
643E: 8E C4 62       LDX    #$4C40
6441: 86 A2          LDA    #$20
6443: 97 53          STA    $71
6445: 86 92          LDA    #$10
6447: E7 A1 D4 88    STB    -$0400,X
644B: A7 A8          STA    ,X+
644D: 0A F9          DEC    $71
644F: 26 D4          BNE    $6447
6451: 3C 6D          CWAI   #$EF
6453: 0A 52          DEC    $70
6455: 26 68          BNE    $6441
6457: C6 28          LDB    #$00
6459: 10 8E EC 9D    LDY    #$64B5
645D: 8E C4 D7       LDX    #$4C5F
6460: 8D 1D          BSR    $64A1
6462: C6 82          LDB    #$00
6464: CE 72 22       LDU    #$50A0
6467: 8E 64 B7       LDX    #$4C9F
646A: BD EF 55       JSR    $677D
646D: C6 88          LDB    #$00
646F: 8E 6F BD       LDX    #$4D9F
6472: 8D AF          BSR    $64A1
6474: C6 22          LDB    #$00
6476: CE D2 8E       LDU    #$50A6
6479: 8E C5 57       LDX    #$4DDF
647C: BD 4F F5       JSR    $677D
647F: 0D 00          TST    $22
6481: 27 86          BEQ    $6487
6483: 96 03          LDA    $21
6485: 97 3D          STA    $BF
6487: 0D 97          TST    $BF
6489: 27 9B          BEQ    $649E
648B: C6 28          LDB    #$00
648D: 8E C6 57       LDX    #$4EDF
6490: BD 46 23       JSR    $64A1
6493: C6 22          LDB    #$00
6495: CE D2 21       LDU    #$50A3
6498: 8E 67 97       LDX    #$4F1F
649B: BD 4F 55       JSR    $677D
649E: 0F 3E          CLR    $B6
64A0: 39             RTS
64A1: A6 22          LDA    ,Y+
64A3: 81 1D          CMPA   #$3F
64A5: 27 8F          BEQ    $64B4
64A7: 80 18          SUBA   #$30
64A9: A7 0C          STA    ,X
64AB: E7 A1 D4 88    STB    -$0400,X
64AF: 30 AA 02       LEAX   $20,X
64B2: 20 6F          BRA    $64A1
64B4: 39             RTS
64B5: 13             SYNC

64BE: 58             ASLB
64BF: 25 06          BCS    $64E5
64C1: 2B C1          BMI    $6506
64C3: C4 5D          ANDB   #$7F
64C5: 8E E7 9A       LDX    #$6518
64C8: EE AD          LDU    B,X
64CA: 96 24          LDA    $AC
64CC: AE E9          LDX    ,U++
64CE: E6 48          LDB    ,U+
64D0: C1 1D          CMPB   #$3F
64D2: 27 B3          BEQ    $6505
64D4: C1 0D          CMPB   #$2F
64D6: 27 76          BEQ    $64CC
64D8: C0 18          SUBB   #$30
64DA: A7 01 D4 28    STA    -$0400,X
64DE: E7 0C          STB    ,X
64E0: 30 AA A2       LEAX   $20,X
64E3: 20 CB          BRA    $64CE
64E5: 8E E7 9A       LDX    #$6518
64E8: EE AD          LDU    B,X
64EA: 96 24          LDA    $AC
64EC: AE E9          LDX    ,U++
64EE: E6 48          LDB    ,U+
64F0: C1 1D          CMPB   #$3F
64F2: 27 93          BEQ    $6505
64F4: C1 0D          CMPB   #$2F
64F6: 27 76          BEQ    $64EC
64F8: C6 38          LDB    #$10
64FA: E7 0C          STB    ,X
64FC: A7 A1 74 88    STA    -$0400,X
6500: 30 AA A2       LEAX   $20,X
6503: 20 CB          BRA    $64EE
6505: 39             RTS
6506: 86 83          LDA    #$01
6508: 97 9D          STA    $B5
650A: 8E ED 30       LDX    #$6518
650D: C4 F7          ANDB   #$7F
650F: EE A7          LDU    B,X
6511: AE 43          LDX    ,U++
6513: 9F 90          STX    $B2
6515: DF 32          STU    $B0
6517: 39             RTS
6518: 4D             TSTA
6519: 10 ED CD       STD    $5,U
651C: 4D             TSTA
651D: 7A ED D7       DEC    $655F
6520: 47             ASRA
6521: 4F             CLRA
6522: E7 FD          STB    -$1,S
6524: 47             ASRA
6525: B6 E7 21       LDA    $65A3
6528: 4D             TSTA
6529: 9E ED          LDX    $65
652B: 35 4E          PULS   D,Y,U
652D: 30 EE          LEAX   $6,S
652F: A6 44          LDA    $6,S
6531: 16 E4 CB       LBRA   $CB7D

65EF: F6 D5 DE       LDB    $F7FC
65F2: 7C 86 24       INC    $0406
65F5: 2E 8C          BGT    $6605
65F7: 96 3E          LDA    $16
65F9: 08 AA          ASL    $22
65FB: A0 20          SUBA   $8,X
65FD: 22 AC          BHI    $6623
65FF: AE 0D          LDX    $F,Y
6601: 6E 56          JMP    [,U]        ; [indirect_jump]

6718: 0D 0A          TST    $22
671A: 27 E8          BEQ    $677C
671C: 58             ASLB
671D: 8E EE FE       LDX    #$6676
6720: 10 AE 07       LDY    B,X
6723: 8E 72 81       LDX    #$50A3
6726: 0D A2          TST    $20
6728: 27 2B          BEQ    $672D
672A: 8E D8 8E       LDX    #$50A6
672D: A6 0A          LDA    ,-X
672F: AB 80          ADDA   ,-Y
6731: 19             DAA
6732: A7 06          STA    ,X
6734: A6 A0          LDA    ,-X
6736: A9 20          ADCA   ,-Y
6738: 19             DAA
6739: A7 0C          STA    ,X
673B: A6 AA          LDA    ,-X
673D: A9 2A          ADCA   ,-Y
673F: 19             DAA
6740: A7 A6          STA    ,X
6742: EC 06          LDD    ,X
6744: 10 93 24       CMPD   $A6
6747: 22 20          BHI    $6751
6749: 25 93          BCS    $6766
674B: E6 2A          LDB    $2,X
674D: D1 20          CMPB   $A8
674F: 25 37          BCS    $6766
6751: CE D2 24       LDU    #$50A6
6754: EC A6          LDD    ,X
6756: ED 46          STD    ,U
6758: E6 2A          LDB    $2,X
675A: E7 CA          STB    $2,U
675C: C6 38          LDB    #$10
675E: CE D8 84       LDU    #$50A6
6761: 8E CF 5D       LDX    #$4DDF
6764: 8D 35          BSR    $677D
6766: 8E CE B7       LDX    #$4C9F
6769: CE D8 28       LDU    #$50A0
676C: C6 38          LDB    #$10
676E: 0D A8          TST    $20
6770: 27 25          BEQ    $6779
6772: 8E CD 3D       LDX    #$4F1F
6775: 33 C1          LEAU   $3,U
6777: C6 38          LDB    #$10
6779: 7E EF F5       JMP    $677D
677C: 39             RTS
677D: A6 4C          LDA    ,U
677F: 44             LSRA
6780: 44             LSRA
6781: 44             LSRA
6782: 44             LSRA
6783: 84 2D          ANDA   #$0F
6785: 26 A4          BNE    $67AD
6787: 86 38          LDA    #$10
6789: 8D CC          BSR    $67CF
678B: A6 EC          LDA    ,U
678D: 84 87          ANDA   #$0F
678F: 26 00          BNE    $67B3
6791: 86 92          LDA    #$10
6793: 8D 18          BSR    $67CF
6795: A6 C3          LDA    $1,U
6797: 44             LSRA
6798: 44             LSRA
6799: 44             LSRA
679A: 44             LSRA
679B: 84 27          ANDA   #$0F
679D: 26 94          BNE    $67BB
679F: 86 32          LDA    #$10
67A1: 8D AE          BSR    $67CF
67A3: A6 63          LDA    $1,U
67A5: 84 8D          ANDA   #$0F
67A7: 26 30          BNE    $67C1
67A9: 86 98          LDA    #$10
67AB: 20 3C          BRA    $67C1
67AD: 8D A8          BSR    $67CF
67AF: A6 E6          LDA    ,U
67B1: 84 8D          ANDA   #$0F
67B3: 8D 38          BSR    $67CF
67B5: A6 C3          LDA    $1,U
67B7: 44             LSRA
67B8: 44             LSRA
67B9: 44             LSRA
67BA: 44             LSRA
67BB: 8D 3A          BSR    $67CF
67BD: A6 C9          LDA    $1,U
67BF: 84 2D          ANDA   #$0F
67C1: 8D 8E          BSR    $67CF
67C3: A6 60          LDA    $2,U
67C5: 44             LSRA
67C6: 44             LSRA
67C7: 44             LSRA
67C8: 44             LSRA
67C9: 8D 8C          BSR    $67CF
67CB: A6 6A          LDA    $2,U
67CD: 84 87          ANDA   #$0F
67CF: E7 AB DE 82    STB    -$0400,X
67D3: A7 A6          STA    ,X
67D5: 30 0A A2       LEAX   $20,X
67D8: 39             RTS
67D9: 8E D8 28       LDX    #$50A0
67DC: 5A             DECB
67DD: 27 90          BEQ    $67F7
67DF: 30 21          LEAX   $3,X
67E1: 5A             DECB
67E2: 27 91          BEQ    $67F7
67E4: 30 21          LEAX   $3,X
67E6: 5A             DECB
67E7: 27 26          BEQ    $67F7
67E9: 30 92          LEAX   -$6,X
67EB: 6F A8          CLR    ,X+
67ED: 6F 08          CLR    ,X+
67EF: 6F A2          CLR    ,X+
67F1: 6F 02          CLR    ,X+
67F3: 6F A2          CLR    ,X+
67F5: 6F 02          CLR    ,X+
67F7: 6F A8          CLR    ,X+
67F9: 6F 08          CLR    ,X+
67FB: 6F AC          CLR    ,X
67FD: 39             RTS
67FE: 5D             TSTB
67FF: 27 2A          BEQ    $6809
6801: C1 80          CMPB   #$02
6803: 25 06          BCS    $6829
6805: 27 AC          BEQ    $6835
6807: 20 3C          BRA    $681D
6809: CE D8 28       LDU    #$50A0
680C: 8E 64 17       LDX    #$4C9F
680F: D6 8F          LDB    $AD
6811: 17 7D EB       LBSR   $677D
6814: CE 72 21       LDU    #$50A3
6817: 8E 67 37       LDX    #$4F1F
681A: 17 77 48       LBSR   $677D
681D: CE D8 2E       LDU    #$50A6
6820: 8E 6F 5D       LDX    #$4DDF
6823: D6 8F          LDB    $AD
6825: BD E5 FF       JSR    $677D
6828: 39             RTS
6829: CE D8 28       LDU    #$50A0
682C: 8E 64 17       LDX    #$4C9F
682F: D6 8F          LDB    $AD
6831: BD E5 FF       JSR    $677D
6834: 39             RTS
6835: CE D2 21       LDU    #$50A3
6838: 8E 67 97       LDX    #$4F1F
683B: D6 85          LDB    $AD
683D: BD EF F5       JSR    $677D
6840: 39             RTS
6841: 32 FF          LEAS   -$3,S
6843: 4F             CLRA
6844: C1 46          CMPB   #$64
6846: 25 87          BCS    $684D
6848: C0 4C          SUBB   #$64
684A: 4C             INCA
684B: 20 DF          BRA    $6844
684D: A7 6C          STA    ,S
684F: 4F             CLRA
6850: C1 10          CMPB   #$32
6852: 25 86          BCS    $6858
6854: C0 10          SUBB   #$32
6856: 86 87          LDA    #$05
6858: C1 22          CMPB   #$0A
685A: 25 8D          BCS    $6861
685C: C0 22          SUBB   #$0A
685E: 4C             INCA
685F: 20 D5          BRA    $6858
6861: A7 E3          STA    $1,S
6863: E7 40          STB    $2,S
6865: 6E 26          JMP    ,Y
6867: 31 A5 28 8A    LEAY   $686D,PCR
686B: 20 FC          BRA    $6841
686D: 96 25          LDA    $AD
686F: A7 AB DE 82    STA    -$0400,X
6873: A7 AB DE A2    STA    -$03E0,X
6877: A7 A1 D4 C8    STA    -$03C0,X
687B: A6 C8          LDA    ,S+
687D: 26 9B          BNE    $6892
687F: 86 32          LDA    #$10
6881: A7 0A C2       STA    $40,X
6884: A6 C2          LDA    ,S+
6886: 26 80          BNE    $688A
6888: 86 38          LDA    #$10
688A: A7 0C          STA    ,X
688C: A6 C8          LDA    ,S+
688E: A7 00 02       STA    $20,X
6891: 39             RTS
6892: A7 06          STA    ,X
6894: A6 C2          LDA    ,S+
6896: A7 0A 08       STA    $20,X
6899: A6 68          LDA    ,S+
689B: A7 A0 68       STA    $40,X
689E: 39             RTS
689F: 8E 4A C2       LDX    #$68E0
68A2: 58             ASLB
68A3: 25 3C          BCS    $68C3
68A5: EE 07          LDU    B,X
68A7: AE E9          LDX    ,U++
68A9: E6 48          LDB    ,U+
68AB: A6 E8          LDA    ,U+
68AD: 81 B7          CMPA   #$3F
68AF: 27 33          BEQ    $68C2
68B1: 81 AD          CMPA   #$2F
68B3: 27 D0          BEQ    $68A7
68B5: 80 B2          SUBA   #$30
68B7: A7 AC          STA    ,X
68B9: E7 01 74 28    STB    -$0400,X
68BD: 30 00 A8       LEAX   $20,X
68C0: 20 CB          BRA    $68AB
68C2: 39             RTS
68C3: EE A7          LDU    B,X
68C5: AE 43          LDX    ,U++
68C7: E6 E8          LDB    ,U+
68C9: A6 48          LDA    ,U+
68CB: 81 17          CMPA   #$3F
68CD: 27 7B          BEQ    $68C2
68CF: 81 0D          CMPA   #$2F
68D1: 27 70          BEQ    $68C5
68D3: 86 32          LDA    #$10
68D5: A7 06          STA    ,X
68D7: E7 A1 D4 88    STB    -$0400,X
68DB: 30 A0 08       LEAX   $20,X
68DE: 20 61          BRA    $68C9


6972: CE C3 7B       LDU    #$4159
6975: 1D             SEX
6976: 58             ASLB
6977: 8E 9F EC       LDX    #$B7C4
697A: 10 AE AD       LDY    B,X
697D: 8E C0 C8       LDX    #$4840
6980: C6 3E          LDB    #$1C
6982: A6 22          LDA    ,Y+
6984: A7 A2          STA    ,X+
6986: 5A             DECB
6987: 26 D1          BNE    $6982
6989: 30 8C          LEAX   $4,X
698B: 8C 63 97       CMPX   #$4BBF
698E: 23 78          BLS    $6980
6990: 39             RTS
6991: 0F F2          CLR    $70
6993: 0F 54          CLR    $76
6995: D6 43          LDB    $C1
6997: C4 2B          ANDB   #$03
6999: 58             ASLB
699A: 10 8E 9F EC    LDY    #$B7C4
699E: 10 AE 87       LDY    B,Y
69A1: 10 9F F0       STY    $72
69A4: 10 8E 35 3E    LDY    #$B7BC
69A8: 10 AE 2D       LDY    B,Y
69AB: 10 9F 5C       STY    $74
69AE: 96 FE          LDA    $76
69B0: C6 3E          LDB    #$1C
69B2: 3D             MUL
69B3: 1F 21          TFR    D,U
69B5: D3 F6          ADDD   $74
69B7: 1F 29          TFR    D,X
69B9: D6 FF          LDB    $77
69BB: 3A             ABX
69BC: 9F 50          STX    $78
69BE: 96 FE          LDA    $76
69C0: C6 02          LDB    #$20
69C2: 3D             MUL
69C3: DD 52          STD    $70
69C5: CC CE C2       LDD    #$4C40
69C8: D3 58          ADDD   $70
69CA: 1F 89          TFR    D,X
69CC: D6 5F          LDB    $77
69CE: 3A             ABX
69CF: 9F 58          STX    $7A
69D1: 1F B2          TFR    U,D
69D3: D3 50          ADDD   $72
69D5: 1F 83          TFR    D,X
69D7: D6 5F          LDB    $77
69D9: 3A             ABX
69DA: 9F F4          STX    $7C
69DC: 9E 52          LDX    $7A
69DE: 10 9E 5A       LDY    $78
69E1: A6 26          LDA    ,Y
69E3: A7 A6          STA    ,X
69E5: 30 0B 7E 28    LEAX   -$0400,X
69E9: 10 9E F4       LDY    $7C
69EC: A6 8C          LDA    ,Y
69EE: A7 0C          STA    ,X
69F0: 8D 3B          BSR    $6A0B
69F2: 0C F5          INC    $77
69F4: 96 55          LDA    $77
69F6: 81 9E          CMPA   #$1C
69F8: 10 26 77 3A    LBNE   $69AE
69FC: 3C C7          CWAI   #$EF
69FE: 0F FF          CLR    $77
6A00: 0C 54          INC    $76
6A02: 96 F4          LDA    $76
6A04: 81 3E          CMPA   #$1C
6A06: 26 0F          BNE    $6995
6A08: 0F 9E          CLR    $B6
6A0A: 39             RTS
6A0B: 0F 56          CLR    $7E
6A0D: 96 49          LDA    $C1
6A0F: 81 21          CMPA   #$03
6A11: 22 8A          BHI    $6A1B
6A13: 48             ASLA
6A14: 8E 48 D8       LDX    #$6A5A
6A17: AE AE          LDX    A,X
6A19: 20 82          BRA    $6A25
6A1B: 84 2B          ANDA   #$03
6A1D: 48             ASLA
6A1E: 8E E2 78       LDX    #$6A5A
6A21: 30 8A          LEAX   $8,X
6A23: AE A4          LDX    A,X
6A25: 96 FC          LDA    $7E
6A27: C6 20          LDB    #$08
6A29: 3D             MUL
6A2A: 3A             ABX
6A2B: 6D AC          TST    ,X
6A2D: 26 89          BNE    $6A30
6A2F: 39             RTS
6A30: DE 58          LDU    $7A
6A32: 11 A3 A6       CMPU   ,X
6A35: 27 86          BEQ    $6A3B
6A37: 0C 56          INC    $7E
6A39: 20 5A          BRA    $6A0D
6A3B: C6 2B          LDB    #$03
6A3D: 30 8A          LEAX   $2,X
6A3F: A6 A2          LDA    ,X+
6A41: A7 42          STA    ,U+
6A43: 5A             DECB
6A44: 26 DB          BNE    $6A3F
6A46: C6 81          LDB    #$03
6A48: DE 52          LDU    $7A
6A4A: 33 41 D4 28    LEAU   -$0400,U
6A4E: A6 08          LDA    ,X+
6A50: A7 E2          STA    ,U+
6A52: 5A             DECB
6A53: 26 DB          BNE    $6A4E
6A55: 0C F5          INC    $77
6A57: 0C 5F          INC    $77
6A59: 39             RTS



6D50: 22 22          BHI    $6D52
6D52: 0D D3          TST    $51
6D54: 26 2E          BNE    $6D62
6D56: 5F             CLRB
6D57: BD 40 B7       JSR    $689F
6D5A: D6 AB          LDB    $23
6D5C: 8E 67 E8       LDX    #$4F60
6D5F: 7E 4A 45       JMP    $6867
6D62: C6 86          LDB    #$04
6D64: 7E 4A 1D       JMP    $689F
6D67: 8E 64 74       LDX    #$4C5C
6D6A: 86 98          LDA    #$10
6D6C: C6 3C          LDB    #$14
6D6E: A7 0C          STA    ,X
6D70: A7 23          STA    $1,X
6D72: 30 0A 02       LEAX   $20,X
6D75: 5A             DECB
6D76: 26 74          BNE    $6D6E
6D78: D6 E8          LDB    $C0
6D7A: 27 AB          BEQ    $6D9F
6D7C: 8E 64 D4       LDX    #$4C5C
6D7F: 8D 3D          BSR    $6DA0
6D81: 5A             DECB
6D82: C1 84          CMPB   #$06
6D84: 23 33          BLS    $6D97
6D86: 5C             INCB
6D87: 96 85          LDA    $AD
6D89: 34 8A          PSHS   A
6D8B: 86 37          LDA    #$1F
6D8D: 97 25          STA    $AD
6D8F: BD 4A 45       JSR    $6867
6D92: 35 80          PULS   A
6D94: 97 8F          STA    $AD
6D96: 39             RTS
6D97: 5D             TSTB
6D98: 27 2D          BEQ    $6D9F
6D9A: 8D 8C          BSR    $6DA0
6D9C: 5A             DECB
6D9D: 20 70          BRA    $6D97
6D9F: 39             RTS
6DA0: 34 66          PSHS   U,B
6DA2: CE 92 32       LDU    #$1010
6DA5: CC 76 77       LDD    #$F4F5
6DA8: ED AC          STD    ,X
6DAA: EF 01 D4 28    STU    -$0400,X
6DAE: 30 00 02       LEAX   $20,X
6DB1: CC 74 75       LDD    #$F6F7
6DB4: ED A6          STD    ,X
6DB6: EF 0B D4 28    STU    -$0400,X
6DBA: 30 00 08       LEAX   $20,X
6DBD: 35 4C          PULS   B,U,PC
6DBF: C6 20          LDB    #$02
6DC1: BD EA 1D       JSR    $689F
6DC4: D6 E3          LDB    $C1
6DC6: 5C             INCB
6DC7: 8E 65 16       LDX    #$4D3E
6DCA: 96 25          LDA    $AD
6DCC: 97 58          STA    $70
6DCE: 86 90          LDA    #$18
6DD0: 97 8F          STA    $AD
6DD2: BD EA 45       JSR    $6867
6DD5: 96 F2          LDA    $70
6DD7: 97 85          STA    $AD
6DD9: 39             RTS
6DDA: C6 89          LDB    #$01
6DDC: BD 40 17       JSR    $689F
6DDF: C6 27          LDB    #$05
6DE1: D7 F2          STB    $70
6DE3: 0F 53          CLR    $71
6DE5: 96 F3          LDA    $71
6DE7: 48             ASLA
6DE8: 48             ASLA
6DE9: 9B F9          ADDA   $71
6DEB: 10 8E 46 91    LDY    #$6E19
6DEF: 31 84          LEAY   A,Y
6DF1: EE 23          LDU    ,Y++
6DF3: AE 83          LDX    ,Y++
6DF5: E6 26          LDB    ,Y
6DF7: 34 7C          PSHS   U,X,B
6DF9: BD EF F5       JSR    $677D
6DFC: 35 7C          PULS   B,X,U
6DFE: 96 25          LDA    $AD
6E00: 97 50          STA    $72
6E02: D7 2F          STB    $AD
6E04: 30 AB 83 A2    LEAX   $0120,X
6E08: E6 6B          LDB    $3,U
6E0A: 5C             INCB
6E0B: BD 40 4F       JSR    $6867
6E0E: 96 FA          LDA    $72
6E10: 97 8F          STA    $AD
6E12: 0C F3          INC    $71
6E14: 0A 52          DEC    $70
6E16: 26 4F          BNE    $6DE5
6E18: 39             RTS
6E19: 79 E8 C5       ROL    $604D
6E1C: 85 29          BITA   #$01
6E1E: D9 E0          ADCB   $68
6E20: 6F 89          CLR    D,Y
6E22: 80 D3          SUBA   #$51
6E24: 52             XNCB
6E25: 6F 2B 81 79    CLR    $0351,Y
6E29: 50             NEGB
6E2A: C5 2F          BITB   #$A7
6E2C: 2C 79          BGE    $6E7F
6E2E: 08 C5          ASL    $4D
6E30: 87 2A          XSTA   #$08
6E32: CE D2 BB       LDU    #$5099
6E35: 8E CC 3F       LDX    #$4EBD
6E38: 10 BE CC E7    LDY    $446F
6E3C: BD 4F F5       JSR    $677D
6E3F: 10 BF 66 ED    STY    $446F
6E43: FC 66 4C       LDD    $446E
6E46: 5A             DECB
6E47: BE 6C 47       LDX    $446F
6E4A: C6 8B          LDB    #$03
6E4C: 16 D2 D8       LBRA   $689F
6E4F: 0D 74          TST    $56
6E51: 26 99          BNE    $6E6E
6E53: C6 27          LDB    #$05
6E55: BD EA 1D       JSR    $689F
6E58: BE 46 16       LDX    $6E9E
6E5B: 30 A1 2A 88    LEAX   $0200,X
6E5F: CE 72 52       LDU    #$5070
6E62: DC DB          LDD    $59
6E64: DD 52          STD    $70
6E66: 0F F0          CLR    $72
6E68: C6 26          LDB    #$0E
6E6A: BD EF 55       JSR    $677D
6E6D: 39             RTS
6E6E: C6 8E          LDB    #$06
6E70: BD 4A 1D       JSR    $689F
6E73: BE 4C 9E       LDX    $6EBC
6E76: 30 0B 2A 28    LEAX   $0200,X
6E7A: CE D8 58       LDU    #$5070
6E7D: DC D1          LDD    $59
6E7F: DD 52          STD    $70
6E81: 0F F0          CLR    $72
6E83: C6 2C          LDB    #$0E
6E85: BD E5 FF       JSR    $677D
6E88: BE 46 52       LDX    $6EDA
6E8B: 30 A1 2A 88    LEAX   $0200,X
6E8F: CE 72 52       LDU    #$5070
6E92: DC D5          LDD    $57
6E94: DD 52          STD    $70
6E96: 0F F0          CLR    $72
6E98: C6 26          LDB    #$0E
6E9A: BD EF 55       JSR    $677D
6E9D: 39             RTS

6EF8: 0D 0A          TST    $22
6EFA: 26 8C          BNE    $6F00
6EFC: 0F 67          CLR    $4F
6EFE: 0F 4A          CLR    $C2
6F00: 8E 72 42       LDX    #$50C0
6F03: 10 8E 95 4E    LDY    #$B7CC
6F07: C6 08          LDB    #$20
6F09: A6 28          LDA    ,Y+
6F0B: A7 A8          STA    ,X+
6F0D: 5A             DECB
6F0E: 26 71          BNE    $6F09
6F10: DC 7B          LDD    $59
6F12: DD 4B          STD    $C9
6F14: 96 72          LDA    $50
6F16: 97 42          STA    $C0
6F18: 8D 39          BSR    $6F2B
6F1A: 8E D8 E8       LDX    #$50C0
6F1D: 10 8E D0 22    LDY    #$5800
6F21: EC 03          LDD    ,X++
6F23: ED 83          STD    ,Y++
6F25: 8C D2 6D       CMPX   #$50EF
6F28: 25 DF          BCS    $6F21
6F2A: 39             RTS
6F2B: CE 70 28       LDU    #$5800
6F2E: 4F             CLRA
6F2F: 5F             CLRB
6F30: 8E 22 82       LDX    #$0000
6F33: 31 A6          LEAY   ,X
6F35: 36 B4          PSHU   Y,X,D
6F37: 36 1E          PSHU   Y,X,D
6F39: 36 9E          PSHU   X,D
6F3B: 11 83 7A 88    CMPU   #$5200
6F3F: 22 D6          BHI    $6F35
6F41: 8E D2 62       LDX    #$50E0
6F44: 86 32          LDA    #$10
6F46: 6F 02          CLR    ,X+
6F48: 4A             DECA
6F49: 26 73          BNE    $6F46
6F4B: 7F 79 C8       CLR    $51E0
6F4E: 30 2C          LEAX   ,Y
6F50: CE 62 22       LDU    #$40A0
6F53: 36 14          PSHU   Y,X,D
6F55: 36 B4          PSHU   Y,X,D
6F57: 36 3E          PSHU   X,D
6F59: 11 83 C8 68    CMPU   #$4040
6F5D: 22 7C          BHI    $6F53
6F5F: CC 6E 22       LDD    #$4C00
6F62: FD C2 E2       STD    $40C0
6F65: FD C2 62       STD    $40E0
6F68: 8E 90 84       LDX    #$B80C
6F6B: 96 E9          LDA    $C1
6F6D: 81 8F          CMPA   #$07
6F6F: 23 20          BLS    $6F73
6F71: 30 8A          LEAX   $8,X
6F73: 84 25          ANDA   #$07
6F75: 48             ASLA
6F76: 10 AE AE       LDY    A,X
6F79: 8E D8 08       LDX    #$5080
6F7C: EC 89          LDD    ,Y++
6F7E: ED 09          STD    ,X++
6F80: 8C 72 22       CMPX   #$50A0
6F83: 25 D5          BCS    $6F7C
6F85: 8E D0 82       LDX    #$5200
6F88: EC 89          LDD    ,Y++
6F8A: ED 09          STD    ,X++
6F8C: 8C 7A 37       CMPX   #$52BF
6F8F: 25 D5          BCS    $6F88
6F91: 8E D0 42       LDX    #$52C0
6F94: EC 83          LDD    ,Y++
6F96: ED 03          STD    ,X++
6F98: 8C 7B B7       CMPX   #$533F
6F9B: 23 DF          BLS    $6F94
6F9D: 8E DB C8       LDX    #$5340
6FA0: C6 02          LDB    #$20
6FA2: A6 22          LDA    ,Y+
6FA4: A7 A2          STA    ,X+
6FA6: 5A             DECB
6FA7: 26 D1          BNE    $6FA2
6FA9: 31 20 68       LEAY   -$20,Y
6FAC: 8C 7B 17       CMPX   #$539F
6FAF: 25 CD          BCS    $6FA0
6FB1: 31 2A A2       LEAY   $20,Y
6FB4: 8E 76 82       LDX    #$5400
6FB7: C6 08          LDB    #$20
6FB9: A6 28          LDA    ,Y+
6FBB: A7 A8          STA    ,X+
6FBD: 5A             DECB
6FBE: 26 71          BNE    $6FB9
6FC0: 31 8A 62       LEAY   -$20,Y
6FC3: 8C 77 7D       CMPX   #$555F
6FC6: 25 6D          BCS    $6FB7
6FC8: 31 80 A8       LEAY   $20,Y
6FCB: 8E 7E 28       LDX    #$5600
6FCE: EC 29          LDD    ,Y++
6FD0: ED A3          STD    ,X++
6FD2: 8C D4 3D       CMPX   #$561F
6FD5: 25 75          BCS    $6FCE
6FD7: 8E 7E A8       LDX    #$5680
6FDA: EC 29          LDD    ,Y++
6FDC: ED A9          STD    ,X++
6FDE: 8C DE 9D       CMPX   #$56BF
6FE1: 25 75          BCS    $6FDA
6FE3: 8E 75 22       LDX    #$5700
6FE6: EC 23          LDD    ,Y++
6FE8: ED A9          STD    ,X++
6FEA: 8C DF B7       CMPX   #$579F
6FED: 25 7F          BCS    $6FE6
6FEF: 8E 75 E2       LDX    #$57C0
6FF2: EC 23          LDD    ,Y++
6FF4: ED A3          STD    ,X++
6FF6: 8C D5 C7       CMPX   #$57EF
6FF9: 25 7F          BCS    $6FF2
6FFB: 86 36          LDA    #$1E
6FFD: 97 4A          STA    $C2
6FFF: 96 E3          LDA    $C1
7001: 81 8D          CMPA   #$0F
7003: 22 28          BHI    $700F
7005: 84 8D          ANDA   #$0F
7007: 9B 7D          ADDA   $55
7009: 81 96          CMPA   #$1E
700B: 22 2A          BHI    $700F
700D: 97 4A          STA    $C2
700F: 0D 00          TST    $22
7011: 26 86          BNE    $7017
7013: 0F E0          CLR    $C2
7015: 0F CD          CLR    $4F
7017: 96 EA          LDA    $C2
7019: 84 94          ANDA   #$1C
701B: 44             LSRA
701C: 1F A1          TFR    A,B
701E: 8B B4          ADDA   #$3C
7020: CB 0A          ADDB   #$28
7022: DD DE          STD    $5C
7024: 58             ASLB
7025: 48             ASLA
7026: DD DC          STD    $5E
7028: 0D 0A          TST    $22
702A: 27 AB          BEQ    $704F
702C: 8E 7A 88       LDX    #$5200
702F: 96 E0          LDA    $C2
7031: D6 AD          LDB    $2F
7033: C4 5A          ANDB   #$78
7035: C1 E2          CMPB   #$60
7037: 24 2E          BCC    $703F
7039: D6 4A          LDB    $C2
703B: 44             LSRA
703C: 54             LSRB
703D: 92 A9          SBCA   $21
703F: D6 E0          LDB    $C2
7041: AB 8A          ADDA   $8,X
7043: EB 2B          ADDB   $9,X
7045: ED 8A          STD    $8,X
7047: 30 A0 08       LEAX   $20,X
704A: 8C DA 97       CMPX   #$52BF
704D: 23 68          BLS    $702F
704F: 8E 70 22       LDX    #$5200
7052: C6 84          LDB    #$06
7054: D7 42          STB    $60
7056: 6D 06          TST    ,X
7058: 27 20          BEQ    $7062
705A: 10 AE 23       LDY    $B,X
705D: A6 87          LDA    $F,X
705F: BD 42 1F       JSR    $603D
7062: 30 0A 02       LEAX   $20,X
7065: 0A E2          DEC    $60
7067: 26 C5          BNE    $7056
7069: 8E DC 88       LDX    #$5400
706C: C6 23          LDB    #$0B
706E: D7 E8          STB    $60
7070: 10 AE 89       LDY    $B,X
7073: A6 2D          LDA    $F,X
7075: BD E2 BF       JSR    $603D
7078: 30 A0 A8       LEAX   $20,X
707B: 0A 48          DEC    $60
707D: 26 79          BNE    $7070
707F: 8E 71 62       LDX    #$5340
7082: C6 81          LDB    #$03
7084: D7 42          STB    $60
7086: 10 AE 23       LDY    $B,X
7089: A6 87          LDA    $F,X
708B: BD 48 15       JSR    $603D
708E: 30 00 02       LEAX   $20,X
7091: 0A E2          DEC    $60
7093: 26 D3          BNE    $7086
7095: 8E D4 82       LDX    #$5600
7098: 10 AE 83       LDY    $B,X
709B: A6 27          LDA    $F,X
709D: 7E E8 B5       JMP    $603D
70A0: 4F             CLRA
70A1: B7 02 05       STA    mainlatch_8087
70A4: B7 A2 82       STA    watchdog_8000
70A7: 0C 67          INC    $4F
70A9: 8D A9          BSR    $70CC
70AB: BD 5A 62       JSR    $724A
70AE: BD FA 4D       JSR    $726F
70B1: BD F0 7E       JSR    $72FC
70B4: 96 20          LDA    $02
70B6: 48             ASLA
70B7: 8E 58 EA       LDX    #jump_table_70c2
70BA: AD 1E          JSR    [A,X]        ; [indirect_jump]
70BC: 86 29          LDA    #$01
70BE: B7 08 A5       STA    mainlatch_8087
70C1: 3B             RTI
70C2: F1 A3 51       CMPB   $2173
70C5: 11 F6 EA 5D    LDB    $6875
70C9: 4F             CLRA
70CA: FD F0 34       STD    $781C
70CD: 20 86          BRA    $70DD
70CF: C8 1F          EORB   #$3D
70D1: A9 96          ADCA   -$C,X
70D3: C1 D6          CMPB   #$F4
70D5: 62 DD          XNC    -$1,U
70D7: 82 DC          SBCA   #$F4
70D9: 69 FD          ROL    -$B,S
70DB: CC 28 96       LDD    #$00BE
70DE: CF D6 66       XSTU   #$5E44
70E1: DD 80          STD    $02
70E3: DC 67          LDD    $45
70E5: FD C6 80       STD    $4402
70E8: 96 63          LDA    $4B
70EA: D6 C0          LDB    $48
70EC: DD 2C          STD    $04
70EE: DC C1          LDD    $49
70F0: FD 66 86       STD    $4404
70F3: 96 6D          LDA    $4F
70F5: D6 CE          LDB    $4C
70F7: DD 2E          STD    $06
70F9: DC C5          LDD    $4D
70FB: FD 6C 2E       STD    $4406
70FE: 96 DB          LDA    $53
7100: D6 72          LDB    $50
7102: DD 8A          STD    $08
7104: DC 73          LDD    $51
7106: FD C6 20       STD    $4408
7109: 96 DF          LDA    $57
710B: D6 7C          LDB    $54
710D: DD 82          STD    $0A
710F: DC 77          LDD    $55
7111: FD C6 88       STD    $440A
7114: 96 79          LDA    $5B
7116: D6 DA          LDB    $58
7118: DD 24          STD    $0C
711A: DC D1          LDD    $59
711C: FD 6C 84       STD    $440C
711F: 96 7D          LDA    $5F
7121: D6 DE          LDB    $5C
7123: DD 2C          STD    $0E
7125: DC DF          LDD    $5D
7127: FD 6C 26       STD    $440E
712A: 96 EB          LDA    $63
712C: D6 48          LDB    $60
712E: DD 98          STD    $10
7130: DC 43          LDD    $61
7132: FD C6 32       STD    $4410
7135: 96 E5          LDA    $67
7137: D6 4C          LDB    $64
7139: DD 9A          STD    $12
713B: DC 4D          LDD    $65
713D: FD CC 9A       STD    $4412
7140: 96 49          LDA    $6B
7142: D6 EA          LDB    $68
7144: DD 36          STD    $14
7146: DC EB          LDD    $69
7148: FD 6C 9C       STD    $4414
714B: 96 47          LDA    $6F
714D: D6 E4          LDB    $6C
714F: DD 34          STD    $16
7151: DC EF          LDD    $6D
7153: FD 66 34       STD    $4416
7156: 96 F1          LDA    $73
7158: D6 58          LDB    $70
715A: DD 90          STD    $18
715C: DC 59          LDD    $71
715E: FD CC 3A       STD    $4418
7161: 96 F5          LDA    $77
7163: D6 56          LDB    $74
7165: DD 98          STD    $1A
7167: DC 5D          LDD    $75
7169: FD CC 92       STD    $441A
716C: 96 53          LDA    $7B
716E: D6 F0          LDB    $78
7170: DD 3E          STD    $1C
7172: DC FB          LDD    $79
7174: FD 66 9E       STD    $441C
7177: 96 57          LDA    $7F
7179: D6 F4          LDB    $7C
717B: DD 36          STD    $1E
717D: DC F5          LDD    $7D
717F: FD 66 3C       STD    $441E
7182: 96 01          LDA    $83
7184: D6 A2          LDB    $80
7186: DD A2          STD    $20
7188: DC A9          LDD    $81
718A: FD CC 08       STD    $4420
718D: 96 0F          LDA    $87
718F: D6 A6          LDB    $84
7191: DD A0          STD    $22
7193: DC A7          LDD    $85
7195: FD C6 A0       STD    $4422
7198: 96 A3          LDA    $8B
719A: D6 00          LDB    $88
719C: DD 0C          STD    $24
719E: DC 01          LDD    $89
71A0: FD 66 A6       STD    $4424
71A3: 96 AD          LDA    $8F
71A5: D6 0E          LDB    $8C
71A7: DD 0E          STD    $26
71A9: DC 05          LDD    $8D
71AB: FD 6C 0E       STD    $4426
71AE: 96 1B          LDA    $93
71B0: D6 B2          LDB    $90
71B2: DD AA          STD    $28
71B4: DC B3          LDD    $91
71B6: FD C6 00       STD    $4428
71B9: 96 1F          LDA    $97
71BB: D6 BC          LDB    $94
71BD: DD A2          STD    $2A
71BF: DC B7          LDD    $95
71C1: FD C6 A8       STD    $442A
71C4: 96 B9          LDA    $9B
71C6: D6 1A          LDB    $98
71C8: DD 04          STD    $2C
71CA: DC 11          LDD    $99
71CC: FD 6C A4       STD    $442C
71CF: 96 BD          LDA    $9F
71D1: D6 1E          LDB    $9C
71D3: DD 0C          STD    $2E
71D5: DC 1F          LDD    $9D
71D7: FD 6C 06       STD    $442E
71DA: 0D B7          TST    $3F
71DC: 27 42          BEQ    $7248
71DE: DE 48          LDU    $C0
71E0: 10 9E 5C       LDY    $DE
71E3: 9E FE          LDX    $DC
71E5: DC 58          LDD    $DA
71E7: 36 1E          PSHU   Y,X,D
71E9: 10 9E 50       LDY    $D8
71EC: 9E FE          LDX    $D6
71EE: DC 5C          LDD    $D4
71F0: 36 14          PSHU   Y,X,D
71F2: 9E 50          LDX    $D2
71F4: DC F2          LDD    $D0
71F6: 36 96          PSHU   X,B
71F8: 33 E0 67       LEAU   -$11,U
71FB: 36 2A          PSHU   A
71FD: 10 9E 46       LDY    $CE
7200: 9E EE          LDX    $CC
7202: DC 48          LDD    $CA
7204: 36 14          PSHU   Y,X,D
7206: 10 9E E0       LDY    $C8
7209: 9E 4E          LDX    $C6
720B: DC EC          LDD    $C4
720D: 36 BE          PSHU   Y,X,D
720F: DC E0          LDD    $C2
7211: 36 84          PSHU   D
7213: DE C2          LDU    $E0
7215: 10 9E 7C       LDY    $FE
7218: 9E D4          LDX    $FC
721A: DC 72          LDD    $FA
721C: 36 1E          PSHU   Y,X,D
721E: 10 9E DA       LDY    $F8
7221: 9E 74          LDX    $F6
7223: DC D6          LDD    $F4
7225: 36 B4          PSHU   Y,X,D
7227: 9E DA          LDX    $F2
7229: DC 78          LDD    $F0
722B: 36 3C          PSHU   X,B
722D: 33 40 67       LEAU   -$11,U
7230: 36 20          PSHU   A
7232: 10 9E CC       LDY    $EE
7235: 9E 6E          LDX    $EC
7237: DC C2          LDD    $EA
7239: 36 BE          PSHU   Y,X,D
723B: 10 9E C0       LDY    $E8
723E: 9E 6E          LDX    $E6
7240: DC C6          LDD    $E4
7242: 36 B4          PSHU   Y,X,D
7244: DC C0          LDD    $E2
7246: 36 84          PSHU   D
7248: 35 A0          PULS   DP,PC
724A: 96 BF          LDA    $37
724C: 97 10          STA    $38
724E: 96 BC          LDA    $34
7250: 97 15          STA    $37
7252: 96 B3          LDA    $31
7254: 97 16          STA    $34
7256: 96 B0          LDA    $32
7258: 97 1D          STA    $35
725A: 96 BB          LDA    $33
725C: 97 1E          STA    $36
725E: B6 B8 A2       LDA    system_3080
7261: 43             COMA
7262: 97 B3          STA    $31
7264: B6 12 03       LDA    port1_3081
7267: 43             COMA
7268: F6 18 0A       LDB    port2_3082
726B: 53             COMB
726C: DD 1A          STD    $32
726E: 39             RTS
726F: 0D 04          TST    $26
7271: 27 8C          BEQ    $7281
7273: 0A 04          DEC    $26
7275: 96 A4          LDA    $26
7277: 81 2C          CMPA   #$04
7279: 26 91          BNE    $7294
727B: 5F             CLRB
727C: F7 A8 0B       STB    $8083
727F: 20 31          BRA    $7294
7281: 0D A6          TST    $24
7283: 27 2D          BEQ    $7294
7285: 0D A4          TST    $26
7287: 26 23          BNE    $7294
7289: 0A AC          DEC    $24
728B: C6 29          LDB    #$01
728D: F7 08 0B       STB    $8083
7290: C6 2A          LDB    #$08
7292: D7 A4          STB    $26
7294: 0D 09          TST    $2B
7296: 27 8C          BEQ    $72A6
7298: 0A 03          DEC    $2B
729A: 96 A3          LDA    $2B
729C: 81 2C          CMPA   #$04
729E: 26 91          BNE    $72B9
72A0: 5F             CLRB
72A1: F7 02 06       STB    $8084
72A4: 20 31          BRA    $72B9
72A6: 0D AB          TST    $29
72A8: 27 27          BEQ    $72B9
72AA: 0D A3          TST    $2B
72AC: 26 23          BNE    $72B9
72AE: 0A A1          DEC    $29
72B0: C6 23          LDB    #$01
72B2: F7 02 A6       STB    $8084
72B5: C6 8A          LDB    #$08
72B7: D7 03          STB    $2B
72B9: 96 B9          LDA    $31
72BB: 9A 1C          ORA    $34
72BD: 43             COMA
72BE: 94 BF          ANDA   $37
72C0: 94 1A          ANDA   $38
72C2: 84 85          ANDA   #$07
72C4: 27 2D          BEQ    $72D5
72C6: 8D 81          BSR    $72CB
72C8: 7E 53 9C       JMP    $7B14
72CB: 85 29          BITA   #$01
72CD: 26 8F          BNE    $72D6
72CF: 85 20          BITA   #$02
72D1: 26 94          BNE    $72E9
72D3: 0C 01          INC    $23
72D5: 39             RTS
72D6: 0C A6          INC    $24
72D8: 0C 0D          INC    $25
72DA: 96 AD          LDA    $25
72DC: 91 0F          CMPA   $27
72DE: 26 7D          BNE    $72D5
72E0: 96 0A          LDA    $28
72E2: 9B A1          ADDA   $23
72E4: 97 01          STA    $23
72E6: 0F A7          CLR    $25
72E8: 39             RTS
72E9: 0C A1          INC    $29
72EB: 0C 02          INC    $2A
72ED: 96 A2          LDA    $2A
72EF: 91 0E          CMPA   $2C
72F1: 26 60          BNE    $72D5
72F3: 96 0F          LDA    $2D
72F5: 9B A1          ADDA   $23
72F7: 97 0B          STA    $23
72F9: 0F A2          CLR    $2A
72FB: 39             RTS
72FC: 9E 36          LDX    $1E
72FE: 9C 94          CMPX   $1C
7300: 26 23          BNE    $7303
7302: 39             RTS
7303: A6 A2          LDA    ,X+
7305: B7 03 82       STA    audio_8100
7308: 4F             CLRA
7309: B7 08 09       STA    $8081
730C: 12             NOP
730D: 12             NOP
730E: 12             NOP
730F: 12             NOP
7310: 12             NOP
7311: 12             NOP
7312: 4C             INCA
7313: B7 A2 A3       STA    $8081
7316: 8C D3 77       CMPX   #$515F
7319: 23 8B          BLS    $731E
731B: 8E 79 68       LDX    #$5140
731E: 9F 96          STX    $1E
7320: 39             RTS
7321: 86 83          LDA    #$01
7323: B7 A2 A2       STA    $8080
7326: 0F 87          CLR    $05
7328: 0F 20          CLR    $08
732A: 0F 83          CLR    $0B
732C: 0F 26          CLR    $0E
732E: 0F AA          CLR    $22
7330: 0C 20          INC    $02
7332: 39             RTS
7333: 96 27          LDA    $05
7335: 48             ASLA
7336: 8E F1 62       LDX    #jump_table_734a
7339: AD 1E          JSR    [A,X]        ; [indirect_jump]
733B: 0D 0B          TST    $23
733D: 26 8C          BNE    $7343
733F: 0D 73          TST    $51
7341: 27 84          BEQ    $7349
7343: 0F 27          CLR    $05
7345: 0F 8A          CLR    $08
7347: 0C 2A          INC    $02
7349: 39             RTS
734A: FB DC 5B       ADDB   $5473
734D: 77 FB 6E       ASR    $73E6
7350: 56             RORB
7351: 71 F6 D8       NEG    $745A
7354: 4F             CLRA
7355: 5F             CLRB
7356: DD C2          STD    $40
7358: D7 6A          STB    $42
735A: 0C 8D          INC    $05
735C: 0F 20          CLR    $08
735E: 39             RTS
735F: 96 2A          LDA    $08
7361: 48             ASLA
7362: 10 8E 51 4A    LDY    #jump_table_7368
7366: 6E 34          JMP    [A,Y]	; [indirect_jump]

736A: FB F1 CC       ADDB   $79E4
736D: 28 98          BVC    $737F
736F: BD 42 2A       JSR    $6008
7372: 86 83          LDA    #$01
7374: 97 94          STA    $B6
7376: 0C 8A          INC    $08
7378: 39             RTS
7379: 0D 3E          TST    $B6
737B: 26 40          BNE    $73E5
737D: CC 8B 89       LDD    #$0301
7380: BD 42 8A       JSR    $6008
7383: CC 20 32       LDD    #$0210
7386: BD E2 20       JSR    $6008
7389: CC 89 8E       LDD    #$0106
738C: BD 48 80       JSR    $6008
738F: CC 28 22       LDD    #$0A00
7392: BD E2 2A       JSR    $6008
7395: CC 83 8A       LDD    #$0108
7398: BD 48 80       JSR    $6008
739B: CC 2A B8       LDD    #$0290
739E: BD E8 2A       JSR    $6008
73A1: CC 83 8B       LDD    #$0109
73A4: BD 42 8A       JSR    $6008
73A7: CC 2A 38       LDD    #$0210
73AA: BD E8 20       JSR    $6008
73AD: CC 89 86       LDD    #$010E
73B0: BD 42 8A       JSR    $6008
73B3: CC 20 30       LDD    #$0212
73B6: BD E2 20       JSR    $6008
73B9: CC 89 82       LDD    #$010A
73BC: BD 48 80       JSR    $6008
73BF: CC 20 3A       LDD    #$0218
73C2: BD E2 2A       JSR    $6008
73C5: CC 83 89       LDD    #$010B
73C8: BD 48 80       JSR    $6008
73CB: CC 29 24       LDD    #$010C
73CE: BD E8 2A       JSR    $6008
73D1: CC 80 9C       LDD    #$021E
73D4: BD 42 8A       JSR    $6008
73D7: CC 29 2F       LDD    #$0107
73DA: BD E8 20       JSR    $6008
73DD: 0C 8D          INC    $05
73DF: 0F 2A          CLR    $08
73E1: 86 4A          LDA    #$C8
73E3: 97 26          STA    $04
73E5: 39             RTS
73E6: 96 8A          LDA    $08
73E8: 48             ASLA
73E9: 10 8E FB C7    LDY    #jump_table_73ef
73ED: 6E 3E          JMP    [A,Y]        ; [indirect_jump]
73EF: FB D1 56       ADDB   $F374
73F2: 86 0A          LDA    #$88
73F4: 26 26          BNE    $73FA
73F6: 8E 86 29       LDX    #$0401
73F9: 97 3E          STA    $B6
73FB: CC 28 38       LDD    #$0010
73FE: BD E8 2A       JSR    $6008
7401: 0C 8A          INC    $08
7403: 39             RTS
7404: 0D 94          TST    $B6
7406: 26 C8          BNE    $7452
7408: CC 2B 89       LDD    #$0301
740B: BD 48 20       JSR    $6008
740E: CC 8A 3D       LDD    #$021F
7411: BD E2 8A       JSR    $6008
7414: CC 20 12       LDD    #$0290
7417: BD 48 20       JSR    $6008
741A: CC 89 21       LDD    #$0109
741D: BD E8 80       JSR    $6008
7420: CC 20 92       LDD    #$0210
7423: BD 42 2A       JSR    $6008
7426: CC 83 26       LDD    #$010E
7429: BD E8 80       JSR    $6008
742C: CC 2A 89       LDD    #$0201
742F: BD 42 2A       JSR    $6008
7432: CC 8F 22       LDD    #$0D00
7435: BD E2 8A       JSR    $6008
7438: CC 29 85       LDD    #$010D
743B: BD 48 20       JSR    $6008
743E: CC 82 22       LDD    #$0A00
7441: BD E2 8A       JSR    $6008
7444: CC 23 85       LDD    #$0107
7447: BD 48 20       JSR    $6008
744A: 86 40          LDA    #$C8
744C: 97 2C          STA    $04
744E: 0C 8D          INC    $05
7450: 0F 2A          CLR    $08
7452: 39             RTS
7453: 0A 26          DEC    $04
7455: 26 80          BNE    $7459
7457: 0C 2D          INC    $05
7459: 39             RTS
745A: 0F C8          CLR    $40
745C: 0F 69          CLR    $41
745E: 0F CA          CLR    $42
7460: 0F 61          CLR    $43
7462: 86 82          LDA    #$00
7464: BD F6 2C       JSR    $D4AE
7467: 39             RTS
7468: 96 2D          LDA    $05
746A: 48             ASLA
746B: 8E 5C E9       LDX    #jump_table_74c1
746E: AD 1E          JSR    [A,X]        ; [indirect_jump]
7470: 96 13          LDA    $31
7472: 85 8A          BITA   #$08
7474: 26 19          BNE    $74B1
7476: 85 92          BITA   #$10
7478: 27 6E          BEQ    $74C0
747A: 0D D9          TST    $51
747C: 26 22          BNE    $7488
747E: 96 AB          LDA    $23
7480: 81 20          CMPA   #$02
7482: 25 BE          BCS    $74C0
7484: 80 20          SUBA   #$02
7486: 97 A1          STA    $23
7488: CC 28 89       LDD    #$0001
748B: DD 08          STD    $20
748D: 86 89          LDA    #$01
748F: 97 00          STA    $22
7491: BD EC 7A       JSR    $6EF8
7494: BD 59 42       JSR    $7BC0
7497: CC 29 A8       LDD    #$0180
749A: DD 8E          STD    $06
749C: CC 2D 89       LDD    #$0501
749F: BD 42 2A       JSR    $6008
74A2: 5C             INCB
74A3: BD 42 2A       JSR    $6008
74A6: 0F 87          CLR    $05
74A8: 0F 20          CLR    $08
74AA: 0F 83          CLR    $0B
74AC: 0F 26          CLR    $0E
74AE: 0C 8A          INC    $02
74B0: 39             RTS
74B1: CC 82 82       LDD    #$0000
74B4: 0D 73          TST    $51
74B6: 26 51          BNE    $748B
74B8: 0D 0B          TST    $23
74BA: 27 8C          BEQ    $74C0
74BC: 0A 0B          DEC    $23
74BE: 20 43          BRA    $748B
74C0: 39             RTS

74C3: F7 3A 57       STB    $1875
74C6: BA F7 76       ORA    $755E
74C9: 96 80          LDA    $08
74CB: 48             ASLA
74CC: 10 8E FC 5A    LDY    #jump_table_74d2
74D0: 6E 94          JMP    [A,Y]        ; [indirect_jump]
74D2: F6 54 57       LDB    $D675
74D5: 27 0D          BEQ    $7466
74D7: 34 26          PSHS   DP,D
74D9: 02 86          XNC    $0E
74DB: 89 B7          ADCA   #$9F
74DD: A8 08          EORA   ,X+
74DF: 8E 62 62       LDX    #$4040
74E2: CC 82 22       LDD    #$0000
74E5: ED 03          STD    ,X++
74E7: 8C 68 B7       CMPX   #$409F
74EA: 23 71          BLS    $74E5
74EC: CC 2A 8B       LDD    #$0203
74EF: BD 42 2A       JSR    $6008
74F2: CC 81 20       LDD    #$0302
74F5: BD E2 8A       JSR    $6008
74F8: CC 28 98       LDD    #$0010
74FB: BD 48 20       JSR    $6008
74FE: 86 89          LDA    #$01
7500: 97 94          STA    $B6
7502: 0C 8A          INC    $08
7504: 39             RTS
7505: 0D 34          TST    $B6
7507: 26 26          BNE    $7517
7509: CC 8F 88       LDD    #$0700
750C: BD 48 80       JSR    $6008
750F: 86 2A          LDA    #$08
7511: 97 86          STA    $04
7513: 0C 27          INC    $05
7515: 0F 8A          CLR    $08
7517: 39             RTS
7518: 0A 2C          DEC    $04
751A: 27 89          BEQ    $751D
751C: 39             RTS
751D: CC 8A 80       LDD    #$0208
7520: BD 42 8A       JSR    $6008
7523: CC 23 21       LDD    #$0103
7526: BD E2 20       JSR    $6008
7529: CC 89 8F       LDD    #$0107
752C: BD 48 80       JSR    $6008
752F: CC 2D 22       LDD    #$0F00
7532: BD E2 2A       JSR    $6008
7535: 0C 87          INC    $05
7537: 39             RTS
7538: 0C 2D          INC    $05
753A: CC 8B 29       LDD    #$0301
753D: BD E8 80       JSR    $6008
7540: CC 28 82       LDD    #$0A00
7543: BD 42 2A       JSR    $6008
7546: 0D D3          TST    $51
7548: 26 20          BNE    $7552
754A: 96 AB          LDA    $23
754C: 97 7C          STA    $54
754E: 81 8A          CMPA   #$02
7550: 25 24          BCS    $7558
7552: CC 83 27       LDD    #$0105
7555: 7E E2 8A       JMP    $6008
7558: CC 29 8C       LDD    #$0104
755B: 7E 48 20       JMP    $6008
755E: 96 AB          LDA    $23
7560: 91 76          CMPA   $54
7562: 27 80          BEQ    $7566
7564: 0A 27          DEC    $05
7566: 39             RTS
7567: 96 2D          LDA    $05
7569: 48             ASLA
756A: 10 8E 5D 58    LDY    #jump_table_7570
756E: 6E 3E          JMP    [A,Y]        ; [indirect_jump]

7578: 96 2D          LDA    $05
757A: 48             ASLA
757B: 10 8E 5D 09    LDY    #jump_table_7581
757F: 6E 94          JMP    [A,Y]        ; [indirect_jump]

758C: 10 8E FD 1A    LDY    #jump_table_7592
7590: 6E 94          JMP    [A,Y]        ; [indirect_jump]

759D: 20 48          BRA    $755F
759F: 10 8E 57 27    LDY    #jump_table_75A5
75A3: 6E 94          JMP    [A,Y]        ; [indirect_jump]

75B2: 10 8E 57 9A    LDY    #jump_table_75b8
75B6: 6E 34          JMP    [A,Y]        ; [indirect_jump]

75BE: 96 83          LDA    $0B
75C0: 48             ASLA
75C1: 10 8E F7 E5    LDY    #jump_table_75C7
75C5: 6E 34          JMP    [A,Y]        ; [indirect_jump]

75CD: 96 86          LDA    $0E
75CF: 48             ASLA
75D0: 10 8E F7 54    LDY    #jump_table_75d6
75D4: 6E 94          JMP    [A,Y]        ; [indirect_jump]

75E3: 82 32          SBCA   #$10
75E5: BD E2 8A       JSR    $6008
75E8: 86 29          LDA    #$01
75EA: 97 3E          STA    $B6
75EC: 0C 26          INC    $0E
75EE: 39             RTS
75EF: 0D 94          TST    $B6
75F1: 26 80          BNE    $75F5
75F3: 0C 2C          INC    $0E
75F5: 39             RTS
75F6: 86 83          LDA    #$01
75F8: 7E FC 26       JMP    $D4AE
75FB: 9E 2E          LDX    $06
75FD: 27 92          BEQ    $7619
75FF: 30 3D          LEAX   -$1,X
7601: 9F 84          STX    $06
7603: 96 6D          LDA    $4F
7605: 85 9D          BITA   #$1F
7607: 26 3A          BNE    $761B
7609: 85 A8          BITA   #$20
760B: 26 2E          BNE    $7613
760D: CC 89 88       LDD    #$0100
7610: 7E 42 8A       JMP    $6008
7613: CC 23 A2       LDD    #$0180
7616: 7E E2 20       JMP    $6008
7619: 0C 83          INC    $0B
761B: 39             RTS
761C: CC 2A 89       LDD    #$0201
761F: BD 42 2A       JSR    $6008
7622: 0F A2          CLR    $20
7624: 86 23          LDA    #$01
7626: B7 02 A8       STA    $8080
7629: 0D A9          TST    $21
762B: 27 2E          BEQ    $7633
762D: CC 89 88       LDD    #$0100
7630: BD 42 8A       JSR    $6008
7633: 86 23          LDA    #$01
7635: 97 85          STA    $07
7637: 0C 20          INC    $08
7639: 0F 83          CLR    $0B
763B: 0F 26          CLR    $0E
763D: 39             RTS
763E: 96 86          LDA    $0E
7640: 48             ASLA
7641: 10 8E F4 65    LDY    #jump_table_7647
7645: 6E 34          JMP    [A,Y]        ; [indirect_jump]
7647: F4 65 5E       ANDB   $4D76
764A: E0 FE          SUBB   -$A,S
764C: 47             ASRA
764D: 0D DB          TST    $53
764F: 27 26          BEQ    $7655
7651: 4F             CLRA
7652: B7 02 A2       STA    $8080
7655: 86 83          LDA    #$01
7657: 97 9E          STA    $B6
7659: CC 88 98       LDD    #$0010
765C: BD 48 80       JSR    $6008
765F: CC 20 23       LDD    #$0201
7662: BD E2 2A       JSR    $6008
7665: 0C 8C          INC    $0E
7667: 39             RTS
7668: 0D 9E          TST    $B6
766A: 26 8A          BNE    $766E
766C: 0C 26          INC    $0E
766E: 39             RTS
766F: 86 23          LDA    #$01
7671: 7E 56 2C       JMP    $D4AE
7674: 9E 24          LDX    $06
7676: 27 98          BEQ    $7692
7678: 30 37          LEAX   -$1,X
767A: 9F 8E          STX    $06
767C: 96 67          LDA    $4F
767E: 85 97          BITA   #$1F
7680: 26 30          BNE    $7694
7682: 85 A2          BITA   #$20
7684: 26 24          BNE    $768C
7686: CC 83 29       LDD    #$0101
7689: 7E E8 80       JMP    $6008
768C: CC 29 09       LDD    #$0181
768F: 7E 42 2A       JMP    $6008
7692: 0C 89          INC    $0B
7694: 39             RTS
7695: CC 80 83       LDD    #$0201
7698: BD 48 80       JSR    $6008
769B: 86 29          LDA    #$01
769D: 97 A8          STA    $20
769F: CC 23 23       LDD    #$0101
76A2: BD E2 2A       JSR    $6008
76A5: 86 83          LDA    #$01
76A7: 97 2F          STA    $07
76A9: 0C 80          INC    $08
76AB: 0F 23          CLR    $0B
76AD: 0F 86          CLR    $0E
76AF: 39             RTS
76B0: 96 29          LDA    $0B
76B2: 48             ASLA
76B3: 10 8E 54 3B    LDY    #jump_table_76B9
76B7: 6E 9E          JMP    [A,Y]			; [indirect_jump]
76B9: 5E             XCLRB
76BA: 35 FE          PULS   D,X,Y,U
76BC: E6 0A          LDB    $2,Y
76BE: 8F 26 2E       XSTX   #$AE0C
76C1: CC 8A 82       LDD    #$0800
76C4: BD 42 8A       JSR    $6008
76C7: 86 29          LDA    #$01
76C9: 97 3E          STA    $B6
76CB: 0C 23          INC    $0B
76CD: 39             RTS
76CE: 0D 3E          TST    $B6
76D0: 26 3E          BNE    $76EE
76D2: 8D 99          BSR    $76EF
76D4: 8E 73 42       LDX    #$51C0
76D7: 10 AE 23       LDY    $B,X
76DA: A6 87          LDA    $F,X
76DC: BD 48 B5       JSR    $603D
76DF: 6F 28          CLR    $A,X
76E1: BD E2 95       JSR    $6017
76E4: 86 23          LDA    #$01
76E6: 97 85          STA    $07
76E8: 0C 20          INC    $08
76EA: 0F 83          CLR    $0B
76EC: 0F 26          CLR    $0E
76EE: 39             RTS
76EF: 0A E2          DEC    $C0
76F1: CC 89 82       LDD    #$0B00
76F4: BD 42 8A       JSR    $6008
76F7: CC 24 28       LDD    #$0C00
76FA: BD E8 20       JSR    $6008
76FD: CC 86 90       LDD    #$0E18
7700: BD 42 8A       JSR    $6008
7703: 8E 95 CE       LDX    #$B7EC
7706: 10 8E 79 E8    LDY    #$51C0
770A: EC 09          LDD    ,X++
770C: ED 89          STD    ,Y++
770E: 10 8C 73 C2    CMPY   #$51E0
7712: 25 74          BCS    $770A
7714: 39             RTS
7715: 0A 85          DEC    $07
7717: 26 3B          BNE    $772C
7719: BD F3 54       JSR    $7BDC
771C: 0F 20          CLR    $08
771E: 0C 8D          INC    $05
7720: CC 20 8E       LDD    #$020C
7723: BD 42 2A       JSR    $6008
7726: CC 81 2B       LDD    #$0303
7729: 7E E8 80       JMP    $6008
772C: 39             RTS
772D: 0F A8          CLR    $20
772F: 86 23          LDA    #$01
7731: B7 02 02       STA    $8080
7734: BD 4D A9       JSR    $6F2B
7737: 86 29          LDA    #$01
7739: 97 8F          STA    $07
773B: CC 28 38       LDD    #$0010
773E: BD E8 2A       JSR    $6008
7741: 86 83          LDA    #$01
7743: 97 94          STA    $B6
7745: 0C 8A          INC    $08
7747: 39             RTS
7748: 86 29          LDA    #$01
774A: 97 A8          STA    $20
774C: BD 47 A3       JSR    $6F2B
774F: 96 71          LDA    $53
7751: 27 86          BEQ    $7757
7753: 4F             CLRA
7754: B7 A2 02       STA    $8080
7757: 86 29          LDA    #$01
7759: 97 8F          STA    $07
775B: CC 28 38       LDD    #$0010
775E: BD E8 2A       JSR    $6008
7761: 86 83          LDA    #$01
7763: 97 94          STA    $B6
7765: 0C 8A          INC    $08
7767: 39             RTS
7768: 0D 9E          TST    $B6
776A: 26 81          BNE    $7775
776C: 0F 20          CLR    $08
776E: CC 8A 22       LDD    #$0200
7771: 97 89          STA    $0B
7773: D7 2C          STB    $0E
7775: 39             RTS
7776: DC 41          LDD    $C3
7778: C3 28 89       ADDD   #$0001
777B: DD EB          STD    $C3
777D: BD FF 07       JSR    $778F
7780: BD 94 59       JSR    $B6DB
7783: BD 5E 1A       JSR    $7C38
7786: BD 27 A0       JSR    $A588
7789: BD 25 7C       JSR    $ADF4
778C: 7E 9E 40       JMP    $B6C8
778F: 0D 00          TST    $22
7791: 27 94          BEQ    $77A9
7793: 96 18          LDA    $3A
7795: 97 B9          STA    $3B
7797: 0D 7B          TST    $53
7799: 27 8C          BEQ    $779F
779B: 0D 08          TST    $20
779D: 26 8D          BNE    $77A4
779F: 96 10          LDA    $32
77A1: 97 B8          STA    $3A
77A3: 39             RTS
77A4: 96 11          LDA    $33
77A6: 97 B8          STA    $3A
77A8: 39             RTS
77A9: 0D B5          TST    $3D
77AB: 27 2F          BEQ    $77B4
77AD: 81 77          CMPA   #$FF
77AF: 27 32          BEQ    $77C1
77B1: 0A BF          DEC    $3D
77B3: 39             RTS
77B4: 9E 1C          LDX    $3E
77B6: EC 03          LDD    ,X++
77B8: DD 12          STD    $3A
77BA: A6 08          LDA    ,X+
77BC: 97 15          STA    $3D
77BE: 9F B6          STX    $3E
77C0: 39             RTS
77C1: DC B8          LDD    $3A
77C3: DD 1C          STD    $3E
77C5: 0F BF          CLR    $3D
77C7: 39             RTS
77C8: 96 20          LDA    $08
77CA: 48             ASLA
77CB: 10 8E 5F 59    LDY    #jump_table_77d1
77CF: 6E 94          JMP    [A,Y]        ; [indirect_jump]
77D1: 55             LSRB
77D2: 68 FA          ASL    -$8,S
77D4: A6 5B          LDA    -$7,S
77D6: DA F8          ORB    $7A
77D8: 48             ASLA
77D9: 96 80          LDA    $08
77DB: 48             ASLA
77DC: 10 8E FF 6A    LDY    #jump_table_77e2
77E0: 6E 94          JMP    [A,Y]        ; [indirect_jump]
77E2: F5 68 5A       BITB   $EA78
77E5: D2 FB          SBCB   $79
77E7: DA 52          ORB    $7A
77E9: BA 96 83       ORA    $1E0B
77EC: 48             ASLA
77ED: 10 8E FF D1    LDY    #jump_table_77F3
77F1: 6E 34          JMP    [A,Y]        ; [indirect_jump]
77F3: F5 D9 5A       BITB   $FB78
77F6: B9 FA 7E       ADCA   $7856
77F9: 50             NEGB
77FA: E4 BD          ANDB   -$B,Y
77FC: 84 28          ANDA   #$00
77FE: 8D 8B          BSR    $7803
7800: 7E 5E A2       JMP    $7C20
7803: CC 6E 22       LDD    #$4C00
7806: FD C2 E8       STD    $40C0
7809: FD C8 68       STD    $40E0
780C: 7F 68 B7       CLR    $403F
780F: 8E 73 E2       LDX    #$51C0
7812: 6F 8C          CLR    $E,X
7814: 10 8E 7E 1C    LDY    #$FC9E
7818: 4F             CLRA
7819: BD E8 B5       JSR    $603D
781C: 6F 22          CLR    $A,X
781E: BD E8 35       JSR    $6017
7821: 10 8E C2 62    LDY    #$4040
7825: BD 35 0C       JSR    $B78E
7828: 31 0C          LEAY   $4,Y
782A: 30 00 08       LEAX   $20,X
782D: 86 89          LDA    #$01
782F: A7 23          STA    $1,X
7831: BD 35 0C       JSR    $B78E
7834: 86 46          LDA    #$64
7836: 97 88          STA    $0A
7838: 0C 23          INC    $0B
783A: 39             RTS
783B: 0A 22          DEC    $0A
783D: 26 9E          BNE    $7855
783F: 8E 62 66       LDX    #$4044
7842: 6F 02          CLR    ,X+
7844: 6F A2          CLR    ,X+
7846: 6F 02          CLR    ,X+
7848: 6F A8          CLR    ,X+
784A: 8C C8 B7       CMPX   #$409F
784D: 25 7B          BCS    $7842
784F: 86 5A          LDA    #$78
7851: 97 88          STA    $0A
7853: 0C 29          INC    $0B
7855: 39             RTS
7856: 8D 85          BSR    $785F
7858: 0A 22          DEC    $0A
785A: 26 8A          BNE    $785E
785C: 0C 23          INC    $0B
785E: 39             RTS
785F: 8E 73 E2       LDX    #$51C0
7862: BD E2 35       JSR    $6017
7865: 10 8E C2 68    LDY    #$4040
7869: 16 B7 AA       LBRA   $B78E
786C: CE 68 28       LDU    #$40A0
786F: CC 22 22       LDD    #$0000
7872: 8E 82 22       LDX    #$0000
7875: 36 94          PSHU   X,D
7877: 11 83 68 C8    CMPU   #$4040
787B: 22 D0          BHI    $7875
787D: 0C 80          INC    $08
787F: 0F 29          CLR    $0B
7881: 0F 8C          CLR    $0E
7883: 39             RTS
7884: 0D E2          TST    $C0
7886: 27 AC          BEQ    $78B6
7888: 0D 09          TST    $21
788A: 26 87          BNE    $789B
788C: 0F 2D          CLR    $05
788E: 86 8B          LDA    #$03
7890: 97 2A          STA    $08
7892: 0F 89          CLR    $0B
7894: 0F 2C          CLR    $0E
7896: 86 83          LDA    #$01
7898: 97 2F          STA    $07
789A: 39             RTS
789B: 7D 70 28       TST    $5800
789E: 27 64          BEQ    $788C
78A0: BD 58 7D       JSR    $7AFF
78A3: 86 26          LDA    #$04
78A5: 97 80          STA    $02
78A7: 0F 2D          CLR    $05
78A9: 86 8B          LDA    #$03
78AB: 97 20          STA    $08
78AD: 0F 83          CLR    $0B
78AF: 0F 2C          CLR    $0E
78B1: 86 83          LDA    #$01
78B3: 97 25          STA    $07
78B5: 39             RTS
78B6: CC 82 28       LDD    #$0000
78B9: BD E8 80       JSR    $6008
78BC: 86 29          LDA    #$01
78BE: 97 3E          STA    $B6
78C0: CC 20 8D       LDD    #$020F
78C3: BD 42 2A       JSR    $6008
78C6: CC 83 2A       LDD    #$0102
78C9: BD E8 80       JSR    $6008
78CC: CC 29 88       LDD    #$0100
78CF: BD 42 2A       JSR    $6008
78D2: 86 4A          LDA    #$C8
78D4: 97 25          STA    $07
78D6: 0C 8A          INC    $08
78D8: 0F 23          CLR    $0B
78DA: 0F 86          CLR    $0E
78DC: CE 68 28       LDU    #$40A0
78DF: CC 22 22       LDD    #$0000
78E2: 8E 82 22       LDX    #$0000
78E5: 36 94          PSHU   X,D
78E7: 11 83 68 C8    CMPU   #$4040
78EB: 22 D0          BHI    $78E5
78ED: 7E F4 94       JMP    $7C1C
78F0: 0D E2          TST    $C0
78F2: 27 99          BEQ    $790F
78F4: 7D 7A 82       TST    $5800
78F7: 27 17          BEQ    $7938
78F9: BD F2 77       JSR    $7AFF
78FC: 86 2B          LDA    #$03
78FE: 97 8A          STA    $02
7900: 0F 27          CLR    $05
7902: 86 81          LDA    #$03
7904: 97 2A          STA    $08
7906: 0F 89          CLR    $0B
7908: 0F 26          CLR    $0E
790A: 86 89          LDA    #$01
790C: 97 2F          STA    $07
790E: 39             RTS
790F: CC 22 22       LDD    #$0000
7912: BD E2 2A       JSR    $6008
7915: 86 83          LDA    #$01
7917: 97 9E          STA    $B6
7919: CC 8A 87       LDD    #$020F
791C: BD 48 80       JSR    $6008
791F: CC 23 20       LDD    #$0102
7922: BD E2 2A       JSR    $6008
7925: CC 83 83       LDD    #$0101
7928: BD 48 80       JSR    $6008
792B: 86 E0          LDA    #$C8
792D: 97 8F          STA    $07
792F: 0C 2A          INC    $08
7931: 0F 89          CLR    $0B
7933: 0F 2C          CLR    $0E
7935: 7E FE 9E       JMP    $7C1C
7938: 0F 2D          CLR    $05
793A: 86 8B          LDA    #$03
793C: 97 20          STA    $08
793E: 0F 83          CLR    $0B
7940: 0F 2C          CLR    $0E
7942: 86 83          LDA    #$01
7944: 97 25          STA    $07
7946: CE C2 88       LDU    #$40A0
7949: CC 88 88       LDD    #$0000
794C: 8E 28 88       LDX    #$0000
794F: 36 34          PSHU   X,D
7951: 11 83 C2 62    CMPU   #$4040
7955: 22 7A          BHI    $794F
7957: 39             RTS
7958: 96 23          LDA    $0B
795A: 48             ASLA
795B: 10 8E 51 E9    LDY    #jump_table_7961
795F: 6E 94          JMP    [A,Y]        ; [indirect_jump]

796A: 8E 0D 9E       LDX    #$85B6
796D: 26 8A          BNE    $7971
796F: 0C 29          INC    $0B
7971: 39             RTS
7972: 0A 85          DEC    $07
7974: 26 2E          BNE    $7982
7976: CC 82 38       LDD    #$0010
7979: BD E8 80       JSR    $6008
797C: 86 29          LDA    #$01
797E: 97 3E          STA    $B6
7980: 0C 29          INC    $0B
7982: 39             RTS
7983: 0D 94          TST    $B6
7985: 26 79          BNE    $7982
7987: CE 78 88       LDU    #$50A0
798A: 0D A8          TST    $20
798C: 27 2B          BEQ    $7991
798E: CE D8 81       LDU    #$50A3
7991: 86 87          LDA    #$05
7993: 97 42          STA    $60
7995: 8E D3 E2       LDX    #$5160
7998: EC EC          LDD    ,U
799A: 10 A3 AC       CMPD   ,X
799D: 22 9B          BHI    $79B2
799F: 25 24          BCS    $79A7
79A1: E6 C0          LDB    $2,U
79A3: E1 20          CMPB   $2,X
79A5: 24 89          BCC    $79B2
79A7: 30 20          LEAX   $8,X
79A9: 0A E8          DEC    $60
79AB: 26 C3          BNE    $7998
79AD: 0C 80          INC    $08
79AF: 0F 29          CLR    $0B
79B1: 39             RTS
79B2: 96 E2          LDA    $60
79B4: 81 23          CMPA   #$01
79B6: 27 9B          BEQ    $79D1
79B8: 9F 4A          STX    $62
79BA: 8E D9 A8       LDX    #$5180
79BD: 31 80          LEAY   $8,X
79BF: 4A             DECA
79C0: 97 43          STA    $61
79C2: 86 8A          LDA    #$08
79C4: E6 A0          LDB    ,-X
79C6: E7 20          STB    ,-Y
79C8: 4A             DECA
79C9: 26 71          BNE    $79C4
79CB: 0A 49          DEC    $61
79CD: 26 7B          BNE    $79C2
79CF: 9E 40          LDX    $62
79D1: EC 43          LDD    ,U++
79D3: ED A3          STD    ,X++
79D5: E6 46          LDB    ,U
79D7: E7 AC          STB    ,X
79D9: 96 49          LDA    $C1
79DB: A7 29          STA    $1,X
79DD: 0C 83          INC    $0B
79DF: 39             RTS
79E0: CC 21 92       LDD    #$0310
79E3: BD 42 2A       JSR    $6008
79E6: CC 80 29       LDD    #$0201
79E9: BD E8 80       JSR    $6008
79EC: CC 25 88       LDD    #$0D00
79EF: BD 42 2A       JSR    $6008
79F2: CC 83 2F       LDD    #$010D
79F5: BD E2 8A       JSR    $6008
79F8: CC 29 8F       LDD    #$0107
79FB: BD 48 20       JSR    $6008
79FE: CC 89 22       LDD    #$0100
7A01: DD 8B          STD    $09
7A03: 0C 29          INC    $0B
7A05: 39             RTS
7A06: 8D 8D          BSR    $7A17
7A08: 9E 21          LDX    $09
7A0A: 30 97          LEAX   -$1,X
7A0C: 9F 21          STX    $09
7A0E: 26 8E          BNE    $7A16
7A10: 0C 2A          INC    $08
7A12: 0F 89          CLR    $0B
7A14: 0F 2C          CLR    $0E
7A16: 39             RTS
7A17: 86 2D          LDA    #$05
7A19: 90 E8          SUBA   $60
7A1B: 97 4A          STA    $62
7A1D: 48             ASLA
7A1E: 48             ASLA
7A1F: 9B 40          ADDA   $62
7A21: CE EC 9B       LDU    #$6E19
7A24: 33 E4          LEAU   A,U
7A26: EE C0          LDU    $2,U
7A28: 31 E1 74 88    LEAY   -$0400,U
7A2C: CE 40 70       LDU    #$68F8
7A2F: 96 40          LDA    $62
7A31: 48             ASLA
7A32: 48             ASLA
7A33: 48             ASLA
7A34: 33 E4          LEAU   A,U
7A36: EE 46          LDU    ,U
7A38: 33 E1 74 88    LEAU   -$0400,U
7A3C: 96 67          LDA    $4F
7A3E: 84 87          ANDA   #$0F
7A40: 97 43          STA    $61
7A42: C6 86          LDB    #$04
7A44: 8D 29          BSR    $7A51
7A46: 33 26          LEAU   ,Y
7A48: C6 2E          LDB    #$06
7A4A: 8D 8D          BSR    $7A51
7A4C: 33 E0 C8       LEAU   $40,U
7A4F: C6 21          LDB    #$03
7A51: A6 46          LDA    ,U
7A53: 84 D2          ANDA   #$F0
7A55: 9A E3          ORA    $61
7A57: A7 EC          STA    ,U
7A59: 33 40 A8       LEAU   $20,U
7A5C: 5A             DECB
7A5D: 26 7A          BNE    $7A51
7A5F: 39             RTS
7A60: 0D 03          TST    $21
7A62: 27 95          BEQ    $7A7B
7A64: 7D 7A 82       TST    $5800
7A67: 27 3A          BEQ    $7A7B
7A69: BD F2 77       JSR    $7AFF
7A6C: 86 2C          LDA    #$04
7A6E: 97 8A          STA    $02
7A70: 0F 27          CLR    $05
7A72: 86 81          LDA    #$03
7A74: 97 2A          STA    $08
7A76: 0F 89          CLR    $0B
7A78: 0F 26          CLR    $0E
7A7A: 39             RTS
7A7B: 4F             CLRA
7A7C: 5F             CLRB
7A7D: DD 88          STD    $00
7A7F: DD 21          STD    $03
7A81: DD 84          STD    $06
7A83: DD 2B          STD    $09
7A85: DD 8E          STD    $0C
7A87: 97 2A          STA    $02
7A89: 97 8D          STA    $05
7A8B: 97 20          STA    $08
7A8D: 97 83          STA    $0B
7A8F: 97 2C          STA    $0E
7A91: 39             RTS
7A92: 7D DA 22       TST    $5800
7A95: 27 66          BEQ    $7A7B
7A97: BD 52 D7       JSR    $7AFF
7A9A: 86 8B          LDA    #$03
7A9C: 97 2A          STA    $02
7A9E: 0F 8D          CLR    $05
7AA0: 86 21          LDA    #$03
7AA2: 97 8A          STA    $08
7AA4: 0F 29          CLR    $0B
7AA6: 0F 8C          CLR    $0E
7AA8: 39             RTS
7AA9: 96 80          LDA    $08
7AAB: 48             ASLA
7AAC: 10 8E F2 3A    LDY    #jump_table_7ab2
7AB0: 6E 94          JMP    [A,Y]        ; [indirect_jump]
7AB2: F8 41 58       EORB   $C37A
7AB5: C1 96          CMPB   #$14
7AB7: 8A 48          ORA    #$60
7AB9: 10 8E F2 97    LDY    #jump_table_7ABF
7ABD: 6E 3E          JMP    [A,Y]        ; [indirect_jump]
7ABF: F2 E1 58       SBCB   $C37A
7AC2: 61 96          NEG    -$C,X
7AC4: 29 48          BVS    $7B30
7AC6: 10 8E 52 E4    LDY    #jump_table_7acc
7ACA: 6E 3E          JMP    [A,Y]        ; [indirect_jump]
7ACC: 52             XNCB
7ACD: F8 F2 5B       EORB   $7AD3
7AD0: 0C 29          INC    $0B
7AD2: 39             RTS
7AD3: 86 20          LDA    #$02
7AD5: D6 43          LDB    $C1
7AD7: 5C             INCB
7AD8: C4 2B          ANDB   #$03
7ADA: 10 26 71 F8    LBNE   $D4AE
7ADE: 86 8B          LDA    #$03
7AE0: 16 7B 49       LBRA   $D4AE
7AE3: DC BB          LDD    $99
7AE5: DD 2B          STD    $A9
7AE7: 96 B3          LDA    $9B
7AE9: 97 23          STA    $AB
7AEB: CC 2C 28       LDD    #$0400
7AEE: 17 6D 35       LBSR   $6008
7AF1: 0C 42          INC    $C0
7AF3: 0C E3          INC    $C1
7AF5: BD ED A9       JSR    $6F2B
7AF8: 0F 2D          CLR    $05
7AFA: 86 8B          LDA    #$03
7AFC: 97 20          STA    $08
7AFE: 39             RTS
7AFF: 8E 72 E2       LDX    #$50C0
7B02: 10 8E 7A 22    LDY    #$5800
7B06: EC 06          LDD    ,X
7B08: EE 8C          LDU    ,Y
7B0A: ED 29          STD    ,Y++
7B0C: EF A9          STU    ,X++
7B0E: 8C D8 CD       CMPX   #$50EF
7B11: 23 71          BLS    $7B06
7B13: 39             RTS
7B14: 86 23          LDA    #$01
7B16: 7E F9 8D       JMP    $7BA5
7B19: 86 80          LDA    #$08
7B1B: 16 28 57       LBRA   $7B9D
7B1E: 6D 82          TST    $A,X
7B20: 26 00          BNE    $7B44
7B22: A6 8F          LDA    $D,X
7B24: 81 2A          CMPA   #$08
7B26: 22 9E          BHI    $7B44
7B28: 34 38          PSHS   X
7B2A: 8E F3 18       LDX    #jump_table_7b30
7B2D: 48             ASLA
7B2E: 6E 1E          JMP    [A,X]        ; [indirect_jump]
7B30: 59             ROLB
7B31: 67 F9          ASR    -$5,S
7B33: C9 59          ADCB   #$7B
7B35: 60 F9          NEG    -$5,S
7B37: C0 53          SUBB   #$7B
7B39: 79 F3 CA       ROL    $7B42
7B3C: 53             COMB
7B3D: 7F F3 D9       CLR    $7B51
7B40: 59             ROLB
7B41: 75 35 12       LSR    $B790
7B44: 39             RTS
7B45: 35 92          PULS   X
7B47: 86 2A          LDA    #$02
7B49: 20 DA          BRA    $7B9D
7B4B: 35 38          PULS   X
7B4D: 86 8B          LDA    #$03
7B4F: 20 6E          BRA    $7B9D
7B51: 35 92          PULS   X
7B53: 86 26          LDA    #$04
7B55: 20 C4          BRA    $7B9D
7B57: 35 38          PULS   X
7B59: 86 8D          LDA    #$05
7B5B: 20 68          BRA    $7B9D
7B5D: 86 81          LDA    #$09
7B5F: 8D 1E          BSR    $7B9D
7B61: 86 88          LDA    #$0A
7B63: 20 1A          BRA    $7B9D
7B65: 86 89          LDA    #$0B
7B67: 20 1C          BRA    $7B9D
7B69: 86 84          LDA    #$0C
7B6B: 20 18          BRA    $7B9D
7B6D: 86 8F          LDA    #$07
7B6F: 20 0E          BRA    $7B9D
7B71: 86 84          LDA    #$06
7B73: 20 0A          BRA    $7B9D
7B75: 86 8F          LDA    #$0D
7B77: 20 0C          BRA    $7B9D
7B79: 86 86          LDA    #$0E
7B7B: 20 08          BRA    $7B9D
7B7D: 86 87          LDA    #$0F
7B7F: 20 3E          BRA    $7B9D
7B81: 86 92          LDA    #$10
7B83: 20 3A          BRA    $7B9D
7B85: 86 90          LDA    #$12
7B87: 20 3C          BRA    $7B9D
7B89: 86 9B          LDA    #$13
7B8B: 20 38          BRA    $7B9D
7B8D: 86 9B          LDA    #$13
7B8F: 20 2E          BRA    $7B9D
7B91: 86 96          LDA    #$14
7B93: 20 2A          BRA    $7B9D
7B95: 86 97          LDA    #$15
7B97: 20 2C          BRA    $7B9D
7B99: 86 84          LDA    #$0C
7B9B: 20 28          BRA    $7B9D
7B9D: 0D DA          TST    $52
7B9F: 26 26          BNE    $7BA5
7BA1: 0D A0          TST    $22
7BA3: 27 30          BEQ    $7BB7
7BA5: 10 9E 9E       LDY    $1C
7BA8: A7 88          STA    ,Y+
7BAA: 10 8C 79 77    CMPY   #$515F
7BAE: 23 8C          BLS    $7BB4
7BB0: 10 8E D3 C2    LDY    #$5140
7BB4: 10 9F 9E       STY    $1C
7BB7: 39             RTS
7BB8: 86 3E          LDA    #$16
7BBA: 20 69          BRA    $7B9D
7BBC: 86 03          LDA    #$2B
7BBE: 20 55          BRA    $7B9D
7BC0: 86 3D          LDA    #$1F
7BC2: 8D 5B          BSR    $7B9D
7BC4: 86 3C          LDA    #$1E
7BC6: 8D 57          BSR    $7B9D
7BC8: 86 35          LDA    #$1D
7BCA: 8D 59          BSR    $7B9D
7BCC: 86 34          LDA    #$1C
7BCE: 8D 45          BSR    $7B9D
7BD0: 86 39          LDA    #$1B
7BD2: 8D 4B          BSR    $7B9D
7BD4: 86 38          LDA    #$1A
7BD6: 8D 47          BSR    $7B9D
7BD8: 86 31          LDA    #$19
7BDA: 20 49          BRA    $7B9D
7BDC: 0D 0A          TST    $22
7BDE: 27 9C          BEQ    $7BF4
7BE0: 96 E3          LDA    $C1
7BE2: 84 81          ANDA   #$03
7BE4: 8B 02          ADDA   #$20
7BE6: 8D 37          BSR    $7B9D
7BE8: 86 36          LDA    #$1E
7BEA: 8D 39          BSR    $7B9D
7BEC: 86 35          LDA    #$1D
7BEE: 8D 25          BSR    $7B9D
7BF0: 86 3E          LDA    #$1C
7BF2: 20 2B          BRA    $7B9D
7BF4: 39             RTS
7BF5: 96 43          LDA    $C1
7BF7: 4C             INCA
7BF8: 84 2B          ANDA   #$03
7BFA: 27 94          BEQ    $7C18
7BFC: 86 0F          LDA    #$27
7BFE: 8D 15          BSR    $7B9D
7C00: 86 3C          LDA    #$1E
7C02: 8D 1B          BSR    $7B9D
7C04: 86 3F          LDA    #$1D
7C06: 8D 17          BSR    $7B9D
7C08: 86 34          LDA    #$1C
7C0A: 8D 19          BSR    $7B9D
7C0C: 86 33          LDA    #$1B
7C0E: 8D 05          BSR    $7B9D
7C10: 86 38          LDA    #$1A
7C12: 8D 0B          BSR    $7B9D
7C14: 86 3B          LDA    #$19
7C16: 20 07          BRA    $7B9D
7C18: 86 00          LDA    #$28
7C1A: 20 6A          BRA    $7BFE
7C1C: 86 01          LDA    #$29
7C1E: 20 2A          BRA    $7BC2
7C20: 86 08          LDA    #$2A
7C22: 17 7D 5A       LBSR   $7B9D
7C25: 86 9C          LDA    #$1E
7C27: 7E 53 B5       JMP    $7B9D
7C2A: 0D AA          TST    $22
7C2C: 27 2C          BEQ    $7C32
7C2E: 86 AC          LDA    #$24
7C30: 20 B2          BRA    $7BC2
7C32: 39             RTS
7C33: 86 33          LDA    #$11
7C35: 16 7D E7       LBRA   $7B9D
7C38: BD BE 26       JSR    $96AE
7C3B: BD 54 78       JSR    $7C50
7C3E: BD 0D 25       JSR    $8507
7C41: BD 07 9E       JSR    $851C
7C44: BD A4 5B       JSR    $86D9
7C47: BD AF F2       JSR    $87DA
7C4A: BD 1C 67       JSR    $944F
7C4D: 7E 2B 7D       JMP    $A3F5
7C50: 0D A2          TST    $80
7C52: 26 8E          BNE    $7C60
7C54: 8E 73 42       LDX    #$51C0
7C57: A6 2B          LDA    $3,X
7C59: 48             ASLA
7C5A: 10 8E 54 49    LDY    #jump_table_7c61
7C5E: 6E 3E          JMP    [A,Y]        ; [indirect_jump]
7C60: 39             RTS

7C69: 6F 00 9D       CLR    $15,X
7C6C: 6D A0 A8       TST    $20,X
7C6F: 26 6B          BNE    $7CBA
7C71: BD FD D9       JSR    $7F5B
7C74: 96 18          LDA    $3A
7C76: 6D 0A 34       TST    $1C,X
7C79: 27 87          BEQ    $7C8A
7C7B: 85 20          BITA   #$08
7C7D: 26 E0          BNE    $7CE7
7C7F: 85 26          BITA   #$04
7C81: 27 90          BEQ    $7C95
7C83: 6D AA 3B       TST    $19,X
7C86: 10 27 29 6A    LBEQ   $7DCC
7C8A: 6D 00 31       TST    $19,X
7C8D: 27 8E          BEQ    $7C95
7C8F: 85 26          BITA   #$04
7C91: 10 26 82 56    LBNE   $7D09
7C95: 6D 0A 9A       TST    $18,X
7C98: 27 22          BEQ    $7CA4
7C9A: 85 80          BITA   #$08
7C9C: 26 35          BNE    $7CBB
7C9E: 85 8C          BITA   #$04
7CA0: 10 26 82 32    LBNE   $7D54
7CA4: 6D AA 98       TST    $1A,X
7CA7: 27 2E          BEQ    $7CAF
7CA9: 85 89          BITA   #$01
7CAB: 10 26 29 C6    LBNE   $7DFD
7CAF: 6D AA 39       TST    $1B,X
7CB2: 27 84          BEQ    $7CBA
7CB4: 85 20          BITA   #$02
7CB6: 10 26 29 03    LBNE   $7DE5
7CBA: 39             RTS
7CBB: A6 27          LDA    $F,X
7CBD: 81 89          CMPA   #$01
7CBF: 10 27 23 D7    LBEQ   $7E18
7CC3: 86 23          LDA    #$01
7CC5: A7 8D          STA    $F,X
7CC7: D6 B6          LDB    $9E
7CC9: 7D DC 87       TST    $540F
7CCC: 26 2C          BNE    $7CD2
7CCE: CB 80          ADDB   #$08
7CD0: 20 20          BRA    $7CD4
7CD2: C0 8A          SUBB   #$08
7CD4: E7 26          STB    $4,X
7CD6: 10 8E D4 A8    LDY    #$FC80
7CDA: 86 89          LDA    #$01
7CDC: BD 48 B5       JSR    $603D
7CDF: 6F 28          CLR    $A,X
7CE1: BD F9 9C       JSR    $7B1E
7CE4: 7E 5C 9A       JMP    $7E18
7CE7: 86 29          LDA    #$01
7CE9: A1 87          CMPA   $F,X
7CEB: 10 27 29 A1    LBEQ   $7E18
7CEF: A7 2D          STA    $F,X
7CF1: D6 0C          LDB    $8E
7CF3: C0 2A          SUBB   #$08
7CF5: E7 86          STB    $4,X
7CF7: 10 8E D4 6A    LDY    #$FCE2
7CFB: BD 48 15       JSR    $603D
7CFE: 6F 82          CLR    $A,X
7D00: BD 42 95       JSR    $6017
7D03: BD 59 3C       JSR    $7B1E
7D06: 7E FC 30       JMP    $7E18
7D09: 85 8B          BITA   #$03
7D0B: 10 26 28 34    LBNE   $7DCB
7D0F: A6 2D          LDA    $F,X
7D11: 81 81          CMPA   #$03
7D13: 10 27 23 83    LBEQ   $7E18
7D17: 86 2B          LDA    #$03
7D19: A7 87          STA    $F,X
7D1B: DC B4          LDD    $9C
7D1D: ED 8C          STD    $4,X
7D1F: B6 76 2D       LDA    $540F
7D22: 10 8E DE 90    LDY    #$FCB2
7D26: BD E2 15       JSR    $603D
7D29: 10 8E F5 78    LDY    #$7D50
7D2D: F6 DC 87       LDB    $540F
7D30: EC 87          LDD    B,Y
7D32: ED 0A 30       STD    $12,X
7D35: 4F             CLRA
7D36: A7 88          STA    $A,X
7D38: BD 48 9F       JSR    $6017
7D3B: BD 53 36       JSR    $7B1E
7D3E: 86 89          LDA    #$01
7D40: A7 21          STA    $3,X
7D42: 6F 0A 32       CLR    $10,X
7D45: 6F 0A 93       CLR    $11,X
7D48: B6 7C 87       LDA    $540F
7D4B: A7 27          STA    $F,X
7D4D: 7E F6 90       JMP    $7E18
7D50: C2 22          SBCB   #$00
7D52: 60 82          NEG    $0,X
7D54: 86 21          LDA    #$03
7D56: A7 8D          STA    $F,X
7D58: 10 8E DF 88    LDY    #$5700
7D5C: E6 2D          LDB    $5,X
7D5E: 6D 2C          TST    ,Y
7D60: 27 3C          BEQ    $7D80
7D62: E1 A1          CMPB   $3,Y
7D64: 26 30          BNE    $7D78
7D66: A6 A0          LDA    $2,Y
7D68: 8B 2C          ADDA   #$04
7D6A: A0 A9          SUBA   $1,Y
7D6C: 97 48          STA    $60
7D6E: A6 8C          LDA    $4,X
7D70: 8B 2A          ADDA   #$08
7D72: A0 A3          SUBA   $1,Y
7D74: 91 42          CMPA   $60
7D76: 23 C7          BLS    $7DBD
7D78: 31 0C          LEAY   $4,Y
7D7A: 10 8C 7F 77    CMPY   #$575F
7D7E: 25 56          BCS    $7D5E
7D80: E6 25          LDB    $7,X
7D82: CB 02          ADDB   #$80
7D84: E7 25          STB    $7,X
7D86: 24 C1          BCC    $7DCB
7D88: E6 2D          LDB    $5,X
7D8A: C1 58          CMPB   #$D0
7D8C: 24 15          BCC    $7DCB
7D8E: A6 8D          LDA    $5,X
7D90: 90 BD          SUBA   $9F
7D92: 2B 86          BMI    $7D98
7D94: 81 27          CMPA   #$05
7D96: 26 8C          BNE    $7DA6
7D98: E6 2D          LDB    $5,X
7D9A: CB 8D          ADDB   #$05
7D9C: E7 2D          STB    $5,X
7D9E: F6 F5 9E       LDB    $7DBC
7DA1: E7 8F          STB    $D,X
7DA3: 7E 59 3C       JMP    $7B1E
7DA6: 44             LSRA
7DA7: 10 8E 55 3C    LDY    #$7DB4
7DAB: A6 8E          LDA    A,Y
7DAD: A7 85          STA    $D,X
7DAF: 6C 27          INC    $5,X
7DB1: 7E F9 9C       JMP    $7B1E
7DB4: 33 30          LEAU   -$E,X
7DB6: 91 96          CMPA   $14
7DB8: 3C 3C          CWAI   #$14
7DBA: 9C 9C          CMPX   $14
7DBC: 3C 86          CWAI   #$AE
7DBE: 9C A7          CMPX   $2F
7DC0: 2F 1F          BLE    $7DFF
7DC2: A2 83          SBCA   $1,X
7DC4: 75 22 54       LSR    >$00D6
7DC7: 54             LSRB
7DC8: E7 A0 95       STB    $1D,X
7DCB: 39             RTS
7DCC: 86 2B          LDA    #$03
7DCE: A1 87          CMPA   $F,X
7DD0: 10 27 82 C6    LBEQ   $7E18
7DD4: A7 2D          STA    $F,X
7DD6: 10 8E D4 CA    LDY    #$FCE2
7DDA: BD E8 15       JSR    $603D
7DDD: 6F 82          CLR    $A,X
7DDF: BD 42 35       JSR    $6017
7DE2: 7E F9 3C       JMP    $7B1E
7DE5: A6 8D          LDA    $F,X
7DE7: 27 07          BEQ    $7E18
7DE9: 4F             CLRA
7DEA: A7 87          STA    $F,X
7DEC: 10 8E 74 08    LDY    #$FC80
7DF0: BD 42 BF       JSR    $603D
7DF3: 6F 28          CLR    $A,X
7DF5: BD E2 95       JSR    $6017
7DF8: BD 53 96       JSR    $7B1E
7DFB: 20 33          BRA    $7E18
7DFD: A6 87          LDA    $F,X
7DFF: 81 20          CMPA   #$02
7E01: 27 97          BEQ    $7E18
7E03: 86 20          LDA    #$02
7E05: A7 8D          STA    $F,X
7E07: 10 8E D4 08    LDY    #$FC80
7E0B: BD 48 15       JSR    $603D
7E0E: 6F 82          CLR    $A,X
7E10: BD 42 95       JSR    $6017
7E13: BD 59 3C       JSR    $7B1E
7E16: 20 82          BRA    $7E18
7E18: A6 27          LDA    $F,X
7E1A: 47             ASRA
7E1B: 10 24 29 98    LBCC   $7F2F
7E1F: 47             ASRA
7E20: 24 71          BCC    $7E75
7E22: E6 85          LDB    $7,X
7E24: EB 2B          ADDB   $9,X
7E26: E7 85          STB    $7,X
7E28: 25 29          BCS    $7E2B
7E2A: 39             RTS
7E2B: 10 8E 7F 88    LDY    #$5700
7E2F: E6 27          LDB    $5,X
7E31: 6D 26          TST    ,Y
7E33: 27 3C          BEQ    $7E53
7E35: E1 A1          CMPB   $3,Y
7E37: 26 3A          BNE    $7E4B
7E39: A6 AA          LDA    $2,Y
7E3B: 8B 2C          ADDA   #$04
7E3D: A0 A9          SUBA   $1,Y
7E3F: 97 42          STA    $60
7E41: A6 86          LDA    $4,X
7E43: 8B 2A          ADDA   #$08
7E45: A0 A3          SUBA   $1,Y
7E47: 91 48          CMPA   $60
7E49: 23 9E          BLS    $7E61
7E4B: 31 0C          LEAY   $4,Y
7E4D: 10 8C DF 7D    CMPY   #$575F
7E51: 25 5C          BCS    $7E31
7E53: E6 27          LDB    $5,X
7E55: C1 52          CMPB   #$D0
7E57: 24 33          BCC    $7E74
7E59: 6C 8D          INC    $5,X
7E5B: BD 48 3F       JSR    $6017
7E5E: 7E F3 3C       JMP    $7B1E
7E61: 86 96          LDA    #$14
7E63: A7 2F          STA    $D,X
7E65: 1F A2          TFR    Y,D
7E67: 83 7F 28       SUBD   #$5700
7E6A: 54             LSRB
7E6B: 54             LSRB
7E6C: E7 A0 95       STB    $1D,X
7E6F: 6F 28          CLR    $A,X
7E71: 7E F9 9C       JMP    $7B1E
7E74: 39             RTS
7E75: 6D 0A 9E       TST    $1C,X
7E78: 10 26 88 06    LBNE   $7F0A
7E7C: E6 2F          LDB    $7,X
7E7E: CB 08          ADDB   #$80
7E80: E7 25          STB    $7,X
7E82: 10 24 22 A1    LBCC   $7F09
7E86: 96 1D          LDA    $9F
7E88: 80 2A          SUBA   #$02
7E8A: A1 8D          CMPA   $5,X
7E8C: 27 01          BEQ    $7EB7
7E8E: A6 8D          LDA    $5,X
7E90: 90 BD          SUBA   $9F
7E92: 81 87          CMPA   #$05
7E94: 26 2B          BNE    $7E9F
7E96: E6 87          LDB    $5,X
7E98: C0 2D          SUBB   #$05
7E9A: E7 8D          STB    $5,X
7E9C: 7E 53 96       JMP    $7B1E
7E9F: 4C             INCA
7EA0: 44             LSRA
7EA1: 10 8E FC 8C    LDY    #$7EAE
7EA5: A6 24          LDA    A,Y
7EA7: A7 25          STA    $D,X
7EA9: 6A 8D          DEC    $5,X
7EAB: 7E 53 36       JMP    $7B1E
7EAE: 99 99          ADCA   $11
7EB0: 30 31          LEAX   -$D,X
7EB2: 96 96          LDA    $14
7EB4: 36 36          PSHU   X,B
7EB6: 96 4F          LDA    $CD
7EB8: 7D 7C 87       TST    $540F
7EBB: 26 24          BNE    $7EC9
7EBD: E6 8C          LDB    $4,X
7EBF: D0 BE          SUBB   $9C
7EC1: 23 C4          BLS    $7F09
7EC3: 10 8E C2 82    LDY    #$E000
7EC7: 20 22          BRA    $7ED3
7EC9: D6 14          LDB    $9C
7ECB: E0 2C          SUBB   $4,X
7ECD: 23 B2          BLS    $7F09
7ECF: 10 8E C0 82    LDY    #$E200
7ED3: 58             ASLB
7ED4: 49             ROLA
7ED5: 31 29          LEAY   D,Y
7ED7: 10 AF A0 9A    STY    $12,X
7EDB: EC 8C          LDD    ,Y
7EDD: 9B 14          ADDA   $9C
7EDF: DB BF          ADDB   $9D
7EE1: ED 86          STD    $4,X
7EE3: B6 76 2D       LDA    $540F
7EE6: 10 8E D4 9C    LDY    #$FCB4
7EEA: BD E8 15       JSR    $603D
7EED: 6F 82          CLR    $A,X
7EEF: 86 23          LDA    #$01
7EF1: A7 81          STA    $3,X
7EF3: 6F AA 32       CLR    $10,X
7EF6: 6F 0A 39       CLR    $11,X
7EF9: BD F3 96       JSR    $7B1E
7EFC: 17 C9 90       LBSR   $6017
7EFF: A6 2C          LDA    $E,X
7F01: 88 02          EORA   #$80
7F03: A7 2C          STA    $E,X
7F05: 86 87          LDA    #$05
7F07: A7 25          STA    $D,X
7F09: 39             RTS
7F0A: E6 8F          LDB    $7,X
7F0C: EB 21          ADDB   $9,X
7F0E: E7 8F          STB    $7,X
7F10: 24 D5          BCC    $7F09
7F12: 96 0D          LDA    $8F
7F14: 80 32          SUBA   #$10
7F16: A1 87          CMPA   $5,X
7F18: 24 20          BCC    $7F22
7F1A: 6A 8D          DEC    $5,X
7F1C: BD 53 96       JSR    $7B1E
7F1F: 7E 42 35       JMP    $6017
7F22: 6F 88          CLR    $A,X
7F24: 86 20          LDA    #$02
7F26: A7 81          STA    $3,X
7F28: 6F A0 96       CLR    $1E,X
7F2B: BD 48 3F       JSR    $6017
7F2E: 39             RTS
7F2F: E6 24          LDB    $6,X
7F31: EB 8A          ADDB   $8,X
7F33: E7 24          STB    $6,X
7F35: 25 83          BCS    $7F38
7F37: 39             RTS
7F38: 47             ASRA
7F39: 24 98          BCC    $7F4B
7F3B: A6 2C          LDA    $4,X
7F3D: 8B 8C          ADDA   #$04
7F3F: 81 32          CMPA   #$10
7F41: 23 80          BLS    $7F45
7F43: 6A 26          DEC    $4,X
7F45: BD F9 9C       JSR    $7B1E
7F48: 7E 48 9F       JMP    $6017
7F4B: A6 2C          LDA    $4,X
7F4D: 8B 84          ADDA   #$0C
7F4F: 81 D2          CMPA   #$F0
7F51: 24 80          BCC    $7F55
7F53: 6C 26          INC    $4,X
7F55: BD F9 9C       JSR    $7B1E
7F58: 7E 48 9F       JMP    $6017
7F5B: 4F             CLRA
7F5C: 5F             CLRB
7F5D: ED 00 90       STD    $18,X
7F60: ED AA 98       STD    $1A,X
7F63: E7 AA 3E       STB    $1C,X
7F66: 8D 8B          BSR    $7F71
7F68: BD A8 92       JSR    $801A
7F6B: BD 57 E9       JSR    $7FC1
7F6E: 7E F7 A5       JMP    $7F87
7F71: A6 86          LDA    $4,X
7F73: 90 BE          SUBA   $9C
7F75: 8B 86          ADDA   #$04
7F77: 81 20          CMPA   #$08
7F79: 22 83          BHI    $7F86
7F7B: 96 B5          LDA    $9D
7F7D: A0 8D          SUBA   $5,X
7F7F: 26 27          BNE    $7F86
7F81: 86 83          LDA    #$01
7F83: A7 AA 3B       STA    $19,X
7F86: 39             RTS
7F87: EC A0 32       LDD    $1A,X
7F8A: 27 8E          BEQ    $7F92
7F8C: 96 B7          LDA    $9F
7F8E: A1 8D          CMPA   $5,X
7F90: 24 0C          BCC    $7FC0
7F92: 7D D6 2D       TST    $540F
7F95: 26 8C          BNE    $7FA5
7F97: E6 2C          LDB    $4,X
7F99: C0 80          SUBB   #$08
7F9B: D0 B6          SUBB   $9E
7F9D: CB 8A          ADDB   #$02
7F9F: C1 26          CMPB   #$04
7FA1: 22 9F          BHI    $7FC0
7FA3: 20 2E          BRA    $7FB1
7FA5: E6 86          LDB    $4,X
7FA7: CB 20          ADDB   #$08
7FA9: D0 16          SUBB   $9E
7FAB: CB 2A          ADDB   #$02
7FAD: C1 8C          CMPB   #$04
7FAF: 22 2D          BHI    $7FC0
7FB1: E6 87          LDB    $5,X
7FB3: D0 BD          SUBB   $9F
7FB5: CB 81          ADDB   #$03
7FB7: C1 3B          CMPB   #$13
7FB9: 22 8D          BHI    $7FC0
7FBB: 86 29          LDA    #$01
7FBD: A7 00 90       STA    $18,X
7FC0: 39             RTS
7FC1: A6 87          LDA    $5,X
7FC3: 10 8E 75 82    LDY    #$5700
7FC7: 6D 8C          TST    ,Y
7FC9: 27 B0          BEQ    $8003
7FCB: A1 0B          CMPA   $3,Y
7FCD: 26 92          BNE    $7FE9
7FCF: E6 26          LDB    $4,X
7FD1: CB 8A          ADDB   #$08
7FD3: E0 03          SUBB   $1,Y
7FD5: CB 8A          ADDB   #$08
7FD7: D7 48          STB    $60
7FD9: E6 AA          LDB    $2,Y
7FDB: C1 D7          CMPB   #$FF
7FDD: 26 8A          BNE    $7FE1
7FDF: C6 CA          LDB    #$E8
7FE1: CB 92          ADDB   #$10
7FE3: E0 03          SUBB   $1,Y
7FE5: D1 E2          CMPB   $60
7FE7: 22 33          BHI    $8004
7FE9: 31 AC          LEAY   $4,Y
7FEB: 10 8C 7F D7    CMPY   #$575F
7FEF: 25 F4          BCS    $7FC7
7FF1: 96 43          LDA    $C1
7FF3: 84 21          ANDA   #$03
7FF5: 4A             DECA
7FF6: 26 89          BNE    $8003
7FF8: 34 08          PSHS   Y
7FFA: BD 20 88       JSR    $A8A0
7FFD: 35 A8          PULS   Y
7FFF: 0D 42          TST    $60
8001: 26 89          BNE    $800E
8003: 39             RTS
8004: 1F 02          TFR    Y,D
8006: 83 D5 28       SUBD   #$5700
8009: 54             LSRB
800A: 54             LSRB
800B: E7 A0 35       STB    $1D,X
800E: 10 9F AE       STY    $8C
8011: 86 83          LDA    #$01
8013: A7 AA 38       STA    $1A,X
8016: A7 0A 33       STA    $1B,X
8019: 39             RTS
801A: 10 8E 7F 48    LDY    #$5760
801E: 6D 2C          TST    ,Y
8020: 27 04          BEQ    $8048
8022: A6 87          LDA    $5,X
8024: 8B 32          ADDA   #$10
8026: A0 A1          SUBA   $3,Y
8028: 97 48          STA    $60
802A: A6 AA          LDA    $2,Y
802C: 8B 38          ADDA   #$10
802E: A0 AB          SUBA   $3,Y
8030: 91 42          CMPA   $60
8032: 25 8E          BCS    $8040
8034: E6 26          LDB    $4,X
8036: CB 8A          ADDB   #$08
8038: E0 09          SUBB   $1,Y
803A: CB 8A          ADDB   #$02
803C: C1 2C          CMPB   #$04
803E: 23 85          BLS    $804D
8040: 31 06          LEAY   $4,Y
8042: 10 8C 75 BD    CMPY   #$579F
8046: 25 54          BCS    $801E
8048: 4F             CLRA
8049: A7 00 94       STA    $1C,X
804C: 39             RTS
804D: E6 AB          LDB    $3,Y
804F: A6 03          LDA    $1,Y
8051: DD 0C          STD    $8E
8053: 86 23          LDA    #$01
8055: A7 0A 9E       STA    $1C,X
8058: 39             RTS
8059: 96 C7          LDA    $4F
805B: 85 17          BITA   #$3F
805D: 26 85          BNE    $806C
805F: 6C AA 37       INC    $15,X
8062: A6 0A 37       LDA    $15,X
8065: 91 07          CMPA   $85
8067: 26 2B          BNE    $806C
8069: BD F4 BB       JSR    $7C33
806C: 6D A0 A8       TST    $20,X
806F: 26 1D          BNE    $80B0
8071: BD 00 5D       JSR    $82DF
8074: 96 18          LDA    $3A
8076: 6D 0A 31       TST    $19,X
8079: 27 86          BEQ    $8089
807B: 85 2C          BITA   #$04
807D: 26 C6          BNE    $80CD
807F: E6 2D          LDB    $F,X
8081: C1 81          CMPB   #$03
8083: 26 26          BNE    $8089
8085: 85 8A          BITA   #$08
8087: 26 00          BNE    $80B1
8089: 6D 00 90       TST    $18,X
808C: 27 26          BEQ    $809C
808E: 85 80          BITA   #$08
8090: 26 3D          BNE    $80B1
8092: E6 8D          LDB    $F,X
8094: C1 23          CMPB   #$01
8096: 26 86          BNE    $809C
8098: 85 2C          BITA   #$04
809A: 26 B9          BNE    $80CD
809C: 6D A0 92       TST    $1A,X
809F: 27 24          BEQ    $80A7
80A1: 85 83          BITA   #$01
80A3: 10 26 22 EC    LBNE   $8115
80A7: 6D A0 33       TST    $1B,X
80AA: 27 8C          BEQ    $80B0
80AC: 85 2A          BITA   #$02
80AE: 26 C3          BNE    $80FB
80B0: 39             RTS
80B1: A6 8D          LDA    $F,X
80B3: 81 23          CMPA   #$01
80B5: 10 27 82 52    LBEQ   $8133
80B9: 86 89          LDA    #$01
80BB: A7 27          STA    $F,X
80BD: 86 8A          LDA    #$02
80BF: A7 21          STA    $3,X
80C1: 6F 0A 9C       CLR    $1E,X
80C4: 6F AA 93       CLR    $11,X
80C7: BD 48 3F       JSR    $6017
80CA: 7E F3 A1       JMP    $7B89
80CD: A6 87          LDA    $F,X
80CF: 81 21          CMPA   #$03
80D1: 10 27 82 7C    LBEQ   $8133
80D5: 86 81          LDA    #$03
80D7: A7 27          STA    $F,X
80D9: DC 16          LDD    $9E
80DB: 7D 7C 27       TST    $540F
80DE: 26 8C          BNE    $80E4
80E0: 8B 2A          ADDA   #$08
80E2: 20 80          BRA    $80E6
80E4: 80 2A          SUBA   #$08
80E6: ED 86          STD    $4,X
80E8: 86 2B          LDA    #$03
80EA: 10 8E D4 A8    LDY    #$FC80
80EE: BD E8 1F       JSR    $603D
80F1: 6F 88          CLR    $A,X
80F3: BD 42 35       JSR    $6017
80F6: BD F9 36       JSR    $7B1E
80F9: 20 B0          BRA    $8133
80FB: A6 27          LDA    $F,X
80FD: 27 BC          BEQ    $8133
80FF: 6F 2D          CLR    $F,X
8101: B6 D6 8D       LDA    $540F
8104: 10 8E 7E 40    LDY    #$FCC2
8108: BD 48 B5       JSR    $603D
810B: 6F 22          CLR    $A,X
810D: BD E8 9F       JSR    $6017
8110: BD 59 9C       JSR    $7B1E
8113: 20 3C          BRA    $8133
8115: A6 8D          LDA    $F,X
8117: 81 2A          CMPA   #$02
8119: 27 90          BEQ    $8133
811B: 86 2A          LDA    #$02
811D: A7 87          STA    $F,X
811F: B6 76 2D       LDA    $540F
8122: 10 8E DE F0    LDY    #$FCD2
8126: BD E2 15       JSR    $603D
8129: 6F 82          CLR    $A,X
812B: BD 48 3F       JSR    $6017
812E: BD F3 3C       JSR    $7B1E
8131: 20 82          BRA    $8133
8133: A6 2D          LDA    $F,X
8135: 47             ASRA
8136: 10 24 28 86    LBCC   $81E8
813A: E6 8F          LDB    $7,X
813C: EB 21          ADDB   $9,X
813E: E7 8F          STB    $7,X
8140: 25 23          BCS    $8143
8142: 39             RTS
8143: 47             ASRA
8144: 24 2A          BCC    $814E
8146: 6F 81          CLR    $3,X
8148: BD 53 96       JSR    $7B1E
814B: 7E 48 3F       JMP    $6017
814E: 96 17          LDA    $9F
8150: 80 20          SUBA   #$02
8152: A1 87          CMPA   $5,X
8154: 10 27 82 F0    LBEQ   $81CA
8158: 10 8E DF 88    LDY    #$5700
815C: 6D 8C          TST    ,Y
815E: 27 AC          BEQ    $8184
8160: A6 27          LDA    $5,X
8162: A0 A1          SUBA   $3,Y
8164: 8B 20          ADDA   #$02
8166: 81 86          CMPA   #$04
8168: 22 3A          BHI    $817C
816A: E6 AA          LDB    $2,Y
816C: CB 2C          ADDB   #$04
816E: E0 A9          SUBB   $1,Y
8170: D7 42          STB    $60
8172: E6 86          LDB    $4,X
8174: CB 2A          ADDB   #$08
8176: E0 A3          SUBB   $1,Y
8178: D1 48          CMPB   $60
817A: 25 9F          BCS    $8193
817C: 31 0C          LEAY   $4,Y
817E: 10 8C 75 7D    CMPY   #$575F
8182: 25 5A          BCS    $815C
8184: 6D 27          TST    $5,X
8186: 27 89          BEQ    $8193
8188: 6C A0 96       INC    $1E,X
818B: 6A 2D          DEC    $5,X
818D: BD F3 96       JSR    $7B1E
8190: 7E 42 95       JMP    $6017
8193: A6 AA 3C       LDA    $1E,X
8196: 81 92          CMPA   #$10
8198: 25 23          BCS    $81A5
819A: 86 8A          LDA    #$02
819C: 97 2D          STA    $05
819E: 0F 80          CLR    $08
81A0: 0F 29          CLR    $0B
81A2: 0F 8C          CLR    $0E
81A4: 39             RTS
81A5: 6F 0A 9C       CLR    $1E,X
81A8: 1F 08          TFR    Y,D
81AA: 83 DF 28       SUBD   #$5700
81AD: 54             LSRB
81AE: 54             LSRB
81AF: E7 AA 3F       STB    $1D,X
81B2: 6F 81          CLR    $3,X
81B4: A6 01          LDA    $3,Y
81B6: A7 87          STA    $5,X
81B8: 4F             CLRA
81B9: 10 8E 74 A8    LDY    #$FC80
81BD: BD E8 B5       JSR    $603D
81C0: 6F 28          CLR    $A,X
81C2: 6F 8D          CLR    $F,X
81C4: BD 59 9C       JSR    $7B1E
81C7: 7E 48 3F       JMP    $6017
81CA: C6 48          LDB    #$C0
81CC: B6 7C 87       LDA    $540F
81CF: 26 20          BNE    $81D3
81D1: C6 C2          LDB    #$40
81D3: A7 2D          STA    $F,X
81D5: 10 8E 7C 37    LDY    #$FE1F
81D9: 10 AF 83       STY    $B,X
81DC: 6F 22          CLR    $A,X
81DE: 86 89          LDA    #$01
81E0: A7 21          STA    $3,X
81E2: BD F9 3C       JSR    $7B1E
81E5: 7E E2 95       JMP    $6017
81E8: BD AA 18       JSR    $8290
81EB: 0D 48          TST    $60
81ED: 26 C9          BNE    $8230
81EF: 0D 43          TST    $61
81F1: 26 BC          BNE    $8231
81F3: 10 AE AA 90    LDY    $12,X
81F7: E6 2F          LDB    $7,X
81F9: EB 81          ADDB   $9,X
81FB: E7 2F          STB    $7,X
81FD: 24 98          BCC    $820F
81FF: 97 42          STA    $60
8201: F6 D6 8D       LDB    $540F
8204: 57             ASRB
8205: D8 E2          EORB   $60
8207: 26 2C          BNE    $820D
8209: 31 AA          LEAY   $2,Y
820B: 20 2A          BRA    $820F
820D: 31 B6          LEAY   -$2,Y
820F: 10 AF AA 90    STY    $12,X
8213: 7D 76 22       TST    $5400
8216: 27 8C          BEQ    $8226
8218: EC 8C          LDD    ,Y
821A: 9B 14          ADDA   $9C
821C: DB B5          ADDB   $9D
821E: ED 8C          STD    $4,X
8220: BD 59 9C       JSR    $7B1E
8223: 7E 42 35       JMP    $6017
8226: 86 80          LDA    #$02
8228: A7 2B          STA    $3,X
822A: 6F 00 36       CLR    $1E,X
822D: 7E F3 01       JMP    $7B89
8230: 39             RTS
8231: E6 86          LDB    $4,X
8233: A6 2D          LDA    $F,X
8235: 26 86          BNE    $823B
8237: CB 2C          ADDB   #$04
8239: 20 8A          BRA    $823D
823B: C0 2C          SUBB   #$04
823D: E7 8C          STB    $4,X
823F: 10 8E DE 02    LDY    #$FC80
8243: BD 42 1F       JSR    $603D
8246: D6 1F          LDB    $9D
8248: E7 2D          STB    $5,X
824A: 6F 82          CLR    $A,X
824C: 6F 2B          CLR    $3,X
824E: 10 8E 75 22    LDY    #$5700
8252: EC 86          LDD    $4,X
8254: 6D 86          TST    ,Y
8256: 27 98          BEQ    $8272
8258: E1 0B          CMPB   $3,Y
825A: 26 86          BNE    $826A
825C: 8B 20          ADDA   #$08
825E: A0 A9          SUBA   $1,Y
8260: 97 42          STA    $60
8262: E6 A0          LDB    $2,Y
8264: E0 03          SUBB   $1,Y
8266: D1 E2          CMPB   $60
8268: 24 20          BCC    $8272
826A: 31 AC          LEAY   $4,Y
826C: 10 8C DF D7    CMPY   #$575F
8270: 25 C2          BCS    $8252
8272: 1F A2          TFR    Y,D
8274: 83 75 82       SUBD   #$5700
8277: 54             LSRB
8278: 54             LSRB
8279: E7 00 95       STB    $1D,X
827C: 39             RTS
827D: 47             ASRA
827E: 24 80          BCC    $8288
8280: 6A 26          DEC    $4,X
8282: BD F9 3C       JSR    $7B1E
8285: 7E E2 95       JMP    $6017
8288: 6C 2C          INC    $4,X
828A: BD F3 36       JSR    $7B1E
828D: 7E E8 9F       JMP    $6017
8290: 0F 42          CLR    $60
8292: 0F E3          CLR    $61
8294: 7D 76 8D       TST    $540F
8297: 26 2E          BNE    $829F
8299: 6D 87          TST    $F,X
829B: 26 1B          BNE    $82D0
829D: 20 AA          BRA    $82C1
829F: 6D 2D          TST    $F,X
82A1: 27 8D          BEQ    $82B2
82A3: E6 26          LDB    $4,X
82A5: CB 92          ADDB   #$10
82A7: D0 B6          SUBB   $9E
82A9: C1 80          CMPB   #$08
82AB: 22 2C          BHI    $82B1
82AD: C6 89          LDB    #$01
82AF: D7 42          STB    $60
82B1: 39             RTS
82B2: E6 86          LDB    $4,X
82B4: CB 26          ADDB   #$04
82B6: D0 1E          SUBB   $9C
82B8: C1 20          CMPB   #$08
82BA: 22 8C          BHI    $82C0
82BC: C6 29          LDB    #$01
82BE: D7 E9          STB    $61
82C0: 39             RTS
82C1: E6 86          LDB    $4,X
82C3: C0 2A          SUBB   #$08
82C5: D0 1C          SUBB   $9E
82C7: C1 20          CMPB   #$08
82C9: 22 8C          BHI    $82CF
82CB: C6 29          LDB    #$01
82CD: D7 E8          STB    $60
82CF: 39             RTS
82D0: E6 26          LDB    $4,X
82D2: CB 86          ADDB   #$04
82D4: D0 BE          SUBB   $9C
82D6: C1 8A          CMPB   #$08
82D8: 22 2C          BHI    $82DE
82DA: C6 89          LDB    #$01
82DC: D7 49          STB    $61
82DE: 39             RTS
82DF: 4F             CLRA
82E0: 5F             CLRB
82E1: ED 0A 9A       STD    $18,X
82E4: ED AA 98       STD    $1A,X
82E7: 8D 2F          BSR    $82F0
82E9: BD 0B 97       JSR    $831F
82EC: BD AB CC       JSR    $8344
82EF: 39             RTS
82F0: 10 8E D5 82    LDY    #$5700
82F4: 6D 86          TST    ,Y
82F6: 27 A4          BEQ    $831E
82F8: A6 0A          LDA    $2,Y
82FA: A0 A9          SUBA   $1,Y
82FC: 97 48          STA    $60
82FE: A6 8C          LDA    $4,X
8300: 8B 2A          ADDA   #$08
8302: A0 A3          SUBA   $1,Y
8304: 91 42          CMPA   $60
8306: 22 8A          BHI    $8310
8308: A6 2D          LDA    $5,X
830A: A0 AB          SUBA   $3,Y
830C: 81 20          CMPA   #$08
830E: 23 81          BLS    $8319
8310: 31 06          LEAY   $4,Y
8312: 10 8C 75 7D    CMPY   #$575F
8316: 25 5E          BCS    $82F4
8318: 39             RTS
8319: 86 89          LDA    #$01
831B: A7 A0 30       STA    $18,X
831E: 39             RTS
831F: 7D 76 2D       TST    $540F
8322: 26 92          BNE    $8334
8324: A6 26          LDA    $4,X
8326: 80 8A          SUBA   #$08
8328: 90 B6          SUBA   $9E
832A: 81 80          CMPA   #$08
832C: 22 2D          BHI    $8333
832E: 86 89          LDA    #$01
8330: A7 AA 9B       STA    $19,X
8333: 39             RTS
8334: A6 26          LDA    $4,X
8336: 8B 92          ADDA   #$10
8338: 90 B6          SUBA   $9E
833A: 81 80          CMPA   #$08
833C: 22 DD          BHI    $8333
833E: 86 89          LDA    #$01
8340: A7 AA 9B       STA    $19,X
8343: 39             RTS
8344: 8D 31          BSR    $8359
8346: 8D 81          BSR    $834B
8348: 7E AB EF       JMP    $8367
834B: A6 2C          LDA    $4,X
834D: 8B 84          ADDA   #$0C
834F: 81 D0          CMPA   #$F2
8351: 22 87          BHI    $8358
8353: 86 23          LDA    #$01
8355: A7 0A 99       STA    $1B,X
8358: 39             RTS
8359: A6 8C          LDA    $4,X
835B: 8B 2C          ADDA   #$04
835D: 81 98          CMPA   #$10
835F: 23 27          BLS    $8366
8361: 86 83          LDA    #$01
8363: A7 AA 38       STA    $1A,X
8366: 39             RTS
8367: 4F             CLRA
8368: E6 2D          LDB    $5,X
836A: CB 98          ADDB   #$10
836C: C1 C8          CMPB   #$E0
836E: 25 60          BCS    $8358
8370: 7D 76 8D       TST    $540F
8373: 26 26          BNE    $8379
8375: A7 0A 99       STA    $1B,X
8378: 39             RTS
8379: A7 00 92       STA    $1A,X
837C: 39             RTS
837D: 8D 88          BSR    $837F
837F: E6 25          LDB    $7,X
8381: CB 7D          ADDB   #$FF
8383: E7 25          STB    $7,X
8385: 25 83          BCS    $8388
8387: 39             RTS
8388: 10 8E DF 88    LDY    #$5700
838C: 6D 8C          TST    ,Y
838E: 27 96          BEQ    $83AE
8390: A6 27          LDA    $5,X
8392: A1 A1          CMPA   $3,Y
8394: 26 32          BNE    $83A6
8396: E6 86          LDB    $4,X
8398: CB 20          ADDB   #$08
839A: E0 A9          SUBB   $1,Y
839C: D7 48          STB    $60
839E: E6 AA          LDB    $2,Y
83A0: E0 03          SUBB   $1,Y
83A2: D1 E2          CMPB   $60
83A4: 24 52          BCC    $8416
83A6: 31 A6          LEAY   $4,Y
83A8: 10 8C DF D7    CMPY   #$575F
83AC: 25 F6          BCS    $838C
83AE: 96 49          LDA    $C1
83B0: 84 21          ANDA   #$03
83B2: 81 80          CMPA   #$02
83B4: 10 26 82 B7    LBNE   $83ED
83B8: 10 8E DE 08    LDY    #$5680
83BC: 6D 8C          TST    ,Y
83BE: 27 A5          BEQ    $83ED
83C0: A6 8A 94       LDA    $16,Y
83C3: 31 8A 3B       LEAY   $19,Y
83C6: E6 86          LDB    $4,X
83C8: CB 20          ADDB   #$08
83CA: D7 E8          STB    $60
83CC: E6 2D          LDB    $5,X
83CE: E0 AA          SUBB   $2,Y
83D0: CB 20          ADDB   #$02
83D2: C1 84          CMPB   #$06
83D4: 22 30          BHI    $83E8
83D6: D6 E2          LDB    $60
83D8: E0 8C          SUBB   ,Y
83DA: CB 8E          ADDB   #$06
83DC: D7 49          STB    $61
83DE: E6 A9          LDB    $1,Y
83E0: E0 86          SUBB   ,Y
83E2: CB 8E          ADDB   #$0C
83E4: D1 43          CMPB   $61
83E6: 24 8D          BCC    $83F7
83E8: 31 0B          LEAY   $3,Y
83EA: 4A             DECA
83EB: 26 F7          BNE    $83CC
83ED: 6D 8D          TST    $5,X
83EF: 27 07          BEQ    $8416
83F1: 6C 0A 9C       INC    $1E,X
83F4: 6A 27          DEC    $5,X
83F6: 39             RTS
83F7: 10 BF 7E 1F    STY    $5697
83FB: A6 0A          LDA    $2,Y
83FD: A7 8D          STA    $5,X
83FF: A6 AA 3C       LDA    $1E,X
8402: 81 92          CMPA   #$10
8404: 22 39          BHI    $8421
8406: 6F 0A 36       CLR    $1E,X
8409: 86 8B          LDA    #$03
840B: A7 2B          STA    $3,X
840D: 96 E9          LDA    $61
840F: 80 32          SUBA   #$10
8411: B7 D3 56       STA    $51D4
8414: 20 0E          BRA    $8442
8416: 6D 87          TST    $5,X
8418: 27 2F          BEQ    $8421
841A: A6 00 36       LDA    $1E,X
841D: 81 98          CMPA   #$10
841F: 23 29          BLS    $842C
8421: 86 80          LDA    #$02
8423: 97 27          STA    $05
8425: 0F 8A          CLR    $08
8427: 0F 23          CLR    $0B
8429: 0F 86          CLR    $0E
842B: 39             RTS
842C: 1F 08          TFR    Y,D
842E: 83 DF 22       SUBD   #$5700
8431: 54             LSRB
8432: 54             LSRB
8433: E7 AA 3F       STB    $1D,X
8436: 6F 81          CLR    $3,X
8438: 6F A0 96       CLR    $1E,X
843B: A6 0B          LDA    $3,Y
843D: A7 8D          STA    $5,X
843F: BD 5D 79       JSR    $7F5B
8442: 86 81          LDA    #$03
8444: A7 2D          STA    $F,X
8446: 10 8E D4 A8    LDY    #$FC80
844A: BD E8 15       JSR    $603D
844D: 6F 82          CLR    $A,X
844F: BD 42 35       JSR    $6017
8452: 7E F9 AF       JMP    $7B8D
8455: 6D 0A A2       TST    $20,X
8458: 26 44          BNE    $84C6
845A: EC 8C          LDD    $4,X
845C: 5D             TSTB
845D: 10 27 88 B5    LBEQ   $84F8
8461: 81 E2          CMPA   #$60
8463: 22 2E          BHI    $8471
8465: C1 2D          CMPB   #$AF
8467: 10 22 28 05    LBHI   $84F8
846B: C1 12          CMPB   #$3A
846D: 10 25 88 54    LBCS   $84E7
8471: 96 B8          LDA    $3A
8473: 27 73          BEQ    $84C6
8475: 85 8E          BITA   #$0C
8477: 26 65          BNE    $84C6
8479: 85 89          BITA   #$01
847B: 26 20          BNE    $8485
847D: 85 8A          BITA   #$02
847F: 27 67          BEQ    $84C6
8481: 86 82          LDA    #$00
8483: 20 20          BRA    $8487
8485: 86 80          LDA    #$02
8487: A1 27          CMPA   $F,X
8489: 27 99          BEQ    $849C
848B: A7 27          STA    $F,X
848D: 10 8E 74 A2    LDY    #$FC80
8491: BD E2 BF       JSR    $603D
8494: 6F 28          CLR    $A,X
8496: BD E2 3F       JSR    $6017
8499: BD F3 96       JSR    $7B1E
849C: A6 2E          LDA    $6,X
849E: AB 80          ADDA   $8,X
84A0: A7 24          STA    $6,X
84A2: 24 A0          BCC    $84C6
84A4: A6 26          LDA    $4,X
84A6: 6D 8D          TST    $F,X
84A8: 27 27          BEQ    $84B9
84AA: 81 84          CMPA   #$0C
84AC: 25 30          BCS    $84C6
84AE: 6A 00 36       DEC    $14,X
84B1: BD E2 95       JSR    $6017
84B4: BD 59 9C       JSR    $7B1E
84B7: 20 25          BRA    $84C6
84B9: 81 7A          CMPA   #$F2
84BB: 22 21          BHI    $84C6
84BD: 6C 00 9C       INC    $14,X
84C0: BD 42 95       JSR    $6017
84C3: BD 59 3C       JSR    $7B1E
84C6: 10 BE 7E BF    LDY    $5697
84CA: A6 2C          LDA    ,Y
84CC: AB A0 9C       ADDA   $14,X
84CF: A7 26          STA    $4,X
84D1: E6 A0          LDB    $2,Y
84D3: E7 27          STB    $5,X
84D5: 8B 8A          ADDA   #$08
84D7: A0 8C          SUBA   ,Y
84D9: 8B 80          ADDA   #$08
84DB: 97 49          STA    $61
84DD: A6 A9          LDA    $1,Y
84DF: A0 86          SUBA   ,Y
84E1: 8B 92          ADDA   #$10
84E3: 91 43          CMPA   $61
84E5: 22 92          BHI    $84F7
84E7: 86 2A          LDA    #$02
84E9: A7 8B          STA    $3,X
84EB: 6F A0 36       CLR    $1E,X
84EE: 6A 8D          DEC    $5,X
84F0: 6A 27          DEC    $5,X
84F2: 6A 87          DEC    $5,X
84F4: 7E 59 0B       JMP    $7B89
84F7: 39             RTS
84F8: BD 53 19       JSR    $7B91
84FB: 86 2A          LDA    #$02
84FD: 5F             CLRB
84FE: 97 8D          STA    $05
8500: D7 2A          STB    $08
8502: D7 89          STB    $0B
8504: D7 2C          STB    $0E
8506: 39             RTS
8507: 8E 7D 48       LDX    #$5560
850A: 6D 0C          TST    ,X
850C: 27 21          BEQ    $8517
850E: 6D 00 32       TST    $10,X
8511: 26 87          BNE    $8518
8513: 86 23          LDA    #$01
8515: A7 83          STA    $1,X
8517: 39             RTS
8518: 6A A0 98       DEC    $10,X
851B: 39             RTS
851C: 8E 7C 88       LDX    #$5400
851F: 6D A6          TST    ,X
8521: 27 8B          BEQ    $852C
8523: 10 8E A7 AF    LDY    #jump_table_852D
8527: A6 2B          LDA    $3,X
8529: 48             ASLA
852A: 6E 3E          JMP    [A,Y]        ; [indirect_jump]
852C: 39             RTS
852D: AD BB          JSR    -$D,Y
852F: 0D 0E          TST    $2C
8531: A7 6E 8E       STA    $8540,PCR
8534: 76 22 A6       ROR    >$0024
8537: 86 80          LDA    #$A8
8539: 3E             XRES
853A: 81 4E          CMPA   #$C6
853C: 22 04          BHI    $856A
853E: A6 8D          LDA    $5,X
8540: 81 FA          CMPA   #$D8
8542: 22 A4          BHI    $856A
8544: 7D 73 4D       TST    $51CF
8547: 26 2F          BNE    $8550
8549: A6 8C          LDA    $4,X
854B: B0 79 EC       SUBA   $51C4
854E: 20 8D          BRA    $8555
8550: B6 73 46       LDA    $51C4
8553: A0 26          SUBA   $4,X
8555: 81 22          CMPA   #$A0
8557: 24 39          BCC    $856A
8559: C6 82          LDB    #$0A
855B: 34 2C          PSHS   B
855D: 8D A4          BSR    $858B
855F: 8D 08          BSR    $858B
8561: 30 0A A2       LEAX   $20,X
8564: 6A C6          DEC    ,S
8566: 26 77          BNE    $855D
8568: 35 AC          PULS   B,PC
856A: 4F             CLRA
856B: 5F             CLRB
856C: 1F 2B          TFR    D,U
856E: C6 89          LDB    #$01
8570: E7 23          STB    $1,X
8572: EF 86          STU    $4,X
8574: A7 21          STA    $3,X
8576: A7 0A 37       STA    $1F,X
8579: 30 00 A8       LEAX   $20,X
857C: 8C 7D D7       CMPX   #$555F
857F: 25 CF          BCS    $856E
8581: 97 02          STA    $80
8583: CC DD DD       LDD    #$FFFF
8586: DD 1E          STD    $9C
8588: DD B6          STD    $9E
858A: 39             RTS
858B: 6D 2B          TST    $3,X
858D: 26 A9          BNE    $85B0
858F: 10 AE AA 90    LDY    $12,X
8593: A6 24          LDA    $6,X
8595: AB 8A          ADDA   $8,X
8597: A7 2E          STA    $6,X
8599: 24 8A          BCC    $859D
859B: 31 0A          LEAY   $2,Y
859D: 10 AF 00 30    STY    $12,X
85A1: EC 26          LDD    ,Y
85A3: BB 73 E6       ADDA   $51C4
85A6: FB D3 ED       ADDB   $51C5
85A9: CB 8D          ADDB   #$05
85AB: ED 2C          STD    $4,X
85AD: 7E E8 9F       JMP    $6017
85B0: 31 AA 62       LEAY   -$20,X
85B3: A6 2D          LDA    $F,X
85B5: 81 80          CMPA   #$02
85B7: 27 2E          BEQ    $85BF
85B9: A6 AC          LDA    $4,Y
85BB: A0 2C          SUBA   $4,X
85BD: 20 8C          BRA    $85C3
85BF: A6 26          LDA    $4,X
85C1: A0 A6          SUBA   $4,Y
85C3: 81 32          CMPA   #$10
85C5: 25 A6          BCS    $85EB
85C7: CC 29 28       LDD    #$0100
85CA: ED 0C          STD    ,X
85CC: 6F 2B          CLR    $3,X
85CE: 6F 00 3D       CLR    $1F,X
85D1: B6 D3 4D       LDA    $51CF
85D4: A7 2D          STA    $F,X
85D6: FC D3 EC       LDD    $51C4
85D9: CB 8C          ADDB   #$04
85DB: ED 2C          STD    $4,X
85DD: A6 87          LDA    $F,X
85DF: 10 8E A4 FF    LDY    #$867D
85E3: BD 42 1F       JSR    $603D
85E6: 6F 88          CLR    $A,X
85E8: 7E 48 9F       JMP    $6017
85EB: 39             RTS
85EC: 8E 7C 88       LDX    #$5400
85EF: 86 28          LDA    #$0A
85F1: 34 80          PSHS   A
85F3: 6D A6          TST    ,X
85F5: 27 88          BEQ    $8601
85F7: A6 A0 37       LDA    $1F,X
85FA: 48             ASLA
85FB: 10 8E AE 82    LDY    #jump_table_860a
85FF: AD 94          JSR    [A,Y]        ; [indirect_jump]
8601: 30 0A A2       LEAX   $20,X
8604: 6A C6          DEC    ,S
8606: 26 69          BNE    $85F3
8608: 35 AA          PULS   A,PC
860A: 0E 98          JMP    $10
860C: AE 7D          LDX    -$B,U
860E: 0E F8          JMP    $70
8610: A6 27          LDA    $5,X
8612: A7 0A 33       STA    $11,X
8615: CE 04 B7       LDU    #$8635
8618: 96 EA          LDA    $C2
861A: A6 4E          LDA    A,U
861C: A7 A0 98       STA    $10,X
861F: 6C AA 3D       INC    $1F,X
8622: 39             RTS
8623: 82 23          SBCA   #$01
8625: 20 80          BRA    $8629
8627: 82 D7          SBCA   #$FF
8629: D6 77          LDB    $FF
862B: 88 28          EORA   #$00
862D: 29 8A          BVS    $8631
862F: 8B 22          ADDA   #$00
8631: DD 7C          STD    $FE
8633: 7D 22 32       TST    >$0010
8636: 93 90          SUBD   $12
8638: 3B             RTI
8639: 3C 9D          CWAI   #$15
863B: 9E 3F          LDX    $17
863D: 30 91          LEAX   -$7,X
863F: 92 39          SBCA   $1B
8641: 3E             XRES
8642: 9F 9C          STX    $1E
8644: 3D             MUL
8645: 02 A2          XNC    $20
8647: A2 08          SBCA   $0,Y
8649: 09 A9          ROL    $21
864B: A9 09          ADCA   $1,Y
864D: 0A AA          DEC    $22
864F: AA 00          ORA    $2,Y
8651: 01 A1          NEG    $23
8653: A1 01          CMPA   $3,Y
8655: 6D 0A 92       TST    $10,X
8658: 27 3A          BEQ    $866C
865A: 6A 00 38       DEC    $10,X
865D: CE 0E AB       LDU    #$8623
8660: 96 6D          LDA    $4F
8662: 84 8D          ANDA   #$0F
8664: A6 E4          LDA    A,U
8666: AB 0A 39       ADDA   $11,X
8669: A7 8D          STA    $5,X
866B: 39             RTS
866C: 6C A0 97       INC    $1F,X
866F: 39             RTS
8670: 6F AA 9D       CLR    $1F,X
8673: 86 23          LDA    #$01
8675: A7 81          STA    $3,X
8677: A6 A0 39       LDA    $11,X
867A: A7 8D          STA    $5,X
867C: 39             RTS

86D7: 04 FB          LSR    $D3
86D9: 8E D9 68       LDX    #$51E0
86DC: 10 8E D9 48    LDY    #$51C0
86E0: 6D A6          TST    ,X
86E2: 27 81          BEQ    $86E7
86E4: 7E A4 6A       JMP    $86E8
86E7: 39             RTS
86E8: A6 0B          LDA    $3,Y
86EA: 81 8A          CMPA   #$02
86EC: 27 65          BEQ    $873B
86EE: EC AC          LDD    $4,Y
86F0: CB 20          ADDB   #$02
86F2: E7 87          STB    $5,X
86F4: E6 0D          LDB    $F,Y
86F6: 27 96          BEQ    $870C
86F8: C1 2A          CMPB   #$02
86FA: 27 84          BEQ    $8708
86FC: D6 12          LDB    $3A
86FE: C5 89          BITB   #$01
8700: 26 24          BNE    $8708
8702: C5 80          BITB   #$02
8704: 26 24          BNE    $870C
8706: 20 B1          BRA    $873B
8708: 80 23          SUBA   #$0B
870A: 20 8A          BRA    $870E
870C: 8B 23          ADDA   #$0B
870E: A7 8C          STA    $4,X
8710: 96 6D          LDA    $4F
8712: 84 8D          ANDA   #$0F
8714: 97 42          STA    $60
8716: A6 8C          LDA    $E,X
8718: 84 D8          ANDA   #$F0
871A: 9A E8          ORA    $60
871C: A7 26          STA    $E,X
871E: 7E E8 35       JMP    $6017

8752: 82 82          SBCA   #$00
8754: 2B E2          BMI    $8716
8756: 7D 7D AF       TST    $FF87
8759: 7C 81 C8       INC    $0940
875C: D7 D7          STB    $FF
875E: 0F D2          CLR    $5A
8760: 2B 22          BMI    $8762
8762: 7D 7D A5       TST    $FF87
8765: 42             XNCA
8766: 8B 02          ADDA   #$80
8768: D7 D7          STB    $FF
876A: 0F EE          CLR    $66
876C: 10 8E 0F F3    LDY    #$877B
8770: 96 62          LDA    $40
8772: 84 8D          ANDA   #$0F
8774: 0C 62          INC    $40
8776: A6 24          LDA    A,Y
8778: 97 6A          STA    $42
877A: 39             RTS

878C: 48             ASLA
878D: A6 00 94       LDA    $1C,X
8790: 48             ASLA
8791: 48             ASLA
8792: 10 8E 75 22    LDY    #$5700
8796: 31 24          LEAY   A,Y
8798: A6 27          LDA    $F,X
879A: 81 8A          CMPA   #$02
879C: 26 27          BNE    $87AD
879E: A6 8C          LDA    $4,X
87A0: 8B 2A          ADDA   #$08
87A2: A0 A3          SUBA   $1,Y
87A4: 81 2A          CMPA   #$08
87A6: 23 93          BLS    $87B9
87A8: 86 29          LDA    #$01
87AA: 97 E8          STA    $60
87AC: 39             RTS
87AD: A6 AA          LDA    $2,Y
87AF: A0 26          SUBA   $4,X
87B1: 81 8E          CMPA   #$0C
87B3: 23 26          BLS    $87B9
87B5: 86 83          LDA    #$01
87B7: 97 48          STA    $60
87B9: 39             RTS
87BA: EC 8C          LDD    $4,X
87BC: 81 A8          CMPA   #$80
87BE: 22 85          BHI    $87CD
87C0: 86 22          LDA    #$00
87C2: C1 E2          CMPB   #$60
87C4: 23 24          BLS    $87CC
87C6: 7D D1 38       TST    $5310
87C9: 27 89          BEQ    $87CC
87CB: 4C             INCA
87CC: 39             RTS
87CD: 86 8A          LDA    #$02
87CF: C1 42          CMPB   #$60
87D1: 23 84          BLS    $87D9
87D3: 7D 71 12       TST    $5330
87D6: 27 83          BEQ    $87D9
87D8: 4C             INCA
87D9: 39             RTS
87DA: 8E DA 28       LDX    #$5200
87DD: C6 8E          LDB    #$06
87DF: 34 36          PSHS   X,B
87E1: EC 06          LDD    ,X
87E3: 27 29          BEQ    $87F0
87E5: E6 81          LDB    $3,X
87E7: 10 8E AF 73    LDY    #jump_table_87fb
87EB: 58             ASLB
87EC: AD 9D          JSR    [B,Y]        ; [indirect_jump]
87EE: AE E9          LDX    $1,S
87F0: 30 AA A2       LEAX   $20,X
87F3: AF 43          STX    $1,S
87F5: 6A 66          DEC    ,S
87F7: 26 C0          BNE    $87E1
87F9: 35 1C          PULS   B,X,PC
87FB: 00 25          NEG    $0D
87FD: A2 11 03 5E    SBCA   [-$7484,X]
8801: AE 5B 0F 60    LDX    [-$72BE,U]
8805: AF 55          STX    [E,U]
8807: 12             NOP
8808: DA B9          ORB    $91
880A: 1A 1B          ORCC   #$93
880C: CC E6 00       LDD    #$CE88
880F: 97 58          STA    $7A
8811: 10 8E 0A 35    LDY    #jump_table_8817
8815: 6E 37          JMP    [B,Y]        ; [indirect_jump]
8817: 0A 37          DEC    $1F
8819: A2 FD          SBCA   -$B,S
881B: 02 A9          XNC    $81
881D: A2 05 EC 26    SBCA   $EC25,PCR
8821: D0 1F          SUBB   $9D
8823: CB 20          ADDB   #$02
8825: C1 86          CMPB   #$04
8827: 22 15          BHI    $8866
8829: 91 14          CMPA   $9C
882B: 26 11          BNE    $8866
882D: B6 D9 4B       LDA    $51C3
8830: 81 23          CMPA   #$01
8832: 10 26 23 AC    LBNE   $89C4
8836: 6D 80          TST    $2,X
8838: 27 3E          BEQ    $8850
883A: B6 D9 FD       LDA    $51D5
883D: 91 0D          CMPA   $85
883F: 23 2D          BLS    $8850
8841: 6D 80          TST    $2,X
8843: 27 29          BEQ    $8850
8845: B6 D3 46       LDA    $51C4
8848: A0 2C          SUBA   $4,X
884A: 8B A8          ADDA   #$20
884C: 81 68          CMPA   #$40
884E: 22 85          BHI    $885D
8850: 6D AA 99       TST    $1B,X
8853: 26 33          BNE    $8866
8855: 86 87          LDA    #$05
8857: A7 2B          STA    $3,X
8859: 6F 00 97       CLR    $1F,X
885C: 39             RTS
885D: CC 8C 88       LDD    #$0400
8860: A7 21          STA    $3,X
8862: E7 0A 3D       STB    $1F,X
8865: 39             RTS
8866: A6 80          LDA    $2,X
8868: 4A             DECA
8869: 27 A5          BEQ    $8898
886B: FC 79 EC       LDD    $51C4
886E: E1 8D          CMPB   $5,X
8870: 26 04          BNE    $8898
8872: A0 86          SUBA   $4,X
8874: 8B 3E          ADDA   #$1C
8876: 81 BA          CMPA   #$38
8878: 10 22 89 C0    LBHI   $89C4
887C: A6 27          LDA    $F,X
887E: 10 8E EC 92    LDY    #$CEB0
8882: E6 80          LDB    $2,X
8884: 58             ASLB
8885: 10 AE 27       LDY    B,Y
8888: BD 48 B5       JSR    $603D
888B: 6F 22          CLR    $A,X
888D: 86 89          LDA    #$01
888F: A7 21          STA    $3,X
8891: 6F 0A 9D       CLR    $1F,X
8894: 6F AA 98       CLR    $1A,X
8897: 39             RTS
8898: BD A7 35       JSR    $8FBD
889B: 96 49          LDA    $61
889D: 88 89          EORA   #$01
889F: A7 AA 3B       STA    $19,X
88A2: 27 84          BEQ    $88AA
88A4: BD A5 38       JSR    $87BA
88A7: A7 A0 36       STA    $1E,X
88AA: DC E8          LDD    $60
88AC: 27 26          BEQ    $88BC
88AE: A6 00 3F       LDA    $1D,X
88B1: 81 80          CMPA   #$02
88B3: 24 25          BCC    $88BC
88B5: A6 0A 9F       LDA    $1D,X
88B8: 81 20          CMPA   #$08
88BA: 25 EB          BCS    $891F
88BC: 6D A0 91       TST    $19,X
88BF: 26 27          BNE    $88C6
88C1: BD 0D 2A       JSR    $8FA8
88C4: 20 35          BRA    $88DD
88C6: E6 0A 36       LDB    $1E,X
88C9: 58             ASLB
88CA: 58             ASLB
88CB: 58             ASLB
88CC: 58             ASLB
88CD: 10 8E DB 22    LDY    #$5300
88D1: 31 27          LEAY   B,Y
88D3: E6 27          LDB    $5,X
88D5: E0 A7          SUBB   $5,Y
88D7: CB 2A          ADDB   #$02
88D9: C1 8C          CMPB   #$04
88DB: 23 6A          BLS    $891F
88DD: E6 AD          LDB    $5,Y
88DF: A6 AA 3E       LDA    $1C,X
88E2: 48             ASLA
88E3: 10 8E 75 42    LDY    #$57C0
88E7: 31 8E          LEAY   A,Y
88E9: E1 8D          CMPB   $5,X
88EB: 24 2C          BCC    $88F1
88ED: A6 A9          LDA    $1,Y
88EF: 20 20          BRA    $88F3
88F1: A6 26          LDA    ,Y
88F3: 27 08          BEQ    $891F
88F5: A0 86          SUBA   $4,X
88F7: 8B 2A          ADDA   #$02
88F9: 81 8C          CMPA   #$04
88FB: 22 0A          BHI    $891F
88FD: 6F 00 95       CLR    $1D,X
8900: A6 2D          LDA    $F,X
8902: 10 8E EC E2    LDY    #$CEC0
8906: E6 80          LDB    $2,X
8908: 58             ASLB
8909: 10 AE 2D       LDY    B,Y
890C: BD 48 B5       JSR    $603D
890F: 6F 28          CLR    $A,X
8911: BD E2 95       JSR    $6017
8914: 86 25          LDA    #$07
8916: A7 81          STA    $3,X
8918: 6F A0 97       CLR    $1F,X
891B: 6F A0 35       CLR    $1D,X
891E: 39             RTS
891F: A6 AA 39       LDA    $1B,X
8922: 26 B0          BNE    $8956
8924: 10 8E D3 42    LDY    #$51C0
8928: A6 0B          LDA    $3,Y
892A: 81 89          CMPA   #$01
892C: 26 00          BNE    $8956
892E: A6 20 37       LDA    $15,Y
8931: 81 88          CMPA   #$0A
8933: 25 03          BCS    $8956
8935: DC 1C          LDD    $9E
8937: CB 25          ADDB   #$0D
8939: E0 8D          SUBB   $5,X
893B: CB 2A          ADDB   #$02
893D: C1 8C          CMPB   #$04
893F: 22 37          BHI    $8956
8941: A0 86          SUBA   $4,X
8943: 8B 20          ADDA   #$02
8945: 81 86          CMPA   #$04
8947: 22 25          BHI    $8956
8949: CC 8D 8B       LDD    #$0503
894C: A7 2B          STA    $3,X
894E: E7 00 3D       STB    $1F,X
8951: C6 83          LDB    #$01
8953: E7 2D          STB    $F,X
8955: 39             RTS
8956: 6D 0A 31       TST    $19,X
8959: 27 AF          BEQ    $8982
895B: E6 A0 36       LDB    $1E,X
895E: 58             ASLB
895F: 58             ASLB
8960: 58             ASLB
8961: 58             ASLB
8962: 10 8E 71 22    LDY    #$5300
8966: 31 27          LEAY   B,Y
8968: EC 0C          LDD    $4,Y
896A: E1 8D          CMPB   $5,X
896C: 26 3C          BNE    $8982
896E: A0 8C          SUBA   $4,X
8970: 8B 20          ADDA   #$02
8972: 81 86          CMPA   #$04
8974: 22 2E          BHI    $8982
8976: EC A6          LDD    $4,Y
8978: ED 2C          STD    $4,X
897A: 86 8E          LDA    #$06
897C: A7 2B          STA    $3,X
897E: 6F 00 3D       CLR    $1F,X
8981: 39             RTS
8982: 10 8E 71 62    LDY    #$5340
8986: 86 81          LDA    #$03
8988: 97 48          STA    $60
898A: EC 8C          LDD    $4,X
898C: 8B 20          ADDA   #$08
898E: CB 80          ADDB   #$08
8990: DD 40          STD    $62
8992: 6D 26          TST    ,Y
8994: 27 3E          BEQ    $89B2
8996: A6 A1          LDA    $3,Y
8998: 81 2D          CMPA   #$05
899A: 27 9E          BEQ    $89B2
899C: EC 0C          LDD    $4,Y
899E: 8B 80          ADDA   #$08
89A0: CB 2A          ADDB   #$08
89A2: 90 E0          SUBA   $62
89A4: 8B 2A          ADDA   #$08
89A6: 81 92          CMPA   #$10
89A8: 22 20          BHI    $89B2
89AA: D0 EB          SUBB   $63
89AC: CB 20          ADDB   #$08
89AE: C1 98          CMPB   #$10
89B0: 23 2B          BLS    $89BB
89B2: 31 2A 02       LEAY   $20,Y
89B5: 0A E2          DEC    $60
89B7: 26 F1          BNE    $8992
89B9: 20 81          BRA    $89C4
89BB: CC 2A 28       LDD    #$0200
89BE: A7 8B          STA    $3,X
89C0: E7 AA 9D       STB    $1F,X
89C3: 39             RTS
89C4: 96 6D          LDA    $4F
89C6: 85 9D          BITA   #$1F
89C8: 26 1E          BNE    $8A00
89CA: BD 0F 44       JSR    $876C
89CD: 85 89          BITA   #$01
89CF: 26 0D          BNE    $8A00
89D1: C6 A2          LDB    #$20
89D3: A6 20          LDA    $2,X
89D5: 81 80          CMPA   #$02
89D7: 27 2A          BEQ    $89DB
89D9: C6 C8          LDB    #$40
89DB: D5 67          BITB   $4F
89DD: 10 26 88 A5    LBNE   $8A68
89E1: 86 80          LDA    #$02
89E3: A8 2D          EORA   $F,X
89E5: A7 8D          STA    $F,X
89E7: 10 8E E6 2C    LDY    #$CEA4
89EB: E6 2A          LDB    $2,X
89ED: 58             ASLB
89EE: 10 AE 87       LDY    B,Y
89F1: BD E2 BF       JSR    $603D
89F4: 6F 28          CLR    $A,X
89F6: 86 86          LDA    #$04
89F8: A7 A0 98       STA    $10,X
89FB: 86 2B          LDA    #$03
89FD: A7 00 97       STA    $1F,X
8A00: A6 24          LDA    $6,X
8A02: AB 8A          ADDA   $8,X
8A04: A7 24          STA    $6,X
8A06: 25 83          BCS    $8A09
8A08: 39             RTS
8A09: BD 0F 03       JSR    $878B
8A0C: 0D 48          TST    $60
8A0E: 26 CB          BNE    $8A53
8A10: 7D 73 41       TST    $51C3
8A13: 26 35          BNE    $8A2C
8A15: B6 D3 5F       LDA    $51DD
8A18: A1 A0 94       CMPA   $1C,X
8A1B: 26 27          BNE    $8A2C
8A1D: FC D9 4C       LDD    $51C4
8A20: E1 27          CMPB   $5,X
8A22: 26 8A          BNE    $8A2C
8A24: A0 26          SUBA   $4,X
8A26: 8B 92          ADDA   #$10
8A28: 81 36          CMPA   #$1E
8A2A: 23 AF          BLS    $8A53
8A2C: 96 67          LDA    $4F
8A2E: 84 C8          ANDA   #$40
8A30: 27 2B          BEQ    $8A3B
8A32: CC 8A 22       LDD    #$0800
8A35: A7 81          STA    $3,X
8A37: E7 A0 37       STB    $1F,X
8A3A: 39             RTS
8A3B: 86 2A          LDA    #$02
8A3D: A8 87          EORA   $F,X
8A3F: A7 2D          STA    $F,X
8A41: 10 8E 4C 86    LDY    #$CEA4
8A45: E6 80          LDB    $2,X
8A47: 58             ASLB
8A48: 10 AE 2D       LDY    B,Y
8A4B: BD 48 15       JSR    $603D
8A4E: 6F 82          CLR    $A,X
8A50: 6C AA 9F       INC    $1D,X
8A53: BD 42 35       JSR    $6017
8A56: A6 8D          LDA    $F,X
8A58: 27 20          BEQ    $8A62
8A5A: 81 8A          CMPA   #$02
8A5C: 27 2F          BEQ    $8A65
8A5E: 86 88          LDA    #$00
8A60: A7 2D          STA    $F,X
8A62: 6C 86          INC    $4,X
8A64: 39             RTS
8A65: 6A 86          DEC    $4,X
8A67: 39             RTS
8A68: 86 38          LDA    #$10
8A6A: A7 00 38       STA    $10,X
8A6D: 86 8B          LDA    #$03
8A6F: A7 AA 3D       STA    $1F,X
8A72: 7E 08 AF       JMP    $8A8D
8A75: BD E2 95       JSR    $6017
8A78: 6A A0 98       DEC    $10,X
8A7B: 26 2B          BNE    $8A80
8A7D: 6C 00 97       INC    $1F,X
8A80: 39             RTS
8A81: 6A 0A 92       DEC    $10,X
8A84: 27 21          BEQ    $8A89
8A86: 7E 0B EC       JMP    $89C4
8A89: 6F 00 97       CLR    $1F,X
8A8C: 39             RTS
8A8D: 6A 00 98       DEC    $10,X
8A90: 27 21          BEQ    $8A95
8A92: 7E E2 35       JMP    $6017
8A95: 6F 0A 9D       CLR    $1F,X
8A98: 39             RTS
8A99: A6 00 97       LDA    $1F,X
8A9C: 48             ASLA
8A9D: 10 8E 02 81    LDY    #jump_table_8aa3
8AA1: 6E 34          JMP    [A,Y]        ; [indirect_jump] [nb_entries=1]

8AA5: E6 0A 9E       LDB    $1C,X
8AA8: 58             ASLB
8AA9: 58             ASLB
8AAA: 10 8E 7F 28    LDY    #$5700
8AAE: 31 2D          LEAY   B,Y
8AB0: A6 26          LDA    $4,X
8AB2: B0 D3 E6       SUBA   $51C4
8AB5: 8B 9E          ADDA   #$1C
8AB7: 81 10          CMPA   #$38
8AB9: 23 A0          BLS    $8AE3
8ABB: A6 2D          LDA    $5,X
8ABD: A1 AB          CMPA   $3,Y
8ABF: 22 00          BHI    $8AE3
8AC1: 34 A2          PSHS   Y
8AC3: A6 2D          LDA    $F,X
8AC5: E6 80          LDB    $2,X
8AC7: 58             ASLB
8AC8: 10 8E 46 2C    LDY    #$CEA4
8ACC: 10 AE 2D       LDY    B,Y
8ACF: BD 42 1F       JSR    $603D
8AD2: 6F 88          CLR    $A,X
8AD4: 35 02          PULS   Y
8AD6: A6 A1          LDA    $3,Y
8AD8: A7 2D          STA    $5,X
8ADA: 6F 00 37       CLR    $1F,X
8ADD: 6F 8B          CLR    $3,X
8ADF: 6F AA 38       CLR    $1A,X
8AE2: 39             RTS
8AE3: A6 2A          LDA    $8,X
8AE5: 44             LSRA
8AE6: AB 84          ADDA   $6,X
8AE8: A7 2E          STA    $6,X
8AEA: 24 B6          BCC    $8B2A
8AEC: BD AF 03       JSR    $878B
8AEF: 0D 42          TST    $60
8AF1: 26 AF          BNE    $8B20
8AF3: 7D 73 E1       TST    $51C3
8AF6: 26 91          BNE    $8B0B
8AF8: B6 79 55       LDA    $51DD
8AFB: A1 A0 34       CMPA   $1C,X
8AFE: 26 83          BNE    $8B0B
8B00: B6 73 46       LDA    $51C4
8B03: A0 26          SUBA   $4,X
8B05: 8B 92          ADDA   #$10
8B07: 81 08          CMPA   #$20
8B09: 23 9D          BLS    $8B20
8B0B: A6 27          LDA    $F,X
8B0D: 88 8A          EORA   #$02
8B0F: A7 2D          STA    $F,X
8B11: 10 8E 4C 92    LDY    #$CEB0
8B15: E6 80          LDB    $2,X
8B17: 58             ASLB
8B18: 10 AE 2D       LDY    B,Y
8B1B: BD 48 15       JSR    $603D
8B1E: 6F 82          CLR    $A,X
8B20: 6D 2D          TST    $F,X
8B22: 26 86          BNE    $8B28
8B24: 6C 26          INC    $4,X
8B26: 20 80          BRA    $8B2A
8B28: 6A 2C          DEC    $4,X
8B2A: 6D 00 32       TST    $1A,X
8B2D: 26 96          BNE    $8B4D
8B2F: EC AA 34       LDD    $16,X
8B32: A3 0A 36       SUBD   $14,X
8B35: ED 0A 94       STD    $16,X
8B38: 81 38          CMPA   #$10
8B3A: 22 8B          BHI    $8B3F
8B3C: 6C A0 92       INC    $1A,X
8B3F: A6 AA 34       LDA    $16,X
8B42: AB 85          ADDA   $7,X
8B44: A7 25          STA    $7,X
8B46: 24 80          BCC    $8B4A
8B48: 6C 2D          INC    $5,X
8B4A: 7E E8 3F       JMP    $6017
8B4D: EC 00 9E       LDD    $16,X
8B50: E3 AA 96       ADDD   $14,X
8B53: ED AA 34       STD    $16,X
8B56: 81 72          CMPA   #$F0
8B58: 25 2B          BCS    $8B5D
8B5A: 6A 00 32       DEC    $1A,X
8B5D: A6 00 9E       LDA    $16,X
8B60: AB 25          ADDA   $7,X
8B62: A7 85          STA    $7,X
8B64: 24 31          BCC    $8B79
8B66: A6 0A 34       LDA    $1C,X
8B69: 48             ASLA
8B6A: 48             ASLA
8B6B: 10 8E 7F 88    LDY    #$5700
8B6F: 31 84          LEAY   A,Y
8B71: A6 87          LDA    $5,X
8B73: A1 01          CMPA   $3,Y
8B75: 23 80          BLS    $8B79
8B77: 6A 2D          DEC    $5,X
8B79: 7E E8 9F       JMP    $6017
8B7C: A6 A0 97       LDA    $1F,X
8B7F: 48             ASLA
8B80: 10 8E 09 04    LDY    #jump_table_8b86
8B84: 6E 94          JMP    [A,Y]        ; [indirect_jump]
8B86: 09 0E          ROL    $8C
8B88: A3 E6          SUBD   W,U
8B8A: 04 D4          LSR    $5C
8B8C: A6 27          LDA    $F,X
8B8E: E6 8A          LDB    $2,X
8B90: 58             ASLB
8B91: 10 8E 4C 96    LDY    #$CEB4
8B95: 10 AE 27       LDY    B,Y
8B98: BD 48 B5       JSR    $603D
8B9B: 6F 22          CLR    $A,X
8B9D: 96 4A          LDA    $C2
8B9F: 84 3D          ANDA   #$1F
8BA1: 44             LSRA
8BA2: CE 09 8C       LDU    #$8BAE
8BA5: A6 44          LDA    A,U
8BA7: A7 A0 38       STA    $10,X
8BAA: 6C 00 37       INC    $1F,X
8BAD: 39             RTS

8BC2: E6 DD          LDB    -$1,U
8BC4: 78 77 D2       ASL    $5550
8BC7: D2 78          SBCB   $50
8BC9: 78 D8 D8       ASL    $5050
8BCC: 78 78 6A       ASL    $50E2
8BCF: 00 32          NEG    $10
8BD1: A6 0A 92       LDA    $10,X
8BD4: 81 32          CMPA   #$10
8BD6: 23 81          BLS    $8BDB
8BD8: 7E 48 9F       JMP    $6017
8BDB: 4D             TSTA
8BDC: 26 4C          BNE    $8C42
8BDE: A6 87          LDA    $F,X
8BE0: 10 8E 4C 26    LDY    #$CEA4
8BE4: E6 20          LDB    $2,X
8BE6: 58             ASLB
8BE7: 10 AE 8D       LDY    B,Y
8BEA: BD E8 15       JSR    $603D
8BED: 6F 82          CLR    $A,X
8BEF: BD 42 35       JSR    $6017
8BF2: 8D DA          BSR    $8C4C
8BF4: A6 2D          LDA    $F,X
8BF6: 81 83          CMPA   #$01
8BF8: 27 61          BEQ    $8C43
8BFA: 81 8B          CMPA   #$03
8BFC: 27 6D          BEQ    $8C43
8BFE: DC 14          LDD    $9C
8C00: 8B 2A          ADDA   #$08
8C02: CB 8A          ADDB   #$08
8C04: DD 42          STD    $60
8C06: EC 86          LDD    $4,X
8C08: 8B 20          ADDA   #$08
8C0A: CB 80          ADDB   #$08
8C0C: D0 49          SUBB   $61
8C0E: CB 8A          ADDB   #$02
8C10: C1 26          CMPB   #$04
8C12: 22 AB          BHI    $8C3D
8C14: 90 42          SUBA   $60
8C16: 8B 8A          ADDA   #$08
8C18: 81 38          CMPA   #$10
8C1A: 22 A9          BHI    $8C3D
8C1C: 6F 27          CLR    $F,X
8C1E: 81 80          CMPA   #$08
8C20: 22 26          BHI    $8C26
8C22: 86 80          LDA    #$02
8C24: A7 2D          STA    $F,X
8C26: 6C 0A 37       INC    $1F,X
8C29: A6 87          LDA    $F,X
8C2B: E6 2A          LDB    $2,X
8C2D: 58             ASLB
8C2E: 10 8E EC 86    LDY    #$CEA4
8C32: 10 AE 87       LDY    B,Y
8C35: BD E2 BF       JSR    $603D
8C38: 6F 22          CLR    $A,X
8C3A: 7E E8 3F       JMP    $6017
8C3D: 6F 00 97       CLR    $1F,X
8C40: 6F 21          CLR    $3,X
8C42: 39             RTS
8C43: CC 25 20       LDD    #$0702
8C46: A7 81          STA    $3,X
8C48: E7 A0 97       STB    $1F,X
8C4B: 39             RTS
8C4C: E6 A0 94       LDB    $1C,X
8C4F: 58             ASLB
8C50: 58             ASLB
8C51: 4F             CLRA
8C52: C3 D5 22       ADDD   #$5700
8C55: 1F 80          TFR    D,Y
8C57: A6 0B          LDA    $3,Y
8C59: A7 8D          STA    $5,X
8C5B: 39             RTS
8C5C: A6 2E          LDA    $6,X
8C5E: AB 80          ADDA   $8,X
8C60: A7 24          STA    $6,X
8C62: 10 24 22 50    LBCC   $8CD8
8C66: BD 05 A3       JSR    $878B
8C69: 0D E8          TST    $60
8C6B: 26 30          BNE    $8C85
8C6D: 86 8A          LDA    #$02
8C6F: A8 2D          EORA   $F,X
8C71: A7 8D          STA    $F,X
8C73: 10 8E EC 26    LDY    #$CEA4
8C77: E6 2A          LDB    $2,X
8C79: 58             ASLB
8C7A: 10 AE 8D       LDY    B,Y
8C7D: BD E8 B5       JSR    $603D
8C80: 6F 28          CLR    $A,X
8C82: 6C 0A 3F       INC    $1D,X
8C85: BD E2 95       JSR    $6017
8C88: A6 27          LDA    $F,X
8C8A: 81 8A          CMPA   #$02
8C8C: 27 2C          BEQ    $8C92
8C8E: 6C 8C          INC    $4,X
8C90: 20 20          BRA    $8C94
8C92: 6A 86          DEC    $4,X
8C94: A6 26          LDA    $4,X
8C96: 90 1E          SUBA   $9C
8C98: 8B 2A          ADDA   #$02
8C9A: 81 8C          CMPA   #$04
8C9C: 22 12          BHI    $8CD8
8C9E: A6 8D          LDA    $5,X
8CA0: 90 BF          SUBA   $9D
8CA2: 8B 80          ADDA   #$02
8CA4: 81 26          CMPA   #$04
8CA6: 22 17          BHI    $8C3D
8CA8: CC C8 88       LDD    #$E000
8CAB: 7D 7C 27       TST    $540F
8CAE: 27 8B          BEQ    $8CB3
8CB0: CC C0 82       LDD    #$E200
8CB3: ED AA 30       STD    $12,X
8CB6: DC 1E          LDD    $9C
8CB8: ED 2C          STD    $4,X
8CBA: B6 DC 27       LDA    $540F
8CBD: A7 87          STA    $F,X
8CBF: 10 8E EC 2A    LDY    #$CEA8
8CC3: E6 20          LDB    $2,X
8CC5: 58             ASLB
8CC6: 10 AE 8D       LDY    B,Y
8CC9: B6 DC 87       LDA    $540F
8CCC: BD 48 B5       JSR    $603D
8CCF: 6F 28          CLR    $A,X
8CD1: 86 87          LDA    #$05
8CD3: A7 21          STA    $3,X
8CD5: 6F 0A 9D       CLR    $1F,X
8CD8: 39             RTS
8CD9: A6 00 97       LDA    $1F,X
8CDC: 48             ASLA
8CDD: 10 8E 04 C1    LDY    #jump_table_8ce3
8CE1: 6E 34          JMP    [A,Y]        ; [indirect_jump]
8CE3: 0E C9          JMP    $EB
8CE5: AE 78          LDX    [F,S]
8CE7: 0F 2E          CLR    $06
8CE9: A5 92          BITA   -$6,X
8CEB: 86 27          LDA    #$0F
8CED: 97 E8          STA    $60
8CEF: 8D 6A          BSR    $8D39
8CF1: 86 B2          LDA    #$30
8CF3: A7 AA 32       STA    $10,X
8CF6: 6C 0A 37       INC    $1F,X
8CF9: 39             RTS
8CFA: 6A 00 38       DEC    $10,X
8CFD: 26 B8          BNE    $8D2F
8CFF: 0F 42          CLR    $60
8D01: 6C 0A 9D       INC    $1F,X
8D04: 20 11          BRA    $8D39
8D06: A6 8D          LDA    $F,X
8D08: E6 2A          LDB    $2,X
8D0A: 58             ASLB
8D0B: 10 8E E6 3C    LDY    #$CEB4
8D0F: 10 AE 87       LDY    B,Y
8D12: BD E2 1F       JSR    $603D
8D15: 6F 88          CLR    $A,X
8D17: 6C A0 37       INC    $1F,X
8D1A: A6 8D          LDA    $5,X
8D1C: 8B 2A          ADDA   #$02
8D1E: 81 8C          CMPA   #$04
8D20: 22 2C          BHI    $8D30
8D22: 86 83          LDA    #$01
8D24: A7 23          STA    $1,X
8D26: 4F             CLRA
8D27: 5F             CLRB
8D28: ED 2B          STD    $3,X
8D2A: E7 8D          STB    $5,X
8D2C: E7 A0 97       STB    $1F,X
8D2F: 39             RTS
8D30: 6A 27          DEC    $5,X
8D32: 6A 87          DEC    $5,X
8D34: 6F 28          CLR    $A,X
8D36: 7E E2 3F       JMP    $6017
8D39: A6 86          LDA    $E,X
8D3B: 84 D8          ANDA   #$F0
8D3D: 9A E8          ORA    $60
8D3F: A7 2C          STA    $E,X
8D41: 39             RTS
8D42: 10 8E 76 22    LDY    #$5400
8D46: 6D 26          TST    ,Y
8D48: 27 27          BEQ    $8D59
8D4A: A6 AB          LDA    $3,Y
8D4C: 4A             DECA
8D4D: 26 82          BNE    $8D59
8D4F: A6 AA 3D       LDA    $1F,X
8D52: 48             ASLA
8D53: 10 8E AF F2    LDY    #jump_table_8d70
8D57: 6E 9E          JMP    [A,Y]        ; [indirect_jump]
8D59: A6 87          LDA    $F,X
8D5B: 10 8E E6 2C    LDY    #$CEA4
8D5F: E6 20          LDB    $2,X
8D61: 58             ASLB
8D62: 10 AE 87       LDY    B,Y
8D65: BD E2 BF       JSR    $603D
8D68: 6F 22          CLR    $A,X
8D6A: 6F 8B          CLR    $3,X
8D6C: 6F A0 97       CLR    $1F,X
8D6F: 39             RTS
8D70: AF 56          STX    -$C,S
8D72: 0F 1B          CLR    $99
8D74: D6 BE          LDB    $9C
8D76: 6D 8D          TST    $F,X
8D78: 27 2C          BEQ    $8D7E
8D7A: CB 80          ADDB   #$08
8D7C: 20 2A          BRA    $8D80
8D7E: C0 80          SUBB   #$08
8D80: E7 26          STB    $4,X
8D82: 10 8E F1 C6    LDY    #$D3E4
8D86: A6 8D          LDA    $F,X
8D88: BD 48 B5       JSR    $603D
8D8B: 6F 22          CLR    $A,X
8D8D: BD E8 9F       JSR    $6017
8D90: C6 1A          LDB    #$38
8D92: E7 0A 32       STB    $10,X
8D95: 6C 0A 9D       INC    $1F,X
8D98: 39             RTS
8D99: 6A 00 98       DEC    $10,X
8D9C: 10 26 5A FF    LBNE   $6017
8DA0: 8D 36          BSR    $8DB6
8DA2: 10 8E F6 3A    LDY    #$D418
8DA6: A6 8D          LDA    $F,X
8DA8: BD 48 B5       JSR    $603D
8DAB: 6F 22          CLR    $A,X
8DAD: BD E8 9F       JSR    $6017
8DB0: 6F 21          CLR    $3,X
8DB2: 6F 0A 3D       CLR    $1F,X
8DB5: 39             RTS
8DB6: CE D6 28       LDU    #$5400
8DB9: 6D 4C          TST    ,U
8DBB: 27 21          BEQ    $8DC6
8DBD: 86 89          LDA    #$01
8DBF: A7 63          STA    $1,U
8DC1: 6F C1          CLR    $3,U
8DC3: 6F EA 3D       CLR    $1F,U
8DC6: 33 4A 08       LEAU   $20,U
8DC9: 11 83 DD 77    CMPU   #$555F
8DCD: 23 62          BLS    $8DB9
8DCF: CC DD DD       LDD    #$FFFF
8DD2: DD 1E          STD    $9C
8DD4: DD BC          STD    $9E
8DD6: 39             RTS
8DD7: A6 A0 37       LDA    $1F,X
8DDA: 48             ASLA
8DDB: 10 8E A5 69    LDY    #jump_table_8de1
8DDF: 6E 94          JMP    [A,Y]        ; [indirect_jump]
8DE1: AC AB          CMPX   $9,Y
8DE3: 0C 64          INC    $46
8DE5: AF 73          STX    [,S++]
8DE7: 0C 01          INC    $29
8DE9: A6 CE          LDA    $6,U
8DEB: 06 7A          ROR    $52
8DED: A6 3E          LDA    [A,Y]
8DEF: 06 F9          ROR    $DB
8DF1: 6D 0A 92       TST    $10,X
8DF4: 27 26          BEQ    $8DFA
8DF6: 6A 0A 38       DEC    $10,X
8DF9: 39             RTS
8DFA: CC 68 28       LDD    #$E000
8DFD: 7D DC 87       TST    $540F
8E00: 27 21          BEQ    $8E05
8E02: CC 60 22       LDD    #$E200
8E05: ED 0A 90       STD    $12,X
8E08: DC B4          LDD    $9C
8E0A: ED 8C          STD    $4,X
8E0C: B6 7C 87       LDA    $540F
8E0F: A7 2D          STA    $F,X
8E11: 10 8E 4C 8A    LDY    #$CEA8
8E15: E6 80          LDB    $2,X
8E17: 58             ASLB
8E18: 10 AE 2D       LDY    B,Y
8E1B: B6 7C 27       LDA    $540F
8E1E: BD E8 1F       JSR    $603D
8E21: 6F 88          CLR    $A,X
8E23: 86 24          LDA    #$06
8E25: A7 0A 9D       STA    $1F,X
8E28: 39             RTS
8E29: C6 B8          LDB    #$30
8E2B: E7 A0 38       STB    $10,X
8E2E: 10 8E EC D0    LDY    #$CEF2
8E32: E6 80          LDB    $2,X
8E34: 58             ASLB
8E35: 10 AE 27       LDY    B,Y
8E38: A6 27          LDA    $F,X
8E3A: BD E8 15       JSR    $603D
8E3D: 6F 82          CLR    $A,X
8E3F: BD 42 35       JSR    $6017
8E42: 6C 0A 3D       INC    $1F,X
8E45: 39             RTS
8E46: BD E2 3F       JSR    $6017
8E49: 6A 00 98       DEC    $10,X
8E4C: 26 2B          BNE    $8E51
8E4E: 6C 00 3D       INC    $1F,X
8E51: 39             RTS
8E52: 6D 0A 32       TST    $10,X
8E55: 27 86          BEQ    $8E5B
8E57: 6A A0 38       DEC    $10,X
8E5A: 39             RTS
8E5B: E6 2F          LDB    $7,X
8E5D: EB 81          ADDB   $9,X
8E5F: E7 25          STB    $7,X
8E61: 24 D0          BCC    $8EB5
8E63: 6A 27          DEC    $5,X
8E65: A6 87          LDA    $5,X
8E67: 8B 2B          ADDA   #$03
8E69: 91 17          CMPA   $9F
8E6B: 26 60          BNE    $8EB5
8E6D: B6 DC 87       LDA    $540F
8E70: 88 20          EORA   #$02
8E72: A7 8D          STA    $F,X
8E74: 10 8E 4C 2E    LDY    #$CEAC
8E78: E6 2A          LDB    $2,X
8E7A: 58             ASLB
8E7B: 10 AE 8D       LDY    B,Y
8E7E: BD E8 1F       JSR    $603D
8E81: 6F 88          CLR    $A,X
8E83: BD 42 35       JSR    $6017
8E86: 4F             CLRA
8E87: 7D 7C 27       TST    $540F
8E8A: 26 84          BNE    $8E98
8E8C: E6 2C          LDB    $4,X
8E8E: D0 14          SUBB   $9C
8E90: 23 01          BLS    $8EB5
8E92: 10 8E C2 22    LDY    #$E000
8E96: 20 88          BRA    $8EA2
8E98: D6 B4          LDB    $9C
8E9A: E0 8C          SUBB   $4,X
8E9C: 23 3F          BLS    $8EB5
8E9E: 10 8E C0 22    LDY    #$E200
8EA2: 58             ASLB
8EA3: 49             ROLA
8EA4: 31 89          LEAY   D,Y
8EA6: 10 AF A0 3A    STY    $12,X
8EAA: EC 2C          LDD    ,Y
8EAC: 9B B4          ADDA   $9C
8EAE: DB 15          ADDB   $9D
8EB0: ED 26          STD    $4,X
8EB2: 6C 0A 3D       INC    $1F,X
8EB5: 39             RTS
8EB6: 34 92          PSHS   X
8EB8: 8E 7C 88       LDX    #$5400
8EBB: 6D AC          TST    ,X
8EBD: 27 86          BEQ    $8ECD
8EBF: A6 21          LDA    $3,X
8EC1: 81 83          CMPA   #$01
8EC3: 26 2A          BNE    $8ECD
8EC5: CC 80 82       LDD    #$0200
8EC8: A7 2B          STA    $3,X
8ECA: E7 00 37       STB    $1F,X
8ECD: 30 00 A8       LEAX   $20,X
8ED0: 8C 77 BD       CMPX   #$553F
8ED3: 23 C4          BLS    $8EBB
8ED5: 35 92          PULS   X
8ED7: 6C A0 37       INC    $1F,X
8EDA: 39             RTS
8EDB: BD B8 32       JSR    $901A
8EDE: 0D E8          TST    $60
8EE0: 26 10          BNE    $8F14
8EE2: BD 12 20       JSR    $9002
8EE5: 0D E2          TST    $60
8EE7: 10 26 28 F0    LBNE   $8F63
8EEB: 10 AE A0 9A    LDY    $12,X
8EEF: E6 25          LDB    $7,X
8EF1: EB 8B          ADDB   $9,X
8EF3: E7 25          STB    $7,X
8EF5: 24 8F          BCC    $8F04
8EF7: B6 7C 27       LDA    $540F
8EFA: A1 87          CMPA   $F,X
8EFC: 27 2C          BEQ    $8F02
8EFE: 31 B6          LEAY   -$2,Y
8F00: 20 20          BRA    $8F04
8F02: 31 A0          LEAY   $2,Y
8F04: 10 AF 0A 90    STY    $12,X
8F08: EC 8C          LDD    ,Y
8F0A: 9B 14          ADDA   $9C
8F0C: DB B5          ADDB   $9D
8F0E: ED 8C          STD    $4,X
8F10: 7E 42 95       JMP    $6017
8F13: 39             RTS
8F14: 1F AB          TFR    A,B
8F16: A6 8D          LDA    $F,X
8F18: B1 7C 87       CMPA   $540F
8F1B: 26 24          BNE    $8F29
8F1D: 34 A8          PSHS   Y
8F1F: BD A5 4E       JSR    $876C
8F22: 35 A2          PULS   Y
8F24: 85 23          BITA   #$01
8F26: 26 83          BNE    $8F29
8F28: 39             RTS
8F29: E7 00 94       STB    $1C,X
8F2C: A6 0B          LDA    $3,Y
8F2E: A7 8D          STA    $5,X
8F30: A6 2D          LDA    $F,X
8F32: E6 80          LDB    $2,X
8F34: 58             ASLB
8F35: 10 8E 4C 8C    LDY    #$CEA4
8F39: 10 AE 2D       LDY    B,Y
8F3C: BD 48 B5       JSR    $603D
8F3F: 6F 28          CLR    $A,X
8F41: 10 8E D1 22    LDY    #$5300
8F45: E6 0A 9E       LDB    $1C,X
8F48: A6 0C          LDA    $4,Y
8F4A: E1 AE          CMPB   $6,Y
8F4C: 27 22          BEQ    $8F58
8F4E: A6 AD          LDA    $5,Y
8F50: E1 05          CMPB   $7,Y
8F52: 27 86          BEQ    $8F58
8F54: 31 0A          LEAY   $8,Y
8F56: 20 72          BRA    $8F48
8F58: A7 A0 96       STA    $1E,X
8F5B: 6F 2B          CLR    $3,X
8F5D: 6F 00 97       CLR    $1F,X
8F60: 7E 42 95       JMP    $6017
8F63: 10 8E 75 82    LDY    #$5700
8F67: A6 80 34       LDA    $1C,Y
8F6A: 48             ASLA
8F6B: 48             ASLA
8F6C: 31 8E          LEAY   A,Y
8F6E: 6D 2C          TST    ,Y
8F70: 27 3C          BEQ    $8F90
8F72: A6 A1          LDA    $3,Y
8F74: A1 27          CMPA   $5,X
8F76: 26 92          BNE    $8F88
8F78: A6 2C          LDA    $4,X
8F7A: 8B 80          ADDA   #$08
8F7C: A0 09          SUBA   $1,Y
8F7E: 97 E8          STA    $60
8F80: A6 00          LDA    $2,Y
8F82: A0 A3          SUBA   $1,Y
8F84: 91 42          CMPA   $60
8F86: 24 94          BCC    $8F9E
8F88: 31 0C          LEAY   $4,Y
8F8A: 10 8C 7F 77    CMPY   #$575F
8F8E: 25 56          BCS    $8F6E
8F90: A6 25          LDA    $7,X
8F92: AB 8B          ADDA   $9,X
8F94: A7 25          STA    $7,X
8F96: 25 83          BCS    $8F99
8F98: 39             RTS
8F99: 6C 8D          INC    $5,X
8F9B: 7E 48 3F       JMP    $6017
8F9E: 1F A8          TFR    Y,D
8FA0: 83 75 82       SUBD   #$5700
8FA3: 54             LSRB
8FA4: 54             LSRB
8FA5: 7E 0D AB       JMP    $8F29
8FA8: 10 8E D9 48    LDY    #$51C0
8FAC: E6 A0 93       LDB    $1B,X
8FAF: 27 29          BEQ    $8FBC
8FB1: 10 8E D0 E2    LDY    #$52C0
8FB5: 5A             DECB
8FB6: 58             ASLB
8FB7: 58             ASLB
8FB8: 58             ASLB
8FB9: 58             ASLB
8FBA: 31 2D          LEAY   B,Y
8FBC: 39             RTS
8FBD: 8D 61          BSR    $8FA8
8FBF: 6D 86          TST    ,Y
8FC1: 26 96          BNE    $8FD7
8FC3: 31 8A 32       LEAY   $10,Y
8FC6: 6C 0A 33       INC    $1B,X
8FC9: E6 00 93       LDB    $1B,X
8FCC: C1 2C          CMPB   #$04
8FCE: 23 67          BLS    $8FBF
8FD0: 6F AA 99       CLR    $1B,X
8FD3: 10 8E 73 42    LDY    #$51C0
8FD7: 4F             CLRA
8FD8: 5F             CLRB
8FD9: DD E8          STD    $60
8FDB: EC 2C          LDD    $4,X
8FDD: 8B 80          ADDA   #$08
8FDF: CB 2A          ADDB   #$08
8FE1: DD E0          STD    $62
8FE3: EC 06          LDD    $4,Y
8FE5: 8B 8A          ADDA   #$08
8FE7: CB 20          ADDB   #$08
8FE9: 90 EA          SUBA   $62
8FEB: 9B 74          ADDA   $5C
8FED: D0 EB          SUBB   $63
8FEF: DB 7F          ADDB   $5D
8FF1: 91 DC          CMPA   $5E
8FF3: 22 26          BHI    $8FF9
8FF5: 86 83          LDA    #$01
8FF7: 97 48          STA    $60
8FF9: D1 D7          CMPB   $5F
8FFB: 22 2C          BHI    $9001
8FFD: 86 89          LDA    #$01
8FFF: 97 43          STA    $61
9001: 39             RTS
9002: 0F E2          CLR    $60
9004: 96 BC          LDA    $9E
9006: 7D D6 27       TST    $540F
9009: 26 8C          BNE    $900F
900B: 8B 20          ADDA   #$08
900D: 20 8A          BRA    $9011
900F: 80 2A          SUBA   #$08
9011: A1 86          CMPA   $4,X
9013: 26 26          BNE    $9019
9015: 86 83          LDA    #$01
9017: 97 48          STA    $60
9019: 39             RTS
901A: B6 DC 27       LDA    $540F
901D: A1 87          CMPA   $F,X
901F: 26 42          BNE    $9081
9021: 10 8E D5 22    LDY    #$5700
9025: E6 0A 9E       LDB    $1C,X
9028: 5C             INCB
9029: 1F 10          TFR    B,A
902B: 58             ASLB
902C: 58             ASLB
902D: 31 2D          LEAY   B,Y
902F: 6D 86          TST    ,Y
9031: 27 A3          BEQ    $9054
9033: E6 26          LDB    $4,X
9035: CB 8A          ADDB   #$08
9037: E0 09          SUBB   $1,Y
9039: D7 E8          STB    $60
903B: E6 0A          LDB    $2,Y
903D: E0 A9          SUBB   $1,Y
903F: D1 42          CMPB   $60
9041: 23 8A          BLS    $904B
9043: E6 27          LDB    $5,X
9045: E0 A1          SUBB   $3,Y
9047: C1 27          CMPB   #$0F
9049: 23 84          BLS    $9057
904B: 4C             INCA
904C: 31 0C          LEAY   $4,Y
904E: 10 8C 75 7D    CMPY   #$575F
9052: 25 59          BCS    $902F
9054: 0F 42          CLR    $60
9056: 39             RTS
9057: E6 2C          LDB    $4,X
9059: D0 14          SUBB   $9C
905B: CB 2C          ADDB   #$04
905D: C1 80          CMPB   #$08
905F: 22 28          BHI    $906B
9061: E6 87          LDB    $5,X
9063: D0 BF          SUBB   $9D
9065: CB 86          ADDB   #$04
9067: C1 20          CMPB   #$08
9069: 23 99          BLS    $907C
906B: E6 09          LDB    $1,Y
906D: C1 98          CMPB   #$10
906F: 25 29          BCS    $907C
9071: E6 A0          LDB    $2,Y
9073: C1 D2          CMPB   #$F0
9075: 22 87          BHI    $907C
9077: 31 0C          LEAY   $4,Y
9079: 7E 18 A7       JMP    $902F
907C: C6 29          LDB    #$01
907E: D7 E8          STB    $60
9080: 39             RTS
9081: EC 86          LDD    $4,X
9083: D0 BF          SUBB   $9D
9085: CB 80          ADDB   #$02
9087: C1 2C          CMPB   #$04
9089: 22 41          BHI    $9054
908B: 90 B4          SUBA   $9C
908D: 8B 8A          ADDA   #$02
908F: 81 26          CMPA   #$04
9091: 22 43          BHI    $9054
9093: DC BE          LDD    $9C
9095: ED 86          STD    $4,X
9097: 4F             CLRA
9098: 10 8E DF 88    LDY    #$5700
909C: 6D 8C          TST    ,Y
909E: 27 AD          BEQ    $90C5
90A0: E6 26          LDB    $4,X
90A2: CB 8A          ADDB   #$08
90A4: E0 03          SUBB   $1,Y
90A6: CB 92          ADDB   #$10
90A8: D7 48          STB    $60
90AA: E6 AA          LDB    $2,Y
90AC: CB 08          ADDB   #$20
90AE: E0 A9          SUBB   $1,Y
90B0: D1 42          CMPB   $60
90B2: 23 8A          BLS    $90BC
90B4: E6 27          LDB    $5,X
90B6: E0 A1          SUBB   $3,Y
90B8: C1 27          CMPB   #$0F
90BA: 23 84          BLS    $90C8
90BC: 4C             INCA
90BD: 31 AC          LEAY   $4,Y
90BF: 10 8C 75 DD    CMPY   #$575F
90C3: 25 F5          BCS    $909C
90C5: 0F E2          CLR    $60
90C7: 39             RTS
90C8: E6 2C          LDB    $4,X
90CA: D0 14          SUBB   $9C
90CC: CB 2C          ADDB   #$04
90CE: C1 80          CMPB   #$08
90D0: 22 28          BHI    $90DC
90D2: E6 87          LDB    $5,X
90D4: D0 BF          SUBB   $9D
90D6: CB 86          ADDB   #$04
90D8: C1 20          CMPB   #$08
90DA: 23 99          BLS    $90ED
90DC: E6 09          LDB    $1,Y
90DE: C1 98          CMPB   #$10
90E0: 25 29          BCS    $90ED
90E2: E6 A0          LDB    $2,Y
90E4: C1 D2          CMPB   #$F0
90E6: 22 87          BHI    $90ED
90E8: 31 0C          LEAY   $4,Y
90EA: 7E 18 B4       JMP    $909C
90ED: C6 89          LDB    #$01
90EF: D7 42          STB    $60
90F1: 39             RTS
90F2: A6 0A 3D       LDA    $1F,X
90F5: 48             ASLA
90F6: 10 8E B8 D4    LDY    #jump_table_90fc
90FA: 6E 3E          JMP    [A,Y]        ; [indirect_jump]
90FC: B9 2E 19       ADCA   $0691
90FF: A8 B3          EORA   [,X++]
9101: 1B             NOP
9102: 13             SYNC
9103: A2 B3          SBCA   [,X++]
9105: 56             RORB
9106: A6 80          LDA    $2,X
9108: 48             ASLA
9109: 10 8E 46 CE    LDY    #$CEE6
910D: 10 AE 2E       LDY    A,Y
9110: A6 2D          LDA    $F,X
9112: BD E2 1F       JSR    $603D
9115: 6F 88          CLR    $A,X
9117: 86 38          LDA    #$10
9119: A7 00 98       STA    $10,X
911C: 6C A0 97       INC    $1F,X
911F: 39             RTS
9120: A6 24          LDA    $6,X
9122: AB 8A          ADDA   $8,X
9124: A7 24          STA    $6,X
9126: 24 92          BCC    $9138
9128: BD 48 9F       JSR    $6017
912B: 6A A0 38       DEC    $10,X
912E: 26 80          BNE    $9138
9130: 86 32          LDA    #$10
9132: A7 0A 32       STA    $10,X
9135: 6C 0A 9D       INC    $1F,X
9138: 39             RTS
9139: 6A 00 98       DEC    $10,X
913C: 27 1D          BEQ    $9173
913E: A6 00 3C       LDA    $1E,X
9141: 48             ASLA
9142: 48             ASLA
9143: 48             ASLA
9144: 48             ASLA
9145: 10 8E D1 28    LDY    #$5300
9149: 31 2E          LEAY   A,Y
914B: EC 0A          LDD    $2,Y
914D: ED 8C          STD    $4,X
914F: A6 03          LDA    $1,Y
9151: A7 0A 9E       STA    $1C,X
9154: 6F AA 9C       CLR    $1E,X
9157: 6F A0 31       CLR    $19,X
915A: A6 8A          LDA    $2,X
915C: 48             ASLA
915D: 10 8E 46 C8    LDY    #$CEEA
9161: 10 AE 24       LDY    A,Y
9164: A6 2D          LDA    $F,X
9166: BD E2 15       JSR    $603D
9169: 6F 82          CLR    $A,X
916B: 86 38          LDA    #$10
916D: A7 00 98       STA    $10,X
9170: 6C AA 9D       INC    $1F,X
9173: 39             RTS
9174: 10 8E 4C 26    LDY    #$CEA4
9178: A6 2A          LDA    $2,X
917A: 48             ASLA
917B: 10 AE 8E       LDY    A,Y
917E: A6 87          LDA    $F,X
9180: BD 42 BF       JSR    $603D
9183: 6F 28          CLR    $A,X
9185: BD E2 95       JSR    $6017
9188: 6F A0 98       CLR    $10,X
918B: 6F 2B          CLR    $3,X
918D: 6F 00 97       CLR    $1F,X
9190: 39             RTS
9191: 39             RTS
9192: A6 0A 3D       LDA    $1F,X
9195: 48             ASLA
9196: 10 8E B9 B4    LDY    #jump_table_919c
919A: 6E 3E          JMP    [A,Y]        ; [indirect_jump]

91A6: 11 92 BB       SBCA   $93
91A9: BF 6D 00       STX    $E588
91AC: 31 26          LEAY   $E,X
91AE: 8D BD          BSR    $91E5
91B0: AD 8A 20       JSR    -$5E,Y
91B3: 8F E6 AA       XSTX   #$C488
91B6: 9C 58          CMPX   $DA
91B8: 58             ASLB
91B9: 58             ASLB
91BA: 58             ASLB
91BB: 10 8E 7B 88    LDY    #$5300
91BF: 31 87          LEAY   B,Y
91C1: E6 A7          LDB    $5,Y
91C3: A6 AA 3E       LDA    $1C,X
91C6: 48             ASLA
91C7: 10 8E 7F 48    LDY    #$57C0
91CB: 31 8E          LEAY   A,Y
91CD: E1 8D          CMPB   $5,X
91CF: 24 24          BCC    $91D7
91D1: C6 83          LDB    #$01
91D3: A6 03          LDA    $1,Y
91D5: 20 86          BRA    $91DB
91D7: C6 2B          LDB    #$03
91D9: A6 2C          LDA    ,Y
91DB: 27 22          BEQ    $91E7
91DD: E7 87          STB    $F,X
91DF: A0 26          SUBA   $4,X
91E1: 8B 80          ADDA   #$02
91E3: 81 26          CMPA   #$04
91E5: 23 84          BLS    $91ED
91E7: 6F A0 37       CLR    $1F,X
91EA: 6F 8B          CLR    $3,X
91EC: 39             RTS
91ED: C6 B8          LDB    #$30
91EF: E7 AA 32       STB    $10,X
91F2: 10 8E EC D0    LDY    #$CEF2
91F6: E6 80          LDB    $2,X
91F8: 58             ASLB
91F9: 10 AE 2D       LDY    B,Y
91FC: A6 27          LDA    $F,X
91FE: BD E8 1F       JSR    $603D
9201: 6F 88          CLR    $A,X
9203: BD 42 35       JSR    $6017
9206: 6C 0A 37       INC    $1F,X
9209: 39             RTS
920A: 6A 00 38       DEC    $10,X
920D: 10 26 46 24    LBNE   $6017
9211: 10 8E 4C E2    LDY    #$CEC0
9215: A6 80          LDA    $2,X
9217: 48             ASLA
9218: 10 AE 2E       LDY    A,Y
921B: A6 27          LDA    $F,X
921D: BD E8 B5       JSR    $603D
9220: 6F 28          CLR    $A,X
9222: BD E2 35       JSR    $6017
9225: 6C 0A 9D       INC    $1F,X
9228: 39             RTS
9229: A6 87          LDA    $F,X
922B: 85 2A          BITA   #$02
922D: 26 8C          BNE    $9233
922F: C6 21          LDB    #$03
9231: 20 80          BRA    $9235
9233: C6 27          LDB    #$05
9235: E7 0A 9D       STB    $1F,X
9238: 6F A0 98       CLR    $10,X
923B: 10 8E E6 48    LDY    #$CEC0
923F: E6 20          LDB    $2,X
9241: 58             ASLB
9242: 10 AE 87       LDY    B,Y
9245: A6 8D          LDA    $F,X
9247: BD 48 15       JSR    $603D
924A: 6F 82          CLR    $A,X
924C: 39             RTS
924D: A6 8E          LDA    $6,X
924F: AB 2A          ADDA   $8,X
9251: A7 84          STA    $6,X
9253: 24 16          BCC    $9289
9255: 6A 87          DEC    $5,X
9257: 10 8E E6 34    LDY    #$CEBC
925B: A6 2A          LDA    $2,X
925D: 48             ASLA
925E: 10 AE 84       LDY    A,Y
9261: A6 0A 92       LDA    $10,X
9264: 6C AA 92       INC    $10,X
9267: E6 8E          LDB    A,Y
9269: E7 85          STB    $D,X
926B: 81 38          CMPA   #$10
926D: 25 92          BCS    $9289
926F: 10 8E EC 42    LDY    #$CEC0
9273: A6 20          LDA    $2,X
9275: 48             ASLA
9276: 10 AE 8E       LDY    A,Y
9279: A6 87          LDA    $F,X
927B: BD 48 15       JSR    $603D
927E: 6F 82          CLR    $A,X
9280: BD 42 95       JSR    $6017
9283: 6F AA 32       CLR    $10,X
9286: 6C 0A 37       INC    $1F,X
9289: 39             RTS
928A: BD E8 3F       JSR    $6017
928D: A6 8E          LDA    $6,X
928F: AB 2A          ADDA   $8,X
9291: A7 84          STA    $6,X
9293: 24 16          BCC    $92C9
9295: 6A 87          DEC    $5,X
9297: EC 2C          LDD    $4,X
9299: 8B 80          ADDA   #$08
929B: DD 48          STD    $60
929D: 10 8E DF 22    LDY    #$5700
92A1: 6D 26          TST    ,Y
92A3: 27 3E          BEQ    $92C1
92A5: 96 E2          LDA    $60
92A7: A0 09          SUBA   $1,Y
92A9: 8B 8E          ADDA   #$06
92AB: 97 4A          STA    $62
92AD: E6 AA          LDB    $2,Y
92AF: E0 03          SUBB   $1,Y
92B1: CB 8E          ADDB   #$0C
92B3: D1 40          CMPB   $62
92B5: 25 88          BCS    $92C1
92B7: D6 49          LDB    $61
92B9: E0 AB          SUBB   $3,Y
92BB: CB 29          ADDB   #$01
92BD: C1 8A          CMPB   #$02
92BF: 23 2B          BLS    $92CA
92C1: 31 A6          LEAY   $4,Y
92C3: 10 8C 75 DD    CMPY   #$575F
92C7: 23 F0          BLS    $92A1
92C9: 39             RTS
92CA: 1F A8          TFR    Y,D
92CC: 83 7F 88       SUBD   #$5700
92CF: 54             LSRB
92D0: 54             LSRB
92D1: E7 0A 9E       STB    $1C,X
92D4: A6 01          LDA    $3,Y
92D6: A7 87          STA    $5,X
92D8: 6F A0 97       CLR    $1F,X
92DB: 6F 2B          CLR    $3,X
92DD: F6 D9 4C       LDB    $51C4
92E0: A6 AA 99       LDA    $1B,X
92E3: 27 2F          BEQ    $92F2
92E5: 4A             DECA
92E6: 48             ASLA
92E7: 48             ASLA
92E8: 48             ASLA
92E9: 48             ASLA
92EA: 10 8E 7A E8    LDY    #$52C0
92EE: 31 2E          LEAY   A,Y
92F0: E6 06          LDB    $4,Y
92F2: E1 86          CMPB   $4,X
92F4: 22 26          BHI    $92FA
92F6: 86 80          LDA    #$02
92F8: 20 2A          BRA    $92FC
92FA: 86 88          LDA    #$00
92FC: A7 27          STA    $F,X
92FE: 10 8E EC 86    LDY    #$CEA4
9302: E6 80          LDB    $2,X
9304: 58             ASLB
9305: 10 AE 27       LDY    B,Y
9308: BD 48 B5       JSR    $603D
930B: 6F 22          CLR    $A,X
930D: 7E E8 9F       JMP    $6017
9310: BD 42 95       JSR    $6017
9313: A6 24          LDA    $6,X
9315: AB 8A          ADDA   $8,X
9317: A7 2E          STA    $6,X
9319: 24 BE          BCC    $9351
931B: 6C 2D          INC    $5,X
931D: EC 8C          LDD    $4,X
931F: 8B 2A          ADDA   #$08
9321: CB 92          ADDB   #$10
9323: DD 42          STD    $60
9325: 10 8E D5 28    LDY    #$5700
9329: 6D 2C          TST    ,Y
932B: 27 34          BEQ    $9349
932D: 96 E8          LDA    $60
932F: A0 03          SUBA   $1,Y
9331: 8B 8A          ADDA   #$08
9333: 97 40          STA    $62
9335: E6 A0          LDB    $2,Y
9337: E0 09          SUBB   $1,Y
9339: CB 98          ADDB   #$10
933B: D1 4A          CMPB   $62
933D: 25 82          BCS    $9349
933F: D6 43          LDB    $61
9341: E0 A1          SUBB   $3,Y
9343: CB 23          ADDB   #$01
9345: C1 80          CMPB   #$02
9347: 23 21          BLS    $9352
9349: 31 AC          LEAY   $4,Y
934B: 10 8C 7F D7    CMPY   #$575F
934F: 23 FA          BLS    $9329
9351: 39             RTS
9352: 1F A2          TFR    Y,D
9354: 83 75 82       SUBD   #$5700
9357: 54             LSRB
9358: 54             LSRB
9359: E7 00 94       STB    $1C,X
935C: 6C A0 97       INC    $1F,X
935F: C6 32          LDB    #$10
9361: E7 0A 92       STB    $10,X
9364: F6 73 46       LDB    $51C4
9367: A6 A0 33       LDA    $1B,X
936A: 27 85          BEQ    $9379
936C: 4A             DECA
936D: 48             ASLA
936E: 48             ASLA
936F: 48             ASLA
9370: 48             ASLA
9371: 10 8E D0 E2    LDY    #$52C0
9375: 31 24          LEAY   A,Y
9377: E6 0C          LDB    $4,Y
9379: E1 8C          CMPB   $4,X
937B: 22 2C          BHI    $9381
937D: 86 8A          LDA    #$02
937F: 20 20          BRA    $9383
9381: 86 82          LDA    #$00
9383: A7 2D          STA    $F,X
9385: 10 8E 4C 8C    LDY    #$CEA4
9389: E6 8A          LDB    $2,X
938B: 58             ASLB
938C: 10 AE 2D       LDY    B,Y
938F: BD 42 1F       JSR    $603D
9392: 6F 88          CLR    $A,X
9394: 7E 42 95       JMP    $6017
9397: A6 2E          LDA    $6,X
9399: AB 80          ADDA   $8,X
939B: A7 2E          STA    $6,X
939D: 24 CC          BCC    $93E3
939F: 6C 27          INC    $5,X
93A1: 10 8E 4C 9E    LDY    #$CEBC
93A5: A6 80          LDA    $2,X
93A7: 48             ASLA
93A8: 10 AE 2E       LDY    A,Y
93AB: A6 A0 38       LDA    $10,X
93AE: 6A 00 32       DEC    $10,X
93B1: E6 24          LDB    A,Y
93B3: E7 2F          STB    $D,X
93B5: 4D             TSTA
93B6: 26 A9          BNE    $93E3
93B8: 6F A0 98       CLR    $10,X
93BB: 6F A0 37       CLR    $1F,X
93BE: 6F 8B          CLR    $3,X
93C0: E6 AA 9E       LDB    $1C,X
93C3: 58             ASLB
93C4: 58             ASLB
93C5: 10 8E D5 28    LDY    #$5700
93C9: 31 2D          LEAY   B,Y
93CB: A6 0B          LDA    $3,Y
93CD: A7 8D          STA    $5,X
93CF: A6 20          LDA    $2,X
93D1: 10 8E 4C 86    LDY    #$CEA4
93D5: 48             ASLA
93D6: 10 AE 8E       LDY    A,Y
93D9: A6 87          LDA    $F,X
93DB: BD 48 15       JSR    $603D
93DE: 6F 82          CLR    $A,X
93E0: BD 42 95       JSR    $6017
93E3: 39             RTS
93E4: A6 AA 9D       LDA    $1F,X
93E7: 48             ASLA
93E8: 10 8E 1B 66    LDY    #jump_table_93ee
93EC: 6E 9E          JMP    [A,Y]        ; [indirect_jump]
93EE: 1B             NOP
93EF: 7C B6 04       INC    $9426
93F2: 16 B3 34       LBRA   $C50B
93F5: 32 10          LEAS   Illegal Postbyte
93F7: 8E 79 E8       LDX    #$51C0
93FA: BD 07 95       JSR    $8FBD
93FD: 35 98          PULS   X
93FF: DC 42          LDD    $60
9401: 27 9F          BEQ    $9420
9403: 10 8E EC 6C    LDY    #$CEEE
9407: A6 2A          LDA    $2,X
9409: 48             ASLA
940A: 10 AE 8E       LDY    A,Y
940D: A6 87          LDA    $F,X
940F: BD 42 1F       JSR    $603D
9412: 6F 88          CLR    $A,X
9414: BD 42 95       JSR    $6017
9417: 86 18          LDA    #$30
9419: A7 00 98       STA    $10,X
941C: 6C A0 97       INC    $1F,X
941F: 39             RTS
9420: 86 20          LDA    #$02
9422: A7 0A 3D       STA    $1F,X
9425: 39             RTS
9426: 6A 0A 38       DEC    $10,X
9429: 26 8B          BNE    $942E
942B: 6C A0 37       INC    $1F,X
942E: 7E E8 35       JMP    $6017
9431: 86 80          LDA    #$02
9433: A8 2D          EORA   $F,X
9435: A7 8D          STA    $F,X
9437: 10 8E E6 2C    LDY    #$CEA4
943B: E6 2A          LDB    $2,X
943D: 58             ASLB
943E: 10 AE 87       LDY    B,Y
9441: BD E2 BF       JSR    $603D
9444: 6F 28          CLR    $A,X
9446: 6C 0A 35       INC    $1D,X
9449: 6F 8B          CLR    $3,X
944B: 6F A0 37       CLR    $1F,X
944E: 39             RTS
944F: 8E 71 62       LDX    #$5340
9452: 6D 06          TST    ,X
9454: 27 2B          BEQ    $945F
9456: 10 8E BC 40    LDY    #jump_table_9468
945A: A6 8B          LDA    $3,X
945C: 48             ASLA
945D: AD 3E          JSR    [A,Y]        ; [indirect_jump]
945F: 30 AA 02       LEAX   $20,X
9462: 8C D1 BD       CMPX   #$539F
9465: 25 69          BCS    $9452
9467: 39             RTS
9468: BC 5C 1C       CMPX   $7494
946B: 58             ASLB
946C: BD 81 1C       JSR    $A994
946F: 58             ASLB
9470: B6 F2 17       LDA    $D095
9473: A3 BD B7 53    SUBD   [$95D1]
9477: BD 48 3F       JSR    $6017
947A: EC 00 3C       LDD    $14,X
947D: 81 98          CMPA   #$10
947F: 23 24          BLS    $9487
9481: A3 0A 94       SUBD   $16,X
9484: ED AA 96       STD    $14,X
9487: AB 2E          ADDA   $6,X
9489: A7 8E          STA    $6,X
948B: 24 22          BCC    $9497
948D: 6D 87          TST    $F,X
948F: 26 26          BNE    $9495
9491: 6C 86          INC    $4,X
9493: 20 20          BRA    $9497
9495: 6A 86          DEC    $4,X
9497: EC A0 30       LDD    $18,X
949A: 81 70          CMPA   #$F8
949C: 22 2E          BHI    $94A4
949E: E3 00 38       ADDD   $1A,X
94A1: ED 0A 9A       STD    $18,X
94A4: AB 25          ADDA   $7,X
94A6: A7 85          STA    $7,X
94A8: 24 26          BCC    $94B8
94AA: 6A 8D          DEC    $5,X
94AC: 6A 2D          DEC    $5,X
94AE: A6 8D          LDA    $5,X
94B0: 81 25          CMPA   #$07
94B2: 22 86          BHI    $94B8
94B4: 86 23          LDA    #$01
94B6: A7 83          STA    $1,X
94B8: BD BD A4       JSR    $952C
94BB: 0D 48          TST    $60
94BD: 27 98          BEQ    $94CF
94BF: 10 8E B4 B1    LDY    #$9633
94C3: A6 2D          LDA    $F,X
94C5: BD E2 BF       JSR    $603D
94C8: 6F 22          CLR    $A,X
94CA: 6C 8B          INC    $3,X
94CC: 7E 53 F9       JMP    $7B71
94CF: 39             RTS
94D0: BD 42 95       JSR    $6017
94D3: EC AA 36       LDD    $14,X
94D6: 81 72          CMPA   #$F0
94D8: 22 2E          BHI    $94E0
94DA: E3 00 3E       ADDD   $16,X
94DD: ED 00 9C       STD    $14,X
94E0: AB 24          ADDA   $6,X
94E2: A7 84          STA    $6,X
94E4: 24 28          BCC    $94F0
94E6: 6D 8D          TST    $F,X
94E8: 26 2C          BNE    $94EE
94EA: 6C 8C          INC    $4,X
94EC: 20 2A          BRA    $94F0
94EE: 6A 8C          DEC    $4,X
94F0: EC AA 9A       LDD    $18,X
94F3: A1 AA 38       CMPA   $1A,X
94F6: 23 99          BLS    $9513
94F8: A3 A0 92       SUBD   $1A,X
94FB: ED A0 30       STD    $18,X
94FE: AB 8F          ADDA   $7,X
9500: A7 25          STA    $7,X
9502: 24 8C          BCC    $9512
9504: 6C 27          INC    $5,X
9506: 6C 87          INC    $5,X
9508: A6 2D          LDA    $5,X
950A: 81 8F          CMPA   #$07
950C: 22 2C          BHI    $9512
950E: 86 89          LDA    #$01
9510: A7 23          STA    $1,X
9512: 39             RTS
9513: 6F 21          CLR    $3,X
9515: 10 8E 14 0B    LDY    #$9623
9519: A6 87          LDA    $F,X
951B: BD 48 15       JSR    $603D
951E: 6F 82          CLR    $A,X
9520: 39             RTS
9521: 10 8E D4 22    LDY    #$5600
9525: EC A6          LDD    $4,Y
9527: C0 2D          SUBB   #$05
9529: ED 8C          STD    $4,X
952B: 39             RTS
952C: 10 8E DF 88    LDY    #$5700
9530: EC 26          LDD    $4,X
9532: 8B 8A          ADDA   #$08
9534: CB 20          ADDB   #$02
9536: DD E2          STD    $60
9538: E6 A0 9B       LDB    $13,X
953B: 96 E9          LDA    $C1
953D: 84 8B          ANDA   #$03
953F: 4A             DECA
9540: 26 2A          BNE    $954A
9542: A6 0A 3E       LDA    $1C,X
9545: 81 80          CMPA   #$02
9547: 22 29          BHI    $954A
9549: 5C             INCB
954A: 58             ASLB
954B: 58             ASLB
954C: 4F             CLRA
954D: C3 DF 88       ADDD   #$5700
9550: DD 46          STD    $64
9552: 6D 26          TST    ,Y
9554: 27 3D          BEQ    $9575
9556: A6 A0          LDA    $2,Y
9558: A0 09          SUBA   $1,Y
955A: 97 EA          STA    $62
955C: 96 48          LDA    $60
955E: A0 A9          SUBA   $1,Y
9560: 91 40          CMPA   $62
9562: 22 88          BHI    $956E
9564: 96 43          LDA    $61
9566: A0 A1          SUBA   $3,Y
9568: 8B 29          ADDA   #$01
956A: 81 8A          CMPA   #$02
956C: 23 35          BLS    $958B
956E: 31 AC          LEAY   $4,Y
9570: 10 9C E6       CMPY   $64
9573: 25 FF          BCS    $9552
9575: 96 E3          LDA    $61
9577: 81 2E          CMPA   #$06
9579: 23 83          BLS    $9586
957B: 96 48          LDA    $60
957D: 80 98          SUBA   #$10
957F: 81 C2          CMPA   #$E0
9581: 22 81          BHI    $9586
9583: 0F 42          CLR    $60
9585: 39             RTS
9586: 86 83          LDA    #$01
9588: A7 29          STA    $1,X
958A: 39             RTS
958B: 1F 08          TFR    Y,D
958D: 83 DF 88       SUBD   #$5700
9590: 54             LSRB
9591: 54             LSRB
9592: E1 0A 31       CMPB   $13,X
9595: 26 87          BNE    $959C
9597: 6C A0 34       INC    $1C,X
959A: 20 8D          BRA    $95A1
959C: 86 29          LDA    #$01
959E: A7 00 3E       STA    $1C,X
95A1: E7 0A 91       STB    $13,X
95A4: 86 23          LDA    #$01
95A6: 97 E2          STA    $60
95A8: 39             RTS
95A9: EC 00 98       LDD    $10,X
95AC: 27 27          BEQ    $95BD
95AE: 83 88 23       SUBD   #$0001
95B1: ED 0A 92       STD    $10,X
95B4: 10 83 82 88    CMPD   #$000A
95B8: 10 23 42 D3    LBLS   $6017
95BC: 39             RTS
95BD: 86 88          LDA    #$00
95BF: A7 21          STA    $3,X
95C1: 86 80          LDA    #$02
95C3: A8 2D          EORA   $F,X
95C5: A7 8D          STA    $F,X
95C7: 6A B0 34       DEC    [$1C,X]
95CA: 6F 00 34       CLR    $1C,X
95CD: 6F 00 95       CLR    $1D,X
95D0: 39             RTS
95D1: 96 43          LDA    $C1
95D3: 84 21          ANDA   #$03
95D5: 4A             DECA
95D6: 26 C8          BNE    $9622
95D8: 10 8E DE 08    LDY    #$5680
95DC: 86 20          LDA    #$08
95DE: 97 E8          STA    $60
95E0: EC 26          LDD    $4,X
95E2: 8B 8A          ADDA   #$08
95E4: DD 40          STD    $62
95E6: DC E0          LDD    $62
95E8: E0 0B          SUBB   $3,Y
95EA: CB 89          ADDB   #$01
95EC: C1 2A          CMPB   #$02
95EE: 22 98          BHI    $9600
95F0: A0 03          SUBA   $1,Y
95F2: 8B 80          ADDA   #$02
95F4: 97 43          STA    $61
95F6: E6 A0          LDB    $2,Y
95F8: E0 09          SUBB   $1,Y
95FA: CB 8C          ADDB   #$04
95FC: D1 49          CMPB   $61
95FE: 24 8F          BCC    $9607
9600: 31 06          LEAY   $4,Y
9602: 0A E2          DEC    $60
9604: 26 C2          BNE    $95E6
9606: 39             RTS
9607: 6C 8C          INC    ,Y
9609: A6 A9          LDA    $1,Y
960B: E6 0B          LDB    $3,Y
960D: C0 8E          SUBB   #$06
960F: ED 26          STD    $4,X
9611: 86 80          LDA    #$02
9613: A7 21          STA    $3,X
9615: CC 83 82       LDD    #$0100
9618: ED A0 98       STD    $10,X
961B: 10 AF A0 94    STY    $1C,X
961F: 7E 59 4F       JMP    $7B6D
9622: 39             RTS

96A9: 41             NEGA
96AA: E6 E9          LDB    $1,S
96AC: 43             COMA
96AD: 49             ROLA
96AE: 8E DE A2       LDX    #$5680
96B1: 96 43          LDA    $C1
96B3: 84 21          ANDA   #$03
96B5: 81 80          CMPA   #$02
96B7: 27 22          BEQ    $96C3
96B9: 81 8B          CMPA   #$03
96BB: 10 27 29 68    LBEQ   $989F
96BF: 7F 62 1D       CLR    $403F
96C2: 39             RTS
96C3: 86 23          LDA    #$01
96C5: B7 C2 BD       STA    $403F
96C8: 6D AC          TST    ,X
96CA: 27 7E          BEQ    $96C2
96CC: A6 2E          LDA    $6,X
96CE: AB 80          ADDA   $8,X
96D0: A7 24          STA    $6,X
96D2: 10 24 22 FA    LBCC   $97AE
96D6: 6D 8C          TST    $E,X
96D8: 26 1B          BNE    $970D
96DA: 6C 82          INC    $A,X
96DC: A6 22          LDA    $A,X
96DE: 81 98          CMPA   #$10
96E0: 26 20          BNE    $96E4
96E2: 6F 88          CLR    $A,X
96E4: 6C AA 96       INC    $14,X
96E7: E6 A0 3C       LDB    $14,X
96EA: C1 80          CMPB   #$08
96EC: 26 70          BNE    $9746
96EE: 6F 00 36       CLR    $14,X
96F1: A6 0A 9A       LDA    $18,X
96F4: 81 80          CMPA   #$A2
96F6: 22 CC          BHI    $9746
96F8: A6 A0 90       LDA    $18,X
96FB: 81 8A          CMPA   #$A2
96FD: 25 8F          BCS    $9706
96FF: C6 BB          LDB    #$99
9701: E7 0A 9A       STB    $18,X
9704: 20 62          BRA    $9746
9706: 8B 81          ADDA   #$03
9708: A7 A0 90       STA    $18,X
970B: 20 11          BRA    $9746
970D: A6 82          LDA    $A,X
970F: 81 21          CMPA   #$03
9711: 24 84          BCC    $9719
9713: C6 2C          LDB    #$0E
9715: E7 88          STB    $A,X
9717: 20 2C          BRA    $971D
9719: 80 8B          SUBA   #$03
971B: A7 22          STA    $A,X
971D: 6D 00 9C       TST    $14,X
9720: 27 27          BEQ    $9727
9722: 6A 0A 36       DEC    $14,X
9725: 20 9D          BRA    $9746
9727: 86 2F          LDA    #$07
9729: A7 00 9C       STA    $14,X
972C: A6 A0 90       LDA    $18,X
972F: 81 80          CMPA   #$A2
9731: 22 91          BHI    $9746
9733: A6 AA 3A       LDA    $18,X
9736: 81 1B          CMPA   #$99
9738: 22 2F          BHI    $9741
973A: C6 2A          LDB    #$A2
973C: E7 A0 90       STB    $18,X
973F: 20 27          BRA    $9746
9741: 80 81          SUBA   #$03
9743: A7 AA 3A       STA    $18,X
9746: A6 88          LDA    $A,X
9748: 48             ASLA
9749: 10 8E 13 E9    LDY    #$9BC1
974D: 10 AE 2E       LDY    A,Y
9750: 8D 0A          BSR    $977A
9752: 6C 88          INC    $A,X
9754: A6 28          LDA    $A,X
9756: 48             ASLA
9757: 10 8E B3 49    LDY    #$9BC1
975B: 10 AE 8E       LDY    A,Y
975E: 8D BA          BSR    $9792
9760: CE 74 1B       LDU    #$5699
9763: 10 8E B9 63    LDY    #$9BE1
9767: A6 A0 3C       LDA    $14,X
976A: 48             ASLA
976B: 10 AE 8E       LDY    A,Y
976E: E6 28          LDB    ,Y+
9770: E7 E2          STB    ,U+
9772: 11 83 74 87    CMPU   #$56A5
9776: 26 74          BNE    $976E
9778: 20 1C          BRA    $97AE
977A: EE 00 38       LDU    $10,X
977D: C6 81          LDB    #$09
977F: D7 42          STB    $60
9781: 86 8B          LDA    #$09
9783: E6 82          LDB    ,Y+
9785: E7 42          STB    ,U+
9787: 4A             DECA
9788: 26 D1          BNE    $9783
978A: 33 40 3F       LEAU   $17,U
978D: 0A E8          DEC    $60
978F: 26 D2          BNE    $9781
9791: 39             RTS
9792: EE 0A 32       LDU    $10,X
9795: 33 4B 7E 28    LEAU   -$0400,U
9799: C6 81          LDB    #$09
979B: D7 48          STB    $60
979D: 86 81          LDA    #$09
979F: E6 82          LDB    ,Y+
97A1: E7 42          STB    ,U+
97A3: 4A             DECA
97A4: 26 DB          BNE    $979F
97A6: 33 4A 3F       LEAU   $17,U
97A9: 0A E8          DEC    $60
97AB: 26 D8          BNE    $979D
97AD: 39             RTS
97AE: A6 8F          LDA    $7,X
97B0: AB 2B          ADDA   $9,X
97B2: A7 85          STA    $7,X
97B4: 10 24 82 30    LBCC   $986A
97B8: 6D 27          TST    $F,X
97BA: 26 BB          BNE    $97EF
97BC: 6C 23          INC    $B,X
97BE: A6 83          LDA    $B,X
97C0: 81 34          CMPA   #$16
97C2: 26 80          BNE    $97C6
97C4: 6F 29          CLR    $B,X
97C6: 6C 0A 3D       INC    $15,X
97C9: E6 00 9D       LDB    $15,X
97CC: C1 23          CMPB   #$0B
97CE: 26 D0          BNE    $9828
97D0: 6F AA 97       CLR    $15,X
97D3: A6 AA 3A       LDA    $18,X
97D6: 81 27          CMPA   #$A5
97D8: 25 66          BCS    $9828
97DA: A6 00 30       LDA    $18,X
97DD: 81 35          CMPA   #$BD
97DF: 26 25          BNE    $97E8
97E1: C6 27          LDB    #$A5
97E3: E7 AA 3A       STB    $18,X
97E6: 20 C2          BRA    $9828
97E8: 8B 2B          ADDA   #$03
97EA: A7 00 30       STA    $18,X
97ED: 20 B1          BRA    $9828
97EF: A6 29          LDA    $B,X
97F1: 81 81          CMPA   #$03
97F3: 24 24          BCC    $97FB
97F5: C6 96          LDB    #$14
97F7: E7 23          STB    $B,X
97F9: 20 8C          BRA    $97FF
97FB: 80 2B          SUBA   #$03
97FD: A7 83          STA    $B,X
97FF: 6D AA 37       TST    $15,X
9802: 27 87          BEQ    $9809
9804: 6A AA 97       DEC    $15,X
9807: 20 37          BRA    $9828
9809: 86 82          LDA    #$0A
980B: A7 A0 3D       STA    $15,X
980E: A6 00 3A       LDA    $18,X
9811: 81 27          CMPA   #$A5
9813: 25 31          BCS    $9828
9815: A6 0A 9A       LDA    $18,X
9818: 81 8D          CMPA   #$A5
981A: 26 8F          BNE    $9823
981C: C6 95          LDB    #$BD
981E: E7 00 3A       STB    $18,X
9821: 20 87          BRA    $9828
9823: 80 21          SUBA   #$03
9825: A7 0A 9A       STA    $18,X
9828: CC 61 BE       LDD    #$4936
982B: FD 68 C8       STD    $40E0
982E: CC C5 14       LDD    #$4D36
9831: FD C2 42       STD    $40C0
9834: A6 29          LDA    $B,X
9836: 48             ASLA
9837: 10 8E 89 E9    LDY    #$A161
983B: 10 AE 8E       LDY    A,Y
983E: 8D A3          BSR    $986B
9840: 6C 29          INC    $B,X
9842: A6 89          LDA    $B,X
9844: 48             ASLA
9845: 10 8E 23 49    LDY    #$A161
9849: 10 AE 2E       LDY    A,Y
984C: 8D 14          BSR    $988A
984E: C6 81          LDB    #$09
9850: D7 43          STB    $61
9852: CE D4 85       LDU    #$56A7
9855: 10 8E 23 A5    LDY    #$A18D
9859: A6 00 9D       LDA    $15,X
985C: 48             ASLA
985D: 10 AE 2E       LDY    A,Y
9860: E6 82          LDB    ,Y+
9862: E7 43          STB    ,U++
9864: 33 63          LEAU   $1,U
9866: 0A E3          DEC    $61
9868: 26 DE          BNE    $9860
986A: 39             RTS
986B: C6 2A          LDB    #$02
986D: D7 EA          STB    $62
986F: EE AA 30       LDU    $12,X
9872: 86 8D          LDA    #$0F
9874: E6 82          LDB    ,Y+
9876: E7 42          STB    ,U+
9878: 4A             DECA
9879: 26 71          BNE    $9874
987B: A6 23          LDA    $B,X
987D: 48             ASLA
987E: 10 8E 83 43    LDY    #$A161
9882: 10 AE 84       LDY    A,Y
9885: 0A E0          DEC    $62
9887: 26 C1          BNE    $9872
9889: 39             RTS
988A: C6 8A          LDB    #$02
988C: D7 4B          STB    $63
988E: CE C8 C0       LDU    #$40E2
9891: 86 8D          LDA    #$0F
9893: E6 82          LDB    ,Y+
9895: E7 42          STB    ,U+
9897: 4A             DECA
9898: 26 D1          BNE    $9893
989A: 0A EB          DEC    $63
989C: 26 DB          BNE    $9891
989E: 39             RTS
989F: CE 74 A2       LDU    #$5680
98A2: A6 4A 02       LDA    $20,U
98A5: 48             ASLA
98A6: 8E 18 D5       LDX    #jump_table_9afd
98A9: 6E 1E          JMP    [A,X]        ; [indirect_jump]
98AB: A6 6E          LDA    $6,U
98AD: AB CF          ADDA   $7,U
98AF: A7 64          STA    $6,U
98B1: 24 F2          BCC    $9923
98B3: 6C EA 36       INC    $14,U
98B6: E6 4A 3C       LDB    $14,U
98B9: C1 87          CMPB   #$0F
98BB: 26 0E          BNE    $98E3
98BD: 86 D0          LDA    #$58
98BF: A7 EA 38       STA    $1A,U
98C2: 6F 4A 3E       CLR    $1C,U
98C5: 6F 4A 99       CLR    $1B,U
98C8: 6F E0 9C       CLR    $14,U
98CB: 6F E0 36       CLR    $1E,U
98CE: 8E C5 EA       LDX    #$4DC8
98D1: AF 4A 92       STX    $10,U
98D4: 8E 6F 45       LDX    #$4DC7
98D7: AF E0 0C       STX    $24,U
98DA: 86 80          LDA    #$08
98DC: A7 E0 9D       STA    $15,U
98DF: 6C EA 02       INC    $20,U
98E2: 39             RTS
98E3: C1 26          CMPB   #$04
98E5: 27 80          BEQ    $98E9
98E7: 20 22          BRA    $98F3
98E9: 86 D6          LDA    #$5E
98EB: A7 E0 32       STA    $1A,U
98EE: A7 40 39       STA    $1B,U
98F1: 20 B4          BRA    $9929
98F3: C1 2A          CMPB   #$08
98F5: 27 B0          BEQ    $9929
98F7: C1 22          CMPB   #$0A
98F9: 27 A1          BEQ    $9924
98FB: 8E B3 2B       LDX    #$9B03
98FE: BD 12 A1       JSR    $9A83
9901: 8E 19 E7       LDX    #$9B65
9904: BD B8 3D       JSR    $9ABF
9907: 6C E0 34       INC    $1C,U
990A: A6 40 34       LDA    $1C,U
990D: 81 8A          CMPA   #$02
990F: 26 21          BNE    $9914
9911: 6F 4A 9E       CLR    $1C,U
9914: 8D 58          BSR    $9990
9916: 6C 4A 35       INC    $1D,U
9919: A6 40 95       LDA    $1D,U
991C: 81 2A          CMPA   #$02
991E: 26 8B          BNE    $9923
9920: 6F EA 9F       CLR    $1D,U
9923: 39             RTS
9924: 86 2A          LDA    #$08
9926: A7 4A 3C       STA    $14,U
9929: 6A 40 99       DEC    $11,U
992C: A6 E0 93       LDA    $1B,U
992F: 80 2A          SUBA   #$08
9931: A7 4A 99       STA    $1B,U
9934: E6 EA 93       LDB    $11,U
9937: C1 E1          CMPB   #$C9
9939: 25 92          BCS    $9955
993B: 6F E0 3D       CLR    $15,U
993E: 8E 13 21       LDX    #$9B03
9941: BD 18 01       JSR    $9A83
9944: BD BB 12       JSR    $9990
9947: 6C E0 35       INC    $1D,U
994A: A6 40 35       LDA    $1D,U
994D: 81 8A          CMPA   #$02
994F: 26 21          BNE    $9954
9951: 6F 4A 9F       CLR    $1D,U
9954: 39             RTS
9955: C1 42          CMPB   #$C0
9957: 26 2D          BNE    $995E
9959: 86 82          LDA    #$0A
995B: A7 E0 3C       STA    $14,U
995E: 8E 13 21       LDX    #$9B03
9961: BD 18 01       JSR    $9A83
9964: 86 EB          LDA    #$C9
9966: A0 4A 39       SUBA   $11,U
9969: A7 40 9D       STA    $15,U
996C: 8E B3 ED       LDX    #$9B65
996F: BD B8 9D       JSR    $9ABF
9972: 6C 4A 3E       INC    $1C,U
9975: A6 4A 9E       LDA    $1C,U
9978: 81 2A          CMPA   #$02
997A: 26 8B          BNE    $997F
997C: 6F E0 94       CLR    $1C,U
997F: BD BB B2       JSR    $9990
9982: 6C 4A 3F       INC    $1D,U
9985: A6 4A 9F       LDA    $1D,U
9988: 81 2A          CMPA   #$02
998A: 26 8B          BNE    $998F
998C: 6F E0 95       CLR    $1D,U
998F: 39             RTS
9990: A6 EA 93       LDA    $11,U
9993: 81 EB          CMPA   #$C9
9995: 22 99          BHI    $99B2
9997: 10 8E 65 44    LDY    #$4DCC
999B: 8E B3 75       LDX    #$9B5D
999E: A6 40 3F       LDA    $1D,U
99A1: C6 86          LDB    #$04
99A3: 3D             MUL
99A4: 30 A7          LEAX   B,X
99A6: 86 86          LDA    #$04
99A8: E6 A8          LDB    ,X+
99AA: E7 2C          STB    ,Y
99AC: 31 80 A8       LEAY   $20,Y
99AF: 4A             DECA
99B0: 26 D4          BNE    $99A8
99B2: 39             RTS
99B3: A6 64          LDA    $6,U
99B5: AB C5          ADDA   $7,U
99B7: A7 6E          STA    $6,U
99B9: 25 89          BCS    $99BC
99BB: 39             RTS
99BC: 6C E0 96       INC    $1E,U
99BF: A6 EA 3C       LDA    $1E,U
99C2: 81 81          CMPA   #$03
99C4: 24 30          BCC    $99D8
99C6: 8E 19 45       LDX    #$9B6D
99C9: 10 8E C5 E2    LDY    #$4DCA
99CD: A6 40 96       LDA    $1E,U
99D0: C6 24          LDB    #$06
99D2: 3D             MUL
99D3: 3A             ABX
99D4: BD B8 0C       JSR    $9A8E
99D7: 39             RTS
99D8: 81 2F          CMPA   #$07
99DA: 26 8B          BNE    $99DF
99DC: 6A E0 96       DEC    $1E,U
99DF: 8E B9 4F       LDX    #$9B6D
99E2: 10 8E 6F E8    LDY    #$4DCA
99E6: A6 4A 36       LDA    $1E,U
99E9: C6 8E          LDB    #$06
99EB: 3D             MUL
99EC: 3A             ABX
99ED: BD 12 06       JSR    $9A8E
99F0: BD B8 90       JSR    $9A12
99F3: E6 EA 33       LDB    $11,U
99F6: C1 45          CMPB   #$C7
99F8: 24 3F          BCC    $9A11
99FA: CB 8B          ADDB   #$03
99FC: E7 E0 AB       STB    $23,U
99FF: 10 AE EA A0    LDY    $22,U
9A03: 86 B5          LDA    #$97
9A05: C6 86          LDB    #$04
9A07: A7 8C          STA    ,Y
9A09: 5A             DECB
9A0A: 27 8D          BEQ    $9A11
9A0C: 31 80 A8       LEAY   $20,Y
9A0F: 20 D4          BRA    $9A07
9A11: 39             RTS
9A12: 8E 19 B5       LDX    #$9B97
9A15: BD 18 01       JSR    $9A83
9A18: A6 E0 92       LDA    $1A,U
9A1B: 80 2C          SUBA   #$04
9A1D: A7 40 92       STA    $1A,U
9A20: 6C EA 96       INC    $14,U
9A23: E6 EA 36       LDB    $14,U
9A26: C1 85          CMPB   #$07
9A28: 26 0A          BNE    $9A4C
9A2A: 8E C5 E4       LDX    #$4DCC
9A2D: AF 40 AE       STX    $26,U
9A30: 6F EA 9E       CLR    $1C,U
9A33: 6F EA 3F       CLR    $1D,U
9A36: 6F 4A 36       CLR    $1E,U
9A39: 6F 40 9D       CLR    $15,U
9A3C: 6C E0 A8       INC    $20,U
9A3F: 6F EA 36       CLR    $14,U
9A42: 8E CF E9       LDX    #$4DCB
9A45: AF 4A 92       STX    $10,U
9A48: AF E0 AC       STX    $24,U
9A4B: 39             RTS
9A4C: C1 2A          CMPB   #$02
9A4E: 26 A8          BNE    $9A70
9A50: 6A EA 93       DEC    $11,U
9A53: E6 EA 33       LDB    $11,U
9A56: C1 42          CMPB   #$C0
9A58: 26 22          BNE    $9A64
9A5A: C6 8A          LDB    #$02
9A5C: E7 E0 9C       STB    $14,U
9A5F: 6F EA 37       CLR    $15,U
9A62: 20 8E          BRA    $9A70
9A64: 6F EA 96       CLR    $14,U
9A67: 5A             DECB
9A68: E7 E0 AD       STB    $25,U
9A6B: C0 97          SUBB   #$BF
9A6D: E7 40 9D       STB    $15,U
9A70: 8E B9 E7       LDX    #$9B65
9A73: 8D 68          BSR    $9ABF
9A75: 6C 4A 9E       INC    $1C,U
9A78: A6 E0 94       LDA    $1C,U
9A7B: 81 2A          CMPA   #$02
9A7D: 26 8B          BNE    $9A82
9A7F: 6F EA 3E       CLR    $1C,U
9A82: 39             RTS
9A83: A6 EA 36       LDA    $14,U
9A86: C6 84          LDB    #$06
9A88: 3D             MUL
9A89: 3A             ABX
9A8A: 10 AE E0 38    LDY    $10,U
9A8E: 86 8A          LDA    #$02
9A90: 97 43          STA    $61
9A92: 86 81          LDA    #$03
9A94: 97 42          STA    $60
9A96: A6 02          LDA    ,X+
9A98: A7 88          STA    ,Y+
9A9A: 0A E8          DEC    $60
9A9C: 26 D0          BNE    $9A96
9A9E: 31 20 3F       LEAY   $1D,Y
9AA1: 0A E3          DEC    $61
9AA3: 26 CF          BNE    $9A92
9AA5: 30 9F          LEAX   -$3,X
9AA7: C6 2B          LDB    #$03
9AA9: A6 08          LDA    ,X+
9AAB: A7 88          STA    ,Y+
9AAD: 5A             DECB
9AAE: 26 71          BNE    $9AA9
9AB0: 30 38          LEAX   -$6,X
9AB2: 31 2A 3F       LEAY   $1D,Y
9AB5: C6 81          LDB    #$03
9AB7: A6 A8          LDA    ,X+
9AB9: A7 28          STA    ,Y+
9ABB: 5A             DECB
9ABC: 26 D1          BNE    $9AB7
9ABE: 39             RTS
9ABF: 6D EA 37       TST    $15,U
9AC2: 27 AB          BEQ    $9AED
9AC4: A6 EA 97       LDA    $15,U
9AC7: 97 4A          STA    $62
9AC9: 10 AE 40 0C    LDY    $24,U
9ACD: A6 40 94       LDA    $1C,U
9AD0: C6 26          LDB    #$04
9AD2: 3D             MUL
9AD3: 30 A7          LEAX   B,X
9AD5: C6 86          LDB    #$04
9AD7: A6 A8          LDA    ,X+
9AD9: A7 2C          STA    ,Y
9ADB: 31 80 08       LEAY   $20,Y
9ADE: 5A             DECB
9ADF: 26 D4          BNE    $9AD7
9AE1: 0A E0          DEC    $62
9AE3: 27 2A          BEQ    $9AED
9AE5: 31 2B 7D 57    LEAY   -$0081,Y
9AE9: 30 94          LEAX   -$4,X
9AEB: 20 C0          BRA    $9AD5
9AED: 39             RTS
9AEE: A6 40 0A       LDA    $28,U
9AF1: AB 4A AB       ADDA   $29,U
9AF4: A7 EA AA       STA    $28,U
9AF7: 24 2B          BCC    $9AFC
9AF9: 6F 40 A8       CLR    $20,U
9AFC: 39             RTS

A3F6: D4 82          ANDB   $00
A3F8: 6D AC          TST    ,X
A3FA: 27 8B          BEQ    $A3FF
A3FC: 7E 8C 88       JMP    $A400
A3FF: 39             RTS
A400: A6 21          LDA    $3,X
A402: 48             ASLA
A403: 10 8E 86 8B    LDY    #jump_table_a409
A407: 6E 9E          JMP    [A,Y]        ; [indirect_jump]

A411: A6 8A          LDA    $8,X
A413: AB 24          ADDA   $6,X
A415: A7 84          STA    $6,X
A417: 24 3B          BCC    $A42C
A419: 6D 87          TST    $F,X
A41B: 26 21          BNE    $A426
A41D: 86 8A          LDA    #$02
A41F: AB 26          ADDA   $4,X
A421: A7 86          STA    $4,X
A423: 7E 42 35       JMP    $6017
A426: A6 86          LDA    $4,X
A428: 80 2A          SUBA   #$02
A42A: A7 8C          STA    $4,X
A42C: 7E 48 9F       JMP    $6017
A42F: A6 AA 3D       LDA    $1F,X
A432: 48             ASLA
A433: 10 8E 86 BB    LDY    #jump_table_a439
A437: 6E 9E          JMP    [A,Y]        ; [indirect_jump]
A439: 8C B5 2C       CMPX   #$3DA4
A43C: 79 10 8E       ROL    $3806
A43F: 2D 78          BLT    $A49B
A441: 86 83          LDA    #$01
A443: A7 2D          STA    $F,X
A445: BD E2 BF       JSR    $603D
A448: 6F 22          CLR    $A,X
A44A: BD E8 3F       JSR    $6017
A44D: 6C 00 97       INC    $1F,X
A450: 39             RTS
A451: BD E2 95       JSR    $6017
A454: 6A 27          DEC    $5,X
A456: 6A 87          DEC    $5,X
A458: A6 2D          LDA    $5,X
A45A: 81 80          CMPA   #$08
A45C: 22 21          BHI    $A467
A45E: 86 89          LDA    #$01
A460: A7 23          STA    $1,X
A462: 6F 81          CLR    $3,X
A464: 6F AA 9D       CLR    $1F,X
A467: 39             RTS
A468: 6D A0 98       TST    $10,X
A46B: 27 21          BEQ    $A476
A46D: 6A 00 98       DEC    $10,X
A470: BD 42 95       JSR    $6017
A473: 7E 42 35       JMP    $6017
A476: 31 06          LEAY   ,X
A478: AE 80 9D       LDX    $15,Y
A47B: C6 3F          LDB    #$17
A47D: E7 00 9B       STB    $13,X
A480: 86 23          LDA    #$01
A482: A7 06          STA    ,X
A484: 6F 21          CLR    $3,X
A486: 6F 2A 3C       CLR    $14,Y
A489: 30 2C          LEAX   ,Y
A48B: A6 27          LDA    $F,X
A48D: 88 8A          EORA   #$02
A48F: A7 2D          STA    $F,X
A491: 10 8E 26 80    LDY    #$A4A2
A495: BD E2 BF       JSR    $603D
A498: 6F 22          CLR    $A,X
A49A: 6F 8B          CLR    $3,X
A49C: BD 48 9F       JSR    $6017
A49F: 7E 59 5B       JMP    $7B79

A585: DD 27          STD    $A5
A587: FB BD 8D       ADDB   $95A5
A58A: 27 BD          BEQ    $A5C1
A58C: 8E CC BD       LDX    #$E435
A58F: 2F 99          BLE    $A54C
A591: BD 2A 55       JSR    $A8D7
A594: BD 8B BF       JSR    $A93D
A597: BD 81 B0       JSR    $A998
A59A: BD 22 B0       JSR    $AA98
A59D: BD 25 31       JSR    $ADB9
A5A0: BD 8E 9C       JSR    $AC1E
A5A3: BD 89 53       JSR    $AB71
A5A6: BD 29 E1       JSR    $ABC9
A5A9: BD 24 70       JSR    $ACF8
A5AC: 7E 85 F8       JMP    $AD70
A5AF: 0D A2          TST    $80
A5B1: 27 AE          BEQ    $A5DF
A5B3: 8E 75 22       LDX    #$5700
A5B6: 10 8E 7C 28    LDY    #$5400
A5BA: 6D 0C          TST    ,X
A5BC: 27 09          BEQ    $A5DF
A5BE: A6 AB          LDA    $3,Y
A5C0: 26 3F          BNE    $A5DF
A5C2: A6 80          LDA    $2,X
A5C4: 80 26          SUBA   #$04
A5C6: A0 83          SUBA   $1,X
A5C8: 97 48          STA    $60
A5CA: A6 AC          LDA    $4,Y
A5CC: 6D 07          TST    $F,Y
A5CE: 26 8A          BNE    $A5D2
A5D0: 8B 2E          ADDA   #$0C
A5D2: A0 83          SUBA   $1,X
A5D4: 91 42          CMPA   $60
A5D6: 25 8A          BCS    $A5E0
A5D8: 30 2C          LEAX   $4,X
A5DA: 8C DF 77       CMPX   #$575F
A5DD: 25 53          BCS    $A5BA
A5DF: 39             RTS
A5E0: A6 07          LDA    $5,Y
A5E2: 8B 89          ADDA   #$0B
A5E4: A0 21          SUBA   $3,X
A5E6: 40             NEGA
A5E7: 81 2A          CMPA   #$02
A5E9: 22 65          BHI    $A5D8
A5EB: 0F A8          CLR    $80
A5ED: 86 89          LDA    #$01
A5EF: 6D 86          TST    ,Y
A5F1: 27 9F          BEQ    $A610
A5F3: 6D 01          TST    $3,Y
A5F5: 26 8B          BNE    $A600
A5F7: 6F 09          CLR    $1,Y
A5F9: A7 AB          STA    $3,Y
A5FB: 6F 80 37       CLR    $1F,Y
A5FE: 20 8F          BRA    $A607
A600: A7 03          STA    $1,Y
A602: 6F A1          CLR    $3,Y
A604: 6F 8A 9D       CLR    $1F,Y
A607: 31 80 08       LEAY   $20,Y
A60A: 10 8C 7D 17    CMPY   #$553F
A60E: 25 57          BCS    $A5EF
A610: CC 2C 92       LDD    #$0E10
A613: 8E 76 22       LDX    #$5400
A616: 6D 06          TST    ,X
A618: 27 24          BEQ    $A626
A61A: A7 85          STA    $D,X
A61C: 30 A0 A8       LEAX   $20,X
A61F: 8C 77 1D       CMPX   #$553F
A622: 25 70          BCS    $A616
A624: 20 25          BRA    $A62D
A626: A7 8F          STA    $D,X
A628: CC 29 88       LDD    #$0100
A62B: ED AC          STD    ,X
A62D: 8E DD C8       LDX    #$5540
A630: C6 32          LDB    #$10
A632: E7 8F          STB    $D,X
A634: CC 23 82       LDD    #$0100
A637: ED AC          STD    ,X
A639: A7 8B          STA    $3,X
A63B: A6 27          LDA    $F,X
A63D: 10 8E 2E 9E    LDY    #$A6BC
A641: BD E2 BF       JSR    $603D
A644: 86 23          LDA    #$01
A646: A7 81          STA    $3,X
A648: FC 79 4C       LDD    $51C4
A64B: ED 2C          STD    $4,X
A64D: DD 14          STD    $9C
A64F: B6 73 EC       LDA    $51CE
A652: 84 72          ANDA   #$F0
A654: E6 2C          LDB    $E,X
A656: C4 8D          ANDB   #$0F
A658: E7 26          STB    $E,X
A65A: AA 86          ORA    $E,X
A65C: A7 26          STA    $E,X
A65E: FC DC 26       LDD    $5404
A661: DD 1C          STD    $9E
A663: 34 12          PSHS   Y,X
A665: BD F9 9B       JSR    $7B19
A668: 35 18          PULS   X,Y
A66A: 10 8E 7C 28    LDY    #$5400
A66E: 6D A7          TST    $F,Y
A670: 26 07          BNE    $A697
A672: 6D A3          TST    $1,Y
A674: 26 33          BNE    $A687
A676: A6 A6          LDA    $4,Y
A678: 80 38          SUBA   #$10
A67A: 31 20 08       LEAY   $20,Y
A67D: E6 A5          LDB    $D,Y
A67F: C1 32          CMPB   #$10
A681: 27 86          BEQ    $A687
A683: A7 06          STA    $4,Y
A685: 20 69          BRA    $A672
A687: FC 79 EC       LDD    $51C4
A68A: 8B 81          ADDA   #$09
A68C: CB 2E          ADDB   #$06
A68E: A1 20 C6       CMPA   -$1C,Y
A691: 25 AA          BCS    $A6BB
A693: ED 8A C6       STD    -$1C,Y
A696: 39             RTS
A697: 6D 09          TST    $1,Y
A699: 26 99          BNE    $A6AC
A69B: A6 0C          LDA    $4,Y
A69D: 8B 98          ADDA   #$10
A69F: 31 8A 02       LEAY   $20,Y
A6A2: E6 AF          LDB    $D,Y
A6A4: C1 32          CMPB   #$10
A6A6: 27 86          BEQ    $A6AC
A6A8: A7 0C          STA    $4,Y
A6AA: 20 63          BRA    $A697
A6AC: FC 79 4C       LDD    $51C4
A6AF: 80 2B          SUBA   #$09
A6B1: CB 85          ADDB   #$07
A6B3: A1 8A C6       CMPA   -$1C,Y
A6B6: 22 81          BHI    $A6BB
A6B8: ED 80 6C       STD    -$1C,Y
A6BB: 39             RTS
A6BC: 8E E4 88       LDX    #$CC00
A6BF: 88 84          EORA   #$A6
A6C1: F0 82 82       SUBB   >$0000
A6C4: 84 FA          ANDA   #$D8
A6C6: 82 82          SBCA   #$00
A6C8: 8E F6 88       LDX    #$DE00
A6CB: 88 38          EORA   #$10
A6CD: E8 8B          EORB   $3,X
A6CF: 77 84 EE       ASR    $A6CC
A6D2: 92 C2          SBCA   $40
A6D4: 21 DD          BRN    $A6D5
A6D6: 24 50          BCC    $A6AA
A6D8: 38 A8          XANDCC #$80
A6DA: 8B 77          ADDA   #$FF
A6DC: 8E F0 98       LDX    #$D810
A6DF: 88 21          EORA   #$03
A6E1: DD 24          STD    $A6
A6E3: 5C             INCB
A6E4: CE 76 82       LDU    #$5400
A6E7: 6D EC          TST    ,U
A6E9: 27 FB          BEQ    $A75E
A6EB: A6 6B          LDA    $3,U
A6ED: 81 89          CMPA   #$01
A6EF: 26 4F          BNE    $A75E
A6F1: 8E D3 42       LDX    #$51C0
A6F4: 6D 21          TST    $3,X
A6F6: 26 E4          BNE    $A75E
A6F8: 6D A0 91       TST    $19,X
A6FB: 26 49          BNE    $A75E
A6FD: A6 87          LDA    $F,X
A6FF: 85 23          BITA   #$01
A701: 26 D9          BNE    $A75E
A703: D6 18          LDB    $3A
A705: C5 86          BITB   #$04
A707: 27 7D          BEQ    $A75E
A709: D6 15          LDB    $9D
A70B: 5C             INCB
A70C: 27 78          BEQ    $A75E
A70E: 4F             CLRA
A70F: 6D 6D          TST    $F,U
A711: 26 CE          BNE    $A75F
A713: E6 26          LDB    $4,X
A715: CB 8A          ADDB   #$08
A717: D0 B4          SUBB   $9C
A719: D7 E8          STB    $60
A71B: D6 B6          LDB    $9E
A71D: D0 14          SUBB   $9C
A71F: D1 42          CMPB   $60
A721: 23 B9          BLS    $A75E
A723: E6 26          LDB    $4,X
A725: D0 1E          SUBB   $9C
A727: 23 1D          BLS    $A75E
A729: 58             ASLB
A72A: 49             ROLA
A72B: 10 8E C8 88    LDY    #$E000
A72F: 31 89          LEAY   D,Y
A731: 10 AF 0A 30    STY    $12,X
A735: EC 26          LDD    ,Y
A737: DB B5          ADDB   $9D
A739: 9B 14          ADDA   $9C
A73B: DD 48          STD    $60
A73D: CB 84          ADDB   #$0C
A73F: E0 27          SUBB   $5,X
A741: C0 8A          SUBB   #$08
A743: C1 28          CMPB   #$0A
A745: 24 95          BCC    $A75E
A747: DC 48          LDD    $60
A749: ED 8C          STD    $4,X
A74B: C6 29          LDB    #$01
A74D: E7 8B          STB    $3,X
A74F: 6F AA 32       CLR    $10,X
A752: 6F 0A 33       CLR    $11,X
A755: 6F 88          CLR    $A,X
A757: C6 2D          LDB    #$05
A759: E7 85          STB    $D,X
A75B: 7E 8F 8F       JMP    $A7A7
A75E: 39             RTS
A75F: E6 26          LDB    $4,X
A761: D0 1C          SUBB   $9E
A763: C0 2A          SUBB   #$08
A765: D7 E2          STB    $60
A767: D6 B4          LDB    $9C
A769: D0 16          SUBB   $9E
A76B: D1 48          CMPB   $60
A76D: 23 67          BLS    $A75E
A76F: D6 BE          LDB    $9C
A771: E0 86          SUBB   $4,X
A773: 23 CB          BLS    $A75E
A775: 58             ASLB
A776: 49             ROLA
A777: 10 8E CA 88    LDY    #$E200
A77B: 31 83          LEAY   D,Y
A77D: 10 AF 00 30    STY    $12,X
A781: EC 26          LDD    ,Y
A783: DB BF          ADDB   $9D
A785: 9B 1E          ADDA   $9C
A787: DD 48          STD    $60
A789: CB 84          ADDB   #$0C
A78B: E0 2D          SUBB   $5,X
A78D: C0 80          SUBB   #$08
A78F: C1 28          CMPB   #$0A
A791: 24 49          BCC    $A75E
A793: DC 42          LDD    $60
A795: ED 86          STD    $4,X
A797: C6 29          LDB    #$01
A799: E7 8B          STB    $3,X
A79B: 6F A0 38       CLR    $10,X
A79E: 6F 00 33       CLR    $11,X
A7A1: 6F 88          CLR    $A,X
A7A3: C6 27          LDB    #$05
A7A5: E7 8F          STB    $D,X
A7A7: A6 67          LDA    $F,U
A7A9: 6D 87          TST    $F,X
A7AB: 26 2F          BNE    $A7B4
A7AD: 10 8E 74 E0    LDY    #$FCC2
A7B1: 7E E2 BF       JMP    $603D
A7B4: 10 8E 7E 50    LDY    #$FCD2
A7B8: 7E 48 B5       JMP    $603D
A7BB: 8E 79 E8       LDX    #$51C0
A7BE: 6D 0C          TST    ,X
A7C0: 27 2F          BEQ    $A7CF
A7C2: 6D 83          TST    $1,X
A7C4: 26 2B          BNE    $A7CF
A7C6: E6 81          LDB    $3,X
A7C8: 58             ASLB
A7C9: 10 8E 2F F8    LDY    #jump_table_a7d0
A7CD: 6E 3D          JMP    [B,Y]        ; [indirect_jump]
A7CF: 39             RTS
A7D0: 85 F8          BITA   #$DA
A7D2: 2A E1          BPL    $A837
A7D4: 85 ED          BITA   #$CF
A7D6: 25 4D          BCS    $A7A7
A7D8: 8F E7 A6       XSTX   #$CF2E
A7DB: 8D 8B          BSR    $A780
A7DD: 20 97          BRA    $A7FE
A7DF: E8 96          EORB   [,Y]
A7E1: BD 8B 8A       JSR    $0908
A7E4: 90 42          SUBA   $60
A7E6: 8B 86          ADDA   #$04
A7E8: 81 20          CMPA   #$08
A7EA: 23 ED          BLS    $A851
A7EC: 7D 7C 87       TST    $540F
A7EF: 26 2E          BNE    $A7FD
A7F1: A6 86          LDA    $4,X
A7F3: 80 2A          SUBA   #$08
A7F5: 90 1C          SUBA   $9E
A7F7: 81 2C          CMPA   #$04
A7F9: 23 DE          BLS    $A851
A7FB: 20 22          BRA    $A807
A7FD: A6 8C          LDA    $4,X
A7FF: 8B 2A          ADDA   #$08
A801: 90 1C          SUBA   $9E
A803: 81 26          CMPA   #$04
A805: 23 C8          BLS    $A851
A807: 10 8E 7F 88    LDY    #$5700
A80B: A6 A0 35       LDA    $1D,X
A80E: 48             ASLA
A80F: 48             ASLA
A810: 31 84          LEAY   A,Y
A812: EC 86          LDD    $4,X
A814: E1 01          CMPB   $3,Y
A816: 26 BB          BNE    $A851
A818: 8B 20          ADDA   #$08
A81A: A0 A9          SUBA   $1,Y
A81C: 8B 2D          ADDA   #$05
A81E: 97 E8          STA    $60
A820: E6 00          LDB    $2,Y
A822: E0 A3          SUBB   $1,Y
A824: CB 28          ADDB   #$0A
A826: D1 E2          CMPB   $60
A828: 24 0F          BCC    $A851
A82A: 96 49          LDA    $C1
A82C: 84 2B          ANDA   #$03
A82E: 4A             DECA
A82F: 26 25          BNE    $A838
A831: BD 2A 22       JSR    $A8A0
A834: 0D 42          TST    $60
A836: 26 9B          BNE    $A851
A838: 86 2A          LDA    #$02
A83A: A7 8B          STA    $3,X
A83C: 6F A0 96       CLR    $1E,X
A83F: A6 2D          LDA    $F,X
A841: 85 83          BITA   #$01
A843: 26 27          BNE    $A84A
A845: 6F 8F          CLR    $D,X
A847: 7E 53 A1       JMP    $7B89
A84A: 86 99          LDA    #$11
A84C: A7 25          STA    $D,X
A84E: 7E F3 AB       JMP    $7B89
A851: A6 0A 9A       LDA    $18,X
A854: AA AA 9B       ORA    $19,X
A857: AA A0 32       ORA    $1A,X
A85A: AA 00 33       ORA    $1B,X
A85D: AA 00 94       ORA    $1C,X
A860: 27 EA          BEQ    $A82A
A862: 39             RTS
A863: D6 18          LDB    $3A
A865: C5 85          BITB   #$07
A867: 26 37          BNE    $A888
A869: D4 B3          ANDB   $3B
A86B: C4 20          ANDB   #$08
A86D: 27 91          BEQ    $A888
A86F: A6 2D          LDA    $F,X
A871: 85 83          BITA   #$01
A873: 26 08          BNE    $A89F
A875: 86 81          LDA    #$03
A877: AB 2D          ADDA   $5,X
A879: A7 8D          STA    $5,X
A87B: 86 2A          LDA    #$02
A87D: A7 8B          STA    $3,X
A87F: 6F AA 3C       CLR    $1E,X
A882: 6F 0A 33       CLR    $11,X
A885: 7E F9 0B       JMP    $7B89
A888: 10 8E DC 88    LDY    #$5400
A88C: A6 2B          LDA    $3,X
A88E: 81 89          CMPA   #$01
A890: 26 2F          BNE    $A89F
A892: 6D 26          TST    ,Y
A894: 26 2B          BNE    $A89F
A896: CC 7D D7       LDD    #$FFFF
A899: DD 14          STD    $9C
A89B: DD B6          STD    $9E
A89D: 20 5E          BRA    $A875
A89F: 39             RTS
A8A0: 86 2A          LDA    #$08
A8A2: 97 E2          STA    $60
A8A4: 10 8E D4 02    LDY    #$5680
A8A8: EC 2C          LDD    $4,X
A8AA: 8B 80          ADDA   #$08
A8AC: DD 4A          STD    $62
A8AE: A6 2C          LDA    ,Y
A8B0: 4A             DECA
A8B1: 27 94          BEQ    $A8C9
A8B3: DC 40          LDD    $62
A8B5: E1 A1          CMPB   $3,Y
A8B7: 26 38          BNE    $A8C9
A8B9: A0 A9          SUBA   $1,Y
A8BB: 8B 2A          ADDA   #$02
A8BD: 97 E9          STA    $61
A8BF: E6 00          LDB    $2,Y
A8C1: E0 A3          SUBB   $1,Y
A8C3: CB 26          ADDB   #$04
A8C5: D1 E3          CMPB   $61
A8C7: 24 21          BCC    $A8D2
A8C9: 31 AC          LEAY   $4,Y
A8CB: 0A 48          DEC    $60
A8CD: 26 57          BNE    $A8AE
A8CF: 0F 42          CLR    $60
A8D1: 39             RTS
A8D2: 86 83          LDA    #$01
A8D4: 97 42          STA    $60
A8D6: 39             RTS
A8D7: 10 8E 7C 88    LDY    #$5400
A8DB: 8E 79 E8       LDX    #$51C0
A8DE: 8D 99          BSR    $A8F1
A8E0: 39             RTS
A8E1: DD 7D          STD    $FF
A8E3: 83 23 23       SUBD   #$0101
A8E6: 83 7D D7       SUBD   #$FFFF
A8E9: 29 89          BVS    $A8EC
A8EB: 77 D7 D7       ASR    $FFFF
A8EE: 77 89 23       ASR    $0101
A8F1: 6D 26          TST    ,Y
A8F3: 27 0D          BEQ    $A924
A8F5: A6 81          LDA    $3,X
A8F7: 81 29          CMPA   #$01
A8F9: 26 A1          BNE    $A924
A8FB: A6 0B          LDA    $3,Y
A8FD: 81 8A          CMPA   #$02
A8FF: 26 0C          BNE    $A92F
A901: D6 B8          LDB    $3A
A903: C4 21          ANDB   #$03
A905: 26 9C          BNE    $A925
A907: 6D A0 39       TST    $11,X
A90A: 26 82          BNE    $A916
A90C: 86 29          LDA    #$01
A90E: A7 00 33       STA    $11,X
A911: A6 87          LDA    $5,X
A913: A7 AA 32       STA    $10,X
A916: CE 04 0B       LDU    #$8623
A919: 96 C7          LDA    $4F
A91B: 84 27          ANDA   #$0F
A91D: A6 4E          LDA    A,U
A91F: AB AA 32       ADDA   $10,X
A922: A7 87          STA    $5,X
A924: 39             RTS
A925: 86 80          LDA    #$02
A927: A7 2B          STA    $3,X
A929: 6F 00 96       CLR    $1E,X
A92C: 7E 53 01       JMP    $7B89
A92F: 6D AA 33       TST    $11,X
A932: 27 72          BEQ    $A924
A934: 6F AA 93       CLR    $11,X
A937: A6 A0 38       LDA    $10,X
A93A: A7 8D          STA    $5,X
A93C: 39             RTS
A93D: 8E DA 88       LDX    #$5200
A940: 10 8E D6 82    LDY    #$5400
A944: C6 24          LDB    #$06
A946: 34 86          PSHS   B
A948: 6D AC          TST    ,X
A94A: 27 80          BEQ    $A954
A94C: A6 2B          LDA    $3,X
A94E: 81 8D          CMPA   #$05
A950: 26 20          BNE    $A954
A952: 8D 8B          BSR    $A95D
A954: 30 AA A2       LEAX   $20,X
A957: 6A CC          DEC    ,S
A959: 26 65          BNE    $A948
A95B: 35 AC          PULS   B,PC
A95D: 6D 2C          TST    ,Y
A95F: 27 2C          BEQ    $A96F
A961: A6 A1          LDA    $3,Y
A963: 81 22          CMPA   #$00
A965: 27 8A          BEQ    $A96F
A967: DC B6          LDD    $9E
A969: 10 83 77 D7    CMPD   #$FFFF
A96D: 26 9F          BNE    $A986
A96F: 6F AA 3D       CLR    $1F,X
A972: 86 81          LDA    #$03
A974: A7 21          STA    $3,X
A976: 34 B2          PSHS   Y,X
A978: 8D 25          BSR    $A987
A97A: CC 8C 23       LDD    #$040B
A97D: DB 6A          ADDB   $E2
A97F: 0C C0          INC    $E2
A981: BD E2 8A       JSR    $6008
A984: 35 92          PULS   X,Y,PC
A986: 39             RTS
A987: CE 81 BB       LDU    #$A993
A98A: 96 6A          LDA    $E2
A98C: A6 EE          LDA    A,U
A98E: 31 0C          LEAY   ,X
A990: 16 22 1D       LBRA   $AA32
A993: C3 67 61       ADDD   #$4543
A996: C5 CA          BITB   #$48
A998: 8E 79 68       LDX    #$51E0
A99B: 6D AC          TST    ,X
A99D: 27 BF          BEQ    $A9D6
A99F: 10 8E 70 82    LDY    #$5200
A9A3: C6 24          LDB    #$06
A9A5: 34 86          PSHS   B
A9A7: E6 0B          LDB    $3,Y
A9A9: A6 20 97       LDA    $1F,Y
A9AC: C1 2E          CMPB   #$06
A9AE: 27 9E          BEQ    $A9C6
A9B0: C1 21          CMPB   #$03
A9B2: 27 90          BEQ    $A9C6
A9B4: C1 20          CMPB   #$02
A9B6: 26 86          BNE    $A9BC
A9B8: 81 2A          CMPA   #$02
A9BA: 26 82          BNE    $A9C6
A9BC: C1 2F          CMPB   #$07
A9BE: 26 8C          BNE    $A9C4
A9C0: 81 20          CMPA   #$02
A9C2: 22 80          BHI    $A9C6
A9C4: 8D 33          BSR    $A9D7
A9C6: 31 2A 08       LEAY   $20,Y
A9C9: 6A 6C          DEC    ,S
A9CB: 26 F2          BNE    $A9A7
A9CD: 32 E9          LEAS   $1,S
A9CF: 10 8E 74 82    LDY    #$5600
A9D3: 7E 88 7D       JMP    $AA5F
A9D6: 39             RTS
A9D7: 6D 8C          TST    ,Y
A9D9: 27 C8          BEQ    $AA1B
A9DB: 6D 09          TST    $1,Y
A9DD: 26 B4          BNE    $AA1B
A9DF: EC 06          LDD    $4,Y
A9E1: 8B 8A          ADDA   #$08
A9E3: CB 2E          ADDB   #$0C
A9E5: DD E2          STD    $60
A9E7: EC 2C          LDD    $4,X
A9E9: 8B 80          ADDA   #$08
A9EB: CB 20          ADDB   #$08
A9ED: D0 E9          SUBB   $61
A9EF: CB 2A          ADDB   #$08
A9F1: C1 92          CMPB   #$10
A9F3: 22 04          BHI    $AA1B
A9F5: 90 E2          SUBA   $60
A9F7: 8B 20          ADDA   #$08
A9F9: 81 9A          CMPA   #$12
A9FB: 22 36          BHI    $AA1B
A9FD: B6 D9 48       LDA    $51C0
AA00: 81 20          CMPA   #$02
AA02: 27 9A          BEQ    $AA1C
AA04: A6 01          LDA    $3,Y
AA06: 81 87          CMPA   #$05
AA08: 27 3A          BEQ    $AA1C
AA0A: 34 B8          PSHS   Y,X
AA0C: CC 2C 81       LDD    #$0409
AA0F: BD 42 2A       JSR    $6008
AA12: 35 B2          PULS   X,Y
AA14: 86 20          LDA    #$02
AA16: A7 A1          STA    $3,Y
AA18: 6F 80 97       CLR    $1F,Y
AA1B: 39             RTS
AA1C: 34 18          PSHS   Y,X
AA1E: 86 CC          LDA    #$44
AA20: 8D 32          BSR    $AA32
AA22: CC 86 28       LDD    #$040A
AA25: BD E2 8A       JSR    $6008
AA28: 35 18          PULS   X,Y
AA2A: 86 8B          LDA    #$03
AA2C: A7 0B          STA    $3,Y
AA2E: 6F 20 3D       CLR    $1F,Y
AA31: 39             RTS
AA32: A7 AF          STA    $D,Y
AA34: 0D 71          TST    $53
AA36: 27 86          BEQ    $AA3C
AA38: 0D 08          TST    $20
AA3A: 26 9A          BNE    $AA4E
AA3C: A6 06          LDA    $E,Y
AA3E: 84 78          ANDA   #$F0
AA40: 81 62          CMPA   #$40
AA42: 27 98          BEQ    $AA5E
AA44: A6 0C          LDA    $E,Y
AA46: 84 8D          ANDA   #$0F
AA48: 8A 68          ORA    #$40
AA4A: A7 A6          STA    $E,Y
AA4C: 20 38          BRA    $AA5E
AA4E: A6 A6          LDA    $E,Y
AA50: 84 D2          ANDA   #$F0
AA52: 81 02          CMPA   #$80
AA54: 27 2A          BEQ    $AA5E
AA56: A6 AC          LDA    $E,Y
AA58: 84 27          ANDA   #$0F
AA5A: 8A 08          ORA    #$80
AA5C: A7 06          STA    $E,Y
AA5E: 39             RTS
AA5F: 6D A6          TST    ,X
AA61: 27 B6          BEQ    $AA97
AA63: 6D 86          TST    ,Y
AA65: 27 B2          BEQ    $AA97
AA67: 6D 09          TST    $1,Y
AA69: 26 A4          BNE    $AA97
AA6B: A6 0B          LDA    $3,Y
AA6D: 81 89          CMPA   #$01
AA6F: 27 04          BEQ    $AA97
AA71: EC A6          LDD    $4,Y
AA73: 8B 2A          ADDA   #$08
AA75: CB 8A          ADDB   #$08
AA77: DD 48          STD    $60
AA79: EC 8C          LDD    $4,X
AA7B: 8B 20          ADDA   #$08
AA7D: CB 80          ADDB   #$08
AA7F: D0 43          SUBB   $61
AA81: CB 8A          ADDB   #$08
AA83: C1 32          CMPB   #$10
AA85: 22 92          BHI    $AA97
AA87: 90 48          SUBA   $60
AA89: 8B 80          ADDA   #$08
AA8B: 81 3A          CMPA   #$12
AA8D: 22 80          BHI    $AA97
AA8F: CC 23 22       LDD    #$0100
AA92: A7 A1          STA    $3,Y
AA94: E7 8A 9D       STB    $1F,Y
AA97: 39             RTS
AA98: 8E 79 48       LDX    #$51C0
AA9B: 6D AC          TST    ,X
AA9D: 27 A2          BEQ    $AAC9
AA9F: 10 8E 70 82    LDY    #$5200
AAA3: C6 24          LDB    #$06
AAA5: 34 86          PSHS   B
AAA7: E6 0B          LDB    $3,Y
AAA9: C1 8E          CMPB   #$06
AAAB: 27 2E          BEQ    $AAB3
AAAD: C1 8B          CMPB   #$03
AAAF: 27 20          BEQ    $AAB3
AAB1: 8D 95          BSR    $AACA
AAB3: 31 8A 02       LEAY   $20,Y
AAB6: 6A 66          DEC    ,S
AAB8: 26 C5          BNE    $AAA7
AABA: 32 E9          LEAS   $1,S
AABC: 10 8E DE 88    LDY    #$5600
AAC0: A6 01          LDA    $3,Y
AAC2: 81 81          CMPA   #$03
AAC4: 27 21          BEQ    $AAC9
AAC6: 7E 28 E2       JMP    $AACA
AAC9: 39             RTS
AACA: 6D 2C          TST    ,Y
AACC: 27 6A          BEQ    $AB10
AACE: EC 8C          LDD    $4,X
AAD0: 8B 2A          ADDA   #$08
AAD2: CB 8A          ADDB   #$08
AAD4: DD 42          STD    $60
AAD6: EC A6          LDD    $4,Y
AAD8: 8B 20          ADDA   #$08
AADA: CB 80          ADDB   #$08
AADC: 90 48          SUBA   $60
AADE: 8B 8E          ADDA   #$06
AAE0: 81 2E          CMPA   #$0C
AAE2: 22 AE          BHI    $AB10
AAE4: D0 43          SUBB   $61
AAE6: CB 8A          ADDB   #$08
AAE8: C1 38          CMPB   #$10
AAEA: 22 AC          BHI    $AB10
AAEC: A6 AC          LDA    ,X
AAEE: 81 8A          CMPA   #$02
AAF0: 24 3D          BCC    $AB11
AAF2: E6 A1          LDB    $3,Y
AAF4: C1 20          CMPB   #$02
AAF6: 26 85          BNE    $AAFF
AAF8: A6 80 97       LDA    $1F,Y
AAFB: 81 2A          CMPA   #$02
AAFD: 26 99          BNE    $AB10
AAFF: 34 02          PSHS   Y
AB01: BD F9 13       JSR    $7B91
AB04: 35 02          PULS   Y
AB06: 86 80          LDA    #$02
AB08: 97 2D          STA    $05
AB0A: 0F 80          CLR    $08
AB0C: 0F 23          CLR    $0B
AB0E: 0F 86          CLR    $0E
AB10: 39             RTS
AB11: E6 A1          LDB    $3,Y
AB13: C1 20          CMPB   #$02
AB15: 26 85          BNE    $AB1E
AB17: A6 80 37       LDA    $1F,Y
AB1A: 81 8A          CMPA   #$02
AB1C: 26 19          BNE    $AB4F
AB1E: A6 00 35       LDA    $17,X
AB21: CE 29 EB       LDU    #$AB69
AB24: A6 E4          LDA    A,U
AB26: BD 28 1A       JSR    $AA32
AB29: 34 B8          PSHS   Y,X
AB2B: E6 A0 3F       LDB    $17,X
AB2E: CB 98          ADDB   #$10
AB30: 86 26          LDA    #$04
AB32: BD E2 2A       JSR    $6008
AB35: 35 B2          PULS   X,Y
AB37: A6 A0 3F       LDA    $17,X
AB3A: 81 8F          CMPA   #$07
AB3C: 22 2B          BHI    $AB41
AB3E: 6C 00 35       INC    $17,X
AB41: 86 81          LDA    #$03
AB43: A7 01          STA    $3,Y
AB45: 6F 2A 9D       CLR    $1F,Y
AB48: 34 18          PSHS   Y,X
AB4A: BD F3 B1       JSR    $7B99
AB4D: 35 38          PULS   X,Y,PC
AB4F: 34 12          PSHS   Y,X
AB51: 86 C6          LDA    #$44
AB53: BD 88 10       JSR    $AA32
AB56: CC 86 22       LDD    #$040A
AB59: BD E8 80       JSR    $6008
AB5C: BD 53 11       JSR    $7B99
AB5F: 35 12          PULS   X,Y
AB61: 86 81          LDA    #$03
AB63: A7 01          STA    $3,Y
AB65: 6F 2A 9D       CLR    $1F,Y
AB68: 39             RTS
AB69: C8 CB          EORB   #$43
AB6B: C0 C9          SUBB   #$E1
AB6D: CA 6B          ORB    #$E3
AB6F: 6C C7          INC    B,S
AB71: 8E D3 42       LDX    #$51C0
AB74: 6D A6          TST    ,X
AB76: 27 9D          BEQ    $AB97
AB78: 10 8E DB C8    LDY    #$5340
AB7C: C6 2B          LDB    #$03
AB7E: D7 E8          STB    $60
AB80: 6D 86          TST    ,Y
AB82: 27 8E          BEQ    $AB90
AB84: 6D 03          TST    $1,Y
AB86: 26 8A          BNE    $AB90
AB88: A6 0B          LDA    $3,Y
AB8A: 81 8A          CMPA   #$02
AB8C: 27 2A          BEQ    $AB90
AB8E: 8D 80          BSR    $AB98
AB90: 31 8A A2       LEAY   $20,Y
AB93: 0A 42          DEC    $60
AB95: 26 6B          BNE    $AB80
AB97: 39             RTS
AB98: EC 2C          LDD    $4,X
AB9A: 8B 80          ADDA   #$08
AB9C: CB 20          ADDB   #$08
AB9E: DD E9          STD    $61
ABA0: EC 06          LDD    $4,Y
ABA2: 8B 8A          ADDA   #$08
ABA4: CB 24          ADDB   #$06
ABA6: 90 E3          SUBA   $61
ABA8: 8B 2E          ADDA   #$06
ABAA: 81 84          CMPA   #$0C
ABAC: 22 32          BHI    $ABC8
ABAE: D0 EA          SUBB   $62
ABB0: CB 24          ADDB   #$06
ABB2: C1 8E          CMPB   #$0C
ABB4: 22 30          BHI    $ABC8
ABB6: 34 A2          PSHS   Y
ABB8: BD 53 1D       JSR    $7B95
ABBB: 35 08          PULS   Y
ABBD: 86 8A          LDA    #$02
ABBF: 97 27          STA    $05
ABC1: 0F 8A          CLR    $08
ABC3: 0F 29          CLR    $0B
ABC5: 0F 8C          CLR    $0E
ABC7: 39             RTS
ABC8: 39             RTS
ABC9: 8E D9 48       LDX    #$51C0
ABCC: 96 E9          LDA    $C1
ABCE: 84 8B          ANDA   #$03
ABD0: 48             ASLA
ABD1: 10 8E 29 DA    LDY    #$ABF8
ABD5: 31 24          LEAY   A,Y
ABD7: EC 2C          LDD    $4,X
ABD9: 8B 80          ADDA   #$08
ABDB: DD 48          STD    $60
ABDD: E1 A9          CMPB   $1,Y
ABDF: 26 34          BNE    $ABF7
ABE1: A0 26          SUBA   ,Y
ABE3: 8B 20          ADDA   #$02
ABE5: 81 96          CMPA   #$14
ABE7: 22 26          BHI    $ABF7
ABE9: 8D 9D          BSR    $AC00
ABEB: 86 2B          LDA    #$03
ABED: 97 8D          STA    $05
ABEF: 86 22          LDA    #$00
ABF1: 97 8A          STA    $08
ABF3: 97 29          STA    $0B
ABF5: 97 8C          STA    $0E
ABF7: 39             RTS
ABF8: F8 E0 30       EORB   $C8B8
ABFB: 48             ASLA
ABFC: F8 E0 F0       EORB   $C878
ABFF: 40             NEGA
AC00: 96 6D          LDA    $4F
AC02: 97 E1          STA    $63
AC04: 86 22          LDA    #$00
AC06: 97 CD          STA    $4F
AC08: BD 86 9A       JSR    $AE12
AC0B: 8E 7A E8       LDX    #$52C0
AC0E: CC 88 26       LDD    #$0004
AC11: A7 06          STA    ,X
AC13: 30 AA 32       LEAX   $10,X
AC16: 5A             DECB
AC17: 26 D0          BNE    $AC11
AC19: 96 EB          LDA    $63
AC1B: 97 67          STA    $4F
AC1D: 39             RTS
AC1E: 8E DA E2       LDX    #$52C0
AC21: 10 8E D3 E2    LDY    #$51C0
AC25: C6 86          LDB    #$04
AC27: 34 3C          PSHS   X,B
AC29: 6D 0C          TST    ,X
AC2B: 27 20          BEQ    $AC35
AC2D: 6D 89          TST    $1,X
AC2F: 26 26          BNE    $AC35
AC31: 8D 8F          BSR    $AC40
AC33: AE 43          LDX    $1,S
AC35: 30 0A 92       LEAX   $10,X
AC38: AF 49          STX    $1,S
AC3A: 6A 6C          DEC    ,S
AC3C: 26 C3          BNE    $AC29
AC3E: 35 1C          PULS   B,X,PC
AC40: EC 06          LDD    $4,Y
AC42: 10 A3 26       CMPD   $4,X
AC45: 26 AE          BNE    $AC73
AC47: 10 AE 2A       LDY    $2,X
AC4A: EC 8E          LDD    $6,X
AC4C: ED 8C          STD    ,Y
AC4E: EC 80          LDD    $8,X
AC50: A7 00          STA    $2,Y
AC52: 31 2B DE 22    LEAY   -$0400,Y
AC56: E7 26          STB    ,Y
AC58: EC 22          LDD    $A,X
AC5A: ED A9          STD    $1,Y
AC5C: 8D 3E          BSR    $AC74
AC5E: 8D ED          BSR    $ACC5
AC60: 86 23          LDA    #$01
AC62: A7 83          STA    $1,X
AC64: 6F A6          CLR    ,X
AC66: CC 86 29       LDD    #$0401
AC69: DB 69          ADDB   $E1
AC6B: 0C C9          INC    $E1
AC6D: BD E8 80       JSR    $6008
AC70: 7E 59 03       JMP    $7B81
AC73: 39             RTS
AC74: 10 8E D7 E2    LDY    #$5560
AC78: CC 29 88       LDD    #$0100
AC7B: ED 8C          STD    ,Y
AC7D: 86 B8          LDA    #$30
AC7F: A7 8A 32       STA    $10,Y
AC82: FC D3 E6       LDD    $51C4
AC85: ED A6          STD    $4,Y
AC87: 96 C9          LDA    $E1
AC89: CE 24 49       LDU    #$ACC1
AC8C: A6 EE          LDA    A,U
AC8E: A7 A5          STA    $D,Y
AC90: 0D 71          TST    $53
AC92: 27 86          BEQ    $AC98
AC94: 0D 02          TST    $20
AC96: 26 93          BNE    $ACA9
AC98: B6 79 46       LDA    $51CE
AC9B: 84 D8          ANDA   #$F0
AC9D: A7 A6          STA    $E,Y
AC9F: 81 E2          CMPA   #$C0
ACA1: 26 97          BNE    $ACB8
ACA3: 86 62          LDA    #$40
ACA5: A7 AC          STA    $E,Y
ACA7: 20 27          BRA    $ACB8
ACA9: B6 D9 46       LDA    $51CE
ACAC: 84 D8          ANDA   #$F0
ACAE: A7 A6          STA    $E,Y
ACB0: 81 22          CMPA   #$00
ACB2: 26 86          BNE    $ACB8
ACB4: 86 A2          LDA    #$80
ACB6: A7 AC          STA    $E,Y
ACB8: A6 06          LDA    $E,Y
ACBA: 84 78          ANDA   #$F0
ACBC: 8A 27          ORA    #$0F
ACBE: A7 A6          STA    $E,Y
ACC0: 39             RTS
ACC1: 62 C3          XNC    $1,U
ACC3: C0 61          SUBB   #$43
ACC5: A6 06          LDA    ,X
ACC7: 81 2A          CMPA   #$02
ACC9: 26 A4          BNE    $ACF7
ACCB: 34 08          PSHS   Y
ACCD: 10 8E D9 E2    LDY    #$51C0
ACD1: E6 26          LDB    ,Y
ACD3: 5A             DECB
ACD4: 26 30          BNE    $ACE8
ACD6: A7 26          STA    ,Y
ACD8: A6 06          LDA    $E,Y
ACDA: 84 78          ANDA   #$F0
ACDC: 8A 2A          ORA    #$02
ACDE: A7 A6          STA    $E,Y
ACE0: EC 0A          LDD    $8,Y
ACE2: DE 17          LDU    $95
ACE4: DD B7          STD    $95
ACE6: EF AA          STU    $8,Y
ACE8: 96 BF          LDA    $97
ACEA: A7 20 3E       STA    $16,Y
ACED: 6F 20 9F       CLR    $17,Y
ACF0: 34 32          PSHS   X
ACF2: BD FE 08       JSR    $7C2A
ACF5: 35 32          PULS   X,Y,PC
ACF7: 39             RTS
ACF8: 96 E9          LDA    $C1
ACFA: 84 8B          ANDA   #$03
ACFC: 81 2A          CMPA   #$02
ACFE: 26 CA          BNE    $AD42
AD00: 8E 73 42       LDX    #$51C0
AD03: A6 21          LDA    $3,X
AD05: 81 83          CMPA   #$01
AD07: 27 11          BEQ    $AD42
AD09: 81 8B          CMPA   #$03
AD0B: 24 1D          BCC    $AD42
AD0D: 10 8E DE A2    LDY    #$5680
AD11: 6D 26          TST    ,Y
AD13: 27 0F          BEQ    $AD42
AD15: A6 2A 94       LDA    $16,Y
AD18: 31 80 91       LEAY   $19,Y
AD1B: E6 2C          LDB    $4,X
AD1D: CB 80          ADDB   #$08
AD1F: D7 42          STB    $60
AD21: E6 87          LDB    $5,X
AD23: E0 00          SUBB   $2,Y
AD25: CB 80          ADDB   #$02
AD27: C1 2E          CMPB   #$06
AD29: 22 9A          BHI    $AD3D
AD2B: D6 48          LDB    $60
AD2D: E0 2C          SUBB   ,Y
AD2F: CB 20          ADDB   #$02
AD31: D7 E3          STB    $61
AD33: E6 03          LDB    $1,Y
AD35: E0 26          SUBB   ,Y
AD37: CB 2C          ADDB   #$04
AD39: D1 E9          CMPB   $61
AD3B: 24 2E          BCC    $AD43
AD3D: 31 AB          LEAY   $3,Y
AD3F: 4A             DECA
AD40: 26 FD          BNE    $AD21
AD42: 39             RTS
AD43: 8D 03          BSR    $AD66
AD45: 10 BF D4 BF    STY    $5697
AD49: A6 AA          LDA    $2,Y
AD4B: A7 2D          STA    $5,X
AD4D: 86 8B          LDA    #$03
AD4F: A7 21          STA    $3,X
AD51: 96 E3          LDA    $61
AD53: 80 28          SUBA   #$0A
AD55: A7 0A 96       STA    $14,X
AD58: A6 27          LDA    $F,X
AD5A: 10 8E D4 A8    LDY    #$FC80
AD5E: BD E8 1F       JSR    $603D
AD61: 6F 88          CLR    $A,X
AD63: 7E 42 35       JMP    $6017
AD66: 34 B2          PSHS   Y,X
AD68: CC 2C 90       LDD    #$0418
AD6B: BD 48 20       JSR    $6008
AD6E: 35 38          PULS   X,Y,PC
AD70: 96 E3          LDA    $C1
AD72: 84 81          ANDA   #$03
AD74: 81 21          CMPA   #$03
AD76: 26 C2          BNE    $ADB8
AD78: 8E 79 48       LDX    #$51C0
AD7B: 6D AC          TST    ,X
AD7D: 27 B1          BEQ    $ADB8
AD7F: 10 8E 74 02    LDY    #$5680
AD83: 6D 86          TST    ,Y
AD85: 27 B3          BEQ    $ADB8
AD87: EC 2C          LDD    $4,X
AD89: 8B 80          ADDA   #$08
AD8B: CB 20          ADDB   #$08
AD8D: A0 20 90       SUBA   $18,Y
AD90: 97 42          STA    $60
AD92: A6 2A 3B       LDA    $19,Y
AD95: A0 2A 9A       SUBA   $18,Y
AD98: 91 48          CMPA   $60
AD9A: 25 94          BCS    $ADB8
AD9C: E0 80 93       SUBB   $1B,Y
AD9F: D7 42          STB    $60
ADA1: E6 2A 98       LDB    $1A,Y
ADA4: E0 8A 99       SUBB   $1B,Y
ADA7: D1 48          CMPB   $60
ADA9: 25 85          BCS    $ADB8
ADAB: BD 53 B9       JSR    $7B91
ADAE: 86 8A          LDA    #$02
ADB0: 97 27          STA    $05
ADB2: 0F 8A          CLR    $08
ADB4: 0F 29          CLR    $0B
ADB6: 0F 8C          CLR    $0E
ADB8: 39             RTS
ADB9: 8E DA 88       LDX    #$5200
ADBC: C6 2E          LDB    #$06
ADBE: D7 E8          STB    $60
ADC0: 8D 2A          BSR    $ADCA
ADC2: 30 0A 02       LEAX   $20,X
ADC5: 0A E2          DEC    $60
ADC7: 26 DF          BNE    $ADC0
ADC9: 39             RTS
ADCA: A6 8B          LDA    $3,X
ADCC: 81 29          CMPA   #$01
ADCE: 22 AB          BHI    $ADF3
ADD0: E6 AA 9E       LDB    $1C,X
ADD3: 58             ASLB
ADD4: 58             ASLB
ADD5: 10 8E D5 28    LDY    #$5700
ADD9: 31 2D          LEAY   B,Y
ADDB: E6 2C          LDB    $4,X
ADDD: CB 80          ADDB   #$08
ADDF: E0 03          SUBB   $1,Y
ADE1: D7 E3          STB    $61
ADE3: A6 00          LDA    $2,Y
ADE5: A0 A3          SUBA   $1,Y
ADE7: 91 49          CMPA   $61
ADE9: 24 80          BCC    $ADF3
ADEB: CC 2B 2B       LDD    #$0303
ADEE: A7 8B          STA    $3,X
ADF0: E7 AA 9D       STB    $1F,X
ADF3: 39             RTS
ADF4: BD 8C 90       JSR    $AE12
ADF7: BD 86 9A       JSR    $AEB2
ADFA: BD 26 D7       JSR    $AEFF
ADFD: BD 38 CE       JSR    $B046
AE00: BD 92 3C       JSR    $B0BE
AE03: BD 91 1C       JSR    $B33E
AE06: BD 31 A7       JSR    $B38F
AE09: BD 3C D9       JSR    $B451
AE0C: BD 9E 01       JSR    $B689
AE0F: 7E 97 94       JMP    $B5B6
AE12: 8E D0 E2       LDX    #$52C0
AE15: D6 CD          LDB    $4F
AE17: C4 2E          ANDB   #$06
AE19: 54             LSRB
AE1A: 10 8E 86 8E    LDY    #$AEA6
AE1E: E6 2D          LDB    B,Y
AE20: D7 43          STB    $61
AE22: 86 86          LDA    #$04
AE24: DD 42          STD    $60
AE26: 8D 8B          BSR    $AE31
AE28: 30 A0 98       LEAX   $10,X
AE2B: 0A 48          DEC    $60
AE2D: 26 7F          BNE    $AE26
AE2F: 20 3D          BRA    $AE50
AE31: 6D 06          TST    ,X
AE33: 27 38          BEQ    $AE4F
AE35: EE 80          LDU    $2,X
AE37: 33 E1 D4 88    LEAU   -$0400,U
AE3B: EC EC          LDD    ,U
AE3D: 84 78          ANDA   #$F0
AE3F: C4 D2          ANDB   #$F0
AE41: 9A E3          ORA    $61
AE43: DA 43          ORB    $61
AE45: ED 43          STD    ,U++
AE47: E6 EC          LDB    ,U
AE49: C4 78          ANDB   #$F0
AE4B: DA 49          ORB    $61
AE4D: E7 4C          STB    ,U
AE4F: 39             RTS
AE50: B6 66 ED       LDA    $446F
AE53: 0D 03          TST    $21
AE55: 27 86          BEQ    $AE5B
AE57: 0D 08          TST    $20
AE59: 26 8F          BNE    $AE62
AE5B: 1F A1          TFR    A,B
AE5D: BE CC E7       LDX    $446F
AE60: 31 A9          LEAY   D,X
AE62: 8E 2C B4       LDX    #$AE96
AE65: 96 43          LDA    $C1
AE67: 84 2B          ANDA   #$03
AE69: 48             ASLA
AE6A: 48             ASLA
AE6B: 30 AE          LEAX   A,X
AE6D: 10 AE 0C       LDY    ,X
AE70: AE 20          LDX    $2,X
AE72: 96 CD          LDA    $4F
AE74: 84 21          ANDA   #$03
AE76: A6 24          LDA    A,Y
AE78: 97 49          STA    $61
AE7A: 8D 85          BSR    $AE89
AE7C: 30 A0 95       LEAX   $1D,X
AE7F: 8D 2A          BSR    $AE89
AE81: 30 0A 9F       LEAX   $1D,X
AE84: 8D 21          BSR    $AE89
AE86: 30 0A 35       LEAX   $1D,X
AE89: 8D 8A          BSR    $AE8D
AE8B: 8D 28          BSR    $AE8D
AE8D: A6 0C          LDA    ,X
AE8F: 84 D2          ANDA   #$F0
AE91: 9A E3          ORA    $61
AE93: A7 A2          STA    ,X+
AE95: 39             RTS

AEAE: 83 84 2F       SUBD   #$0C0D
AEB1: 2C 8E          BGE    $AEBF
AEB3: D3 E2          ADDD   $C0
AEB5: A6 06          LDA    ,X
AEB7: 81 2A          CMPA   #$02
AEB9: 26 8C          BNE    $AEBF
AEBB: 8D 0C          BSR    $AEE1
AEBD: 20 89          BRA    $AEC0
AEBF: 39             RTS
AEC0: 96 6D          LDA    $4F
AEC2: 85 9D          BITA   #$1F
AEC4: 26 38          BNE    $AEE0
AEC6: 6A 0A 3E       DEC    $16,X
AEC9: 26 9D          BNE    $AEE0
AECB: 86 29          LDA    #$01
AECD: A7 0C          STA    ,X
AECF: E6 2C          LDB    $E,X
AED1: C4 72          ANDB   #$F0
AED3: E7 2C          STB    $E,X
AED5: EC 8A          LDD    $8,X
AED7: DE BD          LDU    $95
AED9: DD 1D          STD    $95
AEDB: EF 20          STU    $8,X
AEDD: BD F3 54       JSR    $7BDC
AEE0: 39             RTS
AEE1: A6 0A 94       LDA    $16,X
AEE4: 81 26          CMPA   #$04
AEE6: 22 94          BHI    $AEFE
AEE8: 96 67          LDA    $4F
AEEA: 85 8F          BITA   #$07
AEEC: 26 38          BNE    $AEFE
AEEE: E6 86          LDB    $E,X
AEF0: C4 D2          ANDB   #$F0
AEF2: 85 8A          BITA   #$08
AEF4: 26 26          BNE    $AEFA
AEF6: CA 80          ORB    #$02
AEF8: 20 2A          BRA    $AEFC
AEFA: CA 88          ORB    #$00
AEFC: E7 26          STB    $E,X
AEFE: 39             RTS
AEFF: 0D A2          TST    $80
AF01: 10 26 83 33    LBNE   $B016
AF05: 8E D3 42       LDX    #$51C0
AF08: 6D 2B          TST    $3,X
AF0A: 10 26 29 2F    LBNE   $B015
AF0E: 10 8E 75 22    LDY    #$5700
AF12: 6D 26          TST    ,Y
AF14: 10 27 82 7F    LBEQ   $B015
AF18: A6 2D          LDA    $5,X
AF1A: A1 AB          CMPA   $3,Y
AF1C: 26 3C          BNE    $AF32
AF1E: E6 8C          LDB    $4,X
AF20: CB 2A          ADDB   #$08
AF22: E0 A3          SUBB   $1,Y
AF24: CB 24          ADDB   #$06
AF26: D7 E2          STB    $60
AF28: E6 0A          LDB    $2,Y
AF2A: CB 84          ADDB   #$0C
AF2C: E0 09          SUBB   $1,Y
AF2E: D1 E8          CMPB   $60
AF30: 24 2B          BCC    $AF3B
AF32: 31 A6          LEAY   $4,Y
AF34: 10 8C D5 DD    CMPY   #$575F
AF38: 25 F0          BCS    $AF12
AF3A: 39             RTS
AF3B: E6 27          LDB    $F,X
AF3D: C5 89          BITB   #$01
AF3F: 10 26 22 50    LBNE   $B015
AF43: 96 19          LDA    $3B
AF45: 43             COMA
AF46: 94 B8          ANDA   $3A
AF48: 85 38          BITA   #$10
AF4A: 10 27 28 EF    LBEQ   $B015
AF4E: 86 89          LDA    #$01
AF50: 97 A2          STA    $80
AF52: 34 A2          PSHS   Y
AF54: 10 8E 7E 70    LDY    #$FCF2
AF58: A6 27          LDA    $F,X
AF5A: BD E8 15       JSR    $603D
AF5D: 6F 82          CLR    $A,X
AF5F: BD 42 35       JSR    $6017
AF62: 35 A2          PULS   Y
AF64: BD 59 DF       JSR    $7B5D
AF67: E6 27          LDB    $F,X
AF69: D7 E8          STB    $60
AF6B: EC 2C          LDD    $4,X
AF6D: CB 8C          ADDB   #$04
AF6F: 1F 21          TFR    D,U
AF71: 10 8E D6 02    LDY    #$5420
AF75: EF A6          STU    $4,Y
AF77: 6F 09          CLR    $1,Y
AF79: C6 89          LDB    #$01
AF7B: E7 8C          STB    ,Y
AF7D: E7 AB          STB    $3,Y
AF7F: C6 DD          LDB    #$FF
AF81: E7 AF          STB    $D,Y
AF83: 6F 08          CLR    $A,Y
AF85: D6 E2          LDB    $60
AF87: E7 07          STB    $F,Y
AF89: 31 20 A8       LEAY   $20,Y
AF8C: 10 8C DD D7    CMPY   #$555F
AF90: 25 C1          BCS    $AF75
AF92: 1F B2          TFR    U,D
AF94: CB 26          ADDB   #$04
AF96: 0D E2          TST    $60
AF98: 26 2C          BNE    $AF9E
AF9A: 8B 98          ADDA   #$10
AF9C: 20 2A          BRA    $AFA0
AF9E: 80 98          SUBA   #$10
AFA0: 8E 76 82       LDX    #$5400
AFA3: ED 26          STD    $4,X
AFA5: D6 E2          LDB    $60
AFA7: E7 27          STB    $F,X
AFA9: 10 8E 0E 99    LDY    #$86B1
AFAD: 96 E8          LDA    $60
AFAF: BD 42 1F       JSR    $603D
AFB2: 6F 88          CLR    $A,X
AFB4: BD 42 95       JSR    $6017
AFB7: 10 8E CA 96    LDY    #$E21E
AFBB: 0D 48          TST    $60
AFBD: 26 8C          BNE    $AFC3
AFBF: 10 8E C2 9C    LDY    #$E01E
AFC3: 10 AF AA 90    STY    $12,X
AFC7: 31 80 CA       LEAY   -$1E,Y
AFCA: 10 AF A0 1A    STY    $32,X
AFCE: 10 AF AA 70    STY    $52,X
AFD2: 10 AF AA 50    STY    $72,X
AFD6: 10 AF A1 28 1A STY    $0092,X
AFDB: 10 AF A1 88 3A STY    $00B2,X
AFE0: 10 AF 0B 82 F0 STY    $00D2,X
AFE5: 10 AF 0B 28 DA STY    $00F2,X
AFEA: 10 AF A1 29 9A STY    $0112,X
AFEF: 10 AF AB 83 B0 STY    $0132,X
AFF4: 10 AF 0B 83 7A STY    $0152,X
AFF9: 10 AF 01 29 5A STY    $0172,X
AFFE: 6F 82          CLR    $A,X
B000: 86 23          LDA    #$01
B002: A7 06          STA    ,X
B004: 6F 23          CLR    $1,X
B006: 6F 81          CLR    $3,X
B008: 6F A0 97       CLR    $1F,X
B00B: B7 7D 49       STA    $5561
B00E: 4F             CLRA
B00F: 5F             CLRB
B010: FD 77 E6       STD    $5564
B013: 0F C0          CLR    $E2
B015: 39             RTS
B016: 96 B8          LDA    $3A
B018: 85 2B          BITA   #$03
B01A: 27 71          BEQ    $B015
B01C: 85 2C          BITA   #$04
B01E: 26 7D          BNE    $B015
B020: 85 2A          BITA   #$08
B022: 26 73          BNE    $B015
B024: 0F A2          CLR    $80
B026: C6 83          LDB    #$01
B028: 8E 7C 88       LDX    #$5400
B02B: 86 23          LDA    #$0B
B02D: E7 89          STB    $1,X
B02F: 6F 26          CLR    $4,X
B031: 6F 87          CLR    $5,X
B033: 6F 21          CLR    $3,X
B035: 6F 0A 9D       CLR    $1F,X
B038: 30 A0 A8       LEAX   $20,X
B03B: 4A             DECA
B03C: 26 C7          BNE    $B02D
B03E: CC 77 DD       LDD    #$FFFF
B041: DD 1E          STD    $9C
B043: DD BC          STD    $9E
B045: 39             RTS
B046: 96 87          LDA    $05
B048: 81 2A          CMPA   #$02
B04A: 27 82          BEQ    $B056
B04C: 8E 79 68       LDX    #$51E0
B04F: A6 AA C1       LDA    -$1D,X
B052: 81 80          CMPA   #$02
B054: 26 23          BNE    $B057
B056: 39             RTS
B057: 6D AC          TST    ,X
B059: 26 C7          BNE    $B0AA
B05B: 96 13          LDA    $3B
B05D: 43             COMA
B05E: 94 B2          ANDA   $3A
B060: 85 02          BITA   #$20
B062: 27 DB          BEQ    $B0BD
B064: EC AA 66       LDD    -$1C,X
B067: CB 2A          ADDB   #$02
B069: E7 8D          STB    $5,X
B06B: E6 A0 C7       LDB    -$11,X
B06E: 27 86          BEQ    $B07E
B070: C1 20          CMPB   #$02
B072: 27 8D          BEQ    $B083
B074: D6 18          LDB    $3A
B076: C5 83          BITB   #$01
B078: 26 21          BNE    $B083
B07A: C5 8A          BITB   #$02
B07C: 27 17          BEQ    $B0BD
B07E: 8B 83          ADDA   #$0B
B080: 5F             CLRB
B081: 20 86          BRA    $B087
B083: 80 29          SUBA   #$0B
B085: C6 80          LDB    #$02
B087: A7 2C          STA    $4,X
B089: D7 E8          STB    $60
B08B: 10 8E AF CC    LDY    #$8744
B08F: 96 42          LDA    $60
B091: BD E2 BF       JSR    $603D
B094: 6F 28          CLR    $A,X
B096: BD E2 3F       JSR    $6017
B099: C6 87          LDB    #$0F
B09B: E7 A0 38       STB    $10,X
B09E: 86 89          LDA    #$01
B0A0: A7 A6          STA    ,X
B0A2: 6F 83          CLR    $1,X
B0A4: BD 59 E7       JSR    $7B65
B0A7: 7E 48 3F       JMP    $6017
B0AA: 6D 00 38       TST    $10,X
B0AD: 27 86          BEQ    $B0BD
B0AF: 6A AA 32       DEC    $10,X
B0B2: 26 8B          BNE    $B0BD
B0B4: 4F             CLRA
B0B5: A7 86          STA    $4,X
B0B7: A7 2D          STA    $5,X
B0B9: C6 89          LDB    #$01
B0BB: E7 29          STB    $1,X
B0BD: 39             RTS
B0BE: 10 8E 74 22    LDY    #$5600
B0C2: 6D 26          TST    ,Y
B0C4: 27 51          BEQ    $B139
B0C6: 6D 2A 3C       TST    $14,Y
B0C9: 27 E6          BEQ    $B139
B0CB: A6 0B          LDA    $3,Y
B0CD: 81 89          CMPA   #$01
B0CF: 27 4A          BEQ    $B139
B0D1: A6 A6          LDA    $4,Y
B0D3: 80 32          SUBA   #$10
B0D5: 81 62          CMPA   #$E0
B0D7: 22 48          BHI    $B139
B0D9: 96 4A          LDA    $C2
B0DB: 81 2D          CMPA   #$05
B0DD: 23 D2          BLS    $B139
B0DF: 81 3A          CMPA   #$18
B0E1: 22 8C          BHI    $B0F1
B0E3: 0D AB          TST    $89
B0E5: 27 88          BEQ    $B0F1
B0E7: 96 67          LDA    $4F
B0E9: 85 97          BITA   #$1F
B0EB: 26 64          BNE    $B139
B0ED: 0A 01          DEC    $89
B0EF: 26 6A          BNE    $B139
B0F1: 8E 33 B8       LDX    #$B13A
B0F4: D6 E3          LDB    $C1
B0F6: C5 7A          BITB   #$F8
B0F8: 27 2A          BEQ    $B0FC
B0FA: CB 8C          ADDB   #$04
B0FC: C4 2F          ANDB   #$07
B0FE: 58             ASLB
B0FF: AE A7          LDX    B,X
B101: E6 2A 95       LDB    $17,Y
B104: C4 25          ANDB   #$07
B106: 30 07          LEAX   B,X
B108: 58             ASLB
B109: 30 0D          LEAX   B,X
B10B: 6D AC          TST    ,X
B10D: 26 8D          BNE    $B114
B10F: AE 23          LDX    $1,X
B111: 6F 2A 95       CLR    $17,Y
B114: EC 06          LDD    $4,Y
B116: A0 83          SUBA   $1,X
B118: 8B 2A          ADDA   #$02
B11A: 81 8C          CMPA   #$04
B11C: 22 33          BHI    $B139
B11E: 96 4A          LDA    $C2
B120: 81 38          CMPA   #$1A
B122: 24 8A          BCC    $B12C
B124: E0 20          SUBB   $2,X
B126: CB 80          ADDB   #$02
B128: C1 2C          CMPB   #$04
B12A: 22 85          BHI    $B139
B12C: 96 A0          LDA    $88
B12E: 97 01          STA    $89
B130: 6C 8A 95       INC    $17,Y
B133: AE 8A 37       LDX    $15,Y
B136: 7E 33 8C       JMP    $B1A4
B139: 39             RTS
B13A: 39             RTS
B13B: C2 99          SBCB   #$B1
B13D: 4A             DECA
B13E: 39             RTS
B13F: F2 93 B0       SBCB   $B192
B142: 33 10          LEAU   Illegal Postbyte
B144: 93 40          SUBD   $62
B146: 33 F8          LEAU   -$6,S
B148: 99 BA          ADCA   $92
B14A: 89 08          ADCA   #$80
B14C: F8 29 18       EORB   $0190
B14F: 58             ASLB
B150: 23 5E          BLS    $B1CE
B152: 52             XNCB
B153: 83 BA F2       SUBD   #$98D0
B156: 83 F2 F8       SUBD   #$70D0
B159: 29 FC          BVS    $B1CF
B15B: 58             ASLB
B15C: 29 44          BVS    $B1CA
B15E: 58             ASLB
B15F: 89 AA          ADCA   #$88
B161: F2 83 C2       SBCB   $0140
B164: F2 23 D7       SBCB   $0155
B167: 52             XNCB
B168: 29 E8          BVS    $B12A
B16A: 58             ASLB
B16B: 89 6C          ADCA   #$44
B16D: F8 89 F8       EORB   $0170
B170: F2 23 02       SBCB   $0180
B173: 52             XNCB
B174: 23 82          BLS    $B116
B176: 52             XNCB
B177: 83 98 F8       SUBD   #$B0D0
B17A: 89 CE          ADCA   #$46
B17C: F8 29 D0       EORB   $0158
B17F: 58             ASLB
B180: 23 84          BLS    $B128
B182: 52             XNCB
B183: 83 9A F2       SUBD   #$B8D0
B186: 83 F2 F8       SUBD   #$70D0
B189: 29 08          BVS    $B10B
B18B: 58             ASLB
B18C: 29 48          BVS    $B1EE
B18E: 58             ASLB
B18F: 89 1A          ADCA   #$38
B191: F2 83 D7       SBCB   $0155
B194: F2 23 0C       SBCB   $018E
B197: 52             XNCB
B198: 29 8D          BVS    $B13F
B19A: 58             ASLB
B19B: 89 58          ADCA   #$70
B19D: F8 89 E8       EORB   $0160
B1A0: F2 22 33       SBCB   >$00B1
B1A3: C8 CC          EORB   #$EE
B1A5: 20 C2          BRA    $B1E7
B1A7: A7 0B          STA    $3,Y
B1A9: E7 20 98       STB    $10,Y
B1AC: 8D 4D          BSR    $B213
B1AE: C4 87          ANDB   #$0F
B1B0: D7 42          STB    $60
B1B2: 58             ASLB
B1B3: 58             ASLB
B1B4: 58             ASLB
B1B5: DB E2          ADDB   $60
B1B7: E7 A0 37       STB    $1F,X
B1BA: 96 CA          LDA    $42
B1BC: 84 29          ANDA   #$01
B1BE: A7 00 3C       STA    $1E,X
B1C1: CE 30 9C       LDU    #$B21E
B1C4: 96 E3          LDA    $C1
B1C6: 84 81          ANDA   #$03
B1C8: 81 29          CMPA   #$01
B1CA: 26 8B          BNE    $B1CF
B1CC: CE 9A 26       LDU    #$B2AE
B1CF: 4F             CLRA
B1D0: 33 E9          LEAU   D,U
B1D2: 0D 43          TST    $C1
B1D4: 26 2E          BNE    $B1E2
B1D6: 4F             CLRA
B1D7: 5F             CLRB
B1D8: ED A0 9C       STD    $14,X
B1DB: ED A0 3E       STD    $16,X
B1DE: 33 CC          LEAU   $4,U
B1E0: 20 28          BRA    $B1EC
B1E2: EC 43          LDD    ,U++
B1E4: ED AA 96       STD    $14,X
B1E7: EC E9          LDD    ,U++
B1E9: ED 00 9E       STD    $16,X
B1EC: EC E9          LDD    ,U++
B1EE: ED 00 3A       STD    $18,X
B1F1: EC 43          LDD    ,U++
B1F3: ED AA 38       STD    $1A,X
B1F6: E6 46          LDB    ,U
B1F8: E7 27          STB    $F,X
B1FA: 96 A7          LDA    $2F
B1FC: 84 50          ANDA   #$78
B1FE: 81 E0          CMPA   #$68
B200: 25 2F          BCS    $B20F
B202: 6F 8D          CLR    $F,X
B204: B6 73 46       LDA    $51C4
B207: A1 2C          CMPA   $4,X
B209: 22 8C          BHI    $B20F
B20B: 86 2A          LDA    #$02
B20D: A7 87          STA    $F,X
B20F: 7E 59 5F       JMP    $7B7D
B212: 39             RTS
B213: CE DC 82       LDU    #$FEA0
B216: 0C C3          INC    $41
B218: 4F             CLRA
B219: D6 C9          LDB    $41
B21B: E6 E3          LDB    D,U
B21D: 39             RTS
B21E: 77 88 23       ASR    >$0001
B221: 22 7D          BHI    $B222
B223: 82 3E          SBCA   #$1C
B225: 22 82          BHI    $B227
B227: 7D 28 2A       TST    >$0002
B22A: 88 77          EORA   #$FF
B22C: 28 35          BVC    $B24B
B22E: 88 8A          EORA   #$02
B230: DD 22          STD    $00
B232: 81 82          CMPA   #$00
B234: DD 22          STD    $00
B236: 9C 82          CMPX   $00
B238: 2A D7          BPL    $B239
B23A: 88 8C          EORA   #$04
B23C: 28 D7          BVC    $B23D
B23E: 88 97          EORA   #$1F
B240: 22 22          BHI    $B242
B242: 7D 82 27       TST    >$0005
B245: 22 7D          BHI    $B246
B247: 82 08          SBCA   #$20
B249: 28 8A          BVC    $B24D
B24B: 77 28 2E       ASR    >$0006
B24E: 88 77          EORA   #$FF
B250: 22 03          BHI    $B273
B252: 82 82          SBCA   #$00
B254: DD 22          STD    $00
B256: 85 82          BITA   #$00
B258: D7 28          STB    $00
B25A: AA 88          ORA    $0,X
B25C: 28 D7          BVC    $B25D
B25E: 88 80          EORA   #$08
B260: 22 DD          BHI    $B261
B262: 82 A1          SBCA   #$23
B264: 22 22          BHI    $B266
B266: 7D 82 21       TST    >$0009
B269: 28 77          BVC    $B26A
B26B: 88 0C          EORA   #$24
B26D: 28 8A          BVC    $B271
B26F: 77 22 23       ASR    >$0001
B272: 82 7D          SBCA   #$FF
B274: 22 07          BHI    $B29B
B276: 82 80          SBCA   #$02
B278: D7 28          STB    $00
B27A: 89 88          ADCA   #$00
B27C: D7 28          STB    $00
B27E: AE 88          LDX    $0,X
B280: 22 DD          BHI    $B281
B282: 82 83          SBCA   #$01
B284: 22 DD          BHI    $B285
B286: 82 A5          SBCA   #$27
B288: 28 28          BVC    $B28A
B28A: 77 88 2C       ASR    >$0004
B28D: 28 77          BVC    $B28E
B28F: 88 0A          EORA   #$28
B291: 22 80          BHI    $B295
B293: 7D 22 32       TST    >$0010
B296: 82 7D          SBCA   #$FF
B298: 28 0A          BVC    $B2BC
B29A: 88 8A          EORA   #$02
B29C: D7 28          STB    $00
B29E: 9C 88          CMPX   $00
B2A0: DD 22          STD    $00
B2A2: A6 82          LDA    $0,X
B2A4: 20 DD          BRA    $B2A5
B2A6: 82 9A          SBCA   #$18
B2A8: 28 D7          BVC    $B2A9
B2AA: 88 A8          EORA   #$20
B2AC: 28 28          BVC    $B2AE
B2AE: 77 88 2A       ASR    >$0008
B2B1: 22 7D          BHI    $B2B2
B2B3: 82 2A          SBCA   #$08
B2B5: 22 82          BHI    $B2B7
B2B7: 7D 28 20       TST    >$0008
B2BA: 88 77          EORA   #$FF
B2BC: 28 21          BVC    $B2C7
B2BE: 88 8A          EORA   #$02
B2C0: DD 22          STD    $00
B2C2: 8B 82          ADDA   #$00
B2C4: DD 22          STD    $00
B2C6: 88 82          EORA   #$00
B2C8: 2A D7          BPL    $B2C9
B2CA: 88 81          EORA   #$09
B2CC: 28 D7          BVC    $B2CD
B2CE: 88 82          EORA   #$0A
B2D0: 22 22          BHI    $B2D2
B2D2: 7D 82 2A       TST    >$0008
B2D5: 22 7D          BHI    $B2D6
B2D7: 82 24          SBCA   #$0C
B2D9: 28 8A          BVC    $B2DD
B2DB: 77 28 21       ASR    >$0009
B2DE: 88 77          EORA   #$FF
B2E0: 22 2E          BHI    $B2EE
B2E2: 02 82          XNC    $00
B2E4: DD 22          STD    $00
B2E6: 88 82          EORA   #$00
B2E8: D7 28          STB    $00
B2EA: 84 40          ANDA   #$C8
B2EC: 28 D7          BVC    $B2ED
B2EE: 88 83          EORA   #$0B
B2F0: 22 DD          BHI    $B2F1
B2F2: 82 88          SBCA   #$0A
B2F4: 22 22          BHI    $B2F6
B2F6: 7D 82 24       TST    >$000C
B2F9: 28 77          BVC    $B2FA
B2FB: 88 24          EORA   #$0C
B2FD: A8 8A          EORA   $2,X
B2FF: 77 22 2D       ASR    >$000F
B302: 82 7D          SBCA   #$FF
B304: 22 28          BHI    $B310
B306: E2 80          SBCB   $2,X
B308: D7 28          STB    $00
B30A: 98 88          EORA   $00
B30C: D7 28          STB    $00
B30E: 84 C8          ANDA   #$40
B310: 22 DD          BHI    $B311
B312: 82 90          SBCA   #$12
B314: 22 DD          BHI    $B315
B316: 82 8E          SBCA   #$0C
B318: 08 28          ASL    $00
B31A: 77 88 39       ASR    >$0011
B31D: 28 77          BVC    $B31E
B31F: 88 2E          EORA   #$0C
B321: A2 80          SBCA   $2,X
B323: 7D 22 31       TST    >$0013
B326: 82 7D          SBCA   #$FF
B328: 28 25          BVC    $B337
B32A: 08 8A          ASL    $02
B32C: D7 28          STB    $00
B32E: 82 88          SBCA   #$00
B330: DD 22          STD    $00
B332: 8E B6 20       LDX    #$3402
B335: DD 82          STD    $00
B337: 88 28          EORA   #$00
B339: D7 88          STB    $00
B33B: 85 08          BITA   #$20
B33D: 28 0A          BVC    $B2C1
B33F: 03 26          COM    $04
B341: 6E 96          JMP    -$C,X
B343: 08 97          ASL    $B5
B345: A9 96          ADCA   -$C,X
B347: 19             DAA
B348: 8B B8          ADDA   #$90
B34A: 19             DAA
B34B: 97 B3          STA    $9B
B34D: 96 12          LDA    $9A
B34F: 89 BB          ADCA   #$99
B351: 19             DAA
B352: 97 18          STA    $9A
B354: 96 BB          LDA    $99
B356: 89 1B          ADCA   #$99
B358: 19             DAA
B359: 97 11          STA    $99
B35B: 26 39          BNE    $B36E
B35D: DC 12          LDD    $9A
B35F: 10 83 2A 82    CMPD   #$0800
B363: 22 2B          BHI    $B36E
B365: 25 81          BCS    $B36A
B367: BD 53 AD       JSR    $7B85
B36A: C6 96          LDB    #$1E
B36C: 20 2A          BRA    $B370
B36E: C6 90          LDB    #$18
B370: 86 2C          LDA    #$0E
B372: BD E2 2A       JSR    $6008
B375: 0D 1B          TST    $99
B377: 26 3D          BNE    $B38E
B379: DC 12          LDD    $9A
B37B: 26 39          BNE    $B38E
B37D: 86 8A          LDA    #$02
B37F: 97 27          STA    $05
B381: 4F             CLRA
B382: 97 8A          STA    $08
B384: 97 29          STA    $0B
B386: 97 8C          STA    $0E
B388: BD 54 A8       JSR    $7C20
B38B: 7E 53 90       JMP    $7BB8
B38E: 39             RTS
B38F: 8E 74 22       LDX    #$5600
B392: 6D 06          TST    ,X
B394: 27 26          BEQ    $B39A
B396: 7E 31 92       JMP    $B3BA
B399: 39             RTS
B39A: 6D 89          TST    $1,X
B39C: 26 D3          BNE    $B399
B39E: CC 88 F2       LDD    #$00D0
B3A1: ED 86          STD    $4,X
B3A3: 6F 21          CLR    $3,X
B3A5: B6 D3 4D       LDA    $51CF
B3A8: 84 2A          ANDA   #$02
B3AA: A7 87          STA    $F,X
B3AC: 10 8E 2C 2A    LDY    #$A4A2
B3B0: BD 42 BF       JSR    $603D
B3B3: 6F 28          CLR    $A,X
B3B5: 86 83          LDA    #$01
B3B7: A7 AC          STA    ,X
B3B9: 39             RTS
B3BA: A6 8C          LDA    $4,X
B3BC: 81 D8          CMPA   #$F0
B3BE: 23 71          BLS    $B3B9
B3C0: D6 E3          LDB    $C1
B3C2: C1 86          CMPB   #$04
B3C4: 25 3D          BCS    $B3E5
B3C6: C4 81          ANDB   #$03
B3C8: C1 29          CMPB   #$01
B3CA: 27 91          BEQ    $B3E5
B3CC: 86 37          LDA    #$1F
B3CE: 90 4A          SUBA   $C2
B3D0: 48             ASLA
B3D1: 48             ASLA
B3D2: 48             ASLA
B3D3: B1 73 E7       CMPA   $51C5
B3D6: 22 8F          BHI    $B3E5
B3D8: F6 79 4D       LDB    $51C5
B3DB: E7 2D          STB    $5,X
B3DD: C1 48          CMPB   #$C0
B3DF: 24 26          BCC    $B3E5
B3E1: CB A2          ADDB   #$20
B3E3: E7 27          STB    $5,X
B3E5: 6D 0A 96       TST    $14,X
B3E8: 27 24          BEQ    $B3F6
B3EA: B6 D9 ED       LDA    $51C5
B3ED: A1 8D          CMPA   $5,X
B3EF: 23 7D          BLS    $B450
B3F1: 86 52          LDA    #$D0
B3F3: A7 27          STA    $5,X
B3F5: 39             RTS
B3F6: 86 81          LDA    #$03
B3F8: 10 8E DB C8    LDY    #$5340
B3FC: 6D 8C          TST    ,Y
B3FE: 27 8F          BEQ    $B407
B400: 31 8A A2       LEAY   $20,Y
B403: 4A             DECA
B404: 26 D4          BNE    $B3FC
B406: 39             RTS
B407: 10 AF A0 9D    STY    $15,X
B40B: 86 29          LDA    #$01
B40D: A7 00 9C       STA    $14,X
B410: A7 86          STA    ,Y
B412: 86 87          LDA    #$05
B414: A7 01          STA    $3,Y
B416: 34 B2          PSHS   Y,X
B418: 30 8C          LEAX   ,Y
B41A: 10 8E BE 0B    LDY    #$9623
B41E: A6 87          LDA    $F,X
B420: BD 42 BF       JSR    $603D
B423: BD 42 35       JSR    $6017
B426: 35 B2          PULS   X,Y
B428: E6 2D          LDB    $5,X
B42A: 81 38          CMPA   #$B0
B42C: 25 26          BCS    $B43C
B42E: 86 88          LDA    #$00
B430: A7 2D          STA    $F,X
B432: 10 8E 86 80    LDY    #$A4A2
B436: BD E2 15       JSR    $603D
B439: 6F 82          CLR    $A,X
B43B: 39             RTS
B43C: B6 79 47       LDA    $51CF
B43F: 85 23          BITA   #$01
B441: 26 8F          BNE    $B450
B443: 88 20          EORA   #$02
B445: A7 8D          STA    $F,X
B447: 10 8E 8C 2A    LDY    #$A4A2
B44B: BD 48 15       JSR    $603D
B44E: 6F 82          CLR    $A,X
B450: 39             RTS
B451: 96 CD          LDA    $4F
B453: 84 3D          ANDA   #$1F
B455: 26 AD          BNE    $B486
B457: 96 E9          LDA    $C1
B459: 84 8B          ANDA   #$03
B45B: 81 2A          CMPA   #$02
B45D: 26 AF          BNE    $B486
B45F: 81 21          CMPA   #$03
B461: 27 A6          BEQ    $B487
B463: 8E 74 A2       LDX    #$5680
B466: 0C 4C          INC    $CE
B468: 96 E6          LDA    $CE
B46A: A1 84          CMPA   $C,X
B46C: 25 20          BCS    $B476
B46E: 0F 46          CLR    $CE
B470: A6 2C          LDA    $E,X
B472: 88 80          EORA   #$02
B474: A7 2C          STA    $E,X
B476: 0C 4D          INC    $CF
B478: 96 E7          LDA    $CF
B47A: A1 85          CMPA   $D,X
B47C: 25 20          BCS    $B486
B47E: 0F 47          CLR    $CF
B480: A6 2D          LDA    $F,X
B482: 88 80          EORA   #$02
B484: A7 2D          STA    $F,X
B486: 39             RTS
B487: 8E 7E A8       LDX    #$5680
B48A: 0C 46          INC    $CE
B48C: 96 E6          LDA    $CE
B48E: A1 84          CMPA   $C,X
B490: 25 D6          BCS    $B486
B492: 0F 4C          CLR    $CE
B494: D6 E3          LDB    $C1
B496: C4 8E          ANDB   #$0C
B498: 54             LSRB
B499: 10 8E 3C 86    LDY    #$B4AE
B49D: 10 AE 2D       LDY    B,Y
B4A0: A6 2F          LDA    $D,X
B4A2: 6C 8F          INC    $D,X
B4A4: 84 3D          ANDA   #$1F
B4A6: 48             ASLA
B4A7: EC 8E          LDD    A,Y
B4A9: A7 87          STA    $F,X
B4AB: E7 24          STB    $C,X
B4AD: 39             RTS
B4AE: 3C 3E          CWAI   #$B6
B4B0: 96 D4          LDA    $F6
B4B2: 37 B4          PULU   D,X,Y
B4B4: 97 54          STA    $76
B4B6: 81 87          CMPA   #$05
B4B8: 29 2E          BVS    $B4C0
B4BA: 88 8A          EORA   #$02
B4BC: 29 22          BVS    $B4C8
B4BE: 8B 8A          ADDA   #$02
B4C0: 23 23          BLS    $B4C3
B4C2: 81 8E          CMPA   #$0C
B4C4: 22 21          BHI    $B4C9
B4C6: 81 80          CMPA   #$02
B4C8: 29 29          BVS    $B4CB
B4CA: 8B 8B          ADDA   #$03
B4CC: 29 2C          BVS    $B4D2
B4CE: 89 89          ADCA   #$01
B4D0: 22 23          BHI    $B4D3
B4D2: 81 8D          CMPA   #$0F
B4D4: 22 23          BHI    $B4D7
B4D6: 81 A2          CMPA   #$20
B4D8: 29 38          BVS    $B4EA
B4DA: 88 8D          EORA   #$05
B4DC: 29 22          BVS    $B4E8
B4DE: 8A 8A          ORA    #$02
B4E0: 23 02          BLS    $B502
B4E2: 81 AE          CMPA   #$2C
B4E4: 23 2A          BLS    $B4EE
B4E6: 81 80          CMPA   #$02
B4E8: 29 29          BVS    $B4EB
B4EA: 89 8B          ADCA   #$03
B4EC: 2B 2C          BMI    $B4F2
B4EE: 89 89          ADCA   #$01
B4F0: 21 23          BRN    $B4F3
B4F2: 81 8D          CMPA   #$0F
B4F4: 22 23          BHI    $B4F7
B4F6: 81 87          CMPA   #$05
B4F8: 29 2E          BVS    $B500
B4FA: 88 8A          EORA   #$02
B4FC: 29 22          BVS    $B508
B4FE: 8B 8A          ADDA   #$02
B500: 23 23          BLS    $B503
B502: 81 8E          CMPA   #$0C
B504: 22 21          BHI    $B509
B506: 81 80          CMPA   #$02
B508: 29 29          BVS    $B50B
B50A: 8B 8B          ADDA   #$03
B50C: 29 2C          BVS    $B512
B50E: 89 89          ADCA   #$01
B510: 22 23          BHI    $B513
B512: 81 8D          CMPA   #$0F
B514: 22 23          BHI    $B517
B516: 81 87          CMPA   #$05
B518: 29 2E          BVS    $B520
B51A: 88 8A          EORA   #$02
B51C: 29 22          BVS    $B528
B51E: 8B 8A          ADDA   #$02
B520: 23 23          BLS    $B523
B522: 81 8E          CMPA   #$0C
B524: 22 21          BHI    $B529
B526: 81 80          CMPA   #$02
B528: 29 29          BVS    $B52B
B52A: 8B 8B          ADDA   #$03
B52C: 29 2C          BVS    $B532
B52E: 89 89          ADCA   #$01
B530: 22 23          BHI    $B533
B532: 81 8D          CMPA   #$0F
B534: 22 23          BHI    $B537
B536: 81 87          CMPA   #$05
B538: 29 2E          BVS    $B540
B53A: 88 8A          EORA   #$02
B53C: 29 22          BVS    $B548
B53E: 8B 8A          ADDA   #$02
B540: 23 23          BLS    $B543
B542: 81 8E          CMPA   #$0C
B544: 22 21          BHI    $B549
B546: 81 80          CMPA   #$02
B548: 29 29          BVS    $B54B
B54A: 8B 8B          ADDA   #$03
B54C: 29 2C          BVS    $B552
B54E: 89 89          ADCA   #$01
B550: 22 23          BHI    $B553
B552: 81 8D          CMPA   #$0F
B554: 22 23          BHI    $B557
B556: 81 87          CMPA   #$05
B558: 29 2E          BVS    $B560
B55A: 88 8A          EORA   #$02
B55C: 29 22          BVS    $B568
B55E: 8B 8A          ADDA   #$02
B560: 23 23          BLS    $B563
B562: 81 8E          CMPA   #$0C
B564: 22 21          BHI    $B569
B566: 81 80          CMPA   #$02
B568: 29 29          BVS    $B56B
B56A: 8B 8B          ADDA   #$03
B56C: 29 2C          BVS    $B572
B56E: 89 89          ADCA   #$01
B570: 22 23          BHI    $B573
B572: 81 8D          CMPA   #$0F
B574: 22 23          BHI    $B577
B576: 81 87          CMPA   #$05
B578: 29 2E          BVS    $B580
B57A: 88 8A          EORA   #$02
B57C: 29 22          BVS    $B588
B57E: 8B 8A          ADDA   #$02
B580: 23 23          BLS    $B583
B582: 81 8E          CMPA   #$0C
B584: 22 21          BHI    $B589
B586: 81 80          CMPA   #$02
B588: 29 29          BVS    $B58B
B58A: 8B 8B          ADDA   #$03
B58C: 29 2C          BVS    $B592
B58E: 89 89          ADCA   #$01
B590: 22 23          BHI    $B593
B592: 81 8D          CMPA   #$0F
B594: 22 23          BHI    $B597
B596: 81 87          CMPA   #$05
B598: 29 2E          BVS    $B5A0
B59A: 88 8A          EORA   #$02
B59C: 29 22          BVS    $B5A8
B59E: 8B 8A          ADDA   #$02
B5A0: 23 23          BLS    $B5A3
B5A2: 81 8E          CMPA   #$0C
B5A4: 22 21          BHI    $B5A9
B5A6: 81 80          CMPA   #$02
B5A8: 29 29          BVS    $B5AB
B5AA: 8B 8B          ADDA   #$03
B5AC: 29 2C          BVS    $B5B2
B5AE: 89 89          ADCA   #$01
B5B0: 22 23          BHI    $B5B3
B5B2: 81 8D          CMPA   #$0F
B5B4: 22 23          BHI    $B5B7
B5B6: 8D 94          BSR    $B5CE
B5B8: 96 48          LDA    $60
B5BA: 8E 3D EF       LDX    #$B5C7
B5BD: A6 0E          LDA    A,X
B5BF: 95 6D          BITA   $4F
B5C1: 26 E1          BNE    $B626
B5C3: 8D 40          BSR    $B627
B5C5: 20 9F          BRA    $B5E4
B5C7: 83 29 29       SUBD   #$0101
B5CA: 8B 8F          ADDA   #$07
B5CC: 37 37          PULU   CC,D,DP,X
B5CE: 8E DA 22       LDX    #$5200
B5D1: CC 84 84       LDD    #$0606
B5D4: DD 42          STD    $60
B5D6: EC 06          LDD    ,X
B5D8: 26 2A          BNE    $B5DC
B5DA: 0A E8          DEC    $60
B5DC: 30 A0 A8       LEAX   $20,X
B5DF: 0A 43          DEC    $61
B5E1: 26 71          BNE    $B5D6
B5E3: 39             RTS
B5E4: 0D A4          TST    $86
B5E6: 27 BC          BEQ    $B626
B5E8: 0A AE          DEC    $86
B5EA: 26 B2          BNE    $B626
B5EC: BD 9E 08       JSR    $B680
B5EF: 8E 70 22       LDX    #$5200
B5F2: C6 84          LDB    #$06
B5F4: D7 42          STB    $60
B5F6: 6D 80          TST    $2,X
B5F8: 26 2C          BNE    $B5FE
B5FA: DC 18          LDD    $90
B5FC: 20 2A          BRA    $B600
B5FE: DC 1A          LDD    $92
B600: ED 2A          STD    $8,X
B602: 96 40          LDA    $C2
B604: D6 0D          LDB    $2F
B606: C4 FA          ANDB   #$78
B608: C1 48          CMPB   #$60
B60A: 24 8E          BCC    $B612
B60C: D6 EA          LDB    $C2
B60E: 44             LSRA
B60F: 54             LSRB
B610: 02 20          XNC    $02
B612: D6 40          LDB    $C2
B614: AB 2A          ADDA   $8,X
B616: EB 8B          ADDB   $9,X
B618: ED 20          STD    $8,X
B61A: 30 00 08       LEAX   $20,X
B61D: 0A E8          DEC    $60
B61F: 26 F7          BNE    $B5F6
B621: 96 16          LDA    $94
B623: B7 74 2A       STA    $5608
B626: 39             RTS
B627: 0A AC          DEC    $84
B629: 26 C9          BNE    $B66C
B62B: 96 AB          LDA    $83
B62D: 97 0C          STA    $84
B62F: C6 24          LDB    #$06
B631: 96 03          LDA    $81
B633: 8E 70 22       LDX    #$5200
B636: 6D 06          TST    ,X
B638: 27 29          BEQ    $B63B
B63A: 4A             DECA
B63B: 30 A0 08       LEAX   $20,X
B63E: 5A             DECB
B63F: 26 D7          BNE    $B636
B641: 4A             DECA
B642: 2B AA          BMI    $B66C
B644: 8D 05          BSR    $B66D
B646: 0D E2          TST    $60
B648: 27 0A          BEQ    $B66C
B64A: 96 45          LDA    $CD
B64C: 8B 2A          ADDA   #$02
B64E: 84 8B          ANDA   #$03
B650: 97 EF          STA    $CD
B652: A7 0A 3C       STA    $1E,X
B655: 86 83          LDA    #$01
B657: A7 AC          STA    ,X
B659: CC 8E 8A       LDD    #$0602
B65C: A7 2B          STA    $3,X
B65E: E7 00 3D       STB    $1F,X
B661: 6F 88          CLR    $A,X
B663: 86 DD          LDA    #$FF
B665: A7 8F          STA    $D,X
B667: 86 38          LDA    #$10
B669: A7 00 98       STA    $10,X
B66C: 39             RTS
B66D: C6 8E          LDB    #$06
B66F: D7 42          STB    $60
B671: 8E D0 82       LDX    #$5200
B674: EC A6          LDD    ,X
B676: 27 85          BEQ    $B67F
B678: 30 A0 A8       LEAX   $20,X
B67B: 0A 48          DEC    $60
B67D: 26 7D          BNE    $B674
B67F: 39             RTS
B680: 96 E0          LDA    $C2
B682: 81 9D          CMPA   #$1F
B684: 24 20          BCC    $B688
B686: 0C 40          INC    $C2
B688: 39             RTS
B689: 0D AA          TST    $22
B68B: 27 12          BEQ    $B6C7
B68D: 8E D8 28       LDX    #$50A0
B690: 0D 02          TST    $20
B692: 27 81          BEQ    $B697
B694: 8E 72 21       LDX    #$50A3
B697: EC AC          LDD    ,X
B699: 10 93 41       CMPD   $C9
B69C: 25 01          BCS    $B6C7
B69E: 0D DE          TST    $56
B6A0: 26 26          BNE    $B6A6
B6A2: 0D 4A          TST    $C8
B6A4: 26 03          BNE    $B6C7
B6A6: 86 83          LDA    #$01
B6A8: 97 E0          STA    $C8
B6AA: BD F3 94       JSR    $7BBC
B6AD: 0C 48          INC    $C0
B6AF: CC 29 22       LDD    #$0B00
B6B2: BD E2 2A       JSR    $6008
B6B5: 0D D4          TST    $56
B6B7: 27 26          BEQ    $B6C7
B6B9: 96 42          LDA    $CA
B6BB: 9B 70          ADDA   $58
B6BD: 19             DAA
B6BE: 97 42          STA    $CA
B6C0: 96 EB          LDA    $C9
B6C2: 99 D5          ADCA   $57
B6C4: 19             DAA
B6C5: 97 4B          STA    $C9
B6C7: 39             RTS
B6C8: BD 9E 67       JSR    $B6EF
B6CB: BD 9F 2F       JSR    $B707
B6CE: BD 3F 33       JSR    $B711
B6D1: BD 35 E6       JSR    $B764
B6D4: BD 95 FD       JSR    $B77F
B6D7: 7E 9E CD       JMP    $B6E5
B6DA: 39             RTS
B6DB: 8E 79 E8       LDX    #$51C0
B6DE: 10 8E 62 62    LDY    #$4040
B6E2: 7E 35 AC       JMP    $B78E
B6E5: 8E D7 E2       LDX    #$5560
B6E8: 10 8E C8 0C    LDY    #$4084
B6EC: 7E 9F 06       JMP    $B78E
B6EF: 8E 76 22       LDX    #$5400
B6F2: 10 8E 62 7A    LDY    #$4058
B6F6: C6 8E          LDB    #$0C
B6F8: D7 48          STB    $60
B6FA: BD 3F A6       JSR    $B78E
B6FD: 31 AC          LEAY   $4,Y
B6FF: 30 AA 02       LEAX   $20,X
B702: 0A E2          DEC    $60
B704: 26 D6          BNE    $B6FA
B706: 39             RTS
B707: 8E 79 C8       LDX    #$51E0
B70A: 10 8E 68 6C    LDY    #$4044
B70E: 7E 3F AC       JMP    $B78E
B711: 8E D0 82       LDX    #$5200
B714: 10 8E C2 0A    LDY    #$4088
B718: C6 2E          LDB    #$06
B71A: D7 E8          STB    $60
B71C: EC AC          LDD    ,X
B71E: 26 84          BNE    $B72C
B720: A6 20          LDA    $2,X
B722: 81 86          CMPA   #$04
B724: 26 24          BNE    $B72C
B726: A6 81          LDA    $3,X
B728: 81 2D          CMPA   #$05
B72A: 26 8A          BNE    $B72E
B72C: 8D 22          BSR    $B738
B72E: 30 00 02       LEAX   $20,X
B731: 31 A6          LEAY   $4,Y
B733: 0A 42          DEC    $60
B735: 26 67          BNE    $B71C
B737: 39             RTS
B738: 5D             TSTB
B739: 26 A8          BNE    $B75B
B73B: 0D 7B          TST    $53
B73D: 27 98          BEQ    $B74F
B73F: 0D 02          TST    $20
B741: 27 8E          BEQ    $B74F
B743: EC 26          LDD    $4,X
B745: 43             COMA
B746: 80 8C          SUBA   #$0E
B748: ED 8C          STD    ,Y
B74A: EC 85          LDD    $D,X
B74C: ED 0A          STD    $2,Y
B74E: 39             RTS
B74F: EC 26          LDD    $4,X
B751: 53             COMB
B752: C0 8D          SUBB   #$0F
B754: ED 86          STD    ,Y
B756: EC 8F          LDD    $D,X
B758: ED 0A          STD    $2,Y
B75A: 39             RTS
B75B: 4F             CLRA
B75C: 5F             CLRB
B75D: ED 0C          STD    ,X
B75F: ED 26          STD    $4,X
B761: 8D 6E          BSR    $B74F
B763: 39             RTS
B764: 8E 71 C2       LDX    #$5340
B767: 10 8E 68 C4    LDY    #$404C
B76B: C6 2B          LDB    #$03
B76D: D7 E8          STB    $60
B76F: 6D A6          TST    ,X
B771: 27 80          BEQ    $B775
B773: 8D 3B          BSR    $B78E
B775: 30 0A A2       LEAX   $20,X
B778: 31 0C          LEAY   $4,Y
B77A: 0A E8          DEC    $60
B77C: 26 D9          BNE    $B76F
B77E: 39             RTS
B77F: 8E 74 22       LDX    #$5600
B782: 10 8E 62 6A    LDY    #$4048
B786: EC 06          LDD    ,X
B788: 27 2C          BEQ    $B78E
B78A: 7E 3F A6       JMP    $B78E
B78D: 39             RTS
B78E: 6D 0C          TST    ,X
B790: 27 0B          BEQ    $B7BB
B792: 6D 83          TST    $1,X
B794: 26 36          BNE    $B7AA
B796: 0D D1          TST    $53
B798: 27 3E          BEQ    $B7B0
B79A: 0D A8          TST    $20
B79C: 27 3A          BEQ    $B7B0
B79E: EC 8C          LDD    $4,X
B7A0: 43             COMA
B7A1: 80 8C          SUBA   #$0E
B7A3: ED 86          STD    ,Y
B7A5: EC 8F          LDD    $D,X
B7A7: ED 0A          STD    $2,Y
B7A9: 39             RTS
B7AA: 4F             CLRA
B7AB: 5F             CLRB
B7AC: ED 2C          STD    $4,X
B7AE: ED 0C          STD    ,X
B7B0: EC 26          LDD    $4,X
B7B2: 53             COMB
B7B3: C0 2D          SUBB   #$0F
B7B5: ED 26          STD    ,Y
B7B7: EC 25          LDD    $D,X
B7B9: ED AA          STD    $2,Y
B7BB: 39             RTS


D49F: B7 E2 2A       STA    $C008
D4A2: 7D 56 BE       TST    $D49C
D4A5: 1C 82          ANDCC  #$00
D4A7: 8A 17          ORA    #$3F
D4A9: 28 80          BVC    $D4B3
D4AB: 77 FC 8D       ASR    $D4A5
D4AE: B7 D2 22       STA    $5A00
D4B1: 48             ASLA
D4B2: 8E 56 95       LDX    #jump_table_d4b7
D4B5: 6E 14          JMP    [A,X]        ; [indirect_jump]
D4B7: 56             RORB
D4B8: 97 FD          STA    $D5
D4BA: C9 53          ADCB   #$DB
D4BC: 09 F5          ROL    $DD
D4BE: E2 96          SBCB   -$2,X
D4C0: 29 48          BVS    $D52C
D4C2: 10 8E F6 EA    LDY    #jump_table_D4C8
D4C6: 6E 34          JMP    [A,Y]        ; [indirect_jump]
D4C8: FC FA 5D       LDD    $D2D5
D4CB: 9C FD          CMPX   $D5
D4CD: 0F 5D          CLR    $D5
D4CF: A3 F7          SUBD   [B,U]
D4D1: 0C 0F          INC    $8D
D4D3: A2 0F          SBCA   $D,Y
D4D5: 03 BD          COM    $3F
D4D7: EC D0 CC       LDD    [-$1C,S]
D4DA: 80 88          SUBA   #$00
D4DC: BD 48 80       JSR    $6008
D4DF: 86 23          LDA    #$01
D4E1: 97 34          STA    $B6
D4E3: BD 54 CD       JSR    $76EF
D4E6: 86 42          LDA    #$C0
D4E8: B7 79 46       STA    $51CE
D4EB: 8E 79 E8       LDX    #$51C0
D4EE: 10 AE 29       LDY    $B,X
D4F1: A6 8D          LDA    $F,X
D4F3: BD 42 1F       JSR    $603D
D4F6: 6F 88          CLR    $A,X
D4F8: BD 48 9F       JSR    $6017
D4FB: CC 2A 24       LDD    #$020C
D4FE: BD E8 2A       JSR    $6008
D501: CC 81 81       LDD    #$0303
D504: BD 42 8A       JSR    $6008
D507: BD 47 03       JSR    $6F2B
D50A: 0F B5          CLR    $3D
D50C: 8E F2 E9       LDX    #$DA61
D50F: 9F 1C          STX    $3E
D511: 0C 89          INC    $0B
D513: 39             RTS
D514: 0D 94          TST    $B6
D516: 26 AA          BNE    $D540
D518: BD 5F FE       JSR    $7776
D51B: 96 2D          LDA    $05
D51D: 81 8A          CMPA   #$02
D51F: 26 3D          BNE    $D540
D521: 97 89          STA    $0B
D523: 86 26          LDA    #$04
D525: 97 87          STA    $05
D527: BD 50 2B       JSR    $7803
D52A: 39             RTS
D52B: 7E 50 13       JMP    $783B
D52E: BD F0 7D       JSR    $785F
D531: 0A 88          DEC    $0A
D533: 26 29          BNE    $D540
D535: 0F 87          CLR    $05
D537: 0F 20          CLR    $08
D539: 0F 83          CLR    $0B
D53B: 0F 26          CLR    $0E
D53D: BD 5F 29       JSR    $D7A1
D540: 39             RTS
D541: 96 93          LDA    $11
D543: 48             ASLA
D544: 10 8E 57 C8    LDY    #jump_table_d54a
D548: 6E 9E          JMP    [A,Y]        ; [indirect_jump]
D54A: 5D             TSTB
D54B: D8 FD          EORB   $D5
D54D: 56             RORB
D54E: 5E             XCLRB
D54F: A2 CC          SBCA   W,S
D551: 22 82          BHI    $D553
D553: BD 42 2A       JSR    $6008
D556: 86 83          LDA    #$01
D558: 97 9E          STA    $B6
D55A: C6 9B          LDB    #$13
D55C: BD FF 26       JSR    $D7AE
D55F: 8E FA 30       LDX    #$D812
D562: BD 54 D0       JSR    $D6F2
D565: BD 55 58       JSR    $D7DA
D568: 8E F1 63       LDX    #$D9EB
D56B: BD FE F2       JSR    $D6DA
D56E: 86 40          LDA    #$C8
D570: B7 78 92       STA    $5A10
D573: 0F 6D          CLR    $4F
D575: 7F D8 94       CLR    $5A16
D578: 7F 72 87       CLR    $5A0F
D57B: 0C 39          INC    $11
D57D: 39             RTS
D57E: 0D 3E          TST    $B6
D580: 26 78          BNE    $D5DC
D582: 8E D1 82       LDX    #$53A0
D585: A6 06          LDA    ,X
D587: 4D             TSTA
D588: 27 21          BEQ    $D593
D58A: BD E8 3F       JSR    $6017
D58D: 30 00 A8       LEAX   $20,X
D590: BD 42 95       JSR    $6017
D593: BD F5 0B       JSR    $D729
D596: 86 92          LDA    #$10
D598: BD FF 62       JSR    $D7EA
D59B: B6 72 38       LDA    $5A10
D59E: 4A             DECA
D59F: B7 78 32       STA    $5A10
D5A2: 81 14          CMPA   #$96
D5A4: 27 15          BEQ    $D5DD
D5A6: 81 B0          CMPA   #$32
D5A8: 27 6C          BEQ    $D5EE
D5AA: 81 88          CMPA   #$00
D5AC: 27 51          BEQ    $D627
D5AE: B6 D2 32       LDA    $5A10
D5B1: F6 D8 92       LDB    $5A10
D5B4: 3D             MUL
D5B5: 84 7E          ANDA   #$FC
D5B7: B1 72 3E       CMPA   $5A16
D5BA: 27 81          BEQ    $D5C5
D5BC: B7 72 9E       STA    $5A16
D5BF: 8E 73 C2       LDX    #$51E0
D5C2: BD 55 69       JSR    $D74B
D5C5: 96 CD          LDA    $4F
D5C7: 84 29          ANDA   #$01
D5C9: 26 99          BNE    $D5DC
D5CB: 8E 79 C8       LDX    #$51E0
D5CE: BD 5F B0       JSR    $D792
D5D1: 7D D1 22       TST    $53A0
D5D4: 27 24          BEQ    $D5DC
D5D6: 8E D1 88       LDX    #$53A0
D5D9: BD 5E 3A       JSR    $D6B2
D5DC: 39             RTS
D5DD: 8E 50 A5       LDX    #$D82D
D5E0: BD F4 70       JSR    $D6F2
D5E3: BD F5 F8       JSR    $D7DA
D5E6: 8E 5B F5       LDX    #$D9DD
D5E9: BD 5E 52       JSR    $D6DA
D5EC: 20 E8          BRA    $D5AE
D5EE: 8E 50 6A       LDX    #$D848
D5F1: BD 54 70       JSR    $D6F2
D5F4: BD F5 4E       JSR    $D7CC
D5F7: 8E F1 D1       LDX    #$D9F9
D5FA: BD 5E F2       JSR    $D6DA
D5FD: 8E DB 28       LDX    #$53A0
D600: FC 71 86       LDD    $5304
D603: ED 26          STD    $4,X
D605: ED 0A A6       STD    $24,X
D608: 86 29          LDA    #$01
D60A: A7 0C          STA    ,X
D60C: A7 A0 A8       STA    $20,X
D60F: 6F AA 32       CLR    $10,X
D612: 6F 0A 12       CLR    $30,X
D615: 6F 88          CLR    $A,X
D617: 6F A0 02       CLR    $2A,X
D61A: CC 52 17       LDD    #$DA3F
D61D: ED 83          STD    $B,X
D61F: CC F8 6C       LDD    #$DA4E
D622: ED 0A 09       STD    $2B,X
D625: 20 05          BRA    $D5AE
D627: 0C 39          INC    $11
D629: 39             RTS
D62A: 8E DB 88       LDX    #$53A0
D62D: A6 0C          LDA    ,X
D62F: 4D             TSTA
D630: 27 2B          BEQ    $D63B
D632: BD E2 35       JSR    $6017
D635: 30 0A A2       LEAX   $20,X
D638: BD 48 9F       JSR    $6017
D63B: BD FF 01       JSR    $D729
D63E: 86 98          LDA    #$10
D640: BD F5 68       JSR    $D7EA
D643: B6 78 32       LDA    $5A10
D646: 4C             INCA
D647: B7 72 38       STA    $5A10
D64A: 81 96          CMPA   #$1E
D64C: 27 6B          BEQ    $D691
D64E: 81 D8          CMPA   #$50
D650: 27 0C          BEQ    $D680
D652: 81 28          CMPA   #$AA
D654: 27 6E          BEQ    $D6A2
D656: B6 D8 38       LDA    $5A10
D659: F6 D2 98       LDB    $5A10
D65C: 3D             MUL
D65D: 84 74          ANDA   #$FC
D65F: B1 78 34       CMPA   $5A16
D662: 27 8B          BEQ    $D66D
D664: B7 78 94       STA    $5A16
D667: 8E 79 C8       LDX    #$51E0
D66A: BD 5F 4A       JSR    $D762
D66D: 96 C7          LDA    $4F
D66F: 84 23          ANDA   #$01
D671: 26 8E          BNE    $D67F
D673: 8E 73 C2       LDX    #$51E0
D676: BD 55 BA       JSR    $D792
D679: 8E DB 28       LDX    #$53A0
D67C: BD FE 3A       JSR    $D6B2
D67F: 39             RTS
D680: 8E FA FC       LDX    #$D87E
D683: BD F4 D0       JSR    $D6F2
D686: BD 55 E4       JSR    $D7CC
D689: 8E 51 63       LDX    #$D9EB
D68C: BD FE 52       JSR    $D6DA
D68F: 20 E7          BRA    $D656
D691: 8E 5A E1       LDX    #$D863
D694: BD F4 70       JSR    $D6F2
D697: BD FF E4       JSR    $D7CC
D69A: 8E 51 F5       LDX    #$D9DD
D69D: BD 5E 52       JSR    $D6DA
D6A0: 20 96          BRA    $D656
D6A2: BD 55 83       JSR    $D7A1
D6A5: BD EC 7A       JSR    $6EF8
D6A8: 0F 39          CLR    $11
D6AA: 0F 86          CLR    $0E
D6AC: 86 2A          LDA    #$02
D6AE: 97 83          STA    $0B
D6B0: 4F             CLRA
D6B1: 39             RTS
D6B2: A6 0A 32       LDA    $10,X
D6B5: 85 85          BITA   #$07
D6B7: 26 35          BNE    $D6D6
D6B9: 81 D8          CMPA   #$50
D6BB: 22 2A          BHI    $D6BF
D6BD: 6A 8D          DEC    $5,X
D6BF: 6C 26          INC    $4,X
D6C1: 6C 86          INC    $4,X
D6C3: 6C AA 32       INC    $10,X
D6C6: 30 0A 08       LEAX   $20,X
D6C9: A6 00 98       LDA    $10,X
D6CC: 81 C8          CMPA   #$E0
D6CE: 22 8C          BHI    $D6D4
D6D0: 6A 27          DEC    $5,X
D6D2: 6A 87          DEC    $5,X
D6D4: 6C 26          INC    $4,X
D6D6: 6C 0A 38       INC    $10,X
D6D9: 39             RTS
D6DA: A6 08          LDA    ,X+
D6DC: B7 72 89       STA    $5A01
D6DF: 10 8E 73 6F    LDY    #$51ED
D6E3: A6 A2          LDA    ,X+
D6E5: A7 22          STA    ,Y+
D6E7: E7 8C          STB    ,Y
D6E9: 31 20 97       LEAY   $1F,Y
D6EC: 7A 72 89       DEC    $5A01
D6EF: 26 D0          BNE    $D6E3
D6F1: 39             RTS
D6F2: 34 92          PSHS   X
D6F4: BD F5 3E       JSR    $D7BC
D6F7: 35 38          PULS   X
D6F9: 10 8E D9 C8    LDY    #$51E0
D6FD: A6 08          LDA    ,X+
D6FF: C6 23          LDB    #$01
D701: E7 26          STB    ,Y
D703: 6F 03          CLR    $1,Y
D705: EE 03          LDU    ,X++
D707: EF 0C          STU    $4,Y
D709: 31 20 A8       LEAY   $20,Y
D70C: 4A             DECA
D70D: 26 78          BNE    $D6FF
D70F: 39             RTS
D710: 10 8E D3 64    LDY    #$51E6
D714: C6 26          LDB    #$04
D716: A6 02          LDA    ,X+
D718: A7 88          STA    ,Y+
D71A: 5A             DECB
D71B: 26 D1          BNE    $D716
D71D: 31 A2          LEAY   $A,Y
D71F: C6 24          LDB    #$06
D721: A6 02          LDA    ,X+
D723: A7 82          STA    ,Y+
D725: 5A             DECB
D726: 26 7B          BNE    $D721
D728: 39             RTS
D729: 86 9B          LDA    #$13
D72B: B7 72 29       STA    $5A01
D72E: 8E D9 E2       LDX    #$51C0
D731: 10 8E C2 62    LDY    #$4040
D735: BD 35 0C       JSR    $B78E
D738: 30 A0 A8       LEAX   $20,X
D73B: 31 0C          LEAY   $4,Y
D73D: 7A D2 89       DEC    $5A01
D740: 26 D1          BNE    $D735
D742: 39             RTS
D743: A6 2A          LDA    $8,X
D745: AB 84          ADDA   $6,X
D747: A7 2E          STA    $6,X
D749: 24 86          BCC    $D759
D74B: C6 26          LDB    #$0E
D74D: 34 99          PSHS   X,CC
D74F: 6A 26          DEC    $4,X
D751: 30 0A A2       LEAX   $20,X
D754: 5A             DECB
D755: 26 7A          BNE    $D74F
D757: 35 39          PULS   CC,X
D759: 39             RTS
D75A: A6 80          LDA    $8,X
D75C: AB 2E          ADDA   $6,X
D75E: A7 8E          STA    $6,X
D760: 24 2C          BCC    $D770
D762: C6 8C          LDB    #$0E
D764: 34 33          PSHS   X,CC
D766: 6C 86          INC    $4,X
D768: 30 A0 A8       LEAX   $20,X
D76B: 5A             DECB
D76C: 26 D0          BNE    $D766
D76E: 35 99          PULS   CC,X
D770: 39             RTS
D771: A6 0A 94       LDA    $16,X
D774: AB 25          ADDA   $7,X
D776: A7 85          STA    $7,X
D778: 24 26          BCC    $D788
D77A: C6 86          LDB    #$0E
D77C: 34 39          PSHS   X,CC
D77E: 6A 8D          DEC    $5,X
D780: 30 AA A2       LEAX   $20,X
D783: 5A             DECB
D784: 26 DA          BNE    $D77E
D786: 35 93          PULS   CC,X
D788: 39             RTS
D789: A6 00 9E       LDA    $16,X
D78C: AB 2F          ADDA   $7,X
D78E: A7 8F          STA    $7,X
D790: 24 2C          BCC    $D7A0
D792: C6 8C          LDB    #$0E
D794: 34 33          PSHS   X,CC
D796: 6C 87          INC    $5,X
D798: 30 A0 A8       LEAX   $20,X
D79B: 5A             DECB
D79C: 26 D0          BNE    $D796
D79E: 35 99          PULS   CC,X
D7A0: 39             RTS
D7A1: 86 7D          LDA    #$FF
D7A3: 8E 62 62       LDX    #$4040
D7A6: A7 02          STA    ,X+
D7A8: 8C 68 28       CMPX   #$40A0
D7AB: 26 D1          BNE    $D7A6
D7AD: 39             RTS
D7AE: 8E D9 E2       LDX    #$51C0
D7B1: 86 A2          LDA    #$20
D7B3: 6F A2          CLR    ,X+
D7B5: 4A             DECA
D7B6: 26 79          BNE    $D7B3
D7B8: 5A             DECB
D7B9: 26 7E          BNE    $D7B1
D7BB: 39             RTS
D7BC: 8E 79 68       LDX    #$51E0
D7BF: 86 2C          LDA    #$0E
D7C1: C6 83          LDB    #$01
D7C3: E7 23          STB    $1,X
D7C5: 30 0A A2       LEAX   $20,X
D7C8: 4A             DECA
D7C9: 26 7E          BNE    $D7C1
D7CB: 39             RTS
D7CC: 0D 7B          TST    $53
D7CE: 27 8C          BEQ    $D7D4
D7D0: 0D 02          TST    $20
D7D2: 26 81          BNE    $D7D7
D7D4: C6 62          LDB    #$40
D7D6: 39             RTS
D7D7: C6 A8          LDB    #$80
D7D9: 39             RTS
D7DA: 0D DB          TST    $53
D7DC: 27 2C          BEQ    $D7E2
D7DE: 0D A8          TST    $20
D7E0: 26 21          BNE    $D7E5
D7E2: C6 42          LDB    #$C0
D7E4: 39             RTS
D7E5: C6 82          LDB    #$00
D7E7: 39             RTS
D7E8: 86 26          LDA    #$0E
D7EA: B7 D2 29       STA    $5A01
D7ED: B6 D2 87       LDA    $5A0F
D7F0: 8E F8 DF       LDX    #$DA5D
D7F3: 31 A4          LEAY   A,X
D7F5: 8E D3 62       LDX    #$51E0
D7F8: C6 D8          LDB    #$F0
D7FA: E4 86          ANDB   $E,X
D7FC: EA 8C          ORB    ,Y
D7FE: E7 86          STB    $E,X
D800: 30 AA A2       LEAX   $20,X
D803: 7A 78 23       DEC    $5A01
D806: 26 72          BNE    $D7F8
D808: B6 72 87       LDA    $5A0F
D80B: 4C             INCA
D80C: 84 2B          ANDA   #$03
D80E: B7 D2 2D       STA    $5A0F
D811: 39             RTS

DB12: 92 82          SBCA   $00
DB14: 23 22          BLS    $DB16
DB16: 82 C2          SBCA   #$40
DB18: 2C 2C          BGE    $DB1E
DB1A: 8C 89 29       CMPX   #$0101
DB1D: D7 89          STB    $01
DB1F: 89 DD          ADCA   #$FF
DB21: 96 93          LDA    $11
DB23: 48             ASLA
DB24: 8E F9 AB       LDX    #jump_table_db29
DB27: 6E BE          JMP    [A,X]        ; [indirect_jump]
DB29: F3 BF 53       ADDD   $37DB
DB2C: 8F F3 4F       XSTX   #$DBC7
DB2F: 54             LSRB
DB30: 21 FE          BRN    $DB0E
DB32: 25 5E          BCS    $DB10
DB34: 92 FF          SBCA   $DD
DB36: DD 8E          STD    $0C
DB38: 79 C8 C6       ROL    $E04E
DB3B: 9A BD          ORA    $95
DB3D: FF 39 BD       STU    $B135
DB40: 59             ROLB
DB41: D7 BD          STB    $3F
DB43: 55             LSRB
DB44: 83 96 43       SUBD   #$B4C1
DB47: 84 2B          ANDA   #$03
DB49: 48             ASLA
DB4A: 8E 53 67       LDX    #jump_table_db4f
DB4D: 6E 1E          JMP    [A,X]        ; [indirect_jump]
DB4F: 53             COMB
DB50: 77 F9 DC       ASR    $DB5E
DB53: 59             ROLB
DB54: 45             LSRA
DB55: 8E CD BB       LDX    #$4F39
DB58: CE 55 88       LDU    #$7D00
DB5B: 7E F3 45       JMP    $DB6D
DB5E: 8E C6 FA       LDX    #$4ED8
DB61: CE 92 82       LDU    #$1000
DB64: 7E F9 EF       JMP    $DB6D
DB67: 8E 67 11       LDX    #$4F39
DB6A: CE 08 28       LDU    #watchdog_8000
DB6D: 86 8C          LDA    #$04
DB6F: B7 78 23       STA    $5A01
DB72: 1E B2          EXG    U,D
DB74: E7 AB 7E 82    STB    -$0400,X
DB78: A7 A8          STA    ,X+
DB7A: E7 01 D4 28    STB    -$0400,X
DB7E: A7 08          STA    ,X+
DB80: E7 AB 7E 82    STB    -$0400,X
DB84: A7 A6          STA    ,X
DB86: 30 0A 36       LEAX   $1E,X
DB89: 7A D2 89       DEC    $5A01
DB8C: 26 CE          BNE    $DB74
DB8E: 8E 50 BB       LDX    #$D899
DB91: BD 54 70       JSR    $D6F2
DB94: BD F5 4E       JSR    $D7CC
DB97: 8E F2 2F       LDX    #$DA07
DB9A: BD 5E F2       JSR    $D6DA
DB9D: 7F D2 87       CLR    $5A0F
DBA0: 86 02          LDA    #$20
DBA2: 97 92          STA    $10
DBA4: 0C 33          INC    $11
DBA6: 39             RTS
DBA7: 0A 38          DEC    $10
DBA9: 26 9D          BNE    $DBC0
DBAB: 8E F0 84       LDX    #$D8AC
DBAE: BD 5E D0       JSR    $D6F2
DBB1: BD 55 4E       JSR    $D7CC
DBB4: 8E F8 93       LDX    #$DA11
DBB7: BD FE F2       JSR    $D6DA
DBBA: 86 A8          LDA    #$20
DBBC: 97 38          STA    $10
DBBE: 0C 99          INC    $11
DBC0: BD F5 AB       JSR    $D729
DBC3: BD F5 CA       JSR    $D7E8
DBC6: 39             RTS
DBC7: 0A 38          DEC    $10
DBC9: 26 B9          BNE    $DBFC
DBCB: 8E F0 97       LDX    #$D8BF
DBCE: BD 5E D0       JSR    $D6F2
DBD1: BD 55 4E       JSR    $D7CC
DBD4: 8E F8 99       LDX    #$DA1B
DBD7: BD FE F2       JSR    $D6DA
DBDA: 8E D9 E8       LDX    #$51C0
DBDD: CC 38 58       LDD    #$B0D0
DBE0: ED 26          STD    $4,X
DBE2: 6F 88          CLR    $A,X
DBE4: 10 8E 5B 25    LDY    #$D9A7
DBE8: BD FF 52       JSR    $D7DA
DBEB: 26 2C          BNE    $DBF1
DBED: 10 8E 51 92    LDY    #$D9B0
DBF1: 10 AF 89       STY    $B,X
DBF4: 8E FA 50       LDX    #$D8D2
DBF7: BD FF 38       JSR    $D710
DBFA: 0C 99          INC    $11
DBFC: BD FF A1       JSR    $D729
DBFF: BD F5 CA       JSR    $D7E8
DC02: 39             RTS
DC03: 8E 73 E2       LDX    #$51C0
DC06: BD E2 3F       JSR    $6017
DC09: BD 5F A1       JSR    $D729
DC0C: BD FF 60       JSR    $D7E8
DC0F: 8E 73 C2       LDX    #$51E0
DC12: EC 8A          LDD    $8,X
DC14: A3 AA 96       SUBD   $14,X
DC17: ED 20          STD    $8,X
DC19: 10 83 F3 28    CMPD   #$7B00
DC1D: 27 A1          BEQ    $DC48
DC1F: 10 83 18 82    CMPD   #$3A00
DC23: 27 6B          BEQ    $DC6E
DC25: 10 83 82 28    CMPD   #$0000
DC29: 27 F1          BEQ    $DCA4
DC2B: 8E 79 C8       LDX    #$51E0
DC2E: BD 5F 61       JSR    $D743
DC31: 24 81          BCC    $DC36
DC33: 7A 73 E6       DEC    $51C4
DC36: EC 0A 3E       LDD    $16,X
DC39: E3 00 90       ADDD   $18,X
DC3C: ED A0 9E       STD    $16,X
DC3F: BD F5 53       JSR    $D771
DC42: 24 81          BCC    $DC47
DC44: 7A 73 47       DEC    $51C5
DC47: 39             RTS
DC48: 8E F0 54       LDX    #$D8DC
DC4B: BD FE DA       JSR    $D6F2
DC4E: 0D DB          TST    $53
DC50: 27 26          BEQ    $DC56
DC52: 0D A2          TST    $20
DC54: 26 26          BNE    $DC5A
DC56: C6 02          LDB    #$80
DC58: 20 2A          BRA    $DC5C
DC5A: C6 C8          LDB    #$40
DC5C: 8E F1 63       LDX    #$D9EB
DC5F: BD F4 F8       JSR    $D6DA
DC62: 8E D3 E2       LDX    #$51C0
DC65: CC EB 50       LDD    #$69D2
DC68: ED 2C          STD    $4,X
DC6A: 6F 82          CLR    $A,X
DC6C: 20 95          BRA    $DC2B
DC6E: 8E 50 D5       LDX    #$D8F7
DC71: BD 54 70       JSR    $D6F2
DC74: 0D 71          TST    $53
DC76: 27 86          BEQ    $DC7C
DC78: 0D 08          TST    $20
DC7A: 26 8C          BNE    $DC80
DC7C: C6 A8          LDB    #$80
DC7E: 20 8A          BRA    $DC82
DC80: C6 62          LDB    #$40
DC82: 8E 5B DB       LDX    #$D9F9
DC85: BD 54 58       JSR    $D6DA
DC88: 8E 79 48       LDX    #$51C0
DC8B: CC 12 99       LDD    #$3AB1
DC8E: ED 8C          STD    $4,X
DC90: 6F 28          CLR    $A,X
DC92: 10 8E FB 9B    LDY    #$D9B9
DC96: BD 55 F2       JSR    $D7DA
DC99: 26 8C          BNE    $DC9F
DC9B: 10 8E F1 4A    LDY    #$D9C2
DC9F: 10 AF 29       STY    $B,X
DCA2: 20 05          BRA    $DC2B
DCA4: 0C 33          INC    $11
DCA6: 39             RTS
DCA7: 8E F1 3A       LDX    #$D912
DCAA: BD 5F 38       JSR    $D710
DCAD: 0C 99          INC    $11
DCAF: 39             RTS
DCB0: 8E 73 42       LDX    #$51C0
DCB3: BD 42 35       JSR    $6017
DCB6: BD 55 01       JSR    $D729
DCB9: BD 5F 60       JSR    $D7E8
DCBC: 8E 79 68       LDX    #$51E0
DCBF: EC 2A          LDD    $8,X
DCC1: E3 0A 96       ADDD   $14,X
DCC4: ED 2A          STD    $8,X
DCC6: 10 83 78 08    CMPD   #$5020
DCCA: 27 A1          BEQ    $DCF5
DCCC: 10 83 13 A8    CMPD   #$9B20
DCD0: 27 7B          BEQ    $DD2B
DCD2: 10 83 28 02    CMPD   #$0A20
DCD6: 27 EC          BEQ    $DD46
DCD8: 8E 79 68       LDX    #$51E0
DCDB: BD FF 72       JSR    $D75A
DCDE: 24 8B          BCC    $DCE3
DCE0: 7C 73 46       INC    $51C4
DCE3: EC AA 34       LDD    $16,X
DCE6: A3 0A 30       SUBD   $18,X
DCE9: ED 00 9E       STD    $16,X
DCEC: BD FF F9       JSR    $D771
DCEF: 24 21          BCC    $DCF4
DCF1: 7A D3 47       DEC    $51C5
DCF4: 39             RTS
DCF5: 8E 5B 9E       LDX    #$D91C
DCF8: BD FE 7A       JSR    $D6F2
DCFB: 0D 7B          TST    $53
DCFD: 27 8C          BEQ    $DD03
DCFF: 0D 02          TST    $20
DD01: 26 86          BNE    $DD07
DD03: C6 22          LDB    #$00
DD05: 20 80          BRA    $DD09
DD07: C6 E8          LDB    #$C0
DD09: 8E 51 63       LDX    #$D9EB
DD0C: BD FE 52       JSR    $D6DA
DD0F: 8E 73 E2       LDX    #$51C0
DD12: CC A6 56       LDD    #$2474
DD15: ED 86          STD    $4,X
DD17: 6F 22          CLR    $A,X
DD19: 10 8E 51 E3    LDY    #$D9CB
DD1D: BD 5F 52       JSR    $D7DA
DD20: 26 26          BNE    $DD26
DD22: 10 8E FB F6    LDY    #$D9D4
DD26: 10 AF 23       STY    $B,X
DD29: 20 25          BRA    $DCD8
DD2B: 8E F1 1F       LDX    #$D937
DD2E: BD 5E D0       JSR    $D6F2
DD31: BD 55 58       JSR    $D7DA
DD34: 8E F8 99       LDX    #$DA1B
DD37: BD FE F2       JSR    $D6DA
DD3A: 8E D9 E8       LDX    #$51C0
DD3D: CC B7 CA       LDD    #$3F42
DD40: ED 26          STD    $4,X
DD42: 6F 88          CLR    $A,X
DD44: 20 B0          BRA    $DCD8
DD46: CC 82 28       LDD    #$0000
DD49: BD E8 80       JSR    $6008
DD4C: 86 29          LDA    #$01
DD4E: 97 3E          STA    $B6
DD50: BD F5 23       JSR    $D7A1
DD53: CC 6E 22       LDD    #$4C00
DD56: FD C2 E8       STD    $40C0
DD59: FD C8 68       STD    $40E0
DD5C: 0C 39          INC    $11
DD5E: 39             RTS
DD5F: 0D 94          TST    $B6
DD61: 26 84          BNE    $DD69
DD63: 0F 33          CLR    $11
DD65: 0F 89          CLR    $0B
DD67: 0C 20          INC    $08
DD69: 39             RTS
DD6A: 96 99          LDA    $11
DD6C: 48             ASLA
DD6D: 8E 55 FA       LDX    #jump_table_dd72
DD70: 6E B4          JMP    [A,X]        ; [indirect_jump]
DD72: 5F             CLRB
DD73: FC FF FE       LDD    $DDDC
DD76: 5C             INCB
DD77: 13             SYNC
DD78: F6 9E 56       LDB    $B6DE
DD7B: 66 F7 91 BD    ROR    [$B935]
DD7F: F3 D7 BD       ADDD   $F59F
DD82: 55             LSRB
DD83: 23 C6          BLS    $DD69
DD85: 3A             ABX
DD86: BD 55 86       JSR    $D7AE
DD89: 7F D2 8B       CLR    $5A03
DD8C: 8E 65 34       LDX    #$4DBC
DD8F: BF 78 26       STX    $5A04
DD92: 8E CC 7E       LDX    #$4E5C
DD95: BF D8 84       STX    $5A06
DD98: 8E 65 30       LDX    #$4DB8
DD9B: BF 72 20       STX    $5A08
DD9E: 86 8B          LDA    #$03
DDA0: B7 78 88       STA    $5A0A
DDA3: 86 24          LDA    #$06
DDA5: B7 D8 89       STA    $5A0B
DDA8: 86 2C          LDA    #$04
DDAA: B7 D2 29       STA    $5A01
DDAD: 8E C5 51       LDX    #$4DD9
DDB0: 10 8E CB 5B    LDY    #$49D9
DDB4: 86 4F          LDA    #$6D
DDB6: 5F             CLRB
DDB7: F7 72 24       STB    $5A0C
DDBA: A7 08          STA    ,X+
DDBC: A7 A8          STA    ,X+
DDBE: A7 08          STA    ,X+
DDC0: E7 82          STB    ,Y+
DDC2: E7 22          STB    ,Y+
DDC4: E7 82          STB    ,Y+
DDC6: 30 0A 35       LEAX   $1D,X
DDC9: 31 20 95       LEAY   $1D,Y
DDCC: 7A 72 89       DEC    $5A01
DDCF: 26 CB          BNE    $DDBA
DDD1: 8E CA 82       LDX    #color_ram_4800
DDD4: BF 78 8F       STX    $5A0D
DDD7: 0F 67          CLR    $4F
DDD9: 0C 99          INC    $11
DDDB: 39             RTS
DDDC: 96 67          LDA    $4F
DDDE: 85 8B          BITA   #$03
DDE0: 10 26 82 EA    LBNE   $DE4C
DDE4: 86 4F          LDA    #$6D
DDE6: BE D8 2C       LDX    $5A04
DDE9: 8C C4 B4       CMPX   #$4C3C
DDEC: 27 3B          BEQ    $DE01
DDEE: F6 D2 28       LDB    $5A0A
DDF1: A7 00          STA    ,-X
DDF3: 5A             DECB
DDF4: 26 D9          BNE    $DDF1
DDF6: BE D8 2E       LDX    $5A06
DDF9: F6 D2 82       LDB    $5A0A
DDFC: A7 AA          STA    ,-X
DDFE: 5A             DECB
DDFF: 26 D9          BNE    $DDFC
DE01: BE D8 8A       LDX    $5A08
DE04: 8C 6E BD       CMPX   #$4C3F
DE07: 26 2F          BNE    $DE10
DE09: 0C 99          INC    $11
DE0B: 86 36          LDA    #$1E
DE0D: 97 98          STA    $10
DE0F: 39             RTS
DE10: F6 78 89       LDB    $5A0B
DE13: A7 A6          STA    ,X
DE15: 30 0A A2       LEAX   $20,X
DE18: 5A             DECB
DE19: 26 70          BNE    $DE13
DE1B: 7C 72 22       INC    $5A0A
DE1E: BE D2 26       LDX    $5A04
DE21: 8C CE BE       CMPX   #$4C3C
DE24: 27 2D          BEQ    $DE35
DE26: 30 0A C8       LEAX   -$20,X
DE29: BF D2 8C       STX    $5A04
DE2C: BE 72 8E       LDX    $5A06
DE2F: 30 AA 02       LEAX   $20,X
DE32: BF D8 24       STX    $5A06
DE35: BE D8 8A       LDX    $5A08
DE38: 8C 64 C5       CMPX   #$4C4D
DE3B: 23 21          BLS    $DE46
DE3D: 7C D2 83       INC    $5A0B
DE40: 7C 78 89       INC    $5A0B
DE43: 30 AA C2       LEAX   -$20,X
DE46: 30 9D          LEAX   -$1,X
DE48: BF 72 80       STX    $5A08
DE4B: 39             RTS
DE4C: B6 72 83       LDA    $5A0B
DE4F: 4C             INCA
DE50: B7 78 83       STA    $5A01
DE53: BE 78 24       LDX    $5A06
DE56: BD 55 F2       JSR    $D7DA
DE59: 26 8B          BNE    $DE5E
DE5B: BE 72 2C       LDX    $5A04
DE5E: 30 01 DE 22    LEAX   -$0400,X
DE62: BF D8 2F       STX    $5A0D
DE65: B6 D8 8E       LDA    $5A0C
DE68: F6 72 82       LDB    $5A0A
DE6B: A7 AA          STA    ,-X
DE6D: 5A             DECB
DE6E: 26 73          BNE    $DE6B
DE70: BE 78 8F       LDX    $5A0D
DE73: 30 AA C2       LEAX   -$20,X
DE76: BD 55 F2       JSR    $D7DA
DE79: 26 8B          BNE    $DE7E
DE7B: 30 A0 68       LEAX   $40,X
DE7E: BF D2 2F       STX    $5A0D
DE81: 7A D8 83       DEC    $5A01
DE84: 26 C0          BNE    $DE68
DE86: B6 D8 24       LDA    $5A0C
DE89: 4C             INCA
DE8A: 4C             INCA
DE8B: 84 27          ANDA   #$0F
DE8D: B7 D2 84       STA    $5A0C
DE90: 39             RTS
DE91: 8E C9 22       LDX    #$4BA0
DE94: B6 78 8E       LDA    $5A0C
DE97: C6 34          LDB    #$1C
DE99: A7 08          STA    ,X+
DE9B: 5A             DECB
DE9C: 26 D3          BNE    $DE99
DE9E: 30 00 E6       LEAX   -$3C,X
DEA1: 8C CA A2       CMPX   #$4820
DEA4: 26 D3          BNE    $DE97
DEA6: B6 D8 24       LDA    $5A0C
DEA9: 4C             INCA
DEAA: 84 87          ANDA   #$0F
DEAC: B7 72 84       STA    $5A0C
DEAF: 0A 32          DEC    $10
DEB1: 26 80          BNE    $DEB5
DEB3: 0C 33          INC    $11
DEB5: 39             RTS
DEB6: CC 82 28       LDD    #$0000
DEB9: BD E8 80       JSR    $6008
DEBC: 86 29          LDA    #$01
DEBE: 97 3E          STA    $B6
DEC0: 8E FB C8       LDX    #$D94A
DEC3: BD F4 D0       JSR    $D6F2
DEC6: BD 55 E4       JSR    $D7CC
DEC9: 8E 51 63       LDX    #$D9EB
DECC: BD FE 52       JSR    $D6DA
DECF: 8E 73 E2       LDX    #$51C0
DED2: CC B7 07       LDD    #$3525
DED5: ED 86          STD    $4,X
DED7: 86 FD          LDA    #$D5
DED9: BD 5F 44       JSR    $D7CC
DEDC: ED 25          STD    $D,X
DEDE: 86 89          LDA    #$01
DEE0: A7 A6          STA    ,X
DEE2: 8E 5B B6       LDX    #$D994
DEE5: BD 55 92       JSR    $D710
DEE8: 7F 72 87       CLR    $5A0F
DEEB: 0C 39          INC    $11
DEED: 39             RTS
DEEE: 0D 3E          TST    $B6
DEF0: 26 6C          BNE    $DF40
DEF2: BD 55 0B       JSR    $D729
DEF5: BD 55 6A       JSR    $D7E8
DEF8: 8E 79 68       LDX    #$51E0
DEFB: EC 20          LDD    $8,X
DEFD: A3 00 9C       SUBD   $14,X
DF00: ED 2A          STD    $8,X
DF02: A6 86          LDA    $4,X
DF04: 81 6E          CMPA   #$4C
DF06: 27 BB          BEQ    $DF41
DF08: 81 5E          CMPA   #$76
DF0A: 27 C3          BEQ    $DF57
DF0C: 81 A3          CMPA   #$8B
DF0E: 10 27 22 43    LBEQ   $DF73
DF12: 81 46          CMPA   #$C4
DF14: 10 27 82 EF    LBEQ   $DF85
DF18: 81 CB          CMPA   #$E3
DF1A: 10 27 28 51    LBEQ   $DF97
DF1E: 81 79          CMPA   #$F1
DF20: 10 27 82 07    LBEQ   $DFA9
DF24: 8E 73 62       LDX    #$51E0
DF27: BD FF 72       JSR    $D75A
DF2A: 24 8B          BCC    $DF2F
DF2C: 7C 79 4C       INC    $51C4
DF2F: EC AA 34       LDD    $16,X
DF32: E3 0A 3A       ADDD   $18,X
DF35: ED 0A 94       STD    $16,X
DF38: BD FF 01       JSR    $D789
DF3B: 24 2B          BCC    $DF40
DF3D: 7C D9 4D       INC    $51C5
DF40: 39             RTS
DF41: 8E 5B E7       LDX    #$D965
DF44: BD F4 70       JSR    $D6F2
DF47: BD FF E4       JSR    $D7CC
DF4A: 8E 52 0D       LDX    #$DA25
DF4D: BD 5E 52       JSR    $D6DA
DF50: 86 23          LDA    #$01
DF52: B7 D3 E3       STA    $51C1
DF55: 20 4F          BRA    $DF24
DF57: 8E F1 54       LDX    #$D97C
DF5A: BD 5E DA       JSR    $D6F2
DF5D: BD 5F 44       JSR    $D7CC
DF60: 8E F8 B3       LDX    #$DA31
DF63: BD F4 F8       JSR    $D6DA
DF66: BD 55 F2       JSR    $D7DA
DF69: 8E DA C8       LDX    #$5240
DF6C: E7 26          STB    $E,X
DF6E: E7 00 0C       STB    $2E,X
DF71: 20 33          BRA    $DF24
DF73: 8E FB AB       LDX    #$D989
DF76: BD 54 DA       JSR    $D6F2
DF79: BD 5F 44       JSR    $D7CC
DF7C: 8E F2 B0       LDX    #$DA38
DF7F: BD F4 F8       JSR    $D6DA
DF82: 16 7D BD       LBRA   $DF24
DF85: 8E 5B 0C       LDX    #$D98E
DF88: BD FE 7A       JSR    $D6F2
DF8B: BD FF E4       JSR    $D7CC
DF8E: 8E 52 19       LDX    #$DA3B
DF91: BD 54 58       JSR    $D6DA
DF94: 16 DD 0F       LBRA   $DF24
DF97: 8E F1 B9       LDX    #$D991
DF9A: BD 5E DA       JSR    $D6F2
DF9D: BD 5F 44       JSR    $D7CC
DFA0: 8E F8 BF       LDX    #$DA3D
DFA3: BD F4 F8       JSR    $D6DA
DFA6: 16 7D 53       LBRA   $DF24
DFA9: CC 88 88       LDD    #$0000
DFAC: BD 48 80       JSR    $6008
DFAF: 86 23          LDA    #$01
DFB1: 97 34          STA    $B6
DFB3: BD F5 83       JSR    $D7A1
DFB6: 0C 93          INC    $11
DFB8: 39             RTS
DFB9: 0D 3E          TST    $B6
DFBB: 26 2E          BNE    $DFC3
DFBD: 0C 80          INC    $08
DFBF: 0F 29          CLR    $0B
DFC1: 0F 93          CLR    $11
DFC3: 39             RTS
jump_table_6074:
	dc.w	$643a	; $6074
	dc.w	$64be	; $6076
	dc.w	$6670	; $6078
	dc.w	$6673	; $607a
	dc.w	$6718	; $607c
	dc.w	$67d9	; $607e
	dc.w	$67fe	; $6080
	dc.w	$6976	; $6082
	dc.w	$6991	; $6084
	dc.w	$6d52	; $6086
	dc.w	$6d52	; $6088
	dc.w	$6d67	; $608a
	dc.w	$6dbf	; $608c
	dc.w	$6dda	; $608e
	dc.w	$6e32	; $6090
	dc.w	$6e4f	; $6092
jump_table_70c2:
	dc.w	$7321	; $70c2
	dc.w	$7333	; $70c4
	dc.w	$7468	; $70c6
	dc.w	$7567	; $70c8
	dc.w	$7578	; $70ca
jump_table_734a:
	dc.w	$7354	; $734a
	dc.w	$735f	; $734c
	dc.w	$73e6	; $734e
	dc.w	$7453	; $7350
	dc.w	$745a	; $7352
jump_table_7368:
	dc.w	$736c	; $7368
	dc.w	$7379	; $736a
jump_table_73ef:
	dc.w	$73f3	; $73ef
	dc.w	$7404	; $73f1
jump_table_74c1:
	dc.w	$74c9	; $74c1
	dc.w	$7518	; $74c3
	dc.w	$7538	; $74c5
	dc.w	$755e	; $74c7
jump_table_74d2:
	dc.w	$74d6	; $74d2
	dc.w	$7505	; $74d4
jump_table_7570:
	dc.w	$7589	; $7570
	dc.w	$7776	; $7572
	dc.w	$77c8	; $7574
	dc.w	$7aa9	; $7576
	dc.w	$be05	; $7578
	dc.w	$c098	; $757a
	dc.w	$a675	; $757c
	dc.w	$81e6	; $757e
	dc.w	$b675	; $7580
	dc.w	$9c77	; $7582
	dc.w	$7677	; $7584
	dc.w	$d97a	; $7586
	dc.w	$b6be	; $7588
jump_table_7581:
	dc.w	$759c	; $7581
	dc.w	$7776	; $7583
	dc.w	$77d9	; $7585
	dc.w	$7ab6	; $7587
	dc.w	$be08	; $7589
	dc.w	$c038	; $758b
	dc.w	$a675	; $758d
	dc.w	$924c	; $758f
	dc.w	$b675	; $7591
	dc.w	$af76	; $7593
	dc.w	$b077	; $7595
jump_table_7592:
	dc.w	$75af	; $7592
	dc.w	$76b0	; $7594
	dc.w	$7715	; $7596
	dc.w	$772d	; $7598
	dc.w	$7768	; $759a
	dc.w	$be08	; $759c
	dc.w	$c098	; $759e
	dc.w	$ac75	; $75a0
	dc.w	$a5ec	; $75a2
	dc.w	$b675	; $75a4
	dc.w	$be76	; $75a6
	dc.w	$b077	; $75a8
jump_table_75a5:
	dc.w	$75be	; $75a5
	dc.w	$76b0	; $75a7
	dc.w	$7715	; $75a9
	dc.w	$7748	; $75ab
	dc.w	$7768	; $75ad
jump_table_75b8:
	dc.w	$75cd	; $75b8
	dc.w	$75fb	; $75ba
	dc.w	$761c	; $75bc
jump_table_75c7:
	dc.w	$763e	; $75c7
	dc.w	$7674	; $75c9
	dc.w	$7695	; $75cb
	dc.w	$be0e	; $75cd
	dc.w	$c032	; $75cf
	dc.w	$ac75	; $75d1
	dc.w	$d64c	; $75d3
	dc.w	$b675	; $75d5
	dc.w	$dc75	; $75d7
	dc.w	$ef75	; $75d9
	dc.w	$f6e4	; $75db
jump_table_75d6:
	dc.w	$75dc	; $75d6
	dc.w	$75ef	; $75d8
	dc.w	$75f6	; $75da
jump_table_7647:
	dc.w	$764d	; $7647
	dc.w	$7668	; $7649
	dc.w	$766f	; $764b
jump_table_76b9:
	dc.w	$76bd	; $76b9
	dc.w	$76ce	; $76bb
jump_table_77d1:
	dc.w	$77ea	; $77d1
	dc.w	$7884	; $77d3
	dc.w	$7958	; $77d5
	dc.w	$7a60	; $77d7
	dc.w	$be08	; $77d9
	dc.w	$c038	; $77db
	dc.w	$a677	; $77dd
	dc.w	$e24c	; $77df
	dc.w	$b677	; $77e1
	dc.w	$ea78	; $77e3
	dc.w	$f079	; $77e5
jump_table_77e2:
	dc.w	$77ea	; $77e2
	dc.w	$78f0	; $77e4
	dc.w	$7958	; $77e6
	dc.w	$7a92	; $77e8
jump_table_77f3:
	dc.w	$77fb	; $77f3
	dc.w	$783b	; $77f5
	dc.w	$7856	; $77f7
	dc.w	$786c	; $77f9
jump_table_7961:
	dc.w	$796b	; $7961
	dc.w	$7972	; $7963
	dc.w	$7983	; $7965
	dc.w	$79e0	; $7967
	dc.w	$7a06	; $7969
jump_table_7ab2:
	dc.w	$7ac3	; $7ab2
	dc.w	$7ae3	; $7ab4
jump_table_7abf:
	dc.w	$7ac3	; $7abf
	dc.w	$7ae3	; $7ac1
jump_table_7acc:
	dc.w	$7ad0	; $7acc
	dc.w	$7ad3	; $7ace
jump_table_7b30:
	dc.w	$7b45	; $7b30
	dc.w	$7b4b	; $7b32
	dc.w	$7b42	; $7b34
	dc.w	$7b42	; $7b36
	dc.w	$7b51	; $7b38
	dc.w	$7b42	; $7b3a
	dc.w	$7b57	; $7b3c
	dc.w	$7b51	; $7b3e
	dc.w	$7b57	; $7b40
jump_table_7c61:
	dc.w	$7c69	; $7c61
	dc.w	$8059	; $7c63
	dc.w	$837d	; $7c65
	dc.w	$8455	; $7c67
jump_table_852d:
	dc.w	$8533	; $852d
	dc.w	$852c	; $852f
	dc.w	$85ec	; $8531
jump_table_860a:
	dc.w	$8610	; $860a
	dc.w	$8655	; $860c
	dc.w	$8670	; $860e
jump_table_87fb:
	dc.w	$880d	; $87fb
	dc.w	$8a99	; $87fd
	dc.w	$8b7c	; $87ff
	dc.w	$8cd9	; $8801
	dc.w	$8d42	; $8803
	dc.w	$8dd7	; $8805
	dc.w	$90f2	; $8807
	dc.w	$9192	; $8809
	dc.w	$93e4	; $880b
jump_table_8817:
	dc.w	$881f	; $8817
	dc.w	$8a75	; $8819
	dc.w	$8a81	; $881b
	dc.w	$8a8d	; $881d
jump_table_8aa3:
	dc.w	$8aa5	; $8aa3
jump_table_8b86:
	dc.w	$8b8c	; $8b86
	dc.w	$8bce	; $8b88
	dc.w	$8c5c	; $8b8a
jump_table_8ce3:
	dc.w	$8ceb	; $8ce3
	dc.w	$8cfa	; $8ce5
	dc.w	$8d06	; $8ce7
	dc.w	$8d1a	; $8ce9
jump_table_8d70:
	dc.w	$8d74	; $8d70
	dc.w	$8d99	; $8d72
jump_table_8de1:
	dc.w	$8e29	; $8de1
	dc.w	$8e46	; $8de3
	dc.w	$8df1	; $8de5
	dc.w	$8e29	; $8de7
	dc.w	$8e46	; $8de9
	dc.w	$8e52	; $8deb
	dc.w	$8eb6	; $8ded
	dc.w	$8edb	; $8def
jump_table_90fc:
	dc.w	$9106	; $90fc
	dc.w	$9120	; $90fe
	dc.w	$9139	; $9100
	dc.w	$9120	; $9102
	dc.w	$9174	; $9104
jump_table_919c:
	dc.w	$91aa	; $919c
	dc.w	$920a	; $919e
	dc.w	$9229	; $91a0
	dc.w	$924d	; $91a2
	dc.w	$928a	; $91a4
	dc.w	$9310	; $91a6
	dc.w	$9397	; $91a8
jump_table_93ee:
	dc.w	$93f4	; $93ee
	dc.w	$9426	; $93f0
	dc.w	$9431	; $93f2
jump_table_9468:
	dc.w	$9474	; $9468
	dc.w	$94d0	; $946a
	dc.w	$95a9	; $946c
	dc.w	$94d0	; $946e
	dc.w	$94d0	; $9470
	dc.w	$9521	; $9472
jump_table_9afd:
	dc.w	$98ab	; $9afd
	dc.w	$99b3	; $9aff
	dc.w	$9aee	; $9b01
	dc.w	$9799	; $9b03
	dc.w	$a89b	; $9b05
	dc.w	$9aaa	; $9b07
	dc.w	$9798	; $9b09
	dc.w	$a897	; $9b0b
	dc.w	$9aaa	; $9b0d
	dc.w	$9d9c	; $9b0f
	dc.w	$a89f	; $9b11
	dc.w	$9eaa	; $9b13

jump_table_a409:
	dc.w	$a411	; $a409
	dc.w	$a42f	; $a40b
	dc.w	$a468	; $a40d
	dc.w	$a42f	; $a40f
jump_table_a439:
	dc.w	$a43d	; $a439
	dc.w	$a451	; $a43b
jump_table_a7d0:
	dc.w	$a7da	; $a7d0
	dc.w	$a863	; $a7d2
	dc.w	$a7cf	; $a7d4
	dc.w	$a7cf	; $a7d6
	dc.w	$a7cf	; $a7d8
jump_table_d4b7:
	dc.w	$d4bf	; $d4b7
	dc.w	$d541	; $d4b9
	dc.w	$db21	; $d4bb
	dc.w	$dd6a	; $d4bd
jump_table_d4c8:
	dc.w	$d4d2	; $d4c8
	dc.w	$d514	; $d4ca
	dc.w	$d527	; $d4cc
	dc.w	$d52b	; $d4ce
	dc.w	$d52e	; $d4d0
jump_table_d54a:
	dc.w	$d550	; $d54a
	dc.w	$d57e	; $d54c
	dc.w	$d62a	; $d54e
jump_table_db29:
	dc.w	$db37	; $db29
	dc.w	$dba7	; $db2b
	dc.w	$dbc7	; $db2d
	dc.w	$dc03	; $db2f
	dc.w	$dca7	; $db31
	dc.w	$dcb0	; $db33
	dc.w	$dd5f	; $db35
jump_table_db4f:
	dc.w	$db55	; $db4f
	dc.w	$db5e	; $db51
	dc.w	$db67	; $db53
jump_table_dd72:
	dc.w	$dd7e	; $dd72
	dc.w	$dddc	; $dd74
	dc.w	$de91	; $dd76
	dc.w	$deb6	; $dd78
	dc.w	$deee	; $dd7a
	dc.w	$dfb9	; $dd7c
