8  REM       MINNESOTA EDUCATIONAL COMPUTING CONSORTIUM STAFF
9  REM  PROGRAMMING REVISIONS BY DON RAWITSCH - 1975
11  REM  CURRENT VERSION - 3/27/75
12 REM CONVERTED TO MMBASIC on the PiPico BY RON LAUZON 03/28/2025
15  REM  **FOR THE MEANING OF THE VARIABLES USED, LIST LINES 4900-4960**
   RANDOMIZE timer
   CLS
25  INPUT "Do you need instructions (Y/N)";C2$:PRINT
40  IF C2$="N" or C2$="n" THEN GOTO 400
45 PRINT
59  REM ***INSTRUCTIONS***
60  PRINT "This program simulates a trip over the"
65  PRINT "Oregon Trail from Independence, MS to"
70  PRINT "Oregon City, OR in 1847. Your family of"
    PRINT "5 will cover the 2000 mile Oregon Trail"
75  PRINT "in 5-6 months - If you make it alive."
85  PRINT "You saves $900 to spend for the trip,"
90  PRINT "and you've just paid $200 for a wagon."
95  PRINT "You will need to spend the rest of your"
100  PRINT "money on the following items:"
110  PRINT "Oxen - You can spend $200-$300 on your"
115  PRINT "   team.  The more you spend, the"
120  PRINT "   faster you'll go because you'll"
     print "   have better animals.."
130  PRINT "Food - The more you have, the less"
135  PRINT "   chance there is of getting sick"
     INPUT "Press Enter to continue...";A:print
145  PRINT "Ammunition - $1 buys a belt of 50"
150  PRINT "   bullets.  You will need bullets for"
155  PRINT "   attacks by animals and bandits, and"
     print "   for hunting food."
165  PRINT "Clothing - This is especially "
170  PRINT "   important for the cold weather
     print "   you will encounter when crossing"
175  PRINT "   the mountains."
185  PRINT "Misc. Supplies - This includes medicine"
190  PRINT "   and other things you will need for"
195  PRINT "   sickness and emergency repairs."
210  PRINT "You can spend all your money before"
215  PRINT "you start your trip - or you can save"
     print "some of your cash to spend at forts"
220  PRINT "along the way when you run low."
225  PRINT "However, items cost more at the forts."
     print "You can also go hunting along the way"
230  PRINT "to get more food.."
     INPUT "Press Enter to continue...";A:print
235  PRINT "Whenever you have to use your trusty"
240  PRINT "rifle along the way, you'll see the"
     print "the words: TYPE BANG.  The faster you"
245  PRINT "type in the word 'BANG' and hit the"
     print "'RETURN' key, the better luck you'll"
250  PRINT "have with your gun."
263  PRINT
265  PRINT "Good luck!!!"
     INPUT "Press Enter to continue...";A:print
399  REM ***INITIAL PURCHASES***
400  X1=-1
405  K8=S4=F1=F2=M=M9=D3=0
410  PRINT
415  PRINT "How much do you want to spend on your"
420  INPUT "oxen team";A:print
425  IF A >= 200 THEN GOTO 440
430  PRINT "Not enough"
435  GOTO 415
440  IF A <= 300 THEN GOTO 455
445  PRINT "Too much"
450  GOTO 415
455  INPUT "How much do you want to spend on food";F:PRINT
470  IF F >= 0 THEN GOTO 485
475  PRINT "Impossible"
480  GOTO 455
485  PRINT "How much do you want to spend on"
490  INPUT "ammunition";B:PRINT
495  IF B >= 0 THEN GOTO 510
500  PRINT "Impossible"
505  GOTO 485
510  PRINT "How much do you want to spend on"
515  INPUT "clothing";C:PRINT
520  IF C >= 0 THEN GOTO 535
525  PRINT "Impossible"
530  GOTO 510
535  PRINT "How much do you want to spend on"
540  INPUT "Misc. Supplies";M1:print
545  IF M1 >= 0 THEN GOTO 560
550  PRINT "Impossible"
555  GOTO 535
560  T=700-A-F-B-C-M1
565  IF T >= 0 THEN GOTO 580
570  PRINT "You overspent - You only had $700 to"
     print "spend.  Try again."
