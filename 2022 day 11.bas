!advent of code 2022 day 11
!x11-basic on android

day$="11"
test=FALSE
if test
	fn$="day"+day$+"test.txt"
else
	fn$="day"+day$+"input.txt"
endif

cls
open "I",#1,fn$
print "reading input file";
while not eof(#1)
  print ".";
  l$=trim$(lineinput$(#1))
  ! first get the number of monkeys
  c$=left$(l$,1)
  if c$ = "M"
    num_monkeys=val(rightof$(l$, " "))+1 ! automatically reads to the first non-number char
  else if c$ = "S"
    !get the number of items
    num_items = tally(l$, ",")+1
    add total_items, num_items
    dim monkeys(num_monkeys, total_items)
    item_list$=rightof$(l$, ":")
    for i = 0 to num_items-1
      split item_list$, ",", 0, item$, item_list$
      item_num=val(item$)
      monkeys(num_monkeys-1, i)=item_num
    next i
  else if c$ = "O"
    ! process operation
    ! just take everything after ":" and eval later?
  else if c$ = "T"
    dim monkey_div_test(num_monkeys)
    monkey_div_test(num_monkeys-1)=val(word$(l$,4))
  else if mid$(l$,4,1) = "t"
    dim monkey_true_act(num_monkeys)
    monkey_true_act(num_monkeys-1)=val(word$(l$,6))
  else if mid$(l$,4,1) = "f"
    dim monkey_false_act(num_monkeys)
    monkey_false_act(num_monkeys-1)=val(word$(l$,6))
  endif
wend
print

print num_monkeys; " monkeys read in."
print "holding "; total_items; " items."


end

