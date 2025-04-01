100 CLS
110 ROW=10: COL = 1: GOSUB 6110 : X$ = "Appalachian Trail" : GOSUB 5590
120 ROW=13: COL = 1: GOSUB 6110 : X$ = "(c) by David H. Ahl, 1986" : GOSUB 5590
130 ROW=23: COL = 1: GOSUB 6110 : X$ = "Press any key to continue." : GOSUB 5590
    GOSUB 5410
150 RANDOMIZE TIMER : GOSUB 5620
160 DIM HZ(25), DLC(25), LC$(25), SP$(7), ITM$(4), WHT(4), CST(4), VL(4)
    DIM ITEM$(7), WT(7), COST(7), TSLOW(10), VOL(7), FD(5),R(10)
170 DB = 300 : 'New boot gives 300 extra mi
180 '
190 'Data Input Section
200 CLS
    PRINT "First we need some data about you."
210 INPUT "Your sex (male or female)";A1$ : PRINT
    A1$=ucase$(A1$)
	GOSUB 5540
220 IF A1$<>"M" AND A1$<>"F" THEN PRINT "Answer 'M' or 'F' please." : GOTO 210
230 INPUT "Your weight in pounds";WB:print
240 IF WB > 79 AND WB < 401 THEN 260
250 PRINT "Surely you jest. Let's try that one"
    PRINT "again." : GOTO 230
260 PRINT "What is your physical condition"
    PRINT "(1 = excellent, 2 = good, 3 = fair,"
270 INPUT "4 = poor)";PC:print
280 IF PC < 1 OR PC > 4 THEN PRINT "Answer 1, 2, 3, or 4 please." : GOTO 260
290 PRINT
    PRINT "Walking pace: You may change your pace"
300 PRINT "as the hike progresses. Remember, a"
    PRINT "faster pace covers the distance more"
310 PRINT "quickly but burns more calories and"
    PRINT "has a higher risk of injury."
320 PRINT "Slow and deliberate......1.7 mph"
330 PRINT "Moderate and vigorous......3 mph"
340 PRINT "Fast and very difficult....4 mph"
350 PRINT "At what rate in mph do you wish to walk"
    INPUT "(number & decimal okay)";RW:print
360 IF RW < 1 OR RW > 4.2 THEN PRINT "A rate of" RW "mph is silly." : GOTO 350
370 PRINT
    PRINT "Walking hours per day: You may change"
	PRINT "this as time goes on. To start, how many"
380 INPUT "hours do you wish to walk per day";TW:print
390 IF TW > 14 THEN PRINT "That's just too ambitious." : GOTO 380
400 IF TW * RW < 7 THEN PRINT "You won't even reach NJ by Christmas." : GOTO 380
410 PRINT
    PRINT "Your sensitivity to poison ivy:"
420 PRINT " (1) Highly sensitive"
    PRINT " (2) Moderately sensitive"
430 PRINT " (3) Immune"
    PRINT " (4) Had series of desensitization shots"
440 INPUT "Which number describes you";IVY:print
450 IF IVY < 1 OR IVY > 4 THEN PRINT "What's that? Let's try again." : GOTO 440
460 PRINT
    PRINT "People who have hiked the Trail have"
470 PRINT "different feelings  about rain:"
    PRINT " (1) Let it pour, I love it."
480 PRINT " (2) No problem as long as the sun comes"
    PRINT "     out every few days."
490 PRINT " (3) Five solid days of rain really gets"
    PRINT "     me down."
500 PRINT " (4) If I foresee a long stretch of"
510 PRINT "     rain, I'll hole up in a shelter or"
    PRINT "     motel and wait it out."
520 PRINT "Which number most closely describes"
    INPUT "your feeling";RAIN:print
530 IF RAIN < 1 OR RAIN > 4 THEN PRINT "Not possible. Again please." : GOTO 520
540 '
550 'Data on what to carry
560 PRINT
    PRINT "You must make some decisions about what"
	PRINT "to pack."
570 FOR I = 1 TO 7
    READ SP$(I)
	PRINT
	PRINT SP$(I) ":"
580 FOR J = 1 TO 4
    READ ITM$(J), WHT(J), CST(J), VL(J)
	PRINT J ".. " ITM$(J)
590 WEIGHT = WHT(J)
    PRINT "	";
	GOSUB 5430
600 IF VL(J) > 0 THEN PRINT "," VL(J) " cu in";
610 IF CST(J) > 0 THEN PRINT ", price: $" CST(J)
620 NEXT J
630 INPUT "Which one do you want (number)";A:print
640 IF A < 1 OR A > 4 THEN PRINT "Come on now; answer 1, 2, 3, or 4" : GOTO 630
650 ITEM$(I) = ITM$(A)
    WT(I) = WHT(A)
	COST(I) = CST(A)
	VOL(I) = VL(A) : NEXT I
660 VOL1 = VOL(1) + VOL(5) + VOL(7)
    VOL2 = VOL(3) + VOL(4)
	PRINT
670 IF COST(2) > 135 THEN IF VOL(2) > 3000 + VOL1 THEN 720 ELSE 690
680 IF VOL(2) > 3000 + VOL1 + VOL2 THEN 720 : 'Internal pack hold stuff?
690 PRINT "Your pack is too small to hold all those"
    PRINT "things plus clothes and food. You'll"
	PRINT "have to take a larger pack or some"
	PRINT "smaller items."
710 PRINT
    PRINT "Let's try again... "
	RESTORE
	GOTO 570
720 PRINT "How many changes of underwear do you "
    INPUT "want to take";U:print
730 IF U > 6 THEN PRINT "This is not a picnic. Take fewer." : GOTO 720
740 PRINT "Do you want to take a walking stick?"
    INPUT "(Y or N)";A1$:print
	GOSUB 5540
750 IF A1$ = "Y" THEN STK = 1 ELSE STK = 0
760 PRINT
    PRINT "To summarize, here is what you have
	PRINT" chosen:"