575  GOTO 410
580  B=50*B
585  PRINT "After all your purchases, you now have"
     print T;" dollars left."
590  PRINT
595  PRINT "Monday, March 29 1847"
600  PRINT
605  GOTO 1000
700  IF M >= 2040 OR D3>17 THEN GOTO 4000
709  REM ***SETTING DATE***
710  D3=D3+1
715  PRINT
720  PRINT "Monday ";
725  IF D3>10 THEN GOTO 735
730  ON D3 GOTO 740,750,760,770,780,790,800,810,820,830
735  ON D3-10 GOTO 840,850,860,870,880,890,900
740  PRINT "April 12 ";
744  GOTO 910
750  PRINT "April 26 ";
755  GOTO 910
760  PRINT "May 10 ";
765  GOTO 910
770  PRINT "May 24 ";
775  GOTO 910
780  PRINT "June 7 ";
785  GOTO 910
790  PRINT "June 21 ";
795  GOTO 910
800  PRINT "July 5 ";
805  GOTO 910
810  PRINT "July 19 ";
815  GOTO 910
820  PRINT "August 2 ";
825  GOTO 910
830  PRINT "August 16 ";
835  GOTO 910
840  PRINT "August 31 ";
845  GOTO 910
850  PRINT "Sept. 13 ";
855  GOTO 910
860  PRINT "Sept. 27 ";
865  GOTO 910
870  PRINT "Oct. 11 ";
875  GOTO 910
880  PRINT "Oct. 25 ";
885  GOTO 910
890  PRINT "Nov. 8 ";
895  GOTO 910
900  PRINT "Nov. 22 ";
910  PRINT "1847"
915  PRINT
999  REM ***BEGINNING EACH TURN***
1000  IF F >= 0 THEN GOTO 1015
1010  F=0
1015  IF B >= 0 THEN GOTO 1025
1020  B=0
1025  IF C >= 0 THEN GOTO 1035
1030  C=0
1035  IF M1 >= 0 THEN GOTO 1045
1040  M1=0
1045  IF F >= 12 THEN GOTO 1055
1050  PRINT "You'd better do some hunting of buy"
      print "food and soon!!!!"
1055  F=INT(F)
1060  B=INT(B)
1065  C=INT(C)
1070  M1=INT(M1)
1075  T=INT(T)
1080  M=INT(M)
1085  M2=M
1090  IF S4=1 THEN GOTO 1105
1095  IF K8=1 THEN GOTO 1105
1100  GOTO 1130
1105  T=T-20
1110  IF T<0 THEN GOTO 3520
1115  PRINT "Doctor's bill is $20"
1120  LET K8=S4=0
1130  IF M9=1 THEN GOTO 1145
1135  PRINT "Total mileage is";M
1140  GOTO 1160
1145  PRINT "Total mileage is 950"
1150  M9=0
1160  PRINT "Food";f
      print "Bullets";b
	  print "Clothing";C
	  print "Misc. Supp.";M1
	  print "Cash";t
1300  IF X1=-1 THEN GOTO 1350
1305  X1=X1*-1
1310  PRINT "Do you want to (1) Stop at the next fort"
1315  INPUT "(2) Hunt, OR (3) continue";X: print
1325  IF X>2 THEN GOTO 1340
1330  IF X<1 THEN GOTO 1340
1332  LET X=INT(X)
1335  GOTO 1400
1340  LET X=3
1345  GOTO 1400
1350  INPUT "Do you want to (1) Hunt or (2) continue";X:print
1360  IF X=1 THEN GOTO 1370
1365  LET X=2
1370  LET X=X+1
1375  IF X=3 THEN GOTO 1395
1380  IF B>39 THEN GOTO 1395
1385  PRINT "Tough - You need more bullets to go"
      print "hunting"
