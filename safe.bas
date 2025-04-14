const maxNum = 60
const Right = 0
const Left = 1

dim comb(4): ' Right-Left-Right-Left
currentDial=1
currentCorrect=0
currentComb=0
currentDirection=Right
lose=0

timeLimit = int(rnd*6)+3: ' at least 3 minutes, but up to 9

SplashScreen

InitialDisplay
DisplayCurrent
DisplayCorrect

ChooseCombination

startTime=timer
MainLoop:
    a$=inkey$
    PrintTime

    if a$="" then goto MainLoop

    select case asc(a$)
        case 130 ' Left
            currentDial=currentDial-1
            play tone 500,500,50

            ' If we move left while we are supposed to be moving right
            ' reset where we are at.
            if currentDirection = Right then
                currentCorrect = 0
                DisplayCorrect
                currentComb=0
           end if

        case 131 ' Right
           currentDial=currentDial+1
            play tone 500,500,50

            ' If we move right while we are supposed to be moving left
            ' reset where we are at.
            if currentDirection = Left then
                currentCorrect = 0
                DisplayCorrect
                currentComb=0
           end if

    end select

    if currentDial > maxNum then
        currentDial = 1
    end if

    if currentDial < 1 then
        currentDial = maxNum
    end if

    DisplayCurrent
    
    ' Did we hit a combination number?
    if comb(currentComb) = currentDial then
        ' Indicate that we got one right
        currentCorrect=currentCorrect+1
        DisplayCorrect
        currentComb=currentComb+1
        
        ' Set the new direction we are supposed to be going
        if currentDirection = Right then
            currentDirection = Left
        else
            currentDirection = Right
        end if
    end if

    ' Did we run out of time
    if TimeOut(startTime,timeLimit) = 1 then
        goto TimesUp
    end if

    ' Have we got all the numbers?
    if currentCorrect = 4 then
        goto GotIt
    end if

    goto MainLoop

TimesUp:
    lose=1
    play wav "siren.wav"
    InitialDisplay
    color rgb(yellow),rgb(black)
    print @(0,ToPixelY(21)) "Hands up!  You're under arrest!"
    
    do while inkey$<>""
    loop
    
    do while inkey$=""
    loop
    color rgb(green),rgb(black)
    end

GotIt:
    UnlockSafe
    print @(0,ToPixelY(21)) "You got it!  Now split with the loot!"
    end

function ToPixelY(line) as integer
    ToPixelY = line * MM.FONTHEIGHT
end function

function ToPixelX(col) as integer
    ToPixelX = col * MM.FONTWIDTH
end function

sub SplashScreen
     cls
     print
     print
     print "          SAFE!   By Ron Lauzon"
     print "  Based on the Commodore PET game by"
     print "            Gary Marsa"
     print
     print "NOT-CURSOR #26    Copyright (c) 2025"
     print
     print string$(40,196)
     print
     print "The safe way to be a burglar"
     print
     print
     print "The combination is 4 numbers."
     print "   Right-Left-Right-Left"
     print
     print
     print "Press ";
     color rgb(black),rgb(green)
     print "RETURN";
     color rgb(green),rgb(black)
     print " to begin"

ClearBuffer:
     a$=inkey$:if a$ <> "" then goto ClearBuffer

KeepWaiting:
     a$=inkey$:if a$="" then goto KeepWaiting

end sub