770 FOR I = 1 TO 7 : PRINT SP$(I) " : " ITEM$(I) : NEXT I
780 PRINT "Changes of underwear:" U
790 IF STK = 1 THEN PRINT "Walking stick."
    gosub 5400
800 PRINT "In addition, you must carry (or wear) a"
810 PRINT "hat, short-sleeve shirt, chamois shirt,"
    PRINT "light jacket, long underwear, hiking"
820 PRINT "shorts, long pants, 3 pairs socks,"
    PRINT "eating gear, water bottle, soap, toilet"
830 PRINT "tissue, toilet supplies, towel,"
    PRINT "first-aid kit, snakebite kit,"
840 PRINT "flashlight, 100' nylon cord, watch,"
    PRINT "compass, lighter, bandanna, sewing"
850 PRINT "kit, insect repellent, Swiss Army"
    PRINT "knife, water-purifier tablets,"
860 PRINT "notebook, maps, guidebook, stuff sacks,
    PRINT "moleskin, camera, and money."
	PRINT
870 FOR I = 1 TO 7
    WP = WP + WT(I)
	CST1 = CST1 + COST(I)
	NEXT I
880 WP = WP + 190 + U * 4
    IF STK = 1 THEN WP = WP + 24
890 PRINT "If you bought everything new, the total"
    PRINT" cost would be $" 225 + CST1
900 PRINT "The total weight of what you are wearing"
    PRINT "and carrying is";
910 WEIGHT = WP
    GOSUB 5430
	PRINT
	PRINT ".... not including food or water."
920 '
930 'Data on food
940 GOSUB 5390
    PRINT
	PRINT "Common systems of food supply include:"
950 PRINT " (1) Caches buried along the trail."
960 PRINT "     Pros: no wasted time leaving the"
    PRINT "     Trail for food, heavy items can be
	PRINT "     buried."
970 PRINT " (2) Food sent to post offices along the"
980 PRINT "     way. Pros: more flexible than
    PRINT"      caches. Cons: P.O.s closed nights,
	PRINT"      Sat pm and Sun."
990 PRINT " (3) Grocery stores and restaurants."
    PRINT "     Pros: good variety, cheap. Cons: 
	PRINT "     wasted time leaving Trail, limited"
	PRINT "     opening hours."
1010 print "Which will be your major method of food"
     INPUT "supply"; FOOD:print
1020 IF FOOD < 1 OR FOOD > 3 THEN PRINT "Sorry, try again." : GOTO 1010
1030 IF FOOD = 1 THEN RT = 1 ELSE RT = .95 : 'Off-trail excursions reduce walking rate
1040 RM = RT
     GOSUB 5510 : 'Short pause before screen clears
1050 CLS
1060 PRINT "Obviously, you will carry your food in"
1070 PRINT "the most efficient form: dried,"
     print "dehydrated, concentrated, etc. However,"
1080 PRINT "you must specify the percentage of your"
     print "diet accounted for by each of the"
1090 PRINT "following food groups (remember, all"
     print "five must add up to 100)."
1100 PRINT "(1) Dairy foods, cheese, yogurt"
1110 PRINT "(2) Fruits and vegetables"
1120 PRINT "(3) Meat, poultry, fish, eggs"
1130 PRINT "(4) Bread, cereal, seeds, nuts,"
1140 PRINT "(5) Margarine, lard, oils, fats"
1150 CT = 0
     FOR I = 1 TO 5
	 ROW=I+6
	 COL = 35
	 GOSUB 6110
	 INPUT FD(I):print
	 CT = CT + FD(I)
	 NEXT I
1160 ROW=11: COL = 39: GOSUB 6110 : PRINT CT "%" : PRINT
1170 IF CT = 100 THEN PRINT "Very good." : GOTO 1220
1180 PRINT "Sorry, but your percentages add up to";
     print CT " rather than to 100%."
1190 PRINT
     PRINT "Press any key to try again."
1200 DO WHILE LEN(INKEY$) = 0 : LOOP : GOTO 1050
1210 '
1220 'Calculate calorie usage
1230 DM = RW * TW
     IF DM > 30 THEN DM = 30 : 'Desired distance = rate * time
1240 'Calories = metabolism + walking + climbing + camp activities
1250 CD = INT(WB * 11.5 + WB * DM * .3 + (WB + WP / 16) * DM * .21 + WB * (15 - TW) * .22)
1260 PRINT
     PRINT "Given your weight and that of your"
1270 PRINT "supplies, your walking speed, and your"
     print "walking time per day, you can expect"
1280 PRINT "to burn at least" CD " calories per day."
1290 PRINT
	 print "How many calories worth of food do you"
     INPUT "want to eat"; CAL:print
1300 IF CAL > .6 * CD THEN 1330
1310 PRINT "Your body will rebel against burning"
1320 PRINT "that much body fat. Better eat a bit"
     print "more... "
	 GOTO 1290
1330 IF CAL > 1.5 * CD THEN PRINT "No blimps allowed on the trail." : GOTO 1290
1340 FWT = INT(CAL * 3.2/(4 * FD(1) + 3 * FD(2) + 4 * FD(3) + 4 * FD(4) + 9 * FD(5)))
     WEIGHT = FWT
1350 PRINT "That means eating an approx food weight"
     print "per day of";
	 GOSUB 5430
1360 PRINT
     PRINT
	 IF FOOD = 3 THEN DY = 2 ELSE DY = 3 : 'Avg days of food carried
1370 WADD = DY * FWT + 17
     CADD = WADD * DM * .21
	 WP = WP + WADD
	 CD = CD + CADD
1380 PRINT "Food and water add" WADD "oz. to"
     print "your trail weight bringing your"
1390 PRINT "total weight (worn and carried) to"
     WEIGHT = WP
	 GOSUB 5430
	 PRINT
1400 PRINT
     X$ = "Preparations are finally complete!" : GOSUB 5590 : GOSUB 5510
