!advent of code 2022 day 3 part 2
! tally() string builtin solution
!x11-basic on android

cls
open "I",#1,"Download/day3input.txt"
while (not eof(#1)) !and line < 25
  sack1$=lineinput$(#1)
  inc line
  sack2$=lineinput$(#1)
  sack3$=lineinput$(#1)
  add line,2

  for first = 1 to len(sack1$)
      first_item$=mid$(sack1$,first)
      t2=(instr(sack2$,first_item$))
      t3=(instr(sack3$,first_item$))
      if t2 <>0 and t3 <>0 then
        print first_item$;" found at: ";first,t2,t3
        add p_sum, @item_to_priority(first_item$)
        exit for
      endif
  next first 
wend

!cls
print "sum of badge priorities: ";p_sum
print line; " sacks"
end

function item_to_priority(item$)
  c=asc(item$)
  p=(c-asc("a"))+1
  if sgn(p) = -1 then
    !uppercase
    add p,58
  endif
  return p
endfunction
