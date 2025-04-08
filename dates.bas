'Executive calendar Dates program modified to run on both the 100 and 200 KDM
' Ported to run on the PicoCalc

function ToPixelY(line) as integer
    ToPixelY = line * MM.FONTHEIGHT
end function
function ToPixelX(col) as integer
    ToPixelX = col * MM.FONTWIDTH
end function
function ScreenLocToX(screenLoc)
   ScreenLocToX = screenLoc - int(screenLoc/40)*40
end function
function ScreenLocToY(screenLoc)
   ScreenLocToY = int(screenLoc/40)
end function

' Load up the arrays
20 DIM MN$(12),dy$(6),HL$(20,5),EA(19)
   FOR X=1 TO 12
       READ MN$(X)
   NEXT X
   FOR X=0 TO 6
      READ dy$(X)
   NEXT X
   FOR X=1 TO 18
   FOR Y=1 TO 5
   READ HL$(X,Y)
   NEXT Y
   next X
   FOR X=1 TO 19
   READ EA(X)
   NEXT X
99 GOTO 1000

' Print main menu
100 CLS
    color rgb(black),rgb(green)
    PRINT "                 DATES                  ";
    color rgb(green),rgb(black)
    print
110 PRINT @(ToPixelX(13),ToPixelY(2)) "F1. Conversions";
    PRINT @(ToPixelX(13),ToPixelY(3)) "F2. Holidays";
    PRINT @(ToPixelX(13),ToPixelY(4)) "F3. Weekdays";
    PRINT @(ToPixelX(13),ToPixelY(5)) "F8. Menu";
    PRINT @(0,ToPixelY(7))"          Press Function Keys          ";
    return
    
' Blank out screen section lines 2-6
200 FOR Z9=1 TO 5
    PRINT @(0,ToPixelY(z9+1)) "                                       ";
    NEXT Z9
    RETURN

' Blank out screen section lines 5-6
210 FOR Z9=5 TO 6
    PRINT @(0,z9) "                                      ";
    NEXT Z9
    RETURN

' Center line somewhere
250 K=K+INT((40-LEN(k1$))/2)
    PRINT @(ToPixelX(ScreenLocToX(k)),ToPixelY(ScreenLocToY(k))) k1$;
    RETURN
    
260 PRINT @(0,ToPixelY(7)) "         Press ENTER to return         ";
270 k1$=INKEy$:IF k1$="" THEN goto 270
280 IF k1$=CHR$(10) THEN RETURN
    goto 270

350 CLS
    PRINT " Date Time  Dur.      Description      ";
360 PRINT @(0,ToPixelY(7)) "Add  Edit Rem  Prnt            Calendar";
    RETURN

500 DATA January,February,March,April,May,June,July,August,September,October,November,December
510 DATA Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday
520 DATA "President","1","2.212","Presidents' Day","1"
    data "Mother's" ,"1","5.14","Mother's Day","0"
    data "Memorial" ,"1","5.312","Memorial Day","1"
    data "Father's" ,"1","6.213","Father's Day","0"
525 DATA "Labor"    ,"1","9.073","Labor Day","1"
    data "Columbus" ,"1","10.145","Columbus Day","1"
    data "Election","1","11.081","Election Day","2"
    data "Thanksgv","1","11.285","Thanksgiving Day","4"
530 DATA "Ash Wed","0","-46","Ash Wednesday","3"
    data "1st Sun","0","-42","First Sunday in Lent","0"
    data "Passion","0","-14","Passion Sunday","0"
    data "Palm Sun","0","-7","Palm Sunday","0"
    data "Good Fri","0","-2","Good Friday","5"
535 DATA "Easter","0","0","Easter Sunday","0"
    data "Ascensn","0","39","Ascension Day","4"
    data "Pentecst","0","49","Pentecost","0"
    data "Trinity","0","56","Trinity Sunday","0"
    data "List All","0","0","0","0"
