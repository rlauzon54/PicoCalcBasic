# Executive Calendar for the PicoCalc

Assumes that you've set the date/time when you boot up the PicoCalc (See the autoexec.bas or onboot.bas programs).

I started out by trying to port the TRS-80 Model 100 Executive Calendar to the PicoCalc.  But that proved to be of poor value.  So I did a complete re-write of the software using the original Executive Calendar as a model.

Features:
1. Monthly calendar
1. Jump to month/year
1. Day schedule
1. To do list

Not implemented:
1. Week view.  The original had a week view, but I didn't see the value in it.  All it did was list the days across the top, hours down the side, and put an asterix there if you had an event at that time.

Not done yet:
1. Day events are not sorted by time.  It's by order in the data file.
1. There are probably bugs in edge conditions.
