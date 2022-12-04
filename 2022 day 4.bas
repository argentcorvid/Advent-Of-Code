!advent of code 2022 day 4
!x11-basic on android

day$="4"
filename$="Download/day"+day$+"input.txt"

cls
open "I",#1,filename$
while not eof(#1) !and lines < 25
  line$=upper$(lineinput$(#1))
  print line$;
  inc lines
  split line$,",",0,range1$,range2$
  split range1$,"-",0,r1_1$,r1_2$
  split range2$,"-",0,r2_1$,r2_2$
  r1_1=val(r1_1$)
  r1_2=val(r1_2$)
  r2_1=val(r2_1$)
  r2_2=val(r2_2$)
  if r1_1 <= r2_1 and r1_2 >= r2_2 then
    inc num
    print " f";
  else if r1_1 >= r2_1 and r1_2 <= r2_2 then
    inc num
    print " f";
  endif

  !alternate part 2 (stumbled on while searching for 1)
  if max(r1_1,r2_1) <= min(r1_2, r2_2)\
    and min(r1_2,r2_2) >= max(r1_1, r2_1) then
      inc num3
      print " m";
  endif
   
  !part 2
  if r1_2 >= r2_1 and r1_1 <= r2_2 then
    inc num2
    print " o";
  endif
print
wend
print "number with fully contained ranges: "; num
print "max/min fully contained: ";num3
print "overlaps: ";num2
print "in ";lines;" lines"