1410 '
1420 'Main Hiking Section
1430 'Initial calculations, data, and messages
1440 WP = WP / 16
     GOSUB 1930 : 'Calculate true hiking pace
1450 PRINT
     PRINT
	 GOSUB 5100 : 'Read locations
1460 PRINT "	It is April 1 and you briskly step"
1470 PRINT "out on the approach trail at Amicalola"
     print "Falls, Georgia. You hike the 6.9 miles"
1480 PRINT "to the peak of Springer Mountain and"
1490 PRINT "sign the trail log, the first of many"
     print "that you intend to sign. Your hike will"
1500 PRINT "take you through 14 states as the Trail"
     print "wanders 2007 miles along the Appalachian"
1510 PRINT "Mountains to Baxter Peak on Mt. Katahdin"
1520 PRINT "in Maine. It is a challenging trail with
     print "an average climb of 200 feet each mile."
1530 PRINT "Fewer than 2000 people have walked its"
     print "entire length. Good luck!"
1540 PRINT
     GOSUB 5390
1550 '
1560 'Main loop starts here
1570 T = T + 3
     TD = INT(T + .5)
	 PRINT
	 GOSUB 5200 : 'Check on the hiker every 3 days
1580 DDAYS = 3 * RM * DINPT
     D = D + DDAYS
	 IF D > 1999 THEN 4560
1590 PRINT " You have walked" INT(D) " miles."
1600 FOR I = 1 TO 21
     IF D > DLC(I) - 17 AND D < DLC(I) + 17 THEN 1620 : 'Near anyplace?
1610 NEXT I
    PRINT
	GOTO 1630
1620 PRINT "You are near " LC$(I)
1630 IF D > 1466 THEN R(10) = .85 : TSLOW(10) = 2007 : 'Slow going in mountains
1640 GOSUB 1710 : 'Any mishaps recently?
1650 IF T > 12 THEN GOSUB 4030 : 'Long stretch of rain?
1660 IF D > 1545 AND T > 166 THEN GOSUB 4260 : 'Snow in New England
1670 IF D > 1845 AND KEN = 0 THEN GOSUB 4380 : 'Kennebec River crossing
1680 IF D > (STV + 1) * 400 THEN GOSUB 1820 : 'Allow user to reset input variables
1690 GOSUB 5390
     GOTO 1570 : 'Go back to start of hiking loop
1700 '
1710 'Subroutine to determine which mishap, if any, occurs
1720 TM = 0
     R1 = INT(1 + 40 * RND(1))
	 IF R1 > 35 THEN R1 = 36 : 'Mishap occurs
1730 IF R1 > 12 THEN 1760
1740 ON R1 GOSUB 2070, 2110, 2150, 2220, 2260, 2300, 2320, 2340, 2390, 2410, 2430, 2460
1750 GOTO 1800
1760 r1=r1-12
     IF R1 > 12 THEN 1790
1770 ON R1 GOSUB 2530, 2570, 2600, 2630, 2670, 2710, 2750, 2770, 2790, 2820, 2870, 2910
1780 GOTO 1800
1790 r1=r1-12
     ON R1 GOSUB 2960, 2990, 3010, 3040, 3070, 3100, 3130, 3170, 3200, 3220, 3260, 3340
1800 T = T + TM
     GOSUB 2020
	 RETURN : 'Time delay resulting from mishap
1810 '
1820 'Subroutine to let user reset input variables
1830 STV = STV + 1
     print "Want to change walking pace or hours of"
     INPUT "walking"; A1$:print:a1$=ucase$(a1$)
1840 GOSUB 5540 
     IF A1$ <>"Y" THEN 1910
1850 INPUT "New walking pace (mph)"; RW:print
1860 IF RW < 1 OR RW > 4.5 THEN PRINT "A rate of" RW "mph is silly." : GOTO 1850
1870 INPUT "New hours per day on the trail"; TW:print
1880 IF TW > 14 THEN PRINT "Come now; that's just too ambitious." : GOTO 1870
1890 IF STK = 1 THEN 1910 ELSE PRINT "Want to change your mind and carry a";
1900 INPUT "walking stick";A1$:print
     GOSUB 5540
	 IF A1$ = "Y" THEN STK = 1
1910 PRINT
     GOSUB 1930
	 RETURN
1920 '
1930 'Subroutine to establish true hiking pace
1940 DINPT = RW * TW : 'Desired distance = walking rate * hours per day
1950 IF D > 600 THEN PC = 1 : 'Under 600 miles physical condition limits mileage
1960 DMAX = 6 + 6 * (5 - PC)
     IF DINPT > DMAX THEN DINPT = DMAX
1970 IF WB / WP > 6 THEN 1990 : 'Body weight to pack weight ratio under 6?
1980 DINPT = (.49 + .086 * WB / WP) * DINPT : 'Heavy pack cuts down speed
1990 IF STV = 0 THEN RETURN : 'No chance to change diet at the start
2000 GOSUB 3820
     RETURN : 'Chance to change diet as trip progresses
2010 '
2020 'Subroutine to alter hiking rate due to mishaps
2030 RM = RT
     FOR I = 1 TO 10
	 IF TSLOW(I) > T THEN RM = RM * R(I)
2040 NEXT I
     RETURN
2050 '
2060 'Subroutines for 35 assorted mishaps follow
2070 IF D > 360 OR HZ(6) = 1 THEN RETURN ELSE TM = .5 : HZ(6) = 1
2080 PRINT "You run into Rangers on military"
2090 PRINT "exercises who advise you to avoid the"
     print "trail for the next few miles because of"
	 print "booby traps."
	 RETURN
2100 '
2110 IF D < 800 OR HZ(12) = 1 THEN RETURN ELSE TM = 1 : HZ(12) = 1
2120 PRINT "The back-support strap on your backpack"
2130 PRINT "has worn through. You'll have to find a"
     print "shoemaker to sew on a piece of heavy
	 print "leather."
	 RETURN
