'hamurabi.bas
' Original code by Creative Computing, Morristown, New Jersey
' Updated code by Chris Stoddard

Randomize

Dim As Integer year, people, grain, harvest, rats, land, yield, immigrants
Dim As Integer starved, totalStarved, totalPercentStarved
Dim As Integer landPrice, acresToBuy, acresToSell, grainToFeed, acresToPlant
Dim As Integer plagueChance, peopleFed, babies, inputValid
Dim As Double percentStarved

year = 0: people = 95: grain = 2800: harvest = 0: rats = 0
land = 3000: yield = 3: landPrice = 17: immigrants = 5
starved = 0: totalStarved = 0: totalPercentStarved = 0

Sub ThinkAgainGrain(grain As Integer)
    Print "HAMURABI: THINK AGAIN. YOU HAVE ONLY "; grain; " BUSHELS OF GRAIN. NOW THEN,"
End Sub

Sub ThinkAgainLand(land As Integer)
    Print "HAMURABI: THINK AGAIN. YOU OWN ONLY "; land; " ACRES. NOW THEN,"
End Sub

Sub ImpossibleRequest()
    Print : Print "HAMURABI: I CANNOT DO WHAT YOU WISH."
    Print "GET YOURSELF ANOTHER STEWARD!!!!!"
    End
End Sub

Sub Bell()
    For i As Integer = 1 To 10
        Print Chr(7);
    Next
End Sub

For year = 1 To 10
    Print : Print : Print "HAMURABI: I BEG TO REPORT TO YOU,"
    If year > 1 Then
        Print "IN YEAR "; year - 1; ", "; starved; " PEOPLE STARVED, "; immigrants; " CAME TO THE CITY,"
    End If
    people = people + immigrants
    If plagueChance = 0 Then
        people = people \ 2
        Print "A HORRIBLE PLAGUE STRUCK! HALF THE PEOPLE DIED."
    End If
    Print "POPULATION IS NOW "; people
    Print "THE CITY NOW OWNS "; land; " ACRES."
    Print "YOU HARVESTED "; yield; " BUSHELS PER ACRE."
    Print "THE RATS ATE "; rats; " BUSHELS."
    Print "YOU NOW HAVE "; grain; " BUSHELS IN STORE."

    landPrice = Int(Rnd * 10) + 17
    Print "LAND IS TRADING AT "; landPrice; " BUSHELS PER ACRE."

    Do
        inputValid = 1
        Print "HOW MANY ACRES DO YOU WISH TO BUY? ";
        Input "", acresToBuy
        If acresToBuy < 0 Then ImpossibleRequest
        If acresToBuy * landPrice > grain Then
            ThinkAgainGrain(grain)
            inputValid = 0
        End If
    Loop Until inputValid = 1

    If acresToBuy > 0 Then
        land += acresToBuy
        grain -= acresToBuy * landPrice
    Else
        Do
            inputValid = 1
            Print "HOW MANY ACRES DO YOU WISH TO SELL? ";
            Input "", acresToSell
            If acresToSell < 0 Then ImpossibleRequest
            If acresToSell > land Then
                ThinkAgainLand(land)
                inputValid = 0
            End If
        Loop Until inputValid = 1
        land = land - acresToSell
        grain = grain + acresToSell * landPrice
    End If

    Do
        inputValid = 1
        Print "HOW MANY BUSHELS DO YOU WISH TO FEED YOUR PEOPLE? ";
        Input "", grainToFeed
        If grainToFeed < 0 Then ImpossibleRequest
        If grainToFeed > grain Then
            ThinkAgainGrain(grain)
            inputValid = 0
        End If
    Loop Until inputValid = 1
    grain = grain - grainToFeed

    Do
        inputValid = 1
        Print "HOW MANY ACRES DO YOU WISH TO PLANT WITH SEED? ";
        Input "", acresToPlant
        If acresToPlant < 0 Then ImpossibleRequest
        If acresToPlant > land Then
            ThinkAgainLand(land)
            inputValid = 0
        ElseIf acresToPlant \ 2 > grain Then
            ThinkAgainGrain(grain)
            inputValid = 0
        ElseIf acresToPlant > people * 10 Then
            Print "BUT YOU HAVE ONLY "; people; " PEOPLE TO TEND THE FIELDS! NOW THEN,"
            inputValid = 0
        End If
    Loop Until inputValid = 1
    grain = grain - acresToPlant \ 2

    yield = Int(Rnd * 5) + 1
    harvest = acresToPlant * yield
    rats = 0
    If Int(Rnd * 2) = 0 Then
        rats = Int(grain / yield)
    End If
    grain = grain + harvest - rats

    babies = Int(yield * (20 * land + grain) / people / 100 + 1)
    immigrants = babies
    peopleFed = grainToFeed \ 20

    plagueChance = Int(10 * (2 * Rnd - 0.3))

    If peopleFed < people Then
        starved = people - peopleFed
        percentStarved = (100.0 * starved) / people
        If percentStarved > 45 Then
            Print : Print "YOU STARVED "; starved; " PEOPLE IN ONE YEAR!!!"
            Print "DUE TO THIS EXTREME MISMANAGEMENT YOU HAVE NOT ONLY"
            Print "BEEN IMPEACHED AND THROWN OUT OF OFFICE BUT YOU HAVE"
            Print "ALSO BEEN DECLARED NATIONAL FINK!!!!"
            End
        End If
    Else
        starved = 0
    End If

    totalStarved += starved
    totalPercentStarved += percentStarved
    people = people - starved
Next

Dim As Integer acresPerPerson = land \ people
Dim As Integer avgStarved = totalPercentStarved \ 10

Print : Print "IN YOUR 10-YEAR TERM OF OFFICE, "; avgStarved; "% OF THE"
Print "POPULATION STARVED PER YEAR ON THE AVERAGE."
Print "A TOTAL OF "; totalStarved; " PEOPLE DIED!!"
Print "YOU STARTED WITH 10 ACRES PER PERSON AND ENDED WITH"
Print acresPerPerson; " ACRES PER PERSON."

If avgStarved > 33 Or acresPerPerson < 7 Then
    Print "YOU STARVED TOO MANY AND LOST TOO MUCH LAND!"
    Print "YOU HAVE BEEN DECLARED A DISASTER!"
ElseIf avgStarved <= 10 And acresPerPerson >= 9 Then
    Print "A FANTASTIC PERFORMANCE!!! CHARLEMAGNE, DISRAELI, AND"
    Print "JEFFERSON COMBINED COULD NOT HAVE DONE BETTER!"
ElseIf avgStarved > 3 Or acresPerPerson < 10 Then
    Print "YOUR PERFORMANCE COULD HAVE BEEN SOMEWHAT BETTER."
    Print Int(people * 0.8 * Rnd); " PEOPLE WOULD DEARLY LIKE TO SEE YOU ASSASSINATED."
Else
    Print "YOUR HEAVY-HANDED PERFORMANCE SMACKS OF NERO AND IVAN IV."
    Print "THE PEOPLE (REMAINING) FIND YOU AN UNPLEASANT RULER AND,"
    Print "FRANKLY, HATE YOUR GUTS!!"
End If

Bell()
Print : Print "SO LONG FOR NOW."
End
