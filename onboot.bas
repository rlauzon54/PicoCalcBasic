' A little program to run when you first fire
' up the PicoCalc.

' Set date and time
InputDate:
input "Year";year:print
input "Month";month:print
input "Day";day:print

' Validate input
if year < 100 then year = year+2000
if month < 1 or month > 12 then goto InputDate
if day < 1 or day > 21 then goto InputDate

date$=str$(year)+"-"+str$(month)+"-"+str$(day)
print "Set date to ";date$
print

InputTime:
input "Hour";hour:print
input "Minute";minute:print
' I don't bother to set seconds from
' input simply because it won't be
' even close to right

' Validate input
if hour < 1 or hour > 24 then goto InputTime
if minute < 1 or monute > 60 then goto InputTime

time$=str$(hour)+":"+str$(minute)+":30"

print "Set time to ";time$
print

' I mainly work out of Drive B:
' so default over to drive B:
drive "B:"
print "Defaulting to B: drive"