1390  GOTO 1350
1395  X1=X1*-1
1400  ON X GOTO 1500,1700,1800
1499  REM ***STOPPING AT FORT***
1500  PRINT "Enter what you wish to spend on the"
      print "following"
1505  PRINT "Food";
1510  GOSUB 1520
1515  GOTO 1555
1520  INPUT P: print
1525  IF P<0 THEN GOTO 1550
1530  T=T-P
1535  IF T >= 0 THEN GOTO 1550
1537  PRINT "You don't have that much.
      print "Keep your spending down"
1540  T=T+P
1545  P=0
1550  RETURN
1555  F=F+2/3*P
1560  PRINT "Ammunition";
1565  GOSUB 1520
1570  LET B=INT(B+2/3*P*50)
1575  PRINT "Clothing";
1580  GOSUB 1520
1585  C=C+2/3*P
1590  PRINT "Misc. Supplies";
1595  GOSUB 1520
1600  M1=M1+2/3*P
1605  M=M-45
1610  GOTO 1800
1699  REM ***HUNTING***
1700  IF B>39 THEN GOTO 1715
1705  PRINT "Tough - You need more bullets to go"
      print "hunting"
1710  GOTO 1310
1715  M=M-45
1720  GOSUB 4500
1725  IF B1 <= 1 THEN GOTO 1755
1730  IF 100*RND(1)<13*B1 THEN GOTO 1780
1735  F=F+48-2*B1
1740  PRINT "Nice shot - Right through the neck."
      print "Feast tonight!!"
1745  B=B-10-3*B1
1750  GOTO 1800
1755  PRINT "Right between the eyes"
      print "You got a big one!!!!"
1765  F=F+52+RND(1)*6
1770  B=B-10-RND(1)*4
1775  GOTO 1800
1780  PRINT "Sorry - No luck today"
1800  IF F >= 13 THEN GOTO 1900
1805  GOTO 3500
1899  REM ***EATING***
1900  PRINT "Do you want to eat (1) Poorly"
      print "(2) Moderately OR (3) Well";
1905  INPUT E: print
1910  IF E>3 THEN GOTO 1900
1915  IF E<1 THEN GOTO 1900
1920  LET E=INT(E)
1930  LET F=F-8-5*E
1935  IF F >= 0 THEN GOTO 2000
1940  F=F+8+5*E
1945  PRINT "You can't eat all that well"
1950  GOTO 1900
2000  LET M=M+200+(A-220)/5+10*RND(1)
2005  L1=C1=0
2099  REM ***RIDERS ATTACK***
2100  IF RND(1)*10>((M/100-4)^2+72)/((M/100-4)^2+12)-1 THEN GOTO 2500
2105  PRINT "Riders ahead. They ";
2110  S5=0
2115  IF RND(1)<.8 THEN GOTO 2130
2120  PRINT "don't ";
2125  S5=1
2130  PRINT "look hostile"
2135  PRINT "Tactics"
2140  PRINT "(1) Run (2) Attack (3) Continue"
      print "(4) Circle Wagons"
2145  PRINT "If you run, you'll gain time, but wear"
      print "down your oxen"