2140 '
2150 IF D - DB < 500 THEN RETURN ELSE IF HZ(15) = 1 THEN 2180 ELSE TM = 1 : HZ(15) = 1
2160 PRINT "The soles of your boots have worn"
2170 PRINT "through. You'll have to get new soles at"
     print "a shoemaker."
	 RETURN
2180 IF D - DB < 800 THEN RETURN ELSE TM = 1.5 : DB = D : HZ(15) = 0
2190 PRINT "Your repaired boot soles are going"
2200 PRINT "again. You'll have to buy a new pair of"
     print "boots along the way."
	 RETURN
2210 '
2220 IF D - DB < 700 THEN RETURN ELSE IF HZ(24) = 1 THEN RETURN ELSE TM = 1 : HZ(24) = 1
2230 PRINT "The uppers on your boots are starting to"
2240 PRINT "separate from the soles. You'll have to"
     print "get them repaired by shoemaker."
	 RETURN
2250 '
2260 IF D < 1000 OR HZ(23) = 1 THEN RETURN ELSE TM = .4 : HZ(23) = 1
2270 PRINT "The seat of your pants has worn through."
2280 PRINT "You can take off the pockets and sew"
     print "them over the holes."
	 RETURN
2290 '
2300 TM = .3
     PRINT "Mice got into your food last night."
	 RETURN
2310 '
2320 TM = .3
     PRINT "Some Boy Scouts kept you awake 'til 1 am"
	 print "last night."
	 RETURN
2330 '
2340 IF D > 900 THEN RETURN ELSE TM = .1
2350 PRINT "Curs attack you as you are walking"
     print "through a small town."
2360 IF STK = 1 THEN PRINT "You drive them off with your walking":print"stick." : RETURN
2370 PRINT "They nip at your heels. You should
     print "really carry a stick."
	 RETURN
2380 '
2390 TM = .3
     PRINT "Trail is poorly marked and you get"
	 print "temporarily lost."
	 RETURN
2400 '
2410 TM = .2
     PRINT "Broken zipper on your pack. Lose time"
	 print "drying stuff."
	 RETURN
2420 '
2430 TM = .3
     PRINT "Route marked on map is out of date."
	 print "You lose time trying to get back on"
	 print "the trail."
	 RETURN
2450 '
2460 IF HZ(1) > 1 THEN RETURN ELSE TM = 2 : HZ(1) = HZ(1) + 1 : DOC = 1
2470 PRINT "You forget to shake out your boot and a"
2480 PRINT "snake has curled up inside for the"
     print "night. You're scared and he's mad."
	 GOSUB 5510
2490 IF RND(1) < .9 THEN PRINT "He slithers away and all is okay. Whew!" : RETURN
2500 PRINT "It's a rattler and he bites you. You'll"
     print "have to get a doctor."
2510 GOTO 3360
2520 '
2530 IF D > 165 OR HZ(7) = 1 THEN RETURN ELSE HZ(7) = 1 : RN = INT(1 + 4 * RND(1)) : TM = RN
2540 PRINT "Late snow in the Smokies. The trail is"
     print "impassable for";RN;" days."
2550 RETURN
2560 '
2570 IF HZ(8) > 3 THEN RETURN ELSE HZ(8) = HZ(8) + 1 : R(1) = .9 : TSLOW(1) = T + 14
2580 PRINT "You have some nasty blisters that will"
     print "slow your pace."
	 RETURN
2590 '
2600 IF HZ(9) > 2 THEN RETURN ELSE HZ(9) = HZ(9) + 1 : R(2) = .7 : TSLOW(2) = T + 3
2610 PRINT "You have bad indigestion from an"
     print "unbalanced diet."
	 RETURN
2620 '
2630 IF D > 870 OR HZ(10) = 1 THEN RETURN ELSE HZ(10) = 1 : TM = .5
2640 PRINT "A bear got into your food and ripped"
2650 PRINT "your pack last night. It's a good thing"
     print "he wasn't hungry for human burgers." : RETURN
2660 '
2670 IF HZ(11) > 1 THEN RETURN ELSE HZ(11) = HZ(11) + 1 : R(3) = .75 : TSLOW(3) = T + 6
2680 PRINT "You twisted your ankle crossing a"
2690 PRINT "stream.  That will slow your pace"
     print "for a few days."
     print "Be more careful!"
	 RETURN
2700 '
2710 IF HZ(2) = 1 THEN RETURN ELSE HZ(2) = 1 : DOC = 2
2720 PRINT "You slipped on some rocks on a ledge."
     print "It's incredibly painful!"
2730 PRINT "Better see a doctor." : GOTO 3360
2740 '
2750 TM = .3
     PRINT "A branch snaps in your eye. Lose time"
	 RETURN
2760 '
2770 TM = .3
     PRINT "Bad case of constipation. Better"
	 print "change diet."
	 RETURN
2780 '
2790 TM = .5
     PRINT "You fell in a stream and everything got"
2800 PRINT "wet. Lose time drying out your sleeping"
     print "bag and clothes."
	 RETURN
2810 '
2820 IF HZ(13) = 1 THEN RETURN ELSE HZ(13) = 1 : TM = 1.5
2830 PRINT "Last night you saw an animal moving near"
     print "you and swatted at it."
2840 GOSUB 5510
     PRINT "Big mistake! It was a skunk. You'll have"
2850 PRINT "to wash what you can and replace the
     print "rest."
	 RETURN
2860 '
2870 IF HZ(14) = 1 THEN RETURN ELSE HZ(14) = 1 : TM = 2
2880 PRINT "Lowliest of the low! Someone stole your"
2890 PRINT "pack while you were taking a shower."
     print "You'll have to replace everything."
	 RETURN
2900 '
2910 IF HZ(3) = 1 THEN RETURN ELSE HZ(3) = 1 : TM = 3 : DOC = 3
2920 PRINT "After five solid days of rain,"
     print "everything is soaked and you just"
2930 PRINT "can't stop shivering. You feel so"
     print "terrible that you'll have to"