540 DATA 5.14,5.03,4.23,5.11,4.31,5.18,5.08,4.28,5.16,5.05,4.25,5.13,5.02,4.22,5.10,4.30,5.17,5.07,4.27

1000 gosub 100
1010 k1$=INKEy$:IF k1$="" THEN goto 1010

select case asc(k1$)
    case 145
        gosub 15000
    case 146
        gosub 12000
    case 147
        gosub 13000
    case 152
        end
end select

1040 IF K8=1 THEN K8=0:GOTO 1000
1050 GOTO 1010

1200 CLS
     color rgb(black),rgb(green)
     PRINT "                Holidays                ";
     color rgb(green),rgb(black)
     print
     gosub 1210
     gosub 1220
     RETURN
1210 S1=0
     FOR S2=1 TO 18 STEP 4
        S1=S1+1
        S3=0
        FOR S4=S2 TO S2+3
            p4=(S1*40)+1+(S3*10)
            PRINT @(ToPixelX(ScreenLocToX(p4)),ToPixelY(ScreenLocToY(p4))) HL$(S4,1);
            S3=S3+1
        NEXT S4
     next S2
    RETURN

1220 PRINT @(0,ToPixelY(7)) "F1=This Year  F2=Any Year  F3=Find";
     print @(0,ToPixelY(8)) "F8=Date Menu";
     RETURN

1300 CLS
     color rgb(black),rgb(green)
     PRINT "                Weekdays                ";
     color rgb(green),rgb(black)
     PRINT
     PRINT @(ToPixelX(2), ToPixelY(2)) "1. Days between   5. Year given Day";
     PRINT @(ToPixelX(2), ToPixelY(3)) "2. Wkdays between 6. Date given Day"
1310 PRINT @(ToPixelX(2), ToPixelY(4)) "3. # of times     8. Date Menu";
     PRINT @(ToPixelX(2), ToPixelY(5)) "4. Nth Occurrence";
     PRINT @(0,ToPixelY(7)) "          Press function keys          ";
     RETURN

1500 CLS
     color rgb(black),rgb(green)
     PRINT "              Conversions               ";
     color rgb(green),rgb(black)
     print
     PRINT @(0,ToPixelY(7)) "F1=Gregorian  F2=Julian  F3=Day of Yr"
     PRINT @(0,ToPixelY(8)) "F8=Date Menu";
     RETURN

12000 N1=0
      gosub 1200
      P1=1
      P2=1
      N=1
      P3=(P1*40)+1+((P2-1)*10)
12005 PRINT @(ToPixelX(ScreenLocToX(p3)),ToPixelY(ScreenLocToY(p3)));
      color rgb(black),rgb(green)
      print HL$(N,1);
      color rgb(green),rgb(black)
      IF K8=1 THEN RETURN
      
12010 k1$=INKEy$:IF k1$="" THEN goto 12010
12020 K=ASC(k1$):IF K=152 THEN K8=1:RETURN

select case k
    case 145
        goto 12300
    case 146
        goto 12400
    case 147
        goto 12500
end select

' Arrow keys
12028 IF K=130 OR K=131 OR K=128 OR K=129 THEN goto 12030
      goto 12010

12030 PRINT @(ToPixelX(ScreenLocToX(p3)),ToPixelY(ScreenLocToY(p3))) HL$(N,1);
      IF K=130 THEN P2=P2-1:N=N-1
12040 IF K=131 THEN P2=P2+1:N=N+1
12050 IF K=128 THEN P1=P1-1:N=N-4
12060 IF K=129 THEN P1=P1+1:N=N+4

12130 IF P1<1 THEN P1=1:N=N+4
12140 IF P2<1 THEN P2=1:N=N+1
12150 IF (P1>4 AND P2>2) OR P1>5 THEN P1=P1-1:N=N-4
12160 IF P2>4 THEN P2=4:N=N-1
12170 P3=(P1*40)+1+((P2-1)*10)
      PRINT @(ToPixelX(ScreenLocToX(p3)),ToPixelY(ScreenLocToY(p3)));
      color rgb(black),rgb(green)
      print HL$(N,1);
      color rgb(green),rgb(black)
      print
      GOTO 12010
      