2150  PRINT "If you circle, you'll lose time."
2155  IF RND(1)>.2 THEN GOTO 2165
2160  S5=1-S5
2165  INPUT T1:print
2170  IF T1<1 THEN GOTO 2140
2175  IF T1>4 THEN GOTO 2140
2180  T1=INT(T1)
2185  IF S5=1 THEN GOTO 2330
2190  IF T1>1 THEN GOTO 2220
2195  M=M+20
2200  M1=M1-15
2205  B=B-150
2210  A=A-40
2215  GOTO 2395
2220  IF T1>2 THEN GOTO 2285
2225  GOSUB 4500
2230  B=B-B1*40-80
2235  IF B1>1 THEN GOTO 2250
2240  PRINT "Nice shooting - You drove them off"
2245  GOTO 2395
2250  IF B1 <= 4 THEN GOTO 2275
2255  PRINT "Lousy shot - You got knifed"
2260  K8=1
2265  PRINT "You have to see ol' doc Blanchard"
2270  GOTO 2395
2275  PRINT "Kinda slow with your Colt .45"
2280  GOTO 2395
2285  IF T1>3 THEN GOTO 2310
2290  IF RND(1)>.8 THEN GOTO 2390
2295  LET B=B-150
2300  M1=M1-15
2305  GOTO 2395
2310  GOSUB 4500
2315  B=B-B1*30-80
2320  M=M-25
2325  GOTO 2235
2330  IF T1>1 THEN GOTO 2350
2335  M=M+15
2340  A=A-10
2345  GOTO 2395
2350  IF T1>2 THEN GOTO 2370
2355  M=M-5
2360  B=B-100
2365  GOTO 2395
2370  IF T1>3 THEN GOTO 2380
2375  GOTO 2395
2380  M=M-20
2385  GOTO 2395
2390  PRINT "They did not attack."
2392  GOTO 2500
2395  IF S5=0 THEN GOTO 2410
2400  PRINT "Riders were friendly, but check for"
      print "possible losses"
2405  GOTO 2500
2410  PRINT "Riders were hostile - Check for losses"
2415  IF B >= 0 THEN GOTO 2500
2420  PRINT "You ran out of bullets and got massacred"
      print "by the riders"
2425  GOTO 3600
2499  REM ***SELECTION OF EVENTS***
2500  LET D1=0
2505  RESTORE
2510  R1=100*RND(TIM(0))
2515  LET D1=D1+1
2520  IF D1=16 THEN GOTO 3020
2525  READ D
2530  IF R1>D THEN GOTO 2515
2535  DATA 6,11,13,15,17,22,32,35,37,42,44,54,64,69,95
2537  IF D1>10 THEN GOTO 2545
2540  On D1 GOTO 2550,2570,2590,2615,2630,2645,2660,2690,2785,2810
2545  ON D1-10 GOTO 2825,2860,2885,2970,2990,3020
2550  PRINT "Wagon breaks down"
      print "Lose time and supplies fixing it."
2555  LET M=M-15-5*RND(1)
2560  LET M1=M1-8
2565  GOTO 3100
2570  PRINT "Ox injures leg."
      print "Slows you down rest of the trip."
2575  LET M=M-25
2580  LET A=A-20
2585  GOTO 3100
2590  PRINT "Bad luck. Your daughter broke her arm."
2595  PRINT "You had to stop and use supplies to
      print "make a sling."
2600  M=M-5-4*RND(1)
2605  M1=M1-2-3*RND(1)
2610  GOTO 3100
2615  PRINT "Ox wanders off."
      print "Spend time looking for it"
2620  M=M-17
2625  GOTO 3100
2630  PRINT "Your son gets lost."
      print "Spend half the day looking for him."
2635  M=M-10
2640  GOTO 3100
2645  PRINT "Unsafe water."
      print "Lose time looking for a clean spring."
2650  LET M=M-10*RND(1)-2
2655  GOTO 3100
2660  IF M>950 THEN GOTO 2935
2665  PRINT "Heavy rains - Time and supplies lost."
2670  F=F-10
2672  B=B-500
2675  M1=M1-15
2680  M=M-10*RND(1)-5
2685  GOTO 3100
2690  PRINT "Bandits attack"
2700  GOSUB 4500
2705  B=B-20*B1
2715  IF B >= 0 THEN GOTO 2735
2720  PRINT "You ran out of bullets"
      print "They get lots of cash"
2725  T=T/3
2730  GOTO 2740
2735  IF B1 <= 1 THEN GOTO 2770
2740  PRINT "You got shot in the leg and they took"
      print "one of your oxen."
