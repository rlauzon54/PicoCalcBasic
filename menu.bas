' Max 25 files because 25 lines on the screen
dim file$(25)

' Default all files to empty string
for i = 1 to 25
    file$(i)=""
next i

' Default to Drive B:
Drive "B:"

' Load up the names of the programs on drive b:
f1=0
f$=Dir$("*.bas",FILE)
Do While f$<>""
   f1=f1+1
   file$(f1)=f$
   f$=Dir$()
Loop

' Sort the files descending
sort file$(),,,,(f1+1)

' Reset screen
cls
color rgb(lightgray),rgb(black)

' Display all the files
for i = 1 to 25
    if file$(i)<>"" then print @(0,(i-1)*MM.FONTHEIGHT) file$(i)
next i

' Highlight the first item
i=1
color rgb(black),rgb(lightgray)
print @(0,(i-1)*MM.FONTHEIGHT) file$(i)
color rgb(lightgray),rgb(black)

' Main loop
mainLoop:
   a$=inkey$
   if a$ = "" then goto mainLoop: ' No key pressed.

   ' Arrow down
   if asc(a$)=129 then previ = i: i=i +1
   ' Arrow up
   if asc(a$)=128 then previ = i: i=i -1

   ' Can't go outside of file list
   if i < 1 then i=f1
   if i > f1 then i=1

   ' Enter pressed - select file
   if asc(a$)=10 then goto selectedFile

   ' Move the selected file
   color rgb(lightgray),rgb(black)
   print @(0,(previ-1)*MM.FONTHEIGHT) file$(previ)
   color rgb(black),rgb(lightgray)
   print @(0,(i-1)*MM.FONTHEIGHT) file$(i)

   goto mainLoop

selectedFile:
' Do some screen clean up - needed?
color rgb(lightgray),rgb(black)
cls

' Start the selected program
run file$(i)