12300 N2=0
      Y=VAL(RIGHT$(DATE$,2))
      IF Y>80 THEN Y=Y+1900 ELSE Y=Y+2000
12310 IF N=18 THEN N1=18:N=1
12312 F=0
      A=VAL(HL$(N,2))
      E=VAL(HL$(N,3))
      IF E<3 THEN F=-1
12315 ON A+1 gosub 12600,12700
      IF N2=1 THEN
          GOTO 12520
      ELSE 
          gosub 12800
          gosub 12900
      endif
12320 IF N1=18 THEN
          N=N+1
          IF N<18 AND k1$=CHR$(10) THEN
              goto 12312
          endif
      endif
12330 IF N1=18 THEN N=18
12380 gosub 200
      gosub 1220
      gosub 1210
      GOTO 12005
12400 N2=0
      PRINT @(0,ToPixelY(7))"                                       ";
      PRINT @(ToPixelX(10),ToPixelY(7)) "Which ";
      Q1=296
      gosub 24000
      IF N=18 THEN N1=18:N=1
12410 GOTO 12310
12500 N2=1
      gosub 200
      K=80
      k1$="Find "+HL$(N,4)+" ("+HL$(N,1)+")"
      gosub 250
      Q1=177
      PRINT @(ToPixelX(11),ToPixelY(4)) "Date : "
      gosub 20000
      M1=M
      D1=D
      Y1=Y
      GOTO 12312
12520 y2$=STR$(Y)
      PRINT @(ToPixelX(24),ToPixelY(4)) y2$;
      IF (Y-Y1)>200 THEN goto 12590
12530 IF D<>D1 OR C<>M1 THEN Y=Y+1:GOTO 12312
12580 gosub 12800
      gosub 12900
      GOTO 12380

12590 gosub 200
      K=80
      k1$=HL$(N,4)+" does not fall on"
      gosub 250
      gosub 27240
      D=D1
      M=M1
      Y=Y1
      gosub 27000
      K=160
      k1$=LEFT$(s11$,5)
      gosub 250
      gosub 12900
      GOTO 12380
12600 A=EA(Y-19*INT(Y/19)+1)
      C=INT(A):D=INT(100*(A-C))
12610 A=INT(365.25*Y)+INT(30.6001*C)+D+1720983
      F=A-7*INT(A/7)
12620 A=A+6-F
      A=A+E
      F=A+68569
      E=INT(4*F/146097)
      F=-INT((146097*E+3)/4)+F
12630 Y=INT(4000*(F+1)/1461001)
      F=-INT(1461*Y/4)+31+F
      C=INT(80*F/2447)
12640 D=-INT(2447*C/80)+F
      F=INT(C/11)
      C=-12*F+2+C
      Y=100*(E-49)+Y+F
      RETURN
      
12700 C=INT(E)
      E=100*(E-C)
      D=INT(E)
      E=INT(10*(E-D))
      F=F+Y
12710 E=E+INT(1.25*F)-INT(.75*(1+INT(F/100)))
      D=D-E+7*INT(E/7)
      RETURN

12800 gosub 200
      gosub 27240
      K=80
      k1$=HL$(N,4)+" ("+HL$(N,1)+")"
      gosub 250
      K=120
      Z=D
      gosub 27100
      k1$=dy$(VAL(HL$(N,5)))+", "+MN$(C)+" "+r1$+","+STR$(Y)
      gosub 250
      RETURN

12900 K=200
      k1$="Press ENTER to return."
      gosub 250
12910 k1$=INKEy$:IF k1$="" THEN goto 12910
12920 IF k1$=CHR$(10) OR k1$=CHR$(27) THEN RETURN
12925 IF k1$=CHR$(151) OR k1$=CHR$(152) THEN K8=1:RETURN
12930 GOTO 12910

