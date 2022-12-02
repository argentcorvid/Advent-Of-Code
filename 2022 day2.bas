!advent of code 2022 day 2 part 1
!x11-basic on android

cls
open "I",#1,"Download/day2input.txt"
while not eof(#1)
  round$=upper$(lineinput$(#1))
  inc line
  op_move=asc(left$(round$,1))-64
  me_move=asc(right$(round$,1))-87
  add score,me_move
  
  result=me_move+op_move*10
  select result
    case 12,23,31
      !win
      add score,6
    case 13,21,32
      !lose do nothing
    case 11,22,33
      !draw
      add score,3
    default
      ? "weird round detected"
      ? "line#: ";line
      ? "result: ";result
      end
  endselect
wend
print "predicted score: ";score
print "in ";line; " rounds"
