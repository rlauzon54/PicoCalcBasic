1 PRINT "Guess"
2 PRINT "Creative Computing, Morristown, NJ"
3 PRINT
4 PRINT "This is a number guessing game.  I'll"
5 PRINT "think of a number between 1 and 100."
6 PRINT "Then you'll have to guess what it is."
  print
9 L=100: randomize timer
11 L1=INT(LOG(L)/LOG(2))+1
12 PRINT "I'm thinking of a number - 1 and";L
13 G=1: M=INT(L*RND(1)+1)
14 INPUT "Now you try to guess what it is"; N:print
21 IF N>0 THEN 25
22 PRINT "Nope.  Try again."
23 GOTO 14
25 IF N=M THEN 50
30 G=G+1
31 IF N>M THEN 40
32 PRINT "Too low.  Try a bigger answer."
33 GOTO 14
40 PRINT "Too high.  Try a smaller answer."
42 GOTO 14
50 PRINT "That's it! You got it in";G;" tries."
52 IF G<L1 THEN 58
54 IF G=L1 THEN 60
56 PRINT "You should have been able to get"
   print "it in only";L1;" tries."
57 GOTO 66
58 PRINT "Very ";
60 PRINT "Good."
66 GOTO 12
99 END