2940 PRINT "see a doctor."
     GOTO 3360
2950 '
2960 IF HZ(16) = 1 THEN RETURN ELSE HZ(16) = 1 : TM = .4
2970 PRINT "You cut your hand badly with your knife."
     print "Be careful!"
	 RETURN
2980 '
2990 TM = .3
     PRINT "Socks worn through. You'll have to buy"
	 print "new ones."
	 RETURN
3000 '
3010 IF HZ(17) = 1 THEN RETURN ELSE HZ(17) = 1 : TM = 1
3020 PRINT "Bad toothache. You'll have to find a"
     print "dentist soon."
	 RETURN
3030 '
3040 IF HZ(18) = 2 OR WT(1) = 0 THEN RETURN ELSE HZ(18) = HZ(18) + 1 : TM = .5
3050 PRINT "Tent ripped. You'll have to sew on a"
     print "patch."
	 RETURN
3060 '
3070 IF D < 1000 OR HZ(19) = 1 THEN RETURN ELSE HZ(19) = 1 : TM = .3
3080 PRINT "Your groundcloth is in shreds. Must buy"
     print "a new one."
	 RETURN
3090 '
3100 IF D < 500 OR HZ(20) = 1 OR WT(7) = 0 THEN RETURN ELSE HZ(20) = 1 : TM = .4
3110 PRINT "Bad rip in raingear. Must get a"
     PRINT "replacement."
	 RETURN
3120 '
3130 IF D < 600 OR HZ(21) = 1 OR STK = 0 THEN RETURN ELSE HZ(21) = 1 : R(4) = .9 : TM = .4
3140 PRINT "Your walking stick breaks. You can get a"
3150 PRINT "new one in the next town. Maybe they"
     print "make 'em better up here."
	 TSLOW(4) = T + 4
	 RETURN
3160 '
3170 IF HZ(22) = 1 THEN RETURN ELSE HZ(22) = 1 : TM = .4
3180 PRINT "Your water bag springs a leak. Better"
     print "get a new one soon!"
	 RETURN
3190 '
3200 TM = .2
     PRINT "You run out of toilet tissue. Yucko!" : RETURN
3210 '
3220 PRINT "You run out of water and the springs"
3230 PRINT "marked on the map seem to have vanished"
     print "or dried up. Better take it easy for a"
	 print "bit."
3240 HZ(5) = 1
     R(5) = .9
	 TSLOW(5) = T + 3
	 RETURN
3250 '
3260 IF HZ(4) = 3 THEN RETURN ELSE HZ(4) = HZ(4) + 1 : DOC = 4
3270 PRINT "Oh oh, you stumble into a thicket of"
     print "poison ivy. Zowie!"
3280 IF IVY = 1 OR (IVY = 2 AND RND(1) > .5) THEN 3290 ELSE 3300
3290 PRINT "You got it really bad. You'll have to"
     print "see a doctor."
	 GOTO 3360
3300 PRINT "Like it or not, you got a mild case. It"
3310 PRINT "itches like crazy but the calamine seems"
     print "to have it under control. It slows you"
	 print "down tho'."
3320 R(6) = .9
     TSLOW(6) = T + 7
	 TM = .4
	 RETURN
3330 '
3340 PRINT "Walking... walking... walking... walking" : RETURN
3350 '
3360 'Subroutine to deal with serious injuries and illnesses
3370 PRINT
     PRINT "You're feeling horrible, but you found"
	 print "a nice country doctor."
3380 ON DOC GOTO 3410, 3480, 3570, 3640, 3700
3390 '
3400 'Rattlesnake bite
3410 PRINT "He examines your swollen leg and says,"
     GOSUB 5510
3420 PRINT "'Good thing you got here so quickly."
3430 PRINT "I'll give you a shot of anti-venom but"
     print "you're going to be out of commission"
3440 PRINT "for a good 4 days - and even after that"
     print "you'll have to take it easy for a while.'"
3450 TM = 4
     R(7) = .7
	 TSLOW(7) = T + 15
	 RETURN
3460 '
3470 'Broken or sprained leg
3480 PRINT "He examines your leg and says,"
     GOSUB 5510
	 IF RND(1) > .7 THEN 3520
3490 PRINT "'That's a very nasty sprain. I'll tape"
3500 PRINT "it up, but you'll have to take it easy"
     print "for at least a month.'"
3510 TM = 1.5 
     R(8) = .6
	 TSLOW(8) = T + 30
	 RETURN
3520 PRINT "'Bad news, my young friend. Your leg is"
3530 PRINT "broken. I'm surprised you got here under"
     print "your own power. But this is the end of"
	 print "your hike."
3540 PRINT "Sorry, but maybe you can try again next"
     print "year.'"
	 GOTO 4610
3550 '
3560 'Hypothermia
3570 PRINT "He examines you and says,"
     GOSUB 5510
	 TM = INT(5 + 6 * RND(1))
3580 PRINT "'That prolonged rain and cold has put"
3590 PRINT "you in a condition that we call"
     print "hypothermia. You can stay in town here"
3600 PRINT "at a motel and I'll keep an eye on you,"
     print "but you can't go back on the Trail for"
3610 PRINT "at least";TM;" days. Sorry, but that's"
     print "the way it is.'"
	 RETURN
3620 '
3630 'Poison Ivy
3640 PRINT "He only needs a glance to see that you"
3650 PRINT "are suffering from an extremely bad case"
     print "of poison ivy. He puts you in a clinic"
3660 PRINT "for a few days and tells you what you"
3670 PRINT "already knew - that you'll just have to"
     print "let it run its course."
	 TM = 5
	 RETURN
3680 '
3690 'Excessive weight loss
3700 PRINT "He examines you and says,"
     GOSUB 5510
	 IF WTLOST > .33 * WB THEN 3770
3710 PRINT "'You may want to lose some weight, but"
3720 PRINT "it's coming off far too quickly. Your"
     print "body just can't cope. I'm going to keep"
