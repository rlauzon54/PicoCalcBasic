function ToPixelY(line) as integer
    ToPixelY = line * MM.FONTHEIGHT
end function

function ToPixelX(col) as integer
    ToPixelX = col * MM.FONTWIDTH
end function

sub Beep
    play tone 500,500
    pause 500
    play stop
end sub

sub PressAnyKey
    PRINT TAB(5) "Press any key to continue."
    do WHILE LEN(INKEY$) = 0 
    loop
end sub

cls
randomize timer
PRINT @(0,ToPixelY(10)) "   The Longest Automobile Race, 1908" 
PRINT @(0,ToPixelY(18)) "         (c) David H. Ahl, 1986"
PRINT "     Updated 2025 for the PicoCalc
print "     by Ron Lauzon"
print

'Initialization
DIM La1$(20), LB$(20), TX(20), C(20), WX(20), DX(20)
DIM Fa1$(20), FB$(20), FC$(20), FT(2, 20), FL(2, 20)
dim c1$(6),W1$(6)

Z = 1000 
GF = .25 : 'Starting cash and gas price
GOSUB InitializeText
GOSUB LoadLocations
GOSUB LoadBreakdowns

PressAnyKey

GOSUB Instructions

MainProgram:
J = J + 1 
T = 0 
pause 500 
GOSUB WarningBeeper : 'New location, road data, etc.
DA = 0 
W = WX(J)
D = DX(J) 
TE = TX(J) : 'Set variables for new location
GOSUB DateSubr
PRINT "You are at ";La1$(J);", ";LB$(J);"."
PRINT "You currently have $";format$(z,"%8.2f")
IF J = 1 THEN goto CalcElapsedTime
       
IF FX <> 0 THEN 
    PRINT "A sympathetic garage owner will fix the"
    print Fa1$(FX);" here." 
    FX = 0

    TZ = INT(1 + 3 * RND) 
    PRINT "It will take ";TZ;" day(s)." 
    GOSUB HotelBills
endif

IF J > 7 AND J < 11 THEN GOSUB OceanVoyage
IF JV = 1 THEN 
    JV = 0 
    TL = TL + TE 
    GOTO MainProgram : 'End of ocean voyage?
endif

PRINT 
PRINT "You have driven ";INT(DC);" miles in"
print TD;" days."
IF J = 20 THEN goto FinishedInParis

IF TD < TL THEN 
    PRINT "You are the race leader and are ";TL - TD
    print "day(s) ahead." 
ELSEIF TD = TL THEN 
    PRINT "You and the Italian Zust are running"
    print "even with each other."
else
    PRINT "The race leader passed this point ";TD - TL
    print "day(s) ago." 
endif

CalcElapsedTime:
TL = TL + TE : 'Elapsed time of race leader
IF J = 7 OR J = 12 THEN GOSUB OceanVoyage
IF JV = 1 THEN 
    JV = 0 
    GOTO MainProgram : 'End of ocean voyage?
endif
PRINT "Roads to the west of here are"
print c1$(C(J)) "."
PRINT "The weather forecast is"
print W1$(W);"."
PRINT "You set a goal of making ";D;" miles"
print "in the next ";TE - 2;" days."
GOSUB FuelAndOil
GOSUB HowFast
GOSUB DriveHours

CompleteSegment:
'Go through this race segment day by day
TZ = 1 
GOSUB HotelBills : 'Increment through each day of travel
GOSUB WeatherConditions
GOSUB MechBreakdown
GOSUB AccidentsEtc
DD = SP * HP * PW 
DA = DA + DD 
DC = DC + DD : 'Daily and cumulative distances
GM = .07 * DD * (.8 + .4 * RND) : 'Gas used today
IF GM < GG THEN 
    GG = GG - GM 
    IF DA >= D THEN 
        goto MainProgram
    ELSE 
        goto CompleteSegment
    endif
endif

Beep 
Beep 
Beep 
GOSUB DateSubr 
PRINT "You ran out of gas on the road."
GF = .33 
GOSUB FuelAndOil
GG = GG - GM : 'Buy gas