2745  K8=1
2750  PRINT "Better of a doc look at your wound."
2755  M1=M1-5
2760  A=A-20
2765  GOTO 3100
2770  PRINT "Quickest draw outside of Dodge City!!!"
2775  PRINT "You got 'em!"
2780  GOTO 3100
2785  PRINT "There was a fire in your wagon."
      print "Food and supplies damaged."
2790  F=F-40
2792  B=B-400
2795  LET M1=M1-RND(1)*8-3
2800  M=M-15
2805  GOTO 3100
2810  PRINT "Lose your way in heavy fog."
      print "Time is lost."
2815  M=M-10-5*RND(1)
2820  GOTO 3100
2825  PRINT "You killed a poisonous snake after it"
      print "bit you."
2830  B=B-10
2835  M1=M1-5
2840  IF M1 >= 0 THEN GOTO 2855
2845  PRINT "You die of snakebite sinde you have"
      print "no medicine."
2850  GOTO 3600
2855  GOTO 3100
2860  PRINT "Wagon gets swamped fording river."
      print "Lose food and clothes."
2865  F=F-30
2870  C=C-20
2875  M=M-20-20*RND(1)
2880  GOTO 3100
2885  PRINT "Wile animals attack!"
2887  GOSUB 4500
2889  IF B>39 THEN GOTO 2895
2890  PRINT "You were too low on bullets."
2891  PRINT "The wolves overpowered you."
2892  K8=1
2893  GOTO 3555
2895  IF B1>2 THEN GOTO 2910
2900  PRINT "Nice shootin' pardner."
      print" They didn't get much."
2905  GOTO 2915
2910  PRINT "Slow on the draw."
      print "They got at your food and clothes."
2915  B=B-20*B1
2920  C=C-B1*4
2925  F=F-B1*8
2930  GOTO 3100
2935  PRINT "Cold weather - BRRRRRRR!"
      print "You ";
2940  IF C>22+4*RND(1) THEN GOTO 2955
2945  PRINT "don't ";
2950  C1=1
2955  PRINT "have enough clothing to keep you warm."
2960  IF C1=0 THEN GOTO 3100
2965  GOTO 4700
2970  PRINT "Hail storm - Supplies damaged."
2975  M=M-5-RND(1)*10
2977  B=B-200
2980  M1=M1-4-RND(1)*3
2985  GOTO 3100
2990  IF E=1 THEN GOTO 4700
2995  IF E=3 THEN GOTO 3010
3000  IF RND(1)>.25 THEN GOTO 4700
3005  GOTO 3100
3010  IF RND(1)<.5 THEN GOTO 4700
3015  GOTO 3100
3020  PRINT "Helpful indians show you where to find"
      print "more food."
3025  F=F+14
3030  GOTO 3100
3099  REM ***MOUNTAINS***
3100  IF M <= 950 THEN GOTO 700
3105  IF RND(1)*10>9-((M/100-15)^2+72)/((M/100-15)^2+12) THEN GOTO 3175
3110  PRINT "Rugged mountains"
3115  IF RND(1)>.1 THEN GOTO 3135
3120  PRINT "You got lost - Lose valuable time trying"
      print "to find trail!"
3125  M=M-60
3130  GOTO 3175
3135  IF RND(1)>.11 THEN GOTO 3160
3140  PRINT "Wagon damaged - Lost time and supplies."
3145  M1=M1-5
3147  B=B-200
3150  M=M-20-30*RND(1)
3155  GOTO 3175
3160  PRINT "The going gets slow"
3165  M=M-45-RND(1)/.02
3175  IF F1=1 THEN GOTO 3195
3180  F1=1
3185  IF RND(1)<.8 THEN GOTO 3300
3190  PRINT "You made it safely through South Pass."
      print "No snow."
3195  IF M<1700 THEN GOTO 3215
3200  IF F2=1 THEN GOTO 3215
3205  F2=1
3210  IF RND(1)<.7 THEN GOTO 3300
3215  IF M>950 THEN GOTO 700
3220  M9=1
3225  GOTO 700
3300  PRINT "Blizzard in the mountain pass."
      print "Time and supplies lost."