3730 PRINT "you here for a week on a controlled diet"
     print "- and then for the rest of the trip"
3740 PRINT "you'll have to go at a slower pace. Also,"
     print "I want you to consume at least as many"
	 print "calories per day as your body is using"
	 print "up.'"
3760 WB = 1.18 * WB
     TM = 7
	 R(9) = .8
	 TSLOW(9) = T + 30
	 RETURN
3770 PRINT "'Believe it or not, you are in an"
     print "advanced stage of starvation. You're"
	 print "going to have to remain here for a few"
3790 PRINT "weeks on a controlled diet to stabilize"
     print "your body chemistry. And then you will"
3800 PRINT " go home - yes, HOME, and not back to"
     print "the Trail this year.'"
	 GOTO 4610
3810 '
3820 'Subroutine to examine weight loss
3830 CALOFF = CD - 1.03 * CAL : 'Augment diet by 3% with ice cream, etc.
3840 TS = T - TL
     TL = T : 'Time (in days) of this trip segment
3850 WTLOSS = CALOFF * TS / 3500
     WTLOST = WTLOST + WTLOSS
	 IF WTLOSS < 1 THEN RETURN
3860 PRINT "Since the start of the trip, you have"
     print "lost" INT(WTLOST) " pounds."
3870 IF WTLOST > .07 * WB THEN 3900 : 'Lost more than 7% of orig body weight?
3880 PRINT "Right now you are feeling fit as a"
3890 PRINT "fiddle, but remember, you still have a"
     print "long way to go."
	 GOTO 3970
3900 IF WTLOST > 15 * WB THEN 3930 : 'Lost more than 15% of orig body weight?
3910 PRINT "You occasionally feel a bit lightheaded"
3920 PRINT "and shaky. You really should eat a bit"
     print "more."
	 GOTO 3970
3930 PRINT "That's far too much weight to lose in"
     print "this short period of time."
3940 IF WTLOST > .24 * WB THEN HZ(5) = 1 : DOC = 5 : GOSUB 3360 : GOTO 3970
3950 PRINT "You frequently feel lightheaded,"
3960 PRINT "nauseated, and sluggish. You'd better"
     print "add to your diet... and soon!"
3970 WB = WB.WTLOSS
     CD = INT(WB * 11.5 + WB * DINPT * .3 + (WB + WP) * DINPT * .21 + WB * (15 - TW) * .22)
3980 PRINT "At your current pace, you are burning"
     print CD;" calories per day."
3990 PRINT
     print "How many calories worth of food do you"
     INPUT "want to eat";CAL:print
4000 IF CD - CAL > 400 THEN PRINT "Okay, suit yourself."
4010 RETURN
4020 '
4030 'Subroutine to deal with a long period of rain
4040 IF RND(1) < .94 THEN HZ(5) = 0 : RETURN : '6% chance of heavy rain
4050 IF HZ(5) = 1 THEN HZ(5) = 0 : RETURN : 'In a dry stretch?
4060 HZ(25) = HZ(25) + 1 : TM = RAIN * 1.7 : IF HZ(25) > 4 THEN HZ(25) = 4
4070 ON HZ(25) GOTO 4080, 4130, 4150, 4180
4080 PRINT "It has been raining steadily for the"
4090 PRINT "past week and you are thoroughly soaked"
     print "- your clothes, your sleeping bag, your"
4100 PRINT "food, and, yes, your spirits. What a"
     print "bummer."
	 GOSUB 5510
4110 PRINT "If it continues for another week,"
4120 PRINT "you're going to have fungus growing"
           print "on your skin."
		   RETURN
4130 PRINT "Good grief! More rain - torrential,
     print "blustery, miserable rain."
4140 PRINT "This is really beginning to get you down"
     RETURN
4150 PRINT "Would you believe it? It is raining"
4160 PRINT "again. Not the pitter-patter of the"
     print "songwriters, but steady, heavy, cold"
	 print "rain."
	 GOSUB 5510
4170 PRINT "... and more rain. Won't it ever stop?"
     RETURN
4180 PRINT "Unbelievable... it is raining again..."
     print "and has been for the past week."
4190 IF (RAIN = 2 OR RAIN = 3) AND D < 1900 THEN 4230 ELSE RETURN
4200 IF RAIN = 4 THEN PRINT "Okay, you resign yourself to wait it out" : RETURN
4210 PRINT "Even your cheerful attitude toward rain"
4220 PRINT "is taking a beating, but you keep
     print "slogging along, hoping for a letup."
	 RETURN
4230 GOSUB 5510
     PRINT
	 PRINT "That's it. You can't take any more."
4240 PRINT "Maybe you'll try again next year, but
     print "that's it for now."
	 GOTO 4610
4250 '
4260 'Subroutine to deal with snow in New England
4270 IF T > 200 AND RND(1) > .5 THEN 4290 : '50% chance of snow after Oct 15
4280 IF RND(1) > .2 THEN RETURN : '20% chance of snow
4290 SNO = SNO + 1
     PRINT "Oh oh, New England is getting some snow."
4300 IF SNO = 1 THEN PRINT "but you keep pushing on." : RETURN
4310 IF SNO > 2 THEN 4350 : '3 heavy snowfalls and you're out
4320 PRINT "You pushed through the last flurries but"
4330 PRINT "this looks more serious. You say to"
4340 PRINT "yourself, 'I've gone this far, I'm going"
     print "to go all the way.' And on you go... "
	 RETURN
4350 PRINT "You made a gallant attempt to get"
4360 PRINT "through, but the Park Rangers won't"
     print "let you go on. Too bad."
	 GOTO 4610
4370 '
4380 'Subroutine to deal with the Kennebec River
4390 KEN = 1
     PRINT
	 PRINT "You have arrived at the Kennebec River."
4400 print "Did you make prior arrangements to get"
     INPUT "across";A1$:print
	 GOSUB 5540
