:rem advent of code 2022 day 11
:rem c64 basic

day$="11"
test=0 
if test
	fn$="day"+day$+"test.txt"
else
	fn$="day"+day$+"input.txt"
endif
print chr$(147)

gosub 5000

print

print nm; " monkeys read in."
print "holding "; tt; " items."

gosub arraycopy mi(), im() :rem  keep the original items around to play with later
dim mh(nm)
part1=-1
relief=3
nr = 20

do_the_monkey:

t0=ti
for mr = 0 to nr-1
  if part1=0 and (mr mod 100)=0
    print ".";
  endif
  for mt = 0 to nm-1
    gosub monkey_business(mt)
  next mt
next mr
print
print "After "; nr; ", Monkeys are holding:"
for m=0 to nm-1
  print "Monkey ";m using "##";": ";
  itm=0
  while mi(m,itm)<> 0
    print mi(m,itm);", ";
    inc itm
  wend
  print
next m     

for m = 0 to nm-1
  print "Monkey ";m; " handled "; mh(m); " times"
next m
print "product of 2 most active: "
gosub sort mh()
print mh(nm-1) * mh(nm-2)
print "done in ";ti-t0 using "####.###";" seconds"

if part1=-1
  print "setting up part 2"
  :rem set up and run part 2
  part1 = 0 
  gosub arraycopy mi(), im()
  rem clr mh()
  nr=10000
  relief=1
  for t=0 to nm-1
    relief=relief * md(t)
  next t
  goto do_the_monkey
endif
end


procedure monkey_business(mk)
  rem local item,new,old,to_monkey
  item=0
  while mi(mk,item) <> 0
    :rem inspect item (do operation)
    new = 0
    old = mi(mk,item)
    eval monkey_op$(mk) :rem  thank god this is an option
    :rem relief (worry for item is div by 3)
    if part1=-1
      new = new div 3 :rem  integer floor division
    else
      new = new mod relief
    endif
    :rem test worry level
    if (new mod md(mk))=0
      :rem throw item to TRUE   
      to_monkey=mt(mk)
    else 
      :rem throw item to FALSE
      to_monkey=mf(mk)
    endif
    :rem throw
    mi(mk, item)=0
    gosub monkey_catch(to_monkey, new)    
    item = item + 1
    mh(mk) = mh(mk)+1
  wend
return

procedure monkey_catch(nw, wo)
  local i
  i=0
  if mi(nw,0) = 0
    mi(nw,0)=wo
    return
  else
    while mi(nw, i) <> 0
      inc i
    wend
    mi(nw,i)=wo
  endif
return

4000 rem getline
4009 l$=""
4010 get# 1, ch$
4030 if ch$ = chr$(13) then return :rem hopefully this is the right linebreak
4035 if ch$ = " " and l$="" then goto 4010 : rem skip inital spaces
4040 l$=l$ + ch$
4050 goto 4010

5000 REM procedure parse_input(fn$)
5010 rem local l$,c$,il$
5020 open 1,8,2,fn$+",s,r" :rem open "I",#1,fn$
5030 print "reading input file"
5040 if (st and 64) then print "end of file reached" : close 1:return :rem while not eof(#1)
5050 print ".";
5060 gosub 4000 : rem getline in l$
5070 c$=left$(l$,1)
5080 if c$ = "M" then o=1 : rem nm = number of monkeys, mn= current monkey number
5090 if c$ = "S" then o=2 : rem ni = the number of items for the monkey, tt= total
5190 if c$ = "O" then o=3 :rem  process operation gosub to figureout
5200 if c$ = "T" then o=4 :dim md(nm): md(nm-1)=val(word$(l$,4))
5210 if c$ = "I" and mid$(l$,4,1) = "t" then o=5: dim mt(nm): mt(nm-1)=val(word$(l$,6))
5230 if c$ = "I" and mid$(l$,4,1) = "f" then o=6: dim mf(nm): mf(nm-1)=val(word$(l$,6))
5240 on o gosub 5800,5900
5600 goto 5040

5800 for c=1 to len(l$)
5805 c$=mid$(l$,c,1)
5810 if c$=" " then ns=c+1
5820 if c$=":" then ne=c
5830 next c
5820 mn=val(mid$(l$,ns,ne-ns))
5830 nm=nm+1
5840 return

5900 ni = tally(l$, ",")+1 
59   add tt, ni
59   : rem dim im(nm, tt)
il$=rightof$(l$, ":")
print "monkey ";nm-1;": ";
for i = 0 to ni-1
split il$, ",", 0, item$, il$
item_num=val(item$)
im(nm-1, i)=item_num
print item_num;", ";
next i
print


