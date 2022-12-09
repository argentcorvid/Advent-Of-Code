!advent of code 2022 day 7
!x11-basic on android

day$="7"
folder$="Download/"
!folder$="Documents/"
fn$=folder$+"day"+day$+"input.txt"

cls
fh=freefile()
open "I",#fh,fn$

! do a first pass through the file to count directories
while not eof(#fh) ! and ln <100
  line$=lineinput$(#fh)
  if left$(line$,1) = "d"
    inc dircount
  endif
wend
 
! initialize our data "structure" #0 will be the root
dim dirnames$(dircount+1), dirsizes(dircount+1)

! return to start of file
seek #fh, 0

while not eof(#fh)
  line$=lineinput$(#fh)
  exit if len(line$)=0
  ! print at(1,1);spc(cols())
  cls
  print at(1,1);line$
  inc ln
  
  ! if the first word in the line can be made into a number, it is a file.
  ! add it to the size for the cwd and parents
  if left$(line$,1) <> "$" and val?(word$(line$,1)) > 0
    size=val(word$(line$,1))
    add total_size, size
    @add_to_parents(size)
  endif
  if word$(line$,2) = "cd"
    newdir$=word$(line$,3)
    if newdir$="/"
      print "go to root, initialize"
      cwd$="/"
      arrayfill dirsizes(),0
      arrayfill dirnames$(),""
      dirnames$(0)=cwd$
    else if newdir$=".."
      print "pop from stack: ";
      t$=left$(cwd$,len(cwd$)-1)
      pop=rinstr(t$,"/")
      print right$(t$,pop)
      cwd$=left$(t$,pop)
    else
      cwd$=cwd$+newdir$+"/"
      print "push to stack: ";newdir$
      @add_path(cwd$)
    endif
  endif  
!pause .1
wend
close #fh

cls
print ln; " lines processed"
print "total size: ";total_size;
print " in ";dircount; " directories"
for i = 0 to dircount
  exit if len(dirnames$(i))=0
  if dirsizes(i) <= 100000
    ! print dirnames$(i);": ";dirsizes(i)
    add report1, dirsizes(i)
  endif
next
print "total for part 1: ";report1

disk_cap =70000000
disk_reqd = 30000000
disk_free = disk_cap - total_size
del_reqd = disk_reqd - disk_free
report2=1e100
print "current free: ";disk_free
print "to free: ";del_reqd

for i =0 to dircount
  ds=dirsizes(i)
  if ds > del_reqd and ds < report2
    report2 = ds
  endif
next

print "total for part 2: ";report2
end

procedure add_path(new_path$)
! find the next enpty entry and add it to the list
  for i=0 to dircount !root counts as #0
    if len(dirnames$(i)) = 0
      print "adding ";new_path$;" at idx ";i
      dirnames$(i)=new_path$
      return
    endif
  next
return

procedure add_to_parents(size)
  for i=0 to dircount
    ldn=len(dirnames$(i))
    if ldn=0
      return ! end of list reached
    else if len(cwd$) >= ldn and left$(cwd$,ldn) = dirnames$(i)
      add dirsizes(i), size
    endif
  next
return
      