3305  L1=1
3310  F=F-25
3315  M1=M1-10
3317  B=B-300
3320  M=M-30-40*RND(1)
3325  IF C<18+2*RND(1) THEN GOTO 4700
3330  GOTO 3215
3499  REM ***DYING***
3500  PRINT "You ran out of food and starved to death"
3505  GOTO 3600
3520  LET T=0
3525  PRINT "You can't afford a doctor."
3530  GOTO 3555
3550  PRINT "You ran out of medical supplies."
3555  PRINT "You died of ";
3560  IF K8=1 THEN GOTO 3575
3565  PRINT "pneumonia"
3570  GOTO 3600
3575  PRINT "injuries"
3600  PRINT
3602  PRINT "Due to your unfortunate situation, there"
3605  PRINT "are few formalities we must go through."
3610  PRINT
3615  INPUT "Would you like a minister";C2$:print
3630  INPUT "Would you like a fancy funeral";C2$:print
3650  print "Would you like us to inform your next"
3652  INPUT "of kin";C2$:print
3654  IF C2$="YES" THEN GOTO 3670
3656  PRINT "Your Aunt Nellie in St. Louis is anxious"
3658  PRINT "to hear."
3670  PRINT "We thank you for this information and"
3675  PRINT "sorry you didn't make it to the great"
      print "territory of Oregon."
3680  PRINT "Better luck next time."
3690  PRINT
3695  PRINT "Sincerely"
3705  PRINT "Oregon City Chamber of Commerce"
3710  end
3999  REM ***FINAL TURN***
4000  F9=(2040-M2)/(M-M2)
4005  F=F+(1-F9)*(8+5*E)
4010  PRINT
4015  PRINT "You finally arrived at Oregon City."
4020  PRINT "After 2040 long miles - HOORAY!!!!!"
4025  PRINT
4030  F9=INT(F9*14)
4035  D3=D3*14+F9
4040  F9=F9+1
4045  IF F9<8 THEN GOTO 4055
4050  F9=F9-7
4055  ON F9 GOTO 4060,4070,4080,4090,4100,4110,4120
4060  PRINT "Monday ";
4065  GOTO 4125
4070  PRINT "Tuesday ";
4075  GOTO 4125
4080  PRINT "Wed. ";
4085  GOTO 4125
4090  PRINT "Thurs. ";
4095  GOTO 4125
4100  PRINT "Fri. ";
4105  GOTO 4125
4110  PRINT "Sat. ";
4115  GOTO 4125
4120  PRINT "Sun. ";
4125  IF D3>124 THEN GOTO 4145
4130  D3=D3-93
4135  PRINT "July ";D3;" 1847"
4140  GOTO 4215
4145  IF D3>155 THEN GOTO 4165
4150  D3=D3-124
4155  PRINT "August ";D3;" 1847"
4160  GOTO 4215
4165  IF D3>185 THEN GOTO 4185
4170  D3=D3-155
4175  PRINT "Sept. ";D3;" 1847"
4180  GOTO 4215
4185  IF D3>216 THEN GOTO 4205
4190  D3=D3-185
4195  PRINT "Oct. ";D3;" 1847"
4200  GOTO 4215
4205  D3=D3-216
4210  PRINT "Nov. ";D3;" 1847"
4215  PRINT
4230  IF B>0 THEN GOTO 4240
4235  LET B=0
4240  IF C>0 THEN GOTO 4250
4245  LET C=0
4250  IF M1>0 THEN GOTO 4260
4255  LET M1=0
4260  IF T>0 THEN GOTO 4270
4265  LET T=0
4270  IF F>0 THEN GOTO 4285
4275  LET F=0
4285  PRINT "Food";INT(F)
      print "Bullets";INT(B)
	  print "Clothing";INT(C)
	  print "Misc. Supp.";int(M1)
	  print "Cash";INT(T)
