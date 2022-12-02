!advent of code 2022 day 2 part 2
!x11-basic on android

table1()=[3,1,2;\
          1,2,3;\
          2,3,1]
table2()=[0,3,6]

cls
open "I",#1,"Download/day2input.txt"
while not eof(#1)
  round$=upper$(lineinput$(#1))
  inc line
  op_move=asc(left$(round$,1))-64
  desired=asc(right$(round$,1))-87
  

  me_move=table1(desired-1,op_move-1)
  add score,me_move
  add score,table2(desired-1)
wend
print "predicted score: ";score
print "in ";line; " rounds"
end
