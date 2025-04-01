100 REM (SOURCE UNKNOWN) EDITED SLIGHTLY BY D. KURLAND 11/6/75
110 cLS:PRINT "Welcome to Casino PicoCalc"
120 PRINT "The game is Baccarat"
130 H=0: RANDOMIZE TIMER
140 GOSUB 1400
150 DIM A(10),C(10)
160 PRINT "Are you ready";
170 INPUT X$: PRINT
180 IF X$="n" OR X$="N" THEN GOTO 1630
190 cls:PRINT "Wager";
200 D=0
210 E=0
220 INPUT G: print
230 IF G>100000 THEN GOTO 1370
240 IF G>0 THEN GOTO 270
250 PRINT "Ha! Ha!, Very funny!!"
260 GOTO 190
270 B=1
280 GOTO 740
290 A(B)=INT(RND(1)*52)+1
300 C(B)=A(B)-13*INT(A(B)/13)
310 IF C(B)=0 THEN 600
320 ON C(B) GOTO 330,350,370,390,410,430,450,470,490,510,540,570
330 PRINT "Ace ";
340 GOTO 620
350 PRINT "Deuce ";
360 GOTO 620
370 PRINT "Three ";
380 GOTO 620
390 PRINT "Four ";
400 GOTO 620
410 PRINT "Five ";
420 GOTO 620
430 PRINT "Six ";
440 GOTO 620
450 PRINT "Seven ";
460 GOTO 620
470 PRINT "Eight ";
480 GOTO 620
490 PRINT "Nine ";
500 GOTO 620
510 PRINT "Ten ";
520 C(B)=0
530 GOTO 620
540 PRINT "Jack ";
550 C(B)=0
560 GOTO 620
570 PRINT "Queen ";
580 C(B)=0
590 GOTO 620
600 PRINT "King ";
610 C(B)=0
620 IF INT(A(B)/13)<>A(B)/13 THEN 640
630 ON A(B)/13 GOTO 660,680,700,720
640 IF INT(A(B)/13)=0 THEN 660
650 ON INT(A(B)/13) GOTO 680,700,720
660 PRINT "of Clubs"
670 RETURN
680 PRINT "of Diamonds"
690 RETURN
700 PRINT "of Spades"
710 RETURN
720 PRINT "of Hearts"
730 RETURN
740 PRINT "Your first card is a ";
750 GOSUB 290
760 GOSUB 1310
770 PRINT "Your next card is a ";
780 GOSUB 290
790 GOSUB 1310
800 PRINT "Do you want a card";
810 INPUT J$: print
820 IF J$="y" OR J$="Y" THEN GOTO 870
830 C(3)=0
840 D=D+C(B)
850 B=B+1
860 GOTO 900
870 PRINT "The card is a ";
880 GOSUB 290
890 GOSUB 1310
900 print:PRINT "My first card is a ";
910 GOSUB 290
920 GOSUB 1340
930 PRINT "My next card is a ";
940 GOSUB 290
950 GOSUB 1340
960 IF E<10 THEN GOTO 990
970 E=E-10
980 GOTO 960
990 IF E<6 THEN GOTO 1030
1000 PRINT "I do not want a card"
1010 C(6)=0
1020 GOTO 1060
1030 PRINT "I take a card"
1040 PRINT "The card is a ";
1050 GOSUB 290
1060 E=E+C(6)
1070 IF D<10 THEN GOTO 1100
1080 D=D-10
1090 GOTO 1070
1100 print:PRINT "Your total is";D
1110 IF E<10 THEN GOTO 1140
1120 E=E-10
1130 GOTO 1110
1140 PRINT "My total is ";E
1150 IF D=E THEN GOTO 1590
1160 IF D>E THEN GOTO 1200
1170 PRINT "I win $"G
1180 G=-G
1190 GOTO 1210
1200 PRINT "You win $";G
1210 H=H+G
1220 IF H>0 THEN GOTO 1290
1230 IF H=0 THEN GOTO 1610
1240 PRINT "You owe me $";-H
1250 PRINT "Do you want to try again";
1260 INPUT K$: print
1270 IF K$="n" OR K$="N" THEN GOTO 1630
1280 GOTO 190
1290 PRINT "I.O.U. $";H
1300 GOTO 1250
1310 D=D+C(B)
1320 B=B+1
1330 RETURN
1340 E=E+C(B)
1350 B=B+1
1360 RETURN
1370 PRINT "House limit is $100000"
1380 GOTO 190
1400 PRINT "Do you want the rules of the game";
1410 INPUT I$: print
1420 IF I$="n" OR I$="N" THEN RETURN
1430 PRINT "* Rules for the game of baccarat *"
1440 PRINT "The computer is shuffling 6 decks of"
1450 PRINT "cards together.  The rules are as"
1460 PRINT "follows: The object is to be as close"
1470 PRINT "as possible to 9 in 2 or 3"
1480 PRINT "cards.  Face cards and 10's count 0."
1490 PRINT "Aces count as 1. All other cards"
1491 PRINT "count their index value. When the"
1500 PRINT "total is over 10, the 10's unit is"
1510 PRINT "dropped.  Example: A 7 and a 6"
1511 PRINT "totaling 13 count as 3.  The"
1520 PRINT "player with the higher total wins."
1530 PRINT "In case of a tie, the computer wins."
     print
1540 PRINT "Do you understand the rules";
1550 INPUT O$: print
1560 IF O$="y" OR O$="Y" THEN RETURN
1570 PRINT "Tough luck"
1580 RETURN
1590 PRINT "It is a tie. The computer wins!"
1600 GOTO 1170
1610 PRINT "You are even up!!"
1620 GOTO 1250
1630 END
