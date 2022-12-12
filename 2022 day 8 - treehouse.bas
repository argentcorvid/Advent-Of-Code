!advent of code 2022 day 8
!x11-basic on android

day$="8"
folder$="Download/"
name$="input"
!folder$="Documents/"
!name$="test"
fn$=folder$+"day"+day$+name$+".txt"
DEBUG=FALSE

cls
fh=freefile()
open "I",#fh,fn$

while not eof(#fh) ! and ln <100
  line$=lineinput$(#fh)
  tree_cols=len(line$)
  inc tree_rows
  dim tree_map(tree_rows, tree_cols) !beware! this erases the array in some Basics
  @add_line_to_map(line$)
wend
close #fh


!the perimeter trees are on the edge so are visible
num_visible=(2 * tree_cols) + (2 * (tree_rows-2)) 

if not DEBUG
  t1=timer
  start_ = 1 ! brute force walk through each tree, skip the outer perimeter
  for r = start_ to (tree_rows - start_ -1)
    for c = start_ to (tree_cols - start_ -1)
      if @test_visible(r,c)
        inc num_visible
      endif
      if vscore > max_score
        max_score=vscore
        bestscores()=scores()
        best_tree$=@fmtpt$(r,c)
      endif
    next
  next
  print
  t2=timer
  te_1=t2-t1
endif

print dim?(tree_map());" total elements."
print tree_cols; "Wx";tree_rows;"H"

print "visible trees: ";num_visible
print "in ";te_1;" seconds"
print "best tree at: ";best_tree$
print "up","dn","rt","lt"
for i =0 to 3
print bestscores(i),
next
print
print "score: "; max_score

end

procedure add_line_to_map(new$)
  local i, height
  for i=0 to len(new$)-1
    height=val(mid$(new$,i+1,1))
    tree_map(tree_rows - 1,i)=height
  next
return

function test_visible(y,x)
  ! brute force, check every tree in the same column and row
  ! could probable make separat lists of locations of each height
  ! and if we are in a row or column with one higher mark as not visible
  local visible(), my_height, up,dn,lt,rt
  dim visible(4),scores(4)
  arrayfill visible(),FALSE
  my_height=tree_map(y,x)
  print ".";
  !print @fmtpt$(y,x)
  
  for up = y-1 to -1 step -1
    if up = -1
      visible(0)=TRUE
      scores(0)=y
    else if tree_map(up,x) >= my_height
      scores(0)=y-up
      exit for
    endif
  next
  
  for dn = y+1 to tree_rows
    if dn = tree_rows
      visible(1)=TRUE
      scores(1)=tree_rows-y-1
    else if tree_map(dn,x) >= my_height
      scores(1)=dn-y
      exit for
    endif
  next
  
  for rt = x+1 to tree_cols
    if rt = tree_cols
      visible(2)=TRUE
      scores(2)=tree_cols-x-1
    else if tree_map(y,rt) >= my_height
      scores(2)=rt-x
      exit for
    endif
  next
  
  for lt = x-1 to -1 step -1
    if lt < 0
      visible(3)=TRUE
      scores(3)=x
    else if tree_map(y,lt) >= my_height
      scores(3)=x-lt
      exit for
    endif
  next
  vscore=1
  v=FALSE
  for i=0 to 3
    v=v or visible(i)
    mul vscore,scores(i)
  next
  !print v
  !print vscore
  !pause .1
  if v 
    return TRUE
  else
    return FALSE
  endif
endfunction

function fmtpt$(y,x)
  return "("+str$(y+1)+","+str$(x+1)+")"
endfunction