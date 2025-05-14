'123456789012345678901234567890123456789012345
'YYYYMMDDHH:MMHH:MM---------------------------

RecordSize = 45
maxDesc = 27

sub unpackRecord record$ as string
    y =val(left$(record$,4))
    m=val(mid$(record$,5,2))
    d  =val(mid$(record$,7,2))
    tm$=mid$(record$,9,5)
    dur$ =mid$(record$,14,5)
    desc$=right$(record$,maxDesc)    
end sub

function packRecord$(y,m,d,tm$,dur$,desc$) as string
     local ys$, ms$, ds$, temp$
     ys$ = right$("0000"+str$(y),4)
     ms$ = right$("00"+str$(m),2)
     ds$ = right$("00"+str$(d),2)
     
     temp$=left$(ys$+ms$+ds$+tm$+dur$+desc$+string$(maxDesc,32),RecordSize)
     
     packRecord$ = temp$
end function

filen$="calendr.dat"
fileLoc = 1

OPEN filen$ FOR RANDOM AS #1
do
   a$=inkey$
   select case a$
       case chr$(27)
           exit do
           
       case "a"
           input "Year?",y
           input "Month?",m
           input "Day?",d
           input "Time?",tm$
           input "Duration?",dur$
           input "Desc?",desc$
           
           rec$=packRecord$(y,m,d,tm$,dur$,desc$)
           
           print "=";rec$;"="

           SEEK #1, LOF(#1) + 1
           PRINT #1,rec$; : ' semi-colon important or it will add extra characters
           print lof(#1)

       case "d"
           fileLoc = 1
           do while fileLoc < LOF(#1)
               seek #1,fileLoc
               rec$=input$(RecordSize,#1)
               print rec$
               fileLoc = fileLoc + recordSize
           loop

       case "t"
           on error skip 1
           seek #1,1
           fileLoc = 1
           print "Moved to top of file"
           
       case "r"
           rec$=input$(RecordSize,#1)
           if len(rec$) = 0 then
               print "No record"
           else
               print "=";rec$;"="
               unpackRecord(rec$)

               print "Year",y
               print "Month",m
               print "Day",d
               print "Time",tm$
               print "Duration",dur$
               print "Desc",desc$
           endif
           
       case "n"
            print "lof=";lof(#1)
            if fileLoc+RecordSize < LOF(#1) then
                fileLoc = fileLoc+RecordSize
                seek #1, fileLoc
            else
                print "end of file"
            endif
            
        case "p"
            print "lof=";lof(#1)
            if fileLoc-RecordSize > 0 then
                fileLoc = fileLoc-RecordSize
                seek #1, fileLoc
            else
                print "top of file"
            endif

   end select
loop

close #1
