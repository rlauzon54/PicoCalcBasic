# PicoCalcBasic
A few Olde Tyme BASIC programs converted to the PicoCalc.

These are conversions.  So they mostly maintain all the line numbers.

They have been converted to 40 column display (the default font) except for sst.bas, which uses FONT 7 - a slightly smaller font so I didn't have to convert more of the program.

Some notes:
+ Galaxy 2 is a color version of Galaxy 1.
+ Oregon is based off the 1970 version of Oregon Trail.  The code for shooting still needs work.
+ Slots shows how to use the PRINT @(x,y) to print to a CHARACTER line, column instead of a pixel line, column.
+ SST is the old Super Star Trek.  New command: STA - Status.  This is because I couldn't get all the short range sensor stuff to display.
+ menu is a program that will allow you to select a program to run.  It has examples of how to get a list of files as well as how to detect key strokes and move the selection.
+ onboot is a little program to set the date/time and make the B: drive default.  Since the PicoCalc doesn't have an RTC, you have to set the date/time wheneveryou turn it on.

NOTE:  All of these are still rough.  They are playable, but probably contain bugs and certainly need more work.