13000 gosub 1300
13010 k1$=INKEy$:IF k1$=""THEN goto 13010
13020 K=ASC(k1$)

select case k
    case 145
        gosub 13100
    case 146
        gosub 13200
    case 147
        gosub 13300
    case 148
        gosub 13400
    case 149
        gosub 13500
    case 150
        gosub 13600
    case 151, 152
        K8=1
        RETURN
end select

13040 GOTO 13010
13100 gosub 200
      gosub 210
      K=40
      k1$="# of Days between two dates"
      gosub 250
      Q1=139
      PRINT @(ToPixelX(7),ToPixelY(3)) "Start Date : ";
13110 gosub 20000
      M1=M
      D1=D
      Y1=Y
      gosub 25000
      W=I
      PRINT @(ToPixelX(7),ToPixelY(4)) "End Date  : ";
      Q1=179
      gosub 20000
      M1=M
      D1=D
      Y1=Y
      gosub 25000
      W=I-W
      K=200
      k1$=STR$(W)+" days"
      gosub 250
      gosub 27240
      gosub 260
13120 gosub 1300
      RETURN
      
13200 gosub 200
      gosub 210
      K=40
      k1$="# of Weekdays between two dates"
      gosub 250
      B=2
      C$="Weekdays"
      gosub 13250
      gosub 1300
      RETURN
      
13250 Q1=141
      PRINT @(ToPixelX(9),ToPixelY(3)) "Start Date : ";
      gosub 20000
      M1=M
      I=D-2
      Y1=Y
      gosub 13270
      ON B gosub 13290,13295

13260 A=N
      Q1=181
      PRINT @(ToPixelX(9),ToPixelY(4)) "End Date   : ";
      gosub 20000
      M1=M
      I=D
      Y1=Y
      gosub 13270
      ON B gosub 13290,13295
      N=N-A
      K=200
13262 IF B<>1 THEN k1$=STR$(N-1)+" "+C$ ELSE k1$=STR$(N)+" "+C$
13264 gosub 250
      gosub 260
      RETURN
      
13270 IF M1<3 THEN M1=M1+12:Y1=Y1-1
13275 M1=M1+1
      I=I-INT(.75*(INT(.01*Y1)-7))+INT(365.25*Y)+INT(30.6*M1)
      RETURN
      
13290 I=I-W
      N=INT(I/7)+INT(.055*(I-7*INT(I/7))+1.4)
      RETURN
      
13295 N=5*INT(I/7)+INT(.9005*(I-7*INT(I/7))+.5)
      RETURN
      
13300 gosub 200
      gosub 210
      K=40
      k1$="# of times Given day occurs"
      gosub 250
      B=1
      C$="times"
      Q1=89
      gosub 24500
      gosub 13250
      gosub 1300
      RETURN

13400 gosub 200
      gosub 210
      K=40
      k1$="Nth Occurence of Day in month"
      gosub 250
      Q1=91
      gosub 24500
      Q1=133
      gosub 22000
      
13410 K=160
      k1$="Which "+dy$(W)+" in "+MN$(M)+","+STR$(Y)+" : "
      gosub 250
      LINE INPUT N3$
      N=VAL(N3$)
      IF N<1 OR N>5 THEN goto 13410
13420 A=M
      B=Y
      IF A<3 THEN A=A+12:B=B-1
13430 A=A+1
      H=W-INT(2.6*A)-INT(1.25*B)+INT(.75*INT(.01*B-7))
13440 H=H-7*INT(H/7)
      H=H+(H=0)*-7:D=H+7*N-7
13445 IF D<29 THEN goto 13490
13450 IF (M=4 OR M=9 OR M=6 OR M=11) AND D<31 THEN goto 13490
13455 IF (M=1 OR M=3 OR M=5 OR M=7 OR M=8 OR M=10 OR M=12) AND D<32 THEN goto 13490
13460 IF M<>2 THEN goto 13480
      IF D>29 THEN goto 13480
