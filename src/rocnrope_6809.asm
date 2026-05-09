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
6060: 8E 42 F6       LDX    #$6074
6063: AD B4          JSR    [A,X]		; [indirect_jsr]
6065: 4F             CLRA
6066: B7 02 AA       STA    $8082
6069: 9E 92          LDX    $1A
606B: EC AC          LDD    ,X
606D: 48             ASLA
606E: 24 55          BCC    $604D
6070: 8D 00          BSR    $6094
6072: 20 73          BRA    $6065
6074: 46             RORA
6075: 18             X18
6076: E6 3C          LDB    [W,Y]
6078: 4E             XCLRA
6079: 58             ASLB
607A: EE FB          LDU    -$D,S
607C: 4F             CLRA
607D: 30 EF          LEAX   $7,S
607F: 51             NEGB
6080: 45             LSRA
6081: DC EB          LDD    $69
6083: F4 4B B3       ANDB   $6991
6086: EF D0          STU    -$E,U
6088: 45             LSRA
6089: 7A E5 EF       DEC    $6D67
608C: 45             LSRA
608D: 97 E5          STA    $6D
608F: 52             XNCB
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
64B6: D2 BD          SBCB   $3F
64B8: 60 61          NEG    $9,U
64BA: B7 BA 78       STA    $3250
64BD: 17 58 25       LBSR   $356D
64C0: 06 2B          ROR    $09
64C2: C1 C4          CMPB   #$46
64C4: 5D             TSTB
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
6534: 44             LSRA
6535: 7B E7 31       XDEC   $65B3
6538: 65 58          LSR    -$10,S
653A: D8 C4          EORB   $4C
653C: 69 71          ROL    -$7,U
653E: CD             XHCF
653F: DA 62          ORB    $40
6541: 6D CC          TST    $E,U
6543: C7 1D          XSTB   #$3F
6545: 6F F2          CLR    -$10,S
6547: D2 64          SBCB   $4C
6549: 69 D1          ROL    -$7,U
654B: CD             XHCF
654C: 7A 68 DC       DEC    $4054
654F: DF 6D          STU    $4F
6551: 1D             SEX
6552: CF F0 65       XSTU   #$7247
6555: 63 CF          COM    $D,U
6557: C7 68          XSTB   #$40
6559: 68 C7          ASL    $F,U
655B: DE 6D          LDU    $45
655D: 7A B7 C5       DEC    $3F4D
6560: 50             NEGB
6561: 72 D0 C7       XNC    $5245
6564: 71 71 C2       NEG    $5340
6567: D1 7C          CMPB   $54
6569: 69 DA          ROL    -$E,U
656B: DC 17          LDD    $3F
656D: 65 D8          LSR    -$10,U
656F: C7 6C          XSTB   #$4E
6571: 67 C2          ASR    $0,U
6573: D2 6E          SBCB   $4C
6575: 63 DB          COM    -$7,U
6577: C7 7A          XSTB   #$52
6579: 68 C7          ASL    $F,U
657B: C6 64          LDB    #$4C
657D: 71 B7 C5       NEG    $3F4D
6580: 12             NOP
6581: 6D CC          TST    $E,U
6583: C7 62          XSTB   #$40
6585: 6D D0          TST    -$E,U
6587: C2 7C          SBCB   #$54
6589: 7F C7 C8       CLR    $4F40
658C: 78 64 C9       ASL    $4C41
658F: D1 67          CMPB   $45
6591: 70 D1 BD       NEG    $533F
6594: 6F 72          CLR    -$10,U
6596: C6 C7          LDB    #$45
6598: 78 67 DB       ASL    $4F53
659B: C1 7C          CMPB   #$54
659D: 68 CB          ASL    $3,U
659F: C7 6B          XSTB   #$49
65A1: 6C BD          INC    -$1,Y
65A3: CF 60 18       XSTU   #$423A
65A6: C2 C9          SBCB   #$4B
65A8: 67 66          ASR    $E,U
65AA: C9 C5          ADCB   #$4D
65AC: 61 68          NEG    $0,U
65AE: B9 B1 1A       ADCA   $3938
65B1: 11 BD CF 23    JSR    $4D01
65B5: 1D             SEX
65B6: CF 5B 78       XSTU   #$D950
65B9: 64 C9          LSR    $1,U
65BB: D1 17          CMPB   $3F
65BD: 64 7F          LSR    [E,S]
65BF: 10 B8 CF 6D    EORA   $EDEF
65C3: 92 33          SBCA   $11
65C5: 30 91          LEAX   -$D,X
65C7: 9A 31          ORA    $19
65C9: 32 93          LEAS   -$5,X
65CB: AF 02          STX    $A,Y
65CD: 03 F0          COM    $78
65CF: F2 AA 5E       SBCB   $887C
65D2: AD CE          JSR    $C,U
65D4: F4 B7 15       ANDB   $9597
65D7: 11 C4 C6       ANDB   #$EE
65DA: 75 77 2D       LSR    $FF05
65DD: 2F 85          BLE    $65EC
65DF: 87 37          XSTA   #$15
65E1: 35 A3          PULS   CC,Y
65E3: A1 0B          CMPA   $9,Y
65E5: DA 78          ORB    $FA
65E7: 82 2A          SBCA   #$02
65E9: 07 C4          ASR    $4C
65EB: 5D             TSTB
65EC: BC BE 1A       CMPX   $9692
65EF: F6 D5 DE       LDB    $F7FC
65F2: 7C 86 24       INC    $0406
65F5: 2E 8C          BGT    $6605
65F7: 96 3E          LDA    $16
65F9: 08 AA          ASL    $22
65FB: A0 20          SUBA   $8,X
65FD: 22 AC          BHI    $6623
65FF: AE 0D          LDX    $F,Y
6601: 6E 56          JMP    [,U]
6603: FB 59 AB       ADDB   $7B89
6606: FF 74 D1       STU    $F6F9
6609: D3 89          ADDD   $01
660B: 8B 21          ADDA   #$09
660D: 23 A4          BLS    $663B
660F: A5 3F          BITA   -$3,X
6611: 3D             MUL
6612: A7 9E          STA    -$4,X
6614: 3C 0C          CWAI   #$2E
6616: 76 BD 64       ROR    $3F4C
6619: F8 D8 C4       EORB   $504C
661C: 6D 69          TST    $1,U
661E: DB CD          ADDB   $45
6620: 62 66          XNC    $4,U
6622: C7 D2          XSTB   #$50
6624: 6D 71          TST    -$D,U
6626: CB D6          ADDB   #$54
6628: 68 6B          ASL    $3,U
662A: C7 C1          XSTB   #$49
662C: 66 07          ROR    $F,Y
662E: C5 46          BITB   #$CE
6630: 63 6C          COM    $E,U
6632: C6 AD          LDB    #$2F
6634: 6E EE D2       JMP    $6687,PCR
6637: D0 6D          SUBB   $45
6639: 7B DB C8       XDEC   $5340
663C: 7B 7C C9       XDEC   $5441
663F: DA 76          ORB    $54
6641: 62 C0          XNC    $2,U
6643: D7 76          STB    $54
6645: 76 CD CC       ROR    $4F4E
6648: 17 65 D9       LBSR   $B39C
664B: DB 6B          ADDB   $43
664D: 67 DA          ASR    -$E,U
664F: CD             XHCF
6650: 62 70          XNC    -$E,U
6652: C3 CC 69       ADDD   #$4E4B
6655: 6B CC          XDEC   $E,U
6657: C5 17          BITB   #$3F
6659: 64 5B          LSR    [,--U]
665B: 59             ROLB
665C: FC FE 68       LDD    $D6E0
665F: 6A C3          DEC    ,S++
6661: C1 50          CMPB   #$D2
6663: AA 08          ORA    $A,Y
6665: 0B A9          XDEC   $2B
6667: AE 06          LDX    $E,Y
6669: 0B A4          XDEC   $2C
666B: 5A             DECB
666C: 05 E7          LSR    $CF
666E: 8B B7          ADDA   #$3F
6670: D7 8E          STB    $AC
6672: 39             RTS
6673: D7 8F          STB    $AD
6675: 39             RTS
6676: D2 2E          SBCB   $AC
6678: 4E             XCLRA
6679: 93 EE          SUBD   $66
667B: 36 4E          PSHU   S,Y,D
667D: E9 EE          ADCB   $6,S
667F: 4C             INCA
6680: 44             LSRA
6681: E5 E4          BITB   $6,S
6683: 48             ASLA
6684: 44             LSRA
6685: EF E4          STU    $6,S
6687: 52             XNCB
6688: 4E             XCLRA
6689: FB EE 5E       ADDB   $66D6
668C: 4E             XCLRA
668D: F1 EE 54       CMPB   $66DC
6690: 44             LSRA
6691: FD E4 60       STD    $66E2
6694: 44             LSRA
6695: C7 E4          XSTB   #$66
6697: 6A 4E          DEC    $6,S
6699: C3 EE 66       ADDD   #$66EE
669C: 4E             XCLRA
669D: D9 EE          ADCB   $66
669F: 7C 44 D5       INC    $66F7
66A2: E4 78          ANDB   [F,S]
66A4: 44             LSRA
66A5: DF E5          STU    $67
66A7: 82 4F          SBCA   #$67
66A9: 2B EF          BMI    $6712
66AB: 8E 4F 21       LDX    #$6709
66AE: EF 84          STU    $C,X
66B0: 45             LSRA
66B1: 2D E5          BLT    $671A
66B3: 90 45          SUBA   $67
66B5: 37 E5          PULU   CC,D,Y,S
66B7: 9A 28          ORA    $00
66B9: 2D 88          BLT    $66BB
66BB: 88 20          EORA   #$08
66BD: 28 88          BVC    $66BF
66BF: 9A 22          ORA    $00
66C1: 22 A2          BHI    $66E3
66C3: 82 22          SBCA   #$00
66C5: 10 82 82       SBCA   #$00
66C8: 08 28          ASL    $00
66CA: 88 AC          EORA   #$24
66CC: 28 28          BVC    $66CE
66CE: BA 88 22       ORA    >$0000
66D1: 22 A2          BHI    $66F3
66D3: 82 26          SBCA   #$04
66D5: 22 82          BHI    $66D7
66D7: 8A 28          ORA    #$00
66D9: 28 9E          BVC    $66F1
66DB: 88 28          EORA   #$00
66DD: 08 88          ASL    $00
66DF: 88 07          EORA   #$25
66E1: 22 82          BHI    $66E3
66E3: B2 22 22       SBCA   >$0000
66E6: 92 82          SBCA   $00
66E8: 28 08          BVC    $670A
66EA: 88 88          EORA   #$00
66EC: 18             X18
66ED: 28 88          BVC    $66EF
66EF: C8 22          EORB   #$00
66F1: 22 D2          BHI    $6743
66F3: 82 22          SBCA   #$00
66F5: 42             XNCA
66F6: 82 82          SBCA   #$00
66F8: 58             ASLB
66F9: 28 88          BVC    $66FB
66FB: 08 28          ASL    $00
66FD: 28 8A          BVC    $6701
66FF: 88 22          EORA   #$00
6701: 12             NOP
6702: 82 82          SBCA   #$00
6704: 62 22          XNC    $0,X
6706: 82 D2          SBCA   #$50
6708: 28 28          BVC    $670A
670A: F8 88 28       EORB   >$0000
670D: A8 88          EORA   $0,X
670F: 88 B2          EORA   #$90
6711: 22 83          BHI    $6714
6713: 92 22          SBCA   $00
6715: 22 82          BHI    $6717
6717: A2 0D          SBCA   $5,Y
6719: 0A 27          DEC    $AF
671B: E8 58          EORB   -$10,S
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
68E0: 4A             DECA
68E1: CC EA 7A       LDD    #$68F8
68E4: 4B             XDECA
68E5: 1A EB          ORCC   #$69
68E7: C3 41 41       ADDD   #$6969
68EA: E6 16          LDB    [W,X]
68EC: 46             RORA
68ED: 94 C6          ANDA   $4E
68EF: 08 23          ASL    $01
68F1: 61 D0          NEG    -$E,U
68F3: C7 66          XSTB   #$44
68F5: 6B D6          XDEC   -$C,U
68F7: BD 64 E5       JSR    $4CCD
68FA: 89 C8          ADCA   #$40
68FC: 19             DAA
68FD: 7B DC A7       XDEC   $542F
6900: 6E E9          JMP    D,U
6902: 80 C2          SUBA   #$40
6904: 10 6C C6       INC    $4,U
6907: AD 64          JSR    $C,U
6909: E1 8B          CMPB   $3,X
690B: C8 1B          EORB   #$33
690D: 7A CC A7       DEC    $442F
6910: 6E E5          JMP    E,U
6912: 86 C2          LDA    #$40
6914: 16 76 CA       LBRA   $BD5F
6917: AD 64          JSR    $C,U
6919: ED 80          STD    $8,X
691B: C8 1D          EORB   #$35
691D: 7C C0 A7       INC    $482F
6920: 6E ED          JMP    ,W++
6922: 8A D0          ORA    #$52
6924: 63 6C          COM    $E,U
6926: C9 C2          ADCB   #$40
6928: 68 68          ASL    $0,U
692A: C8 DB          EORB   #$53
692C: 6B 67          XDEC   $F,U
692E: DA CD          ORB    $45
6930: 62 62          XNC    $0,U
6932: D1 D6          CMPB   $54
6934: 63 65          COM    $7,U
6936: C7 BD          XSTB   #$3F
6938: 64 56          LSR    -$2,S
693A: 90 DB          SUBA   $53
693C: 7C 69 CF       INC    $4147
693F: CD             XHCF
6940: 1D             SEX
6941: 6C 3C          INC    [W,Y]
6943: 9C B6          CMPX   $94
6945: 5E             XCLRB
6946: FD 0D AD       STD    $8F85
6949: B8 A7 C7       EORA   $2F4F
694C: 56             RORB
694D: 16 1C A7       LBRA   $FD7F
6950: 6C 9F 9C 1B    INC    [$87ED,PCR]
6954: 0D 6D          TST    $4F
6956: FF BC B1       STU    $3E99
6959: 07 C6          ASR    $4E
695B: 34 36          PSHS   X,DP,D
695D: 8D A7          BSR    $698E
695F: C6 FE          LDB    #$DC
6961: 1C 2E          ANDCC  #$AC
6963: 2E 8E          BGT    $6911
6965: 8E 2E 27       LDX    #$ACA5
6968: 17 66 08       LBSR   $B7EB
696B: 88 6E          EORA   #$46
696D: 7A CD CD       DEC    $4545
6970: 62 72          XNC    -$10,U
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
6A5A: E2 E2          SBCB   $A,S
6A5C: 42             XNCA
6A5D: E3 E3          ADDD   $B,S
6A5F: AC 49          CMPX   $B,S
6A61: 57             ASRB
6A62: E9 54          ADCB   [A,U]
6A64: 4E             XCLRA
6A65: 15             XHCF
6A66: EE 1A 44       LDU    [$6C,X]
6A69: D9 C4          ADCB   $4C
6A6B: DB B8          ADDB   $90
6A6D: B9 E6 88       ADCA   $6E00
6A70: 22 22          BHI    $6A72
6A72: CE 48 CA       LDU    #$CAE8
6A75: CB 03          ADDB   #$81
6A77: 82 28          SBCA   #$00
6A79: 28 C7          BVC    $6ACA
6A7B: CB B8          ADDB   #$90
6A7D: B9 25 88       ADCA   $AD00
6A80: 22 22          BHI    $6A82
6A82: CD             XHCF
6A83: D3 CA          ADDD   $E8
6A85: CB EC          ADDB   #$6E
6A87: 82 28          SBCA   #$00
6A89: 28 C4          BVC    $6AD7
6A8B: 5D             TSTB
6A8C: 8F 8D DE       XSTX   #$A556
6A8F: A8 02          EORA   $0,Y
6A91: 02 CE          XNC    $4C
6A93: 6E 85          JMP    E,Y
6A95: 87 FF          XSTA   #$7D
6A97: A2 08          SBCA   $0,Y
6A99: 08 C5          ASL    $4D
6A9B: 80 8F          SUBA   #$A7
6A9D: 8D E4          BSR    $6B0B
6A9F: A8 02          EORA   $0,Y
6AA1: 02 CF          XNC    $4D
6AA3: 93 81          SUBD   $A3
6AA5: 87 D4          XSTA   #$56
6AA7: A2 08          SBCA   $0,Y
6AA9: 08 C6          ASL    $4E
6AAB: 7B 8F 8D       XDEC   $A7A5
6AAE: E4 88          ANDB   $0,X
6AB0: 22 22          BHI    $6AB2
6AB2: CC 64 81       LDD    #$E6A3
6AB5: 87 FF          XSTA   #$7D
6AB7: 82 28          SBCA   #$00
6AB9: 28 C7          BVC    $6B0A
6ABB: A7 8B          STA    ,--Y
6ABD: 8D DE          BSR    $6B15
6ABF: 88 22          EORA   #$00
6AC1: 22 CC          BHI    $6B11
6AC3: 28 85          BVC    $6A6C
6AC5: 87 92          XSTA   #$10
6AC7: 82 28          SBCA   #$00
6AC9: 28 88          BVC    $6ACB
6ACB: C4 FB          ANDB   #$D3
6ACD: 58             ASLB
6ACE: FA 98 22       ORB    $1000
6AD1: 22 82          BHI    $6AD3
6AD3: CF 2B BA       XSTU   #$0998
6AD6: 1B             NOP
6AD7: 92 28          SBCA   $00
6AD9: 28 88          BVC    $6ADB
6ADB: C7 29          XSTB   #$01
6ADD: 58             ASLB
6ADE: FA 98 22       ORB    $1000
6AE1: 22 82          BHI    $6AE3
6AE3: CD             XHCF
6AE4: 31 BA 1B       LEAY   [-$67,X]
6AE7: 92 28          SBCA   $00
6AE9: 28 88          BVC    $6AEB
6AEB: C5 6B          BITB   #$43
6AED: EB 48          ADDB   ,U+
6AEF: 98 22          EORA   $00
6AF1: 22 82          BHI    $6AF3
6AF3: CE C5 E1       LDU    #$E7C3
6AF6: 42             XNCA
6AF7: 92 28          SBCA   $00
6AF9: 28 88          BVC    $6AFB
6AFB: C5 78          BITB   #$50
6AFD: EB 49          ADDB   ,U++
6AFF: 48             ASLA
6B00: 22 22          BHI    $6B02
6B02: 82 CF          SBCA   #$4D
6B04: 37 E1          PULU   CC,A,S,PC
6B06: 43             COMA
6B07: 42             XNCA
6B08: 28 28          BVC    $6B0A
6B0A: 88 C6          EORA   #$4E
6B0C: 5D             TSTB
6B0D: EB 49          ADDB   ,U++
6B0F: 48             ASLA
6B10: 22 22          BHI    $6B12
6B12: 82 CC          SBCA   #$4E
6B14: 89 E1          ADCA   #$C3
6B16: 43             COMA
6B17: 42             XNCA
6B18: 28 28          BVC    $6B1A
6B1A: 88 C7          EORA   #$4F
6B1C: 2F EB          BLE    $6AE1
6B1E: 48             ASLA
6B1F: 98 22          EORA   $00
6B21: 22 82          BHI    $6B23
6B23: 82 6E          SBCA   #$4C
6B25: B6 FC FD       LDA    $7E7F
6B28: 67 A8          ASR    ,X+
6B2A: 08 08          ASL    $80
6B2C: 65 A4 14       LSR    $6ACB,PCR
6B2F: 15             XHCF
6B30: A2 22          SBCA   $0,X
6B32: 82 82          SBCA   #$00
6B34: 6D 47          TST    $5,S
6B36: 1E 1F          EXG    B,inv
6B38: A8 28          EORA   $0,X
6B3A: 88 88          EORA   #$00
6B3C: 67 5C          ASR    -$C,S
6B3E: F6 F7 6D       LDB    $7F4F
6B41: A2 02          SBCA   ,X+
6B43: 02 6E          XNC    $4C
6B45: 86 FB          LDA    #$79
6B47: FA A8 A8       ORB    $8080
6B4A: 08 88          ASL    $00
6B4C: 64 FF          LSR    [E,U]
6B4E: F1 F0 A2       CMPB   $7880
6B51: A2 02          SBCA   ,X+
6B53: 82 6F          SBCA   #$4D
6B55: 86 FB          LDA    #$79
6B57: FB 50 A8       ADDB   $7880
6B5A: 08 08          ASL    $80
6B5C: 66 3B          ROR    -$D,X
6B5E: F1 F0 A2       CMPB   $7880
6B61: A2 02          SBCA   ,X+
6B63: 82 6C          SBCA   #$4E
6B65: 35 FF          PULS   CC,B,DP,X,Y,U
6B67: FA A8 A8       ORB    $8080
6B6A: 08 88          ASL    $00
6B6C: 66 46          ROR    $E,S
6B6E: F1 F4 58       CMPB   $7C7A
6B71: A2 02          SBCA   ,X+
6B73: 02 22          XNC    $00
6B75: 6D C0          TST    $2,U
6B77: 6A C1 85 88    DEC    -$5300,S
6B7B: 88 28          EORA   #$00
6B7D: 65 FF          LSR    -$9,S
6B7F: 4D             TSTA
6B80: E4 A2          ANDB   ,X+
6B82: 82 82          SBCA   #$00
6B84: 22 6D          BHI    $6BD5
6B86: B0 12 85       SUBA   $90AD
6B89: F2 88 88       SBCB   >$0000
6B8C: 08 64          ASL    $4C
6B8E: EE 18          LDU    [,W]
6B90: FC 8F 82       LDD    $AD00
6B93: 82 22          SBCA   #$00
6B95: 6F 86          CLR    $4,X
6B97: 21 8D          BRN    $6B3E
6B99: 55             LSRB
6B9A: 8A 88          ORA    #$00
6B9C: 28 66          BVC    $6BEC
6B9E: 02 2B          XNC    $A3
6BA0: 87 5F          XSTA   #$7D
6BA2: 80 82          SUBA   #$00
6BA4: 22 6E          BHI    $6BF2
6BA6: 52             XNCB
6BA7: 25 8D          BCS    $6B4E
6BA9: F6 8A 88       LDB    $0200
6BAC: 28 64          BVC    $6BFA
6BAE: 7C 2F 87       INC    $A7A5
6BB1: F6 80 82       LDB    $0200
6BB4: 23 6D          BLS    $6C05
6BB6: E7 21          STB    ,--Y
6BB8: 8D 55          BSR    $6C37
6BBA: 8A 88          ORA    #$00
6BBC: 28 65          BVC    $6C0B
6BBE: A1 2B          CMPA   ,--Y
6BC0: 87 8F          XSTA   #$AD
6BC2: 80 82          SUBA   #$00
6BC4: 22 6D          BHI    $6C15
6BC6: 8D 25          BSR    $6B6F
6BC8: 8B 8D          ADDA   #$A5
6BCA: 88 88          EORA   #$00
6BCC: 28 67          BVC    $6C1D
6BCE: 9C 2F          CMPX   $A7
6BD0: 87 A2          XSTA   #$80
6BD2: 80 82          SUBA   #$00
6BD4: 22 22          BHI    $6BD6
6BD6: CE F5 C0       LDU    #$77E8
6BD9: C1 E7          CMPB   #$6F
6BDB: 88 28          EORA   #$00
6BDD: 28 C5          BVC    $6C2C
6BDF: E6 BA BB       LDB    [-$67,X]
6BE2: 61 82          NEG    $0,X
6BE4: 22 22          BHI    $6BE6
6BE6: CD             XHCF
6BE7: C1 C0          CMPB   #$E8
6BE9: C1 25          CMPB   #$AD
6BEB: 88 28          EORA   #$00
6BED: 28 C6          BVC    $6C3D
6BEF: D9 BA          ADCB   $98
6BF1: BB 22 82       ADDA   $A000
6BF4: 22 22          BHI    $6BF6
6BF6: CF D7 8F       XSTU   #$55A7
6BF9: 8D 98          BSR    $6C0B
6BFB: A8 08          EORA   $0,Y
6BFD: 28 C4          BVC    $6C4B
6BFF: E4 85          ANDB   E,Y
6C01: 87 FF          XSTA   #$7D
6C03: A2 02          SBCA   $0,Y
6C05: 22 CE          BHI    $6C53
6C07: 33 8B          LEAU   ,--Y
6C09: 8D D3          BSR    $6C66
6C0B: A8 08          EORA   $0,Y
6C0D: 08 C5          ASL    $4D
6C0F: A0 85          SUBA   E,Y
6C11: 87 EA          XSTA   #$68
6C13: A2 02          SBCA   $0,Y
6C15: 02 CD          XNC    $4F
6C17: 91 8F          CMPA   $A7
6C19: 8D F5          BSR    $6C98
6C1B: 88 28          EORA   #$00
6C1D: 28 C7          BVC    $6C6E
6C1F: C7 81          XSTB   #$A3
6C21: 87 DE          XSTA   #$5C
6C23: 82 22          SBCA   #$00
6C25: 22 CC          BHI    $6C75
6C27: 68 8F          ASL    E,Y
6C29: 8D DB          BSR    $6C7E
6C2B: 88 28          EORA   #$00
6C2D: 28 C7          BVC    $6C7E
6C2F: EE 81          LDU    ,--Y
6C31: 87 92          XSTA   #$10
6C33: 82 22          SBCA   #$00
6C35: 22 82          BHI    $6C37
6C37: CE E6 B0       LDU    #$CE98
6C3A: 11 98 28       EORA   $00
6C3D: 28 88          BVC    $6C3F
6C3F: C4 FA          ANDB   #$D8
6C41: 52             XNCB
6C42: F0 92 22       SUBB   $1000
6C45: 22 82          BHI    $6C47
6C47: CC C9 B0       LDD    #$E198
6C4A: 11 98 28       EORA   $00
6C4D: 28 88          BVC    $6C4F
6C4F: C7 2C          XSTB   #$0E
6C51: 52             XNCB
6C52: F0 92 22       SUBB   $1000
6C55: 22 82          BHI    $6C57
6C57: CE CB EB       LDU    #$E3C3
6C5A: 48             ASLA
6C5B: 98 28          EORA   $00
6C5D: 28 88          BVC    $6C5F
6C5F: C4 E5          ANDB   #$C7
6C61: E1 42          CMPB   ,U+
6C63: 92 22          SBCA   $00
6C65: 22 82          BHI    $6C67
6C67: CC EF EB       LDD    #$C7C3
6C6A: 48             ASLA
6C6B: 98 28          EORA   $00
6C6D: 28 88          BVC    $6C6F
6C6F: C5 49          BITB   #$6B
6C71: E1 43          CMPB   ,U++
6C73: 42             XNCA
6C74: 22 22          BHI    $6C76
6C76: 82 CC          SBCA   #$4E
6C78: A3 EB          SUBD   ,--U
6C7A: 49             ROLA
6C7B: 48             ASLA
6C7C: 28 28          BVC    $6C7E
6C7E: 88 C5          EORA   #$4D
6C80: 52             XNCB
6C81: E1 43          CMPB   ,U++
6C83: 42             XNCA
6C84: 22 22          BHI    $6C86
6C86: 82 CF          SBCA   #$4D
6C88: 1D             SEX
6C89: EB 49          ADDB   ,U++
6C8B: 48             ASLA
6C8C: 28 28          BVC    $6C8E
6C8E: 88 C6          EORA   #$4E
6C90: 57             ASRB
6C91: E1 43          CMPB   ,U++
6C93: 42             XNCA
6C94: 22 22          BHI    $6C96
6C96: 82 82          SBCA   #$00
6C98: 64 EE          LSR    A,U
6C9A: 14             XHCF
6C9B: 15             XHCF
6C9C: A8 28          EORA   $0,X
6C9E: 88 88          EORA   #$00
6CA0: 6F 1B          CLR    -$7,Y
6CA2: 47             ASRA
6CA3: 44             LSRA
6CA4: A2 22          SBCA   $0,X
6CA6: 82 82          SBCA   #$00
6CA8: 67 A1 4D 4E    ASR    -$3A3A,X
6CAC: 45             LSRA
6CAD: 28 88          BVC    $6CAF
6CAF: 08 6C          ASL    $4E
6CB1: 52             XNCB
6CB2: 18             X18
6CB3: 19             DAA
6CB4: A2 22          SBCA   $0,X
6CB6: 82 82          SBCA   #$00
6CB8: 64 AC          LSR    ,X
6CBA: F1 F0 46       CMPB   $786E
6CBD: A8 08          EORA   ,X+
6CBF: 28 6F          BVC    $6D0E
6CC1: 86 FB          LDA    #$79
6CC3: FB 5A A2       ADDB   $7880
6CC6: 02 02          XNC    $80
6CC8: 66 E6          ROR    W,U
6CCA: F1 F4 52       CMPB   $7C7A
6CCD: A8 08          EORA   ,X+
6CCF: 08 6D          ASL    $4F
6CD1: 31 FE          LEAY   -$4,S
6CD3: F8 A2 A2       EORB   $8080
6CD6: 02 82          XNC    $00
6CD8: 66 3B          ROR    -$D,X
6CDA: F1 F0 A8       CMPB   $7880
6CDD: A8 08          EORA   ,X+
6CDF: 88 6E          EORA   #$4C
6CE1: 95 FB          BITA   $79
6CE3: FA A2 A2       ORB    $8080
6CE6: 02 82          XNC    $00
6CE8: 66 1F          ROR    -$9,Y
6CEA: F5 F0 A8       BITB   $7880
6CED: A8 08          EORA   ,X+
6CEF: 88 22          EORA   #$00
6CF1: 6F AC          CLR    $E,Y
6CF3: 6A CB D3 82    DEC    -$0F00,S
6CF7: 82 28          SBCA   #$00
6CF9: 66 87          ROR    $F,X
6CFB: 18             X18
6CFC: 55             LSRB
6CFD: 55             LSRB
6CFE: 88 88          EORA   #$00
6D00: 22 6D          BHI    $6D51
6D02: 80 12          SUBA   #$90
6D04: FC 8F 82       LDD    $AD00
6D07: A2 28          SBCA   $0,X
6D09: 67 BE          ASR    -$A,Y
6D0B: 4D             TSTA
6D0C: EE A8          LDU    ,X+
6D0E: 88 88          EORA   #$00
6D10: 22 6E          BHI    $6D5E
6D12: 26 21          BNE    $6CB7
6D14: 87 CE          XSTA   #$EC
6D16: 80 82          SUBA   #$00
6D18: 28 64          BVC    $6D66
6D1A: 61 2B          NEG    ,--Y
6D1C: 8D 85          BSR    $6CCB
6D1E: 8A 88          ORA    #$00
6D20: 22 6C          BHI    $6D70
6D22: 66 25          ROR    E,Y
6D24: 81 87          CMPA   #$A5
6D26: 82 80          SBCA   #$02
6D28: 28 66          BVC    $6D78
6D2A: 47             ASRA
6D2B: 2F 8B          BLE    $6CD0
6D2D: 8D 88          BSR    $6D2F
6D2F: 8A 22          ORA    #$00
6D31: 6F 92          CLR    -$10,X
6D33: 25 87          BCS    $6CDA
6D35: CE 80 82       LDU    #$0200
6D38: 28 67          BVC    $6D89
6D3A: C2 2B          SBCB   #$A3
6D3C: 8D 55          BSR    $6DBB
6D3E: 8A 88          ORA    #$00
6D40: 22 6E          BHI    $6D8E
6D42: 76 25 87       ROR    $A7A5
6D45: F6 80 82       LDB    $0200
6D48: 29 67          BVS    $6D99
6D4A: 9C 2F          CMPX   $A7
6D4C: 8D A8          BSR    $6CCE
6D4E: 8A 88          ORA    #$00
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
6E9E: C4 E3          ANDB   #$6B
6EA0: 2C 13          BGE    $6ED3
6EA2: D1 D6          CMPB   $54
6EA4: 62 60          XNC    $2,U
6EA6: CD             XHCF
6EA7: CC 7D 7B       LDD    #$5553
6EAA: C8 C9          EORB   #$41
6EAC: 6E 7C          JMP    -$C,U
6EAE: CD             XHCF
6EAF: DA 62          ORB    $40
6EB1: 62 C2          XNC    $0,U
6EB3: C2 62          SBCB   #$40
6EB5: 62 C2          XNC    $0,U
6EB7: C2 78          SBCB   #$50
6EB9: 7C DB B7       INC    $533F
6EBC: 64 43          LSR    $B,S
6EBE: 86 B9          LDA    #$31
6EC0: 71 76 C2       NEG    $5440
6EC3: C0 6D          SUBB   #$4F
6EC5: 6C D7          INC    -$B,U
6EC7: D1 68          CMPB   $40
6EC9: 69 CE          ROL    $6,U
6ECB: DC 6D          LDD    $45
6ECD: 7A C8 C8       DEC    $4040
6ED0: 62 62          XNC    $0,U
6ED2: C2 C2          SBCB   #$40
6ED4: 62 62          XNC    $0,U
6ED6: D2 D6          SBCB   $54
6ED8: 7B 07 C4       XDEC   $2F4C
6EDB: E0 26          SUBB   $E,X
6EDD: 69 C6          ROL    $E,U
6EDF: CC 62 60       LDD    #$4042
6EE2: CD             XHCF
6EE3: CC 77 71       LDD    #$5553
6EE6: C2 C7          SBCB   #$45
6EE8: 7E 6D DA       JMP    $4552
6EEB: D1 68          CMPB   $40
6EED: 68 C8          ASL    $0,U
6EEF: C8 62          EORB   #$40
6EF1: 62 C2          XNC    $0,U
6EF3: C2 72          SBCB   #$50
6EF5: 76 D1 BD       ROR    $533F
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
70B7: 8E 58 EA       LDX    #$70C2
70BA: AD 1E          JSR    [A,X]
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
7336: 8E F1 62       LDX    #$734A
7339: AD 1E          JSR    [A,X]
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
7362: 10 8E 51 4A    LDY    #$7368
7366: 6E 34          JMP    [A,Y]	; [indirect_jmp]
7368: 5B             XDECB
7369: 44             LSRA
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
73E9: 10 8E FB C7    LDY    #$73EF
73ED: 6E 3E          JMP    [A,Y]
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
746B: 8E 5C E9       LDX    #$74C1
746E: AD 1E          JSR    [A,X]
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
74C1: 56             RORB
74C2: 4B             XDECA
74C3: F7 3A 57       STB    $1875
74C6: BA F7 76       ORA    $755E
74C9: 96 80          LDA    $08
74CB: 48             ASLA
74CC: 10 8E FC 5A    LDY    #$74D2
74D0: 6E 94          JMP    [A,Y]
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
756A: 10 8E 5D 58    LDY    #$7570
756E: 6E 3E          JMP    [A,Y]
7570: 57             ASRB
7571: AB F5          ADDA   -$9,S
7573: F4 55 EA       ANDB   $77C8
7576: F8 2B 96       EORB   $A9BE
7579: 2D 48          BLT    $753B
757B: 10 8E 5D 09    LDY    #$7581
757F: 6E 94          JMP    [A,Y]
7581: 57             ASRB
7582: 1E F5          EXG    inv,inv
7584: 54             LSRB
7585: 55             LSRB
7586: 5B             XDECB
7587: F8 9E 96       EORB   $B6BE
758A: 80 48          SUBA   #$C0
758C: 10 8E FD 1A    LDY    #$7592
7590: 6E 94          JMP    [A,Y]
7592: F7 2D 54       STB    $AF76
7595: 92 F5          SBCA   $77
7597: 97 5F          STA    $77
7599: 05 FF          LSR    $77
759B: E0 96          SUBB   [W,Y]
759D: 20 48          BRA    $755F
759F: 10 8E 57 27    LDY    #$75A5
75A3: 6E 94          JMP    [A,Y]
75A5: 57             ASRB
75A6: 3C F4          CWAI   #$76
75A8: 98 5F          EORA   $77
75AA: 9D FF          JSR    $77
75AC: 60 5F          NEG    -$9,S
75AE: E0 96          SUBB   -$2,X
75B0: 29 48          BVS    $761C
75B2: 10 8E 57 9A    LDY    #$75B8
75B6: 6E 34          JMP    [A,Y]
75B8: 5D             TSTB
75B9: E5 FD          BITB   -$B,S
75BB: 73 5E 34       COM    $761C
75BE: 96 83          LDA    $0B
75C0: 48             ASLA
75C1: 10 8E F7 E5    LDY    #$75C7
75C5: 6E 34          JMP    [A,Y]
75C7: F4 16 5E       ANDB   $3E76
75CA: FC FE BD       LDD    $7695
75CD: 96 86          LDA    $0E
75CF: 48             ASLA
75D0: 10 8E F7 54    LDY    #$75D6
75D4: 6E 94          JMP    [A,Y]
75D6: F7 5E 5D       STB    $DC75
75D9: C7 FD          XSTB   #$75
75DB: 7E CC 2A       JMP    $E402
75DE: 89 BD          ADCA   #$35
75E0: 42             XNCA
75E1: 2A CC          BPL    $7631
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
7641: 10 8E F4 65    LDY    #$7647
7645: 6E 34          JMP    [A,Y]
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
76B3: 10 8E 54 3B    LDY    #table_76B9
76B7: 6E 9E          JMP    [A,Y]
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
77CB: 10 8E 5F 59    LDY    #$77D1
77CF: 6E 94          JMP    [A,Y]
77D1: 55             LSRB
77D2: 68 FA          ASL    -$8,S
77D4: A6 5B          LDA    -$7,S
77D6: DA F8          ORB    $7A
77D8: 48             ASLA
77D9: 96 80          LDA    $08
77DB: 48             ASLA
77DC: 10 8E FF 6A    LDY    #$77E2
77E0: 6E 94          JMP    [A,Y]
77E2: F5 68 5A       BITB   $EA78
77E5: D2 FB          SBCB   $79
77E7: DA 52          ORB    $7A
77E9: BA 96 83       ORA    $1E0B
77EC: 48             ASLA
77ED: 10 8E FF D1    LDY    #$77F3
77F1: 6E 34          JMP    [A,Y]
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
795B: 10 8E 51 E9    LDY    #$7961
795F: 6E 94          JMP    [A,Y]
7961: 5B             XDECB
7962: E9 FB          ADCB   -$7,S
7964: 50             NEGB
7965: 5B             XDECB
7966: 01 FB          NEG    $79
7968: C8 52          EORB   #$7A
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
7AAC: 10 8E F2 3A    LDY    #$7AB2
7AB0: 6E 94          JMP    [A,Y]
7AB2: F8 41 58       EORB   $C37A
7AB5: C1 96          CMPB   #$14
7AB7: 8A 48          ORA    #$60
7AB9: 10 8E F2 97    LDY    #$7ABF
7ABD: 6E 3E          JMP    [A,Y]
7ABF: F2 E1 58       SBCB   $C37A
7AC2: 61 96          NEG    -$C,X
7AC4: 29 48          BVS    $7B30
7AC6: 10 8E 52 E4    LDY    #$7ACC
7ACA: 6E 3E          JMP    [A,Y]
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
7B2A: 8E F3 18       LDX    #$7B30
7B2D: 48             ASLA
7B2E: 6E 1E          JMP    [A,X]
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
7C5A: 10 8E 54 49    LDY    #$7C61
7C5E: 6E 3E          JMP    [A,Y]
7C60: 39             RTS
7C61: 5E             XCLRB
7C62: EB 02          ADDB   ,X+
7C64: 7B A1 FF       XDEC   $837D
7C67: 06 7D          ROR    $55
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
8523: 10 8E A7 AF    LDY    #$852D
8527: A6 2B          LDA    $3,X
8529: 48             ASLA
852A: 6E 3E          JMP    [A,Y]
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
85FB: 10 8E AE 82    LDY    #$860A
85FF: AD 94          JSR    [A,Y]
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
867D: AE 05 88 22    LDX    $8681,PCR
8681: A4 14          ANDA   [A,X]
8683: 82 22          SBCA   #$00
8685: A4 1D 82 28    ANDA   [$0000]
8689: AE 20 88       LDX    $00,Y
868C: 28 24          BVC    $869A
868E: 48             ASLA
868F: 8C 2F E2       CMPX   #$0DC0
8692: 86 7D          LDA    #$FF
8694: A4 AF 8E C2    ANDA   $92D8,PCR
8698: 2C 25          BGE    $86A7
869A: C8 8C          EORB   #$04
869C: D7 AE          STB    $86
869E: 1E 84          EXG    D,inv
86A0: 22 26          BHI    $86A6
86A2: 8F 82 26       XSTX   #$0004
86A5: DD 04          STD    $86
86A7: 1D             SEX
86A8: 24 A8          BCC    $862A
86AA: 8C 85 A8       CMPX   #$0D80
86AD: 2C 77          BGE    $86AE
86AF: 0E 8A          JMP    $A8
86B1: A4 45          ANDA   E,U
86B3: 82 22          SBCA   #$00
86B5: A4 43          ANDA   ,U++
86B7: 82 28          SBCA   #$00
86B9: AE 5B          LDX    [,--U]
86BB: 88 28          EORA   #$00
86BD: AE 45 88 22    LDX    $86C1,PCR
86C1: 28 C2          BVC    $8703
86C3: 86 DD          LDA    #$FF
86C5: A4 43          ANDA   ,U++
86C7: 88 E8          EORA   #$C0
86C9: 2C 77          BGE    $86CA
86CB: 0E EF          JMP    $C7
86CD: 22 08          BHI    $864F
86CF: 8C DD A4       CMPX   #$FF86
86D2: 4F             CLRA
86D3: 88 22          EORA   #$00
86D5: 26 7D          BNE    $86D6
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
8721: 2A 82          BPL    $8723
8723: 81 22          CMPA   #$00
8725: 2B 82          BMI    $8727
8727: 89 28          ADCA   #$00
8729: 27 88          BEQ    $872B
872B: 86 28          LDA    #$00
872D: 29 88          BVS    $872F
872F: 85 22          BITA   #$00
8731: 2B 82          BMI    $8733
8733: 83 22 2B       SUBD   #$0009
8736: 82 8A          SBCA   #$08
8738: 28 2B          BVC    $873D
873A: 88 6F          EORA   #$E7
873C: 2C 6F          BGE    $8785
873E: 8D 86          BSR    $874E
8740: 23 A7          BLS    $86C7
8742: 83 39 A5       SUBD   #$BB87
8745: 78 82 82       ASL    >$0000
8748: AF 7C          STX    -$C,U
874A: 88 88          EORA   #$00
874C: AF 4E          STX    $6,S
874E: 88 88          EORA   #$00
8750: A5 42          BITA   $0,S
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
877B: 89 29          ADCA   #$01
877D: 28 89          BVC    $8780
877F: 88 22          EORA   #$00
8781: 23 83          BLS    $8784
8783: 82 22          SBCA   #$00
8785: 23 83          BLS    $8788
8787: 83 28 29       SUBD   #$0001
878A: 88 0F          EORA   #$87
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
87E7: 10 8E AF 73    LDY    #$87FB
87EB: 58             ASLB
87EC: AD 9D          JSR    [B,Y]
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
8811: 10 8E 0A 35    LDY    #$8817
8815: 6E 37          JMP    [B,Y]
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
8A9D: 10 8E 02 81    LDY    #$8AA3
8AA1: 6E 34          JMP    [A,Y]
8AA3: 08 87          ASL    $A5
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
8B80: 10 8E 09 04    LDY    #$8B86
8B84: 6E 94          JMP    [A,Y]
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
8BAE: 40             NEGA
8BAF: 4B             XDECA
8BB0: 9C 9B          CMPX   $B9
8BB2: 36 2D          PSHU   PC,Y,DP,D,CC
8BB4: 88 87          EORA   #$A5
8BB6: 22 14          BHI    $8B4E
8BB8: A4 AA          ANDA   ,-X
8BBA: F0 E6 46       SUBB   $6E6E
8BBD: 46             RORA
8BBE: F0 FB 4C       SUBB   $736E
8BC1: 4B             XDECA
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
8CDD: 10 8E 04 C1    LDY    #$8CE3
8CE1: 6E 34          JMP    [A,Y]
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
8D53: 10 8E AF F2    LDY    #$8D70
8D57: 6E 9E          JMP    [A,Y]
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
8DDB: 10 8E A5 69    LDY    #$8DE1
8DDF: 6E 94          JMP    [A,Y]
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
90F6: 10 8E B8 D4    LDY    #$90FC
90FA: 6E 3E          JMP    [A,Y]
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
9196: 10 8E B9 B4    LDY    #$919C
919A: 6E 3E          JMP    [A,Y]
919C: B9 82 1A       ADCA   $AA92
919F: 82 B0          SBCA   #$92
91A1: 0B 10          XDEC   $92
91A3: CF B0 A8       XSTU   #$928A
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
93E8: 10 8E 1B 66    LDY    #$93EE
93EC: 6E 9E          JMP    [A,Y]
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
9456: 10 8E BC 40    LDY    #$9468
945A: A6 8B          LDA    $3,X
945C: 48             ASLA
945D: AD 3E          JSR    [A,Y]
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
9623: 14             XHCF
9624: 61 B4          NEG    [A,X]
9626: C1 14          CMPB   #$96
9628: 6B BE          XDEC   [A,X]
962A: CB 1E          ADDB   #$96
962C: 7A BE DA       DEC    $9652
962F: 1E 70          EXG    PC,Y
9631: B4 D0 14       ANDA   $5296
9634: 43             COMA
9635: B4 E3 14       ANDA   $6196
9638: 49             ROLA
9639: BE E9 1E       LDX    $6196
963C: 58             ASLB
963D: BE F8 1E       LDX    $7096
9640: 52             XNCB
9641: B4 F2 D1       ANDA   $7053
9644: E2 23          SBCB   $1,X
9646: D3 42          ADDD   $C0
9648: 29 7A          BVS    $969C
964A: 48             ASLA
964B: 89 79          ADCA   #$51
964D: E8 89          EORB   $1,X
964F: 77 B4 61       ASR    $9643
9652: D1 82          CMPB   $00
9654: 23 73          BLS    $96A7
9656: 82 83          SBCA   #$01
9658: 7A 28 89       DEC    >$0001
965B: D9 28          ADCB   $00
965D: 29 77          BVS    $965E
965F: 1E 70          EXG    PC,Y
9661: 71 42 83       NEG    $C001
9664: 73 E2 83       COM    $C001
9667: D0 E8          SUBB   $C0
9669: 29 D9          BVS    $96BC
966B: 48             ASLA
966C: 29 D7          BVS    $966D
966E: 1E E9          EXG    inv,X
9670: 71 22 83       NEG    >$0001
9673: D3 22          ADDD   $00
9675: 23 D0          BLS    $96C9
9677: 82 29          SBCA   #$01
9679: 79 88 89       ROL    >$0001
967C: D7 BE          STB    $96
967E: F8 0B BD       EORB   $839F
9681: 92 34          SBCA   $B6
9683: 33 B4          LEAU   [A,X]
9685: B9 16 3A       ADCA   $94B8
9688: 3C BB          CWAI   #$93
968A: 9E 1F          LDX    $97
968C: B7 B5 1A       STA    $9D92
968F: 16 B4 10       LBRA   $2CC4
9692: B4 B6 11       ANDA   $3433
9695: 72 F0 ED       XNC    $726F
9698: 4F             CLRA
9699: 5A             DECB
969A: E9 E5          ADCB   $D,S
969C: 45             LSRA
969D: 4D             TSTA
969E: EC A8          LDD    $0,Y
96A0: 40             NEGA
96A1: 5B             XDECB
96A2: A2 CA          SBCA   $8,U
96A4: 0C 02          INC    $20
96A6: C4 F7          ANDB   #$75
96A8: 42             XNCA
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
98A6: 8E 18 D5       LDX    #$9AFD
98A9: 6E 1E          JMP    [A,X]
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
9AFD: B0 23 11       SUBA   $AB99
9B00: 91 B8          CMPA   $9A
9B02: 6C 15          INC    [E,X]
9B04: BB 8A 19       ADDA   $A89B
9B07: 18             X18
9B08: 82 BF          SBCA   #$97
9B0A: 10 20 BF B2    XLBRA  $32A8
9B0E: 22 15          BHI    $9AAD
9B10: BE 8A 1D       LDX    $A89F
9B13: 1C 88          ANDCC  #$AA
9B15: 86 22          LDA    #$A0
9B17: 2A 8E          BPL    $9ABF
9B19: 8A 22          ORA    #$AA
9B1B: 1F AC          TFR    A,S
9B1D: 89 1D          ADCA   #$95
9B1F: 0E 81          JMP    $A3
9B21: AA 0B 27 A8    ORA    -$5A76,X
9B25: A9 25          ADCA   E,Y
9B27: 0E A5          JMP    $8D
9B29: 89 06          ADCA   #$8E
9B2B: 07 8B          ASR    $A3
9B2D: A8 09          EORA   ,X++
9B2F: 2D A0          BLT    $9AB3
9B31: A1 25          CMPA   E,Y
9B33: 0A AB          DEC    $89
9B35: B3 08 09       SUBD   $8A8B
9B38: BB A8 09       ADDA   $8081
9B3B: 18             X18
9B3C: AA AB          ORA    ,--X
9B3E: 1A 0C          ORCC   #$84
9B40: A7 89          STA    D,Y
9B42: 04 05          LSR    $87
9B44: 8E AF 16       LDX    #$8D94
9B47: 29 A7          BVS    $9AD8
9B49: BE 24 0D       LDX    $AC85
9B4C: 83 83 0F       SUBD   #$AB87
9B4F: 24 8E          BCC    $9AFD
9B51: B6 29 29       LDA    $ABAB
9B54: B4 8E 2E       ANDA   $ACAC
9B57: 29 83          BVS    $9B04
9B59: 83 24 24       SUBD   #$ACAC
9B5C: 84 89          ANDA   #$A1
9B5E: 2B 2B          BMI    $9B03
9B60: 83 87 25       SUBD   #$A5A7
9B63: 25 87          BCS    $9B0A
9B65: 89 2E          ADCA   #$AC
9B67: 2E 83          BGT    $9B14
9B69: 85 26          BITA   #$AE
9B6B: 26 85          BNE    $9B1A
9B6D: 83 23 2D       SUBD   #$ABA5
9B70: 8E 8E 25       LDX    #$ACA7
9B73: 29 89          BVS    $9B20
9B75: 87 2E          XSTA   #$AC
9B77: 2E 8F          BGT    $9B20
9B79: 98 39          EORA   $B1
9B7B: 29 9A          BVS    $9B2F
9B7D: 9B 2B          ADDA   $A3
9B7F: 1F 86          TFR    CC,S
9B81: 82 35          SBCA   #$B7
9B83: 24 80          BCC    $9B27
9B85: B5 1F 1E       BITA   $9D9C
9B88: 9D B7          JSR    $9F
9B8A: 16 1F BF       LBRA   $3324
9B8D: B0 1F 1F       SUBA   $9797
9B90: B8 B5 15       EORA   $9797
9B93: 1B             NOP
9B94: B5 B5 19       BITA   $979B
9B97: 29 9C          BVS    $9B4D
9B99: BD 24 3E       JSR    $ACB6
9B9C: 9F 90          STX    $B8
9B9E: 31 1F          LEAY   [E,X]
9BA0: 98 99          EORA   $BB
9BA2: 37 36          PULU   B,X,Y,PC
9BA4: B5 B5 34       BITA   $97B6
9BA7: 35 BF          PULS   CC,D,X,PC
9BA9: 91 1F          CMPA   $97
9BAB: 1F 93          TFR    DP,DP
9BAD: 9D 1F          JSR    $97
9BAF: 1F B5          TFR    B,inv
9BB1: B5 35 15       BITA   $B797
9BB4: B5 B5 15       BITA   $9797
9BB7: 15             XHCF
9BB8: 9D BF          JSR    $97
9BBA: 1F 1F          TFR    B,inv
9BBC: BF BF 1F       STX    $9797
9BBF: 1F B5          TFR    B,inv
9BC1: BE D3 1E       LDX    $519C
9BC4: 80 BE          SUBA   #$9C
9BC6: 71 1F 6C       NEG    $9D44
9BC9: B5 1D 15       BITA   $959D
9BCC: CE B6 BF       LDU    #$9E37
9BCF: 16 AA BC       LBRA   $2470
9BD2: 5B             XDECB
9BD3: 1D             SEX
9BD4: 08 BD          ASL    $9F
9BD6: F9 1D E4       ADCB   $9FCC
9BD9: 88 95          EORA   #$1D
9BDB: 28 46          BVC    $9C4B
9BDD: 88 37          EORA   #$BF
9BDF: 29 32          BVS    $9BF1
9BE1: B9 73 19       ADCA   $F19B
9BE4: DF BE          STU    $9C
9BE6: 8B 1E          ADDA   #$9C
9BE8: 3D             MUL
9BE9: B4 A9 14       ANDA   $219C
9BEC: 05 B4          LSR    $9C
9BEE: B1 14 67       CMPA   $9C45
9BF1: BF 28 EE       STX    $AA6C
9BF4: 99 E5          ADCA   $C7
9BF6: CF 1F 82       XSTU   #$9DAA
9BF9: 06 08          ROR    $80
9BFB: 04 65          LSR    $4D
9BFD: 8B 38          ADDA   #$B0
9BFF: E2 99          SBCB   [D,Y]
9C01: E5 C5          BITB   $7,U
9C03: 15             XHCF
9C04: 86 12          LDA    #$30
9C06: 02 0E          XNC    $8C
9C08: 7B 81 3E       XDEC   $A9B6
9C0B: E1 92          CMPB   [F,Y]
9C0D: EE C8          LDU    $0,U
9C0F: 19             DAA
9C10: BC 13 03       CMPX   $3181
9C13: 0F 7B          CLR    $59
9C15: 92 3E          SBCA   $BC
9C17: E5 90 EC       BITB   [-$3C,Y]
9C1A: B3 03 BF       SUBD   $8B97
9C1D: 1B             NOP
9C1E: 0B 07          XDEC   $8F
9C20: 42             XNCA
9C21: 91 3D          CMPA   $BF
9C23: E6 91          LDB    [,--Y]
9C25: 9D B4          JSR    $36
9C27: 0A BC          DEC    $94
9C29: 1E 00          EXG    A,A
9C2B: 1C 4C          ANDCC  #$64
9C2D: 90 4C          SUBA   $C4
9C2F: D7 92          STB    $B0
9C31: 9E B1          LDX    $33
9C33: 01 AD          NEG    $8F
9C35: 19             DAA
9C36: 09 15          ROL    $97
9C38: 4F             CLRA
9C39: 92 4E          SBCA   $C6
9C3B: D1 81          CMPB   $A9
9C3D: 9E B9          LDX    $31
9C3F: 09 AF          ROL    $8D
9C41: 63 13          COM    [,X++]
9C43: 1C 4B          ANDCC  #$69
9C45: 99 45          ADCA   $C7
9C47: D1 8B          CMPB   $A3
9C49: 98 B8          EORA   $30
9C4B: 08 A4          ASL    $8C
9C4D: 6F 1F          CLR    [E,X]
9C4F: 2C 48          BGE    $9CBB
9C51: A2 40          SBCA   ,-U
9C53: 02 A2          XNC    $80
9C55: 65 02          LSR    ,X+
9C57: DC A8          LDD    $80
9C59: A8 08          EORA   ,X+
9C5B: 08 A8          ASL    $80
9C5D: A8 89          EORA   $1,X
9C5F: 08 A2          ASL    $80
9C61: A2 02          SBCA   ,X+
9C63: 02 A2          XNC    $80
9C65: A2 02          SBCA   ,X+
9C67: 8E A8 A8       LDX    #$8080
9C6A: 08 08          ASL    $80
9C6C: 28 A8          BVC    $9BEE
9C6E: 08 08          ASL    $80
9C70: 67 A2          ASR    ,X+
9C72: 02 02          XNC    $80
9C74: 22 0F          BHI    $9CA3
9C76: 88 C1          EORA   #$43
9C78: 6C 23          INC    $B,X
9C7A: CC CB 22       LDD    #$430A
9C7D: 05 88          LSR    $00
9C7F: 08 A2          ASL    $80
9C81: A2 C7          SBCA   $5,U
9C83: 02 A2          XNC    $80
9C85: A2 82          SBCA   $0,X
9C87: 02 A8          XNC    $80
9C89: A8 08          EORA   ,X+
9C8B: 84 A8          ANDA   #$80
9C8D: A8 08          EORA   ,X+
9C8F: 08 A2          ASL    $80
9C91: A2 02          SBCA   ,X+
9C93: 02 23          XNC    $01
9C95: A2 02          SBCA   ,X+
9C97: 02 A8          XNC    $80
9C99: A8 08          EORA   ,X+
9C9B: 08 A8          ASL    $80
9C9D: 6F 08          CLR    ,X+
9C9F: D3 78          ADDD   $5A
9CA1: A2 82          SBCA   $0,X
9CA3: 22 22          BHI    $9CA5
9CA5: 22 22          BHI    $9C47
9CA7: 82 A8          SBCA   #$80
9CA9: 28 88          BVC    $9CAB
9CAB: 88 28          EORA   #$00
9CAD: 28 88          BVC    $9CAF
9CAF: 28 22          BVC    $9CB1
9CB1: 22 82          BHI    $9CB3
9CB3: 82 22          SBCA   #$00
9CB5: 22 82          BHI    $9CB7
9CB7: 82 88          SBCA   #$A0
9CB9: 28 88          BVC    $9CBB
9CBB: 88 28          EORA   #$00
9CBD: C8 88          EORB   #$00
9CBF: 88 22          EORA   #$00
9CC1: 82 82          SBCA   #$00
9CC3: 82 22          SBCA   #$00
9CC5: 82 42          SBCA   #$C0
9CC7: 42             XNCA
9CC8: E8 E8          EORB   ,U+
9CCA: 08 08          ASL    $80
9CCC: A8 A8          EORA   ,X+
9CCE: 08 48          ASL    $C0
9CD0: 22 22          BHI    $9CD2
9CD2: 82 02          SBCA   #$80
9CD4: 22 22          BHI    $9CD6
9CD6: 82 02          SBCA   #$80
9CD8: 28 28          BVC    $9CDA
9CDA: 88 88          EORA   #$00
9CDC: A8 28          EORA   $0,X
9CDE: 88 88          EORA   #$00
9CE0: 22 22          BHI    $9CE2
9CE2: 82 82          SBCA   #$00
9CE4: 22 A2          BHI    $9C66
9CE6: 82 82          SBCA   #$00
9CE8: 28 28          BVC    $9CEA
9CEA: 88 88          EORA   #$00
9CEC: 28 28          BVC    $9CEE
9CEE: 08 88          ASL    $00
9CF0: A2 A2          SBCA   ,X+
9CF2: 82 02          SBCA   #$80
9CF4: E0 A2          SUBB   ,X+
9CF6: 02 84          XNC    $06
9CF8: 2F 76          BLE    $9D58
9CFA: 08 08          ASL    $80
9CFC: A8 A8          EORA   ,X+
9CFE: 08 08          ASL    $80
9D00: 34 3B          PSHS   X,DP,CC
9D02: 02 02          XNC    $80
9D04: A2 27          SBCA   $5,X
9D06: 02 02          XNC    $80
9D08: A8 3D          EORA   -$B,X
9D0A: 90 08          SUBA   $80
9D0C: A8 A8          EORA   ,X+
9D0E: 8C 99 30       CMPX   #$1112
9D11: 31 96          LEAY   -$C,X
9D13: 95 A2          BITA   $80
9D15: A2 02          SBCA   ,X+
9D17: 81 25          CMPA   #$0D
9D19: 26 87          BNE    $9D2A
9D1B: 98 27          EORA   $0F
9D1D: 26 85          BNE    $9D2C
9D1F: 8B A2          ADDA   #$80
9D21: A2 02          SBCA   ,X+
9D23: 95 36          BITA   $14
9D25: 31 90          LEAY   -$E,X
9D27: 93 2C          SUBD   $04
9D29: A8 08          EORA   ,X+
9D2B: 08 30          ASL    $18
9D2D: 3D             MUL
9D2E: 08 08          ASL    $80
9D30: A2 27          SBCA   $5,X
9D32: 02 02          XNC    $80
9D34: A2 3B          SBCA   -$7,X
9D36: 94 02          ANDA   $80
9D38: A8 A8          EORA   ,X+
9D3A: 08 08          ASL    $80
9D3C: A8 A8          EORA   ,X+
9D3E: 8F 8E A2       XSTX   #$0680
9D41: 79 D8 02       ROL    $5A80
9D44: 22 82          BHI    $9CE6
9D46: 82 82          SBCA   #$00
9D48: C8 C8          EORB   #$E0
9D4A: 08 88          ASL    $00
9D4C: 28 28          BVC    $9D4E
9D4E: 88 88          EORA   #$00
9D50: 22 C2          BHI    $9D32
9D52: 62 82          XNC    $0,X
9D54: 22 22          BHI    $9D56
9D56: 62 82          XNC    $0,X
9D58: 28 28          BVC    $9D5A
9D5A: 68 68          ASL    ,S+
9D5C: 28 28          BVC    $9D5E
9D5E: 88 68          EORA   #$E0
9D60: C2 C2          SBCB   #$E0
9D62: 62 62          XNC    ,S+
9D64: C2 22          SBCB   #$00
9D66: 82 82          SBCA   #$00
9D68: C8 C8          EORB   #$E0
9D6A: 68 68          ASL    ,S+
9D6C: A8 A8          EORA   ,X+
9D6E: 08 08          ASL    $80
9D70: A2 22          SBCA   $0,X
9D72: 82 82          SBCA   #$00
9D74: A2 A2          SBCA   ,X+
9D76: 02 02          XNC    $80
9D78: A8 A8          EORA   ,X+
9D7A: 88 88          EORA   #$00
9D7C: 28 A8          BVC    $9CFE
9D7E: 08 88          ASL    $00
9D80: 22 22          BHI    $9D82
9D82: 02 82          XNC    $00
9D84: 22 22          BHI    $9D86
9D86: 02 02          XNC    $80
9D88: 28 28          BVC    $9D8A
9D8A: 88 88          EORA   #$00
9D8C: 28 28          BVC    $9D8E
9D8E: 88 08          EORA   #$80
9D90: A2 22          SBCA   $0,X
9D92: 02 02          XNC    $80
9D94: 22 A2          BHI    $9D16
9D96: 40             NEGA
9D97: 02 A8          XNC    $80
9D99: A8 B2          EORA   -$6,Y
9D9B: E9 A8          ADCB   ,X+
9D9D: A8 08          EORA   ,X+
9D9F: 08 A2          ASL    $80
9DA1: A2 02          SBCA   ,X+
9DA3: A0 07          SUBA   $5,Y
9DA5: A2 02          SBCA   ,X+
9DA7: 8B 78          ADDA   #$50
9DA9: A8 08          EORA   ,X+
9DAB: A9 0C          ADCA   $4,Y
9DAD: A8 08          EORA   ,X+
9DAF: 08 2A          ASL    $08
9DB1: 38 99          XANDCC #$1B
9DB3: 9C 02          CMPX   $20
9DB5: 01 02          NEG    $80
9DB7: 02 A8          XNC    $80
9DB9: A8 08          EORA   ,X+
9DBB: 94 35          ANDA   $1D
9DBD: 37 95          PULU   CC,B,DP,X
9DBF: 94 A2          ANDA   $80
9DC1: A2 02          SBCA   ,X+
9DC3: 02 A2          XNC    $80
9DC5: 01 A2          NEG    $20
9DC7: 9C 33          CMPX   $1B
9DC9: 32 80          LEAS   $8,X
9DCB: 08 A8          ASL    $80
9DCD: A8 AC          EORA   $4,Y
9DCF: A9 A2          ADCA   ,X+
9DD1: A2 D2          SBCA   -$10,U
9DD3: 8B A2          ADDA   #$80
9DD5: A2 A7          SBCA   $5,Y
9DD7: A0 A8          SUBA   ,X+
9DD9: A8 08          EORA   ,X+
9DDB: 08 A8          ASL    $80
9DDD: A8 08          EORA   ,X+
9DDF: B3 18 A2       SUBD   $3A80
9DE2: 02 D9          XNC    $5B
9DE4: 78 A2 82       ASL    watchdog_8000
9DE7: 22 28          BHI    $9DE9
9DE9: 28 88          BVC    $9DEB
9DEB: 68 A8          ASL    ,X+
9DED: 28 88          BVC    $9DEF
9DEF: 88 22          EORA   #$00
9DF1: 22 82          BHI    $9DF3
9DF3: 82 C2          SBCA   #$E0
9DF5: C2 82          SBCB   #$00
9DF7: 82 C8          SBCA   #$E0
9DF9: C8 88          EORB   #$00
9DFB: 88 C8          EORA   #$E0
9DFD: C8 88          EORB   #$00
9DFF: 88 22          EORA   #$00
9E01: C2 62          SBCB   #$E0
9E03: 62 C2          XNC    ,S+
9E05: C2 62          SBCB   #$E0
9E07: 82 28          SBCA   #$00
9E09: 28 88          BVC    $9E0B
9E0B: 88 C8          EORA   #$E0
9E0D: C8 08          EORB   #$80
9E0F: 08 A2          ASL    $80
9E11: 22 82          BHI    $9E13
9E13: 82 22          SBCA   #$00
9E15: 22 02          BHI    $9D97
9E17: 02 A8          XNC    $80
9E19: A8 08          EORA   ,X+
9E1B: 08 28          ASL    $00
9E1D: 28 88          BVC    $9E1F
9E1F: 08 A2          ASL    $80
9E21: 22 82          BHI    $9E23
9E23: 02 A2          XNC    $80
9E25: 22 82          BHI    $9E27
9E27: 02 A8          XNC    $80
9E29: 28 88          BVC    $9E2B
9E2B: 88 28          EORA   #$00
9E2D: 28 88          BVC    $9E2F
9E2F: 88 A2          EORA   #$80
9E31: A2 82          SBCA   $0,X
9E33: 82 A2          SBCA   #$80
9E35: A2 82          SBCA   $0,X
9E37: 02 EA          XNC    $C2
9E39: A8 08          EORA   ,X+
9E3B: 08 A8          ASL    $80
9E3D: 48             ASLA
9E3E: C8 08          EORB   #$80
9E40: 1F 1C          TFR    U,inv
9E42: 02 02          XNC    $80
9E44: A2 14          SBCA   -$A,Y
9E46: BB C3 A8       ADDA   $4180
9E49: 14             XHCF
9E4A: B9 BA A8       ADCA   $3280
9E4D: A8 BD          EORA   -$B,Y
9E4F: B0 A2 A2       SUBA   $8080
9E52: 02 D3          XNC    $51
9E54: 12             NOP
9E55: 0D B6          TST    $34
9E57: B5 A8 A8       BITA   $8080
9E5A: 08 08          ASL    $80
9E5C: A8 A8          EORA   ,X+
9E5E: AE BB          LDX    -$D,Y
9E60: 04 A2          LSR    $80
9E62: 02 02          XNC    $80
9E64: A2 A2          SBCA   ,X+
9E66: 02 B5          XNC    $37
9E68: 1C 07          ANDCC  #$2F
9E6A: B8 D9 A8       EORA   $5180
9E6D: A8 08          EORA   ,X+
9E6F: B0 17 A2       SUBA   $3580
9E72: 02 B0          XNC    $32
9E74: 13             SYNC
9E75: 1E 02          EXG    A,D
9E77: C3 11 1E       ADDD   #$3936
9E7A: 08 08          ASL    $80
9E7C: A8 16          EORA   -$2,Y
9E7E: B5 08 62       BITA   $8040
9E81: 1D             SEX
9E82: 02 02          XNC    $80
9E84: A2 79          SBCA   -$5,U
9E86: D8 02          EORB   $80
9E88: 28 88          BVC    $9E2A
9E8A: 88 88          EORA   #$00
9E8C: 28 28          BVC    $9E8E
9E8E: 08 68          ASL    $E0
9E90: 22 C2          BHI    $9E72
9E92: 62 82          XNC    $0,X
9E94: 22 22          BHI    $9E96
9E96: 62 62          XNC    ,S+
9E98: C8 28          EORB   #$00
9E9A: 68 68          ASL    ,S+
9E9C: C8 28          EORB   #$00
9E9E: 88 68          EORA   #$E0
9EA0: C2 22          SBCB   #$00
9EA2: 82 82          SBCA   #$00
9EA4: C2 C2          SBCB   #$E0
9EA6: 62 62          XNC    ,S+
9EA8: C8 28          EORB   #$00
9EAA: 88 88          EORA   #$00
9EAC: 28 28          BVC    $9EAE
9EAE: 88 68          EORA   #$E0
9EB0: A2 A2          SBCA   ,X+
9EB2: 82 82          SBCA   #$00
9EB4: 22 22          BHI    $9EB6
9EB6: 82 82          SBCA   #$00
9EB8: A8 A8          EORA   ,X+
9EBA: 08 08          ASL    $80
9EBC: A8 28          EORA   $0,X
9EBE: 88 88          EORA   #$00
9EC0: A2 A2          SBCA   ,X+
9EC2: 82 82          SBCA   #$00
9EC4: A2 A2          SBCA   ,X+
9EC6: 02 82          XNC    $00
9EC8: A8 A8          EORA   ,X+
9ECA: 08 88          ASL    $00
9ECC: 28 28          BVC    $9ECE
9ECE: 08 08          ASL    $80
9ED0: 22 A2          BHI    $9E52
9ED2: 02 82          XNC    $00
9ED4: 22 22          BHI    $9ED6
9ED6: 02 02          XNC    $80
9ED8: 28 A8          BVC    $9E5A
9EDA: 4A             DECA
9EDB: 08 A8          ASL    $80
9EDD: A8 08          EORA   ,X+
9EDF: D6 A2          LDB    $80
9EE1: A2 02          SBCA   ,X+
9EE3: 80 0C          SUBA   #$2E
9EE5: A2 02          SBCA   ,X+
9EE7: 02 06          XNC    $2E
9EE9: 2A 08          BPL    $9E6B
9EEB: 08 04          ASL    $2C
9EED: 6E CA          JMP    $2,U
9EEF: 08 60          ASL    $42
9EF1: 64 AE          LSR    $C,Y
9EF3: 02 A2          XNC    $80
9EF5: A2 AB          SBCA   $9,Y
9EF7: A8 03          EORA   $B,Y
9EF9: 02 A1          XNC    $29
9EFB: 08 A8          ASL    $80
9EFD: A8 08          EORA   ,X+
9EFF: 08 05          ASL    $27
9F01: 0A A5          DEC    $27
9F03: 02 A2          XNC    $80
9F05: A2 02          SBCA   ,X+
9F07: 02 01          XNC    $29
9F09: 02 A3          XNC    $2B
9F0B: A2 01          SBCA   $9,Y
9F0D: A8 08          EORA   ,X+
9F0F: 08 0E          ASL    $2C
9F11: 64 C0          LSR    $2,U
9F13: 02 60          XNC    $42
9F15: 64 AE          LSR    $C,Y
9F17: 02 A8          XNC    $80
9F19: 2A A6          BPL    $9F49
9F1B: 08 A8          ASL    $80
9F1D: A8 A6          EORA   $E,Y
9F1F: 8A A2          ORA    #$80
9F21: A2 02          SBCA   ,X+
9F23: 02 A2          XNC    $80
9F25: A2 02          SBCA   ,X+
9F27: D9 72          ADCB   $5A
9F29: A8 88          EORA   $0,X
9F2B: 28 28          BVC    $9F2D
9F2D: 28 88          BVC    $9F2F
9F2F: 88 A2          EORA   #$80
9F31: 22 82          BHI    $9F33
9F33: 82 C2          SBCA   #$E0
9F35: C2 82          SBCB   #$00
9F37: 82 28          SBCA   #$00
9F39: 88 28          EORA   #$A0
9F3B: 88 28          EORA   #$00
9F3D: C8 68          EORB   #$E0
9F3F: 68 22          ASL    $0,X
9F41: 82 22          SBCA   #$A0
9F43: 22 22          BHI    $9F45
9F45: 22 82          BHI    $9F47
9F47: 62 C8          XNC    ,S+
9F49: C8 28          EORB   #$A0
9F4B: 28 28          BVC    $9F4D
9F4D: 28 88          BVC    $9F4F
9F4F: 88 22          EORA   #$00
9F51: C2 02          SBCB   #$80
9F53: 02 22          XNC    $00
9F55: 22 82          BHI    $9F57
9F57: 82 28          SBCA   #$00
9F59: E8 48          EORB   ,U+
9F5B: 08 A8          ASL    $80
9F5D: A8 88          EORA   $0,X
9F5F: 88 22          EORA   #$00
9F61: E2 42          SBCB   ,U+
9F63: 42             XNCA
9F64: 22 A2          BHI    $9EE6
9F66: 02 02          XNC    $80
9F68: 28 28          BVC    $9F6A
9F6A: 48             ASLA
9F6B: 48             ASLA
9F6C: 28 28          BVC    $9F6E
9F6E: 88 08          EORA   #$80
9F70: A2 22          SBCA   $0,X
9F72: 82 82          SBCA   #$00
9F74: 22 22          BHI    $9F76
9F76: 82 82          SBCA   #$00
9F78: A8 A8          EORA   ,X+
9F7A: 88 08          EORA   #$80
9F7C: EA 17          ORB    -$1,Y
9F7E: 08 08          ASL    $80
9F80: A2 7C          SBCA   -$2,U
9F82: 02 02          XNC    $80
9F84: A2 63          SBCA   $1,U
9F86: BB B4 A8       ADDA   $3680
9F89: A8 08          EORA   ,X+
9F8B: B6 15 A8       LDA    $3D80
9F8E: 08 B0          ASL    $38
9F90: 17 A2 02       LBSR   $2013
9F93: B0 13 1E       SUBA   $313C
9F96: 02 02          XNC    $80
9F98: A8 1F          EORA   -$9,Y
9F9A: BC A7 18       CMPX   $2F30
9F9D: 79 08 08       ROL    $8080
9FA0: A2 A2          SBCA   ,X+
9FA2: A4 B1          ANDA   -$D,Y
9FA4: 04 A2          LSR    $80
9FA6: 02 02          XNC    $80
9FA8: A8 79          EORA   -$F,U
9FAA: B8 A7 1C       EORA   $2F34
9FAD: 1F 08          TFR    A,D
9FAF: 08 A2          ASL    $80
9FB1: 1E B3          EXG    U,X
9FB3: B0 A2 A2       SUBA   $8080
9FB6: B7 BA A8       STA    $3880
9FB9: A8 B5          EORA   -$3,Y
9FBB: B6 A8 A8       LDA    $8080
9FBE: 08 BE          ASL    $36
9FC0: 1B             NOP
9FC1: 63 02          COM    ,X+
9FC3: 02 A2          XNC    $80
9FC5: A2 02          SBCA   ,X+
9FC7: 02 A8          XNC    $80
9FC9: 74 D2 08       LSR    $5A80
9FCC: 28 88          BVC    $9F6E
9FCE: 28 88          BVC    $9FD0
9FD0: 22 22          BHI    $9FD2
9FD2: 02 82          XNC    $00
9FD4: 22 22          BHI    $9FD6
9FD6: 22 22          BHI    $9F78
9FD8: 88 28          EORA   #$00
9FDA: 88 88          EORA   #$00
9FDC: 88 88          EORA   #$A0
9FDE: 88 88          EORA   #$00
9FE0: 82 82          SBCA   #$A0
9FE2: 82 82          SBCA   #$00
9FE4: 82 82          SBCA   #$A0
9FE6: 22 82          BHI    $9FE8
9FE8: 28 28          BVC    $9FEA
9FEA: 28 28          BVC    $9F8C
9FEC: 88 88          EORA   #$A0
9FEE: 28 88          BVC    $9FF0
9FF0: 22 22          BHI    $9FF2
9FF2: 82 42          SBCA   #$C0
9FF4: 82 82          SBCA   #$A0
9FF6: 82 82          SBCA   #$00
9FF8: 28 28          BVC    $9FFA
9FFA: 48             ASLA
9FFB: 48             ASLA
9FFC: E8 E8          EORB   ,U+
9FFE: 48             ASLA
9FFF: 88 22          EORA   #$00
A001: 22 42          BHI    $9FC3
A003: 42             XNCA
A004: E2 22          SBCB   $0,X
A006: 82 42          SBCA   #$C0
A008: E8 28          EORB   $0,X
A00A: 88 48          EORA   #$C0
A00C: E8 28          EORB   $0,X
A00E: 88 88          EORA   #$00
A010: E2 E2          SBCB   ,U+
A012: 42             XNCA
A013: 82 22          SBCA   #$00
A015: 22 82          BHI    $A017
A017: 82 28          SBCA   #$00
A019: 28 08          BVC    $9F9B
A01B: 08 28          ASL    $00
A01D: A8 4A          EORA   ,-U
A01F: B3 18 A2       SUBD   $3A80
A022: 02 DC          XNC    $5E
A024: A2 A2          SBCA   ,X+
A026: 02 02          XNC    $80
A028: 0D 0A          TST    $22
A02A: 08 08          ASL    $80
A02C: A8 A8          EORA   ,X+
A02E: 08 08          ASL    $80
A030: A2 A2          SBCA   ,X+
A032: A6 A3          LDA    $1,Y
A034: A2 A2          SBCA   ,X+
A036: D2 8B          SBCB   $09
A038: A8 A8          EORA   ,X+
A03A: 08 AB          ASL    $23
A03C: 08 36          ASL    $1E
A03E: 93 92          SUBD   $1A
A040: 2A A2          BPL    $9FC2
A042: 02 9E          XNC    $1C
A044: 3F             SWI
A045: 3D             MUL
A046: 9F 9E          STX    $1C
A048: A8 A8          EORA   ,X+
A04A: 80 92          SUBA   #$1A
A04C: 33 36          LEAU   -$2,X
A04E: A8 AB          EORA   $3,Y
A050: A2 A2          SBCA   ,X+
A052: 02 8B          XNC    $09
A054: 72 A2 02       XNC    $8080
A057: A3 0C          SUBD   $4,Y
A059: A8 08          EORA   ,X+
A05B: 08 A8          ASL    $80
A05D: A8 08          EORA   ,X+
A05F: 08 A2          ASL    $80
A061: 00 A7          NEG    $25
A063: 02 A2          XNC    $80
A065: A2 02          SBCA   ,X+
A067: 02 A8          XNC    $80
A069: A8 B2          EORA   -$6,Y
A06B: D5 72          BITB   $5A
A06D: A8 88          EORA   $0,X
A06F: 28 82          BVC    $A011
A071: 82 82          SBCA   #$00
A073: 82 A2          SBCA   #$80
A075: 22 82          BHI    $A077
A077: 82 28          SBCA   #$00
A079: 88 28          EORA   #$A0
A07B: 88 28          EORA   #$00
A07D: 28 88          BVC    $A07F
A07F: 88 22          EORA   #$00
A081: 22 82          BHI    $A083
A083: 22 82          BHI    $A025
A085: 22 82          BHI    $A087
A087: 22 88          BHI    $A029
A089: 28 88          BVC    $A08B
A08B: 88 88          EORA   #$A0
A08D: 88 28          EORA   #$A0
A08F: 28 82          BVC    $A031
A091: 82 82          SBCA   #$00
A093: 82 E2          SBCA   #$C0
A095: E2 22          SBCB   ,Y+
A097: 22 88          BHI    $A039
A099: 28 88          BVC    $A09B
A09B: 48             ASLA
A09C: E8 E8          EORB   ,U+
A09E: 48             ASLA
A09F: 48             ASLA
A0A0: E2 22          SBCB   $0,X
A0A2: 82 82          SBCA   #$00
A0A4: E2 E2          SBCB   ,U+
A0A6: 82 82          SBCA   #$00
A0A8: E8 E8          EORB   ,U+
A0AA: 88 88          EORA   #$00
A0AC: 28 28          BVC    $A0AE
A0AE: 88 88          EORA   #$00
A0B0: 22 22          BHI    $A0B2
A0B2: 42             XNCA
A0B3: 42             XNCA
A0B4: 22 22          BHI    $A0B6
A0B6: 82 82          SBCA   #$00
A0B8: 28 28          BVC    $A0BA
A0BA: 88 48          EORA   #$C0
A0BC: A8 A8          EORA   ,X+
A0BE: 88 08          EORA   #$80
A0C0: E0 A2          SUBB   ,X+
A0C2: 85 84          BITA   #$06
A0C4: A2 7C          SBCA   -$2,U
A0C6: 02 02          XNC    $80
A0C8: A8 A8          EORA   ,X+
A0CA: 08 91          ASL    $19
A0CC: 3E             XRES
A0CD: A8 08          EORA   ,X+
A0CF: 08 A2          ASL    $80
A0D1: A2 02          SBCA   ,X+
A0D3: 02 3A          XNC    $18
A0D5: 37 02          PULU   PC
A0D7: 02 A8          XNC    $80
A0D9: 2D 08          BLT    $A05B
A0DB: 08 A8          ASL    $80
A0DD: 3F             SWI
A0DE: 9C 9B          CMPX   $13
A0E0: 30 33          LEAX   -$F,X
A0E2: 86 81          LDA    #$03
A0E4: 2F 2C          BLE    $A0F4
A0E6: 8D 92          BSR    $A0F8
A0E8: 27 26          BEQ    $A0F8
A0EA: 85 8B          BITA   #$03
A0EC: 2C 39          BGE    $A0FF
A0EE: 9A 9B          ORA    $13
A0F0: 36 35          PSHU   X,D,CC
A0F2: 02 02          XNC    $80
A0F4: A2 27          SBCA   $5,X
A0F6: 02 02          XNC    $80
A0F8: A8 3D          EORA   -$B,X
A0FA: 90 08          SUBA   $80
A0FC: A8 A8          EORA   ,X+
A0FE: 08 08          ASL    $80
A100: A2 A2          SBCA   ,X+
A102: 94 9B          ANDA   $19
A104: A2 A2          SBCA   ,X+
A106: 02 02          XNC    $80
A108: A8 A8          EORA   ,X+
A10A: 08 8E          ASL    $06
A10C: 2F 73          BLE    $A169
A10E: D2 08          SBCB   $80
A110: 22 82          BHI    $A0B2
A112: 82 22          SBCA   #$A0
A114: 82 22          SBCA   #$00
A116: 02 82          XNC    $00
A118: 28 28          BVC    $A11A
A11A: 88 88          EORA   #$00
A11C: 88 88          EORA   #$A0
A11E: 88 88          EORA   #$00
A120: 22 22          BHI    $A122
A122: 82 82          SBCA   #$00
A124: 22 82          BHI    $A0C6
A126: 22 82          BHI    $A128
A128: 28 28          BVC    $A12A
A12A: 28 88          BVC    $A12C
A12C: 28 28          BVC    $A12E
A12E: 28 28          BVC    $A0D0
A130: 82 82          SBCA   #$A0
A132: 22 22          BHI    $A0D4
A134: E2 E2          SBCB   ,U+
A136: 42             XNCA
A137: 42             XNCA
A138: 88 88          EORA   #$A0
A13A: 28 28          BVC    $A0DC
A13C: 88 E8          EORA   #$C0
A13E: 48             ASLA
A13F: 48             ASLA
A140: E2 E2          SBCB   ,U+
A142: 42             XNCA
A143: 82 22          SBCA   #$00
A145: 22 42          BHI    $A107
A147: 82 28          SBCA   #$00
A149: 28 48          BVC    $A10B
A14B: 48             ASLA
A14C: 28 28          BVC    $A14E
A14E: 88 88          EORA   #$00
A150: 22 22          BHI    $A152
A152: 82 42          SBCA   #$C0
A154: E2 22          SBCB   $0,X
A156: 82 82          SBCA   #$00
A158: 28 28          BVC    $A15A
A15A: 88 88          EORA   #$00
A15C: E8 E8          EORB   ,U+
A15E: 08 08          ASL    $80
A160: 22 83          BHI    $A103
A162: 21 20          BRN    $A106
A164: 6A 83          DEC    ,Y++
A166: 30 20          LEAX   ,-Y
A168: 4E             XCLRA
A169: 89 49          ADCA   #$C1
A16B: 2A AC          BPL    $A0F1
A16D: 89 58          ADCA   #$D0
A16F: 2A 80          BPL    $A113
A171: 83 5D 20       SUBD   #$DFA2
A174: E2 83          SBCB   ,Y++
A176: 6C 20          INC    ,-Y
A178: F6 89 75       LDB    $A1FD
A17B: 2A D4          BPL    $A179
A17D: 8A 84          ORA    #$0C
A17F: 2B 38          BMI    $A19B
A181: 80 99          SUBA   #$1B
A183: 21 1A          BRN    $A1BD
A185: 80 A8          SUBA   #$2A
A187: 21 7E          BRN    $A1DF
A189: 8A B1          ORA    #$39
A18B: 2B 5C          BMI    $A201
A18D: 8B 1A          ADDA   #$92
A18F: 2B B9          BMI    $A12C
A191: 81 26          CMPA   #$A4
A193: 21 8F          BRN    $A142
A195: 81 34          CMPA   #$B6
A197: 21 97          BRN    $A158
A199: 8B 40          ADDA   #$C8
A19B: 2B F9          BMI    $A16E
A19D: 8B 52          ADDA   #$DA
A19F: 2B C1          BMI    $A184
A1A1: 81 6E          CMPA   #$EC
A1A3: D7 77          STB    $55
A1A5: 76 EB EB       ROR    $6969
A1A8: 7E 41 E1       JMP    $6969
A1AB: E1 7D          CMPB   -$B,U
A1AD: 41             NEGA
A1AE: E1 DD          CMPB   -$B,U
A1B0: 71 71 D7       NEG    $5355
A1B3: D4 70          ANDB   $52
A1B5: 70 EB D1       NEG    $6953
A1B8: 41             NEGA
A1B9: 41             NEGA
A1BA: E1 DB          CMPB   -$D,U
A1BC: 41             NEGA
A1BD: 41             NEGA
A1BE: DE DA          LDU    $52
A1C0: 75 74 D7       LSR    $5655
A1C3: EB 76          ADDB   -$C,U
A1C5: 4B             XDECA
A1C6: EB D6          ADDB   -$C,U
A1C8: 41             NEGA
A1C9: 41             NEGA
A1CA: E1 DB          CMPB   -$D,U
A1CC: 41             NEGA
A1CD: 7D DA DF       TST    $5257
A1D0: 74 76 EB       LSR    $5469
A1D3: D4 4B          ANDB   $69
A1D5: 4B             XDECA
A1D6: D7 EB          STB    $69
A1D8: 41             NEGA
A1D9: 41             NEGA
A1DA: DD E1          STD    $69
A1DC: 7C 41 DB       INC    $6953
A1DF: DC 71          LDD    $53
A1E1: 4B             XDECA
A1E2: D6 EB          LDB    $69
A1E4: 4B             XDECA
A1E5: 70 D0 EB       NEG    $5269
A1E8: 41             NEGA
A1E9: 7D E1 DB       TST    $6953
A1EC: 41             NEGA
A1ED: 7C DC DA       INC    $5452
A1F0: 70 70 D0       NEG    $5252
A1F3: EB 4B          ADDB   $9,S
A1F5: 77 EB EB       ASR    $6969
A1F8: 7B 41 DA       XDEC   $6952
A1FB: DA 7D          ORB    $55
A1FD: 7A DA DB       DEC    $5253
A200: 4B             XDECA
A201: 76 EB EB       ROR    $6969
A204: 76 4B EB       ROR    $6969
A207: EB 7B          ADDB   -$D,U
A209: 41             NEGA
A20A: DB DD          ADDB   $55
A20C: 7A 7A DC       DEC    $5254
A20F: E1 74          CMPB   -$A,U
A211: 4B             XDECA
A212: EB EB          ADDB   $9,S
A214: 71 4B EB       NEG    $6969
A217: D7 41          STB    $69
A219: 7C DE DA       INC    $5652
A21C: 7B 7D E1       XDEC   $5569
A21F: DC 4B          LDD    $69
A221: 4B             XDECA
A222: EB D4          ADDB   -$A,U
A224: 4B             XDECA
A225: 4B             XDECA
A226: D7 EB          STB    $69
A228: 7D 7D DB       TST    $5553
A22B: DB 7E          ADDB   $56
A22D: 41             NEGA
A22E: DA DA          ORB    $52
A230: 4B             XDECA
A231: 4B             XDECA
A232: D1 EB          CMPB   $69
A234: 4B             XDECA
A235: 71 EB D4       NEG    $6956
A238: 7D 7C DC       TST    $5454
A23B: DD 41          STD    $69
A23D: 41             NEGA
A23E: DC E1          LDD    $69
A240: 4B             XDECA
A241: 4B             XDECA
A242: D6 EB          LDB    $69
A244: 4B             XDECA
A245: 71 D7 D6       NEG    $5554
A248: A8 A8          EORA   ,X+
A24A: 48             ASLA
A24B: 08 A8          ASL    $80
A24D: A8 08          EORA   ,X+
A24F: 08 A2          ASL    $80
A251: E2 02          SBCB   ,X+
A253: 02 A2          XNC    $80
A255: E2 42          SBCB   ,U+
A257: 22 88          BHI    $A1F9
A259: C8 28          EORB   #$A0
A25B: 28 88          BVC    $A1FD
A25D: 88 28          EORA   #$A0
A25F: 28 C2          BVC    $A241
A261: 82 22          SBCA   #$A0
A263: 22 C2          BHI    $A245
A265: C2 02          SBCB   #$80
A267: 02 E8          XNC    $C0
A269: A8 08          EORA   ,X+
A26B: 48             ASLA
A26C: A8 A8          EORA   ,X+
A26E: 08 48          ASL    $C0
A270: A2 A2          SBCA   ,X+
A272: 02 42          XNC    $C0
A274: A2 82          SBCA   ,Y+
A276: 22 62          BHI    $A258
A278: 88 88          EORA   #$A0
A27A: 68 28          ASL    ,Y+
A27C: 88 88          EORA   #$A0
A27E: 68 28          ASL    ,Y+
A280: 82 82          SBCA   #$A0
A282: 62 22          XNC    ,Y+
A284: A2 E2          SBCA   ,U+
A286: 02 02          XNC    $80
A288: A8 A8          EORA   ,X+
A28A: 08 08          ASL    $80
A28C: A8 A8          EORA   ,X+
A28E: 08 08          ASL    $80
A290: E2 E2          SBCB   ,U+
A292: 02 22          XNC    $A0
A294: C2 82          SBCB   #$A0
A296: 22 22          BHI    $A238
A298: 88 88          EORA   #$A0
A29A: 28 28          BVC    $A23C
A29C: 88 88          EORA   #$A0
A29E: 28 68          BVC    $A280
A2A0: C2 82          SBCB   #$A0
A2A2: 02 42          XNC    $C0
A2A4: A2 A2          SBCA   ,X+
A2A6: 02 02          XNC    $80
A2A8: E8 A8          EORB   ,X+
A2AA: 08 08          ASL    $80
A2AC: A8 A8          EORA   ,X+
A2AE: 48             ASLA
A2AF: 08 A2          ASL    $80
A2B1: 82 62          SBCA   #$E0
A2B3: 22 82          BHI    $A255
A2B5: 82 22          SBCA   #$A0
A2B7: 62 88          XNC    ,Y+
A2B9: 88 28          EORA   #$A0
A2BB: 28 88          BVC    $A25D
A2BD: C8 28          EORB   #$A0
A2BF: 28 E2          BVC    $A281
A2C1: E2 02          SBCB   ,X+
A2C3: 42             XNCA
A2C4: A2 A2          SBCA   ,X+
A2C6: 42             XNCA
A2C7: 02 A8          XNC    $80
A2C9: A8 48          EORA   ,U+
A2CB: 08 E8          ASL    $C0
A2CD: A8 08          EORA   ,X+
A2CF: 68 C2          ASL    ,S+
A2D1: 82 62          SBCA   #$E0
A2D3: 22 82          BHI    $A275
A2D5: C2 22          SBCB   #$A0
A2D7: 22 88          BHI    $A279
A2D9: C8 28          EORB   #$A0
A2DB: 68 88          ASL    ,Y+
A2DD: 88 48          EORA   #$C0
A2DF: 48             ASLA
A2E0: A2 E2          SBCA   ,U+
A2E2: 02 02          XNC    $80
A2E4: A2 A2          SBCA   ,X+
A2E6: 02 02          XNC    $80
A2E8: E8 A8          EORB   ,X+
A2EA: 48             ASLA
A2EB: 08 A8          ASL    $80
A2ED: C8 68          EORB   #$E0
A2EF: 28 C2          BVC    $A2D1
A2F1: 82 22          SBCA   #$A0
A2F3: 22 82          BHI    $A295
A2F5: 82 22          SBCA   #$A0
A2F7: 62 88          XNC    ,Y+
A2F9: C8 28          EORB   #$A0
A2FB: 28 E8          BVC    $A2BD
A2FD: A8 08          EORA   ,X+
A2FF: 08 A2          ASL    $80
A301: A2 02          SBCA   ,X+
A303: 42             XNCA
A304: A2 A2          SBCA   ,X+
A306: 02 02          XNC    $80
A308: A8 A8          EORA   ,X+
A30A: 08 68          ASL    $E0
A30C: 88 88          EORA   #$A0
A30E: 28 28          BVC    $A2B0
A310: 82 82          SBCA   #$A0
A312: 62 22          XNC    ,Y+
A314: 82 82          SBCA   #$A0
A316: 22 22          BHI    $A2B8
A318: 88 88          EORA   #$A0
A31A: 48             ASLA
A31B: 08 A8          ASL    $80
A31D: A8 08          EORA   ,X+
A31F: 08 A2          ASL    $80
A321: A2 02          SBCA   ,X+
A323: 02 A2          XNC    $80
A325: A2 02          SBCA   ,X+
A327: 02 A8          XNC    $80
A329: C8 28          EORB   #$A0
A32B: 28 88          BVC    $A2CD
A32D: 88 28          EORA   #$A0
A32F: 28 82          BVC    $A2D1
A331: 82 22          SBCA   #$A0
A333: 22 82          BHI    $A2D5
A335: 82 22          SBCA   #$A0
A337: 22 A8          BHI    $A2B9
A339: A8 08          EORA   ,X+
A33B: 08 E8          ASL    $C0
A33D: A8 08          EORA   ,X+
A33F: 08 A2          ASL    $80
A341: A2 02          SBCA   ,X+
A343: 42             XNCA
A344: A2 A2          SBCA   ,X+
A346: 42             XNCA
A347: 22 88          BHI    $A2E9
A349: 88 28          EORA   #$A0
A34B: 68 88          ASL    ,Y+
A34D: 88 28          EORA   #$A0
A34F: 28 82          BVC    $A2F1
A351: 82 62          SBCA   #$E0
A353: 22 82          BHI    $A2F5
A355: C2 02          SBCB   #$80
A357: 02 A8          XNC    $80
A359: A8 48          EORA   ,U+
A35B: 08 A8          ASL    $80
A35D: A8 48          EORA   ,U+
A35F: 08 A2          ASL    $80
A361: E2 02          SBCB   ,X+
A363: 02 E2          XNC    $C0
A365: 82 22          SBCA   #$A0
A367: 22 88          BHI    $A309
A369: C8 28          EORB   #$A0
A36B: 28 88          BVC    $A30D
A36D: C8 28          EORB   #$A0
A36F: 28 C2          BVC    $A351
A371: 82 22          SBCA   #$A0
A373: 62 A2          XNC    ,X+
A375: A2 42          SBCA   ,U+
A377: 02 A8          XNC    $80
A379: A8 08          EORA   ,X+
A37B: 08 A8          ASL    $80
A37D: A8 08          EORA   ,X+
A37F: 08 A2          ASL    $80
A381: E2 42          SBCB   ,U+
A383: 22 82          BHI    $A325
A385: C2 22          SBCB   #$A0
A387: 22 88          BHI    $A329
A389: 88 28          EORA   #$A0
A38B: 28 88          BVC    $A32D
A38D: 88 28          EORA   #$A0
A38F: 28 C2          BVC    $A371
A391: C2 BB          SBCB   #$39
A393: BE 66 6D       LDX    $444F
A396: E7 04          STB    A,X
A398: B4 80 38       ANDA   $A8B0
A39B: B1 14 6D       CMPA   $3C45
A39E: D9 E0          ADCB   $68
A3A0: AA BF 2B 32    ORA    [$4D54,PCR]
A3A4: 1B             NOP
A3A5: 1F C4          TFR    S,inv
A3A7: D1 43          CMPB   $6B
A3A9: A2 16          SBCA   [W,X]
A3AB: 21 98          BRN    $A35D
A3AD: 11 B5 CF 76    BITA   $4754
A3B1: 4C             INCA
A3B2: 0E 1D          JMP    $9F
A3B4: 88 92          EORA   #$B0
A3B6: BB BD 60       ADDA   $3F48
A3B9: 7E F9 06       JMP    $718E
A3BC: 88 83          EORA   #$AB
A3BE: 38 B1          XANDCC #$39
A3C0: 1D             SEX
A3C1: 6B DA          XDEC   -$8,U
A3C3: F6 B2 83       LDB    $90A1
A3C6: 2E 32          BGT    $A378
A3C8: 11 69 C2       ROL    $A,U
A3CB: D2 5F          SBCB   $77
A3CD: BA 2A 24       ORA    $A2AC
A3D0: 92 1B          SBCA   $39
A3D2: C3 C9 7F       ADDD   #$4B5D
A3D5: 58             ASLB
A3D6: 16 21 85       LBRA   $4786
A3D9: 98 B1          EORA   $39
A3DB: CA 64          ORB    #$4C
A3DD: 77 F5 1E       ASR    $7D96
A3E0: 86 8C          LDA    #$AE
A3E2: 32 B8          LEAS   -$6,Y
A3E4: 60 6F          NEG    $D,U
A3E6: E3 02          ADDD   ,X+
A3E8: B0 8D 26       SUBA   $A5AE
A3EB: 38 13          XANDCC #$3B
A3ED: 6B C6          XDEC   $E,U
A3EF: EB A1          ADDB   ,--X
A3F1: B8 24 2D       EORA   $A6AF
A3F4: 92 8E          SBCA   $AC
A3F6: D4 82          ANDB   $00
A3F8: 6D AC          TST    ,X
A3FA: 27 8B          BEQ    $A3FF
A3FC: 7E 8C 88       JMP    $A400
A3FF: 39             RTS
A400: A6 21          LDA    $3,X
A402: 48             ASLA
A403: 10 8E 86 8B    LDY    #$A409
A407: 6E 9E          JMP    [A,Y]
A409: 8C 99 2C       CMPX   #$11A4
A40C: 07 8C          ASR    $A4
A40E: E0 2C          SUBB   ,Y
A410: 0D A6          TST    $84
A412: 8A AB          ORA    #$29
A414: 24 A7          BCC    $A39B
A416: 84 24          ANDA   #$A6
A418: 3B             RTI
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
A433: 10 8E 86 BB    LDY    #$A439
A437: 6E 9E          JMP    [A,Y]
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
A4A2: 26 30          BNE    $A456
A4A4: 86 E5          LDA    #$C7
A4A6: 26 5E          BNE    $A484
A4A8: 8C D9 2D       CMPX   #$F1A5
A4AB: 8E 8D 33       LDX    #$A51B
A4AE: 2D B8          BLT    $A4E0
A4B0: 87 67          XSTA   #$45
A4B2: DB 42          ADDB   $C0
A4B4: 24 78          BCC    $A510
A4B6: 42             XNCA
A4B7: 81 73          CMPA   #$5B
A4B9: E8 8B          EORB   $3,X
A4BB: D4 E8          ANDB   $C0
A4BD: 2E D3          BGT    $A51A
A4BF: 48             ASLA
A4C0: 21 78          BRN    $A51C
A4C2: 42             XNCA
A4C3: 81 DD          CMPA   #$FF
A4C5: 86 30          LDA    #$B2
A4C7: DB E8          ADDB   $C0
A4C9: 2E D2          BGT    $A525
A4CB: 48             ASLA
A4CC: 2B 73          BMI    $A529
A4CE: 48             ASLA
A4CF: 8B 7E          ADDA   #$5C
A4D1: E2 84          SBCB   $6,X
A4D3: D9 E2          ADCB   $C0
A4D5: 21 D8          BRN    $A531
A4D7: 42             XNCA
A4D8: 2B D7          BMI    $A4D9
A4DA: 2C 4F          BGE    $A4A3
A4DC: 71 68 8E       NEG    $4006
A4DF: D2 62          SBCB   $40
A4E1: 21 D9          BRN    $A53E
A4E3: C2 21          SBCB   #$03
A4E5: 7E C2 84       JMP    $4006
A4E8: 73 68 8B       COM    $4003
A4EB: D2 68          SBCB   $40
A4ED: 2B 77          BMI    $A4EE
A4EF: 2C FE          BGE    $A4CD
A4F1: 7B C2 84       XDEC   $4006
A4F4: 78 62 81       ASL    $4003
A4F7: D9 68          ADCB   $40
A4F9: 2B D4          BMI    $A557
A4FB: C8 2E          EORB   #$06
A4FD: 73 C8 8B       COM    $4003
A500: 78 62 81       ASL    $4003
A503: 7D 86 D3       TST    $A4F1
A506: DB 82          ADDB   $00
A508: 2E 72          BGT    $A564
A50A: 88 8B          EORA   #$03
A50C: 73 28 8B       COM    >$0003
A50F: D4 22          ANDB   $00
A511: 24 D9          BCC    $A56E
A513: 82 21          SBCA   #$03
A515: 78 82 81       ASL    >$0003
A518: D7 8D          STB    $A5
A51A: 8E D1 A8       LDX    #$5980
A51D: 2E D2          BGT    $A579
A51F: 08 21          ASL    $03
A521: 79 02 81       ROL    $8003
A524: 7E A2 84       JMP    $8006
A527: D9 A8          ADCB   $80
A529: 2B D2          BMI    $A585
A52B: 08 2B          ASL    $03
A52D: D7 2D          STB    $A5
A52F: 93 7B          SUBD   $59
A531: A2 84          SBCA   $6,X
A533: D8 A2          EORB   $80
A535: 21 D9          BRN    $A592
A537: 02 2B          XNC    $03
A539: 74 08 8E       LSR    $8006
A53C: 73 A8 8B       COM    $8003
A53F: D2 A2          SBCB   $80
A541: 21 7D          BRN    $A542
A543: 27 12          BEQ    $A575
A545: 7B 82 84       XDEC   >$0006
A548: 72 28 8B       XNC    >$0003
A54B: D3 28          ADDD   $00
A54D: 2B D4          BMI    $A5AB
A54F: 88 24          EORA   #$06
A551: 79 82 81       ROL    >$0003
A554: 78 22 81       ASL    >$0003
A557: 7D 8D 6D       TST    $A545
A55A: 2D E2          BLT    $A5C6
A55C: 8D 42          BSR    $A5C8
A55E: 2D E2          BLT    $A5CA
A560: 87 48          XSTA   #$6A
A562: 27 FB          BEQ    $A5DD
A564: 87 5B          XSTA   #$79
A566: 27 FB          BEQ    $A5E1
A568: 8D 51          BSR    $A5E3
A56A: 90 48          SUBA   $C0
A56C: 2C 31          BGE    $A587
A56E: 48             ASLA
A56F: 8C 38 E2       CMPX   #$1AC0
A572: 86 9B          LDA    #$19
A574: 62 26          XNC    $4,X
A576: 7D 27 42       TST    $A56A
A579: 30 88          LEAX   $0,X
A57B: 8C 31 28       CMPX   #$1900
A57E: 8C 92 22       CMPX   #$1A00
A581: 26 9B          BNE    $A59C
A583: 02 26          XNC    $04
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
A7C9: 10 8E 2F F8    LDY    #$A7D0
A7CD: 6E 3D          JMP    [B,Y]
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
AE96: 2C 24          BGE    $AE3E
AE98: 63 11          COM    -$7,Y
AE9A: 26 22          BNE    $AE46
AE9C: 62 F0 26       XNC    [-$52,U]
AE9F: 26 69          BNE    $AEEC
AEA1: 1B             NOP
AEA2: 2C 2C          BGE    $AE52
AEA4: 6B FB 82 81    XDEC   [$0003,U]
AEA8: 2C 2D          BGE    $AEAF
AEAA: 82 8F          SBCA   #$07
AEAC: 20 21          BRA    $AEB7
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
B7BC: CC 28 62       LDD    #$00EA
B7BF: A8 D2          EORA   [,--W]
B7C1: 62 74          XNC    [A,S]
B7C3: E2 C5          SBCB   E,S
B7C5: 32 6F B2 DB    LEAS   $E8BC,PCR
B7C9: 78 71 F8       ASL    $F970
B7CC: 2B 28          BMI    $B7CE
B7CE: 88 88          EORA   #$00
B7D0: 22 24          BHI    $B7D8
B7D2: 86 82          LDA    #$00
B7D4: 22 22          BHI    $B7D6
B7D6: 82 82          SBCA   #$00
B7D8: 28 28          BVC    $B7DA
B7DA: 88 88          EORA   #$00
B7DC: 28 28          BVC    $B7DE
B7DE: 88 88          EORA   #$00
B7E0: 22 22          BHI    $B7E2
B7E2: 82 82          SBCA   #$00
B7E4: 22 22          BHI    $B7E6
B7E6: 82 82          SBCA   #$00
B7E8: 28 28          BVC    $B7EA
B7EA: 88 88          EORA   #$00
B7EC: 29 28          BVS    $B7EE
B7EE: 88 88          EORA   #$00
B7F0: 32 2A          LEAS   $8,X
B7F2: 82 82          SBCA   #$00
B7F4: 8A A8          ORA    #$8A
B7F6: 82 7E          SBCA   #$FC
B7F8: A8 29          EORA   $1,X
B7FA: 88 88          EORA   #$00
B7FC: 28 28          BVC    $B7FE
B7FE: 88 88          EORA   #$00
B800: 22 22          BHI    $B802
B802: 82 82          SBCA   #$00
B804: 22 22          BHI    $B806
B806: 83 83 28       SUBD   #$0100
B809: 28 88          BVC    $B80B
B80B: 88 90          EORA   #$B8
B80D: 0C 32          INC    $BA
B80F: 7C 9F E6       INC    $BDC4
B812: 42             XNCA
B813: 16 E1 46       LBRA   $7B7A
B816: 44             LSRA
B817: B6 E1 2C       LDA    $C904
B81A: 43             COMA
B81B: 5C             INCB
B81C: EB 4C          ADDB   $4,S
B81E: 4E             XCLRA
B81F: BC EB 26       CMPX   $C904
B822: 49             ROLA
B823: 56             RORB
B824: 22 24          BHI    $B82C
B826: 86 8A          LDA    #$08
B828: 14             XHCF
B829: 22 D2          BHI    $B885
B82B: 88 2C          EORA   #$04
B82D: 2C 84          BGE    $B83B
B82F: 84 22          ANDA   #$00
B831: 22 82          BHI    $B833
B833: 82 B2          SBCA   #$90
B835: B0 0C 12       SUBA   $8E90
B838: 80 F0          SUBA   #$D8
B83A: 32 82          LEAS   $A,X
B83C: 28 28          BVC    $B83E
B83E: D8 88          EORB   $00
B840: DD DD          STD    $FF
B842: 7D 7D 23       TST    $FF01
B845: 22 83          BHI    $B848
B847: 82 98          SBCA   #$B0
B849: 30 88          LEAX   $0,X
B84B: 88 A8          EORA   #$80
B84D: A8 88          EORA   $0,X
B84F: 59             ROLB
B850: BC 42 C2       CMPX   $6040
B853: 80 22          SUBA   #$00
B855: 22 82          BHI    $B857
B857: 82 24          SBCA   #$0C
B859: 28 77          BVC    $B85A
B85B: 88 28          EORA   #$00
B85D: 28 88          BVC    $B85F
B85F: 88 23          EORA   #$01
B861: 22 82          BHI    $B863
B863: 82 23          SBCA   #$01
B865: 22 83          BHI    $B868
B867: 82 68          SBCA   #$40
B869: 78 88 88       ASL    >$0000
B86C: A8 A8          EORA   ,X+
B86E: 88 59          EORA   #$D1
B870: BC 42 42       CMPX   $60C0
B873: 82 22          SBCA   #$00
B875: 22 82          BHI    $B877
B877: 82 24          SBCA   #$0C
B879: 28 77          BVC    $B87A
B87B: 88 28          EORA   #$00
B87D: 28 88          BVC    $B87F
B87F: 88 27          EORA   #$05
B881: 22 82          BHI    $B883
B883: 82 23          SBCA   #$01
B885: 22 82          BHI    $B887
B887: 82 E8          SBCA   #$C0
B889: 48             ASLA
B88A: 88 88          EORA   #$00
B88C: A8 A8          EORA   ,X+
B88E: 88 46          EORA   #$CE
B890: D4 42          ANDB   $60
B892: C2 80          SBCB   #$02
B894: 22 22          BHI    $B896
B896: 82 82          SBCA   #$00
B898: 24 28          BCC    $B89A
B89A: 77 88 28       ASR    >$0000
B89D: 28 88          BVC    $B89F
B89F: 88 24          EORA   #$06
B8A1: 22 82          BHI    $B8A3
B8A3: 82 23          SBCA   #$01
B8A5: 22 82          BHI    $B8A7
B8A7: 82 E8          SBCA   #$C0
B8A9: 80 88          SUBA   #$00
B8AB: 88 A8          EORA   #$80
B8AD: A8 88          EORA   $0,X
B8AF: 46             RORA
B8B0: D4 42          ANDB   $60
B8B2: 42             XNCA
B8B3: 82 22          SBCA   #$00
B8B5: 22 82          BHI    $B8B7
B8B7: 82 24          SBCA   #$0C
B8B9: 28 77          BVC    $B8BA
B8BB: 88 28          EORA   #$00
B8BD: 28 88          BVC    $B8BF
B8BF: 88 2E          EORA   #$0C
B8C1: 22 82          BHI    $B8C3
B8C3: 82 23          SBCA   #$01
B8C5: 22 82          BHI    $B8C7
B8C7: 82 30          SBCA   #$18
B8C9: 90 88          SUBA   $00
B8CB: 88 A8          EORA   #$80
B8CD: A8 88          EORA   $0,X
B8CF: 46             RORA
B8D0: D4 42          ANDB   $60
B8D2: 42             XNCA
B8D3: 82 22          SBCA   #$00
B8D5: 22 82          BHI    $B8D7
B8D7: 82 24          SBCA   #$0C
B8D9: 28 77          BVC    $B8DA
B8DB: 88 28          EORA   #$00
B8DD: 28 88          BVC    $B8DF
B8DF: 88 2F          EORA   #$0D
B8E1: 22 82          BHI    $B8E3
B8E3: 82 22          SBCA   #$00
B8E5: 22 82          BHI    $B8E7
B8E7: 82 28          SBCA   #$00
B8E9: 28 88          BVC    $B8EB
B8EB: 88 A8          EORA   #$80
B8ED: A8 88          EORA   $0,X
B8EF: 46             RORA
B8F0: D4 42          ANDB   $60
B8F2: 42             XNCA
B8F3: 82 22          SBCA   #$00
B8F5: 22 82          BHI    $B8F7
B8F7: 82 24          SBCA   #$0C
B8F9: 28 77          BVC    $B8FA
B8FB: 88 28          EORA   #$00
B8FD: 28 88          BVC    $B8FF
B8FF: 88 22          EORA   #$00
B901: 22 82          BHI    $B903
B903: 82 23          SBCA   #$01
B905: 22 CE          BHI    $B953
B907: 48             ASLA
B908: 04 78          LSR    $50
B90A: D4 25          ANDB   $AD
B90C: A9 08          ADCA   $0,Y
B90E: 88 88          EORA   #$00
B910: 22 22          BHI    $B912
B912: 82 82          SBCA   #$00
B914: 20 22          BRA    $B916
B916: CE D1 24       LDU    #$530C
B919: B0 D4 25       SUBA   $5CAD
B91C: 46             RORA
B91D: 08 88          ASL    $00
B91F: 88 22          EORA   #$00
B921: 22 82          BHI    $B923
B923: 82 20          SBCA   #$02
B925: 22 CD          BHI    $B976
B927: C1 E4          CMPB   #$CC
B929: 30 D4          LEAX   -$4,U
B92B: 25 85          BCS    $B8DA
B92D: 08 88          ASL    $00
B92F: 88 22          EORA   #$00
B931: 22 82          BHI    $B933
B933: 82 23          SBCA   #$01
B935: 22 CD          BHI    $B986
B937: D3 E4          ADDD   $CC
B939: A0 D4          SUBA   -$4,U
B93B: 25 46          BCS    $B9AB
B93D: 08 88          ASL    $00
B93F: 88 22          EORA   #$00
B941: 22 82          BHI    $B943
B943: 82 23          SBCA   #$01
B945: 28 99          BVC    $B962
B947: 1A 3B          ORCC   #$13
B949: 18             X18
B94A: 88 88          EORA   #$00
B94C: 28 28          BVC    $B94E
B94E: 88 88          EORA   #$00
B950: 22 22          BHI    $B952
B952: 82 82          SBCA   #$00
B954: 23 2E          BLS    $B962
B956: 59             ROLB
B957: 2A 3B          BPL    $B96C
B959: 18             X18
B95A: 88 88          EORA   #$00
B95C: 28 28          BVC    $B95E
B95E: 88 88          EORA   #$00
B960: 22 22          BHI    $B962
B962: 82 82          SBCA   #$00
B964: 23 2E          BLS    $B972
B966: 59             ROLB
B967: 2A FB          BPL    $B93C
B969: 68 88          ASL    $0,X
B96B: 88 28          EORA   #$00
B96D: 28 88          BVC    $B96F
B96F: 88 22          EORA   #$00
B971: 22 82          BHI    $B973
B973: 82 22          SBCA   #$00
B975: 22 59          BHI    $B952
B977: 2A F3          BPL    $B954
B979: 08 88          ASL    $00
B97B: 88 28          EORA   #$00
B97D: 28 88          BVC    $B97F
B97F: 88 22          EORA   #$00
B981: 22 82          BHI    $B983
B983: 82 22          SBCA   #$00
B985: 22 82          BHI    $B987
B987: 82 28          SBCA   #$00
B989: E8 88          EORB   $0,X
B98B: 88 A8          EORA   #$80
B98D: A8 88          EORA   $0,X
B98F: 1E 01          EXG    Y,U
B991: 22 82          BHI    $B993
B993: 82 22          SBCA   #$00
B995: 22 82          BHI    $B997
B997: 82 D7          SBCA   #$FF
B999: 28 89          BVC    $B99C
B99B: 88 D7          EORA   #$FF
B99D: 28 89          BVC    $B9A0
B99F: 88 22          EORA   #$00
B9A1: 22 82          BHI    $B9A3
B9A3: 82 22          SBCA   #$00
B9A5: 22 82          BHI    $B9A7
B9A7: 82 38          SBCA   #$10
B9A9: 20 88          BRA    $B9AB
B9AB: 88 D7          EORA   #$FF
B9AD: 6D 89          TST    $1,X
B9AF: 0E 5F          JMP    $7D
B9B1: 42             XNCA
B9B2: 82 82          SBCA   #$00
B9B4: 22 22          BHI    $B9B6
B9B6: 82 82          SBCA   #$00
B9B8: D7 D7          STB    $FF
B9BA: 88 88          EORA   #$00
B9BC: D7 D7          STB    $FF
B9BE: 77 77 DD       ASR    $FFFF
B9C1: DD 7D          STD    $FF
B9C3: 7D 23 22       TST    $0100
B9C6: 82 82          SBCA   #$00
B9C8: 38 F8          XANDCC #$D0
B9CA: 88 88          EORA   #$00
B9CC: 88 88          EORA   #$A0
B9CE: 88 2C          EORA   #$A4
B9D0: 80 22          SUBA   #$00
B9D2: 82 82          SBCA   #$00
B9D4: 22 22          BHI    $B9D6
B9D6: 82 82          SBCA   #$00
B9D8: 28 28          BVC    $B9DA
B9DA: 88 88          EORA   #$00
B9DC: 28 28          BVC    $B9DE
B9DE: 88 88          EORA   #$00
B9E0: 22 22          BHI    $B9E2
B9E2: 82 82          SBCA   #$00
B9E4: 22 22          BHI    $B9E6
B9E6: 82 82          SBCA   #$00
B9E8: 28 28          BVC    $B9EA
B9EA: 88 88          EORA   #$00
B9EC: 28 28          BVC    $B9EE
B9EE: 88 88          EORA   #$00
B9F0: 22 22          BHI    $B9F2
B9F2: 82 82          SBCA   #$00
B9F4: 22 22          BHI    $B9F6
B9F6: 82 82          SBCA   #$00
B9F8: 28 28          BVC    $B9FA
B9FA: 88 88          EORA   #$00
B9FC: 28 28          BVC    $B9FE
B9FE: 88 88          EORA   #$00
BA00: 22 22          BHI    $BA02
BA02: 82 82          SBCA   #$00
BA04: 22 22          BHI    $BA06
BA06: 82 82          SBCA   #$00
BA08: 28 28          BVC    $BA0A
BA0A: 88 88          EORA   #$00
BA0C: 28 28          BVC    $BA0E
BA0E: 88 88          EORA   #$00
BA10: 22 22          BHI    $BA12
BA12: 82 82          SBCA   #$00
BA14: 22 22          BHI    $BA16
BA16: 82 82          SBCA   #$00
BA18: 28 28          BVC    $BA1A
BA1A: 88 88          EORA   #$00
BA1C: 28 28          BVC    $BA1E
BA1E: 88 88          EORA   #$00
BA20: 22 22          BHI    $BA22
BA22: 82 82          SBCA   #$00
BA24: 23 22          BLS    $BA26
BA26: E7 8A          STB    $8,X
BA28: 29 B2          BVS    $B9C4
BA2A: 77 90 29       ASR    $1801
BA2D: 50             NEGB
BA2E: 1F A0          TFR    Y,A
BA30: 23 22          BLS    $BA32
BA32: EF B2          STU    -$10,Y
BA34: 23 B8          BLS    $B9D0
BA36: 7D C2 29       TST    $4001
BA39: 28 ED          BVC    $BAA0
BA3B: D8 29          EORB   $01
BA3D: B2 77 E8       SBCA   $FF60
BA40: 23 5A          BLS    $BABA
BA42: 15             XHCF
BA43: F2 23 22       SBCB   $0100
BA46: DF F2          STU    $70
BA48: 29 BA          BVS    $B9DC
BA4A: 77 00 29       ASR    $8801
BA4D: 28 E5          BVC    $BABC
BA4F: 10 23 A2 1C    LBLS   $3AF1
BA53: 22 23          BHI    $BA56
BA55: 88 7D          EORA   #$FF
BA57: 2A 29          BPL    $BA5A
BA59: 28 E5          BVC    $BAC8
BA5B: 30 29          LEAX   $1,X
BA5D: 8A 77          ORA    #$FF
BA5F: 40             NEGA
BA60: 23 22          BLS    $BA62
BA62: D4 62          ANDB   $E0
BA64: 23 9E          BLS    $BA22
BA66: 7D 62 28       TST    $E000
BA69: 28 88          BVC    $BA6B
BA6B: 88 28          EORA   #$00
BA6D: 28 88          BVC    $BA6F
BA6F: 88 22          EORA   #$00
BA71: 22 82          BHI    $BA73
BA73: 82 22          SBCA   #$00
BA75: 22 82          BHI    $BA77
BA77: 82 28          SBCA   #$00
BA79: 28 88          BVC    $BA7B
BA7B: 88 28          EORA   #$00
BA7D: 28 88          BVC    $BA7F
BA7F: 88 22          EORA   #$00
BA81: 22 82          BHI    $BA83
BA83: 82 23          SBCA   #$01
BA85: 9F C2          STX    $40
BA87: B2 29 6C       SBCA   $0144
BA8A: D8 CC          EORB   $44
BA8C: 29 85          BVS    $BA3B
BA8E: E8 DC          EORB   -$C,U
BA90: 23 1E          BLS    $BACE
BA92: F2 E6 23       SBCB   $6401
BA95: EF 0A FA       STU    $78,X
BA98: 29 6C          BVS    $BADE
BA9A: 10 00 29       NEG    $01
BA9D: 95 20          BITA   $A8
BA9F: 14             XHCF
BAA0: 23 16          BLS    $BAD6
BAA2: 3A             ABX
BAA3: 2E 22          BGT    $BAA5
BAA5: 22 82          BHI    $BAA7
BAA7: 82 28          SBCA   #$00
BAA9: 28 88          BVC    $BAAB
BAAB: 88 28          EORA   #$00
BAAD: 28 88          BVC    $BAAF
BAAF: 88 22          EORA   #$00
BAB1: 22 82          BHI    $BAB3
BAB3: 82 22          SBCA   #$00
BAB5: 22 82          BHI    $BAB7
BAB7: 82 28          SBCA   #$00
BAB9: 28 88          BVC    $BABB
BABB: 88 28          EORA   #$00
BABD: 28 88          BVC    $BABF
BABF: 88 22          EORA   #$00
BAC1: 22 82          BHI    $BAC3
BAC3: 82 1A          SBCA   #$38
BAC5: 22 4A          BHI    $BA8F
BAC7: 82 28          SBCA   #$00
BAC9: 28 A0          BVC    $BAF3
BACB: B0 90 E0       SUBA   $B8C8
BACE: A0 A0          SUBA   $8,Y
BAD0: 94 9A          ANDA   $B8
BAD2: 82 82          SBCA   #$00
BAD4: 16 0A 5A       LBRA   $E3AF
BAD7: 34 68          PSHS   U
BAD9: 1C 88          ANDCC  #$00
BADB: 88 E0          EORA   #$C8
BADD: F0 88 C8       SUBB   >$0040
BAE0: 22 EA          BHI    $BAAA
BAE2: 82 82          SBCA   #$00
BAE4: 22 22          BHI    $BAE6
BAE6: 82 82          SBCA   #$00
BAE8: 28 28          BVC    $BAEA
BAEA: 88 88          EORA   #$00
BAEC: 28 28          BVC    $BAEE
BAEE: 88 88          EORA   #$00
BAF0: 22 22          BHI    $BAF2
BAF2: 82 82          SBCA   #$00
BAF4: 22 24          BHI    $BAFC
BAF6: 86 8A          LDA    #$08
BAF8: 14             XHCF
BAF9: 20 DD          BRA    $BB50
BAFB: 88 2B          EORA   #$03
BAFD: 2B 84          BMI    $BB0B
BAFF: 84 22          ANDA   #$00
BB01: 22 82          BHI    $BB03
BB03: 82 B4          SBCA   #$96
BB05: B0 16 16       SUBA   $9494
BB08: 98 E0          EORA   $C8
BB0A: 3C 81          CWAI   #$09
BB0C: 28 28          BVC    $BB0E
BB0E: D8 88          EORB   $00
BB10: DD DD          STD    $FF
BB12: 7D 7D 23       TST    $FF01
BB15: 22 83          BHI    $BB18
BB17: 82 90          SBCA   #$B8
BB19: 20 88          BRA    $BB1B
BB1B: 88 A0          EORA   #$88
BB1D: A0 88          SUBA   $0,X
BB1F: 59             ROLB
BB20: BC 42 C2       CMPX   $6040
BB23: 80 22          SUBA   #$00
BB25: 22 82          BHI    $BB27
BB27: 82 24          SBCA   #$0C
BB29: 28 77          BVC    $BB2A
BB2B: 88 28          EORA   #$00
BB2D: 28 88          BVC    $BB2F
BB2F: 88 20          EORA   #$02
BB31: 22 82          BHI    $BB33
BB33: 82 23          SBCA   #$01
BB35: 22 82          BHI    $BB37
BB37: 82 68          SBCA   #$40
BB39: 60 88          NEG    $0,X
BB3B: 88 AE          EORA   #$86
BB3D: AE 88          LDX    $0,X
BB3F: 46             RORA
BB40: D4 42          ANDB   $60
BB42: 42             XNCA
BB43: 82 22          SBCA   #$00
BB45: 22 82          BHI    $BB47
BB47: 82 24          SBCA   #$0C
BB49: 28 77          BVC    $BB4A
BB4B: 88 28          EORA   #$00
BB4D: 28 88          BVC    $BB4F
BB4F: 88 27          EORA   #$05
BB51: 22 82          BHI    $BB53
BB53: 82 23          SBCA   #$01
BB55: 22 83          BHI    $BB58
BB57: 82 A8          SBCA   #$80
BB59: 58             ASLB
BB5A: 88 88          EORA   #$00
BB5C: A0 A0 88       SUBA   $00,X
BB5F: 59             ROLB
BB60: BC 42 42       CMPX   $60C0
BB63: 82 22          SBCA   #$00
BB65: 22 82          BHI    $BB67
BB67: 82 24          SBCA   #$0C
BB69: 28 77          BVC    $BB6A
BB6B: 88 28          EORA   #$00
BB6D: 28 88          BVC    $BB6F
BB6F: 88 2A          EORA   #$08
BB71: 22 82          BHI    $BB73
BB73: 82 23          SBCA   #$01
BB75: 22 83          BHI    $BB78
BB77: 82 98          SBCA   #$B0
BB79: 60 88          NEG    $0,X
BB7B: 88 A0          EORA   #$88
BB7D: A0 88          SUBA   $0,X
BB7F: 59             ROLB
BB80: BC 42 C2       CMPX   $6040
BB83: 80 22          SUBA   #$00
BB85: 22 82          BHI    $BB87
BB87: 82 24          SBCA   #$0C
BB89: 28 77          BVC    $BB8A
BB8B: 88 28          EORA   #$00
BB8D: 28 88          BVC    $BB8F
BB8F: 88 24          EORA   #$06
BB91: 22 82          BHI    $BB93
BB93: 82 23          SBCA   #$01
BB95: 22 82          BHI    $BB97
BB97: 82 40          SBCA   #$68
BB99: 00 88          NEG    $00
BB9B: 88 A0          EORA   #$88
BB9D: A0 88          SUBA   $0,X
BB9F: 46             RORA
BBA0: D4 42          ANDB   $60
BBA2: 42             XNCA
BBA3: 82 22          SBCA   #$00
BBA5: 22 82          BHI    $BBA7
BBA7: 82 24          SBCA   #$0C
BBA9: 28 77          BVC    $BBAA
BBAB: 88 28          EORA   #$00
BBAD: 28 88          BVC    $BBAF
BBAF: 88 21          EORA   #$03
BBB1: 22 82          BHI    $BBB3
BBB3: 82 22          SBCA   #$00
BBB5: 22 83          BHI    $BBB8
BBB7: 82 28          SBCA   #$00
BBB9: 28 88          BVC    $BBBB
BBBB: 88 AC          EORA   #$84
BBBD: A0 88          SUBA   $0,X
BBBF: 59             ROLB
BBC0: BC 42 C2       CMPX   $6040
BBC3: 83 22 22       SUBD   #$0000
BBC6: 82 82          SBCA   #$00
BBC8: 24 28          BCC    $BBCA
BBCA: 77 88 28       ASR    >$0000
BBCD: 28 88          BVC    $BBCF
BBCF: 88 22          EORA   #$00
BBD1: 22 82          BHI    $BBD3
BBD3: 82 23          SBCA   #$01
BBD5: 22 CD          BHI    $BC26
BBD7: 83 94 20       SUBD   #$BC08
BBDA: 98 98          EORA   $10
BBDC: 38 28          XANDCC #$00
BBDE: 88 88          EORA   #$00
BBE0: 22 22          BHI    $BBE2
BBE2: 82 82          SBCA   #$00
BBE4: 20 22          BRA    $BBE6
BBE6: CF 8B 14       XSTU   #$093C
BBE9: 60 98          NEG    -$10,X
BBEB: 98 38          EORA   $10
BBED: 28 88          BVC    $BBEF
BBEF: 88 22          EORA   #$00
BBF1: 22 82          BHI    $BBF3
BBF3: 82 20          SBCA   #$02
BBF5: 22 CD          BHI    $BC46
BBF7: 91 94          CMPA   $BC
BBF9: B0 98 98       SUBA   $1010
BBFC: 38 28          XANDCC #$00
BBFE: 88 88          EORA   #$00
BC00: 22 22          BHI    $BC02
BC02: 82 82          SBCA   #$00
BC04: 23 22          BLS    $BC06
BC06: CE 51 04       LDU    #$D32C
BC09: B0 98 98       SUBA   $1010
BC0C: 38 28          XANDCC #$00
BC0E: 88 88          EORA   #$00
BC10: 22 22          BHI    $BC12
BC12: 82 82          SBCA   #$00
BC14: 23 28          BLS    $BC20
BC16: 91 1A          CMPA   $98
BC18: 3B             RTI
BC19: 00 88          NEG    $00
BC1B: 88 28          EORA   #$00
BC1D: 28 88          BVC    $BC1F
BC1F: 88 22          EORA   #$00
BC21: 22 82          BHI    $BC23
BC23: 82 22          SBCA   #$00
BC25: 22 5E          BHI    $BC03
BC27: 1E F4          EXG    inv,inv
BC29: 18             X18
BC2A: 88 88          EORA   #$00
BC2C: 28 28          BVC    $BC2E
BC2E: 88 88          EORA   #$00
BC30: 22 22          BHI    $BC32
BC32: 82 82          SBCA   #$00
BC34: 23 29          BLS    $BC41
BC36: 59             ROLB
BC37: 1A F3          ORCC   #$DB
BC39: 20 88          BRA    $BC3B
BC3B: 88 28          EORA   #$00
BC3D: 28 88          BVC    $BC3F
BC3F: 88 22          EORA   #$00
BC41: 22 82          BHI    $BC43
BC43: 82 22          SBCA   #$00
BC45: 22 5E          BHI    $BC23
BC47: 1E F4          EXG    inv,inv
BC49: 18             X18
BC4A: 88 88          EORA   #$00
BC4C: 28 28          BVC    $BC4E
BC4E: 88 88          EORA   #$00
BC50: 22 22          BHI    $BC52
BC52: 82 82          SBCA   #$00
BC54: 22 22          BHI    $BC56
BC56: 82 82          SBCA   #$00
BC58: 28 E8          BVC    $BC1A
BC5A: 88 88          EORA   #$00
BC5C: B8 B8 88       EORA   $9000
BC5F: 1E 01          EXG    Y,U
BC61: 22 82          BHI    $BC63
BC63: 82 22          SBCA   #$00
BC65: 22 82          BHI    $BC67
BC67: 82 D7          SBCA   #$FF
BC69: 28 89          BVC    $BC6C
BC6B: 88 D7          EORA   #$FF
BC6D: 28 89          BVC    $BC70
BC6F: 88 22          EORA   #$00
BC71: 22 82          BHI    $BC73
BC73: 82 22          SBCA   #$00
BC75: 22 82          BHI    $BC77
BC77: 82 38          SBCA   #$10
BC79: 24 88          BCC    $BC7B
BC7B: 88 D7          EORA   #$FF
BC7D: 6D 89          TST    $1,X
BC7F: 0E 5F          JMP    $7D
BC81: 42             XNCA
BC82: 82 82          SBCA   #$00
BC84: 22 22          BHI    $BC86
BC86: 82 82          SBCA   #$00
BC88: D7 D7          STB    $FF
BC8A: 88 88          EORA   #$00
BC8C: D7 D7          STB    $FF
BC8E: 77 77 DD       ASR    $FFFF
BC91: DD 7D          STD    $FF
BC93: 7D 23 22       TST    $0100
BC96: 82 82          SBCA   #$00
BC98: 38 F8          XANDCC #$D0
BC9A: 88 88          EORA   #$00
BC9C: 8C 8C 88       CMPX   #$A400
BC9F: 2C 80          BGE    $BC43
BCA1: 22 82          BHI    $BCA3
BCA3: 82 22          SBCA   #$00
BCA5: 22 82          BHI    $BCA7
BCA7: 82 28          SBCA   #$00
BCA9: 28 88          BVC    $BCAB
BCAB: 88 28          EORA   #$00
BCAD: 28 88          BVC    $BCAF
BCAF: 88 22          EORA   #$00
BCB1: 22 82          BHI    $BCB3
BCB3: 82 23          SBCA   #$01
BCB5: 77 E0 8A       ASR    $6208
BCB8: 29 BD          BVS    $BC4F
BCBA: 2A 80          BPL    $BCC4
BCBC: 29 8D          BVS    $BC63
BCBE: 3A             ABX
BCBF: A0 23          SUBA   $1,X
BCC1: 77 E0 CA       ASR    $6248
BCC4: 23 17          BLS    $BCFB
BCC6: C0 F2          SUBB   #$70
BCC8: 29 9D          BVS    $BC7F
BCCA: 4A             DECA
BCCB: F8 29 B5       EORB   $019D
BCCE: 22 10          BHI    $BC68
BCD0: 23 77          BLS    $BD27
BCD2: E0 42          SUBB   ,U+
BCD4: 22 22          BHI    $BCD6
BCD6: 82 82          SBCA   #$00
BCD8: 28 28          BVC    $BCDA
BCDA: 88 88          EORA   #$00
BCDC: 28 28          BVC    $BCDE
BCDE: 88 88          EORA   #$00
BCE0: 22 22          BHI    $BCE2
BCE2: 82 82          SBCA   #$00
BCE4: 22 22          BHI    $BCE6
BCE6: 82 82          SBCA   #$00
BCE8: 28 28          BVC    $BCEA
BCEA: 88 88          EORA   #$00
BCEC: 28 28          BVC    $BCEE
BCEE: 88 88          EORA   #$00
BCF0: 22 22          BHI    $BCF2
BCF2: 82 82          SBCA   #$00
BCF4: 23 22          BLS    $BCF6
BCF6: D7 8A          STB    $08
BCF8: 29 4A          BVS    $BD5C
BCFA: 1D             SEX
BCFB: 80 29          SUBA   #$01
BCFD: 8A 77          ORA    #$FF
BCFF: 80 23          SUBA   #$01
BD01: 22 27          BHI    $BCA8
BD03: AA 23          ORA    $1,X
BD05: 90 7D          SUBA   $FF
BD07: AA 29          ORA    $1,X
BD09: 28 DD          BVC    $BD60
BD0B: C0 29          SUBB   #$01
BD0D: 4A             DECA
BD0E: 77 C0 23       ASR    $4801
BD11: 22 B7          BHI    $BD48
BD13: F2 23 60       SBCB   $0142
BD16: 37 F2          PULU   X,Y,S
BD18: 29 EA          BVS    $BCDC
BD1A: 77 F8 29       ASR    $7001
BD1D: 28 15          BVC    $BCBC
BD1F: 10 23 88 7D    LBLS   $6822
BD23: 1A 23          ORCC   #$01
BD25: 22 D7          BHI    $BD7C
BD27: 42             XNCA
BD28: 29 4A          BVS    $BD8C
BD2A: 77 48 28       ASR    $C000
BD2D: 28 88          BVC    $BD2F
BD2F: 88 22          EORA   #$00
BD31: 22 82          BHI    $BD33
BD33: 82 22          SBCA   #$00
BD35: 22 82          BHI    $BD37
BD37: 82 28          SBCA   #$00
BD39: 28 88          BVC    $BD3B
BD3B: 88 28          EORA   #$00
BD3D: 28 88          BVC    $BD3F
BD3F: 88 22          EORA   #$00
BD41: 22 82          BHI    $BD43
BD43: 82 22          SBCA   #$00
BD45: 22 82          BHI    $BD47
BD47: 82 28          SBCA   #$00
BD49: 28 88          BVC    $BD4B
BD4B: 88 28          EORA   #$00
BD4D: 28 88          BVC    $BD4F
BD4F: 88 22          EORA   #$00
BD51: 22 82          BHI    $BD53
BD53: 82 23          SBCA   #$01
BD55: 76 AA 9E       ROR    $281C
BD58: 29 14          BVS    $BD96
BD5A: C0 B4          SUBB   #$3C
BD5C: 29 EC          BVS    $BD22
BD5E: C0 B4          SUBB   #$3C
BD60: 23 8E          BLS    $BD0E
BD62: F2 DE 23       SBCB   $5C01
BD65: 76 1A 06       ROR    $9884
BD68: 29 6C          BVS    $BDAE
BD6A: 48             ASLA
BD6B: 24 29          BCC    $BD6E
BD6D: B4 48 24       ANDA   $C0AC
BD70: 22 22          BHI    $BD72
BD72: 82 82          SBCA   #$00
BD74: 22 22          BHI    $BD76
BD76: 82 82          SBCA   #$00
BD78: 28 28          BVC    $BD7A
BD7A: 88 88          EORA   #$00
BD7C: 28 28          BVC    $BD7E
BD7E: 88 88          EORA   #$00
BD80: 22 22          BHI    $BD82
BD82: 82 82          SBCA   #$00
BD84: 22 22          BHI    $BD86
BD86: 82 82          SBCA   #$00
BD88: 28 28          BVC    $BD8A
BD8A: 88 88          EORA   #$00
BD8C: 28 28          BVC    $BD8E
BD8E: 88 88          EORA   #$00
BD90: 22 22          BHI    $BD92
BD92: 82 82          SBCA   #$00
BD94: 3A             ABX
BD95: 22 02          BHI    $BD17
BD97: 82 FC          SBCA   #$D4
BD99: 28 AC          BVC    $BDBF
BD9B: 08 C8          ASL    $E0
BD9D: FC 98 AC       LDD    $1024
BDA0: FA C2 9A       ORB    $E018
BDA3: 92 A2          SBCA   $80
BDA5: 5A             DECB
BDA6: 62 5A 5E       XNC    [$76,U]
BDA9: A8 5C          EORA   [,U]
BDAB: 68 28          ASL    $0,X
BDAD: 37 88          PULU   
BDAF: FE 22 22       LDU    >$0000
BDB2: 82 82          SBCA   #$00
BDB4: 22 22          BHI    $BDB6
BDB6: 82 82          SBCA   #$00
BDB8: 28 28          BVC    $BDBA
BDBA: 88 88          EORA   #$00
BDBC: 28 28          BVC    $BDBE
BDBE: 88 88          EORA   #$00
BDC0: 22 22          BHI    $BDC2
BDC2: 82 82          SBCA   #$00
BDC4: 22 24          BHI    $BDCC
BDC6: 86 8A          LDA    #$08
BDC8: 14             XHCF
BDC9: 2F CE          BLE    $BE11
BDCB: 88 2C          EORA   #$04
BDCD: 2C 84          BGE    $BDDB
BDCF: 84 22          ANDA   #$00
BDD1: 22 82          BHI    $BDD3
BDD3: 82 82          SBCA   #$A0
BDD5: BE 22 18       LDX    $A09A
BDD8: 90 F8          SUBA   $D0
BDDA: 30 82          LEAX   $A,X
BDDC: 28 28          BVC    $BDDE
BDDE: D8 88          EORB   $00
BDE0: DD DD          STD    $FF
BDE2: 7D 7D 23       TST    $FF01
BDE5: 22 82          BHI    $BDE7
BDE7: 82 E8          SBCA   #$C0
BDE9: 20 88          BRA    $BDEB
BDEB: 88 B8          EORA   #$90
BDED: B8 88 46       EORA   >$00CE
BDF0: D4 42          ANDB   $60
BDF2: C2 82          SBCB   #$00
BDF4: 22 22          BHI    $BDF6
BDF6: 82 82          SBCA   #$00
BDF8: 24 28          BCC    $BDFA
BDFA: 77 88 28       ASR    >$0000
BDFD: 28 88          BVC    $BDFF
BDFF: 88 23          EORA   #$01
BE01: 22 82          BHI    $BE03
BE03: 82 23          SBCA   #$01
BE05: 22 83          BHI    $BE08
BE07: 82 F8          SBCA   #$D0
BE09: 00 88          NEG    $00
BE0B: 88 BC          EORA   #$94
BE0D: B8 88 59       EORA   >$00D1
BE10: BC 42 42       CMPX   $60C0
BE13: 80 22          SUBA   #$00
BE15: 22 82          BHI    $BE17
BE17: 82 24          SBCA   #$0C
BE19: 28 77          BVC    $BE1A
BE1B: 88 28          EORA   #$00
BE1D: 28 88          BVC    $BE1F
BE1F: 88 20          EORA   #$02
BE21: 22 82          BHI    $BE23
BE23: 82 23          SBCA   #$01
BE25: 22 83          BHI    $BE28
BE27: 82 08          SBCA   #$20
BE29: 48             ASLA
BE2A: 88 88          EORA   #$00
BE2C: BC B8 88       CMPX   $9000
BE2F: 59             ROLB
BE30: BC 42 42       CMPX   $60C0
BE33: 82 22          SBCA   #$00
BE35: 22 82          BHI    $BE37
BE37: 82 24          SBCA   #$0C
BE39: 28 77          BVC    $BE3A
BE3B: 88 28          EORA   #$00
BE3D: 28 88          BVC    $BE3F
BE3F: 88 24          EORA   #$06
BE41: 22 82          BHI    $BE43
BE43: 82 23          SBCA   #$01
BE45: 22 82          BHI    $BE47
BE47: 82 A0          SBCA   #$88
BE49: AC 88          CMPX   $0,X
BE4B: 88 B8          EORA   #$90
BE4D: B8 88 46       EORA   >$00CE
BE50: D4 42          ANDB   $60
BE52: C2 80          SBCB   #$02
BE54: 22 22          BHI    $BE56
BE56: 82 82          SBCA   #$00
BE58: 24 28          BCC    $BE5A
BE5A: 77 88 28       ASR    >$0000
BE5D: 28 88          BVC    $BE5F
BE5F: 88 2B          EORA   #$09
BE61: 22 82          BHI    $BE63
BE63: 82 23          SBCA   #$01
BE65: 22 82          BHI    $BE67
BE67: 82 40          SBCA   #$68
BE69: 48             ASLA
BE6A: 88 88          EORA   #$00
BE6C: B8 B8 88       EORA   $9000
BE6F: 46             RORA
BE70: D4 42          ANDB   $60
BE72: 42             XNCA
BE73: 82 22          SBCA   #$00
BE75: 22 82          BHI    $BE77
BE77: 82 24          SBCA   #$0C
BE79: 28 77          BVC    $BE7A
BE7B: 88 28          EORA   #$00
BE7D: 28 88          BVC    $BE7F
BE7F: 88 25          EORA   #$07
BE81: 22 82          BHI    $BE83
BE83: 82 22          SBCA   #$00
BE85: 22 82          BHI    $BE87
BE87: 82 28          SBCA   #$00
BE89: 28 88          BVC    $BE8B
BE8B: 88 BC          EORA   #$94
BE8D: B8 88 46       EORA   >$00CE
BE90: D4 42          ANDB   $60
BE92: C2 83          SBCB   #$01
BE94: 22 22          BHI    $BE96
BE96: 82 82          SBCA   #$00
BE98: 24 28          BCC    $BE9A
BE9A: 77 88 28       ASR    >$0000
BE9D: 28 88          BVC    $BE9F
BE9F: 88 22          EORA   #$00
BEA1: 22 82          BHI    $BEA3
BEA3: 82 23          SBCA   #$01
BEA5: 22 CE          BHI    $BEF3
BEA7: 16 34 8C       LBRA   $DB4E
BEAA: E4 08          ANDB   ,X+
BEAC: A8 A8          EORA   ,X+
BEAE: 88 88          EORA   #$00
BEB0: 22 22          BHI    $BEB2
BEB2: 82 82          SBCA   #$00
BEB4: 20 22          BRA    $BEB6
BEB6: CF 0E 74       XSTU   #$8C5C
BEB9: 48             ASLA
BEBA: 08 08          ASL    $80
BEBC: A8 28          EORA   $0,X
BEBE: 88 88          EORA   #$00
BEC0: 22 22          BHI    $BEC2
BEC2: 82 82          SBCA   #$00
BEC4: 20 22          BRA    $BEC6
BEC6: CD             XHCF
BEC7: E7 FC          STB    [,U]
BEC9: 00 08          NEG    $80
BECB: 08 A8          ASL    $80
BECD: 28 88          BVC    $BECF
BECF: 88 22          EORA   #$00
BED1: 22 82          BHI    $BED3
BED3: 82 23          SBCA   #$01
BED5: 22 CD          BHI    $BF26
BED7: F6 FC 8C       LDB    $D4A4
BEDA: E4 08          ANDB   ,X+
BEDC: A8 A8          EORA   ,X+
BEDE: 88 88          EORA   #$00
BEE0: 22 22          BHI    $BEE2
BEE2: 82 82          SBCA   #$00
BEE4: 23 2C          BLS    $BEF4
BEE6: 97 4A          STA    $C8
BEE8: 3D             MUL
BEE9: 18             X18
BEEA: 88 88          EORA   #$00
BEEC: 28 28          BVC    $BEEE
BEEE: 88 88          EORA   #$00
BEF0: 22 22          BHI    $BEF2
BEF2: 82 82          SBCA   #$00
BEF4: 22 22          BHI    $BEF6
BEF6: 83 A1 A1       SUBD   #$2389
BEF9: 29 88          BVS    $BEFB
BEFB: 88 28          EORA   #$00
BEFD: 28 88          BVC    $BEFF
BEFF: 88 22          EORA   #$00
BF01: 22 82          BHI    $BF03
BF03: 82 23          SBCA   #$01
BF05: 2B 47          BMI    $BECC
BF07: 06 F5          ROR    $DD
BF09: 20 88          BRA    $BF0B
BF0B: 88 28          EORA   #$00
BF0D: 28 88          BVC    $BF0F
BF0F: 88 22          EORA   #$00
BF11: 22 82          BHI    $BF13
BF13: 82 22          SBCA   #$00
BF15: 22 83          BHI    $BF18
BF17: A1 A1 29 88    CMPA   $0100,X
BF1B: 88 28          EORA   #$00
BF1D: 28 88          BVC    $BF1F
BF1F: 88 22          EORA   #$00
BF21: 22 82          BHI    $BF23
BF23: 82 23          SBCA   #$01
BF25: 22 82          BHI    $BF27
BF27: 82 28          SBCA   #$00
BF29: E8 88          EORB   $0,X
BF2B: 88 88          EORA   #$A0
BF2D: 88 88          EORA   #$00
BF2F: 1E 01          EXG    Y,U
BF31: 22 82          BHI    $BF33
BF33: 82 22          SBCA   #$00
BF35: 22 82          BHI    $BF37
BF37: 82 D7          SBCA   #$FF
BF39: 28 89          BVC    $BF3C
BF3B: 88 D7          EORA   #$FF
BF3D: 28 89          BVC    $BF40
BF3F: 88 22          EORA   #$00
BF41: 22 82          BHI    $BF43
BF43: 82 22          SBCA   #$00
BF45: 22 82          BHI    $BF47
BF47: 82 38          SBCA   #$10
BF49: 24 88          BCC    $BF4B
BF4B: 88 D7          EORA   #$FF
BF4D: 6D 89          TST    $1,X
BF4F: 0E 5F          JMP    $7D
BF51: 42             XNCA
BF52: 82 82          SBCA   #$00
BF54: 22 22          BHI    $BF56
BF56: 82 82          SBCA   #$00
BF58: D7 D7          STB    $FF
BF5A: 88 88          EORA   #$00
BF5C: D7 D7          STB    $FF
BF5E: 77 77 DD       ASR    $FFFF
BF61: DD 7D          STD    $FF
BF63: 7D 23 22       TST    $0100
BF66: 82 82          SBCA   #$00
BF68: 38 F8          XANDCC #$D0
BF6A: 88 88          EORA   #$00
BF6C: 80 80          SUBA   #$A8
BF6E: 88 2C          EORA   #$A4
BF70: 80 22          SUBA   #$00
BF72: 82 82          SBCA   #$00
BF74: 22 22          BHI    $BF76
BF76: 82 82          SBCA   #$00
BF78: 28 28          BVC    $BF7A
BF7A: 88 88          EORA   #$00
BF7C: 28 28          BVC    $BF7E
BF7E: 88 88          EORA   #$00
BF80: 22 22          BHI    $BF82
BF82: 82 82          SBCA   #$00
BF84: 23 22          BLS    $BF86
BF86: 82 82          SBCA   #$00
BF88: 28 28          BVC    $BF8A
BF8A: 88 88          EORA   #$00
BF8C: 38 08          XANDCC #$20
BF8E: 89 89          ADCA   #$01
BF90: 32 36          LEAS   -$C,X
BF92: 82 82          SBCA   #$00
BF94: 6C 27          INC    $5,X
BF96: C2 40          SBCB   #$C2
BF98: 28 28          BVC    $BF9A
BF9A: 85 DE          BITA   #$56
BF9C: B1 B5 22       CMPA   $9DAA
BF9F: E4 99          ANDB   [D,Y]
BFA1: E5 CF          BITB   $D,U
BFA3: 1F 88          TFR    CC,CC
BFA5: 0C 02          INC    $80
BFA7: 0E 65          JMP    $4D
BFA9: 68 C7          ASL    $F,U
BFAB: B1 68 67       CMPA   $404F
BFAE: B4 C8 6D       ANDA   $404F
BFB1: 66 C2          ROR    $0,U
BFB3: CD             XHCF
BFB4: 6D 62          TST    $0,U
BFB6: CD             XHCF
BFB7: E7 68          STB    $0,U
BFB9: 67 0E          ASR    A,X
BFBB: C8 67          EORB   #$4F
BFBD: B4 C8 C7       ANDA   $404F
BFC0: 8A 62          ORA    #$40
BFC2: CD             XHCF
BFC3: 32 23          LEAS   $1,X
BFC5: 2C F1          BGE    $C03A
BFC7: 8A 29          ORA    #$01
BFC9: 54             LSRB
BFCA: 77 80 29       ASR    $0801
BFCD: 80 77          SUBA   #$FF
BFCF: A0 23          SUBA   $1,X
BFD1: 22 B5          BHI    $C00A
BFD3: B2 23 72       SBCA   $0150
BFD6: 05 BA          LSR    $38
BFD8: 29 E0          BVS    $BFA2
BFDA: 77 C0 29       ASR    $4801
BFDD: 3C B3          CWAI   #$3B
BFDF: E8 23          EORB   $1,X
BFE1: 76 05 E2       ROR    $8760
BFE4: 23 E1          BLS    $BFA9
BFE6: 6D E6          TST    $4,S
BFE8: 29 7C          BVS    $C03E
BFEA: 6B 0C          XDEC   ,X
BFEC: 29 38          BVS    $BFFE
BFEE: B3 00 23       SUBD   $8801
BFF1: 36 B9          PSHU   Y,X,DP,A,CC
BFF3: 26 23          BNE    $BFF6
BFF5: 86 7D          LDA    #$FF
BFF7: 26 29          BNE    $BFFA
BFF9: 7C 07 20       INC    $8FA8
BFFC: 29 28          BVS    $BFFE
BFFE: EF 40 23       STU    $01,U
C001: 5A             DECB
C002: 32 4A 23       LEAS   $01,U
C005: 9A 7D          ORA    $FF
C007: 4A             DECA
C008: 28 28          BVC    $C00A
C00A: 88 88          EORA   #$00
C00C: 28 28          BVC    $C00E
C00E: 88 88          EORA   #$00
C010: 22 22          BHI    $C012
C012: 82 82          SBCA   #$00
C014: 22 22          BHI    $C016
C016: 82 82          SBCA   #$00
C018: 28 28          BVC    $C01A
C01A: 88 88          EORA   #$00
C01C: 28 28          BVC    $C01E
C01E: 88 88          EORA   #$00
C020: 22 22          BHI    $C022
C022: 82 82          SBCA   #$00
C024: 23 0F          BLS    $C053
C026: B2 A2 29       SBCA   $2001
C029: 45             LSRA
C02A: B0 A8 29       SUBA   $2001
C02D: B5 0C F8       BITA   $8470
C030: 23 A7          BLS    $BFB7
C032: 2A 1A          BPL    $BFCC
C034: 23 17          BLS    $C06B
C036: 4A             DECA
C037: 3A             ABX
C038: 29 AD          BVS    $BFBF
C03A: 40             NEGA
C03B: 34 28          PSHS   
C03D: 28 88          BVC    $C03F
C03F: 88 22          EORA   #$00
C041: 22 82          BHI    $C043
C043: 82 22          SBCA   #$00
C045: 22 82          BHI    $C047
C047: 82 28          SBCA   #$00
C049: 28 88          BVC    $C04B
C04B: 88 28          EORA   #$00
C04D: 28 88          BVC    $C04F
C04F: 88 22          EORA   #$00
C051: 22 82          BHI    $C053
C053: 82 22          SBCA   #$00
C055: 22 82          BHI    $C057
C057: 82 28          SBCA   #$00
C059: 28 88          BVC    $C05B
C05B: 88 28          EORA   #$00
C05D: 28 88          BVC    $C05F
C05F: 88 22          EORA   #$00
C061: 22 82          BHI    $C063
C063: 82 36          SBCA   #$14
C065: 22 42          BHI    $C027
C067: 82 C8          SBCA   #$E0
C069: E8 A0          EORB   $8,Y
C06B: 9C 40          CMPX   $68
C06D: 28 58          BVC    $C03F
C06F: 68 0A          ASL    $8,Y
C071: 02 FA          XNC    $78
C073: EA EA F2       ORB    -$30,U
C076: 34 FA          PSHS   U,Y,X,DP
C078: 3C 00          CWAI   #$28
C07A: 90 9C          SUBA   $14
C07C: 8F 9E F0       XSTX   #$B678
C07F: E8 22          EORB   $0,X
C081: 7E 82 FA       JMP    >$0078
C084: 22 22          BHI    $C086
C086: 82 82          SBCA   #$00
C088: 28 28          BVC    $C08A
C08A: 88 88          EORA   #$00
C08C: 28 28          BVC    $C08E
C08E: 88 88          EORA   #$00
C090: 22 22          BHI    $C092
C092: 82 82          SBCA   #$00
C094: 22 24          BHI    $C09C
C096: 86 8A          LDA    #$08
C098: 14             XHCF
C099: 2D C9          BLT    $C0DC
C09B: 88 2C          EORA   #$04
C09D: 2C 85          BGE    $C0AC
C09F: 85 22          BITA   #$00
C0A1: 22 82          BHI    $C0A3
C0A3: 82 92          SBCA   #$B0
C0A5: 80 28          SUBA   #$AA
C0A7: 1C E8          ANDCC  #$C0
C0A9: F8 3E 82       EORB   $B60A
C0AC: 28 28          BVC    $C0AE
C0AE: D8 88          EORB   $00
C0B0: DD DD          STD    $FF
C0B2: 7D 7D 23       TST    $FF01
C0B5: 22 83          BHI    $C0B8
C0B7: 82 68          SBCA   #$40
C0B9: 18             X18
C0BA: 88 88          EORA   #$00
C0BC: 88 B8          EORA   #$90
C0BE: 88 59          EORA   #$D1
C0C0: BC 42 C2       CMPX   $6040
C0C3: 80 22          SUBA   #$00
C0C5: 22 82          BHI    $C0C7
C0C7: 82 24          SBCA   #$0C
C0C9: 28 77          BVC    $C0CA
C0CB: 88 28          EORA   #$00
C0CD: 28 88          BVC    $C0CF
C0CF: 88 20          EORA   #$02
C0D1: 22 82          BHI    $C0D3
C0D3: 82 23          SBCA   #$01
C0D5: 22 83          BHI    $C0D8
C0D7: 82 E0          SBCA   #$C8
C0D9: 38 88          XANDCC #$00
C0DB: 88 88          EORA   #$A0
C0DD: B8 88 59       EORA   >$00D1
C0E0: BC 42 42       CMPX   $60C0
C0E3: 82 22          SBCA   #$00
C0E5: 22 82          BHI    $C0E7
C0E7: 82 24          SBCA   #$0C
C0E9: 28 77          BVC    $C0EA
C0EB: 88 28          EORA   #$00
C0ED: 28 88          BVC    $C0EF
C0EF: 88 23          EORA   #$01
C0F1: 22 82          BHI    $C0F3
C0F3: 82 23          SBCA   #$01
C0F5: 22 82          BHI    $C0F7
C0F7: 82 68          SBCA   #$40
C0F9: 58             ASLB
C0FA: 88 88          EORA   #$00
C0FC: B4 A6 88       ANDA   $8E00
C0FF: 46             RORA
C100: D4 42          ANDB   $60
C102: C2 80          SBCB   #$02
C104: 22 22          BHI    $C106
C106: 82 82          SBCA   #$00
C108: 24 28          BCC    $C10A
C10A: 77 88 28       ASR    >$0000
C10D: 28 88          BVC    $C10F
C10F: 88 24          EORA   #$06
C111: 22 82          BHI    $C113
C113: 82 23          SBCA   #$01
C115: 22 82          BHI    $C117
C117: 82 18          SBCA   #$30
C119: 70 88 88       NEG    >$0000
C11C: B4 A6 88       ANDA   $8E00
C11F: 46             RORA
C120: D4 42          ANDB   $60
C122: 42             XNCA
C123: 82 22          SBCA   #$00
C125: 22 82          BHI    $C127
C127: 82 24          SBCA   #$0C
C129: 28 77          BVC    $C12A
C12B: 88 28          EORA   #$00
C12D: 28 88          BVC    $C12F
C12F: 88 26          EORA   #$04
C131: 22 82          BHI    $C133
C133: 82 23          SBCA   #$01
C135: 22 82          BHI    $C137
C137: 82 98          SBCA   #$B0
C139: 10 88 88       EORA   #$00
C13C: B4 A6 88       ANDA   $8E00
C13F: 46             RORA
C140: D4 42          ANDB   $60
C142: 42             XNCA
C143: 82 22          SBCA   #$00
C145: 22 82          BHI    $C147
C147: 82 24          SBCA   #$0C
C149: 28 77          BVC    $C14A
C14B: 88 28          EORA   #$00
C14D: 28 88          BVC    $C14F
C14F: 88 21          EORA   #$03
C151: 22 82          BHI    $C153
C153: 82 22          SBCA   #$00
C155: 22 82          BHI    $C157
C157: 82 28          SBCA   #$00
C159: 28 88          BVC    $C15B
C15B: 88 B4          EORA   #$9C
C15D: A6 88          LDA    $0,X
C15F: 46             RORA
C160: D4 42          ANDB   $60
C162: 42             XNCA
C163: 82 22          SBCA   #$00
C165: 22 82          BHI    $C167
C167: 82 24          SBCA   #$0C
C169: 28 77          BVC    $C16A
C16B: 88 28          EORA   #$00
C16D: 28 88          BVC    $C16F
C16F: 88 22          EORA   #$00
C171: 22 82          BHI    $C173
C173: 82 23          SBCA   #$01
C175: 22 CD          BHI    $C1C6
C177: C0 E4          SUBB   #$CC
C179: 38 F5          XANDCC #$7D
C17B: DF 85          STU    $AD
C17D: 28 88          BVC    $C17F
C17F: 88 22          EORA   #$00
C181: 22 82          BHI    $C183
C183: 82 23          SBCA   #$01
C185: 22 CF          BHI    $C1D4
C187: F5 7C 90       BITB   $54B8
C18A: 08 08          ASL    $80
C18C: A8 28          EORA   $0,X
C18E: 88 88          EORA   #$00
C190: 22 22          BHI    $C192
C192: 82 82          SBCA   #$00
C194: 20 22          BRA    $C196
C196: CE E4 3C       LDU    #$6614
C199: 18             X18
C19A: F5 56 85       BITB   $DEAD
C19D: 28 88          BVC    $C19F
C19F: 88 22          EORA   #$00
C1A1: 22 82          BHI    $C1A3
C1A3: 82 20          SBCA   #$02
C1A5: 22 CD          BHI    $C1F6
C1A7: B0 EC B8       SUBA   $C490
C1AA: 57             ASRB
C1AB: 25 F2          BCS    $C187
C1AD: 28 88          BVC    $C1AF
C1AF: A8 22          EORA   $0,X
C1B1: 22 82          BHI    $C1B3
C1B3: 82 23          SBCA   #$01
C1B5: 2A C6          BPL    $C1FB
C1B7: 12             NOP
C1B8: 04 18          LSR    $30
C1BA: 88 88          EORA   #$00
C1BC: 28 28          BVC    $C1BE
C1BE: 88 88          EORA   #$00
C1C0: 22 22          BHI    $C1C2
C1C2: 82 82          SBCA   #$00
C1C4: 23 2B          BLS    $C1CF
C1C6: 2E 12          BGT    $C158
C1C8: 04 18          LSR    $30
C1CA: 88 88          EORA   #$00
C1CC: 28 28          BVC    $C1CE
C1CE: 88 88          EORA   #$00
C1D0: 22 22          BHI    $C1D2
C1D2: 82 82          SBCA   #$00
C1D4: 23 2B          BLS    $C1DF
C1D6: 2E 12          BGT    $C168
C1D8: 94 10          ANDA   $38
C1DA: 88 88          EORA   #$00
C1DC: 28 28          BVC    $C1DE
C1DE: 88 88          EORA   #$00
C1E0: 22 22          BHI    $C1E2
C1E2: 82 82          SBCA   #$00
C1E4: 23 2A          BLS    $C1EE
C1E6: C6 12          LDB    #$90
C1E8: 94 10          ANDA   $38
C1EA: 88 88          EORA   #$00
C1EC: 28 28          BVC    $C1EE
C1EE: 88 88          EORA   #$00
C1F0: 22 22          BHI    $C1F2
C1F2: 82 82          SBCA   #$00
C1F4: 22 22          BHI    $C1F6
C1F6: 82 82          SBCA   #$00
C1F8: 28 E8          BVC    $C1BA
C1FA: 88 88          EORA   #$00
C1FC: 88 88          EORA   #$A0
C1FE: 88 1E          EORA   #$96
C200: 01 22          NEG    $00
C202: 82 82          SBCA   #$00
C204: 22 22          BHI    $C206
C206: 82 82          SBCA   #$00
C208: D7 28          STB    $00
C20A: 89 88          ADCA   #$00
C20C: D7 28          STB    $00
C20E: 89 88          ADCA   #$00
C210: 22 22          BHI    $C212
C212: 82 82          SBCA   #$00
C214: 22 22          BHI    $C216
C216: 82 82          SBCA   #$00
C218: 38 20          XANDCC #$08
C21A: 88 88          EORA   #$00
C21C: D7 6D          STB    $45
C21E: 89 0E          ADCA   #$86
C220: 5F             CLRB
C221: 42             XNCA
C222: 82 82          SBCA   #$00
C224: 22 22          BHI    $C226
C226: 82 82          SBCA   #$00
C228: D7 D7          STB    $FF
C22A: 88 88          EORA   #$00
C22C: D7 D7          STB    $FF
C22E: 77 77 DD       ASR    $FFFF
C231: DD 7D          STD    $FF
C233: 7D 23 22       TST    $0100
C236: 82 82          SBCA   #$00
C238: 38 F8          XANDCC #$D0
C23A: 88 88          EORA   #$00
C23C: 98 98          EORA   $B0
C23E: 88 2C          EORA   #$A4
C240: 80 22          SUBA   #$00
C242: 82 82          SBCA   #$00
C244: 22 22          BHI    $C246
C246: 82 82          SBCA   #$00
C248: 28 28          BVC    $C24A
C24A: 88 88          EORA   #$00
C24C: 28 28          BVC    $C24E
C24E: 88 88          EORA   #$00
C250: 22 22          BHI    $C252
C252: 82 82          SBCA   #$00
C254: 23 22          BLS    $C256
C256: 82 82          SBCA   #$00
C258: 28 28          BVC    $C25A
C25A: 88 E8          EORA   #$60
C25C: 28 28          BVC    $C25E
C25E: 88 88          EORA   #$00
C260: 22 22          BHI    $C262
C262: 82 82          SBCA   #$00
C264: 6F E9          CLR    D,U
C266: 82 82          SBCA   #$00
C268: 28 28          BVC    $C26A
C26A: 88 88          EORA   #$00
C26C: 5E             XCLRB
C26D: A1 88          CMPA   $0,X
C26F: 88 22          EORA   #$00
C271: 22 82          BHI    $C273
C273: 82 22          SBCA   #$00
C275: 22 CF          BHI    $C2C4
C277: 82 65          SBCA   #$4D
C279: E3 C5          ADDD   $D,U
C27B: 44             LSRA
C27C: 28 24          BVC    $C28A
C27E: 88 88          EORA   #$00
C280: 22 22          BHI    $C282
C282: 82 82          SBCA   #$00
C284: 22 22          BHI    $C286
C286: 82 82          SBCA   #$00
C288: 28 28          BVC    $C28A
C28A: 88 88          EORA   #$00
C28C: 28 28          BVC    $C28E
C28E: 88 88          EORA   #$00
C290: 22 22          BHI    $C292
C292: 82 82          SBCA   #$00
C294: 23 22          BLS    $C296
C296: EC 8A          LDD    $8,X
C298: 29 B9          BVS    $C22B
C29A: 77 98 29       ASR    $1001
C29D: 38 E6          XANDCC #$6E
C29F: B8 23 B3       EORA   $0191
C2A2: 6C BA          INC    -$8,Y
C2A4: 23 32          BLS    $C2B6
C2A6: EC DA          LDD    -$8,U
C2A8: 29 B9          BVS    $C23B
C2AA: 6E E8          JMP    $0,S
C2AC: 29 31          BVS    $C2C7
C2AE: E6 F8          LDB    -$10,S
C2B0: 23 43          BLS    $C313
C2B2: 1C FA          ANDCC  #$78
C2B4: 23 03          BLS    $C2D7
C2B6: F4 12 29       ANDB   $9001
C2B9: B9 56 18       ADCA   $DE90
C2BC: 29 01          BVS    $C2E7
C2BE: EE 38 23 BB    LDU    [$0199,W]
C2C2: 54             LSRB
C2C3: 32 23          LEAS   $1,X
C2C5: 1B             NOP
C2C6: F4 3A 29       ANDB   $B801
C2C9: 41             NEGA
C2CA: 16 40 28       LBRA   $8ACD
C2CD: 28 88          BVC    $C2CF
C2CF: 88 22          EORA   #$00
C2D1: 22 82          BHI    $C2D3
C2D3: 82 22          SBCA   #$00
C2D5: 22 82          BHI    $C2D7
C2D7: 82 28          SBCA   #$00
C2D9: 28 88          BVC    $C2DB
C2DB: 88 28          EORA   #$00
C2DD: 28 88          BVC    $C2DF
C2DF: 88 22          EORA   #$00
C2E1: 22 82          BHI    $C2E3
C2E3: 82 22          SBCA   #$00
C2E5: 22 82          BHI    $C2E7
C2E7: 82 28          SBCA   #$00
C2E9: 28 88          BVC    $C2EB
C2EB: 88 28          EORA   #$00
C2ED: 28 88          BVC    $C2EF
C2EF: 88 22          EORA   #$00
C2F1: 22 82          BHI    $C2F3
C2F3: 82 23          SBCA   #$01
C2F5: 66 B2          ROR    -$10,Y
C2F7: A2 29          SBCA   $1,X
C2F9: F4 B0 A0       ANDB   $3828
C2FC: 29 1C          BVS    $C332
C2FE: 18             X18
C2FF: 0C 23          INC    $01
C301: 1E 32          EXG    DP,D
C303: 26 23          BNE    $C306
C305: 6E DA          JMP    -$8,U
C307: CA 29          ORB    #$01
C309: 8C E8 D8       CMPX   #$6050
C30C: 29 EC          BVS    $C2D2
C30E: 18             X18
C30F: F4 23 E6       ANDB   $01C4
C312: 32 26          LEAS   ,Y
C314: 22 22          BHI    $C316
C316: 82 82          SBCA   #$00
C318: 28 28          BVC    $C31A
C31A: 88 88          EORA   #$00
C31C: 28 28          BVC    $C31E
C31E: 88 88          EORA   #$00
C320: 22 22          BHI    $C322
C322: 82 82          SBCA   #$00
C324: 22 22          BHI    $C326
C326: 82 82          SBCA   #$00
C328: 28 28          BVC    $C32A
C32A: 88 88          EORA   #$00
C32C: 28 28          BVC    $C32E
C32E: 88 88          EORA   #$00
C330: 22 22          BHI    $C332
C332: 82 82          SBCA   #$00
C334: 72 22 3A       XNC    >$00B8
C337: 82 7C          SBCA   #$54
C339: 00 38          NEG    $B0
C33B: 30 60          LEAX   $8,U
C33D: 02 24          XNC    $AC
C33F: 38 6A          XANDCC #$48
C341: 6A 82          DEC    $0,X
C343: 82 7A          SBCA   #$58
C345: 6A 1C          DEC    [W,X]
C347: 2E 28          BGT    $C349
C349: 70 88 16       NEG    >$009E
C34C: 28 28          BVC    $C34E
C34E: 88 88          EORA   #$00
C350: 22 22          BHI    $C352
C352: 82 82          SBCA   #$00
C354: 22 22          BHI    $C356
C356: 82 82          SBCA   #$00
C358: 28 28          BVC    $C35A
C35A: 88 88          EORA   #$00
C35C: 28 28          BVC    $C35E
C35E: 88 88          EORA   #$00
C360: 22 22          BHI    $C362
C362: 82 82          SBCA   #$00
C364: 22 24          BHI    $C36C
C366: 86 8A          LDA    #$08
C368: 14             XHCF
C369: 2D C9          BLT    $C3AC
C36B: 88 2C          EORA   #$04
C36D: 2C 84          BGE    $C37B
C36F: 84 22          ANDA   #$00
C371: 22 82          BHI    $C373
C373: 82 E2          SBCA   #$C0
C375: 80 3C          SUBA   #$BE
C377: 22 E0          BHI    $C341
C379: E4 22          ANDB   F,Y
C37B: 81 28          CMPA   #$00
C37D: 28 D8          BVC    $C3CF
C37F: 88 DD          EORA   #$FF
C381: DD 7D          STD    $FF
C383: 7D 23 22       TST    $0100
C386: 83 82 98       SUBD   #$00B0
C389: 30 88          LEAX   $0,X
C38B: 88 98          EORA   #$B0
C38D: BC 88 59       CMPX   >$00D1
C390: BC 42 C2       CMPX   $6040
C393: 80 22          SUBA   #$00
C395: 22 82          BHI    $C397
C397: 82 24          SBCA   #$0C
C399: 28 77          BVC    $C39A
C39B: 88 28          EORA   #$00
C39D: 28 88          BVC    $C39F
C39F: 88 23          EORA   #$01
C3A1: 22 82          BHI    $C3A3
C3A3: 82 23          SBCA   #$01
C3A5: 22 83          BHI    $C3A8
C3A7: 82 68          SBCA   #$40
C3A9: 78 88 88       ASL    >$0000
C3AC: 86 B8          LDA    #$90
C3AE: 88 59          EORA   #$D1
C3B0: BC 42 42       CMPX   $60C0
C3B3: 82 22          SBCA   #$00
C3B5: 22 82          BHI    $C3B7
C3B7: 82 24          SBCA   #$0C
C3B9: 28 77          BVC    $C3BA
C3BB: 88 28          EORA   #$00
C3BD: 28 88          BVC    $C3BF
C3BF: 88 27          EORA   #$05
C3C1: 22 82          BHI    $C3C3
C3C3: 82 23          SBCA   #$01
C3C5: 22 82          BHI    $C3C7
C3C7: 82 60          SBCA   #$48
C3C9: 58             ASLB
C3CA: 88 88          EORA   #$00
C3CC: 82 A6          SBCA   #$8E
C3CE: 88 46          EORA   #$CE
C3D0: D4 42          ANDB   $60
C3D2: C2 80          SBCB   #$02
C3D4: 22 22          BHI    $C3D6
C3D6: 82 82          SBCA   #$00
C3D8: 24 28          BCC    $C3DA
C3DA: 77 88 28       ASR    >$0000
C3DD: 28 88          BVC    $C3DF
C3DF: 88 2A          EORA   #$08
C3E1: 22 82          BHI    $C3E3
C3E3: 82 23          SBCA   #$01
C3E5: 22 82          BHI    $C3E7
C3E7: 82 E8          SBCA   #$C0
C3E9: 80 88          SUBA   #$00
C3EB: 88 82          EORA   #$AA
C3ED: A4 88          ANDA   $0,X
C3EF: 46             RORA
C3F0: D4 42          ANDB   $60
C3F2: 42             XNCA
C3F3: 82 22          SBCA   #$00
C3F5: 22 82          BHI    $C3F7
C3F7: 82 24          SBCA   #$0C
C3F9: 28 77          BVC    $C3FA
C3FB: 88 28          EORA   #$00
C3FD: 28 88          BVC    $C3FF
C3FF: 88 2E          EORA   #$0C
C401: 22 82          BHI    $C403
C403: 82 23          SBCA   #$01
C405: 22 82          BHI    $C407
C407: 82 30          SBCA   #$18
C409: 90 88          SUBA   $00
C40B: 88 88          EORA   #$A0
C40D: A4 88          ANDA   $0,X
C40F: 46             RORA
C410: D4 42          ANDB   $60
C412: 42             XNCA
C413: 82 22          SBCA   #$00
C415: 22 82          BHI    $C417
C417: 82 24          SBCA   #$0C
C419: 28 77          BVC    $C41A
C41B: 88 28          EORA   #$00
C41D: 28 88          BVC    $C41F
C41F: 88 2F          EORA   #$0D
C421: 22 82          BHI    $C423
C423: 82 22          SBCA   #$00
C425: 22 82          BHI    $C427
C427: 82 28          SBCA   #$00
C429: 28 88          BVC    $C42B
C42B: 88 88          EORA   #$A0
C42D: A2 88          SBCA   $0,X
C42F: 46             RORA
C430: D4 42          ANDB   $60
C432: 42             XNCA
C433: 82 22          SBCA   #$00
C435: 22 82          BHI    $C437
C437: 82 24          SBCA   #$0C
C439: 28 77          BVC    $C43A
C43B: 88 28          EORA   #$00
C43D: 28 88          BVC    $C43F
C43F: 88 22          EORA   #$00
C441: 22 82          BHI    $C443
C443: 82 23          SBCA   #$01
C445: 22 CE          BHI    $C493
C447: F5 3C 90       BITB   $14B8
C44A: F5 F5 47       BITB   $7D6F
C44D: 28 88          BVC    $C44F
C44F: 88 22          EORA   #$00
C451: 22 82          BHI    $C453
C453: 82 20          SBCA   #$02
C455: 22 CF          BHI    $C4A4
C457: EC 7C          LDD    -$C,U
C459: 58             ASLB
C45A: 98 98          EORA   $10
C45C: CB 28          ADDB   #$00
C45E: 88 A8          EORA   #$20
C460: 22 22          BHI    $C462
C462: 82 82          SBCA   #$00
C464: 23 22          BLS    $C466
C466: CD             XHCF
C467: C1 E4          CMPB   #$CC
C469: 30 D4          LEAX   -$4,U
C46B: 25 85          BCS    $C41A
C46D: 08 88          ASL    $00
C46F: 88 22          EORA   #$00
C471: 22 82          BHI    $C473
C473: 82 20          SBCA   #$02
C475: 22 CC          BHI    $C4C5
C477: D3 A4          ADDD   $8C
C479: A0 98          SUBA   -$10,X
C47B: 98 88          EORA   $A0
C47D: 28 88          BVC    $C47F
C47F: 88 22          EORA   #$00
C481: 22 82          BHI    $C483
C483: 82 23          SBCA   #$01
C485: 28 99          BVC    $C4A2
C487: 1A 3B          ORCC   #$13
C489: 18             X18
C48A: 88 88          EORA   #$00
C48C: 28 28          BVC    $C48E
C48E: 88 88          EORA   #$00
C490: 22 22          BHI    $C492
C492: 82 82          SBCA   #$00
C494: 22 22          BHI    $C496
C496: 59             ROLB
C497: 2A F3          BPL    $C474
C499: 08 88          ASL    $00
C49B: 88 28          EORA   #$00
C49D: 28 88          BVC    $C49F
C49F: 88 22          EORA   #$00
C4A1: 22 82          BHI    $C4A3
C4A3: 82 23          SBCA   #$01
C4A5: 2E 59          BGT    $C482
C4A7: 2A F3          BPL    $C484
C4A9: 30 88          LEAX   $0,X
C4AB: 88 28          EORA   #$00
C4AD: 28 88          BVC    $C4AF
C4AF: 88 22          EORA   #$00
C4B1: 22 82          BHI    $C4B3
C4B3: 82 22          SBCA   #$00
C4B5: 22 59          BHI    $C492
C4B7: 2A F3          BPL    $C494
C4B9: 08 88          ASL    $00
C4BB: 88 28          EORA   #$00
C4BD: 28 88          BVC    $C4BF
C4BF: 88 22          EORA   #$00
C4C1: 22 82          BHI    $C4C3
C4C3: 82 22          SBCA   #$00
C4C5: 22 82          BHI    $C4C7
C4C7: 82 28          SBCA   #$00
C4C9: E8 88          EORB   $0,X
C4CB: 88 88          EORA   #$A0
C4CD: 88 88          EORA   #$00
C4CF: 1E 01          EXG    Y,U
C4D1: 22 82          BHI    $C4D3
C4D3: 82 22          SBCA   #$00
C4D5: 22 82          BHI    $C4D7
C4D7: 82 D7          SBCA   #$FF
C4D9: 28 89          BVC    $C4DC
C4DB: 88 D7          EORA   #$FF
C4DD: 28 89          BVC    $C4E0
C4DF: 88 22          EORA   #$00
C4E1: 22 82          BHI    $C4E3
C4E3: 82 22          SBCA   #$00
C4E5: 22 82          BHI    $C4E7
C4E7: 82 38          SBCA   #$10
C4E9: 20 88          BRA    $C4EB
C4EB: 88 D7          EORA   #$FF
C4ED: 6D 89          TST    $1,X
C4EF: 0E 5F          JMP    $7D
C4F1: 42             XNCA
C4F2: 82 82          SBCA   #$00
C4F4: 22 22          BHI    $C4F6
C4F6: 82 82          SBCA   #$00
C4F8: D7 D7          STB    $FF
C4FA: 88 88          EORA   #$00
C4FC: D7 D7          STB    $FF
C4FE: 77 77 DD       ASR    $FFFF
C501: DD 7D          STD    $FF
C503: 7D 23 22       TST    $0100
C506: 82 82          SBCA   #$00
C508: 38 F8          XANDCC #$D0
C50A: 88 88          EORA   #$00
C50C: 90 90          SUBA   $B8
C50E: 88 2C          EORA   #$A4
C510: 80 22          SUBA   #$00
C512: 82 82          SBCA   #$00
C514: 22 22          BHI    $C516
C516: 82 82          SBCA   #$00
C518: 28 28          BVC    $C51A
C51A: 88 88          EORA   #$00
C51C: 28 28          BVC    $C51E
C51E: 88 88          EORA   #$00
C520: 22 22          BHI    $C522
C522: 82 82          SBCA   #$00
C524: 22 22          BHI    $C526
C526: 82 82          SBCA   #$00
C528: 28 28          BVC    $C52A
C52A: 88 88          EORA   #$00
C52C: 28 28          BVC    $C52E
C52E: 88 88          EORA   #$00
C530: 22 22          BHI    $C532
C532: 82 82          SBCA   #$00
C534: 22 22          BHI    $C536
C536: 82 82          SBCA   #$00
C538: 28 28          BVC    $C53A
C53A: 88 88          EORA   #$00
C53C: 28 28          BVC    $C53E
C53E: 88 88          EORA   #$00
C540: 22 22          BHI    $C542
C542: 82 82          SBCA   #$00
C544: 22 22          BHI    $C546
C546: 82 82          SBCA   #$00
C548: 28 28          BVC    $C54A
C54A: 88 88          EORA   #$00
C54C: 28 28          BVC    $C54E
C54E: 88 88          EORA   #$00
C550: 22 22          BHI    $C552
C552: 82 82          SBCA   #$00
C554: 22 22          BHI    $C556
C556: 82 82          SBCA   #$00
C558: 28 28          BVC    $C55A
C55A: 88 88          EORA   #$00
C55C: 28 28          BVC    $C55E
C55E: 88 88          EORA   #$00
C560: 22 22          BHI    $C562
C562: 82 82          SBCA   #$00
C564: 23 22          BLS    $C566
C566: E7 8A          STB    $8,X
C568: 29 B2          BVS    $C504
C56A: 77 90 29       ASR    $1801
C56D: 50             NEGB
C56E: 1F A0          TFR    Y,A
C570: 23 22          BLS    $C572
C572: EF B2          STU    -$10,Y
C574: 23 B8          BLS    $C510
C576: 7D C2 29       TST    $4001
C579: 28 ED          BVC    $C5E0
C57B: D8 29          EORB   $01
C57D: B2 77 E8       SBCA   $FF60
C580: 23 5A          BLS    $C5FA
C582: 15             XHCF
C583: F2 23 22       SBCB   $0100
C586: DF F2          STU    $70
C588: 29 BA          BVS    $C51C
C58A: 77 00 29       ASR    $8801
C58D: 28 E5          BVC    $C5FC
C58F: 10 23 A2 1C    LBLS   $4631
C593: 22 23          BHI    $C596
C595: 88 7D          EORA   #$FF
C597: 2A 29          BPL    $C59A
C599: 28 E5          BVC    $C608
C59B: 30 29          LEAX   $1,X
C59D: 8A 77          ORA    #$FF
C59F: 40             NEGA
C5A0: 23 22          BLS    $C5A2
C5A2: D4 62          ANDB   $E0
C5A4: 23 9E          BLS    $C562
C5A6: 7D 62 28       TST    $E000
C5A9: 28 88          BVC    $C5AB
C5AB: 88 28          EORA   #$00
C5AD: 28 88          BVC    $C5AF
C5AF: 88 22          EORA   #$00
C5B1: 22 82          BHI    $C5B3
C5B3: 82 22          SBCA   #$00
C5B5: 22 82          BHI    $C5B7
C5B7: 82 28          SBCA   #$00
C5B9: 28 88          BVC    $C5BB
C5BB: 88 28          EORA   #$00
C5BD: 28 88          BVC    $C5BF
C5BF: 88 22          EORA   #$00
C5C1: 22 82          BHI    $C5C3
C5C3: 82 23          SBCA   #$01
C5C5: 76 3A 2E       ROR    $B8AC
C5C8: 29 34          BVS    $C5E6
C5CA: F8 EC 29       EORB   $6401
C5CD: 04 10          LSR    $98
C5CF: 00 23          NEG    $01
C5D1: 6E D2          JMP    -$10,U
C5D3: C6 23          LDB    #$01
C5D5: E6 2A 1E       LDB    -$64,Y
C5D8: 29 FC          BVS    $C5AE
C5DA: 00 F0          NEG    $78
C5DC: 29 94          BVS    $C59A
C5DE: E8 DC          EORB   -$C,U
C5E0: 23 FE          BLS    $C5BE
C5E2: C2 B2          SBCB   #$30
C5E4: 22 22          BHI    $C5E6
C5E6: 82 82          SBCA   #$00
C5E8: 28 28          BVC    $C5EA
C5EA: 88 88          EORA   #$00
C5EC: 28 28          BVC    $C5EE
C5EE: 88 88          EORA   #$00
C5F0: 22 22          BHI    $C5F2
C5F2: 82 82          SBCA   #$00
C5F4: 22 22          BHI    $C5F6
C5F6: 82 82          SBCA   #$00
C5F8: 28 28          BVC    $C5FA
C5FA: 88 88          EORA   #$00
C5FC: 28 28          BVC    $C5FE
C5FE: 88 88          EORA   #$00
C600: 22 22          BHI    $C602
C602: 82 82          SBCA   #$00
C604: 1A 22          ORCC   #$00
C606: 4A             DECA
C607: 82 28          SBCA   #$00
C609: 28 B8          BVC    $C63B
C60B: B0 EB E0       SUBA   $C3C8
C60E: A0 B8          SUBA   -$10,Y
C610: E2 E1          SBCB   ,--U
C612: 82 82          SBCA   #$00
C614: 16 0A 5A       LBRA   $EEEF
C617: 42             XNCA
C618: 68 1C          ASL    -$C,Y
C61A: 88 88          EORA   #$00
C61C: E0 F0 88       SUBB   [$00,U]
C61F: C8 22          EORB   #$00
C621: EA 82          ORB    $0,X
C623: 82 22          SBCA   #$00
C625: 22 82          BHI    $C627
C627: 82 28          SBCA   #$00
C629: 28 88          BVC    $C62B
C62B: 88 28          EORA   #$00
C62D: 28 88          BVC    $C62F
C62F: 88 22          EORA   #$00
C631: 22 82          BHI    $C633
C633: 82 22          SBCA   #$00
C635: 24 86          BCC    $C63B
C637: 8A 14          ORA    #$3C
C639: 2B B4          BMI    $C677
C63B: 88 2C          EORA   #$04
C63D: 2C 84          BGE    $C64B
C63F: 84 22          ANDA   #$00
C641: 22 82          BHI    $C643
C643: 82 EA          SBCA   #$C8
C645: 86 4A          LDA    #$C8
C647: 2A E0          BPL    $C611
C649: E4 22          ANDB   F,Y
C64B: 81 28          CMPA   #$00
C64D: 28 D8          BVC    $C69F
C64F: 88 DD          EORA   #$FF
C651: DD 7D          STD    $FF
C653: 7D 23 22       TST    $0100
C656: 83 82 90       SUBD   #$00B8
C659: 20 88          BRA    $C65B
C65B: 88 98          EORA   #$B0
C65D: BC 88 59       CMPX   >$00D1
C660: BC 42 C2       CMPX   $6040
C663: 80 22          SUBA   #$00
C665: 22 82          BHI    $C667
C667: 82 24          SBCA   #$0C
C669: 28 77          BVC    $C66A
C66B: 88 28          EORA   #$00
C66D: 28 88          BVC    $C66F
C66F: 88 20          EORA   #$02
C671: 22 82          BHI    $C673
C673: 82 23          SBCA   #$01
C675: 22 82          BHI    $C677
C677: 82 68          SBCA   #$40
C679: 00 88          NEG    $00
C67B: 88 86          EORA   #$AE
C67D: B8 88 46       EORA   >$00CE
C680: D4 42          ANDB   $60
C682: 42             XNCA
C683: 82 22          SBCA   #$00
C685: 22 82          BHI    $C687
C687: 82 24          SBCA   #$0C
C689: 28 77          BVC    $C68A
C68B: 88 28          EORA   #$00
C68D: 28 88          BVC    $C68F
C68F: 88 21          EORA   #$03
C691: 22 82          BHI    $C693
C693: 82 23          SBCA   #$01
C695: 22 83          BHI    $C698
C697: 82 F8          SBCA   #$D0
C699: 60 88          NEG    $0,X
C69B: 88 82          EORA   #$AA
C69D: A6 88          LDA    $0,X
C69F: 59             ROLB
C6A0: BC 42 42       CMPX   $60C0
C6A3: 82 22          SBCA   #$00
C6A5: 22 82          BHI    $C6A7
C6A7: 82 24          SBCA   #$0C
C6A9: 28 77          BVC    $C6AA
C6AB: 88 28          EORA   #$00
C6AD: 28 88          BVC    $C6AF
C6AF: 88 24          EORA   #$06
C6B1: 22 82          BHI    $C6B3
C6B3: 82 23          SBCA   #$01
C6B5: 22 83          BHI    $C6B8
C6B7: 82 08          SBCA   #$20
C6B9: 58             ASLB
C6BA: 88 88          EORA   #$00
C6BC: 82 A4          SBCA   #$8C
C6BE: 88 59          EORA   #$D1
C6C0: BC 42 C2       CMPX   $6040
C6C3: 80 22          SUBA   #$00
C6C5: 22 82          BHI    $C6C7
C6C7: 82 24          SBCA   #$0C
C6C9: 28 77          BVC    $C6CA
C6CB: 88 28          EORA   #$00
C6CD: 28 88          BVC    $C6CF
C6CF: 88 25          EORA   #$07
C6D1: 22 82          BHI    $C6D3
C6D3: 82 23          SBCA   #$01
C6D5: 22 82          BHI    $C6D7
C6D7: 82 A8          SBCA   #$80
C6D9: 58             ASLB
C6DA: 88 88          EORA   #$00
C6DC: 88 A6          EORA   #$8E
C6DE: 88 46          EORA   #$CE
C6E0: D4 42          ANDB   $60
C6E2: 42             XNCA
C6E3: 82 22          SBCA   #$00
C6E5: 22 82          BHI    $C6E7
C6E7: 82 24          SBCA   #$0C
C6E9: 28 77          BVC    $C6EA
C6EB: 88 28          EORA   #$00
C6ED: 28 88          BVC    $C6EF
C6EF: 88 2A          EORA   #$08
C6F1: 22 82          BHI    $C6F3
C6F3: 82 22          SBCA   #$00
C6F5: 22 82          BHI    $C6F7
C6F7: 82 28          SBCA   #$00
C6F9: 28 88          BVC    $C6FB
C6FB: 88 88          EORA   #$A0
C6FD: A2 88          SBCA   $0,X
C6FF: 46             RORA
C700: D4 42          ANDB   $60
C702: C2 83          SBCB   #$01
C704: 22 22          BHI    $C706
C706: 82 82          SBCA   #$00
C708: 24 28          BCC    $C70A
C70A: 77 88 28       ASR    >$0000
C70D: 28 88          BVC    $C70F
C70F: 88 22          EORA   #$00
C711: 22 82          BHI    $C713
C713: 82 20          SBCA   #$02
C715: 22 CE          BHI    $C763
C717: 4C             INCA
C718: 04 58          LSR    $70
C71A: 98 98          EORA   $10
C71C: 38 28          XANDCC #$00
C71E: 88 88          EORA   #$00
C720: 22 22          BHI    $C722
C722: 82 82          SBCA   #$00
C724: 23 22          BLS    $C726
C726: CE 5A 04       LDU    #$D82C
C729: E8 98          EORB   -$10,X
C72B: 98 38          EORA   $10
C72D: 28 88          BVC    $C72F
C72F: 88 22          EORA   #$00
C731: 22 82          BHI    $C733
C733: 82 20          SBCA   #$02
C735: 22 CC          BHI    $C785
C737: 63 9C          COM    [,Y]
C739: 20 98          BRA    $C74B
C73B: 98 38          EORA   $10
C73D: 28 88          BVC    $C73F
C73F: 88 22          EORA   #$00
C741: 22 82          BHI    $C743
C743: 82 23          SBCA   #$01
C745: 22 CD          BHI    $C796
C747: 8C 94 58       CMPX   #$BC70
C74A: 98 98          EORA   $10
C74C: 38 28          XANDCC #$00
C74E: 88 88          EORA   #$00
C750: 22 22          BHI    $C752
C752: 82 82          SBCA   #$00
C754: 23 28          BLS    $C760
C756: 91 1A          CMPA   $98
C758: 3B             RTI
C759: 00 88          NEG    $00
C75B: 88 28          EORA   #$00
C75D: 28 88          BVC    $C75F
C75F: 88 22          EORA   #$00
C761: 22 82          BHI    $C763
C763: 82 23          SBCA   #$01
C765: 29 59          BVS    $C742
C767: 1A 3B          ORCC   #$13
C769: 00 88          NEG    $00
C76B: 88 28          EORA   #$00
C76D: 28 88          BVC    $C76F
C76F: 88 22          EORA   #$00
C771: 22 82          BHI    $C773
C773: 82 23          SBCA   #$01
C775: 29 59          BVS    $C752
C777: 1A F3          ORCC   #$DB
C779: 38 88          XANDCC #$00
C77B: 88 28          EORA   #$00
C77D: 28 88          BVC    $C77F
C77F: 88 22          EORA   #$00
C781: 22 82          BHI    $C783
C783: 82 22          SBCA   #$00
C785: 28 91          BVC    $C79A
C787: 1A F3          ORCC   #$DB
C789: 38 88          XANDCC #$00
C78B: 88 28          EORA   #$00
C78D: 28 88          BVC    $C78F
C78F: 88 22          EORA   #$00
C791: 22 82          BHI    $C793
C793: 82 22          SBCA   #$00
C795: 22 82          BHI    $C797
C797: 82 28          SBCA   #$00
C799: E8 88          EORB   $0,X
C79B: 88 88          EORA   #$A0
C79D: 88 88          EORA   #$00
C79F: 1E 01          EXG    Y,U
C7A1: 22 82          BHI    $C7A3
C7A3: 82 22          SBCA   #$00
C7A5: 22 82          BHI    $C7A7
C7A7: 82 D7          SBCA   #$FF
C7A9: 28 89          BVC    $C7AC
C7AB: 88 D7          EORA   #$FF
C7AD: 28 89          BVC    $C7B0
C7AF: 88 22          EORA   #$00
C7B1: 22 82          BHI    $C7B3
C7B3: 82 22          SBCA   #$00
C7B5: 22 82          BHI    $C7B7
C7B7: 82 38          SBCA   #$10
C7B9: 24 88          BCC    $C7BB
C7BB: 88 D7          EORA   #$FF
C7BD: 6D 89          TST    $1,X
C7BF: 0E 5F          JMP    $7D
C7C1: 42             XNCA
C7C2: 82 82          SBCA   #$00
C7C4: 22 22          BHI    $C7C6
C7C6: 82 82          SBCA   #$00
C7C8: D7 D7          STB    $FF
C7CA: 88 88          EORA   #$00
C7CC: D7 D7          STB    $FF
C7CE: 77 77 DD       ASR    $FFFF
C7D1: DD 7D          STD    $FF
C7D3: 7D 23 22       TST    $0100
C7D6: 82 82          SBCA   #$00
C7D8: 38 F8          XANDCC #$D0
C7DA: 88 88          EORA   #$00
C7DC: E8 E8          EORB   ,U+
C7DE: 88 2C          EORA   #$A4
C7E0: 80 22          SUBA   #$00
C7E2: 82 82          SBCA   #$00
C7E4: 22 22          BHI    $C7E6
C7E6: 82 82          SBCA   #$00
C7E8: 28 28          BVC    $C7EA
C7EA: 88 88          EORA   #$00
C7EC: 28 28          BVC    $C7EE
C7EE: 88 88          EORA   #$00
C7F0: 22 22          BHI    $C7F2
C7F2: 82 82          SBCA   #$00
C7F4: 23 77          BLS    $C84B
C7F6: E0 8A          SUBB   $8,X
C7F8: 29 BD          BVS    $C78F
C7FA: 2A 80          BPL    $C804
C7FC: 29 8D          BVS    $C7A3
C7FE: 3A             ABX
C7FF: A0 23          SUBA   $1,X
C801: 77 E0 CA       ASR    $6248
C804: 23 17          BLS    $C83B
C806: C0 F2          SUBB   #$70
C808: 29 9D          BVS    $C7BF
C80A: 4A             DECA
C80B: F8 29 B5       EORB   $019D
C80E: 22 10          BHI    $C7A8
C810: 23 77          BLS    $C867
C812: E0 42          SUBB   ,U+
C814: 22 22          BHI    $C816
C816: 82 82          SBCA   #$00
C818: 28 28          BVC    $C81A
C81A: 88 88          EORA   #$00
C81C: 28 28          BVC    $C81E
C81E: 88 88          EORA   #$00
C820: 22 22          BHI    $C822
C822: 82 82          SBCA   #$00
C824: 22 22          BHI    $C826
C826: 82 82          SBCA   #$00
C828: 28 28          BVC    $C82A
C82A: 88 88          EORA   #$00
C82C: 28 28          BVC    $C82E
C82E: 88 88          EORA   #$00
C830: 22 22          BHI    $C832
C832: 82 82          SBCA   #$00
C834: 23 22          BLS    $C836
C836: D7 8A          STB    $08
C838: 29 4A          BVS    $C89C
C83A: 1D             SEX
C83B: 80 29          SUBA   #$01
C83D: 8A 77          ORA    #$FF
C83F: 80 23          SUBA   #$01
C841: 22 27          BHI    $C7E8
C843: AA 23          ORA    $1,X
C845: 90 7D          SUBA   $FF
C847: AA 29          ORA    $1,X
C849: 28 DD          BVC    $C8A0
C84B: C0 29          SUBB   #$01
C84D: 4A             DECA
C84E: 77 C0 23       ASR    $4801
C851: 22 B7          BHI    $C888
C853: F2 23 60       SBCB   $0142
C856: 37 F2          PULU   X,Y,S
C858: 29 EA          BVS    $C81C
C85A: 77 F8 29       ASR    $7001
C85D: 28 15          BVC    $C7FC
C85F: 10 23 88 7D    LBLS   $7362
C863: 1A 23          ORCC   #$01
C865: 22 D7          BHI    $C8BC
C867: 42             XNCA
C868: 29 4A          BVS    $C8CC
C86A: 77 48 28       ASR    $C000
C86D: 28 88          BVC    $C86F
C86F: 88 22          EORA   #$00
C871: 22 82          BHI    $C873
C873: 82 22          SBCA   #$00
C875: 22 82          BHI    $C877
C877: 82 28          SBCA   #$00
C879: 28 88          BVC    $C87B
C87B: 88 28          EORA   #$00
C87D: 28 88          BVC    $C87F
C87F: 88 22          EORA   #$00
C881: 22 82          BHI    $C883
C883: 82 22          SBCA   #$00
C885: 22 82          BHI    $C887
C887: 82 28          SBCA   #$00
C889: 28 88          BVC    $C88B
C88B: 88 28          EORA   #$00
C88D: 28 88          BVC    $C88F
C88F: 88 22          EORA   #$00
C891: 22 82          BHI    $C893
C893: 82 23          SBCA   #$01
C895: 19             DAA
C896: AA 9E          ORA    -$4,X
C898: 29 1B          BVS    $C8CD
C89A: C0 B4          SUBB   #$3C
C89C: 29 9B          BVS    $C851
C89E: C0 B4          SUBB   #$3C
C8A0: 23 79          BLS    $C8FD
C8A2: F2 E2 23       SBCB   $6001
C8A5: 81 F2          CMPA   #$70
C8A7: E2 29          SBCB   $1,X
C8A9: 73 10 00       COM    $9888
C8AC: 29 63          BVS    $C8F9
C8AE: 48             ASLA
C8AF: 38 23          XANDCC #$01
C8B1: B9 42 32       ADCA   $C0B0
C8B4: 22 22          BHI    $C8B6
C8B6: 82 82          SBCA   #$00
C8B8: 28 28          BVC    $C8BA
C8BA: 88 88          EORA   #$00
C8BC: 28 28          BVC    $C8BE
C8BE: 88 88          EORA   #$00
C8C0: 22 22          BHI    $C8C2
C8C2: 82 82          SBCA   #$00
C8C4: 22 22          BHI    $C8C6
C8C6: 82 82          SBCA   #$00
C8C8: 28 28          BVC    $C8CA
C8CA: 88 88          EORA   #$00
C8CC: 28 28          BVC    $C8CE
C8CE: 88 88          EORA   #$00
C8D0: 22 22          BHI    $C8D2
C8D2: 82 82          SBCA   #$00
C8D4: 3A             ABX
C8D5: 22 FA          BHI    $C94F
C8D7: 82 F4          SBCA   #$DC
C8D9: 28 08          BVC    $C85B
C8DB: F0 C8 F4       SUBB   $E0DC
C8DE: A8 AE          EORA   $6,Y
C8E0: FA A2 9A       ORB    $8018
C8E3: A2 A2          SBCA   ,X+
C8E5: 5A             DECB
C8E6: 62 5A A8       XNC    [-$80,U]
C8E9: 30 5A          LEAX   Illegal Postbyte
C8EB: 68 28          ASL    $0,X
C8ED: 37 88          PULU   
C8EF: 08 22          ASL    $00
C8F1: 22 82          BHI    $C8F3
C8F3: 82 22          SBCA   #$00
C8F5: 22 82          BHI    $C8F7
C8F7: 82 28          SBCA   #$00
C8F9: 28 88          BVC    $C8FB
C8FB: 88 28          EORA   #$00
C8FD: 28 88          BVC    $C8FF
C8FF: 88 22          EORA   #$00
C901: 22 82          BHI    $C903
C903: 82 22          SBCA   #$00
C905: 24 86          BCC    $C90B
C907: 8A 14          ORA    #$3C
C909: 2A B4          BPL    $C947
C90B: 88 2C          EORA   #$04
C90D: 2C 84          BGE    $C91B
C90F: 84 22          ANDA   #$00
C911: 22 82          BHI    $C913
C913: 82 EA          SBCA   #$C8
C915: 86 56          LDA    #$D4
C917: 2A F0          BPL    $C8F1
C919: E0 22          SUBB   F,Y
C91B: 81 28          CMPA   #$00
C91D: 28 D8          BVC    $C96F
C91F: 88 DD          EORA   #$FF
C921: DD 7D          STD    $FF
C923: 7D 23 22       TST    $0100
C926: 82 82          SBCA   #$00
C928: E8 20          EORB   $8,X
C92A: 88 88          EORA   #$00
C92C: E8 88          EORB   ,Y+
C92E: 88 46          EORA   #$CE
C930: D4 42          ANDB   $60
C932: C2 82          SBCB   #$00
C934: 22 22          BHI    $C936
C936: 82 82          SBCA   #$00
C938: 24 28          BCC    $C93A
C93A: 77 88 28       ASR    >$0000
C93D: 28 88          BVC    $C93F
C93F: 88 23          EORA   #$01
C941: 22 82          BHI    $C943
C943: 82 23          SBCA   #$01
C945: 22 83          BHI    $C948
C947: 82 E8          SBCA   #$C0
C949: 00 88          NEG    $00
C94B: 88 E0          EORA   #$C8
C94D: 80 88          SUBA   #$00
C94F: 59             ROLB
C950: BC 42 42       CMPX   $60C0
C953: 80 22          SUBA   #$00
C955: 22 82          BHI    $C957
C957: 82 24          SBCA   #$0C
C959: 28 77          BVC    $C95A
C95B: 88 28          EORA   #$00
C95D: 28 88          BVC    $C95F
C95F: 88 20          EORA   #$02
C961: 22 82          BHI    $C963
C963: 82 23          SBCA   #$01
C965: 22 83          BHI    $C968
C967: 82 50          SBCA   #$78
C969: 48             ASLA
C96A: 88 88          EORA   #$00
C96C: E0 80 88       SUBB   $00,Y
C96F: 59             ROLB
C970: BC 42 42       CMPX   $60C0
C973: 82 22          SBCA   #$00
C975: 22 82          BHI    $C977
C977: 82 24          SBCA   #$0C
C979: 28 77          BVC    $C97A
C97B: 88 28          EORA   #$00
C97D: 28 88          BVC    $C97F
C97F: 88 25          EORA   #$07
C981: 22 82          BHI    $C983
C983: 82 23          SBCA   #$01
C985: 22 82          BHI    $C987
C987: 82 A0          SBCA   #$88
C989: AC 88          CMPX   $0,X
C98B: 88 E8          EORA   #$C0
C98D: 88 88          EORA   #$00
C98F: 46             RORA
C990: D4 42          ANDB   $60
C992: C2 80          SBCB   #$02
C994: 22 22          BHI    $C996
C996: 82 82          SBCA   #$00
C998: 24 28          BCC    $C99A
C99A: 77 88 28       ASR    >$0000
C99D: 28 88          BVC    $C99F
C99F: 88 2B          EORA   #$09
C9A1: 22 82          BHI    $C9A3
C9A3: 82 23          SBCA   #$01
C9A5: 22 82          BHI    $C9A7
C9A7: 82 08          SBCA   #$20
C9A9: A0 88          SUBA   $0,X
C9AB: 88 E8          EORA   #$C0
C9AD: 88 88          EORA   #$00
C9AF: 46             RORA
C9B0: D4 42          ANDB   $60
C9B2: 42             XNCA
C9B3: 82 22          SBCA   #$00
C9B5: 22 82          BHI    $C9B7
C9B7: 82 24          SBCA   #$0C
C9B9: 28 77          BVC    $C9BA
C9BB: 88 28          EORA   #$00
C9BD: 28 88          BVC    $C9BF
C9BF: 88 28          EORA   #$0A
C9C1: 22 82          BHI    $C9C3
C9C3: 82 22          SBCA   #$00
C9C5: 22 82          BHI    $C9C7
C9C7: 82 28          SBCA   #$00
C9C9: 28 88          BVC    $C9CB
C9CB: 88 E8          EORA   #$C0
C9CD: 88 88          EORA   #$00
C9CF: 46             RORA
C9D0: D4 42          ANDB   $60
C9D2: C2 83          SBCB   #$01
C9D4: 22 22          BHI    $C9D6
C9D6: 82 82          SBCA   #$00
C9D8: 24 28          BCC    $C9DA
C9DA: 77 88 28       ASR    >$0000
C9DD: 28 88          BVC    $C9DF
C9DF: 88 22          EORA   #$00
C9E1: 22 82          BHI    $C9E3
C9E3: 82 20          SBCA   #$02
C9E5: 22 CE          BHI    $CA33
C9E7: 44             LSRA
C9E8: 04 18          LSR    $30
C9EA: 08 08          ASL    $80
C9EC: A8 28          EORA   $0,X
C9EE: 88 88          EORA   #$00
C9F0: 22 22          BHI    $C9F2
C9F2: 82 82          SBCA   #$00
C9F4: 23 22          BLS    $C9F6
C9F6: CF BB 6C       XSTU   #$3944
C9F9: E0 08          SUBB   ,X+
C9FB: 08 A8          ASL    $80
C9FD: 28 88          BVC    $C9FF
C9FF: 88 22          EORA   #$00
CA01: 22 82          BHI    $CA03
CA03: 82 23          SBCA   #$01
CA05: 22 CD          BHI    $CA56
CA07: 0B F4          XDEC   $DC
CA09: 60 08          NEG    ,X+
CA0B: 08 45          ASL    $6D
CA0D: 28 88          BVC    $CA0F
CA0F: 08 22          ASL    $00
CA11: 22 82          BHI    $CA13
CA13: 82 20          SBCA   #$02
CA15: 22 CC          BHI    $CA65
CA17: F2 BC AC       SBCB   $9484
CA1A: E4 08          ANDB   ,X+
CA1C: A8 A8          EORA   ,X+
CA1E: 88 88          EORA   #$00
CA20: 22 22          BHI    $CA22
CA22: 82 82          SBCA   #$00
CA24: 23 2C          BLS    $CA34
CA26: 97 4A          STA    $C8
CA28: 3D             MUL
CA29: 18             X18
CA2A: 88 88          EORA   #$00
CA2C: 28 28          BVC    $CA2E
CA2E: 88 88          EORA   #$00
CA30: 22 22          BHI    $CA32
CA32: 82 82          SBCA   #$00
CA34: 23 2B          BLS    $CA3F
CA36: 47             ASRA
CA37: 06 3D          ROR    $15
CA39: 18             X18
CA3A: 88 88          EORA   #$00
CA3C: 28 28          BVC    $CA3E
CA3E: 88 88          EORA   #$00
CA40: 22 22          BHI    $CA42
CA42: 82 82          SBCA   #$00
CA44: 23 2B          BLS    $CA4F
CA46: 47             ASRA
CA47: 06 F5          ROR    $DD
CA49: 20 88          BRA    $CA4B
CA4B: 88 28          EORA   #$00
CA4D: 28 88          BVC    $CA4F
CA4F: 88 22          EORA   #$00
CA51: 22 82          BHI    $CA53
CA53: 82 22          SBCA   #$00
CA55: 2F DF          BLE    $CAB4
CA57: 2A F5          BPL    $CA36
CA59: 20 88          BRA    $CA5B
CA5B: 88 28          EORA   #$00
CA5D: 28 88          BVC    $CA5F
CA5F: 88 22          EORA   #$00
CA61: 22 82          BHI    $CA63
CA63: 82 23          SBCA   #$01
CA65: 22 82          BHI    $CA67
CA67: 82 28          SBCA   #$00
CA69: E8 88          EORB   $0,X
CA6B: 88 88          EORA   #$A0
CA6D: 88 88          EORA   #$00
CA6F: 1E 01          EXG    Y,U
CA71: 22 82          BHI    $CA73
CA73: 82 22          SBCA   #$00
CA75: 22 82          BHI    $CA77
CA77: 82 D7          SBCA   #$FF
CA79: 28 89          BVC    $CA7C
CA7B: 88 D7          EORA   #$FF
CA7D: 28 89          BVC    $CA80
CA7F: 88 22          EORA   #$00
CA81: 22 82          BHI    $CA83
CA83: 82 22          SBCA   #$00
CA85: 22 82          BHI    $CA87
CA87: 82 38          SBCA   #$10
CA89: 24 88          BCC    $CA8B
CA8B: 88 D7          EORA   #$FF
CA8D: 6D 89          TST    $1,X
CA8F: 0E 5F          JMP    $7D
CA91: 42             XNCA
CA92: 82 82          SBCA   #$00
CA94: 22 22          BHI    $CA96
CA96: 82 82          SBCA   #$00
CA98: D7 D7          STB    $FF
CA9A: 88 88          EORA   #$00
CA9C: D7 D7          STB    $FF
CA9E: 77 77 DD       ASR    $FFFF
CAA1: DD 7D          STD    $FF
CAA3: 7D 23 22       TST    $0100
CAA6: 82 82          SBCA   #$00
CAA8: 38 F8          XANDCC #$D0
CAAA: 88 88          EORA   #$00
CAAC: E0 E0 88       SUBB   $00,U
CAAF: 2C 80          BGE    $CA53
CAB1: 22 82          BHI    $CAB3
CAB3: 82 22          SBCA   #$00
CAB5: 22 82          BHI    $CAB7
CAB7: 82 28          SBCA   #$00
CAB9: 28 88          BVC    $CABB
CABB: 88 28          EORA   #$00
CABD: 28 88          BVC    $CABF
CABF: 88 22          EORA   #$00
CAC1: 22 82          BHI    $CAC3
CAC3: 82 23          SBCA   #$01
CAC5: 22 82          BHI    $CAC7
CAC7: 82 28          SBCA   #$00
CAC9: 28 88          BVC    $CACB
CACB: 88 38          EORA   #$10
CACD: 08 89          ASL    $01
CACF: 89 32          ADCA   #$10
CAD1: 36 82          PSHU   
CAD3: 82 6C          SBCA   #$4E
CAD5: 27 C2          BEQ    $CB17
CAD7: 40             NEGA
CAD8: 28 28          BVC    $CADA
CADA: 85 DE          BITA   #$56
CADC: B1 B5 22       CMPA   $9DAA
CADF: E4 99          ANDB   [D,Y]
CAE1: E5 CF          BITB   $D,U
CAE3: 1F 88          TFR    CC,CC
CAE5: 0C 02          INC    $80
CAE7: 0E 65          JMP    $4D
CAE9: 68 C7          ASL    $F,U
CAEB: B1 68 67       CMPA   $404F
CAEE: B4 C8 6D       ANDA   $404F
CAF1: 66 C2          ROR    $0,U
CAF3: CD             XHCF
CAF4: 6D 62          TST    $0,U
CAF6: CD             XHCF
CAF7: E7 68          STB    $0,U
CAF9: 67 0E          ASR    A,X
CAFB: C8 67          EORB   #$4F
CAFD: B4 C8 C7       ANDA   $404F
CB00: 8A 62          ORA    #$40
CB02: CD             XHCF
CB03: 32 23          LEAS   $1,X
CB05: 2C F1          BGE    $CB7A
CB07: 8A 29          ORA    #$01
CB09: 54             LSRB
CB0A: 77 80 29       ASR    $0801
CB0D: 80 77          SUBA   #$FF
CB0F: A0 23          SUBA   $1,X
CB11: 22 B5          BHI    $CB4A
CB13: B2 23 72       SBCA   $0150
CB16: 05 BA          LSR    $38
CB18: 29 E0          BVS    $CAE2
CB1A: 77 C0 29       ASR    $4801
CB1D: 3C B3          CWAI   #$3B
CB1F: E8 23          EORB   $1,X
CB21: 76 05 E2       ROR    $8760
CB24: 23 E1          BLS    $CAE9
CB26: 6D E6          TST    $4,S
CB28: 29 7C          BVS    $CB7E
CB2A: 6B 0C          XDEC   ,X
CB2C: 29 38          BVS    $CB3E
CB2E: B3 00 23       SUBD   $8801
CB31: 36 B9          PSHU   Y,X,DP,A,CC
CB33: 26 23          BNE    $CB36
CB35: 86 7D          LDA    #$FF
CB37: 26 29          BNE    $CB3A
CB39: 7C 07 20       INC    $8FA8
CB3C: 29 28          BVS    $CB3E
CB3E: EF 40 23       STU    $01,U
CB41: 5A             DECB
CB42: 2D 4A          BLT    $CB0C
CB44: 23 9A          BLS    $CAFE
CB46: 7D 4A 28       TST    $C800
CB49: 28 88          BVC    $CB4B
CB4B: 88 28          EORA   #$00
CB4D: 28 88          BVC    $CB4F
CB4F: 88 22          EORA   #$00
CB51: 22 82          BHI    $CB53
CB53: 82 22          SBCA   #$00
CB55: 22 82          BHI    $CB57
CB57: 82 28          SBCA   #$00
CB59: 28 88          BVC    $CB5B
CB5B: 88 28          EORA   #$00
CB5D: 28 88          BVC    $CB5F
CB5F: 88 22          EORA   #$00
CB61: 22 82          BHI    $CB63
CB63: 82 23          SBCA   #$01
CB65: 06 B2          ROR    $30
CB67: A2 29          SBCA   $1,X
CB69: 44             LSRA
CB6A: B0 A8 29       SUBA   $2001
CB6D: 9C 0C          CMPX   $84
CB6F: F8 23 E6       EORB   $01C4
CB72: 26 1A          BNE    $CB0C
CB74: 23 A6          BLS    $CAFA
CB76: 2A 1A          BPL    $CB10
CB78: 29 04          BVS    $CBA6
CB7A: 40             NEGA
CB7B: 30 29          LEAX   $1,X
CB7D: A4 40 34       ANDA   -$44,U
CB80: 22 22          BHI    $CB82
CB82: 82 82          SBCA   #$00
CB84: 22 22          BHI    $CB86
CB86: 82 82          SBCA   #$00
CB88: 28 28          BVC    $CB8A
CB8A: 88 88          EORA   #$00
CB8C: 28 28          BVC    $CB8E
CB8E: 88 88          EORA   #$00
CB90: 22 22          BHI    $CB92
CB92: 82 82          SBCA   #$00
CB94: 22 22          BHI    $CB96
CB96: 82 82          SBCA   #$00
CB98: 28 28          BVC    $CB9A
CB9A: 88 88          EORA   #$00
CB9C: 28 28          BVC    $CB9E
CB9E: 88 88          EORA   #$00
CBA0: 22 22          BHI    $CBA2
CBA2: 82 82          SBCA   #$00
CBA4: 36 22          PSHU   
CBA6: 42             XNCA
CBA7: 82 C8          SBCA   #$E0
CBA9: E8 A0          EORB   $8,Y
CBAB: 9C 40          CMPX   $68
CBAD: 70 58 68       NEG    $D0E0
CBB0: 0A 02          DEC    $20
CBB2: FA EA EA       ORB    $68C8
CBB5: F2 EA FA       SBCB   $6878
CBB8: 3C 00          CWAI   #$28
CBBA: 90 9C          SUBA   $14
CBBC: 28 28          BVC    $CBBE
CBBE: F1 E0 22       CMPB   $6800
CBC1: 7A 82 FB       DEC    >$0079
CBC4: 22 22          BHI    $CBC6
CBC6: 82 82          SBCA   #$00
CBC8: 28 28          BVC    $CBCA
CBCA: 88 88          EORA   #$00
CBCC: 28 28          BVC    $CBCE
CBCE: 88 88          EORA   #$00
CBD0: 22 22          BHI    $CBD2
CBD2: 82 82          SBCA   #$00
CBD4: 22 24          BHI    $CBDC
CBD6: 86 8A          LDA    #$08
CBD8: 14             XHCF
CBD9: 2A B4          BPL    $CC17
CBDB: 88 2C          EORA   #$04
CBDD: 2C 84          BGE    $CBEB
CBDF: 84 22          ANDA   #$00
CBE1: 22 82          BHI    $CBE3
CBE3: 82 F6          SBCA   #$D4
CBE5: 94 56          ANDA   $D4
CBE7: 32 C8          LEAS   ,S+
CBE9: EC 2C          LDD    ,Y
CBEB: 81 28          CMPA   #$00
CBED: 28 D8          BVC    $CC3F
CBEF: 88 DD          EORA   #$FF
CBF1: DD 7D          STD    $FF
CBF3: 7D 23 22       TST    $0100
CBF6: 83 82 68       SUBD   #$0040
CBF9: 18             X18
CBFA: 88 88          EORA   #$00
CBFC: F8 98 88       EORB   $B000
CBFF: 59             ROLB
CC00: BC 42 C2       CMPX   $6040
CC03: 80 22          SUBA   #$00
CC05: 22 82          BHI    $CC07
CC07: 82 24          SBCA   #$0C
CC09: 28 77          BVC    $CC0A
CC0B: 88 28          EORA   #$00
CC0D: 28 88          BVC    $CC0F
CC0F: 88 20          EORA   #$02
CC11: 22 82          BHI    $CC13
CC13: 82 23          SBCA   #$01
CC15: 22 83          BHI    $CC18
CC17: 82 E0          SBCA   #$C8
CC19: 38 88          XANDCC #$00
CC1B: 88 F8          EORA   #$D0
CC1D: 98 88          EORA   $00
CC1F: 59             ROLB
CC20: BC 42 42       CMPX   $60C0
CC23: 82 22          SBCA   #$00
CC25: 22 82          BHI    $CC27
CC27: 82 24          SBCA   #$0C
CC29: 28 77          BVC    $CC2A
CC2B: 88 28          EORA   #$00
CC2D: 28 88          BVC    $CC2F
CC2F: 88 23          EORA   #$01
CC31: 22 82          BHI    $CC33
CC33: 82 23          SBCA   #$01
CC35: 22 82          BHI    $CC37
CC37: 82 E0          SBCA   #$C8
CC39: 10 88 88       EORA   #$00
CC3C: E0 90 88       SUBB   [$00,Y]
CC3F: 46             RORA
CC40: D4 42          ANDB   $60
CC42: C2 80          SBCB   #$02
CC44: 22 22          BHI    $CC46
CC46: 82 82          SBCA   #$00
CC48: 24 28          BCC    $CC4A
CC4A: 77 88 28       ASR    >$0000
CC4D: 28 88          BVC    $CC4F
CC4F: 88 21          EORA   #$03
CC51: 22 82          BHI    $CC53
CC53: 82 23          SBCA   #$01
CC55: 22 82          BHI    $CC57
CC57: 82 98          SBCA   #$B0
CC59: 48             ASLA
CC5A: 88 88          EORA   #$00
CC5C: E0 F0 88       SUBB   [$00,U]
CC5F: 46             RORA
CC60: D4 42          ANDB   $60
CC62: 42             XNCA
CC63: 82 22          SBCA   #$00
CC65: 22 82          BHI    $CC67
CC67: 82 24          SBCA   #$0C
CC69: 28 77          BVC    $CC6A
CC6B: 88 28          EORA   #$00
CC6D: 28 88          BVC    $CC6F
CC6F: 88 27          EORA   #$05
CC71: 22 82          BHI    $CC73
CC73: 82 23          SBCA   #$01
CC75: 22 82          BHI    $CC77
CC77: 82 78          SBCA   #$50
CC79: 58             ASLB
CC7A: 88 88          EORA   #$00
CC7C: E0 F0 88       SUBB   [$00,U]
CC7F: 46             RORA
CC80: D4 42          ANDB   $60
CC82: 42             XNCA
CC83: 82 22          SBCA   #$00
CC85: 22 82          BHI    $CC87
CC87: 82 24          SBCA   #$0C
CC89: 28 77          BVC    $CC8A
CC8B: 88 28          EORA   #$00
CC8D: 28 88          BVC    $CC8F
CC8F: 88 24          EORA   #$06
CC91: 22 82          BHI    $CC93
CC93: 82 22          SBCA   #$00
CC95: 22 82          BHI    $CC97
CC97: 82 28          SBCA   #$00
CC99: 28 88          BVC    $CC9B
CC9B: 88 E0          EORA   #$C8
CC9D: 80 88          SUBA   #$00
CC9F: 46             RORA
CCA0: D4 42          ANDB   $60
CCA2: 42             XNCA
CCA3: 82 22          SBCA   #$00
CCA5: 22 82          BHI    $CCA7
CCA7: 82 24          SBCA   #$0C
CCA9: 28 77          BVC    $CCAA
CCAB: 88 28          EORA   #$00
CCAD: 28 88          BVC    $CCAF
CCAF: 88 22          EORA   #$00
CCB1: 22 82          BHI    $CCB3
CCB3: 82 23          SBCA   #$01
CCB5: 22 CF          BHI    $CD04
CCB7: AC 6C          CMPX   $4,U
CCB9: 58             ASLB
CCBA: 63 25 D9 08    COM    $BDDE,PCR
CCBE: 88 88          EORA   #$00
CCC0: 22 22          BHI    $CCC2
CCC2: 82 82          SBCA   #$00
CCC4: 20 22          BRA    $CCC6
CCC6: CD             XHCF
CCC7: 80 94          SUBA   #$BC
CCC9: 38 F5          XANDCC #$7D
CCCB: 56             RORB
CCCC: 85 28          BITA   #$00
CCCE: A8 88          EORA   $0,X
CCD0: 22 22          BHI    $CCD2
CCD2: 82 82          SBCA   #$00
CCD4: 23 22          BLS    $CCD6
CCD6: CD             XHCF
CCD7: B4 EC 98       ANDA   $C4B0
CCDA: 08 08          ASL    $80
CCDC: A8 28          EORA   $0,X
CCDE: 88 88          EORA   #$00
CCE0: 22 22          BHI    $CCE2
CCE2: 82 82          SBCA   #$00
CCE4: 20 22          BRA    $CCE6
CCE6: CC 8D 54       LDD    #$0F7C
CCE9: 50             NEGB
CCEA: F5 F5 55       BITB   $7D7D
CCED: 28 88          BVC    $CCEF
CCEF: 88 22          EORA   #$00
CCF1: 22 82          BHI    $CCF3
CCF3: 82 23          SBCA   #$01
CCF5: 2A C6          BPL    $CD3B
CCF7: 12             NOP
CCF8: 04 18          LSR    $30
CCFA: 88 88          EORA   #$00
CCFC: 28 28          BVC    $CCFE
CCFE: 88 88          EORA   #$00
CD00: 22 22          BHI    $CD02
CD02: 82 82          SBCA   #$00
CD04: 23 2B          BLS    $CD0F
CD06: 2E 12          BGT    $CC98
CD08: 04 18          LSR    $30
CD0A: 88 88          EORA   #$00
CD0C: 28 28          BVC    $CD0E
CD0E: 88 88          EORA   #$00
CD10: 22 22          BHI    $CD12
CD12: 82 82          SBCA   #$00
CD14: 23 2B          BLS    $CD1F
CD16: 2E 12          BGT    $CCA8
CD18: 94 10          ANDA   $38
CD1A: 88 88          EORA   #$00
CD1C: 28 28          BVC    $CD1E
CD1E: 88 88          EORA   #$00
CD20: 22 22          BHI    $CD22
CD22: 82 82          SBCA   #$00
CD24: 23 2A          BLS    $CD2E
CD26: C6 12          LDB    #$90
CD28: 94 10          ANDA   $38
CD2A: 88 88          EORA   #$00
CD2C: 28 28          BVC    $CD2E
CD2E: 88 88          EORA   #$00
CD30: 22 22          BHI    $CD32
CD32: 82 82          SBCA   #$00
CD34: 22 22          BHI    $CD36
CD36: 82 82          SBCA   #$00
CD38: 28 E8          BVC    $CCFA
CD3A: 88 88          EORA   #$00
CD3C: 88 88          EORA   #$A0
CD3E: 88 1E          EORA   #$96
CD40: 01 22          NEG    $00
CD42: 82 82          SBCA   #$00
CD44: 22 22          BHI    $CD46
CD46: 82 82          SBCA   #$00
CD48: D7 28          STB    $00
CD4A: 89 88          ADCA   #$00
CD4C: D7 28          STB    $00
CD4E: 89 88          ADCA   #$00
CD50: 22 22          BHI    $CD52
CD52: 82 82          SBCA   #$00
CD54: 22 22          BHI    $CD56
CD56: 82 82          SBCA   #$00
CD58: 38 20          XANDCC #$08
CD5A: 88 88          EORA   #$00
CD5C: D7 6D          STB    $45
CD5E: 89 0E          ADCA   #$86
CD60: 5F             CLRB
CD61: 42             XNCA
CD62: 82 82          SBCA   #$00
CD64: 22 22          BHI    $CD66
CD66: 82 82          SBCA   #$00
CD68: D7 D7          STB    $FF
CD6A: 88 88          EORA   #$00
CD6C: D7 D7          STB    $FF
CD6E: 77 77 DD       ASR    $FFFF
CD71: DD 7D          STD    $FF
CD73: 7D 23 22       TST    $0100
CD76: 82 82          SBCA   #$00
CD78: 38 F8          XANDCC #$D0
CD7A: 88 88          EORA   #$00
CD7C: F8 F8 88       EORB   $D000
CD7F: 2C 80          BGE    $CD23
CD81: 22 82          BHI    $CD83
CD83: 82 22          SBCA   #$00
CD85: 22 82          BHI    $CD87
CD87: 82 28          SBCA   #$00
CD89: 28 88          BVC    $CD8B
CD8B: 88 28          EORA   #$00
CD8D: 28 88          BVC    $CD8F
CD8F: 88 22          EORA   #$00
CD91: 22 82          BHI    $CD93
CD93: 82 23          SBCA   #$01
CD95: 22 82          BHI    $CD97
CD97: 82 28          SBCA   #$00
CD99: 28 88          BVC    $CD9B
CD9B: E8 28          EORB   $0,X
CD9D: 28 88          BVC    $CD9F
CD9F: 88 22          EORA   #$00
CDA1: 22 82          BHI    $CDA3
CDA3: 82 6F          SBCA   #$4D
CDA5: E9 82          ADCB   $0,X
CDA7: 82 28          SBCA   #$00
CDA9: 28 88          BVC    $CDAB
CDAB: 88 5E          EORA   #$76
CDAD: A1 88          CMPA   $0,X
CDAF: 88 22          EORA   #$00
CDB1: 22 82          BHI    $CDB3
CDB3: 82 22          SBCA   #$00
CDB5: 22 CF          BHI    $CE04
CDB7: 82 65          SBCA   #$4D
CDB9: E3 C5          ADDD   $D,U
CDBB: 44             LSRA
CDBC: 28 08          BVC    $CDDE
CDBE: 88 88          EORA   #$00
CDC0: 22 22          BHI    $CDC2
CDC2: 82 82          SBCA   #$00
CDC4: 22 22          BHI    $CDC6
CDC6: 82 82          SBCA   #$00
CDC8: 28 28          BVC    $CDCA
CDCA: 88 88          EORA   #$00
CDCC: 28 28          BVC    $CDCE
CDCE: 88 88          EORA   #$00
CDD0: 22 22          BHI    $CDD2
CDD2: 82 82          SBCA   #$00
CDD4: 23 22          BLS    $CDD6
CDD6: EC 8A          LDD    $8,X
CDD8: 29 B9          BVS    $CD6B
CDDA: 77 98 29       ASR    $1001
CDDD: 38 E6          XANDCC #$6E
CDDF: B8 23 B3       EORA   $0191
CDE2: 6C BA          INC    -$8,Y
CDE4: 23 32          BLS    $CDF6
CDE6: EC DA          LDD    -$8,U
CDE8: 29 B9          BVS    $CD7B
CDEA: 6E E8          JMP    $0,S
CDEC: 29 31          BVS    $CE07
CDEE: E6 F8          LDB    -$10,S
CDF0: 23 43          BLS    $CE53
CDF2: 1C FA          ANDCC  #$78
CDF4: 23 03          BLS    $CE17
CDF6: F4 12 29       ANDB   $9001
CDF9: B9 56 18       ADCA   $DE90
CDFC: 29 01          BVS    $CE27
CDFE: EE 38 23 BB    LDU    [$0199,W]
CE02: 54             LSRB
CE03: 32 23          LEAS   $1,X
CE05: 1B             NOP
CE06: F4 3A 29       ANDB   $B801
CE09: 41             NEGA
CE0A: 16 40 28       LBRA   $960D
CE0D: 28 88          BVC    $CE0F
CE0F: 88 22          EORA   #$00
CE11: 22 82          BHI    $CE13
CE13: 82 22          SBCA   #$00
CE15: 22 82          BHI    $CE17
CE17: 82 28          SBCA   #$00
CE19: 28 88          BVC    $CE1B
CE1B: 88 28          EORA   #$00
CE1D: 28 88          BVC    $CE1F
CE1F: 88 22          EORA   #$00
CE21: 22 82          BHI    $CE23
CE23: 82 22          SBCA   #$00
CE25: 22 82          BHI    $CE27
CE27: 82 28          SBCA   #$00
CE29: 28 88          BVC    $CE2B
CE2B: 88 28          EORA   #$00
CE2D: 28 88          BVC    $CE2F
CE2F: 88 22          EORA   #$00
CE31: 22 82          BHI    $CE33
CE33: 82 23          SBCA   #$01
CE35: 0E B2          JMP    $30
CE37: A2 29          SBCA   $1,X
CE39: 94 B0          ANDA   $38
CE3B: A0 29          SUBA   $1,X
CE3D: 14             XHCF
CE3E: D0 C0          SUBB   $48
CE40: 23 F6          BLS    $CE16
CE42: E2 D2          SBCB   -$10,U
CE44: 23 66          BLS    $CE8A
CE46: 12             NOP
CE47: 06 29          ROR    $01
CE49: 9C 18          CMPX   $90
CE4B: 08 29          ASL    $01
CE4D: 14             XHCF
CE4E: 38 2C          XANDCC #$A4
CE50: 23 E6          BLS    $CE16
CE52: 32 26          LEAS   ,Y
CE54: 22 22          BHI    $CE56
CE56: 82 82          SBCA   #$00
CE58: 28 28          BVC    $CE5A
CE5A: 88 88          EORA   #$00
CE5C: 28 28          BVC    $CE5E
CE5E: 88 88          EORA   #$00
CE60: 22 22          BHI    $CE62
CE62: 82 82          SBCA   #$00
CE64: 22 22          BHI    $CE66
CE66: 82 82          SBCA   #$00
CE68: 28 28          BVC    $CE6A
CE6A: 88 88          EORA   #$00
CE6C: 28 28          BVC    $CE6E
CE6E: 88 88          EORA   #$00
CE70: 22 22          BHI    $CE72
CE72: 82 82          SBCA   #$00
CE74: 62 22          XNC    $0,X
CE76: 22 82          BHI    $CE78
CE78: 78 68 38       ASL    $40B0
CE7B: 28 10          BVC    $CEB5
CE7D: 78 40 38       ASL    $C8B0
CE80: 0E 1A          JMP    $38
CE82: 82 82          SBCA   #$00
CE84: 7A 12 1C       DEC    $309E
CE87: 4A             DECA
CE88: 28 70          BVC    $CEE2
CE8A: 88 28          EORA   #$A0
CE8C: 28 28          BVC    $CE8E
CE8E: 88 88          EORA   #$00
CE90: 22 22          BHI    $CE92
CE92: 82 82          SBCA   #$00
CE94: 22 22          BHI    $CE96
CE96: 82 82          SBCA   #$00
CE98: 28 28          BVC    $CE9A
CE9A: 88 88          EORA   #$00
CE9C: 28 28          BVC    $CE9E
CE9E: 88 88          EORA   #$00
CEA0: 22 22          BHI    $CEA2
CEA2: 82 82          SBCA   #$00
CEA4: EC D4          LDD    [A,S]
CEA6: 53             COMB
CEA7: 1C E7          ANDCC  #$CF
CEA9: 6A 59          DEC    [,U++]
CEAB: 62 E7          XNC    ,W++
CEAD: A6 5A          LDA    Illegal Postbyte
CEAF: BE ED F8       LDX    $CFDA
CEB2: 50             NEGB
CEB3: 00 F2          NEG    $D0
CEB5: 38 50          XANDCC #$D2
CEB7: 4C             INCA
CEB8: F8 60 5A       EORB   $48D2
CEBB: 74 E6 EC       LSR    $CEC4
CEBE: 46             RORA
CEBF: 5D             TSTB
CEC0: F2 48 51       SBCB   $6AD3
CEC3: A8 42          EORA   $0,S
CEC5: 42             XNCA
CEC6: E2 E2          SBCB   $0,S
CEC8: 4A             DECA
CEC9: 4A             DECA
CECA: EA EA          ORB    $2,S
CECC: 4B             XDECA
CECD: 4B             XDECA
CECE: EB EB          ADDB   $3,S
CED0: 46             RORA
CED1: 46             RORA
CED2: E6 E6          LDB    $4,S
CED4: 46             RORA
CED5: 58             ASLB
CED6: F8 F8 52       EORB   $7A7A
CED9: 54             LSRB
CEDA: F4 F4 54       ANDB   $7C7C
CEDD: 55             LSRB
CEDE: F5 F5 5F       BITB   $7D7D
CEE1: 5C             INCB
CEE2: FC FC 5C       LDD    $7E7E
CEE5: 5C             INCB
CEE6: 52             XNCB
CEE7: 1A FB          ORCC   #$D3
CEE9: 70 58 56       NEG    $D0DE
CEEC: FB B6 59       ADDB   $9ED1
CEEF: AC F6          CMPX   [,U]
CEF1: 62 53          XNC    [,U++]
CEF3: F2 F6 AE       SBCB   $D48C
CEF6: 4D             TSTA
CEF7: 84 E7          ANDA   #$CF
CEF9: 2E 47          BGT    $CECA
CEFB: 9D E7          JSR    $CF
CEFD: 3D             MUL
CEFE: 47             ASRA
CEFF: AC ED          CMPX   ,W++
CF01: 06 4D          ROR    $CF
CF03: B1 ED 11       CMPA   $CF33
CF06: A7 42          STA    ,U+
CF08: 2E 0E          BGT    $CF30
CF0A: 48             ASLA
CF0B: 8E 0F E8       LDX    #$27C0
CF0E: 8E AE E2       LDX    #$26C0
CF11: 24 7D          BCC    $CF12
CF13: 4D             TSTA
CF14: 24 07          BCC    $CF3B
CF16: C2 84          SBCB   #$06
CF18: 0E 68          JMP    $40
CF1A: 8E AF 68       LDX    #$2740
CF1D: 2E AE          BGT    $CF45
CF1F: C8 24          EORB   #$06
CF21: DD 4D          STD    $CF
CF23: 97 07          STA    $25
CF25: 22 84          BHI    $CF2D
CF27: A4 28          ANDA   $0,X
CF29: 2E AF          BGT    $CF52
CF2B: 88 2E          EORA   #$06
CF2D: 0E 88          JMP    $00
CF2F: 8E DD ED       LDX    #$FFCF
CF32: A6 A7          LDA    $5,Y
CF34: A2 24          SBCA   $6,X
CF36: A4 02          ANDA   ,X+
CF38: 2E 0F          BGT    $CF61
CF3A: 08 8E          ASL    $06
CF3C: 0E A8          JMP    $80
CF3E: 8E 77 ED       LDX    #$FFCF
CF41: 11 4D          TSTA
CF43: D0 ED          SUBB   $CF
CF45: 70 4D E3       NEG    $CF61
CF48: E7 49          STB    $1,S
CF4A: 47             ASRA
CF4B: F8 E7 58       EORB   $CF70
CF4E: 47             ASRA
CF4F: F7 ED 5D       STB    $CF7F
CF52: AB 42          ADDA   ,U+
CF54: 24 08          BCC    $CF80
CF56: 42             XNCA
CF57: 84 03          ANDA   #$2B
CF59: E8 8E          EORB   $6,X
CF5B: A2 E8          SBCA   ,U+
CF5D: 2E 77          BGT    $CF5E
CF5F: 47             ASRA
CF60: 70 0B C2       NEG    $2940
CF63: 84 08          ANDA   #$2A
CF65: 62 84          XNC    $6,X
CF67: A9 68          ADCA   $0,U
CF69: 2E A2          BGT    $CF95
CF6B: C8 2E          EORB   #$06
CF6D: D7 47          STB    $CF
CF6F: E9 0B          ADCB   $9,Y
CF71: 22 84          BHI    $CF79
CF73: A8 22          EORA   $0,X
CF75: 24 A9          BCC    $CFA2
CF77: 82 2E          SBCA   #$06
CF79: 02 88          XNC    $00
CF7B: 8E D7 E7       LDX    #$FFCF
CF7E: F8 A1 A2       EORB   $2980
CF81: 24 A8          BCC    $CFAD
CF83: 02 24          XNC    $06
CF85: 09 02          ROL    $80
CF87: 84 02          ANDA   #$2A
CF89: A8 8E          EORA   $6,X
CF8B: 77 E7 57       ASR    $CF7F
CF8E: 47             ASRA
CF8F: 16 ED BC       LBRA   $9F30
CF92: 4D             TSTA
CF93: 2F ED          BLE    $CF64
CF95: 8F 4D 3E       XSTX   #$CFBC
CF98: E7 94 47       STB    [$CF6A,PCR]
CF9B: 43             COMA
CF9C: E7 E3          STB    D,U
CF9E: A4 48          ANDA   ,U+
CFA0: 27 08          BEQ    $CFCC
CFA2: 42             XNCA
CFA3: 87 0F          XSTA   #$2D
CFA5: E2 87          SBCB   $5,X
CFA7: A8 E8          EORA   ,U+
CFA9: 2D 77          BLT    $CFAA
CFAB: 47             ASRA
CFAC: B6 04 C8       LDA    $2C40
CFAF: 8D 08          BSR    $CFDB
CFB1: 62 87          XNC    $5,X
CFB3: AF 62          STX    $0,U
CFB5: 27 A8          BEQ    $CFE1
CFB7: C2 2D          SBCB   #$05
CFB9: D7 47          STB    $CF
CFBB: 25 04          BCS    $CFE9
CFBD: 28 8D          BVC    $CFC4
CFBF: A2 22          SBCA   $0,X
CFC1: 27 AF          BEQ    $CFF0
CFC3: 82 27          SBCA   #$05
CFC5: 08 82          ASL    $00
CFC7: 87 D7          XSTA   #$FF
CFC9: E7 34 A4       STB    [$CFF8,PCR]
CFCC: A8 2D          EORA   $5,X
CFCE: A2 08          SBCA   ,X+
CFD0: 27 0F          BEQ    $CFFF
CFD2: 02 87          XNC    $05
CFD4: 08 A2          ASL    $80
CFD6: 87 7D          XSTA   #$FF
CFD8: E7 E3          STB    D,U
CFDA: 47             ASRA
CFDB: 62 E7          XNC    ,W++
CFDD: C2 47          SBCB   #$CF
CFDF: 7E ED D4       JMP    $CFF6
CFE2: 52             XNCB
CFE3: 80 F2          SUBA   #$D0
CFE5: 20 52          BRA    $CFB7
CFE7: 8C F8 26       CMPX   #$D00E
CFEA: E2 48          SBCB   ,U+
CFEC: 2D 43          BLT    $D059
CFEE: 48             ASLA
CFEF: 84 48          ANDA   #$6A
CFF1: E2 87          SBCB   $5,X
CFF3: 7D ED C8       TST    $CFEA
CFF6: E8 C2          EORB   $0,U
CFF8: 2D 43          BLT    $D065
CFFA: C8 84          EORB   #$0C
CFFC: 42             XNCA
CFFD: 68 8D          ASL    $5,X
CFFF: 77 ED D4       ASR    $CFF6
D002: E8 82          EORB   $0,X
D004: 27 49          BEQ    $D071
D006: 82 8E          SBCA   #$0C
D008: 42             XNCA
D009: 28 8D          BVC    $D010
D00B: 77 F8 2A       ASR    $D002
D00E: E2 08          SBCB   ,X+
D010: 27 49          BEQ    $D07D
D012: 02 8E          XNC    $0C
D014: 48             ASLA
D015: A2 87          SBCA   $5,X
D017: 7D F8 26       TST    $D00E
D01A: 58             ASLB
D01B: A2 F8          SBCA   [,W++]
D01D: 02 58          XNC    $D0
D01F: A2 F2          SBCA   [,W++]
D021: 08 52          ASL    $D0
D023: BB F2 1B       ADDA   $D039
D026: 52             XNCB
D027: BB F8 11       ADDA   $D039
D02A: B2 C8 29       SBCA   $4001
D02D: 13             SYNC
D02E: C8 89          EORB   #$01
D030: 18             X18
D031: 62 83          XNC    $1,X
D033: B9 E2 23       ADCA   $C001
D036: 7D 52 02       TST    $D02A
D039: 12             NOP
D03A: 88 89          EORA   #$01
D03C: 13             SYNC
D03D: 28 89          BVC    $D040
D03F: B2 22 23       SBCA   >$0001
D042: B9 02 23       ADCA   $8001
D045: DD 52          STD    $D0
D047: BB F8 70       ADDA   $D058
D04A: 58             ASLB
D04B: D0 F8          SUBB   $D0
D04D: 70 58 D0       NEG    $D058
D050: F2 43 52       SBCB   $61D0
D053: E3 F2          ADDD   [,W++]
D055: 43             COMA
D056: 52             XNCB
D057: E3 0D          ADDD   $5,Y
D059: 68 8C          ASL    $4,X
D05B: AE 68          LDX    $0,U
D05D: 2C 77          BGE    $D05E
D05F: 58             ASLB
D060: 7A 07 82       DEC    $2500
D063: 86 04          LDA    #$26
D065: 22 86          BHI    $D06B
D067: 7D F8 49       TST    $D061
D06A: 58             ASLB
D06B: F2 F8 52       SBCB   $D07A
D06E: 58             ASLB
D06F: F2 F2 58       SBCB   $D07A
D072: 52             XNCB
D073: 0B F2          XDEC   $D0
D075: AB 52          ADDA   [,W++]
D077: 0B F8          XDEC   $D0
D079: A1 E9          CMPA   $1,S
D07B: 48             ASLA
D07C: 2C 48          BGE    $D0DE
D07E: 48             ASLA
D07F: 8C 43 62       CMPX   #$6140
D082: 86 E2          LDA    #$60
D084: E2 26          SBCB   $4,X
D086: 7D 52 52       TST    $D07A
D089: 49             ROLA
D08A: 88 8C          EORA   #$04
D08C: 48             ASLA
D08D: 28 8C          BVC    $D093
D08F: E9 A2          ADCB   ,X+
D091: 26 E2          BNE    $D0F3
D093: 82 26          SBCA   #$04
D095: DD 52          STD    $D0
D097: 0B F8          XDEC   $D0
D099: 80 58          SUBA   #$D0
D09B: 20 F8          BRA    $D06D
D09D: 80 58          SUBA   #$D0
D09F: 20 F2          BRA    $D071
D0A1: E1 52          CMPB   [,W++]
D0A3: 41             NEGA
D0A4: F2 E1 52       SBCB   $C3D0
D0A7: 41             NEGA
D0A8: 7D E8 89       TST    $C001
D0AB: DD E8          STD    $C0
D0AD: 29 DE          BVS    $D105
D0AF: 48             ASLA
D0B0: 23 74          BLS    $D108
D0B2: 42             XNCA
D0B3: 83 75 E2       SUBD   #$57C0
D0B6: 83 DA E8       SUBD   #$58C0
D0B9: 29 D0          BVS    $D113
D0BB: 48             ASLA
D0BC: 29 67          BVS    $D10D
D0BE: 48             ASLA
D0BF: 89 DD          ADCA   #$FF
D0C1: F2 3F D7       SBCB   $BD55
D0C4: 22 23          BHI    $D0C7
D0C6: D7 82          STB    $00
D0C8: 29 7E          BVS    $D120
D0CA: 88 89          EORA   #$01
D0CC: 7E 28 89       JMP    >$0001
D0CF: DF 22          STU    $00
D0D1: 23 DA          BLS    $D12B
D0D3: 82 23          SBCA   #$01
D0D5: 7A 82 83       DEC    >$0001
D0D8: 67 28          ASR    $0,X
D0DA: 89 77          ADCA   #$FF
D0DC: F8 F0 58       EORB   $D8D0
D0DF: 66 F2          ROR    [,W++]
D0E1: CC 52 6C       LDD    #$D0EE
D0E4: F2 CC 53       SBCB   $EED1
D0E7: 8B F9          ADDA   #$D1
D0E9: 21 59          BRN    $D0BC
D0EB: 81 F9          CMPA   #$D1
D0ED: 21 C7          BRN    $D13E
D0EF: 48             ASLA
D0F0: 23 4E          BLS    $D15E
D0F2: 42             XNCA
D0F3: 83 4E E2       SUBD   #$6CC0
D0F6: 83 EF E8       SUBD   #$6DC0
D0F9: 29 E5          BVS    $D168
D0FB: 48             ASLA
D0FC: 29 46          BVS    $D16C
D0FE: 48             ASLA
D0FF: 89 4D          ADCA   #$6F
D101: E2 83          SBCB   $1,X
D103: A7 E2          STA    ,U+
D105: 23 7D          BLS    $D106
D107: 53             COMB
D108: 2B 67          BMI    $D159
D10A: 88 89          EORA   #$01
D10C: 44             LSRA
D10D: 28 89          BVC    $D110
D10F: E4 22          ANDB   $0,X
D111: 23 EF          BLS    $D180
D113: 82 23          SBCA   #$01
D115: 4F             CLRA
D116: 82 83          SBCA   #$01
D118: 46             RORA
D119: 28 89          BVC    $D11C
D11B: E7 28          STB    $0,X
D11D: 29 AD          BVS    $D144
D11F: 88 23          EORA   #$01
D121: DD 53          STD    $D1
D123: 9C F3          CMPX   $D1
D125: 16 53 B6       LBRA   $A25C
D128: F9 6B 59       ADCB   $43D1
D12B: CB F9          ADDB   #$D1
D12D: 7A 59 DA       DEC    $D152
D130: F3 43 53       ADDD   $61D1
D133: E3 0C          ADDD   $E,Y
D135: E2 8E          SBCB   $C,X
D137: AD E8          JSR    ,U+
D139: 24 AE          BCC    $D161
D13B: 48             ASLA
D13C: 24 06          BCC    $D16C
D13E: 48             ASLA
D13F: 84 DD          ANDA   #$FF
D141: F3 B6 AC       ADDD   $342E
D144: 62 2E          XNC    $C,X
D146: AD C2          JSR    $0,U
D148: 24 0E          BCC    $D170
D14A: C8 84          EORB   #$0C
D14C: 06 68          ROR    $40
D14E: 84 77          ANDA   #$FF
D150: F3 61 AC       ADDD   $432E
D153: 82 2E          SBCA   #$0C
D155: 0D 82          TST    $00
D157: 8E 0E 28       LDX    #$2600
D15A: 84 A6          ANDA   #$2E
D15C: 28 24          BVC    $D16A
D15E: 77 59 70       ASR    $D152
D161: 0C 02          INC    $80
D163: 8E 0D A2       LDX    #$2F80
D166: 8E A4 A8       LDX    #$2680
D169: 24 A6          BCC    $D199
D16B: 08 24          ASL    $0C
D16D: D7 59          STB    $D1
D16F: E9 F3          ADCB   [,U++]
D171: A2 53          SBCA   [,U++]
D173: 02 F3          XNC    $D1
D175: A2 53          SBCA   [,U++]
D177: 02 F9          XNC    $D1
D179: A7 59          STA    [,U++]
D17B: 07 F9          ASR    $D1
D17D: A7 59          STA    [,U++]
D17F: 07 7F          ASR    $5D
D181: E2 8A          SBCB   $8,X
D183: DC E2          LDD    $C0
D185: 2A DC          BPL    $D1E5
D187: C2 20          SBCB   #$08
D189: 75 C8 80       LSR    $4008
D18C: D7 F9          STB    $D1
D18E: 08 D5          ASL    $5D
D190: 22 2A          BHI    $D19A
D192: DC 82          LDD    $00
D194: 2A 7C          BPL    $D1F4
D196: 02 8A          XNC    $08
D198: 75 A8 80       LSR    $8008
D19B: 77 F9 A7       ASR    $D18F
D19E: 59             ROLB
D19F: 26 F3          BNE    $D172
D1A1: 8C 53 3F       CMPX   #$D1BD
D1A4: F3 9F 53       ADDD   $BDD1
D1A7: 4E             XCLRA
D1A8: F9 E4 59       ADCB   $CCD1
D1AB: 53             COMB
D1AC: F9 F3 B8       ADCB   $DB30
D1AF: 48             ASLA
D1B0: 24 13          BCC    $D1E3
D1B2: 42             XNCA
D1B3: 84 10          ANDA   #$32
D1B5: E2 84          SBCB   $6,X
D1B7: B3 E8 2E       SUBD   $C006
D1BA: 77 59 86       ASR    $D1AE
D1BD: 18             X18
D1BE: C8 8E          EORB   #$06
D1C0: 13             SYNC
D1C1: 62 84          XNC    $6,X
D1C3: B0 62 24       SUBA   $4006
D1C6: B3 C2 2E       SUBD   $4006
D1C9: D7 59          STB    $D1
D1CB: 35 18          PULS   X,Y
D1CD: 28 8E          BVC    $D1D5
D1CF: B9 22 24       ADCA   >$0006
D1D2: B0 82 24       SUBA   >$0006
D1D5: 13             SYNC
D1D6: 82 84          SBCA   #$06
D1D8: D7 F9          STB    $D1
D1DA: 44             LSRA
D1DB: B8 A8 2E       EORA   $8006
D1DE: B9 08 24       ADCA   $8006
D1E1: 10 02 84       XNC    $06
D1E4: 13             SYNC
D1E5: A2 84          SBCA   $6,X
D1E7: 7D F9 F3       TST    $D1DB
D1EA: 59             ROLB
D1EB: 72 F9 D2       XNC    $D1FA
D1EE: 5A             DECB
D1EF: 81 F0          CMPA   #$D2
D1F1: 2B 50          BMI    $D1C5
D1F3: 9A F0          ORA    $D2
D1F5: 3A             ABX
D1F6: 50             NEGB
D1F7: A5 FA          BITA   Illegal Postbyte
D1F9: 0F BD          CLR    $35
D1FB: 48             ASLA
D1FC: 2C 1E          BGE    $D234
D1FE: 48             ASLA
D1FF: 8C 15 E2       CMPX   #$37C0
D202: 86 B4          LDA    #$36
D204: E2 26          SBCB   $4,X
D206: 7D 53 D2       TST    $D1FA
D209: 1D             SEX
D20A: C8 8C          EORB   #$04
D20C: 1E 68          EXG    S,D
D20E: 8C BF 62       CMPX   #$3740
D211: 26 B4          BNE    $D249
D213: C2 26          SBCB   #$04
D215: DD 50          STD    $D2
D217: 8B 1D          ADDA   #$35
D219: 28 8C          BVC    $D21F
D21B: BE 28 2C       LDX    >$0004
D21E: BF 88 26       STX    >$0004
D221: 14             XHCF
D222: 82 86          SBCA   #$04
D224: DD F0          STD    $D2
D226: 9A B7          ORA    $35
D228: A8 2C          EORA   $4,X
D22A: BE 08 2C       LDX    $8004
D22D: 1F 08          TFR    A,D
D22F: 8C 14 A2       CMPX   #$3680
D232: 86 7D          LDA    #$FF
D234: F0 05 50       SUBB   $27D2
D237: C4 FA          ANDB   #$D2
D239: 6E 5A          JMP    Illegal Postbyte
D23B: DD FA          STD    $D2
D23D: 7D 5A EC       TST    $D264
D240: F0 46 50       SUBB   $64D2
D243: F1 F0 51       CMPB   $D273
D246: BA 42 2C       ORA    $C004
D249: 1E 48          EXG    inv,D
D24B: 8C 11 E8       CMPX   #$39C0
D24E: 8C BE E2       CMPX   #$36C0
D251: 26 7D          BNE    $D252
D253: 50             NEGB
D254: 64 1A          LSR    -$8,Y
D256: C2 86          SBCB   #$04
D258: 1E 68          EXG    S,D
D25A: 8C B1 68       CMPX   #$3940
D25D: 2C BE          BGE    $D295
D25F: C8 26          EORB   #$04
D261: DD 50          STD    $D2
D263: D7 1A          STB    $38
D265: 22 86          BHI    $D26B
D267: B4 28 2C       ANDA   >$0004
D26A: B1 88 2C       CMPA   >$0004
D26D: 1E 88          EXG    D,D
D26F: 8C DD F0       CMPX   #$FFD2
D272: E6 BA          LDB    -$8,Y
D274: A2 26          SBCA   $4,X
D276: B4 02 2C       ANDA   $8004
D279: 11 08 8C       ASL    $04
D27C: 1E A8          EXG    A,D
D27E: 8C 77 F0       CMPX   #$FFD2
D281: 51             NEGB
D282: 50             NEGB
D283: 10 F0 B0 50    SUBB   $92D2
D287: 23 FA          BLS    $D25B
D289: 89 5A          ADCA   #$D2
D28B: 38 FA          XANDCC #$D2
D28D: 98 5A          EORA   $D2
D28F: 37 F0          PULU   A,X,S,PC
D291: 9D A7          JSR    $25
D293: 42             XNCA
D294: 20 04          BRA    $D2BC
D296: 42             XNCA
D297: 80 0F          SUBA   #$27
D299: E8 8A          EORB   $2,X
D29B: AE E8          LDX    ,U+
D29D: 2A 77          BPL    $D29E
D29F: 5A             DECB
D2A0: B0 07 C2       SUBA   $2540
D2A3: 80 04          SUBA   #$26
D2A5: 62 80          XNC    $2,X
D2A7: A5 68          BITA   $0,U
D2A9: 2A AE          BPL    $D2D1
D2AB: C8 2A          EORB   #$02
D2AD: D7 5A          STB    $D2
D2AF: 29 07          BVS    $D2D6
D2B1: 22 80          BHI    $D2B5
D2B3: A4 22          ANDA   $0,X
D2B5: 20 A5          BRA    $D2DE
D2B7: 82 2A          SBCA   #$02
D2B9: 0E 88          JMP    $00
D2BB: 8A D7          ORA    #$FF
D2BD: FA 38 AD       ORB    $B025
D2C0: A2 20          SBCA   $2,X
D2C2: A4 02          ANDA   ,X+
D2C4: 20 05          BRA    $D2ED
D2C6: 02 80          XNC    $02
D2C8: 0E A8          JMP    $80
D2CA: 8A 77          ORA    #$FF
D2CC: FA 97 5A       ORB    $BFD2
D2CF: 56             RORB
D2D0: F0 FC 50       SUBB   $DED2
D2D3: 5C             INCB
D2D4: F0 FC 50       SUBB   $DED2
D2D7: 6F FA          CLR    Illegal Postbyte
D2D9: C5 5A          BITB   #$D2
D2DB: 65 FA          LSR    Illegal Postbyte
D2DD: C5 B4          BITB   #$3C
D2DF: C8 23          EORB   #$01
D2E1: 1F C2          TFR    S,D
D2E3: 83 1E 62       SUBD   #$3C40
D2E6: 83 BF E8       SUBD   #$3DC0
D2E9: 29 77          BVS    $D2EA
D2EB: 5A             DECB
D2EC: F6 14 88       LDB    $3C00
D2EF: 89 1F          ADCA   #$3D
D2F1: 22 83          BHI    $D2F4
D2F3: BE 22 23       LDX    >$0001
D2F6: BF 02 29       STX    $8001
D2F9: D7 5A          STB    $D2
D2FB: 65 FB          LSR    [,--U]
D2FD: 24 5B          BCC    $D2D2
D2FF: 84 F1          ANDA   #$D3
D301: 2E 51          BGT    $D2D6
D303: 8E F1 39       LDX    #$D31B
D306: 51             NEGB
D307: 99 FB          ADCA   $D3
D309: 33 5B          LEAU   [,--U]
D30B: 93 18          SUBD   $30
D30D: 68 89          ASL    $1,X
D30F: B9 62 23       ADCA   $4001
D312: B0 C2 23       SUBA   $4001
D315: 13             SYNC
D316: C2 83          SBCB   #$01
D318: D7 FB          STB    $D3
D31A: 84 B8          ANDA   #$30
D31C: 28 29          BVC    $D31F
D31E: B9 88 23       ADCA   >$0001
D321: 10 82 83       SBCA   #$01
D324: 13             SYNC
D325: 22 83          BHI    $D328
D327: 7D FB 33       TST    $D31B
D32A: 5B             XDECB
D32B: B2 FB 12       SBCA   $D33A
D32E: 5B             XDECB
D32F: B2 F1 18       SBCA   $D33A
D332: 51             NEGB
D333: CB F1          ADDB   #$D3
D335: 6B 51          XDEC   [,--U]
D337: CB FB          ADDB   #$D3
D339: 61 F3          NEG    -$5,S
D33B: 48             ASLA
D33C: 2A 52          BPL    $D3B8
D33E: 48             ASLA
D33F: 8A 59          ORA    #$7B
D341: 62 80          XNC    $2,X
D343: F8 E2 20       EORB   $C002
D346: 7D 51 12       TST    $D33A
D349: 53             COMB
D34A: 88 8A          EORA   #$02
D34C: 52             XNCB
D34D: 28 8A          BVC    $D351
D34F: F3 A2 20       ADDD   $8002
D352: F8 82 20       EORB   >$0002
D355: DD 51          STD    $D3
D357: CB FB          ADDB   #$D3
D359: 40             NEGA
D35A: 5B             XDECB
D35B: E0 FB          SUBB   [,--U]
D35D: 40             NEGA
D35E: 5B             XDECB
D35F: E0 F1          SUBB   [,--U]
D361: A1 51          CMPA   [,--U]
D363: 01 F1          NEG    $D3
D365: A1 51          CMPA   [,--U]
D367: 01 18          NEG    $30
D369: E8 89          EORB   $1,X
D36B: C2 E8          SBCB   #$C0
D36D: 29 C3          BVS    $D3BA
D36F: 48             ASLA
D370: 23 6E          BLS    $D3BE
D372: 42             XNCA
D373: 83 6F E2       SUBD   #$4DC0
D376: 83 CC E8       SUBD   #$4EC0
D379: 29 C7          BVS    $D3CA
D37B: 48             ASLA
D37C: 29 67          BVS    $D3CD
D37E: 48             ASLA
D37F: 89 DD          ADCA   #$FF
D381: F1 FF B2       CMPB   $7D30
D384: 22 23          BHI    $D387
D386: C8 82          EORB   #$00
D388: 29 63          BVS    $D3D5
D38A: 88 89          EORA   #$01
D38C: 64 28          LSR    $0,X
D38E: 89 C5          ADCA   #$4D
D390: 22 23          BHI    $D393
D392: CC 82 23       LDD    #$0001
D395: 6D 82          TST    $0,X
D397: 83 67 28       SUBD   #$4F00
D39A: 89 77          ADCA   #$FF
D39C: FB B0 5B       ADDB   $98D3
D39F: 26 F1          BNE    $D374
D3A1: 8C 51 2C       CMPX   #$D3AE
D3A4: F1 8C 51       CMPB   $AED3
D3A7: 4B             XDECA
D3A8: FB E1 5B       ADDB   $C9D3
D3AB: 41             NEGA
D3AC: FB E1 C7       ADDB   $C94F
D3AF: 48             ASLA
D3B0: 23 6D          BLS    $D401
D3B2: 42             XNCA
D3B3: 83 47 E2       SUBD   #$65C0
D3B6: 83 E4 E8       SUBD   #$66C0
D3B9: 29 EF          BVS    $D422
D3BB: 48             ASLA
D3BC: 29 40          BVS    $D426
D3BE: 48             ASLA
D3BF: 89 10          ADCA   #$32
D3C1: E2 83          SBCB   $1,X
D3C3: B0 E2 23       SUBA   $C001
D3C6: 7D 51 EB       TST    $D3C3
D3C9: 67 88          ASR    $0,X
D3CB: 89 67          ADCA   #$4F
D3CD: 28 89          BVC    $D3D0
D3CF: ED 22          STD    $0,X
D3D1: 23 E4          BLS    $D439
D3D3: 82 23          SBCA   #$01
D3D5: 45             LSRA
D3D6: 82 83          SBCA   #$01
D3D8: 40             NEGA
D3D9: 28 89          BVC    $D3DC
D3DB: BA 28 29       ORA    >$0001
D3DE: BA 88 23       ORA    >$0001
D3E1: DD 51          STD    $D3
D3E3: 5C             INCB
D3E4: F1 D6 51       CMPB   $F4D3
D3E7: 76 FB D5       ROR    $D3FD
D3EA: 5B             XDECB
D3EB: 75 FC 2E       LSR    $D406
D3EE: 5C             INCB
D3EF: 8E F6 2D       LDX    #$D40F
D3F2: 56             RORB
D3F3: 8D 55          BSR    $D46C
D3F5: E2 86          SBCB   $4,X
D3F7: FA E8 2C       ORB    $C004
D3FA: 77 5B DC       ASR    $D3F4
D3FD: 5F             CLRB
D3FE: C8 8C          EORB   #$04
D400: 5A             DECB
D401: 62 86          XNC    $4,X
D403: 7D F1 DF       TST    $D3FD
D406: F5 82 2C       BITB   >$0004
D409: 50             NEGB
D40A: 88 8C          EORA   #$04
D40C: D7 FC          STB    $D4
D40E: 8E FF A2       LDX    #$7780
D411: 26 FA          BNE    $D48B
D413: 02 26          XNC    $04
D415: DD 56          STD    $D4
D417: 8D FC          BSR    $D3ED
D419: 00 5C          NEG    $D4
D41B: A0 FC          SUBA   [,U]
D41D: 06 5C          ROR    $D4
D41F: A6 F6          LDA    [,U]
D421: 16 56 B6       LBRA   $A858
D424: F6 18 56       LDB    $3AD4
D427: B8 51 E8       EORA   $79C0
D42A: 80 77          SUBA   #$FF
D42C: F9 86 F1       ADCB   $AE79
D42F: C8 2A          EORB   #$08
D431: DD 53          STD    $D1
D433: 3F             SWI
D434: 5B             XDECB
D435: 22 8A          BHI    $D43F
D437: 7D F9 E4       TST    $D1CC
D43A: F1 08 20       CMPB   $8008
D43D: D7 59          STB    $D1
D43F: 53             COMB
D440: F6 72 56       LDB    $50D4
D443: D2 F6          SBCB   $D4
D445: 7D 56 DD       TST    $D45F
D448: FC 46 5C       LDD    $6ED4
D44B: E6 FC          LDB    [,U]
D44D: 55             LSRB
D44E: 5C             INCB
D44F: F5 11 E2       BITB   $33C0
D452: 8E B6 E2       LDX    #$34C0
D455: 2E B3          BGT    $D488
D457: 42             XNCA
D458: 24 1B          BCC    $D48D
D45A: 48             ASLA
D45B: 84 D7          ANDA   #$FF
D45D: FC D8 BB       LDD    $5033
D460: 62 2E          XNC    $C,X
D462: B6 C2 2E       LDA    $400C
D465: 13             SYNC
D466: C2 8E          SBCB   #$0C
D468: 1B             NOP
D469: 68 84          ASL    $C,X
D46B: 77 FC 77       ASR    $D45F
D46E: BB 88 2E       ADDA   >$000C
D471: 16 82 8E       LBRA   $D480
D474: 13             SYNC
D475: 22 8E          BHI    $D483
D477: B1 28 24       CMPA   >$000C
D47A: 77 5C 46       ASR    $D46E
D47D: 1B             NOP
D47E: 08 84          ASL    $0C
D480: 16 A2 8E       LBRA   $548F
D483: B3 A2 2E       SUBD   $800C
D486: B1 02 24       CMPA   $800C
D489: D7 5C          STB    $D4
D48B: F5 FC B4       BITB   $D49C
D48E: 5C             INCB
D48F: 14             XHCF
D490: F6 BE 56       LDB    $9CD4
D493: 1E F6          EXG    inv,S
D495: 87 56          XSTA   #$D4
D497: 27 FC          BEQ    $D46D
D499: 8D 5C          BSR    $D46F
D49B: 2D 16          BLT    $D4DB
D49D: E8 80          EORB   $8,X
D49F: B7 E2 2A       STA    $C008
D4A2: 7D 56 BE       TST    $D49C
D4A5: 1C 82          ANDCC  #$00
D4A7: 8A 17          ORA    #$3F
D4A9: 28 80          BVC    $D4B3
D4AB: 77 FC 8D       ASR    $D4A5
D4AE: B7 D2 22       STA    $5A00
D4B1: 48             ASLA
D4B2: 8E 56 95       LDX    #$D4B7
D4B5: 6E 14          JMP    [A,X]
D4B7: 56             RORB
D4B8: 97 FD          STA    $D5
D4BA: C9 53          ADCB   #$DB
D4BC: 09 F5          ROL    $DD
D4BE: E2 96          SBCB   -$2,X
D4C0: 29 48          BVS    $D52C
D4C2: 10 8E F6 EA    LDY    #$D4C8
D4C6: 6E 34          JMP    [A,Y]
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
D544: 10 8E 57 C8    LDY    #$D54A
D548: 6E 9E          JMP    [A,Y]
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
D812: 8F 22 12       XSTX   #$A030
D815: B2 B2 02       SBCA   system_3080
D818: 18             X18
D819: 88 A8          EORA   #$20
D81B: 18             X18
D81C: 08 A8          ASL    $80
D81E: A8 F8          EORA   -$10,S
D820: 02 82          XNC    $A0
D822: 92 12          SBCA   $90
D824: 32 A2          LEAS   ,X+
D826: 92 F2          SBCA   $70
D828: 38 98          XANDCC #$B0
D82A: 88 28          EORA   #$A0
D82C: 28 25          BVC    $D83B
D82E: 10 C1 AA       CMPB   #$88
D831: 6B FA          XDEC   -$8,S
D833: CB BA          ADDB   #$98
D835: 1B             NOP
D836: 0A BB          DEC    $39
D838: 50             NEGB
D839: 11 E0 B1       SUBB   -$7,Y
D83C: B0 01 00       SUBA   $2988
D83F: A1 5A          CMPA   -$8,S
D841: 0B EA          XDEC   $68
D843: AB BA 3B       ADDA   [$19,X]
D846: 0A 9B          DEC    $19
D848: 25 44          BCS    $D8B6
D84A: F2 C4 42       SBCB   $4C6A
D84D: 74 E2 E4       LSR    $6A6C
D850: 48             ASLA
D851: 5E             XCLRB
D852: E8 0E 48       EORB   $D8BF,PCR
D855: 6E D8          JMP    -$6,U
D857: DE 72          LDU    $5A
D859: 44             LSRA
D85A: D2 F4          SBCB   $7C
D85C: 72 A4 D2       XNC    $8C5A
D85F: E4 68          ANDB   $A,U
D861: 5E             XCLRB
D862: C8 8F          EORB   #$0D
D864: 42             XNCA
D865: 82 F2          SBCA   #$70
D867: 22 A8          BHI    $D7E9
D869: 88 E8          EORA   #$60
D86B: 18             X18
D86C: 58             ASLB
D86D: B8 08 18       EORA   $8090
D870: B2 B2 E2       SBCA   $9060
D873: 02 52          XNC    $70
D875: A2 02          SBCA   ,X+
D877: 02 B8          XNC    $90
D879: A8 E8          EORA   $0,S
D87B: F8 58 58       EORB   $7070
D87E: 85 E0          BITA   #$68
D880: E0 5A          SUBB   -$8,S
D882: 40             NEGA
D883: 0A E0          DEC    $C2
D885: 4A             DECA
D886: 30 FA          LEAX   -$8,S
D888: 9A A0          ORA    $88
D88A: 3A             ABX
D88B: 10 9A 40       ORA    $68
D88E: 2A F0          BPL    $D908
D890: 80 AA          SUBA   #$88
D892: 20 1A          BRA    $D82C
D894: 80 7A          SUBA   #$58
D896: 10 EA BA       ORB    Illegal Postbyte
D899: 21 28          BRN    $D83B
D89B: 58             ASLB
D89C: E8 F8          EORB   [,W++]
D89E: 58             ASLB
D89F: 58             ASLB
D8A0: C2 F2          SBCB   #$D0
D8A2: 22 42          BHI    $D864
D8A4: 92 E2          SBCA   $C0
D8A6: 42             XNCA
D8A7: 42             XNCA
D8A8: F8 E8 68       EORB   $C0E0
D8AB: 48             ASLA
D8AC: 21 B8          BRN    $D83E
D8AE: 40             NEGA
D8AF: 28 EA          BVC    $D879
D8B1: 92 4A          SBCA   $C8
D8B3: 42             XNCA
D8B4: EA F2          ORB    [,W++]
D8B6: 4A             DECA
D8B7: 12             NOP
D8B8: 90 88          SUBA   $A0
D8BA: 30 38 90 E8    LEAX   [-$4740,W]
D8BE: 30 81          LEAX   $9,X
D8C0: 82 F2          SBCA   #$D0
D8C2: 32 52          LEAS   [,W++]
D8C4: A2 E2          SBCA   ,U+
D8C6: 12             NOP
D8C7: 42             XNCA
D8C8: 88 E8          EORA   #$C0
D8CA: 38 48          XANDCC #$C0
D8CC: A8 98 18 38    EORA   [-$6F50,W]
D8D0: 82 92          SBCA   #$B0
D8D2: 7D 82 F2       TST    >$00D0
D8D5: 22 83          BHI    $D8D8
D8D7: 82 28          SBCA   #$00
D8D9: 28 89          BVC    $D8DC
D8DB: 88 25          EORA   #$0D
D8DD: 41             NEGA
D8DE: 2A D1          BPL    $D939
D8E0: 80 6B          SUBA   #$49
D8E2: 20 EB          BRA    $D94D
D8E4: 90 7B          SUBA   $59
D8E6: 30 CB          LEAX   $9,U
D8E8: 9A 11          ORA    $39
D8EA: 3A             ABX
D8EB: E1 EA          CMPB   ,-U
D8ED: 71 4A C1       NEG    $C249
D8F0: E0 1B          SUBB   -$7,Y
D8F2: 40             NEGA
D8F3: FB F0 4B       ADDB   $D269
D8F6: 50             NEGB
D8F7: 8F 12 A9       XSTX   #$3A81
D8FA: D2 19          SBCB   $91
D8FC: 62 B9          XNC    [,X++]
D8FE: B2 19 08       SBCA   $912A
D901: B3 98 13       SUBD   $1A91
D904: 78 83 C8       ASL    $A14A
D907: 23 12          BLS    $D943
D909: 89 A2          ADCA   #$2A
D90B: 29 32          BVS    $D927
D90D: 89 B2          ADCA   #$3A
D90F: 39             RTS
D910: 08 93          ASL    $B1
D912: 2A 15          BPL    $D8AB
D914: 0F 02          CLR    $20
D916: 83 82 88       SUBD   #$00A0
D919: 28 88          BVC    $D91B
D91B: 28 25          BVC    $D92A
D91D: 0C CC          INC    $44
D91F: BC 66 66       CMPX   $4444
D922: C6 A6          LDB    #$24
D924: 76 16 D6       ROR    $3454
D927: C6 7C          LDB    #$54
D929: 7C DC AC       INC    $5424
D92C: 4C             INCA
D92D: 1C EC          ANDCC  #$64
D92F: CC 46 76       LDD    #$6454
D932: E6 96          LDB    -$C,X
D934: 56             RORB
D935: 06 F6          ROR    $74
D937: 8B 67          ADDA   #$4F
D939: 6A B7          DEC    -$1,Y
D93B: CA 47          ORB    #$6F
D93D: 1A D7          ORCC   #$5F
D93F: BA 6D 10       ORA    $4F32
D942: BD B0 4D       JSR    $326F
D945: 00 DD          NEG    $5F
D947: A0 67          SUBA   $F,U
D949: 0A 85          DEC    $0D
D94B: A8 18          EORA   -$10,Y
D94D: 18             X18
D94E: B8 C8 12       EORA   $4030
D951: 02 A2          XNC    $20
D953: B2 02 62       SBCA   $2040
D956: A2 D2          SBCA   -$10,U
D958: 08 08          ASL    $20
D95A: 98 B8          EORA   $30
D95C: 38 68          XANDCC #$40
D95E: 98 D8          EORA   $50
D960: 32 32          LEAS   -$10,X
D962: 82 A2          SBCA   #$20
D964: 22 29          BHI    $D971
D966: D6 D9          LDB    $5B
D968: 4C             INCA
D969: 73 FC D3       COM    $745B
D96C: AC 73          CMPX   -$5,U
D96E: 1C D3          ANDCC  #$5B
D970: 76 69 E6       ROR    $4B64
D973: C9 56          ADCB   #$74
D975: 69 06          ROL    ,X
D977: C9 7C          ADCB   #$54
D979: 13             SYNC
D97A: EC B3          LDD    -$5,Y
D97C: 2E 5F          BGT    $D9F5
D97E: 00 0F          NEG    $87
D980: AA B5          ORA    [E,X]
D982: 0A 25          DEC    $A7
D984: AA 95          ORA    [E,Y]
D986: 0A 15          DEC    $97
D988: 50             NEGB
D989: 2A 23          BPL    $D936
D98B: 14             XHCF
D98C: 93 B4          SUBD   $9C
D98E: 89 5D          ADCA   #$D5
D990: 97 23          STA    $01
D992: 66 46          ROR    ,U
D994: DD 22          STD    $00
D996: B2 82 28       SBCA   >$0000
D999: 28 B8          BVC    $D9CB
D99B: 88 28          EORA   #$00
D99D: 28 50          BVC    $D977
D99F: C8 02          EORB   #$20
D9A1: FB C2 A2       ADDB   $4020
D9A4: DD FB          STD    $D9
D9A6: 1C 58          ANDCC  #$DA
D9A8: 68 38          ASL    -$10,X
D9AA: 53             COMB
D9AB: C8 38          EORB   #$10
D9AD: D7 51          STB    $D9
D9AF: 2F F8          BLE    $D98B
D9B1: A2 92          SBCA   -$10,X
D9B3: 59             ROLB
D9B4: A2 32          SBCA   -$10,X
D9B6: 7D 5B 98       TST    $D9B0
D9B9: 33 88          LEAU   $0,X
D9BB: A8 33          EORA   -$5,X
D9BD: A8 A8          EORA   $0,Y
D9BF: 77 FB 9B       ASR    $D9B9
D9C2: 99 42          ADCA   $C0
D9C4: 02 39          XNC    $1B
D9C6: C2 A2          SBCB   #$20
D9C8: D7 F1          STB    $D9
D9CA: 4A             DECA
D9CB: 52             XNCB
D9CC: E8 38          EORB   -$10,X
D9CE: 53             COMB
D9CF: 48             ASLA
D9D0: 32 DD 5B 49    LEAS   [$D9CB]
D9D4: F8 22 92       EORB   >$0010
D9D7: 59             ROLB
D9D8: 28 38          BVC    $D9EA
D9DA: 77 51 FC       ASR    $D9D4
D9DD: 25 3C          BCS    $D993
D9DF: 3D             MUL
D9E0: 94 95          ANDA   $B7
D9E2: 3A             ABX
D9E3: 3B             RTI
D9E4: 98 99          EORA   $BB
D9E6: 3E             XRES
D9E7: 3F             SWI
D9E8: 96 C2          LDA    $EA
D9EA: 63 85          COM    $D,X
D9EC: B3 B4 15       SUBD   $9C9D
D9EF: 16 BD 82       LBRA   $7992
D9F2: 23 21          BLS    $D997
D9F4: 86 87          LDA    #$A5
D9F6: 24 25          BCC    $D99F
D9F8: 80 25          SUBA   #$0D
D9FA: 37 48          PULU   S,PC
D9FC: E9 EA          ADCB   ,-U
D9FE: 4B             XDECA
D9FF: 4C             INCA
DA00: E7 E4          STB    A,U
DA02: 45             LSRA
DA03: 4A             DECA
DA04: EB E8          ADDB   F,U
DA06: 49             ROLA
DA07: 8B B8          ADDA   #$90
DA09: A2 04 06       SBCA   $D99A,PCR
DA0C: B9 A1 03       ADCA   $898B
DA0F: 05 AD          LSR    $8F
DA11: 2B 02          BMI    $D993
DA13: 03 A0          COM    $82
DA15: A6 05          LDA    E,X
DA17: 0A AE          DEC    $86
DA19: AB 0D          ADDA   B,X
DA1B: 81 B0          CMPA   #$98
DA1D: B1 1A 1C       CMPA   $9294
DA20: B5 B8 11       BITA   $9A93
DA23: 17 B4 29       LBSR   $7031
DA26: 2B 28          BMI    $D9D2
DA28: 83 84 25       SUBD   #$ACAD
DA2B: 26 87          BNE    $D9DC
DA2D: 98 39          EORA   $B1
DA2F: 3A             ABX
DA30: 91 24          CMPA   $06
DA32: 4D             TSTA
DA33: 4C             INCA
DA34: EE EC          LDU    W,U
DA36: 4D             TSTA
DA37: 4F             CLRA
DA38: 2A F8          BPL    $DA0A
DA3A: 59             ROLB
DA3B: 89 FA          ADCA   #$D2
DA3D: 29 5B          BVS    $DA12
DA3F: 65 62          LSR    $0,U
DA41: 02 6E          XNC    $EC
DA43: C2 02          SBCB   #$20
DA45: CC C2 A2       LDD    #$4020
DA48: C4 68          ANDB   #$40
DA4A: A8 77 F2 17    EORA   [$DA3F]
DA4E: 64 C8          LSR    $0,U
DA50: 02 CC          XNC    $EE
DA52: C2 A2          SBCB   #$20
DA54: CF 62 A2       XSTU   #$4020
DA57: 6C 68          INC    $0,U
DA59: 08 77          ASL    $FF
DA5B: 52             XNCB
DA5C: 66 28          ROR    $0,X
DA5E: 8A 8C          ORA    #$04
DA60: 2E 20          BGT    $DA64
DA62: 80 A4          SUBA   #$26
DA64: 22 22          BHI    $DA66
DA66: 8E 92 28       LDX    #$1000
DA69: 29 88          BVS    $DA6B
DA6B: 88 02          EORA   #$2A
DA6D: 2C 8C          BGE    $DA73
DA6F: 8C 20 20       CMPX   #$0202
DA72: 0D 86          TST    $04
DA74: 26 39          BNE    $DA91
DA76: 82 82          SBCA   #$00
DA78: 24 2A          BCC    $DA7C
DA7A: 8A 84          ORA    #$0C
DA7C: 28 28          BVC    $DA7E
DA7E: 84 98          ANDA   #$10
DA80: 22 23          BHI    $DA83
DA82: 82 82          SBCA   #$00
DA84: 12             NOP
DA85: 26 86          BNE    $DA8B
DA87: 86 2A          LDA    #$02
DA89: 2A E8          BPL    $DAEB
DA8B: 8C 2C 33       CMPX   #$041B
DA8E: 8A 8A          ORA    #$02
DA90: 37 22          PULU   
DA92: 82 A2          SBCA   #$20
DA94: 02 22          XNC    $00
DA96: 83 82 28       SUBD   #$0000
DA99: 24 80          BCC    $DAA3
DA9B: 80 00          SUBA   #$28
DA9D: 28 88          BVC    $DA9F
DA9F: B8 2A 2A       EORA   $0808
DAA2: AA 80          ORA    $2,X
DAA4: 20 12          BRA    $DAD6
DAA6: 83 83 18       SUBD   #$0130
DAA9: 28 88          BVC    $DAAB
DAAB: 80 2A          SUBA   #$02
DAAD: 2A A0          BPL    $DAD7
DAAF: 89 23          ADCA   #$01
DAB1: 21 82          BRN    $DAB3
DAB3: 82 32          SBCA   #$10
DAB5: 32 82          LEAS   $0,X
DAB7: 83 28 28       SUBD   #$0000
DABA: D8 8C          EORB   $04
DABC: 2C 2C          BGE    $DAC2
DABE: 89 89          ADCA   #$01
DAC0: 12             NOP
DAC1: 22 82          BHI    $DAC3
DAC3: 8A 23          ORA    #$01
DAC5: 23 6A          BLS    $DAAF
DAC7: 86 2C          LDA    #$04
DAC9: 33 8A          LEAU   $2,X
DACB: 8A 38          ORA    #$10
DACD: 28 88          BVC    $DACF
DACF: 98 32          EORA   $10
DAD1: 22 83          BHI    $DAD4
DAD3: 82 22          SBCA   #$00
DAD5: 02 86          XNC    $04
DAD7: 86 2C          LDA    #$04
DAD9: 2A 8A          BPL    $DADD
DADB: E8 28          EORB   $0,X
DADD: 28 98          BVC    $DAEF
DADF: 89 23          ADCA   #$01
DAE1: 21 82          BRN    $DAE3
DAE3: 82 F2          SBCA   #$D0
DAE5: 02 82          XNC    $00
DAE7: 87 28          XSTA   #$00
DAE9: 28 98          BVC    $DAFB
DAEB: 8A 2A          ORA    #$02
DAED: 68 8C          ASL    $4,X
DAEF: 8C 39 20       CMPX   #$1B02
DAF2: 80 87          SUBA   #$05
DAF4: 22 22          BHI    $DAF6
DAF6: 92 92          SBCA   $10
DAF8: 28 29          BVC    $DAFB
DAFA: 88 88          EORA   #$00
DAFC: 18             X18
DAFD: 2C 8C          BGE    $DB03
DAFF: 8C 20 20       CMPX   #$0202
DB02: D2 86          SBCB   $04
DB04: 26 39          BNE    $DB21
DB06: 80 80          SUBA   #$02
DB08: 38 28          XANDCC #$00
DB0A: 88 80          EORA   #$08
DB0C: 29 29          BVS    $DB0F
DB0E: A8 88          EORA   $0,X
DB10: 22 32          BHI    $DB22
DB12: 92 82          SBCA   $00
DB14: 23 22          BLS    $DB16
DB16: 82 C2          SBCA   #$40
DB18: 2C 2C          BGE    $DB1E
DB1A: 8C 89 29       CMPX   #$0101
DB1D: D7 89          STB    $01
DB1F: 89 DD          ADCA   #$FF
DB21: 96 93          LDA    $11
DB23: 48             ASLA
DB24: 8E F9 AB       LDX    #$DB29
DB27: 6E BE          JMP    [A,X]
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
DB4A: 8E 53 67       LDX    #$DB4F
DB4D: 6E 1E          JMP    [A,X]
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
DD6D: 8E 55 FA       LDX    #$DD72
DD70: 6E B4          JMP    [A,X]
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
