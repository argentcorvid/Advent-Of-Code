!advent of code 2022 day 5
!x11-basic on android

day$="5"

filename$="day"+day$+"input.txt"
foldername$="Download"
filehandle=freefile()

cls

open "I",#filehandle,foldername$+"/"+filename$
instr_offset=0

num_stacks=@get_stack_count()
dim stacks$(num_stacks)
@read_stacks

!part2 -ln19
arraycopy pt2_stacks$(),stacks$()

seek filehandle,instr_offset

while not eof(#1) ! and lines <2
  cls
  print at(1,1); "part 1 stacks:"
  for s=0 to num_stacks-1
    print s+1;": "+reverse$(stacks$(s))
  next
  print
  print "part 2 stacks: "
  for s=0 to num_stacks-1
    print s+1;": "+reverse$(pt2_stacks$(s))
  next

  instruction$=lineinput$(filehandle)
  inc lines
  number=val(word$(instruction$,2))
  from_stack=val(word$(instruction$,4))-1
  to_stack=val(word$(instruction$,6))-1
  
  print 
  print lines;":";instruction$

  crane$=left$(stacks$(from_stack), number)
  crane2$=left$(pt2_stacks$(from_stack), number)
  print "crane 1: ";crane$
  print "crane 2: ";crane2$
  stacks$(from_stack)=right$(stacks$(from_stack),len(stacks$(from_stack))-number)
  pt2_stacks$(from_stack)=right$(pt2_stacks$(from_stack),len(pt2_stacks$(from_stack))-number)

  pt2_stacks$(to_stack)=crane2$ + pt2_stacks$(to_stack)
  stacks$(to_stack)=reverse$(crane$) + stacks$(to_stack)
  pause .2
wend

cls
print at(1,1);"end stacks 1:"
for s=0 to num_stacks-1
  print s+1;": "+reverse$(stacks$(s))
next
print
print "end stacks 2:"
for s=0 to num_stacks-1
  print s+1;": "+reverse$(pt2_stacks$(s))
next

print
print "top of stacks"
for s=0 to num_stacks-1
  out$=out$+left$(stacks$(s),1)
  out2$=out2$+left$(pt2_stacks$(s),1)
next
print out$
print out2$
f=freefile()
open "o",#f,"Documents/day5out.txt"
print #f, out$
print #f, out2$
close #f
print lines;" instructions processed"

end

function get_stack_count()
  local line$
  repeat
    line$=lineinput$(filehandle)
  until tally(line$, "1")<>0
  instr_offset=loc(filehandle)+1
  return tally(replace$(trim$(line$)," ",","),",")+1
endfunction

procedure read_stacks()
  local crate$,line,s
  seek filehandle,0 
  do 
    line$=lineinput$(filehandle)
    if tally(line$,"1") <> 0
	  return
	endif
	for s=0 to num_stacks-1
	  crate$=mid$(line$,2+4*s,1) !strings are indexed on 1, not 0
	  if crate$ <> " " 
	    stacks$(s)=stacks$(s) + crate$
      endif
	next
  loop
return
