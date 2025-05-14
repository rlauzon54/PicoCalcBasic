' Key codes
CONST Func1 = 145
CONST Func2 = 146
CONST Func3 = 147
CONST Func4 = 148
CONST Func5 = 149
CONST Func6 = 150
CONST Func7 = 151
CONST Func8 = 152
CONST Func9 = 153
CONST Func10 = 154
CONST ESC = 27
CONST RETURN = 10
CONST UPARROW = 128
CONST LEFTARROW = 130
CONST RIGHTARROW = 131
CONST DOWNARROW = 129
' Shift Up Arrow
CONST SHUPARR = 136
' Shift Down Arrow
CONST SHDOWNARR = 137
CONST BACKSP = 8

' Number of days in each month
dim monthDays(12)
monthDays(1) = 31
monthDays(2) = 28
monthDays(3) = 31
monthDays(4) = 30
monthDays(5) = 31
monthDays(6) = 30
monthDays(7) = 31
monthDays(8) = 31
monthDays(9) = 30
monthDays(10) = 31
monthDays(11) = 30
monthDays(12) = 31

' The limit on 48 entries on a day or todo list is arbitrary and was left over
' from the original program.
dim dayYear(48), dayMonth(48), dayDay(48), dayTime$(48), dayDur$(48), dayDesc$(48), dayFileLoc(48)
dim todoYear(48), todoMonth(48), todoDay(48), todoDesc$(48), todoFileLoc(48)

' Shared between todo and daily calendar
recCount = 0: ' Number of records read in
RecordSize = 45: ' Byte size of the records

' ************************************
' Common file management
' ************************************

