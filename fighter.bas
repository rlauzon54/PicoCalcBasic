function ToPixelY(line) as integer
    ToPixelY = line * MM.FONTHEIGHT
end function

function ToPixelX(col) as integer
    ToPixelX = col * MM.FONTWIDTH
end function

sub Beep
    play tone 500,500
    pause 500
    play stop
end sub

sub CsrHome
    print @(0,0) "";
end sub

sub Explosion
    local i, sx, sy, tx, ty, colr

    ' The screen location that's the "center"
    sx = 170
    sy = 170
    
    ' The max area for the explosions
    tx = MM.FONTWIDTH*2*2
    ty = MM.FONTHEIGHT*2*2
    
    ' Make the explosions different colors
    for i = 1 to 10
        select case int(rnd*5)+1
            case 1
                colr = rgb(red)
            case 2
                colr = rgb(yellow)
            case 3
                colr = rgb(orange)
            case 4
                colr = rgb(white)
            case 5
                colr = rgb(gold)
            case else
                colr = rgb(red)
        end select
        
        circle sx-int(rnd*tx), sy-int(rnd*ty), int(rnd*30), 1, 1, colr, colr
        pause 50
    next i
end sub

10 CLS
11 T=0
15 BLANK$="       "
20 Y5=3:GOSUB 670
30 PRINT "You have been asked to go on a mission"
40 PRINT "to destroy five enemy craft that"
   print "threaten the Galaxy...."
50 PRINT "You must position your craft to that"
60 PRINT "the enemy is in a position in the"
70 PRINT "center of your gunsight in order to
   print "destroy him."
80 PRINT
   PRINT "The aiming is done as follows:"
90 PRINT "Hit the arrow keys to move your sights."
100 PRINT "For example, to move the gunsight up"
110 PRINT "(Target down), hit the up arrow.. Hit"
120 PRINT "Return to fire."
125 PRINT
130 PRINT "If you finish with a rating over 75%,"
135 PRINT "you will notice the time between target"
140 PRINT "moves speeding up. Also, if your rating"
145 PRINT "is 50% or less, the time will decrase."
150 PRINT "As you get better, your rating will"
    print "improve. GOOD LUCK!!!!!!"
170 pause 1500
175 PRINT:RANDOMIZE timer
180 PRINT "TYPE N FOR NOVICE PILOT,"
    print "     E FOR EXPERIENCED,"
185 INPUT "OR   A FOR ACE"; V$
    v$=ucase$(v$)
190 IF V$="E" THEN V8=200:GOTO 220
200 IF V$="N" THEN V8=350:GOTO 220
210 IF V$="A" THEN V8=100:GOTO 220
215 GOTO 180
220 CLS
230 Y5=10:X5=0:GOSUB 670
240 PRINT "Good luck -- on into battle!!!"
250 pause 1000
270 D2=1:D1=1:CLS
280 GOSUB 1140
290 Y5=6:X5=0:GOSUB 670:GOSUB 500
300 Y5=INT(10*RND+7)
310 X5=INT(20*RND+6)
320 P=X5:Q=Y5:Y5=6:X5=0:GOSUB 670:GOSUB 500:X5=P:Y5=Q
    GOSUB 670
330 GOSUB 640
340 CsrHome
350 Z$="":do WHILE Z$=""
355 Z$=INKEY$
360 GOSUB 1080
365 loop
370 D=ASC(Z$)
380 GOSUB 670

' Arrow up: 128
' Arrow down: 129
' Arrow left: 130
' Arrow right: 131
' Enter: 10 or 13 (old and new firmware)
390 IF D=130 THEN X5=X5+1
400 IF D=131 THEN X5=X5-1
410 IF D=128 THEN Y5=Y5+1
420 IF D=129 THEN Y5=Y5-1
430 IF D=13 or D=10 THEN GOTO 710
450 GOSUB 1050
460 GOTO 320

