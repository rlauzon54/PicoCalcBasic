10 REM
100 input "Do you want instructions? (Y/N)";ZZ$:ZZ$=ucase$(zz$)
102 IF ZZ$="N" THEN 120
110 GOSUB 170
120 GOSUB 480
130 REM
140 GOSUB 620
150 GOSUB 750
160 GOTO 130
170 REM Instructions
190 PRINT "              Haunted House"
200 PRINT "            By Barry Gaskins"
    print
250 PRINT "You are lost in the woods and are at"
260 PRINT "the entrance to a strange looking"
    print "house.  Looking for help and food you"
280 PRINT "decide to go in. Suddenly the door"
290 PRINT "slams shut. You hear an evil laugh and"
300 PRINT "a voice coming from the very walls:"
310 PRINT "'You will never leave this"
320 PRINT "house.  You will stay forever to"
330 PRINT "walk its rooms and halls. Hear these"
350 PRINT "words and know your doom!!!!!"
    print "HA HA HA HA....'"
360 gosub 1900
380 PRINT "Looking around you see that there are"
381 PRINT "several exits but no windows."
382 PRINT "Maybe you have a chance..."
410 PRINT "If you tell me what you want to do, I"
411 PRINT "will tell you what is happening."
    print "and if you need help, just type HELP"
	print "in place of your command."
450 gosub 1900
470 RETURN
480 DIM S(13)
    DIM S1$(13)
	L=1
490 DIM R$(13)
    DIM E$(13)
	DIM CO$(14)
500 FOR X=1 TO 13
    S(X)=X
	READ S1$(X)
	NEXT
510 FOR X=1 TO 13
    READ R$(X)
	NEXT
520 FOR X=1 TO 12
    READ E$(X)
	NEXT
530 FOR X=1 TO 14
    READ CO$(X)
	NEXT
540 RETURN
550 DATA rope,sword,key,bucket of water,rug,wand,moldy food,wine,kegs
551 DATA ashes,rocks,leabes,null
560 DATA The Den,A Trophy room,The Servents Quarters,The Dining Room
561 DATA The Kitchen,The cellar,a storage room,The wine cellar
562 DATA aging room,a narrow pasage,a huge cave,a small save
563 DATA the outside world
570 DATA "south east and west","west","north","north","south and east"
580 DATA "up and east","south","west east and north","west"
590 DATA "east and west","east and west","west"
600 DATA "north","south","east","west","up","down"
610 DATA get,drop,use,offer,drink,search,attack with,inventory
620 PRINT "You are in ";R$(L)
630 PRINT "Visible items: ";
640 FOR X=1 TO 13
    IF S(X)=L THEN PRINT S1$(X)" ";
650 NEXT
    PRINT
660 PRINT "You see exits "; E$(L)
670 IF L=6 AND NOT F2 THEN PRINT "There is a ghost in this room!!!"
680 IF L=10 AND NOT F4 THEN PRINT "A wall of fire blocks your way!!!"
690 IF L=11 AND NOT F5 THEN PRINT "There is a huge, hungry giant in here."
700 IF L=12 THEN GOSUB 711
710 RETURN
711 PRINT "There is a hole in the ceiling and you"
    print "can see the open sky above!!!"
712 RETURN
720 PRINT"Legal commands are:"
730 FOR X=1 TO 6
    PRINT "  ";CO$(X)
	NEXT
731 FOR X=7 TO 13
    PRINT "  ";CO$(X);" something"
	NEXT
732 PRINT "  ";CO$(14)
    PRINT
740 PRINT "I only look at the first 3 letters of"
741 PRINT "each word, so you only need to type"
    print "the first 3 letters."
	GOTO 1890
750 REM Input command
760 INPUT "What do you want to do";dc$:print
    dc$=lcase$(dc$)
770 IF dc$="up" THEN X=5:GOTO 810
780 IF LEN(dc$)<3 THEN 720
790 FOR X=1 TO 14
    IF LEFT$(dc$,3)=LEFT$(CO$(X),3) THEN 810
800 NEXT
    GOTO 720
