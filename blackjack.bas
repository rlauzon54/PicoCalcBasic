100 REM *** B L A C K J A C K ***
101 RANDOMIZE TIMER
110 DIM D(208),H(16),O(16),P(16,11),Q(11),S(16),X(16)
120 CLS
    PRINT "Welcome to the Casino"
140 PRINT
    INPUT "Instruction? (Y/N) ";M1$: PRINT
	IF M1$="N" or M1$="n" THEN GOTO 160
150 IF M1$="Y" or M1$="y" THEN GOSUB 1640:GOTO 160
151 GOTO 140
160 R=16
    INPUT "How many decks (1-4)";N: PRINT
170 IF N<1 OR N>4 THEN PRINT "1 TO 4 ONLY";:GOTO 170
180 E=N*52
    GOSUB 870
	B=1
	GOSUB 890
	A=1
190 PRINT
    G=1
200 INPUT"Bet";U: print
    IF U>0 THEN GOTO 220
201 IF U=0 THEN 1600
210 B=1
    GOSUB 890
	GOTO 200
220 IF U<=500 THEN 240
221 PRINT "Sorry, the house limit is $500."
230 GOTO 200
240 GOSUB 930
    H(1)=U
	N=Q(2)
	PRINT
	PRINT "My up card";
	GOSUB 1050
	N=P(R,1)
250 PRINT
    PRINT "Your 1st card ";
	GOSUB 1050
	PRINT "Your 2nd card ";
	N=P(R,2)
260 GOSUB 1050
270 GOSUB 1170
    IF M<>11 THEN 280
271 GOSUB 1550
280 IF W<>21 THEN GOTO 320
281 PRINT
    PRINT"I have Blackjack, ";
290 IF X(1)<>21 THEN GOTO 310
291 PRINT "So do you.  We push."
300 GOSUB 1510
    GOTO 190
310 PRINT "You lose"
    V=V-U
	GOTO 300
320 IF X(1)<>21 THEN GOTO 340
321 PRINT "You have blackjack.  You win!"
330 V=V+3*U/2
    GOTO 300
340 PRINT
    PRINT "Play ";
	IF R=1 THEN GOTO 350
341 PRINT "For hand";G;
350 PRINT
    PRINT "Your total is";X(G);
	INPUT F:print
	IF F>-1 THEN GOTO 370
360 PRINT "Only 0-3 is valid";
    GOTO 350
370 IF F>3 THEN GOTO 360
371 IF F<>1 THEN GOTO 550
380 REM ******** PLAYER HIT ROUTINE *************
390 IF A<=E THEN GOTO 400
400 GOSUB 1220
401 M=S(G)
    M=M+1
	S(G)=M
	N=D(A)
	P(G,M)=N
	PRINT "Your card is ";
	GOSUB 1050
410 GOSUB 1010
    A=A+1
	IF N<>11 THEN GOTO 420
411 O(G)=O(G)+1
420 X(G)=X(G)+N
430 IF X(G)<22 THEN GOTO 340
431 IF O(G)=0 THEN GOTO 450
440 O(G)=O(G)-1
    X(G)=X(G)-10
	GOTO 430
450 PRINT
    PRINT "You busted with";X(G)
	X(G)=0
	Y=Y-1
	PRINT
460 REM ********* CHECK FOR END OF PLAY ************
470 IF G<R THEN GOTO 500
480 GOSUB 1250
490 GOTO 190
500 G=G+1
510 N=P(G,1)
520 PRINT "Your 1st card for hand";G;" was";
530 GOSUB 1050
540 GOTO 340
550 IF F<>0 THEN GOTO 620
560 REM *********PLAYER STAND ALONE ROUTINE ************
570 IF X(G)<22 THEN GOTO 470
580 IF O(G)=0 THEN GOTO 450
590 X(G)=X(G)-10
600 O(G)=O(G)-1
610 G=G+1
620 IF F<>2 THEN GOTO 730
630 IF S(G)=2 THEN GOTO 670
640 PRINT "Double on 1st 2 cards only"
650 GOTO 340
660 REM ***** DOUBLE DOWN ROUTINE **********
670 IF A<=E THEN GOTO 680
671 GOTO 1220
680 H(G)=2*U
    N=D(A)
	P(G,3)=N
	A=A+1
	PRINT "You draw the";:GOSUB 1050
