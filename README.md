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
+ autoexec is a more refined program to run on boot.
+ forecast is a weather "forecasting" program (mostly random number).  But the rules are for the Michigan area.  Change as needed for your weather.  It's surpringly accurate.
+ haunt.bas is Haunted House.  A very simple Zork-like adventure game.  May still be buggy as I haven't gone through all the paths yet.
+ bcalc is a Business Calculator program ported from the TRS-80 Model 100
+ Baseconv is a base 2,8,10,16 conversion program based on the TRS-80 Model 100's HBD program but completely rewritten (i.e. not ported over).
+ Safe is a rewrite of the Commodore PET Safe cracking game.
+ Progm - I Are A Programmer!  Just a cute little program.  Needs progm.jpg
+ enigma - A simple implementation of the German Enigma machine encryption

One problem that we've found is that, sometimes, when using INPUT, the scan codes for keys like the shifts, ctrl and alt, will be put into the string as characters, resulting in problems because there are extra characters in the input string.
Those characters do not show up as you are inputting your response to INPUT.  But will be in the resulting string.

inputString.bas is a function, with an example program, to allow you to input a string and strip out those extra characters that something puts in there.

Links to other repos of PicoCalc programs in BASIC:
+ [PicoCalc-Toys](https://github.com/VanzT/PicoCalc-Toys)
+ [Scripts and utilities for picocalc MMBasic shell](https://github.com/huntergdavis/picocalc)