sub SaveNewRecord rec$ as string, filename$ as string
    local fileLoc
    
    OPEN filename$ FOR RANDOM AS #1
    
    ' Find open slot
    fileLoc = 1
    do while fileLoc < LOF(#1)
        seek #1,fileLoc
        rec1$=input$(RecordSize,#1)
        if len(rec1$) > 0 then
            TodoUnpackRecord(rec1$)
            
            ' Empty slot
            if recYear = 0 then
                seek #1,fileLoc
                PRINT #1,rec$;
                close #1
                exit sub
            endif
        endif
        fileLoc = fileLoc + recordSize
    loop

    ' No empty slots - add to the end
    SEEK #1, LOF(#1) + 1
    PRINT #1,rec$; : ' semi-colon important or it will add extra characters
    close #1
end sub

sub UpdateRecord rec$ as string, filename$ as string, fileLoc as integer
    OPEN filename$ FOR RANDOM AS #1
    SEEK #1, fileLoc
    PRINT #1,rec$; : ' semi-colon important or it will add extra characters
    close #1
end sub



' ************************************
' Todo file management
' ************************************

todoFile$="todo.dat"
maxTodoDesc = 37
sub TodoUnpackRecord record$ as string
    recYear =val(left$(record$,4))
    recMon =val(mid$(record$,5,2))
    recDay =val(mid$(record$,7,2))
    recDesc$=rtrim$(right$(record$,maxTodoDesc)," ")
end sub

function TodoPackRecord$(y,m,d,desc$) as string
     local ys$, ms$, ds$, temp$
     ys$ = right$("0000"+str$(y),4)
     ms$ = right$("00"+str$(m),2)
     ds$ = right$("00"+str$(d),2)
     
     temp$=left$(ys$+ms$+ds$+desc$+string$(maxTodoDesc,32),RecordSize)
     
     TodoPackRecord$ = temp$
end function

sub TodoGetDataForToday
    local fileLoc
     
    recCount = 0

    ' Open the file
    OPEN todoFile$ FOR RANDOM AS #1
    fileLoc = 1
    
    ' Keep reading until we run out of data
    do while fileLoc < LOF(#1)
        seek #1,fileLoc
        rec$=input$(RecordSize,#1)
        if len(rec$) > 0 then
            TodoUnpackRecord(rec$)

            if recYear = year and recMon = Month and recDay = day then
                todoFileLoc(recCount) = fileLoc
                todoYear(recCount) = recYear
                todoMonth(recCount) = recMonth
                todoDay(recCount) = recDay
                todoDesc$(recCount) = recDesc$
                recCount = recCount+1
            endif
        endif

        fileLoc = fileLoc + recordSize
    loop
    
    Close #1
end sub

' ************************************
' Daily calendar file management
' ************************************

maxDayDesc = 27
calendarFile$="calendr.dat"

sub DayUnpackRecord record$ as string
    recYear =val(left$(record$,4))
    recMon =val(mid$(record$,5,2))
    recDay =val(mid$(record$,7,2))
    recTm$=mid$(record$,9,5)
    recDur$ =mid$(record$,14,5)
    recDesc$=rtrim$(right$(record$,maxDayDesc)," ")
end sub

function DayPackRecord$(y,m,d,tm$,dur$,desc$) as string
     local ys$, ms$, ds$, temp$
     ys$ = right$("0000"+str$(y),4)
     ms$ = right$("00"+str$(m),2)
     ds$ = right$("00"+str$(d),2)
     
     temp$=left$(ys$+ms$+ds$+tm$+dur$+desc$+string$(maxDayDesc,32),RecordSize)
     
     DayPackRecord$ = temp$
end function

sub DayGetDataForToday
    local fileLoc
     
    recCount = 0

    ' Open the file
    OPEN calendarFile$ FOR RANDOM AS #1
    fileLoc = 1
    
    ' Keep reading until we run out of data
    do while fileLoc < LOF(#1)
        seek #1,fileLoc
        rec$=input$(RecordSize,#1)
        if len(rec$) > 0 then
            DayUnpackRecord(rec$)

            'print @(0,toPixelY(20)) recYear;" ";recMon;" ";recDay

            if recYear = year and recMon = Month and recDay = day then
                dayFileLoc(recCount) = fileLoc
                dayYear(recCount) = recYear
                dayMonth(recCount) = recMonth
                dayDay(recCount) = recDay
                dayTime$(recCount) = recTm$
                dayDur$(recCount) = recDur$
                dayDesc$(recCount) = recDesc$
                recCount = recCount+1
            endif
        endif

        fileLoc = fileLoc + recordSize
    loop
    
    Close #1
end sub


' ************************************
' General routines
' ************************************

Function RTrim$(s$, c$)
    RTrim$ = s$
    Do While Instr(c$, Right$(RTrim$, 1))
        RTrim$ = Mid$(RTrim$, 1, Len(RTrim$) - 1)
    Loop
End Function

function ToPixelY(line) as integer
    ToPixelY = line * MM.FONTHEIGHT
end function
function ToPixelX(col) as integer
    ToPixelX = col * MM.FONTWIDTH
end function

sub revOn()
    color rgb(black), rgb(green)
end sub
sub revOff()
    color rgb(green), rgb(black)
end sub

' Input len characters
' Like old Microsoft BASIC INPUT$ function
function inputString$(len)
    local result$, a$
    result$=""
    
    do
        a$=""
        do while a$=""
           a$=INKEY$
        loop
        
        ' Remove extra key strokes generated by the
        ' Shifts, ctrl and alt keys
        select case asc(a$)
            ' Left shift, right shift, ctrl, alt
            case 162, 163, 161, 165
                a$=""
        end select

        result$=result$+a$
    loop until len(result$) = len
    
    inputString$ = result$
end function

function MonthString(month) as string
    select case month
        case 1
            MonthString="January"
        case 2
            MonthString="February"
        case 3
            MonthString="March"
        case 4
            MonthString="April"
        case 5
            MonthString="May"
        case 6
            MonthString="June"
        case 7
            MonthString="July"
        case 8
            MonthString="August"
        case 9
            MonthString="September"
        case 10
            MonthString="October"
        case 11
            MonthString="November"
        case 12
            MonthString="December"
        case else
            MonthString="Error"+str$(month)
    end select
end function

sub Center stuff as string, y as integer
    local x
    x = int((40-len(stuff))/2)
    print @(ToPixelX(x),ToPixelY(y)) stuff
end sub

function FebuaryDays(year) as integer
    if year mod 400 = 0 then
        FebuaryDays = 29
    elseif year mod 100 = 0 then
        FebuaryDays = 28
    elseif year mod 4 = 0 then
        FebuaryDays = 29
    else
        FebuaryDays = 28
    endif
end function


' ************************************
' Main Calendar routines
' ************************************
sub DisplayCalendar
    cls
    revOn()
    PRINT" Executive Calendar - Version 01.00.00 ";
    revOff()
    print
    print
    print
    print "  Sun  Mon  Tue  Wed  Thu  Fri  Sat"
    print " ";chr$(218);
    for i = 1 to 6
        print string$(4,196);chr$(194);
    next i
    print  string$(4,196);chr$(191)
    
    for j = 1 to 5
        print " ";
        for i = 1 to 7
            print chr$(179);string$(4,32);
        next i
        print chr$(179)

        print " ";chr$(195);
        for i = 1 to 6
            print string$(4,196);chr$(197);
        next i
        print string$(4,196);chr$(180)
    next j

    print " ";
    for i = 1 to 7
        print chr$(179);string$(4,32);
    next i
    print chr$(179)

    print " ";chr$(192);
    for i = 1 to 6
        print string$(4,196);chr$(193);
    next i
    print string$(4,196);chr$(217)

    print @(0,ToPixelY(22)) " F1=Prev F2= Next F3=Any F4=Todo F5=Day"
    print @(0,ToPixelY(23)) "             ESC=Exit"
end sub

function DOWNum(dow$) as integer
    select case dow$
        case "Sunday"
            DOWNum = 1
        case "Monday"
            DOWNum = 2
        case "Tuesday"
            DOWNum = 3
        case "Wednesday"
            DOWNum = 4
        case "Thursday"
            DOWNum = 5
        case "Friday"
            DOWNum = 6
        case "Saturday"
            DOWNum = 7
        case else
            print @(0,ToPixelY(24)) "Unknown day ";dow$
            DOWNum = 0
    end select
end function

sub DisplayDays
     local sx, sy, i, dw, md
     
     dw = DayStartOfMonth(month, year)
     
     sx = 4+(dw-1)*5
     sy = 5
     
     for i = 1 to monthDays(month)
     
         if i = day then revOn()
         print @(ToPixelX(sx),ToPixelY(sy)) str$(i);
         if i = day then revOff()
         
         sx=sx+5
         if sx > 35 then
             sx=4
             sy=sy+2
         endif
     next i
end sub

function DayStartOfMonth(month, year) as integer
    local t$, t2$
    
    t$="1-"+str$(month)+"-"+str$(year)
    t2$=day$(t$)
    DayStartOfMonth = DOWNum(t2$)
end function

' ************************************
' Day Calendar routines
' ************************************
sub DayDisplayFrame
    cls
    center(MonthString(month)+" "+str$(day)+" "+str$(year))
    print "Time  Dur.  Description"
    print @(0,ToPixelY(23)) "F1=Add  F2=Edit  F3=Remove  ESC=Back"
end sub

sub DayDisplayInfo startI as integer
    local i, x, desc$
    
    if recCount = 0 then exit sub
    
    i = startI
    for x = 0 to 14
        if i >= recCount then exit sub
        
        desc$=dayDesc$(i)+string$(maxDayDesc,32)
        desc$ = left$(desc$,maxDayDesc)
        
        print @(0,ToPixelY(2+x)) dayTime$(i);" ";dayDur$(i);" ";desc$;
        
        i=i+1
    next x

end sub

sub DayCurrentSelection dataIndex as integer, dataLoc as integer, highlight as integer

    desc$=dayDesc$(dataIndex)+string$(maxDayDesc,32)
    desc$ = left$(desc$,maxDayDesc)

    print @(0,ToPixelY(2+dataLoc));
    
    if highlight = 1 then revOn()
    print dayTime$(dataIndex);" ";dayDur$(dataIndex);" ";desc$;
    if highlight = 1 then revOff()

end sub

function InputTime$(x,y) as string
    entry$=""
    
    ' Input data
    do while len(entry$) < 5
        a$=inputString$(1)
        
        if a$ = chr$(BACKSP) then
            if len(entry$) > 0 then
                entry$ = left$(entry$,len(entry$)-1)
            endif
        elseif a$=chr$(ESC) then
            entry$ = ""
            Exit Do
            
        elseif len(entry$) < 2 then
            if INSTR("0123456789",a$) > 0 then
                entry$=entry$+a$
            endif
        elseif len(entry$) = 2 then
            if a$ = ":" then
                entry$=entry$+a$
            endif
        else
            if INSTR("0123456789",a$) > 0 then
                entry$=entry$+a$
            endif
        endif
        
        PRINT @(toPixelX(x),ToPixelY(y)) "HH:MM";
        PRINT @(toPixelX(x),ToPixelY(y)) entry$;
        
        InputTime$ = entry$
    loop

end function

function DayInputDesc$(x,y) as string
    entry$=""
    
    ' Input data
    do while len(entry$) < maxDayDesc
        a$=inputString$(1)
        
        select case a$
            case chr$(BACKSP) 
                if len(entry$) > 0 then
                    entry$ = left$(entry$,len(entry$)-1)
                endif
            
            case chr$(ESC) 
                entry$ = ""
                Exit do

            case chr$(RETURN)
                DayInputDesc$ = entry$
                Exit do

            case else
                entry$=entry$+a$
        end select
        
        PRINT @(toPixelX(x),ToPixelY(y)) string$(maxDayDesc,46);
        PRINT @(toPixelX(x),ToPixelY(y)) entry$;
    loop

    DayInputDesc$ = entry$
end function

' ************************************
' To do routines
' ************************************

sub TodoDisplayFrame
   cls
   Center str$(Month)+"/"+str$(day)+"/"+str$(year),1
   
   print @(0,ToPixelY(23)) "F1=Add  F2=Edit  F3=Remove  ESC=Back"
   print "F4=Tomorrow   F5=Next Week"
end sub

sub TodoDisplayInfo startI as integer
    local i, x, desc$

    if recCount = 0 then exit sub
    
    i = startI
    for x = 0 to 14

        if i >= recCount then exit sub
        
        desc$=todoDesc$(i)+string$(maxTodoDesc,32)
        desc$ = left$(desc$,maxTodoDesc)

        print @(0,ToPixelY(2+x)) desc$;
        
        i=i+1
    next x

end sub

sub TodoCurrentSelection index as integer, loc as integer, highlight as integer

    desc$=todoDesc$(index)+string$(maxTodoDesc,32)
    desc$ = left$(desc$,maxTodoDesc)

    print @(0,ToPixelY(2+dataLoc));
    
    if highlight = 1 then revOn()
    print desc$;
    if highlight = 1 then revOff()

end sub

function TodoInputDesc$(x,y,init$) as string
    entry$=init$

    PRINT @(toPixelX(x),ToPixelY(y)) string$(maxTodoDesc,46);
    PRINT @(toPixelX(x),ToPixelY(y)) entry$;

    ' Input data
    do while len(entry$) < maxTodoDesc
        a$=inputString$(1)
        
        select case a$
            case chr$(BACKSP) 
                if len(entry$) > 0 then
                    entry$ = left$(entry$,len(entry$)-1)
                endif
            
            case chr$(ESC) 
                entry$ = ""
                Exit do

            case chr$(RETURN)
                Exit do

            case else
                entry$=entry$+a$
        end select
        
        PRINT @(toPixelX(x),ToPixelY(y)) string$(maxTodoDesc,46);
        PRINT @(toPixelX(x),ToPixelY(y)) entry$;
    loop
    
    TodoInputDesc$ = entry$
end function

sub ToDoAddOneDay
   ' Add 1 to the day
   tdDay = tdDay +1
   
   ' Did we roll to the next month?
   if tdDay > monthDays(tdMonth) then
       tdDay = 1
       tdMonth = tdMonth+1
   endif
   
   ' Did we roll to the next year?
   if tdMonth > 12 then
       tdMonth = 1
       tdYear = tdYear +1
   endif
end sub

sub ToDoMinusOneDay
   ' Subtract 1 from the day
   tdDay = tdDay -1
   
   ' Did we roll to the previous month?
   if tdDay < 1 then
       tdMonth = tdMonth-1

       ' Did we roll to the next year?
       if tdMonth < 1 then
           tdYear = tdYear -1
           tdMonth = 12
       endif
       
       if tdMonth = 2 then
          tdDay = FebuaryDays(tdYear)
       else
          tdDay = monthDays(tdMonth)
       endif
   endif
   
end sub

' ************************************
' Main program
' ************************************

' Initialization
DAY = VAL(LEFT$(DATE$,2))
MONTH = VAL(MID$(DATE$,4,2))
YEAR = VAL(RIGHT$(DATE$,4))

Calendar1:
    DisplayCalendar

Calendar2:
    Center MonthString(month)+" "+ str$(year),2

    monthDays(2) = FebuaryDays(year)
    
    DisplayDays
    
    Do
        a$=inkey$
        select case asc(a$)
            case ESC
               CLS
               END
               
            case RIGHTARROW
               if day + 1 <= monthDays(month) then
                   day = day +1
                   goto Calendar2
               endif
               
            case LEFTARROW
               if day - 1 > 0 then
                   day = day -1
                   goto Calendar2
               endif
               
            case UPARROW
               if day - 7 > 0 then
                  day = day -7
                  goto Calendar2
              endif
              
            case DOWNARROW
               if day + 7 <= monthDays(month) then
                  day = day +7
                  goto Calendar2
               endif
               
            case Func1
                month = month - 1
                if month < 1 then
                   year = year -1
                   month = 12
                endif
                goto Calendar1
                
            case Func2
                month = month +1
                if month > 12 then
                   year = year +1
                   month = 1
                endif
                goto Calendar1

            case Func3
                goto Any

            case Func4
                goto TodoList

            case Func5
                goto DayDisplay

        end select
    Loop

Any:
    PRINT @(toPixelX(10),ToPixelY(20)) "Date : MM/YYYY";
    anyd$=""
    
    ' Input data
    do while len(anyd$) < 7
        a$=inputString$(1)
        
        if a$ = chr$(BACKSP) then
            if len(anyd$) > 0 then
                anyd$ = left$(anyd$,len(anyd$)-1)
            endif
        elseif a$=chr$(ESC) then
            ' Blank out entry area
            PRINT @(0,ToPixelY(20)) string$(40,32);
            ' Go back to the calendar display
            goto Calendar1

        elseif len(anyd$) < 2 then
            if INSTR("0123456789",a$) > 0 then
                anyd$=anyd$+a$
            endif
        elseif len(anyd$) = 2 then
            if a$ = "/" then
                anyd$=anyd$+a$
            endif
        else
            if INSTR("0123456789",a$) > 0 then
                anyd$=anyd$+a$
            endif
        endif
        
        PRINT @(toPixelX(10),ToPixelY(20)) "Date : MM/YYYY";
        PRINT @(toPixelX(17),ToPixelY(20));anyd$
    loop
    
    newMon = val(left$(anyd$,2))
    if newMon < 1 or newMon > 12 then goto Any
    
    newYear = val(right$(anyd$,4))
    if newYear < 1900 or newYear > 3000 then goto any
    
    ' Set month and year based on input
    month = newMon
    year = newYear
    
    ' Blank out entry area
    PRINT @(0,ToPixelY(20)) string$(40,32);
    
    ' Go back to the calendar display
    goto Calendar1

DayDisplay:
    DayDisplayFrame
    
    ' Display any data
    DayGetDataForToday
    
    topIndex = 0
    dataIndex = 0
    dataLoc = 0
    DayDisplayInfo(topIndex)
    
    ' Highlight today
    if recCount > 0 then DayCurrentSelection(dataIndex, dataLoc, 1)
    
    Do
        a$=inkey$
        select case asc(a$)
            case ESC
               goto Calendar1
                              
            case UPARROW
                if dataIndex - 1 >= 0 then
                    DayCurrentSelection(dataIndex, dataLoc, 0)
                    dataIndex = dataIndex-1

                    if dataLoc-1 < 0 then
                        topIndex = topIndex-1
                        DayDisplayInfo(topIndex)
                    else
                        dataLoc = dataLoc-1
                    endif
                    
                    DayCurrentSelection(dataIndex, dataLoc, 1)
                endif
              
            case DOWNARROW
                if dataIndex + 1 < recCount then
                    DayCurrentSelection(dataIndex, dataLoc, 0)
                    dataIndex = dataIndex+1

                    if dataLoc+1 >= 15 then
                        topIndex = topIndex+1
                        DayDisplayInfo(topIndex)
                    else
                        dataLoc = dataLoc+1
                    endif
                    
                    DayCurrentSelection(dataIndex, dataLoc, 1)
                endif
               
            case Func1
                DayCurrentSelection(dataIndex, dataLoc, 0)
                
                print @(0,ToPixelY(20)) "Time: HH:MM  Duration: HH:MM"
                print @(0,ToPixelY(21)) "Desc: "+string$(maxDayDesc,46)
                
                nt$ = inputTime$(6,20)
                if nt$ <> "" then ndur$ = inputTime$(23,20)
                if ndur$ <> "" then ndes$ = DayInputDesc$(6,21)
                
                if nt$ <> "" and ndur$ <> "" and ndes$ <> "" then
                    rec$=DayPackRecord$(year, Month, day, nt$, ndur$, ndes$)
                    SaveNewRecord(rec$,calendarFile$)
                endif
                
                goto DayDisplay

            case Func2
                DayCurrentSelection(dataIndex, dataLoc, 0)
                
                print @(0,ToPixelY(20)) "Time: HH:MM  Duration: HH:MM"
                print @(0,ToPixelY(21)) "Desc: "+string$(maxDayDesc,46)
                
                nt$ = inputTime$(6,20)
                if nt$ <> "" then ndur$ = inputTime$(23,20)
                if ndur$ <> "" then ndes$ = DayInputDesc$(6,21)
                
                if nt$ <> "" and ndur$ <> "" and ndes$ <> "" then
                    rec$=DayPackRecord$(year, Month, day, nt$, ndur$, ndes$)
                    UpdateRecord rec$, calendarFile$, dayFileLoc(dataIndex)
                endif
                
                goto DayDisplay

            case Func3
                rec$=DayPackRecord$(0, 0, 0, "    ", "    ", "empty")
                
                DayUpdateRecord rec$, calendarFile$, dayFileLoc(dataIndex)
                
                goto DayDisplay
        end select
    Loop

TodoList:
    TodoDisplayFrame
    
    ' Display any data
    TodoGetDataForToday
    
    topIndex = 0
    dataIndex = 0
    dataLoc = 0
    TodoDisplayInfo(topIndex)
    
    ' Highlight today
    if recCount > 0 then
        TodoCurrentSelection(dataIndex, dataLoc, 1)
    endif
    
    Do
        a$=inkey$
        select case asc(a$)
            case ESC
               goto Calendar1
                              
            case UPARROW
                if dataIndex - 1 >= 0 then
                    TodoCurrentSelection(dataIndex, dataLoc, 0)
                    dataIndex = dataIndex-1

                    if dataLoc-1 < 0 then
                        topIndex = topIndex-1
                        TodoDisplayInfo(topIndex)
                    else
                        dataLoc = dataLoc-1
                    endif
                    
                    TodoCurrentSelection(dataIndex, dataLoc, 1)
                endif
              
            case DOWNARROW
                if dataIndex + 1 < recCount then
                    TodoCurrentSelection(dataIndex, dataLoc, 0)
                    dataIndex = dataIndex+1

                    if dataLoc+1 >= 15 then
                        topIndex = topIndex+1
                        TodoDisplayInfo(topIndex)
                    else
                        dataLoc = dataLoc+1
                    endif
                    
                    TodoCurrentSelection(dataIndex, dataLoc, 1)
                endif
                
            case RIGHTARROW
                tdYear = year
                tdMonth = month
                tdDay = day
                
                ToDoAddOneDay
                
                year = tdYear
                month = tdMonth
                day = tdDay

                goto TodoList

            case LEFTARROW
                tdYear = year
                tdMonth = month
                tdDay = day
                
                ToDoMinusOneDay
                
                year = tdYear
                month = tdMonth
                day = tdDay

                goto TodoList
            
            case Func1
                TodoCurrentSelection(dataIndex, dataLoc, 0)
                
                print @(0,ToPixelY(20)) string$(maxTodoDesc,46)
                
                ndes$ = TodoInputDesc$(0,20,"")
                
                if ndes$ <> "" then
                    rec$=TodoPackRecord$(year, Month, day, ndes$)
                    TodoSaveNewRecord(rec$,todoFile$)
                endif
                
                goto TodoList

            case Func2
                TodoCurrentSelection(dataIndex, dataLoc, 0)
                
                print @(0,ToPixelY(20)) string$(maxTodoDesc,46)
                
                ndes$ = TodoInputDesc$(0,20,todoDesc$(dataIndex))
                
                if ndes$ <> "" then
                    rec$=TodoPackRecord$(year, Month, day, ndes$)
                    UpdateRecord rec$, todoFile$, todoFileLoc(dataIndex)
                endif
                
                goto TodoList

            case Func3
                rec$=TodoPackRecord$(0, 0, 0, "empty")
                
                UpdateRecord rec$, todoFile$, todoFileLoc(dataIndex)
                
                goto TodoList

            case Func4
                ' Add 1 day to the record and update it
                tdYear = year
                tdMonth = month
                tdDay = day

                ToDoAddOneDay

                rec$=TodoPackRecord$(tdYear, tdMonth, tdDay, todoDesc$(dataIndex))
                UpdateRecord rec$, todoFile$, todoFileLoc(dataIndex)

                goto TodoList
                
            case Func5
                ' Add 7 days to the record and update it
                tdYear = year
                tdMonth = month
                tdDay = day

                for i = 1 to 7
                    ToDoAddOneDay
                endif
                
                rec$=TodoPackRecord$(tdYear, tdMonth, tdDay, todoDesc$(dataIndex))
                UpdateRecord rec$, todoFile$, todoFileLoc(dataIndex)

                goto TodoList

        end select
    Loop
