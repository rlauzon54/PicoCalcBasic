10 CLS: RANDOMIZE TIMER
20 REM Weather "forecaster"
25 REM by Ron Lauzon 2022
   n = epoch(now): ' Get the current date time as an epoch
   od = 24*60*60: ' 24 hours/day * 60 min/hour * 60 sec/min
50 MON = VAL(MID$(TODAY$,4,2)): ' Get the month for the rules
190 PRINT "Weekly forecast:"
200 FOR I = 0 TO 6
210 If I = 0 then print "Today - ";tab(14);:goto 220
    print day$(datetime$(n+od*i));" - ";tab(14);
220 GOSUB 460: REM print forecast
250 NEXT I
260 END
450 REM Display forecast
460 X=INT(RND*21)+1
470 ON X GOTO 480, 490, 500, 510, 520, 540, 560, 570, 580, 590, 610, 630, 650, 670, 690, 710, 720, 740, 750, 770, 790
480 PRINT "Clear": RETURN
490 PRINT "Partly clear": RETURN
500 PRINT "Mostly clear": RETURN
510 PRINT "Mostly cloudy": RETURN
520 IF MON > 10 OR MON < 4 THEN PRINT "Snowy": RETURN
530 GOTO 460
540 IF MON > 4 AND MON < 11 THEN PRINT "Rainy": RETURN
550 GOTO 460
560 PRINT "Windy": RETURN
570 PRINT "Partly cloudy": RETURN
580 PRINT "Cloudy": RETURN
590 IF MON > 4 AND MON < 11 THEN PRINT "Foggy": RETURN
600 GOTO 460
610 IF MON > 10 OR MON < 4 THEN PRINT "Blizzard": RETURN
620 GOTO 460
630 IF MON > 2 AND MON < 10 THEN PRINT "Thunderstorms": RETURN
640 GOTO 460
650 IF MON > 5 AND MON < 9 THEN PRINT "Hot and humid": RETURN
660 GOTO 460
670 IF MON > 10 OR MON < 4 THEN PRINT "Frigid": RETURN
680 GOTO 460
690 IF MON=9 OR MON=10 OR MON=11 OR MON=3 OR MON=4 OR MON=5 THEN PRINT "Cold and wet": RETURN
700 GOTO 460
710 PRINT "Pleasant": RETURN
720 IF MON>2 AND MON < 11 THEN PRINT "Warm and sunny": RETURN
730 GOTO 460
740 PRINT "Sunny": RETURN
750 IF MON > 5 AND MON < 10 THEN PRINT "Beach weather!": RETURN
760 GOTO 460
770 IF MON=3 OR MON=4 OR MON=5 OR MON=9 OR MON=10 OR MON=11 THEN PRINT "Blustery": RETURN
780 GOTO 460
790 IF MON=1 OR MON=2 OR MON=12 THEN PRINT "Break out the snowshoes!": RETURN
800 GOTO 460

