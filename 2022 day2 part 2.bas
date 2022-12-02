!advent of code 2022 day 2 part 1
!x11-basic on android

cls
open "I",#1,"Download/day2input.txt"
while not eof(#1)
  round$=upper$(lineinput$(#1))
  inc line
  op_move=asc(left$(round$,1))-64
  desired=asc(right$(round$,1))-87
  
  code=10*desired+op_move
  select code
    case 12,21,33
      me_move= 1
    case 13,22,31
      me_move= 2
    case 11,23,32
      me_move= 3
    default
      ? "something is wrong"
      end
  endselect

  add score,me_move
  
  select desired
    case 3
      !win
      add score,6
    case 1
      !lose do nothing
    case 2
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
end
