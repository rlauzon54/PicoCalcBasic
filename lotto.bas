sub ExistsInArray
    local a

    for a = 1 to num
        if i(a) = 0 then exit sub
        if i(a) = w then
            w = 0
            exit sub
        end if
    next a    
end sub

randomize timer
cls
print "Lottery number generator"
print

num=0
do while num < 1
    input "How many lottery numbers in each set";num
loop

max = 0
do while max < 2
    input "Each lottery number is from 1 to ";max
loop

dim i(num)
15

for a = 1 to num
    i(a) = 0
next a

' Pick random numbers
for a = 1 to num
    w = 0
    ' Pick a new random number 
    ' not in the array yet
    do while w < 1
        w = int(1+max*rnd)
        ExistsInArray
    loop
    
    ' Add the new number to the array
    i(a) = w        
next a

print "Set:";
for f = 1 to num:
    print i(f);" ";
next f
print
