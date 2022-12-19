!advent of code 2022 day 9	
!x11-basic on android

day$="10"
test=FALSE
if test
	fn$="day"+day$+"test.txt"
else
	fn$="day"+day$+"input.txt"
endif

x_reg=1
cycles_complete=0
crt_w=40
crt_h=6
dim display(crt_w * crt_h)
dim sig_strs(6)
i=0

cls
open "I",#1,fn$
while not eof(#1)
  @do_fetch_execute
  
  if test  
    print at(1,1);"ctr:";tab(8);ctr using "######"
    print "cycles:";tab(8);cycles_complete using "######"
    print "x_reg:";tab(8);x_reg using "######"
    !pause .5
  else 
    print ".";
  endif
wend

print
print "instructions: ";lineno using "######"
print "cycles:";tab(14);cycles_complete using "######"
print "x_reg:";tab(14); x_reg using "######"

print "sig_strs: "
for x = 0 to 5
  print spc(2);x;":";tab(14);sig_strs(x) using "######"
  add total_str, sig_strs(x)
next

print "total:";tab(14); total_str using "######"

@put_crt_text

close #1
end

procedure do_fetch_execute
  inst$=lineinput$(#1)
  inc lineno
  ! "read instruction" cycle start
  i$=left$(inst$,1)
  operand=val(rightof$(inst$, " "))
  @update_display(cycles_complete, x_reg)
  inc cycles_complete 
  @update_signal_str
  ! "read instruction" cycle done
  if i$= "a"
    ! "add" cycle start
    @update_display(cycles_complete, x_reg)
    inc cycles_complete 
    @update_signal_str
    add x_reg, operand
    ! "add" cycle done
  endif
  !start of next cycle
return

procedure update_signal_str
  if (cycles_complete mod crt_w) = 20 and i < 6
    ss =cycles_complete * x_reg
    sig_strs(i) = ss
    inc i
  endif
 return

procedure update_display(beam_loc, spr_loc)
  if abs((beam_loc mod crt_w) - spr_loc) < 2
    display(beam_loc)=1
  else
    display(beam_loc)=0
  endif
return

procedure put_crt_text
  for p = 0 to (dim?(display()) - 1)
    if (p mod crt_w) = 0
      print
    endif
    if display(p)
      print chr$(178); ! ▓
    else
      print chr$(176); ! ░
    endif
  next p
  print
return