690 GOSUB 1010
    IF N=11 THEN O(G)=O(G)+1
700 X(G)=X(G)+N
710 IF X(G)<22 THEN GOTO 470
720 IF O(G)=0 THEN GOTO 450
721 O(G)=O(G)-1
    X(G)=X(G)-10
	GOTO 1350
730 N=P(G,1)
    Y=Y+1
	GOSUB 1010
	M=N
	N=P(G,2)
	GOSUB 1010
	IF M=N THEN GOTO 760
740 PRINT "You may only split pairs"
    GOTO 340
750 REM *********PAIR SPLIT ROUTINE **********
760 R=R+1
    Y=Y+1
	P(R,1)=P(G,2)
	S(G)=1
	S(R)=1
	X(G)=X(G)/2
	X(R)=X(G)
770 H(R)=U
    IF N<>11 THEN GOTO 340
780 REM **********ACES WERE SPLIT - 1 CARD EACH *********
790 IF A>E THEN GOSUB 1220
800 N=D(A)
    P(G,2)=N
	PRINT "1st Ace gets a ";
	GOSUB 1050
	GOSUB 1010
810 IF N=11 THEN N=1
820 X(G)=X(G)+N
    A=A+1
	IF A>E THEN GOSUB 1220
830 N=D(A)
    P(R,2)=N
	PRINT "2nd Ace gets a ";
	GOSUB 1050
	GOSUB 1010
840 IF N=11 THEN N=1
850 X(R)=X(R)+N
    A=A+1
	GOTO 480
860 REM ************ BUILD 1 TO 4 DECKS ************
870 FOR I=1 TO N
    J=(I-1)*52
	FOR K =1 TO 52
	D(J+K)=K
	NEXT K,I
	RETURN
880 REM *********SHUFFLE THE CARDS ***********
890 CLS
    PRINT "I'm shuffling.... "
	FOR I=B TO E
900 C=RND(1)*E
    IF C<B THEN GOTO 900
901 L=D(I)
    D(I)=D(C)
	D(C)=L
	NEXT I
910 A=B
    RETURN
920 REM ******** DEAL THE CARDS ***********
930 FOR I=1 TO 11
    Q(I)=0
	FOR J=1 TO R
	P(J,I)=0
	NEXT J,I
	R=1:Y=1
940 IF A+4>E THEN B=1:GOSUB 890
950 PRINT "Dealing"
    P(R,1)=D(A)
	Q(1)=D(A+1)
	P(R,2)=D(A+2)
	Q(2)=D(A+3)
960 A=A+4
    T=2
	S(1)=2
	GOSUB 980
	M=N
	RETURN
970 REM ********** COMPUTE THE VALUE OF THE DEALERS HAND *********
980 Z=0
    W=0
	FOR I=1 TO 2
	N=Q(I)
	GOSUB 1010
	IF N=11 THEN Z=Z+1
990 W=W+N
    NEXT I
	RETURN
1000 REM **********COMPUTE THE VALUE OF A CARD **********:
1010 IF N<14 THEN GOTO 1020
1011 N=N-13
     GOTO 1010
1020 IF N=1 THEN N=11:RETURN
1021 GOTO 1030
1030 IF N<11 THEN RETURN
1031 N=10
     RETURN
1040 REM **********PRINT A CARD **********
1050 I=0
1060 IF N>=14 THEN N=N-13:I=I+1:GOTO 1060
1070 IF N=1 THEN PRINT "Ace";:GOTO 1130
1080 IF N<10 THEN PRINT N;:GOTO 1130
1090 IF N<11 THEN PRINT N;:GOTO 1130
1100 IF N<12 THEN PRINT "Jack";:GOTO 1130
1110 IF N<13 THEN PRINT "Queen";:GOTO 1130
1120 PRINT "King";
1130 PRINT " of ";
     IF I=0 THEN PRINT "Spades":RETURN
1140 IF I=1 THEN PRINT "Hearts":RETURN
1150 IF I=2 THEN PRINT "Diamonds":RETURN
1151 PRINT "Clubs"
     RETURN
