10 PRINT "BUNCO": RANDOMIZE TIMER
20 S=0:W=INT(RND(1)*200)+300
30 FOR R=1 TO 6
40 PRINT "ROLLING..."
50 FOR Q=1 TO W: X=RND(1): NEXT Q
60 D1=INT(RND(1)*6)+1:D2=INT(RND(1)*6)+1:D3=INT(RND(1)*6)+1
70 PRINT "ROUND:";R;" Rolls:";D1;D2;D3
80 IF (D1=D2) AND (D2=D3) THEN 150
90 IF D1=R THEN S=S+1
100 IF D2=R THEN S=S+1
110 IF D3=R THEN S=S+1
120 PRINT "SCORE ";S
125 INPUT "PRESS ENTER";A$: print
130 NEXT R
140 PRINT "FINAL SCORE=";S: END
150 IF D1=R THEN PRINT "BUNCO!": S=S+21: GOTO 120
160 PRINT "MINI BUNCO": S=S+5: GOTO 120
