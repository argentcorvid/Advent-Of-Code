!advent of code 2022 day 11
!x11-basic on android

day$="11"
test=FALSE 
if test
	fn$="bas/day"+day$+"test.txt"
else
	fn$="bas/day"+day$+"input.txt"
endif
cls

@parse_input(fn$)

print

print num_monkeys; " monkeys read in."
print "holding "; total_items; " items."

arraycopy monkey_items(), init_monkeys() ! keep the original items around to play with later
dim monkey_handled(num_monkeys)
part1=TRUE
relief=3
num_rounds = 20

do_the_monkey:

t0=timer
for monkey_round = 0 to num_rounds-1
  if part1=FALSE and (monkey_round mod 100)=0
    print ".";
  endif
  for monkey_turn = 0 to num_monkeys-1
    @monkey_business(monkey_turn)
  next monkey_turn
next monkey_round
print
print "After "; num_rounds; ", Monkeys are holding:"
for m=0 to num_monkeys-1
  print "Monkey ";m using "##";": ";
  itm=0
  while monkey_items(m,itm)<> 0
    print monkey_items(m,itm);", ";
    inc itm
  wend
  print
next m     

for m = 0 to num_monkeys-1
  print "Monkey ";m; " handled "; monkey_handled(m); " times"
next m
print "product of 2 most active: "
sort monkey_handled()
print monkey_handled(num_monkeys-1) * monkey_handled(num_monkeys-2)
print "done in ";timer-t0 using "####.###";" seconds"

if part1=TRUE
  print "setting up part 2"
  !set up and run part 2
  part1 = FALSE 
  arraycopy monkey_items(), init_monkeys()
  clr monkey_handled()
  num_rounds=10000
  relief=1
  for t=0 to num_monkeys-1
    mul relief,monkey_div_test(t)
  next t
  goto do_the_monkey
endif
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
    if part1=TRUE
      new = new div 3 ! integer floor division
    else
      new = new mod relief
    endif
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
    inc monkey_handled(monkey)
  wend
return

procedure monkey_catch(new_monkey, worry)
  local i
  i=0
  if monkey_items(new_monkey,0) = 0
    monkey_items(new_monkey,0)=worry
    return
  else
    while monkey_items(new_monkey, i) <> 0
      inc i
    wend
    monkey_items(new_monkey,i)=worry
  endif
return

procedure parse_input(filename$)
  local l$,c$,item_list$
  open "I",#1,fn$
  print "reading input file"
  while not eof(#1)
    !print ".";
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
        print "monkey ";num_monkeys-1 using "##";": ";
      for i = 0 to num_items-1
        split item_list$, ",", 0, item$, item_list$
        item_num=val(item$)
        init_monkeys(num_monkeys-1, i)=item_num
        print item_num;", ";
      next i
      print
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