IF DA >= D THEN
    goto MainProgram
ELSE
    goto CompleteSegment
endif

FuelAndOil:
GP = GF * (.7 + .6 * RND) 
PRINT "Gas costs";INT(100 * GP);" cents per"
print "gallon here. How many gallons do you"
input "want for the segment ahead"; GG
GF = .25 
ZN = GG * GP 
PRINT "That will cost $";format$(zn,"%8.2f")
GOSUB PayTheBills
IF A = 0 THEN RETURN : 'Enough money now?
IF Z < 2 THEN 
    PRINT "Your car won't run on fumes. It's all"
    print "over." 
    GOTO LoseRace
endif
GG = INT(Z / GP) 
PRINT "Sorry, you could only get" GG "gallons." 
RETURN

HowFast:
INPUT "How fast (mph) do you want to drive";SP
IF SP > 54 THEN 
    PRINT "Top speed of your car is only 54 mph." 
    GOTO HowFast
endif
IF SP < 8 THEN 
    PRINT "At that rate, you'll never get"
    print "there." 
    GOTO HowFast
endif
IF W < 3 AND SP > 30 THEN 
    PRINT "That's too fast for these weather"
    print "and road conditions." 
    GOTO HowFast
ELSE
    PB = SP * SP / 7000 : 'Probability of mechanical breakdown is related to speed
    RETURN
endif

DriveHours:
K = 0 : 'Counter for pushing too hard
AskDriveHours:
print "How many hours do you want to drive"
input "each day"; HP
IF K = 1 THEN goto CheckFatigue
IF HP > 8 THEN 
    PRINT "That's too much for both you and your"
    print "car." 
    GOTO AskDriveHours
endif
IF HP < 2 THEN
    PRINT "No one is that lazy!" 
    GOTO AskDriveHours
endif
HC = HC + HP 
IF J > 2 AND HC / J > 7.55 THEN
    PRINT "You've been pushing yourself and your"
    PRINT "crew pretty hard. You should probably"
    print "back off a bit." 
    K = 1 
    GOTO AskDriveHours
endif

CheckFatigue:
PF = HP ^ 3 / 1000 - .15 
IF PF < .01 THEN PF = .01 : 'Probability of fatigue problem
RETURN

DateSubr:
IF TT = TD THEN RETURN : 'Printed this date already?
PrintDate:
IF TD < 19 THEN 
    MO$ = "February" 
    MD = TD + 11
ELSEIF TD < 50 THEN 
    MO$ = "March" 
    MD = TD - 18 
ELSEIF TD < 80 THEN 
    MO$ = "April" 
    MD = TD - 49 
ELSEIF TD < 111 THEN 
    MO$ = "May"
    MD = TD - 79
ELSEIF TD < 141 THEN
    MO$ = "June" 
    MD = TD - 110 
ELSEIF TD < 172 THEN 
    MO$ = "July" 
    MD = TD - 140
ELSEIF TD < 203 THEN 
    MO$ = "August"
    MD = TD - 171
ELSE 
    GOSUB WarningBeeper 
    GOTO TimesUp
endif

PRINT 
PRINT "Date: " MO$; MD ", 1908" 
TT = TD 
RETURN

TimesUp:
PRINT 
PRINT "It's September 1 and the winning car"
PRINT "crossed the finish line in Paris over a"
PRINT "month ago. Your factory refuses to give"
print "you any more money to continue."
print "Better luck next time."
GOTO EndRaceAndStats

