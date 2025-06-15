' Inspired by "Not OK - A Requiem for GW-BASIC"
' by Mark Jones Lorenzo

function ToPixelY(line) as integer
    ToPixelY = line * MM.FONTHEIGHT
end function
function ToPixelX(col) as integer
    ToPixelX = col * MM.FONTWIDTH
end function

sub revOn()
    color rgb(black), rgb(white)
end sub
sub revOff()
    color rgb(white), rgb(black)
end sub

sub Center stuff as string, y as integer
    local x
    x = int((40-len(stuff))/2)
    print @(ToPixelX(x),ToPixelY(y)) stuff
end sub

randomize timer
color rgb(white)

Another:
cls
revOn()
Center "The Decision Maker",0
revOff()

print @(0,ToPixelY(3)) "Ask your question:"
line input d$

c = int(rnd*5)+5
for m = 1 to c
    print @(0,ToPixelY(10));
    
    select case int(rnd*5)+1
        case 1
            color rgb(gold)
            print "Computing....           "
        case 2
            color rgb(orange)
            print "Consulting the stars... "
        case 3
            color rgb(red)
            print "Reading the entrails... "
        case 4
            color rgb(pink)
            print "Talking to the Oracle..."
        case 5
            color rgb(cyan)
            print "Computing....           "
    end select
    color rgb(white)
    
    pause 1000
next m

i = int(1+9*rnd)
print @(0,ToPixelY(10));string$(39,32)
print @(0,ToPixelY(10));
select case i
    case 1
        color rgb(green)
        print "It's certain!"
    case 2
        color rgb(green)
        print "Without any doubt!!"
    case 3
        color rgb(green)
        print "You can rely on it."
    case 4
        color rgb(green)
        print "Your outlook's good."
    case 5
        color rgb(yellow)
        print "Please ask me again later..."
    case 6
        color rgb(red)
        print "Well, don't count on it."
    case 7
        color rgb(red)
        print "My reply is no."
    case 8
        color rgb(red)
        print "Your out look is not so good."
    case 9
        color rgb(red)
        print "It's very, very doubtful."
end select

color rgb(white)

print
input "Another? (Y/N)"; t$
t$=ucase$(t$)
if t$="Y" then goto Another
cls
end
