10 REM		<< GALAXY >>
20 DS=200
30 DIM G$(25)
40 FOR X=1 TO 25 : READ G$(X) : NEXT
50 A$="*":B$="+":C$=".":D$="*"
60 FOR I=1 TO 40
70 GOSUB 140
80 COLOR rgb(int(rnd*255)+1,int(rnd*255)+1,int(rnd*255)+1)
   PRINT TAB(A1);A$;
   COLOR rgb(int(rnd*255)+1,int(rnd*255)+1,int(rnd*255)+1)
81 PRINT TAB(B1);B$;
   COLOR rgb(int(rnd*255)+1,int(rnd*255)+1,int(rnd*255)+1)
82 PRINT TAB(C1);C$
85 GOSUB 1010 : REM delay
90 NEXT
100 Z1=INT(RND*25)+1
110 Z$=G$(Z1)
120 COLOR RGB(WHITE): PRINT Z$
125 GOSUB 1010: REM delay
130 GOTO 60
140 A1=INT(RND*13)+1 : B1=INT(RND*13)+13 : C1=INT(RND*13)+26
150 X=RND
160 IF X<.15 THEN S$=A$: A$=B$: B$=S$ : GOTO 230
170 IF X<.3  THEN S$=B$: B$=C$: C$=S$ : GOTO 230
180 IF X<.45 THEN S$=C$: C$=A$: A$=S$ : GOTO 230
190 IF X<.6  THEN S$=A$: A$=D$: D$=S$ : GOTO 230
200 IF X<.75 THEN S$=B$: B$=D$: D$=S$ : GOTO 230
220 IF X<.9  THEN S$=C$: C$=D$: D$=S$
230 RETURN
322 DATA "You are a traveller lost in space"
323 data "I am but a traveller lost in space"
324 data "All mankind but explorers lost in space"
325 data "Can we find each other in space?"
326 data "How does life seem from up there?"
327 data "i can see you clearly now from here"
328 data "The years seen to pass so quickly"
329 data "We'll meet here in a million years"
330 data "Greetings from where the rats crawl"
331 data "Greetings from the cracks in the wall"
332 data "I see all that you ever are doing"
333 data "The sky is falling on us all!!!"
334 data "I'm afraid that the end is coming"
335 data "In which remote place can God be met?"
336 data "We'll meet again don't know where or when"
337 data "Time runs quite short for you and me"
338 data "You grow old at the speed of light"
339 data "Have you made peace with your maker?"
340 data "Have you existed as a giver or a taker?"
341 data "Will you be able to meet me out here?"
342 data "Remember all the great times we had?"
343 data "We shall never leave this place till we die"
344 data "Eternal energy beyond the dreams of man"
345 data "Some people will always be free forever"
346 data "Some people will never taste freedom"
1000 REM delay by milliseconds
1010 pause DS
1030 RETURN