WeatherConditions:
select case w
    case 1 
        'Heavy snow and blizzard conditions
        RN = RND 
        IF RN < .33 THEN 
            GOSUB PrintDate 
            PW = .03 + .08 * RND : 'Speed factor in blizzard
            PRINT "Blizzard conditions. Tough going today." 
            pause 500 
            RETURN
        ELSEIF RN > .83 THEN 
            GOSUB PrintDate 
            PW = .05 + .1 * RND : 'Speed factor in very heavy snow
            PRINT "You're stuck in a huge snow drift." 
            GOSUB PullOutOfDitch 
            RETURN
        ELSE 
            PW = .14 + .17 * RND 
            RETURN : 'Speed factor on heavy snow day
        endif
    case 2 
        'Snow conditions
        ' 10% chance of getting stuck in snow
        1240 IF RND < .1 THEN
            PW = .15 + .1 * RND 
            GOSUB PrintDate 
            PRINT "You have skidded into a ditch."
            GOSUB PullOutOfDitch 
        else
            PW = .3 + .4 * RND 
        endif
        return
    case 3 
        ' Rainy weather
        IF RND < .2 THEN 
            GOSUB PrintDate 
            GOTO BoggedInMud : 'Bogged down in mud?
        endif
        PW = .35 + .4 * RND 
        RETURN : 'Speed factor on normal rainy day
    case else
        ' Cloudy and mixed weather
        RN = RND 
        IF RN > .08 THEN 
            PW = .4 + .4 * RND 
            RETURN : 'Normal cloudy day
        ELSE
            GOSUB PrintDate : 'Normal cloudy day?
        endif

        IF RN < .01 THEN
            PRINT "An unexpected downpour!" 
            GOTO BoggedInMud
        endif
end select

BoggedInMud:
PW = .02 + .04 * RND 
PRINT "You are totally bogged down in the mud."
GOSUB PullOutOfDitch 
RETURN : 'Hire farmer to pull you out of mud?

RiverWithNoBridge:
PRINT "River ahead with no bridge. Some locals"
PRINT "tell you there is a bridge 'some"
print " distance' north. They also offer to"
print "take you across by boat ";
ZN = 3 + 2 * INT(3 * RND) 
PRINT "for $" ZN
INPUT "Want to go by boat";a1$
GOSUB CheckForYesOrNo 
IF A = 1 THEN goto DriveToBridge : 'Not willing to pay?
GOSUB PayTheBills
IF A = 1 THEN goto DriveToBridge : 'Still not enough money?
PRINT "They got you across in";2 + INT(3 * RND)
print "hours." 
PW = .3 
RETURN

DriveToBridge:
TZ = INT(1 + 2 * RND) 
PRINT "It took ";TZ;" day(s) for you to"
PRINT "drive north and find the bridge." 
GOSUB HotelBills 
RETURN

ClearAndSunny:
IF RND < .025 THEN 
    GOSUB PrintDate 
    GOTO RiverWithNoBridge : 'River with no bridge
endif

PW = .45 + .5 * RND 
RETURN : 'Normal sunny day

PullOutOfDitch:
ZN = 5 * INT(1 + 4 * RND) 
PRINT "A farmer offers to pull you out for $" ZN
INPUT "Do you want to pay him to pull you out";a1$ 
GOSUB CheckForYesOrNo
IF A = 1 THEN goto PullCarOut : 'Not willing to pay?
GOSUB PayTheBills
IF A = 1 THEN goto PullCarOut : 'Still not enough money?

RQ = INT(1.5 + 5 * RND) 
PRINT "It took ";RQ;" hours for him to pull"
print "you out."
IF RQ >= 5 THEN 
    TZ = 1 
    GOSUB HotelBills 
    PW = PW * 1.5 
endif
    RETURN

PullCarOut:
TZ = INT(1 + 1.3 * RND) 
PRINT "It took ";TZ;" day(s) for you and your"
PRINT "mechanic to pull the car out by"
print "yourselves." 
GOSUB HotelBills 
PW = PW * 1.5
RETURN

MechBreakdown:
IF RND > PB THEN RETURN : 'If no mechanical breakdown then return
F = INT(1 + 15 * RND) 
IF F > 13 THEN F = INT(14 + 5 * RND) : 'What malfunction
Beep 
Beep 
Beep 
GOSUB DateSubr : 'Sound warning beeper and print date
PRINT "Uh oh. You have a problem. It's a"
print Fa1$(F);"."
PRINT "Here's what you can do about the"
print "problem:"
PRINT TAB(3);"(1) Try to keep going with it"
PRINT TAB(3);"(2) ";FB$(F);", cost $";FL(1, F)
IF FC$(F) = "" THEN goto Decision1 : 'Only one way to fix it?