13465 y2$=STR$(Y)
      M1=VAL(RIGHT$(y2$,2))
      IF M1=0 THEN M3=Y/400-INT(Y/400):IF M3=0 THEN goto 13480
13470 M3=M1/4-INT(M1/4)
      IF M3=0 THEN goto 13490
13480 K=200
      gosub 27240
      gosub 27240
      k1$="There aren't"+STR$(N)+" "+dy$(W)+"s in "+MN$(M)
      gosub 250
      GOTO 13495

13490 Z=D
      gosub 27100
      K=200
      k1$="It's on the "+r1$
      gosub 250
13495 gosub 260
      gosub 1300
      RETURN
      
13500 gosub 200
      gosub 210
      K=40
      k1$="Given Date occurs on given day"
      gosub 250
      Q1=91
      gosub 24500
      Q1=139
      PRINT @(ToPixelX(7),ToPixelY(3)) "Start date :";
      gosub 20000
      A=M
      F=0
      F1=1
      gosub 13510
      gosub 260
      gosub 1300
      RETURN
13510 IF 3>M THEN F=1:M=M+12
13520 Z=INT((M+11)*2.6)+D
      Z=(Z-W-INT((Z-W)/7)*7)/2:X=INT(Z)
      IF X<>Z THEN X=X+4
13530 X=INT((Y-1-(4*X))/28)*28+(4*X)+F
      F=1
      gosub 200
      Z=D
      gosub 27100
      K=40
      k1$=dy$(W)+" will be on "+MN$(A)+" "+r1$+" in"
      gosub 250
13540 gosub 13570
      X=X+6
      IF F=>13 THEN RETURN
13542 gosub 13570
      X=X+11
      IF F=>13 THEN RETURN
13544 gosub 13570
      X=X+6
      IF F>=13 THEN RETURN
13546 gosub 13570
      X=X+5
      IF F<12 THEN goto 13540
13550 RETURN

13570 IF X>=Y THEN IF(A*D<>58)OR(X/4=INT(X/4))THEN gosub 13580:F=F+1
13572 RETURN

13580 IF F<4 THEN F1=(F*40)+86
13582 IF F>3 AND F<7 THEN F1=((F-3)*40)+93
13584 IF F>6 AND F<10 THEN F1=((F-6)*40)+100
13586 IF F>9 THEN F1=((F-9)*40)+107
13590 gosub 27240
      PRINT @(ToPixelX(ScreenLocToX(f1)),ToPixelY(ScreenLocToY(f1))) STR$(X);
      RETURN

13600 gosub 200
      K=40
      k1$="Dates of given day of the week"
      gosub 250
      Q1=89
      gosub 24500
      Q1=138
      PRINT @(ToPixelX(8),ToPixelY(3)) "Start Date : ";
      gosub 20000
      gosub 200
      K=80
      k1$=dy$(W)+" falls on "
      gosub 250
      gosub 13602
      gosub 260
      gosub 1300
      RETURN

13602 IF M<3 THEN M=M+12:Y=Y-1
13604 M=M+1
      J=INT(365.25*Y)+INT(30.6001*M)+D+1720982
13610 Z=J+1-7*INT((J+1)/7)
      IF Z>W THEN W=W+7
13620 J=J+W-Z
      A=0
13630 R=J+68569
      P=INT(4*R/146097)
      R=-INT(((146097*P)+3)/4)+R
      Y=INT(4000*(R+1)/1461001)
13640 R=-INT((1461*Y)/4)+31+R
      M=INT(80*R/2447)
      S=-INT(2447*M/80)+R
      R=INT(M/11)
      M=(-12*R)+2+M
13650 Y=100*(P-49)+Y+R
13660 A=A+1
      D=S
      gosub 27000
13662 IF A<4 THEN A1=(A*40)+82
13664 IF A>3 AND A<7 THEN A1=((A-3)*40)+95
13666 IF A>6 THEN A1=((A-6)*40)+107
13668 PRINT @(ToPixelX(ScreenLocToX(a1)),ToPixelY(ScreenLocToY(a1))) s11$;
      gosub 27240
      J=J+7
      IF A<9 THEN goto 13630
      RETURN
      
