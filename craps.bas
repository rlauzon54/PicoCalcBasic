100 REM  NAME--CRAPS
110 REM
120 REM  DESCRIPTIONS--A SESSION AT THE CRAPS TABLE.
130 REM
140 REM  SOURCE--UNKNOWN
150 REM
160 REM  INSTRUCTIONS--TYPE "RUN" AND FOLLOW INSTRUCTIONS.
170 REM
180 REM
190 REM  *  *  *  *  *  *   MAIN PROGRAM  *  *  *  *  *  *  *  *  *  *
200 REM
210 RANDOMIZE TIMER
220 PRINT
230 PRINT "Welcome to the digital craps table."
240 PRINT "Do you want instructions (0=NO  1=YES) ";
250 INPUT Z0:PRINT
260 IF Z0=0 THEN 350
270 IF Z0=1 THEN 300
280 PRINT "Please type '1' or '0'";
290 GOTO 250
300 PRINT "On the first throw, 2'S,3'S and 12'S"
310 PRINT "lose, 7'S and 11'S win.  On later throws"
320 PRINT "7'S and 11'S lose, and theh original"
    PRINT "number wins. Any other result causes"
330 PRINT "another throw. Bets may range from .01"
340 PRINT "to 10000. Enter '-1' to show the state"
    PRINT "of your winnings or losses, and a '0'"
	PRINT "to quit."
350 PRINT
360 PRINT
370 PRINT
380 PRINT "How much do you bet";
390 INPUT B1:PRINT
400 IF B1<0 THEN 840
410 IF B1=0 THEN 960
420 IF B1<5 THEN 940
430 IF B1>10000 THEN 820
440 LET T7=0
450 LET D1=INT(6*RND(1))+1
460 LET D2=INT(6*RND(1))+1
470 PRINT D1;D2;
480 LET T=D1+D2
490 IF T7>0 THEN 520
500 IF T=12 THEN 750
510 IF T=2 THEN 770
520 IF T=8 THEN 560
530 IF T=11 THEN 560
540 PRINT " - A";T;
550 GOTO 570
560 PRINT " - AN";T;
570 IF T7>0 THEN 630
580 IF T=3 THEN 780
590 IF T=7 THEN 710
600 IF T=11 THEN 710
610 LET D9=T
620 GOTO 680
630 IF T=7 THEN 780
640 IF T=11 THEN 780
650 IF T=D9 THEN 710
660 PRINT
670 GOTO 450
680 PRINT: PRINT "Your number is " T
690 LET T7=1
700 GOTO 450
710 PRINT:PRINT "You win"
720 LET W=W+B1
730 PRINT "You win $" B1
740 GOTO 370
750 PRINT " Boxcars.....";
760 GOTO 780
770 PRINT " Snake eyes.....";
780 LET W=W-B1
790 PRINT: PRINT "You lose"
800 PRINT "You lose $" B1
810 GOTO 370
820 PRINT "Are you kidding me? Try a little less."
830 GOTO 370
840 PRINT
850 IF W>=0 THEN 920
860 PRINT"You are behind $";-W
    PRINT"Try some more (1=YES  0=NO) ";
870 INPUT H0:PRINT
880 IF H0=0 THEN 960
890 IF H0=1 THEN 370
900 PRINT "Plesae enter '1' OR '0'";
910 GOTO 870
920 PRINT "You are ahead $";W;".  How about a little more";
930 GOTO 870
940 PRINT "You are a cheapskate, but I'll play."
950 GOTO 440
960 PRINT
970 PRINT
980 PRINT
990 PRINT
1000 IF W>=0 THEN 1040
1010 PRINT "You lost $";-W;" Tough life."
1020 PRINT "Let this be a lesson."
1030 goto 1050
1040 PRINT "You won $";W;"... I will send the check tomorrow."
1050 END