PRINT TAB(3);"(3) ";FC$(F);", cost $";FL(2, F)

Decision1:
INPUT "Which would you like to do";FQ

select case FQ
    case 1
        goto NurseItAlong : 'Decided to do nothing?
    case 2
        ' Do nothing yet
    case 3
        ' Do nothing yet
    case else
        PRINT "Please enter a number." 
        GOTO Decision1
end select

FQ = FQ - 1 
FU = FT(FQ, F) 
IF FU < 8 THEN 
    FD$ = "hours" 
ELSE 
    goto 1790
endif

IF FU < 5 THEN
    goto Repairs1
ELSE 
    TZ = 1 
    GOTO Repairs2 : 'Lose a day for repairs?
endif

1790 FU = FT(FQ, F) / 8 
TZ = FU 
IF FU = 1 THEN 
    FD$ = "day"
ELSE 
    FD$ = "days"
endif

Repairs2:
PW = PW * 1.5 
GOSUB HotelBills : 'Allow for 1/2 day driven & increase day counters

Repairs1:
ZN = FL(FQ, F) 
PRINT "Repairs will take ";FU;" ";FD$
print "and will cost $";ZN
GOSUB PayTheBills
IF A = 0 THEN RETURN : 'Enough money?

NurseItAlong:
PRINT "You try to nurse the car along to the"
print "next major city."

IF FX = 0 THEN goto UnfixedMalfunction : 'Any unfixed malfunction?

PRINT "But with the other problem you just" 
PRINT "can't make it and reluctantly you admit"
print "defeat." 
GOTO EndRaceAndStats

' 60% chance that you can nurse it along
UnfixedMalfunction:
IF RND > .4 THEN 
    PRINT "It looks like you'll make but at a 
    print "drastically reduced speed."
    PW = PW * .5 
    FX = F 
    RETURN : 'Cut speed factor in half, note unfixed item
endif

pause 500
PRINT 
PRINT "Unfortunately, it just won't make it and"
PRINT "reluctantly you admit defeat." 
GOTO EndRaceAndStats

PRINT "It looks like you'll make but at a 
print "drastically reduced speed."
PW = PW * .5 
FX = F 
RETURN : 'Cut speed factor in half, note unfixed item

AccidentsEtc:
IF RND > PF THEN goto DriveRailroad : 'If driving long hours is not a problem, go on
Beep 
Beep 
Beep 
Beep 
GOSUB DateSubr 

PRINT "You dozed off and your car has run"

select case INT(1 + 4 * RND)
    case 1
        PRINT "into a tree." 
        TZ = 2 
        ZN = 24
    case 2
        PRINT "off the road." 
        TZ = 1 
        ZN = 12
    case 3
        PRINT "into a gaping hole." 
        TZ = 1 
        ZN = 18
    case 4
        PRINT "into a farmer's wagon." 
        TZ = 2
        ZN = 25
    case else
        PRINT "into a farmer's wagon."
        TZ = 2
        ZN = 25
end select

PRINT "You can try to fix it or get a tow to"
print "the next village for $15."
print "Want to try to bang out the damage on"
input "the spot";a1$ 
GOSUB CheckForYesOrNo

IF A = 0 THEN 
    goto PayForTow
ELSE
    PRINT "The tow costs $15 and the repairs cost $" ZN
endif

ZN = ZN + 15 
GOSUB PayTheBills
IF A = 0 THEN goto DriveRailroad
PRINT "The locals impound your car for your unpaid debt." 
GOTO EndRaceAndStats

PayForTow:
PRINT "You finally manage to do it but it takes"
print TZ;" day(s)."
PW = PW * 1.5 
GOSUB HotelBills : 'Allow for 1/2 day driven & increase day counters

DriveRailroad:
'Drive on railraod ties routine
IF J< >2 AND J< >5 AND J< >13 AND J< >14 THEN goto NoGrease : 'In area with railroads?
IF RND > .4 THEN
    goto NoGrease
