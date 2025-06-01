' Ahl's Simple Benchmark
randomize timer

st=timer
for n = 1 to 100
    a=n
    for i = 1 to 10
        a=sqr(a):
        r=r+rnd
    next i

    for i = 1 to 10
        a=a^2
        r=r+rnd
    next i

    s=s+a
next n
el=timer-st

print "Time (ms): ";el
print "Accuracy: ";abs(1010-s/5)
print "Random: ";abs(1000-r)