810 IF X<7 THEN 910
820 IF X=14 THEN 1320
830 IF X=7 THEN 1360
840 IF X=8 THEN 1470
850 IF X=9 THEN 1530
860 IF X=11 THEN 1590
870 IF X=10 THEN 1640
880 IF X=12 THEN 1690
890 IF X=13 THEN 1750
900 GOTO 720
910 ON L GOTO 920,970,990,1010,1030,1070,1110,1130,1170,1200,1230,1270
920 IF X=1 THEN 1350
930 IF X=2 THEN L=3:RETURN
940 IF X=3 THEN L=2:RETURN
950 IF X=4 THEN L=5:RETURN
960 GOTO 1350
970 IF X=4 THEN L=1:RETURN
980 GOTO 1350
990 IF X=1 THEN L=1:RETURN
1000 GOTO 1350
1010 IF X=1 THEN L=5:RETURN
1020 GOTO 1350
1030 IF X=2 THEN L=4:RETURN
1040 IF X=3 THEN L=1:RETURN
1050 IF X=6 AND F1 THEN L=6:RETURN
1060 GOTO 1350
1070 IF X=3 AND F2 THEN L=8:RETURN
1080 IF X=3 THEN PRINT"The ghost blocks your way!"
1090 IF X=5 THEN L=5:RETURN
1100 GOTO 1350
1110 IF X=2 THEN L=8:RETURN
1120 GOTO 1350
1130 IF X=1 THEN L=7:RETURN
1140 IF X=3 THEN L=9:RETURN
1150 IF X=4 THEN L=6:RETURN
1160 GOTO 1350
1170 IF X=3 AND F3 THENL=10:RETURN
1180 I FX=4 THEN L=8:RETURN
1190 GOTO 1350
1200 IF X=3 AND F4 THEN L=11:RETURN
1210 IF X=4 THEN L=9:RETURN
1220 GOTO 1350
1230 IF X=3 AND F5 THEN L=12:RETURN
1240 IF X=4 THEN L=10:RETURN
1250 IF X=3 THEN PRINT "You were burned up in the fire":GOTO 1820
1260 GOTO 1350
1270 IF X=4 THEN L=11:RETURN
1280 IF X=5 AND F6 THEN 1300
1290 GOTO 1350
1300 PRINT "You mae it out alive!!!"
1310 PRINT "Good job":END
1320 PRINT "  INVENTORY:"
1330 FOR X=1 TO 13
     IF S(X)=0 THEN PRINT S1$(X)
1340 NEXT
     GOTO 1890
1350 PRINT " You can't go that way."
     GOTO 1890
1360 dc$=dc$+" "
     N=LEN(dc$)-1
	 FOR X=1 TO N
	 IF LEFT$(dc$,1)=" " THEN X=N
1370 dc$=RIGHT$(dc$,LEN(dc$)-1)
1380 NEXT
     IF LEN(dc$)<2 THEN 1430
1390 dc$=LEFT$(dc$,LEN(dc$)-1)
     IF LEN(dc$)<3 THEN 1430
1400 FOR X=1 TO 13
     IF LEFT$(dc$,3)=LEFT$(S1$(X),3)THEN 1420
1410 NEXT
     GOTO 1430
1420 IF S(X)=L THEN S(X)=0:GOTO 1440
1430 PRINT "I see no ";dc$;" here"
     GOTO 1890
1440 IF dc$="rug" AND NOT F1 THEN 1461
1450 IF X=9 THEN S(X)=L:PRINT "The kegs are much to big to carry.":GOTO 1890
1460 RETURN
1461 F1=1
     PRINT" There was a trapdoor under the rug!"
	 PRINT
	 E$(5)="down "+E$(5)
1462 GOTO 1890
1470 dc$=dc$+" "
     N=LEN(dc$)
	 FOR X=1 TO N
	 IF LEFT$(dc$,1)=" "THEN X=N
1480 dc$=RIGHT$(dc$,LEN(dc$)-1)
     NEXT
	 IF LEN(dc$)<2 THEN 1520
1490 dc$=LEFT$(dc$,LEN(dc$)-1)
     IF LEN(dc$)<3 THEN 1520
1500 FOR X=1 TO 13
     IF LEFT$(dc$,3)=LEFT$(S1$(X),3) AND S(X)=0 THEN S(X)=L:RETURN
1510 NEXT
1520 PRINT "You don't have a ";dc$
     GOTO 1890
1530 REM 
1540 GOSUB 1840
     IF LEN(dc$)<3 THEN 1580
