!advent of code 2022 day 2 part 1
!x11-basic on android

table()=[3,6,0;\
         0,3,6;\
         6,0,3]

cls
open "I",#1,"Download/day2input.txt"
while not eof(#1)
  round$=upper$(lineinput$(#1))
  inc line
  op_move=asc(left$(round$,1))-64
  me_move=asc(right$(round$,1))-87
  add score,me_move
  add score,table(op_move-1,me_move-1)
wend
print "predicted score: ";score
print "in ";line; " rounds"