15000 gosub 1500
15010 k1$=INKEy$:IF k1$="" THEN goto 15010
15020 K=ASC(k1$)
      IF K=152 THEN GOTO 15070
15030 IF K=145 THEN GOTO 15100
15040 IF K=146 THEN GOTO 15200
15050 IF K=147 THEN GOTO 15300
15060 GOTO 15010

15070 K8=1
     RETURN
     
15100 gosub 200
     Q1=137
     PRINT @(ToPixelX(11),ToPixelY(3)) "Date :";
     gosub 20000
     M1=M
     D1=D
     Y1=Y
     gosub 25000
     J=I
     GOTO 15400
15200 gosub 200
      PRINT@(ToPixelX(11),ToPixelY(3)) "Date :";
      LINE INPUT j2$
      J=VAL(j2$)
      gosub 26000
      GOTO 15400
15300 gosub 200
      Q1=131
      gosub 21000
      J=INT(365.25*Y)+D+1721045
      gosub 26000
15400 M1=12
      D1=31
      Y1=Y-1
      gosub 25000
      Z=J-I
      M1=12
      D1=31
      Y1=Y
      gosub 25000
      W=I-J
      D2=J+1-7*INT((J+1)/7)
15500 gosub 200
      gosub 27000
      K=80
      k1$=dy$(D2)+", "+s11$
      gosub 250
      gosub 27200
      K=120
      k1$=j2$+" Julian Days"
      gosub 250
      gosub 27100
      K=159
      k1$=r1$+" day of the year"
      gosub 250
      K=200
      k1$=STR$(W)+" remain in the year"
      gosub 250
      GOTO 15010
      
20000 PRINT @(ToPixelX(ScreenLocToX(Q1)),ToPixelY(ScreenLocToY(Q1))) " MM/DD/YYYY";
      gosub 27240
      PRINT @(ToPixelX(ScreenLocToX(Q1)),ToPixelY(ScreenLocToY(Q1))) " ";
      LINE INPUT y2$
20010 IF LEN(y2$)<>10 THEN goto 20000
20020 IF MID$(y2$,3,1)<>"/" OR MID$(y2$,6,1)<>"/" THEN goto 20000
20030 M=VAL(LEFT$(y2$,2))
      D=VAL(MID$(y2$,4,2))
      Y=VAL(RIGHT$(y2$,4))
20040 IF M<1 OR M>12 OR D<1 THEN goto 20000
20050 IF M=2 AND D>29 THEN goto 20000
20060 IF (M=4 OR M=6 OR M=9 OR M=11) AND D>30 THEN goto 20000
20070 IF D>31 THEN goto 20000
20080 IF M=2 AND D=29 THEN goto 20100
      RETURN

20100 M1=VAL(RIGHT$(y2$,2))
      IF M1=0 THEN M3=Y/400-INT(Y/400):IF M3<>0 THEN goto 20000
20110 M3=M1/4-INT(M1/4)
      IF M3=0 THEN RETURN
      goto 20000

21000 PRINT @(ToPixelX(ScreenLocToX(Q1)),ToPixelY(ScreenLocToY(Q1))) "Date : DDD/YYYY";
      gosub 27240
      Q1=Q1+6
21005 PRINT @(ToPixelX(ScreenLocToX(Q1)),ToPixelY(ScreenLocToY(Q1))) " ";
      LINE INPUT y2$
21010 IF LEN(y2$)<>8 THEN goto 21005
21020 IF MID$(y2$,4,1)<>"/" THEN goto 21005
21030 D=VAL(LEFT$(y2$,3))
      Y=VAL(RIGHT$(y2$,4))
21040 IF D<1 OR Y<1 OR D>366 THEN goto 21005
21050 IF D<>366 THEN RETURN
21060 M1=VAL(RIGHT$(y2$,2))
      IF M1=0 THEN M3=Y/400-INT(Y/400):IF M3=0 THEN goto 21005
