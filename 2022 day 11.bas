!advent of code 2022 day 11
!x11-basic on android

day$="11"
test=TRUE
if test
	fn$="day"+day$+"test.txt"
else
	fn$="day"+day$+"input.txt"
endif

@parse_input(fn$)

cls
print

print num_monkeys; " monkeys read in."
print "holding "; total_items; " items."

arraycopy monkey_items(), init_monkeys() ! keep the original items around to play with later

num_rounds = 20

for monkey_round = 0 to num_rounds-1
  for monkey_turn = 0 to num_monkeys-1
    @monkey_business(monkey_turn)
  next monkey_turn
next monkey_round

print "After "; num_rounds; ", Monkeys are holding:"
for m=0 to num_monkeys-1
  print "Monkey ";m using "##";": ";
  for itm=0 to num_items-1
    if monkey_items(m,itm) = 0
      exit for
    else
      print monkey_items(m,itm);", ";
    endif
  next itm
  print
next m     

end

procedure monkey_business(monkey)
  local item,new,old,to_monkey
  item=0
  while monkey_items(monkey,item) <> 0
    !inspect item (do operation)
    new = 0
    old = monkey_items(monkey,item)
    eval monkey_op$(monkey) ! thank god this is an option
    !relief (worry for item is div by 3)
    new = new div 3 ! integer floor division
    !test worry level
    if (new mod monkey_div_test(monkey))=0
      !throw item to true
      to_monkey=monkey_true_act(monkey)
    else 
      !throw item to false
      to_monkey=monkey_false_act(monkey)
    endif
    !throw
    monkey_items(monkey, item)=0
    @monkey_catch(to_monkey, new)    
    inc item
  wend
  !update number of items inspected
return

procedure monkey_catch(new_monkey, worry)
  local i
  i=0
  while monkey_items(new_monkey, i) <> 0
    inc i
  wend
  monkey_items(new_monkey,i)=worry
return

procedure parse_input(filename$)
  local l$,c$,item_list$,item_num
  open "I",#1,fn$
  print "reading input file";
  while not eof(#1)
    print ".";
    l$=trim$(lineinput$(#1))
    c$=left$(l$,1)
    if c$ = "M"
      ! first get the number of monkeys
      num_monkeys=val(rightof$(l$, " "))+1 ! automatically reads to the first non-number char
    else if c$ = "S"
      !get the number of items
      num_items = tally(l$, ",")+1
      add total_items, num_items
      dim init_monkeys(num_monkeys, total_items)
      item_list$=rightof$(l$, ":")
      for i = 0 to num_items-1
        split item_list$, ",", 0, item$, item_list$
        item_num=val(item$)
        init_monkeys(num_monkeys-1, i)=item_num
      next i
    else if c$ = "O"
      ! process operation
      ! just take everything after ":" and eval later?
      dim monkey_op$(num_monkeys)
      monkey_op$(num_monkeys-1) = trim$(rightof$(l$, ":"))
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
  close #1
return