1160 REM ********* COMPUTE VALUE OF PLAYERS HAND *********:
1170 O(G)=0
     X(G)=0
	 FOR I =1 TO 2
	 N=P(G,I)
	 GOSUB 1010
	 X(G)=X(G)+N
1180 IF N<>11 THEN GOTO 1200
1190 O(G)=O(G)+1
1200 NEXT I
     RETURN
1210 REM *********SAVE THE CARDS THAT ARE ALREADY DEALT AND SHUFFLE**
1220 K=T
     FOR I=1 TO R
	 K=K+S(I)
	 NEXT I
1230 FOR I=1 TO K
     A=A-1
	 J=D(I)
	 D(I)=D(A)
	 D(A)=J
	 NEXT I
	 B=K+1
	 GOSUB 890
	 RETURN
1240 REM *******DEALERS LOGIC **********:
1250 N=Q(1)
     PRINT "My hole card";
	 GOSUB 1050
	 IF Y=0 THEN GOTO 1390
1260 IF W<17 THEN GOTO 1300
1270 IF W>17 THEN GOTO 1340
1280 IF Z=0 THEN GOTO 1380
1290 W=W-10
     Z=Z-1
1300 IF A>E THEN GOSUB 1220
1310 N=D(A)
     T=T+1
	 A=A+1
	 PRINT
	 PRINT "I draw the ";
	 GOSUB 1050
	 GOSUB 1010
1320 IF N=11 THEN Z=Z+1
1330 W=W+N
     GOTO 1260
1340 IF W<22 THEN GOTO 1380
1350 IF Z=0 THEN GOTO 1370
1360 Z=Z-1
     W=W-10
	 GOTO 1260
1370 PRINT "I Busted ";
1380 PRINT "My total is";W
1390 FOR I =1 TO R
     PRINT "You ";:
	 IF X(I)<>0 THEN GOTO 1410
1400 PRINT "Lost ";
     V=V-H(I)
	 GOTO 1460
1410 IF W<22 THEN GOTO 1430
1420 PRINT "Won ";
     V=V+H(I)
	 GOTO 1460
1430 IF W<>X(I) THEN GOTO 1450
1440 PRINT "Pushed on ";
     GOTO 1460
1450 IF W<X(I) THEN GOTO 1420
1451 GOTO 1400
1460 IF R<>1 THEN GOTO 1470
1461 PRINT "The hand"
     GOTO 1480
1470 PRINT "Hand ";I
1480 NEXT I
1490 REM ********* PRINT THE PLAYERS WON/LOST STANDING *******
1500 PRINT
1510 PRINT "You're ";
     IF V=0 THEN PRINT "even":RETURN
1520 IF V<0 THEN PRINT "behind $"V:RETURN
1521 PRINT "ahead $";V:RETURN
1530 PRINT "ahead $";V
1540 REM ********INSURANCE ROUTINE ************
1550 INPUT "Insurance (Y/N)";M1$:print
     IF M1$="N" or M1$="n" THEN RETURN
1570 PRINT "Your insurance bet ";
     IF W=21 THEN PRINT "wins":V=V+U:RETURN
1580 PRINT "loses"
     V=V-U/2
	 RETURN
1590 REM ******END OF GAME WRAP UP **************
1600 PRINT "Thanks for playing"
     PRINT "Hope you enjoyed yourself."
1610 PRINT "Here's your final standing.":GOSUB 1510
1620 IF V>0 THEN PRINT "Now, just you try to collect!!":END
1630 IF V=0 THEN PRINT "Big deal......":END
1631 PRINT "Pay up, or else":END
1640 REM ******** INSTRUCTIONS ***********
1650 PRINT
     PRINT"The dealer stands on 17 or more."
1660 PRINT"But will hit a soft 17."
1670 PRINT"You may split any pair."
     PRINT"You may double the 1st 2 cards"
1680 PRINT"An get only 1 more card."
     PRINT
	 PRINT"Play codes:"
1690 PRINT "0 - Stand"
     PRINT "1 - Hit"
	 PRINT "2 - Double down"
1700 PRINT "3 - Split a pair"
     PRINT
	 PRINT "A 0 bed ends the game"
1710 PRINT "A negative bet forces a shuffle"
1720 PRINT "Good luck - Let's start"
     RETURN
