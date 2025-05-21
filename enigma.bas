' 94 possible characters
' Space (chr$(32)) not allowed.
' So characters 33 to 126 inclusive

' Todo:
' The original Enigma had a plugboard that I didn't implement.
' It sat between the keyboard and the display.  The plugboard
' always translated between the same to characters.
' Ex: A->F, F=>A

' Idea:
' Allow a file to be input/output.

DIM R1(94), R2(94), R3(94)
MinIndex = 0
MaxIndex = 93

' Used for the reflector.  Basically a rot13-like
' translation.
RotValue = Int((MaxIndex-MinIndex+1)/2)

InitRotors

' This is to verify that the rotors and reflector
' work correctly.
print "Unit tests";
TestRotor1
TestRotor2
TestRotor3
TestReflector
print "- Passed"

print
print "Type your message - ESC to end"

do
    a$=inkey$
    
    i=asc(a$)
    if i = 27 then end
    
    if i > 32 and i < 127 then
        i = i - 33
        Rotor1In
        Rotor2In
        Rotor3In
        Reflector
        Rotor3Out
        Rotor2Out
        Rotor1Out

        RotateRotor1
        
        IF RotorCount1 = Notch1 THEN
            RotateRotor2
        endif
        IF RotorCount2 = Notch2 THEN
            RotateRotor3
        endif

        if RotorCount1 > MaxIndex then RotorCount1 = 0
        if RotorCount2 > MaxIndex then RotorCount2 = 0
        
        print chr$(i+33);
    endif
loop

sub Rotor1In
    I = R1(I)
end sub

sub Rotor1Out
    FOR X = MinIndex to MaxIndex
        IF R1(X) = I THEN I=X: exit sub
    NEXT X
end sub

sub TestRotor1
    local x
    for x = MinIndex to MaxIndex
       i = x
       Rotor1In
       Rotor1Out
       if i <> x then
           print "1:";x;" ";i
           end
       endif
end sub

sub RotateRotor1
    local x
    
    RotorCount1=RotorCount1+1
    C = R1(MinIndex)
    FOR X=MinIndex TO MaxIndex-1
        R1(X)=R1(X+1)
    NEXT X
    R1(MaxIndex)=C
end sub

sub Rotor2In
    I = R2(I)
end sub

sub Rotor2Out
    local x
    FOR X = MinIndex to MaxIndex
        IF R2(X) = I THEN I=X: exit sub
    NEXT X
end sub

sub TestRotor2
    local x
    for x = MinIndex to MaxIndex
       i = x
       Rotor2In
       Rotor2Out
       if i <> x then
           print "2:";x;" ";i
           end
       endif
end sub

sub RotateRotor2
    RotorCount2=RotorCount2+1
    C = R2(MinIndex)
    FOR X=MinIndex TO MaxIndex-1
        R2(X)=R2(X+1)
    NEXT X
    R2(MaxIndex)=C
end sub

sub Rotor3In
    I = R3(I)
end sub

sub Rotor3Out
    local x
    FOR X = MinIndex to MaxIndex
        IF R3(X) = I THEN I=X: exit sub
    NEXT X
end sub

sub TestRotor3
    local x
    for x = MinIndex to MaxIndex
       i = x
       Rotor3In
       Rotor3Out
       if i <> x then
           print "3:";x;" ";i
           end
       endif
end sub

sub RotateRotor3
    C = R3(MinIndex)
    FOR X=MinIndex TO MaxIndex-1
        R3(X)=R3(X+1)
    NEXT X
    R3(MaxIndex)=C
end sub

sub Reflector
    P=I
    P=P+RotValue
    IF P >= MaxIndex THEN P=P-MaxIndex-1
    I=P
end sub

sub TestReflector
    local x
    for x = MinIndex to MaxIndex
       i = x
       Reflector
       Reflector
       if i <> x then
           print "R:";x;" ";i
           end
       endif
end sub

Sub InitRotors
    FOR X=MinIndex TO MaxIndex: READ R1(X): NEXT X
    FOR X=MinIndex TO MaxIndex: READ R2(X): NEXT X
    FOR X=MinIndex TO MaxIndex: READ R3(X): NEXT X
    
    ' Where on the rotor we "roll" the next rotor.
    Notch1=10
    Notch2=15
    
    ' Used to keep track of where we are on these
    ' rotors so that we know when to "roll" the nex
    ' rotor.
    RotorCount1=0
    RotorCount2=0

        ' 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
    DATA 85,37,15,14,19, 5, 1,36,81,77,28,83,44,61, 6,30,18,65,52,51
    DATA 59,33,47,68,79,16,34,41,49,69,45,21,32,63,75,10,29,27,66,89
    DATA 20,62, 2,55,80,74,91,58,24,88,12, 0, 9,22,71,57,17, 3,11,39
    DATA 72,73,26,56,43,76, 7,86, 4,42,54,35,67,46,50,78, 8,31,84,38
    DATA 82,93,25,40,13,48,92,87,64,60,90,23,70,53
    DATA 89,36,73,65,26,28, 2,46,33, 9,42,45,30,20,66,51,84,64,71,32
    DATA  1, 3,27,91,50, 8,57,88, 7, 0,83,31,15, 4,59, 6,24,17,40,10
    DATA 86,54,68,61,58,41,78,22,55,90,19,93,79,39,69,49,35,75,34,23
    DATA 80,25,70,47,48,56,82,87,38,11,18,16,60,72,74,21, 5,63,52,76
    DATA 92,62,81,53,85,12,14,67,13,37,29,77,44,43
    DATA 37,63,35,70,52,13,28,41, 7,81,48,29, 4,76,16,59,19,80,36,92
    DATA 31,50,83,47,68,45,89,20,22,11,84,77,72,30,49,86, 3,64,38,71
    DATA 82,69,39, 8,58,74, 1,27,15, 2,90,34,53,46, 6,33,67,60,79,75
    DATA  5,56,44,87,88,21,14,23,10,55,24,32,66,91,42,18,93,12,25,78
    DATA 17, 0,57,61,26, 9,54,51,73,65,85,40,62,43
end sub