ELSE
    GOSUB DateSubr : '40% chance to drive on rwy tracks
endif

PRINT "In this area of terrible roads, you can"
PRINT "save some time by driving on the"
PRINT "railraod tracks. However, it is murder"
print "on your wheels, tires, and car."
INPUT "Want to drive on the tracks";a1$
GOSUB CheckForYesOrNo 
IF A = 1 THEN RETURN
PW = PW * 1.7 
PB = PB * 1.25 
RETURN : 'Increase speed and chance of trouble

NoGrease:
IF J< >15 AND J< >16 THEN RETURN : 'In central Russia?
IF RND > .2 THEN RETURN : '20% chance of no grease
Beep 
Beep 
Beep 
GOSUB DateSubr
PRINT "Your differential is dry and there is"
PRINT "no grease available here. However,"
print "you can get Vaseline."
INPUT "Want to use it in place of grease";a1$ 
GOSUB CheckForYesOrNo

IF A = 0 THEN 
    PRINT "Okay, you buy 20 jars for $4." 
    Z = Z - 4 
    RETURN
endif

PRINT "The gears sound horrible. You'll have"
print "to cut your speed in half."
PW = PW * .5 
RETURN

OceanVoyage:
JV = 1
TZ = INT(1 + 3.5 * RND) : 'Length of time in port
IF J = 12 THEN goto Freighter
IF J = 10 THEN goto BackToSeattle
IF J = 9 THEN goto SteamerSched 
IF J = 8 THEN goto WaitForSteamer

PRINT "You're stuck in port for ";TZ + 1;" days"
PRINT "before you can get a steamer for"
PRINT "Seattle. You use the time to get new"
print "countershaft housings, springs, wheels,"
print "drive chains, and tires."

IF Z > 300 THEN
    PRINT "The cost of these items is $164." 
    Z = Z - 164 
else
    PRINT "These were all furnished by the local"
    print "Thomas Flyer dealer."
endif

TZ = TZ + 1 
TD = TD + 3 
GOSUB HotelBills 
GOSUB ReadyToGo 
RETURN

WaitForSteamer:
PRINT "It took 3 days on the steamer. The next"
PRINT "steamer for Valdez Leaves in ";TZ;" days."
print "Nothing to do but wait." 
GOSUB HotelBills
GOSUB ReadyToGo 
TD = TD + 7 
RETURN

SteamerSched:
PRINT "The steamer made many stops up the coast"
PRINT "and it took 7 days. It is apparent that"
PRINT "the race organizers have never been in"
print "Alaska and have no idea that it is"
PRINT "impossible to drive on the snow and ice"
PRINT "at all, much less across the Bering"
print "Strait to Russia. You'll have to return"
print "to Seattle. Next steamer goes in ";TZ
print "days."
GOSUB HotelBills 
GOSUB ReadyToGo 
TD = TD + 7
RETURN

BackToSeattle:
PRINT "It took 7 days to get back to Seattle."
print "Now you have a ";TZ;" day wait before"
print "you can get a freighter for Japan."
GOSUB HotelBills 
GOSUB ReadyToGo 
TD = TD + 21 
RETURN

Freighter:
PRINT "The freighter across the Pacific takes a"
PRINT "leisurely 21 days making stops at"
PRINT "Hawaii, Guam, and the Philippines. Also"
print "the Chinese crewmen made sandals out of"
PRINT "your leather fenders and mud flaps. You"
PRINT "can't replace them in Japan, but you"
print "can at Vladivostock, Russia. There"
PRINT "you'll have to spend several days"
print "arranging for fuel also. But hurry now."
print "A steamer to Russia leaves tonight."
GOSUB ReadyToGo 
TD = TD + 7 
RETURN

HotelBills:
T = T + TZ 
TD = TD + TZ : 'Increment time counters
ZN = 10 * TZ
GOSUB PayTheBills
IF A = 0 THEN RETURN : 'Did we have enough money?
PRINT 
PRINT "You don't even have enough money to pay"
PRINT "for meals. That's the end of the road"
print "for you." 
PRINT 
GOTO EndRaceAndStats

