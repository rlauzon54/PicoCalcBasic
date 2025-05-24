CONST maxEntries = 50
CONST TypeDirectory = 0
CONST TypeFile = 1
CONST maxSlots=20: ' The number of "slots" on the screen to display things

CONST ESC = 27
CONST DEL = 212
CONST RETURN = 10
CONST UPARROW = 128
CONST DOWNARROW = 129
CONST Func1 = 145
CONST Func2 = 146
CONST Func3 = 147

' fn$ - The file/directory names
' ft - The type of entry
' fCount = Number of entries read in
dim fn$(maxEntries), ft(maxEntries), ftemp$(maxEntries)

function ToPixelY(line) as integer
    ToPixelY = line * MM.FONTHEIGHT
end function

function ToPixelX(col) as integer
    ToPixelX = col * MM.FONTWIDTH
end function

sub Center stuff as string, y as integer
    local x
    x = int((40-len(stuff))/2)
    print @(ToPixelX(x),ToPixelY(y)) stuff
end sub

sub FormatScreen
    local t$,i
    
    cls
    color rgb(black),rgb(green)
    print space$(40);
    Center cwd$,0
    color rgb(green), rgb(black)
    
    print @(0,ToPixelY(23)) "Del=Delete F1=Copy F2=Rename F3=Mkdir"
end sub

sub DisplayStatus status as string
    color rgb(black),rgb(green)
    print @(0,ToPixelY(21)) space$(40);
    print @(0,ToPixelY(21)) status
    color rgb(green), rgb(black)
end sub

sub GetEntries
    local f$, i, x

    ' Get all the directories
    i = 0
    f$=Dir$("*",DIR)
    Do While f$<>""
        ftemp$(i)=f$
        i = i +1
        f$=Dir$()
    Loop

    fCount=0
    if i > 0 then
        ' Sort descending
        sort ftemp$(),,,,i
        
        ' Copy them to the list of files/directories
        for x = 0 to i-1
            fn$(fCount) = ftemp$(x)
            ft(fCount) = TypeDirectory
            fCount=fCount+1
            if fcount = maxEntries then exit sub
         next x     
    endif

    ' Get all the files
    i = 0
    f$=Dir$("*",FILE)
    Do While f$<>""
        ftemp$(i)=f$
        i = i +1
        f$=Dir$()
    Loop

    if i > 0 then
        ' Sort descending
        sort ftemp$(),,,,i
        
        ' Copy them to the list of files/directories
        for x = 0 to i-1
            fn$(fCount) = ftemp$(x)
            ft(fCount) = TypeFile
            fCount=fCount+1
            if fcount = maxEntries then exit sub
        next x
    endif

end sub

sub DisplaySlot entry as integer, loc as integer
    print @(0,ToPixelY(loc)) space$(40);
    print @(0,ToPixelY(loc));
    if ft(entry) = TypeDirectory then print "<DIR> ";
    print fn$(entry);
end sub

sub HighlightEntry entry as integer, loc as integer
    color rgb(black),rgb(green)
    DisplaySlot entry, loc
    color rgb(green), rgb(black)
end sub

sub DisplayFiles startI as integer
    local i, x

    if fCount = 0 then exit sub
    
    i = startI
    for x = 0 to maxSlots-1

        if i >= fcount then 
            exit sub
        endif
        
        DisplaySlot i,x+1
        
        i=i+1
    next x

end sub

function InRootDir() as integer
    local a$
    a$=cwd$
    if right$(a$,1) = "/" then
        InRootDir = 1
    else
        InRootDir = 0
    endif
end function

function GetFileName$(prompt$) as string
    local a$

    color rgb(black),rgb(green)
    print @(0,ToPixelY(21)) space$(40);
    print @(0,ToPixelY(21)) prompt$;
    input a$
    color rgb(green), rgb(black)

    GetFileName$ = a$
end function

function AreYouSure() as integer
    local a$, resp

    color rgb(black),rgb(green)
    print @(0,ToPixelY(21)) space$(40);
    print @(0,ToPixelY(21)) "Are you sure (Y/N)";
    color rgb(green), rgb(black)

    resp = 0
    a$=""
    do
        a$=ucase$(inkey$)
        if a$="Y" then
            AreYouSure = 1
            exit function
        endif
        if a$="N" then
            AreYouSure = 0
            exit function
        endif
    loop

end function


' Main program

MainProgram:
GetEntries
FormatScreen

fe=0: ' The file entry we are currently on
fTop=0: ' The file entry at the top of the screen
slotLoc=1: ' The "slot" that's currently highlighted

DisplayFiles fTop

if fcount > 0 then
    HighlightEntry fe, slotLoc
endif

Do
    a$=inkey$
    select case asc(a$)
        case ESC
            if InRootDir() = 1 then
                cls
                end
            endif
            chdir ".."
            goto MainProgram

        case RETURN
            if ft(fe) = TypeDirectory then
                chdir fn$(fe)
                goto MainProgram
            else if ucase$(right$(fn$(fe),4)) = ".BAS" then
                run fn$(fe)
            else
                DisplayStatus fn$(fe)+" cannot be run"
            endif
            
        case UPARROW
            if fe-1 >= 0 then
                DisplaySlot fe, slotLoc
                fe=fe-1

                if slotLoc-1 < 1 then
                    fTop = fTop-1
                    DisplayFiles fTop
                else
                    slotLoc = slotLoc-1
                endif

                HighlightEntry fe, slotLoc
            endif

        case DOWNARROW
            if fe+1 < fcount then
                DisplaySlot fe, slotLoc
                fe=fe+1

                if slotLoc >= maxSlots then
                    fTop = fTop+1
                    DisplayFiles fTop
                else
                    slotLoc = slotLoc+1
                endif

                HighlightEntry fe, slotLoc
            endif

        case DEL
            if AreYouSure() = 1 then
                if ft(fe) = TypeDirectory then
                    on error skip 1
                    rmdir fn$(fe)
                    if MM.ERRNO <> 0 then
                        DisplayStatus MM.ERRMSG$
                    else
                        goto MainProgram
                    endif
                else
                    kill fn$(fe)
                    if MM.ERRNO <> 0 then
                        DisplayStatus MM.ERRMSG$
                    else
                        goto MainProgram
                    endif                
                endif
            else
                DisplayStatus " "
            endif
            
        case Func1
            newFile$ = GetFileName$("To")
            if len(newFile$) > 0 then
                on error skip 1
                copy fn$(fe) to newFile$
                if MM.ERRNO <> 0 then
                    DisplayStatus MM.ERRMSG$
                else
                    goto MainProgram
                endif
            else
                DisplayStatus " "
            endif

        case Func2
            newFile$ = GetFileName$("Name")
            if len(newFile$) > 0 then
                on error skip 1
                rename fn$(fe) as newFile$
                if MM.ERRNO <> 0 then
                    DisplayStatus MM.ERRMSG$
                else
                    goto MainProgram
                endif
            else
                DisplayStatus " "
            endif

        case Func3
            DisplayStatus "Make Dir"
            newFile$ = GetFileName$("Name")
            if len(newFile$) > 0 then
                on error skip 1
                mkdir newFile$
                if MM.ERRNO <> 0 then
                    DisplayStatus MM.ERRMSG$
                else
                    goto MainProgram
                endif
            else
                DisplayStatus " "
            endif

    end select
Loop