' Print gunsight
500 PRINT string$(8,32)+string$(11,196)+chr$(194)+string$(10,196)
510 PRINT string$(19,32)+chr$(179)
520 PRINT string$(19,32)+chr$(179)
530 PRINT string$(19,32)+chr$(179)
540 PRINT " "+chr$(179)+string$(37,32)+chr$(179)
550 PRINT " "+chr$(179)+string$(10,32)+chr$(179)+string$(15,32)+chr$(179)+string$(10,32)+chr$(179)
560 PRINT " "+chr$(195)+string$(10,196)+chr$(180)+string$(15,32)+chr$(195)+string$(10,196)+chr$(180)
570 PRINT " "+chr$(179)+string$(10,32)+chr$(179)+string$(15,32)+chr$(179)+string$(10,32)+chr$(179)
580 PRINT " "+chr$(179)+string$(37,32)+chr$(179)
590 PRINT string$(19,32)+chr$(179)
600 PRINT string$(19,32)+chr$(179)
610 PRINT string$(19,32)+chr$(179)
620 PRINT string$(8,32)+string$(11,196)+chr$(193)+string$(10,196)
630 RETURN

    ' Print enemy fighterm
    ' Red = in sights
640 if x5=17 and y5=12 then
    color rgb(red)
else
    color rgb(yellow)
endif
PRINT chr$(204)+chr$(205)+chr$(150)+chr$(205)+chr$(185)
color rgb(green)
650 P=Y5:Q=X5
660 RETURN

670 PRINT @(ToPixelX(X5),ToPixelY(Y5));
680 RETURN

710 IF Y5=12 THEN GOTO 740
720 GOSUB 880
730 GOTO 320
740 IF X5=17 THEN GOTO 770
750 GOSUB 880
760 GOTO 320
770 Explosion
FOR N=0 TO 3:Beep:NEXT N
pause 500

' Clear screen and redisplay sights
cls
Y5=6:X5=0:GOSUB 670:GOSUB 500

820 Y5=22:X5=0:GOSUB 670
830 PRINT "      May the Force Be With You!!"

840 Y5=1:X5=0:GOSUB 670
850 PRINT "Enemy destroyed=";D1
860 D1=D1+1
865 IF D1=6 THEN GOTO 920
870 GOTO 300
880 P=Y5:Q=X5:Y5=2:X5=0:GOSUB 670
890 PRINT "Number missed=";D2:D2=D2+1
900 Y5=P:X5=Q:GOSUB 670
910 RETURN
920 Y5=22:X5=10:GOSUB 670
930 D2=D2-1
940 Y5=20:X5=0:GOSUB 670
950 PRINT "The Home Base has been saved."
    print "        Congratulations"
960 PRINT "Your mission record: ";format$(5/(5+D2)*100,"%5.2f");"%         "
970 IF 5/(5+D2)*100 >75 THEN V8=V8-50:IF V8<=50 THEN GOTO 1200
980 IF 5/(5+D2)*100 <51 THEN V8=V8+50
990 PRINT "Do you want another mission?";
1000 q1$="":do WHILE q1$="":q1$=INKEY$:loop
     q1$=ucase$(q1$)
1020 IF q1$<>"Y" THEN END

' Blank out the end of game stuff
Y5=20:X5=0:GOSUB 670
PRINT string$(39,32)
PRINT string$(39,32)
PRINT string$(39,32)
PRINT string$(39,32)

' Go again
1030 GOTO 270

' Blank out old enemy fighter
1050 PRINT @(ToPixelX(Q),ToPixelY(P));
1060 PRINT BLANK$;
1070 RETURN

1080 T=T+1
1090 IF T>V8 THEN GOTO 1110
     pause 10: ' Slow down the PicoCalc a bit
1100 RETURN

1110 IF X5>31 OR X5<1 THEN GOTO 1116
1112 X5=X5-1:Y5=Y5+1:GOSUB 1050: GOSUB 670:GOSUB 640: CsrHome: GOTO 1120
1116 X5=X5+1:Y5=Y5-1:GOSUB 1050:GOSUB 670:GOSUB 640:CsrHome:GOTO 1120
1120 IF Y5>18 OR Y5<5 THEN CLS:PRINT "You're shot down!!!":GOTO 1125
1122 T=0:RETURN
1125 X5=0:Y5=6:GOSUB 670:GOSUB 500:V8=V8+50:GOTO 990
1140 IF V8<=100 THEN q1$="Rating=Ace":GOTO 1170
1150 IF V8>= 350 THEN q1$="Rating=Novice":GOTO 1170
1160 q1$="Rating=Experienced"
1170 Y5=1:X5=19:GOSUB 670
1180 PRINT q1$
1190 RETURN
1200 CLS
1210 pause 500
1220 PRINT:PRINT " C O N G R A T U L A T I O N S !!!!"
1230 PRINT:PRINT "	YOU BEAT THE COMPUTER!!"
END