PayTheBills:
IF Z < ZN THEN 
    GOSUB SendMoreMoney
ELSE 
    Z = Z - ZN 
    A = 0 
    RETURN : 'Subtract money from kitty
endif

IF Z < ZN THEN
    A = 1 
    RETURN : 'Couldn't get money from home
endif

SendMoreMoney:
ZB = ZB + 1 
IF ZB < 3 THEN 
    ZW = 1000 
ELSE 
    ZW = 500 : 'Money request and amount
endif
PRINT
PRINT "You don't have enough money to continue."
PRINT "Your only hope is to send a telegram"
PRINT "back to Mr. Thomas at the factory and"
print "ask for more money. Remember, telegrams"
PRINT "in 1908 used all capital letters, had"
print "no commas, and were short."
INPUT "What is your message";a1$ 
a1$=ucase$(a1$)
PRINT "Sending telegram now..."

GOSUB Telegraph 

IF ZB > 3 THEN goto NoMoreMoney
as1 = 0 
AP = 0 
L = LEN(a1$) 
IF L < 12 THEN 
    PRINT "Your message was short all right. Too"
    PRINT "short. Mr. Thomas didn't send any money."
    print "Sorry." 
    RETURN
endif

FOR I = 1 TO L - 2 
    AT$ = MID$(a1$, I, 3) : 'Look at 3-letter groups in telegram
    IF AT$ = "PLE" OR AT$ = "BEG" OR AT$ = "SOR" OR AT$ = "IMP" THEN AP = 1
    IF AT$ = "SOO" OR AT$ = "QUI" OR AT$ = "EAR" OR AT$ = "FAS" OR AT$ = "HUR" THEN as1 = 1
    IF AT$ = "IMM" OR AT$ = "ONC" OR AT$ = "URG" THEN as1 = 1
NEXT I 

IF AP = 0 THEN goto NotPolite
IF as1 = 0 THEN goto NotUrgent

PRINT "Mr. Thomas wired back $";ZW
print "and said 'GOOD LUCK!" 
Z = Z + ZW 
RETURN

NotUrgent:
PRINT "Mr. Thomas didn't know you needed the"
PRINT "money right away and waited 3 days"
print "before wiring back $";ZW 
Z = Z + ZW 
TZ = 3 
GOSUB HotelBills 
RETURN

NotPolite:
IF as1 = 0 THEN 
    PRINT "Mr. Thomas was offended by your" 
    PRINT "telegram and refused to send any money."
    print "Sorry." 
else
    PRINT "Mr. Thomas wired back, 'YOU COULD AT"
    PRINT "LEAST BE POLITE,' but did include a"
    print "draft for $";ZW 
    ZW = ZW / 2 
    Z = Z + ZW 
endif
RETURN

NoMoreMoney:
PRINT "Mr. Thomas wires back: I AM FED UP WITH"
PRINT "THIS ADVENTURE STOP YOU WILL GET NO"
print "MORE MONEY FROM ME STOP" 
RETURN

InitializeText:
FOR I = 1 TO 6 
    READ c1$(I) 
NEXT I
3000 DATA "hard packed gravel", "muddy ruts", "slightly improved wagon tracks"
3010 DATA "built for narrow carts", "practically non-existent", "horrible"

FOR I = 1 TO 6
    READ W1$(I) 
NEXT I
3020 DATA "blizzard conditions", "snow and sleet", "rain"
3030 DATA "cloudy with a chance of rain", "mixed", "sunny and dry"
RETURN

