100 REM * Slot/Bas * Written for CodeWorks magazine
110 REM * 3838 S Warner St. Tacoma, WA 98409 (206) 475-2219
120 REM * placed in public domain 1987 (C)1987 80-NW Publishing Inc
130 '
135 RANDOMIZE TIMER

function ToPixelY(line) as integer
    ToPixelY = line * MM.FONTHEIGHT
end function
function ToPixelX(col) as integer
    ToPixelX = col * MM.FONTWIDTH
end function

220 'do some initialization of variables
240 DIM E$(3)
250 A$="##########  ##########  ##########"
260 B$="  XXXXXX  "
    DLY=500
280 '
400 'clear the screen and print the heading
410 CLS
420 PRINT "SILVER DOLLAR SLOT MACHINE"
430 PRINT
440 PRINT "=== 3 BARS PAY $ 100 ===
450 PRINT "3 CHERRIES, PLUMS or BELLS pay $ 10
460 PRINT "2 CHERRIES, 2 PLUMS or 2 BELLS
470 PRINT "when on the RIGHT side pay  $ 3
480 PRINT "except with a lemon on the left.
490 '
560 'print the wheels
570 PRINT @(0,ToPixelY(9)) A$;
580 PRINT @(0,ToPixelY(10)) A$;
590 PRINT @(0,ToPixelY(11)) A$;
600 '
610 ' get started
620 PRINT @(0,ToPixelY(14)) "How many coins will you start with";
630 INPUT CU
640 IF CU=<0 THEN 620 ' can't start without putting coins in
650 CU=CU-1
670 PRINT @(0,ToPixelY(14)) STRING$(48,32);
680 '
690 'start of main loop, play as long as CU is not zero
700 PRINT @(0,ToPixelY(10)) A$;
710 '
720 ' spin the wheels and pick what they stop on.
730 ' note that locate Y is already defined in the J loop here.
740   FOR J=1 TO 3
750     IF J=1 THEN Y=0 ELSE IF J=2 THEN Y=12 ELSE Y=24
760     FOR I=35 TO Y STEP -1
770       PRINT @(ToPixelX(y),ToPixelY(10)) B$; ' print the center bar
775       pause 20
780       PRINT @(ToPixelX(y),ToPixelY(10)) STRING$(10,32); ' blank the center bar
785       pause 20
790     NEXT I
800     GOSUB 1160 ' to pick what it stops on
810     PRINT @(ToPixelX(y),ToPixelY(10)) C$;
820   NEXT J ' end of wheel spinning loop
830 '
840 ' take D$ apart to see what is in it
850   FOR K=1 TO 3
860     E$(K)=MID$(D$,K,1)
870   NEXT K
880 '
890 ' find out if we have a win and if so, what kind.
900   IF E$(1)=E$(2) AND E$(1)=E$(3) AND VAL(E$(1))=1 THEN GOSUB 1320:GOTO 950
910   IF E$(1)=E$(2) AND E$(1)=E$(3) AND VAL(E$(1))>2 THEN GOSUB 1420:GOTO 950
920   IF E$(2)=E$(3) AND E$(1)<>"2"  AND VAL(RIGHT$(D$,2)) > 22 THEN GOSUB 1520:GOTO 950
930 '
940   IF CU=0 THEN 1080
950   PRINT @(0,ToPixelY(14)) "Press ENTER to pull the lever";
960   INPUT XX
970   CU=CU-1
990   PRINT @(0,ToPixelY(15)) STRING$(20,32);
1000   PRINT @(0,ToPixelY(15)) "You now have $";CU
1010   D$=""
1020   PRINT @(0,ToPixelY(14)) STRING$(40,32);
1030   PL=PL+1 ' keep track of number of pulls
1040 GOTO 700
1050 ' end of main loop
1060 '
1070 'end play when you have lost all your money.
1080 PRINT @(0,ToPixelY(15)) "The one-armed bandit got you!
1090 PRINT"You have put $";PL+1;" into this machine.
1100 END
1110 '
1150 ' pick a random number between 1 and 5
1160 A1=INT(RND*5)+1
1170 '
1180 ' retard lemons during early part of play
1190 IF PL>30 THEN PQ=1 ELSE IF PL>15 THEN PQ=2 ELSE PQ=3
1200 AA=INT(RND(1)*PQ)+1
1210 IF AA>1 THEN IF A1=2 THEN 1160
1220 ON A1 GOTO 1250,1260,1270,1280,1290
1230 '
1240 ' D$ will be built up here to keep track of what we have
1250 C$="  ==BAR== ":D$=D$+"1":RETURN
1260 C$="   lemon  ":D$=D$+"2":RETURN
1270 C$="   PLUM   ":D$=D$+"3":RETURN
1280 C$="   BELL   ":D$=D$+"4":RETURN
1290 C$="  CHERRY  ":D$=D$+"5":RETURN
1300 '
1310 ' three bars win routine
1320 FOR JP=1 TO 100
1340   PRINT @(ToPixelX(5),ToPixelY(14)) "K L U N K":gosub 1810
1345   pause 100
1350   PRINT @(ToPixelX(5),ToPixelY(14)) STRING$(10,32);
       pause 100
1360   CU=CU+1
1370   PRINT @(0,ToPixelY(15)) "You now have $";CU
1380 NEXT JP
1390 RETURN
1400 '
1410 ' three of a kind win routine
1420 FOR JP=1 TO 10
1440   PRINT @(ToPixelX(5),ToPixelY(14)) "K L U N K":gosub 1810
1445   pause 100
1450   PRINT @(ToPixelX(5),ToPixelY(14)) STRING$(10,32);
       pause 100
1460   CU=CU+1
1470   PRINT @(0,ToPixelY(15)) "You now have $";CU
1480 NEXT JP
1490 RETURN
1500 '
1510 ' two on the right win routine
1520 FOR JP=1 TO 3
1540   PRINT @(ToPixelX(5),ToPixelY(14)) "C L I N K":gosub 1810
1545   pause 100
1550   PRINT @(ToPixelX(5),ToPixelY(14)) STRING$(10,32);
       pause 100
1560   CU=CU+1
1570   PRINT @(0,ToPixelY(15)) "You now have $";CU
1580 NEXT JP
1590 RETURN
1600 '
1800 REM Bell
1810 play tone 1000,1000,200: return
