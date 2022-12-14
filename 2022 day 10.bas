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
cycles=0
crt_w=40
crt_h=6
dim display(crt_w * crt_h)
dim sig_strs(6)
i=0

cls
open "I",#1,fn$
while not eof(#1)
  @do_fetch_execute ! part 2 executed in here
  @do_part_1
  
  if test  
    print at(1,1);"ctr:";tab(8);ctr using "######"
    print "cycles:";tab(8);cycles using "######"
    print "x_reg:";tab(8);x_reg using "######"
    !pause .5
  else 
    print ".";
  endif
wend

print
print "instructions: ";lineno using "######"
print "cycles:";tab(14);cycles using "######"
print "x_reg:";tab(14); x_reg using "######"

print "sig_strs: "
for x = 0 to 5
  print spc(2);x;":";tab(14);sig_strs(x) using "######"
  add total_str, sig_strs(x)
next

print "total:";tab(14); total_str using "######"

for p = 0 to (dim?(display()) - 1)
  if (p mod 40) = 0
    print
  endif
  if display(p)
    print "#";
  else
    print ".";
  endif
next p
print


close #1
end

procedure do_fetch_execute
  inst$=lineinput$(#1)
  inc lineno
  did_add=FALSE
  @update_display(cycles, x_reg)
  inc cycles !fetch
  if left$(inst$,1) = "a"
    !addx
    operand=val(rightof$(inst$, " "))
    @update_display(cycles, x_reg)
    add x_reg, operand
    inc cycles !execute
    did_add=TRUE
  else if left$(inst$,1) = "n"
    ! noop
    did_add=FALSE
  else
    print "invalid instruction at line ";lineno
  endif
return

procedure do_part_1 ! go back in time and figure out what it should be!
  ctr=abs(cycles-20) mod 40
  if ctr = 0 and not did_add
    !add sig_str to total (or save for later?)
    sig_str=cycles * x_reg
    if i < 6
      sig_strs(i)=sig_str
      inc i
    endif
   else if ctr=0 and did_add
    sig_str=(cycles) * (x_reg - operand)
    if i < 6
      sig_strs(i)=sig_str
      inc i
    endif
   else if ctr=1 and did_add
    !subtract out the previous add and cycle increment
    sig_str=(cycles - 1) * (x_reg - operand)
    if i < 6
      sig_strs(i)=sig_str
      inc i
    endif
  endif
return


procedure update_display(beam_loc, spr_loc)
  
  if abs((beam_loc mod 40) - spr_loc) < 2 
    display(beam_loc)=1
  else
    display(beam_loc)=0
  endif
return