1550 IF LEFT$(dc$,3)="key" AND S(3)=0 AND L=9 AND FO THEN 1581
1560 IF LEFT$(dc$,3)="buc" AND L=10 AND S(4)=0 THEN 1583
1570 IF LEFT$(dc$,3)="rop" AND (S(1)=0 OR S(1)=L) AND L=12 THEN 1584
1580 PRINT "That had no useful effect"
     GOTO 1890
1581 PRINT "You opened the keg to reveal a passage!"
1582 F3=1
     E$(9)=E$(9)+" and east"
	 GOTO 1890
1583 PRINT "The water put the fire out."
     F4=1
	 GOTO 1890
1584 F6=1
     E$(12)=E$(12)+" and up"
1585 PRINT "Your rope catches something outside."
     GOTO 1890
1590 REM
1600 GOSUB 1840
     IF LEN(dc$)<3 THEN 1630
1610 IF LEFT$(dc$,3)="win" AND (S(8)=0 OR S(8)=L) THEN 1631
1620 IF (LEFT$(dc$,3)="buc" OR LEFT$(dc$,3)="WAT") AND (S(4)=0 OR S(4)=L) THEN 1632
1630 PRINT"I see nothing to drink around here."
     GOTO 1890
1631 PRINT "While you were druink, a troll came by and ate you."
     GOTO 1820
1632 PRINT "The water was poison."
     GOTO 1820
1640 REM
1650 IF NOT(L=6 OR L=11) THEN PRINT "There is nobody here to offer anything.":GOTO 1890
1660 IF L=6 THEN PRINT "The ghost doesn't want it.":GOTO 1890
1670 GOSUB 1840
     IF LEFT$(dc$,3)="win" AND S(8)=0 THEN 1681
1680 PRINT"The giant gets mad and throws a rock at you."
     GOTO 1820
1681 PRINT "The giant drinks the wine and falls over on the floor drunk."
     F5=1
1682 GOTO 1890
1690 REM
1700 GOSUB 1840
1710 IF LEN(dc$)<3 THEN 1740
1720 IF LEFT$(dc$,3)="rug" AND L=5 THEN 1741
1730 IF LEFT$(dc$,3)="keg" AND L=9 THEN 1743
1740 PRINT "There is nothing special about that."
     GOTO 1890
1741 PRINT "There was a trapdoor under the rug!!"
     E$(5)="DOWN "+E$(5)
	 F1=1
1742 GOTO 1890
1743 PRINT "You found a keyhole in one of the kegs!"
     FO=1
	 GOTO 1890
1750 REM
1760 dc$=" "+dc$
     N=LEN(dc$)
	 FOR X=N TO 1 STEP-1
1761 IF MID$(dc$,X,1)=" " THEN dc$=RIGHT$(dc$,N-X)
     next
1762 FOR X=1 TO 13
     IF LEFT$(S1$(X),3)=LEFT$(dc$,3)THEN 1780
1770 NEXT
     GOTO 1810
1780 IF LEFT$(dc$,3)="swo" AND S(2)=0 AND L=6 THEN 1831
1785 IF LEFT$(dc$,3)="swo" AND S(2)<>0 THEN 1810
1790 IF L=11 THEN PRINT "The giant grabbed you and squeezed you to death!!!":GOTO 1820
1800 PRINT "There is nothing to attack."
     GOTO 1890
1810 PRINT "You don't have one of those."
     GOTO 1890
1820 PRINT "Oh no....."
     PRINT "You died."
1821 INPUT "Do you want to play again?";A$:print
     a$=ucase$(a$):IF LEFT$(A$,1)="N" THEN END
1830 GOTO 10
1831 F2=1
     PRINT"The ghost is dead!!!"
	 GOTO 1890
1840 dc$=dc$+" "
     N=LEN(dc$)-1
	 FOR X=1 TO N
	 IF LEFT$(dc$,1)=" "THEN X=N
1850 dc$=RIGHT$(dc$,LEN(dc$)-1)
1860 NEXT
     IF LEN(dc$)<2 THEN 1880
1870 dc$=LEFT$(dc$,LEN(dc$)-1)
     IF LEN(dc$)<3 THEN 1880
1880 RETURN
1890 REM
1900 PRINT "Hit Return to continue":INPUT ZZ$:print
1920 RETURN
