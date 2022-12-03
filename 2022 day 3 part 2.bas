!advent of code 2022 day 3 part 2
! obvious solution
!x11-basic on android

cls
open "I",#1,"Download/day3input.txt"
while (not eof(#1))
  sack1$=lineinput$(#1)
  inc line
  sack2$=lineinput$(#1)
  sack3$=lineinput$(#1)
  add line,2

  for first = 1 to len(sack1$)
    for second = 1 to len(sack2$)
      left_item$=mid$(sack1$,first)
      right_item$=mid$(sack2$,second)
      if left_item$ = right_item$ then
        for third = 1 to len(sack3$)
          third_item$=mid$(sack3$,third)
          if third_item$=left_item$ then
            p=@item_to_priority(third_item$)
            add p_sum,p
            break
          endif
        next third
        if old_p_sum <> p_sum then
          break
        endif
      endif
    next second
    if old_p_sum <> p_sum then
      old_p_sum = p_sum
      break
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
