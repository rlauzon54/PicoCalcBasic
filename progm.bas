sub Beep
   play tone 700, 700
   pause 500
   play stop
   pause 100
end sub

sub Boop
   play tone 400,400
   pause 300
   play stop
   pause 100
end sub

sub EyesRed
    circle px1, py1, psize, 0, 2, rgb(red), rgb(red)
    circle px2, py2, psize, 0, 2, rgb(red), rgb(red)
end sub

sub EyesWhite
    circle px1, py1, psize, 0, 2, rgb(red), rgb(white)
    circle px2, py2, psize, 0, 2, rgb(red), rgb(white)
end sub

cls

px1=147
py1=139

px2=181
py2=148

psize=1

load jpg "progm.jpg",0,0

do
    EyesRed   
    Beep
    EyesWhite
    Boop
    EyesRed   
    Beep
    EyesWhite
    Beep
    EyesRed   
    Boop
    EyesWhite
    Pause 5000
loop

cls