21070 M3=M1/4-INT(M1/4)
      IF M3=0 THEN RETURN
      goto 21005

22000 gosub 27240
      PRINT @(ToPixelX(ScreenLocToX(Q1)),ToPixelY(ScreenLocToY(Q1))) "Date : MM/YYYY";
      PRINT @(ToPixelX(ScreenLocToX(Q1+6)),ToPixelY(ScreenLocToY(Q1+6))) " ";
      LINE INPUT y2$
      IF LEN(y2$)<>7 THEN goto 22000
22200 M=VAL(LEFT$(y2$,2))
      Y=VAL(RIGHT$(y2$,4))
      IF M<1 OR M>12 OR Y<1 THEN goto 22000
      RETURN

24000 PRINT @(ToPixelX(ScreenLocToX(Q1)),ToPixelY(ScreenLocToY(Q1))) "Year : YYYY";
      gosub 27240
      PRINT @(ToPixelX(22),ToPixelY(7)) " ";
      y2$=" "
      Y4$=""
      Y1=1
24010 Y4$=INKEy$:IF Y4$="" THEN goto 24010
24020 IF Y4$=CHR$(8) AND Y1<>1 THEN y2$=LEFT$(y2$,LEN(y2$)-1):Y1=Y1-1:GOTO 24060
24050 IF INSTR("0123456789"+CHR$(10),Y4$)=0 THEN goto 24010
24056 IF Y4$=CHR$(10) THEN PRINT @(ToPixelX(22),ToPixelY(7)) y2$;"    ";:GOTO 24070
24058 y2$=y2$+Y4$
      Y1=Y1+1
24060 PRINT @(TopixelX(22),ToPixelY(7)) y2$;
      IF Y1<5 THEN goto 24010
24070 Y=VAL(y2$)
      RETURN
      
24500 gosub 27240
      PRINT @(ToPixelX(ScreenLocToX(Q1)),ToPixelY(ScreenLocToY(Q1))) "Which Day (1-7) :";
      LINE INPUT W1$
      W=VAL(W1$)
      W=W-1
      IF W<0 OR W>6 THEN goto 24500
      RETURN

25000 REM gregorian to julian M,D,Y to I
25010 IF M1<3 THEN M1=M1+12:Y1=Y1-1
25020 M1=M1+1
      I=INT(365.25*Y1)+INT(30.6001*M1)+D1+1720982
      RETURN

26000 REM julian to gregorian conversion
26010 U=J+68569
      V=INT(4*U/146097)
      U=-INT((146097*V+3)/4)+U
      Y=INT(4000*(U+1)/1461001)
      U=-INT(1461*Y/4)+31+U
      M=INT(80*U/2447)
      D=-INT(2447*M/80)+U
      U=INT(M/11)
      M=-12*U+2+M
      Y=100*(V-49)+Y+U
      RETURN
27000 m2$=STR$(M)
      IF M<10 THEN m2$="0"+m2$
27010 d3$=STR$(D)
      IF D<10 THEN d3$="0"+d3$
27020 y2$=STR$(Y)
      IF Y<0 THEN y2$=y2$+"BC"
27030 s11$=m2$+"/"+d3$+"/"+Y2$
      RETURN
      
27100 z2$=STR$(Z)
      G$=RIGHT$(z2$,1)
      r1$=z2$
      RETURN

27200 j2$=format$(j,"%10.0f")
27210 IF LEN(j2$)>6 THEN J1=LEN(j2$)-6:j2$=LEFT$(j2$,J1)+","+MID$(j2$,J1+1,3)+","+RIGHT$(j2$,3):RETURN
27220 IF LEN(j2$)>3 THEN J1=LEN(j2$)-3:j2$=LEFT$(j2$,J1)+","+RIGHT$(j2$,3):RETURN
27230 RETURN

27240 play tone 1000,1000,200: return