LoadLocations:
'Location, expected weather, road conditions, need to use rail,
'	expected days to next location, distance to next location
FOR I = 1 TO 20
READ X, La1$(I), LB$(I), WX(I), C(I), TX(I), DX(I) 
NEXT I
RETURN
3100 DATA 1, "New York", "New York", 		2, 1, 8, 897
3110 DATA 2, "Kendallville", "Indiana", 	1, 1, 6, 166
3120 DATA 3, "Chicago", "Illinois", 		3, 2, 7, 634
3130 DATA 4, "Omaha", "Nebraska", 		6, 3, 4, 482
3140 DATA 5, "Laramie", "Wyoming", 		2, 3, 7, 467
3150 DATA 6, "Ogden", "Utah", 			6, 1, 8, 1237
3160 DATA 7, "San Francisco", "California", 	5, 7, 8, 0
3170 DATA 8, "Seattle", "Washington", 		5, 7, 8, 0
3180 DATA 9, "Valdez", "Alaska", 		5, 7, 8, 0
3190 DATA 10, "Seattle", "Washington",		5, 7, 25, 0
3200 DATA 11, "Kobe", "Japan", 			4, 4, 4, 350
3210 DATA 12, "Tsuruga", "Japan", 		4, 7, 7, 0
3220 DATA 13, "Vladivostock", "Russia", 	3, 5, 15, 558
3230 DATA 14, "Tsitsihar", "Manchuria", 	5, 6, 10, 659
3240 DATA 15, "Chita", "Russia", 		3, 3, 8, 1116
3250 DATA 16, "Kansk", "Russia", 		4, 3, 6, 1075
3260 DATA 17, "Omsk", "Russia", 		5, 1, 7, 820
3270 DATA 18, "Perm", "Russia", 		3, 2, 14, 1090
3280 DATA 19, "St. Petersburg", "Russia", 	3, 1, 8, 1575
3290 DATA 20, "Paris", "France", 		0, 0, 0, 0

LoadBreakdowns:
'Mechanical breakdown descriptions, time to fix, cost
FOR I = 1 TO 18
READ X, Fa1$(I), FB$(I), FC$(I), FT(1, I), FL(1, I), FT(2, I), FL(2, I) 
NEXT I 
RETURN
3340 DATA 1, "tire blowout", "Patch the hole", "Replace the tire", 		2, 1, 2, 7
3350 DATA 2, "skipping cylinder", "New spark plugs", "Grind cylinder",		1, 2, 8, 2
3360 DATA 3, "rough running engine", "Do a tune up", "", 			4, 5, 0, 0
3370 DATA 4, "binding axle bearing", "Regrind bearing", "Get a new one", 	8, 2, 4, 8
3380 DATA 5, "cracked spring", "New spring", "Weld angle iron to it", 		8, 26, 8, 4
3390 DATA 6, "cracked wheel", "New wheel", "Weld brace on it", 			2, 42, 8, 4
3400 DATA 7, "slipping clutch", "Adjust clutch", "New clutch plate", 		4, 4, 8, 54
3410 DATA 8, "stripped gear", "Weld teeth back on", "New gear", 		16, 6, 8, 24
3420 DATA 9, "radiator leak", "Weld a patch on it", "", 			4, 2, 0, 0
3430 DATA 10, "brakes failure", "Replace the linings", "", 			8, 7, 0, 0
3440 DATA 11, "crack in the countershaft housing", "A new housing", "", 	24, 40, 0, 0
3450 DATA 12, "broken drive pinion", "Weld teeth back on", "New pinion", 	16, 6, 8, 18
3460 DATA 13, "broken rear axle", "Get a new axle", "", 			16, 68, 0, 0
3470 DATA 14, "cracked transmission housing", "New one from factory", "", 	24, 60, 0, 0
3480 DATA 15, "broken motor support", "Make a new one of scrap iron", "", 	16, 16, 0, 0
3490 DATA 16, "worn down clutch shaft", "A new clutch shaft", "", 		8, 28, 0, 0
3500 DATA 17, "cracked frame", "Weld on braces of angle iron", "", 		24, 26, 0, 0
3510 DATA 18, "total transmission failure", "A new one from factory", "", 	40, 225, 0, 0

CheckForYesOrNo:
a1$=UCASE$(a1$)
IF a1$ = "" OR a1$ = "Y" THEN
    A = 0 
    RETURN
endif
IF a1$ = "N" THEN
    A = 1 
    RETURN
endif
PRINT "Don't understand your answer of ";a1$; "."
INPUT "Please enter Y for 'yes' or N for 'no.'";a1$ 
GOTO CheckForYesOrNo


