RecordSize = 45
todoFile$="todo.dat"

OPEN todoFile$ FOR RANDOM AS #1

fileLoc = 1
do while fileLoc < LOF(#1)
   seek #1,fileLoc
   rec$=input$(RecordSize,#1)
   print rec$
   fileLoc = fileLoc + recordSize
loop

close #1
