!advent of code 2022 day 3
! obvious solution
!x11-basic on android

cls
open "I",#1,"Download/day3input.txt"
while (not eof(#1))
  sack$=lineinput$(#1)
  inc line
  comp_size=len(sack$)/2
  if frac(comp_size) <> 0 then
    print "compartments not equal size"
    end
  endif
  comp1$=left$(sack$,comp_size)
  comp2$=right$(sack$,comp_size)
  for l = 1 to comp_size
    for r= 1 to comp_size
      left_item$=mid$(comp1$,l)
      right_item$=mid$(comp2$,r)
      if left_item$ = right_item$ then
        p=@item_to_priority(left_item$)
        !print "sack ";line; " dup: ";left_item$;
        !print " priority: ";p
        add p_sum,p
        break
      endif
    next
    if old_p_sum <> p_sum then
      old_p_sum = p_sum
      break
    endif
  next   
wend

!cls
print "sum of duplicate priorities: ";p_sum
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
