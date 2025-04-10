' This program is intended to be set to autorun
' on boot.  To make it run on boot do:
' load "autoexec.bas"
' flash save 1
' option autorun 1

InitializeDisplay

SetDate

SetTime

MainLoop:
    a$=inkey$
    if a$="" then goto MainLoop
    
    select case asc(a$)
        case 27
            cls
            end

        case 145
            ChangeDefaultDrive "B:"
        case 146
            ChangeDefaultDrive "A:"
            
        case 147
            SetDate
        case 148
            SetTime
    end select

    goto MainLoop
    

function ToPixelY(line) as integer
    ToPixelY = line * MM.FONTHEIGHT
end function

function ToPixelX(col) as integer
    ToPixelX = col * MM.FONTWIDTH
end function

sub InitializeDisplay
    cls
    color rgb(black),rgb(green)
    print "          PicoCalc AutoExec             "
    color rgb(green), rgb(black)
    
    print@(0,ToPixelY(2)) "Default ";MM.INFO(drive)

    print@(0,ToPixelY(20)) "ESC=Exit    F1=Default B:  F2=Default A:"
    print@(0,ToPixelY(21)) "F3=Set Date F4=Set Time"
end sub

sub SetDate
    print @(0,ToPixelY(5)) "Date:    YYYY-MM-DD";
    print @(ToPixelX(7),ToPixelY(5));
    input dt$:print
    date$=dt$
    print "Set date to ";date$
end sub

' Explanation here:
' For some strange reason, when INPUTting
' if you enter ":", it will add an extra character
' that does not display.  Theory: It's the code
' for the Shift key.  So enter a space instead
' and then replace the space with a ":".
sub SetTime
    print @(0,ToPixelY(8)) "Time:    HH MM";
    print @(ToPixelX(7),ToPixelY(8));
    input t$:print
    mid$(t$,3,1)=":"
    time$=t$
    print "Set time to ";time$
end sub

sub ChangeDefaultDrive drv$
    drive drv$
    print@(ToPixelX(8),ToPixelY(2)) drv$
end sub