Telegraph:
FOR I = 1 TO 20
    X = 1 + 3 * RND 
    play tone 500,500
    pause 100*x
    play stop
    pause 50
NEXT I
RETURN

WarningBeeper:
PRINT 
FOR I = 1 TO 3 
    Beep
    Beep
    pause 500
NEXT I
RETURN

ReadyToGo:
PRINT
PRINT "Press any key when you're ready to go"
print "aboard."
do WHILE LEN(INKEY$) = 0 
loop
RETURN

FinishedInParis:
' Finished the race in Paris!
FOR K = 1 TO 3
    pause 500
    Beep 
    Beep 
    Beep 
NEXT K 
cls 
X = 0

FOR I = 1 TO 10 
    pause 100
    PRINT @(ToPixelX(15),ToPixelY(10)) x1$ 
    Beep
    IF X = 0 THEN 
        x1$ = "CONGRATULATIONS!" 
        X = 1 
    else
        x1$ = "                "  : 'x1$ = 17 spaces to erase congratulations
        X = 0
    endif
NEXT I
PRINT
PRINT

IF TD < TL THEN 
    PRINT "You reached Paris first! The next car is"
    print TL - TD;" days behind."
    GOTO WonRace
ELSE IF TD = TL THEN 
    goto TiedRace
endif

PRINT "You made it to Paris! The German Protos"
PRINT "beat you by ";TD - TL;" days but just"
print "to finish is a great honor!" 
GOTO LoseRace

TiedRace:
PRINT "You reached Paris in a dead tie with the"
print "French Motobloc!"

WonRace:
PRINT 
PRINT "You reached Paris in ";TD;" days. In"
PRINT "1908, the Thomas Flyer won the race"
print "reaching Paris on July 30 after 169"
print "days." 
END

'End of race and summary statistics
EndRaceAndStats:
PRINT 
GOSUB WarningBeeper
PRINT

LoseRace:
PRINT "Sorry you were unsuccessful. Only three"
PRINT "of the cars in the 1908 race ever"
print "finished." 
PRINT
PRINT "In the ";TD;" days since the start of"
PRINT "the race on February 12, 1908, you"
print "covered ";INT(DC) miles. You almost"
PRINT "made it to ";La1$(J + 1);","
print LB$(J + 1) "."
PRINT "Not bad, but you can do better." 
PRINT
END

Instructions:
cls
PRINT "  The Longest Automobile Race, 1908" 
PRINT
PRINT "	In this program, you are the captain"
PRINT "of the Thomas Flyer team. It is your"
print "job to get the car from New York to"
PRINT "Paris - east to west - as quickly as"
print "possible. The race starts on Febraury"
print "12, 1908."
PRINT "	You must overcome many problems: bad"
PRINT "weather, accidents, mechanical"
print "breakdowns, fatigue, and a lack of gas"
print "stations."
PRINT "	For each leg of the trip, buy as much"
PRINT "gas as you need, but no more. You car"
PRINT "gets approximately 14 mpg, although"
print "this will vary. You will carry what"
PRINT "fuel you can and ship the rest ahead"
print "by rail to locations along your route"
print "to be held for you (called 'spotting')."

PressAnyKey

cls

PRINT "	Your car has a top speed of 54 mph."
PRINT "However, the probability of a breakdown"
print "increases substantially at speeds over"
PRINT "35 mph. Like-wise, driving more than"
PRINT "six hours per day increases your chance"
print "of having an accident. But don't forget,"
print "this IS a race."
PRINT "	If you get stuck, you can pay someone"
PRINT "to pull you out (costs money) or try to"
print "get out on your own (costs time)."
PRINT "	You can choose to repair a mechanical"
PRINT "problem on the spot or wait until the"
PRINT "next large town to get it fixed. Either"
print "choice has associated risks."
PRINT "	If and when you run out of money, you"
PRINT "can wire Mr. Thomas for more, but your"
PRINT "request must be carefully and politely"
print "worded Also, your telegram must be in"
print "all UPPER CASE letters."

PressAnyKey

cls 
RETURN

