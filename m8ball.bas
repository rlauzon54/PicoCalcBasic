5 RANDOMIZE TIMER
10 INPUT "What is your question";A$: print
20 R=INT(RND (1)*20)+1
30 ON R GOSUB 41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60
   print:print
40 GOTO 10
41 PRINT "It is certain": RETURN 
42 PRINT "It is decidely so": RETURN 
43 PRINT "Without a doubt": RETURN 
44 PRINT "Yes, definitely": RETURN 
45 PRINT "You may rely on it": RETURN 
46 PRINT "As I see it, Yes": RETURN 
47 PRINT "Most likely": RETURN 
48 PRINT "Outlook good": RETURN 
49 PRINT "Yes": RETURN 
50 PRINT "Signs point to Yes": RETURN 
51 PRINT "Reply hazy. Try again": RETURN 
52 PRINT "Ask again later": RETURN 
53 PRINT "Better not tell you now": RETURN 
54 PRINT "Cannot predict now": RETURN 
55 PRINT "Concentrate and ask again": RETURN 
56 PRINT "Do not count on it": RETURN 
57 PRINT "My reply is No": RETURN 
58 PRINT "My sources say No": RETURN 
59 PRINT "Ooutlook not so good": RETURN 
60 PRINT "Very doubtful": RETURN 