4410 IF A1$< >"Y" THEN 4450 ELSE RN = RND(1) : IF RN > .5 THEN 4440
4420 PRINT "Fortunately the person you called showed"
4430 PRINT "up to meet you with a canoe. You get"
     print "across in jig time."
	 TM = .5
	 GOTO 4540
4440 GOSUB 5510
     PRINT "Too bad; the guy you called didn't show"
	 print "up."
	 GOTO 4460
4450 PRINT "That wasn't very sensible."
     print "What will you do now?"
	 GOSUB 5510
4460 IF RND(1) > .7 THEN 4520 : '30% chance you can ford the river
4470 PRINT "The river is running very high and the"
4480 PRINT "logs from the sawmill are very dangerous.
     print "You'll have to hang around until another"
4490 PRINT "hiker (who, hopefully, has arranged for"
4500 PRINT "a canoe) shows up or hope that someone"
     print "comes along."
	 GOSUB 5510
	 TM = INT(2 + 3 * RND(1))
4510 PRINT "Finally... you're across, but it cost"
     print :you" TM "days."
	 GOTO 4540
4520 PRINT "Fortunately the river isn't running too"
4530 PRINT "high and you can probably wade across"
     print "downstream at the ford. Boy, were you"
	 print "lucky!"
	 TM = .6
4540 T = T + TM
     RETURN
4550 '
4560 'Reached end of trail!
4570 PRINT "You reached the end of the trail at"
     print "Baxter Peak on Mt. Katahdin!"
4580 FOR J = 1 TO 3
     GOSUB 5510
	 NEXT J
	 CLS
	 FOR J = 1 TO 10
4590 BEEP
     X$ = "CONGRATULATIONS!"
	 ROW=12: COL = 1
	 GOSUB 6110
	 GOSUB 5590
     NEXT I
	 CLS
	 FOR I = 1 TO 50
	 NEXT I
	 NEXT J
	 D = 2007
4610 TD = INT(T + .5)
     D = INT(D)
	 X1 = (INT(.5 + 10 * D / TD)) / 10 : 'End game statistics
4620 PRINT
     PRINT "It is now ";
	 GOSUB 5220:print
	 PRINT "and you have been on the"
4630 PRINT "trail for";TD;" days."
     print "You have covered" D " miles."
	 print "Your average speed, considering"
	 print "all the delays, was";x1
4650 PRINT " miles per day."
4660 WB = INT(WB + .5)
     WL = INT(WTLOST + .5)
	 IF WL > 0 THEN X$ = " less" : GOTO 4680
4670 X$ = " more"
     WL = -WL
4680 PRINT "You weighed";WB;" pounds at the end,"
     print WL;X$;" than at the start."
4690 PRINT "Nice going!"
4700 PRINT
     END
4720 '
4730 'Names of items that can be carried
4740 DATA "Tent"
4750 DATA "Sierra Designs Divine Light, 20 sq ft, max height 34 in.", 35, 135, 214
4760 DATA "Eureka! Crescent Bike, 22 sq ft, height 43 in.", 48, 125, 353
4770 DATA "Moss Starlet, 29 sq ft; with vestibule, 37; height 39 in.", 78, 250, 334
4780 DATA "None. Use trail shelters and sleep in open.", 0, 0, 0
4790 DATA "Pack"
4800 DATA "Kelty Mountaineer external - frame with Seneca pack", 69, 139, 3975
4810 DATA "Jansport D2 external - frame pack", 99, 169, 5520
4820 DATA "Camp Trails Grey Wolf internal - frame pack, large", 82, 119, 5975
4830 DATA "Coleman Peak 1 model 680 internal - frame pack", 58, 115, 4013
4840 DATA "Sleeping bag"
4850 DATA "North Face Blue Kazoo, mummy, goose down, rated 25 deg", 34, 140, 452
4860 DATA "Slumberjack Bike Lite, mummy, Quallofil, rated 30 deg", 50, 65, 808
4870 DATA "REI 747 Wide Body, semi-rect, Quallofil, rated 30 deg", 54, 90, 1884
4880 DATA "L.L. Bean Ultra - Lite, rectangular, Quallofil, rated 35 deg", 58, 80, 804
4890 DATA "Sleeping pad/mattress"
4900 DATA "Sevylor Superlight air mattress", 32, 20, 360
4910 DATA "Therm-A-Rest self - inflating ultra-lite pad", 28, 48, 325
4920 DATA "Ensolite 1/2 in. pad", 24, 23, 300
4930 DATA "None.", 0, 0, 0
4940 DATA "Stove"
4950 DATA "MSR Whisperlite, uses white gas (available along trail)", 18, 37, 120
4960 DATA "Gaz Bleuet, fuel: butane cartridge (light and reliable)", 16, 20, 106
4970 DATA "Primus Grasshopper, fuel: propane cylinder (long life)", 22, 19, 90
4980 DATA "None (incidentally, wood fires are PROHIBITED on the trail)", 0, 0, 0
4990 DATA "Boots"
5000 DATA "Asolo Trail II S, mid-ankle leather boots", 49, 140, 0
5010 DATA "Danner Featherlight Trail, mid-ankle leather & Gore-Tex boot", 52, 95, 0
5020 DATA "Timberland Lightweight Hiker, mid-ankle fabric and Gore-Tex", 46, 50, 0
5030 DATA "Raichle Montagnas, full-height leather boots", 80, 125, 0
5040 DATA "Raingear"
5050 DATA "Early Winters Ultralight Gore-Tex rain parka", 13, 145, 25
5060 DATA "Patagonia featherweight Gore-Tex shell", 7, 58, 15
5070 DATA "Campmor nylon poncho", 16, 25, 22
5080 DATA "None.", 0, 0, 0
5090 '
5100 FOR I = 1 TO 21 : READ DLC(I), LC$(I) : NEXT I : RETURN
5110 DATA 79, "Bly Gap, GA", 165, "Doe Knob, NC", 302, "Big Bald Mt., NC"
5120 DATA 384, "Wilbur Lake, TN", 483, "Big Walker Lookout, VA", 602, "Tinker Mt., VA"
5130 DATA 698, "Salt Log Gap, VA", 800, "Fishers Gap, VA", 889, "Potomac River, WV"
5140 DATA 966, "Piney Mt., PA", 1099, "Baer Rocks, PA", 1190, "High Point, NC"
5150 DATA 1272, "Shenandoah Mt., NY", 1361, "Sages Ravine, CT", 1435
5160 DATA "Mt. Greylock, MA", 1554, "Killington, VT", 1687, "Mt. Washington, NH"
5170 DATA 1776, "Bemis Pond, ME", 1855, "Kennebec River, ME", 1922
5180 DATA "Chairback Mt., ME", 1992, "Penobscot West Branch, ME"
5190 '
5200 'Subroutine to print the date
5210 IF TT = TD THEN RETURN : 'Printed this date already?
5220 IF TD < 31 THEN 5250 ELSE IF TD < 62 THEN 5260 ELSE IF TD < 90 THEN 5270
5230 IF TD < 121 THEN 5280 ELSE IF TD < 152 THEN 5290 ELSE IF TD < 182 THEN 5300
5240 IF TD < 213 THEN 5310 ELSE IF TD < 225 THEN 5320 ELSE GOTO 5340
5250 MO$ = "April" : MD = TD : GOTO 5330
5260 MO$ = "May" : MD = TD - 30 : GOTO 5330
5270 MO$ = "June" : MD = TD - 61 : GOTO 5330
5280 MO$ = "July" : MD = TD - 89 : GOTO 5330
5290 MO$ = "August" : MD = TD - 120 : GOTO 5330
5300 MO$ = "September" : MD = TD - 151 : GOTO 5330
5310 MO$ = "October" : MD = TD - 181 : GOTO 5330
5320 MO$ = "November" : MD = TD - 212
5330 PRINT MO$; MD; : TT = TD : RETURN
5340 PRINT
     PRINT "It's November 12 and all the New England"