sub InitialDisplay
     cls
     if lose = 1 then
        color rgb(black),rgb(yellow)
     end if
     
     print string$(17,32);chr$(218);string$(4,196);chr$(191);string$(17,32)
     print string$(17,32);chr$(179);string$(4,32);chr$(179);string$(17,32)
     print string$(17,32);chr$(192);chr$(194);chr$(196);chr$(196);chr$(194);chr$(217);string$(17,32)
     print string$(10,32);chr$(218);string$(7,196);chr$(193);chr$(196);chr$(196);;chr$(193);string$(7,196);chr$(191);string$(10,32)
     print string$(10,32);chr$(179);" ";chr$(218);string$(14,196);chr$(191);" ";chr$(179);string$(10,32)
     print string$(10,32);chr$(179);" ";chr$(179);"    ";chr$(218);string$(4,196);chr$(191);"    ";chr$(179);" ";chr$(179);string$(10,32)
     print string$(10,32);chr$(179);" ";chr$(179);"    ";chr$(179);string$(4,32);chr$(179);"    ";chr$(179);" ";chr$(179);string$(10,32)
     print string$(10,32);chr$(179);" ";chr$(179);"    ";chr$(192);string$(4,196);chr$(217);"    ";chr$(179);" ";chr$(179);string$(10,32)
     print string$(10,32);chr$(179);" ";chr$(179);string$(14,32);chr$(179);" ";chr$(179);string$(10,32)
     print string$(10,32);chr$(179);" ";chr$(179);string$(14,32);chr$(179);" ";chr$(179);string$(10,32)
     print string$(10,32);chr$(179);" ";chr$(179);" O";string$(12,32);chr$(179);" ";chr$(179);string$(10,32)
     print string$(10,32);chr$(179);" ";chr$(179);" ";chr$(219);string$(3,220);string$(9,32);chr$(179);" ";chr$(179);string$(5,32);
     
     if lose=0 then
        color rgb(black),rgb(green)
     else
        color rgb(yellow),rgb(black)
     end if
     
     print "o";
     
     if lose=0 then
        color rgb(green),rgb(black)
     else
        color rgb(black),rgb(yellow)
     end if
     
     print string$(4,32)
     print string$(10,32);chr$(179);" ";chr$(179);string$(14,32);chr$(179);" ";chr$(179);;string$(5,32);
     
     if lose=0 then
        color rgb(black),rgb(green)
     else
        color rgb(yellow),rgb(black)
     end if
     
     print "o";
     
     if lose=0 then
        color rgb(green),rgb(black)
     else
        color rgb(black),rgb(yellow)
     end if
     
     print string$(4,32)
     print string$(10,196);chr$(179);" ";chr$(179);string$(14,32);chr$(179);" ";chr$(179);string$(10,196)
     print string$(10,196);chr$(179);" ";chr$(179);string$(14,32);chr$(179);" ";chr$(179);string$(10,196)
     print string$(10,32);chr$(179);" ";chr$(192);string$(14,196);chr$(217);" ";chr$(179);string$(6,32);chr$(218);chr$(196);chr$(196);" "
     print string$(10,32);chr$(192);string$(18,196);chr$(217);"   =";chr$(254);chr$(196);chr$(217);string$(3,32)
     print string$(12,32);"\ /";string$(10,32);"\ /";string$(12,32)
     print string$(13,32);"-";string$(12,32);"-";string$(13,32)

     if lose = 1 then
        color rgb(green),rgb(black)
     end if
end sub

sub UnlockSafe
     print @(ToPixelX(15),ToPixelY(11)) string$(3,32)

     print @(ToPixelX(14),ToPixelY(12)) chr$(221);
     print @(ToPixelX(14),ToPixelY(13)) chr$(221);
     print @(ToPixelX(14),ToPixelY(14)) chr$(221);
end sub

function TimeOut(startTime, timeLimit) as integer
    tm=int((timer-startTime)/60000): ' Minutes
    if tm > timeLimit then
        TimeOut = 1
    else
        TimeOut = 0
    end if
end function

sub PrintTime
    tm=int((timer-startTime)/1000)
    mn=int(tm/60)
    sc=tm-mn*60
    print @(ToPixelX(18),ToPixelY(1)) format$(mn,"%0g");":";format$(sc,"%02g");
end sub

sub ChooseCombination
    comb(0) = int(rnd*maxNum)+1
    comb(1) = int(rnd*maxNum)+1
    comb(2) = int(rnd*maxNum)+1
    comb(3) = int(rnd*maxNum)+1
end sub

sub DisplayCurrent
    print @(ToPixelX(19),ToPixelY(6)) "  ";
    print @(ToPixelX(19),ToPixelY(6)) format$(currentDial,"%02g");
end sub

sub DisplayCorrect
    print @(ToPixelX(23),ToPixelY(6)) "  ";
    print @(ToPixelX(23),ToPixelY(6)) currentCorrect;
end sub