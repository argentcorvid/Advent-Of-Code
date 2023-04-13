!advent of code 2022 day 12
!x11-basic on android

day$="12"

tf$="day"+day$+"test.txt"
ff$="day"+day$+"input.txt"

max_w=200
max_l=50
max_q=int(sqr(max_w*max_w+max_l*max_l))

dim curr_position(2), start_point(2), end_point(2)
dim queue%(max_q,2)
dim neigbors(4,2)
for x=0 to 3
  for y=0 to 1  
    read neigbors(x,y)
  next
next

dim grid_height%(max_w,max_l),grid_distance%(max_w,max_l) ! width,length  
for y=0 to max_l-1
  for x=0 to max_w-1
    grid_distance%(x,y)=-1
  next
next

cls
prompt:
input "1 for test, 2 for full, x to quit: ",a$
if a$<>"1" and a$<>"2" and a$<>"x"
  goto prompt
endif

if a$="x"
  end
else if a$="1"
  @read_input(tf$)
else if a$="2"
  @read_input(ff$) 
endif

print
@find_distances
s_to_e=grid_distance%(start_point(0),start_point(1))
print "Distance from 'S' to 'E': "; s_to_e
min_d=s_to_e
for y=0 to max_l-1
  d=grid_distance%(0,y)
  if d>0 and d<min_d
    min_d=grid_distance%(0,y)
    print min_d
  endif
next

print "min distance to E: "; min_d
end

data 0,-1,1,0,0,1,-1,0

procedure read_input(file_name$)
  open "I",#1,file_name$
  print "reading input file"
  while not eof(#1)
    l$=trim$(lineinput$(#1))
    print ".";
    if not grid_length
      grid_width=len(l$)
    endif
    !if grid_width>max_w 
    inc grid_length
    for w=1 to grid_width
      height=asc(mid$(l$,w,1))-96
      if height=-13
        start_point(0)=w-1
        start_point(1)=grid_length-1
        height=1
      endif
      if height=-27
        end_point(0)=w-1
        end_point(1)=grid_length-1
        height=26
      endif
      grid_height%(w-1,grid_length-1)=height
      !print height using "00 ";
    next w
    !print
  wend
  grid_distance%(end_point(0),end_point(1))=0

  print
  print "grid size is ";grid_width;"cx"; grid_length;"r"
  print "Start point at ";start_point(0);",";start_point(1)
  print "End point at ";end_point(0);",";end_point(1)
  close #1
return

procedure find_distances
  queue%(0,0)=end_point(0)
  queue%(0,1)=end_point(1) ! add end point, walk backwards
  qh=0 ! head index in queue
  qt=1 ! tail index in queue
  ql=1 ! queue length
  d=0 ! distance
  print "finding distances to end point"
  while ql > 0 !queue isnt empty
    !print ".";
    print at(9,0);"queue length: ";ql
    curr_position(0)=queue%(qh,0)
    curr_position(1)=queue%(qh,1) !get next location coords from queue
    inc qh                        !move queue head index
    if qh=max_q
      qh=0         !wrap queue head if needed
    endif
    dec ql                        !reduce queue length
    d=grid_distance%(curr_position(0),curr_position(1))
    !print "checking ";curr_position(0);",";curr_position(1);" ht: ";grid_height%(curr_position(0),curr_position(1))
    for n=0 to 3                  !get neigbors of current location
      nx=curr_position(0)+neigbors(n,0)
      ny=curr_position(1)+neigbors(n,1)
      ib = (nx < grid_width and nx >=0 and ny < grid_length and ny >=0)
      if not ib                   !in bounds
        goto skip
      endif
      !print tab(3);"neighbor: ";nx;",";ny;" ht: ";grid_height%(nx,ny);
      
      ht = (grid_height%(curr_position(0),curr_position(1)) - grid_height%(nx,ny) <= 1)
      nv = (grid_distance%(nx,ny)=-1)
      if ht and nv                !and add to queue if reachable (h<=h+1)
        queue%(qt,0)=nx
        queue%(qt,1)=ny
        inc qt
        if qt=max_q
          qt=0     !wrap queue tail if needed
        endif
        inc ql
        grid_distance%(nx,ny)=d+1   !set each neigbors distance to d
        !print ": added, distance: ";d+1
      else
        !print ": skipped"
      endif
skip:
    next n
  wend
  print "done"
  !for y=0 to grid_length-1
  !for x=0 to grid_width-1
  !print grid_distance%(x,y) using "00 ";
  !next
  !print
  !next
return