5350 PRINT "states are covered with snow. You have"
     print "no chance of finishing the trail. Better"
5360 PRINT "luck next year. You have been out on the"
5370 TD = INT(T + .5) 
     D = INT(D)
	 X1 = (INT(.5 + 10 * D / TD)) / 10
	 GOTO 4630
5380 '
5390 'Subroutine to temporarily break execution
5400 PRINT : X$ = "Press any key to continue" : GOSUB 5590
5410 DO WHILE LEN(INKEY$) = 0 : LOOP : PRINT : RETURN
5420 '
5430 'Subroutine to print weights by pounds and ounces
5440 WTPND = INT(WEIGHT / 16) : WTOZ = WEIGHT - 16 * WTPND
5450 IF WTPND > 1 THEN PRINT WTPND " pounds"; : GOTO 5470
5460 IF WTPND = 1 THEN PRINT " 1 pound"; : GOTO 5470
5470 IF WTOZ > 1 THEN PRINT WTOZ " ounces"; : RETURN
5480 IF WTOZ = 1 THEN PRINT " 1 ounce";
5490 RETURN
5500 '
5510 'Subroutine to make a short pause
5520 FOR I = 1 TO 900 : NEXT I : RETURN
5530 '
5540 'Subroutine to extract the first letter of an input answer
5550 IF A1$ = "" THEN A1$ = "Y" : RETURN
5560 A1$ = LEFT$(A1$, 1)
     IF A1$ >= "A" AND A1$ <= "Z" THEN RETURN
5570 A1$ = CHR$(ASC(A1$) - 32) : RETURN
5580 '
5590 'Subroutine to print centered lines
5600 PRINT TAB((40 - LEN(X$)) / 2) X$; : RETURN
5610 '
5620 'Subroutine to print the instructions
5630 X$ = "Appalachian Trail" : GOSUB 5590: PRINT
5640 PRINT "   You are a hiker whose goal is to walk"
5650 PRINT "the entire 2007 miles of the Appalachian"
     PRINT "Trail from Springer Mt., GA, to Mt. "
     PRINT "Katahdin, Maine."
5660 PRINT "   You set out in April as soon as the"
5670 PRINT "Smokies are clear of snow, and you must
     PRINT "reach the northern terminus before it is"
	 PRINT "blocked by snow."
	 GOSUB 5400
5680 PRINT "   Your hike is divided into three-day"
5690 PRINT "segments. Along the way, you encounter"
     PRINT "natural hazards, difficulties with your"
5700 PRINT " equipment, and physical problems."
5710 PRINT "   Careful planning for your hike is"
5720 PRINT "very important. In deciding what to"
     PRINT "pack, you have to make trade-offs -"
5730 PRINT "generally between weight and comfort."
     PRINT "Of course, everything must fit in your"
	 PRINT "pack."
5740 PRINT "   You must decide how you will obtain"
5750 PRINT "food along the route, how much to eat"
     PRINT "in each food group, and how many"
	 PRINT "calories to replenish."
5760 PRINT " You must decide at what pace you will"
5770 PRINT "walk, and how long to hike each day. Of"
     PRINT "course, a faster pace will cover"
5780 PRINT "mileage more quickly than a slower one,"
     PRINT "but it is much harder on your body."
	 GOSUB 5400
5790 PRINT "   You don't have many choices when"
5800 PRINT "dealing with mishaps. It is assumed that"
     PRINT "you are a sensible hiker, make repairs"
5810 PRINT "when necessary, replace things that wear"
     PRINT "out, and see a doctor if you get sick."
5820 PRINT "Nevertheless, mishaps cost you time,"
5830 PRINT "of which you have little to spare as"
     PRINT "you take another of the five million"
	 PRINT "steps towards Maine."
5840 PRINT : X$ = "Press any key when you're ready to go."
     GOSUB 5590
	 gosub 5410
	 RETURN
6100 REM Locate row,col
6110 PRINT @(COL*MM.FONTWIDTH,ROW*MM.FONTHEIGHT);: RETURN
