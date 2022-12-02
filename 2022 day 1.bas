!advent of code 2022 day1 
!X11 Basic on Android

dim top_3(3,2)
en=1

open "I",#1,"Download/day1input.txt"
cls
WHILE NOT EOF(#1) 
  LINEINPUT #1,a$
  if a$ ="" then
    print "elf # ";en;" cals ";cals
    if cals>max_cals then
      print "new max!"
      max_cals=cals
      max_elf=en
    endif
    @rank_elf(en, cals)
    inc en
    cals=0
  else
    cals=cals + val(a$)
  endif
WEND
cls
print "the elf with the most calories was elf# ";max_elf
print "with ";max_cals;" calories"

!part 2 vvvv
print
print "top 3 elfs"
for i=0 to 2
  print "#";top_3(i,0);": ";top_3(i,1)
  total=total + top_3(i,1)
next
print "total of top 3: ";total
CLOSE #1
end

procedure rank_elf(elf, cals)
  for e=0 to 2
    if cals > top_3(e,1) then
      if e < 2 then
       top_3(2,0) = top_3(1,0)
       top_3(2,1) = top_3(1,1)
      endif
      if e < 1 then
        top_3(1,0) = top_3(0,0)
        top_3(1,1) = top_3(0,1)
      endif
      top_3(e,0)=elf
      top_3(e,1)=cals
      exit for
    endif
  next
return
