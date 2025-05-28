' Display main screen

DIM ST$(4), BS(4)
ST$(0)="Binary":BS(0)=2
ST$(1)="Decimal":BS(1)=10
ST$(2)="Octal":BS(2)=8
ST$(3)="Hexadecimal":BS(3)=16

CB=0
CE$=""

' Locations for output items
const IBX=12
const IBY=5
const INX=12
const INY=7
const BX=5
const BY=9
const OX=5
const OY=10
const HX=5
const HY=11
const DX=5
const DY=12
const DBX=0
const DBY=20


MainScreen

' Display the starting input base
SwitchBase

MainLoop:
    a$=inkey$
    if a$="" then goto MainLoop

    select case asc(a$)
        ' 0 to 9
        case 48 to 57
            HandleEntry

        ' A to F
        case 65 to 70
            HandleEntry

        ' a to f
        case 97 to 102
            a$=ucase$(a$): ' Normalize input
            HandleEntry

        ' backspace
        case 8
            HandleEntry

        ' Enter
        case 10, 13
            ProcessInput
        
        ' F1
        case 145
            SwitchBase

        ' F2
        case 146
            HandleEntry

        ' Esc
        case 27
            cls
            end
    end select
   
    goto MainLoop

sub MainScreen
    cls
    color rgb(black),rgb(green)
    print "             Base Conversion            ";
    color rgb(green),rgb(black)
    
    print @(0,ToPixelY(5)) "Input Base:"
    print @(0,ToPixelY(7)) "Input:"
    
    print @(0,ToPixelY(9))  "Bin:"
    print @(0,ToPixelY(10)) "Oct:"
    print @(0,ToPixelY(11)) "Hex:"
    print @(0,ToPixelY(12)) "Dec:"
    
    print @(0,ToPixelY(15)) "F1=Change Input Base  F2=Clear Entry"
    print "ESC=Exit"
end sub

function ToDecimal(ce$, base) as Integer
    local val=0, ln=len(ce$),cc$
    for i = 1 to ln
        cc$=mid$(ce$,i,1)
        val = val*base + instr("0123456789ABCDEF",cc$)-1
    next i
    
    ToDecimal = val
end function

function ToBase(dec,base) as string
    local val$="",r=0, tmp
    tmp = dec
    do while tmp > 0
        r = tmp-int(tmp/base)*base
        tmp=int(tmp/base)
        val$ = mid$("0123456789ABCDEF",r+1,1)+val$
    loop
    
    ToBase=val$
end function

sub ProcessInput
    ' Convert input to decimal
    if CB=1 then
        dec=val(ce$)
    else
        dec=ToDecimal(ce$,bs(cb))
    end if

    ' Convert to other bases
    if CB=0 then
       bin$=ce$
    else
       bin$=ToBase(dec,bs(0))
    end if
    if CB=2 then
       oct$=ce$
    else
       oct$=ToBase(dec,bs(2))
    end if
    if CB=3 then
       hex$=ce$
    else
       hex$=ToBase(dec,bs(3))
    end if

    print @(ToPixelX(BX),ToPixelY(BY)) string$(40-inx,32);
    print @(ToPixelX(BX),ToPixelY(BY)) bin$
    print @(ToPixelX(OX),ToPixelY(OY)) string$(40-inx,32);
    print @(ToPixelX(OX),ToPixelY(OY)) oct$
    print @(ToPixelX(HX),ToPixelY(HY)) string$(40-inx,32);
    print @(ToPixelX(HX),ToPixelY(HY)) hex$
    print @(ToPixelX(DX),ToPixelY(DY)) string$(40-inx,32);
    print @(ToPixelX(DX),ToPixelY(DY)) str$(dec)

end sub

sub SwitchBase
    CB=CB+1
    if CB > 3 then CB=0
    ' Blank out current entry
    print @(ToPixelX(IBX),ToPixelY(IBY)) "           "
    color rgb(black),rgb(green)
    print @(ToPixelX(IBX),ToPixelY(IBY)) st$(cb);
    color rgb(green),rgb(black)
    
    ' If we switch the base, we should blank out the entry
    print @(ToPixelX(INX),ToPixelY(INY)) string$(40-inx,32);
    ce$=""
end sub

' Depending on the select input base
' only certain values will be allowed
function ValidEntry(cb,a$) as integer
    select case CB
        case 0
           ValidEntry = instr("01",a$)

        case 1
           ValidEntry = instr("0123456789",a$)

        case 2
           ValidEntry = instr("01234567",a$)

        case 3
           ValidEntry = instr("0123456789ABCDEF",a$)

        case else
           ValidEntry = 0
    end select
end function

sub HandleEntry
   select case asc(a$)
       case 8
           if len(ce$) > 0 then
               ce$=left$(ce$,len(ce$)-1)
           end if
 
       case 146
           ce$=""
		   print @(ToPixelX(INX),ToPixelY(INY)) string$(40-INX,32);
            
       case else
           if ValidEntry(cb,a$) > 0 then
               ce$=ce$+a$
           end if
   end select

   ' Print the current entry
   ' Plus an extra space (to blank out any extra char)
   print @(ToPixelX(INX),ToPixelY(INY)) ce$;" "
end sub

function ToPixelY(line) as integer
    ToPixelY = line * MM.FONTHEIGHT
end function

function ToPixelX(col) as integer
    ToPixelX = col * MM.FONTWIDTH
end function