4290  PRINT
4295  PRINT "President James K. Polk sends you his"
4297  PRINT "      Heartiest Congratulations"
4300  PRINT
4305  PRINT "And Wishes you a prosperous life ahead"
4315  PRINT "at your new home.."
4320  end
4499  REM ***SHOOTING SUB-ROUTINE***
4500  PRINT "Type BANG";
4505  B2=TIMER
4510  C2$=""
4515  INPUT C2$:print:c2$=ucase$(c2$)
4519  REM Calculate the number of seconds it took to enter 'BANG' with a Max of 7 seconds
      REM The timer "ticks" 1000 about every second.
4520  PRINT: B1=INT((TIMER-B2)/1000): IF B1>7 THEN B1=7
4525  IF C2$="BANG" THEN GOTO 4535
4530  B1=7
4535  RETURN
4699  REM ***ILLNESS SUB-ROUTINE***
4700  IF 100*RND(1)<10+35*(E-1) THEN GOTO 4740
4705  IF 100*RND(1)<100-(40/4^(E-1)) THEN GOTO 4760
4715  PRINT "Serious illness:"
4720  PRINT "You must stop for medical attention."
4725  M1=M1-10
4730  S4=1
4735  GOTO 4780
4740  PRINT "Mild illness - Medicine used"
4745  M=M-5
4750  M1=M1-2
4755  GOTO 4780
4760  PRINT "Bad illness - Medicine used"
4765  M=M-5
4770  M1=M1-5
4780  IF M1<0 THEN GOTO 3550
4785  IF L1=1 THEN GOTO 3215
4790  GOTO 3100
4900  REM ***IDENDIFICATION OF VARIABLES IN THE PROGRAM***
4902  REM A = AMOUNT SPENT ON ANIMALS
4904  REM B = AMOUNT SPENT ON AMMUNITION
4906  REM B1 = ACTUAL RESPONSE TIME FOR INPUTING 'BANG'
4908  REM B2 = The start timer before asking for 'BANG'
4910  REM C = AMOUNT SPENT ON CLOTHING
4912  REM C1 = FLAG FOR INSUFFICIENT CLOTHING IN COLD WEATHER
4914  REM C2$ = YES/NO RESPONSE TO QUESTIONS
4916  REM D1 = COUNTER IN GENERATING EVENTS
4918  REM D3 = TURN NUMBER FOR SETTING DATE
4920  REM D4 = CURRENT DATE
4922  REM E = CHOICE OF EATING
4924  REM F = AMOUNT SPENT ON FOOD
4926  REM F1 = FLAG FOR CLEARING SOUTH PASS
4928  REM F2 = FLAG FOR CLEARING BLUE MOUNTAINS
4930  REM F9 = FRACTION OF 2 WEEKS TRAVELED ON FINAL TURN
4932  REM K8 = FLAG FOR INJURY
4934  REM L1 = FLAG FOR BLIZZARD
4936  REM M = TOTAL MILEAGE WHOLE TRIP
4938  REM M1 = AMOUNT SPENT ON MISCELLANEOUS SUPPLIES
4940  REM M2 = TOTAL MILEAGE UP THROUGH PREVIOUS TURN
4942  REM M9 = FLAG FOR CLEARING SOUTH PASS IN SETTING MILEAGE
4944  REM P = AMOUNT SPENT ON ITEMS AT FORT
4946  REM R1 = RANDOM NUMBER IN CHOOSING EVENTS
4948  REM S4 = FLAG FOR ILLNESS
4950  REM S5 = 'HOSTILITY OF RIDERS' FACTOR
4952  REM T = CASH LEFT OVER AFTER INITIAL PURCHASES
4954  REM T1 = CHOICE OF TACTICS WHEN ATTACKED
4956  REM X = CHOICE OF ACTION FOR EACH TURN
4958  REM X1 = FLAG FOR FORT OPTION
5000  END
