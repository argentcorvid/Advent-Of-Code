!advent of code 2022 day 9	
!x11-basic on android

day$="9"
test=FALSE
if test
	fn$="day"+day$+"test.txt"
else
	fn$="Download/"+"day"+day$+"input.txt"
endif

rope_length=10 ! including head and tail
dim rope(rope_length,2) ! dimension 1 - x,y, dimension 0 - segment
dim tail_seen(500)
arrayfill rope(),0
arrayfill tail_seen(), 0
tail_seen=1 ! origin counts!

cls

if not TEST
  open "I",#1,fn$
    while not eof(#1)
    l$=lineinput$(#1)
    split l$," ",0,direction$,distance$
    add distance, val(distance$)
  wend
  dim tail_seen(distance) ! head moves this much, -> tail moves at most this much
  arrayfill tail_seen(), 0
  seek #1,0
  while not eof(#1) !and s < 10
    l$=lineinput$(#1)
    inc s
    split l$," ",0,direction$,distance$
    distance=val(distance$)
    @move_rope(direction$, distance)
    if mod(s,100)=0
      print ".";
    endif
  wend
  close 1
else
  restore testdata1
  for s = 1 to 8
    read direction$
    read distance
    @move_rope(direction$, distance)
  next
endif

for x=0 to dim?(tail_seen())-1
  if tail_seen(x) <> 0
    inc ts2
    !print x,tail_seen(x)
  endif
next
inc ts2 !account for starting position 

print
print "Rope Length: "; rope_length
print "commands: "; s
print "Tail visited unique: ", tail_seen
print "ts2: ";ts2

end

procedure move_rope(dir$, dist)
  select asc(dir$) ! select must be number!
    case asc("R")
      !print "moving right: ";dist
      !add rope(0,0),dist
      d=1
      a=0
    case asc("L")
      !sub rope(0,0),dist
      !print "moving left: ";dist
      d=-1
      a=0
    case asc("U")
      !add rope(0,1),dist
      !print "moving up: ";dist
      d=1
      a=1
    case asc("D")
      !sub rope(0,1),dist
      !print "moving down: ";dist
      d=-1
      a=1
    default
      print "direction select block failure"
      close #1
      end
  endselect
  for l=1 to dist
    add rope(0,a),d
    @move_followers
  next
  !print "head location x,y: "; rope(0,0),rope(0,1)
return

procedure move_followers
  for segment = 1 to rope_length - 1 
    x_dist_from_prev = rope(segment - 1, 0) - (rope(segment,0))
    y_dist_from_prev = rope(segment - 1, 1) - (rope(segment,1))
    !print "dist x,y:";tab(19); x_dist_from_prev, y_dist_from_prev
    if abs(x_dist_from_prev) > 1 or abs(y_dist_from_prev) > 1
      ! move this seg toward previous seg until touching
      ! sign 0 = 0, but if it's 0 then we are adding 0 anyway
      repeat 
        add rope(segment,0), sgn(x_dist_from_prev) !sgn(0)=0
        add rope(segment,1), sgn(y_dist_from_prev)
        x_dist_from_prev=rope(segment-1,0)-(rope(segment,0))
        y_dist_from_prev=rope(segment-1,1)-(rope(segment,1))
        !print "tail new:";tab(19);rope(segment,0),rope(segment,1);
        if segment = rope_length-1
          @update_tail_seen
        endif
        !print
      until abs(x_dist_from_prev) <= 1 and abs(y_dist_from_prev) <= 1
    endif
  next segment
 return

procedure update_tail_seen
  l_ts=dim?(tail_seen())
  seg=rope_length-1
  key=(rope(seg,0)+500)*1000 + (rope(seg,1)+500)
  idx=key-int(key/(l_ts-1))*(l_ts-1)
  while tail_seen(idx) <> key and tail_seen(idx)<>0
    idx=(idx+1) mod l_ts-1
  wend
  if tail_seen(idx)= 0
    inc tail_seen
    tail_seen(idx)=key
  endif

return

function sgn2(v) ! sgn() is broken in v 1.27, returns positive for 0
  if v=0
    return 0
  else
    return sgn(v)
  endif
endfunction

testdata1:
data  R,4,U,4,L,3,D,1,R,4,D,1,L,5,R,2

!testdata2:
!data R,5,U,8,L,8,D,3,R,17,D,10,L,25,U,20