!advent of code 2022 day 6
!x11-basic on android

day$="6"
fn$="Download/day"+day$+"input.txt"

sample1$="mjqjpqmgbljsphdztnvjfqwrcgsmlb"
sample1_res=7 !offset to last character of marker
sample3$="nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"
sample3_res=10

window_size=4

o = @walk_sample_string(sample3$)
if o = sample3_res
  print "success with sample!"
else
  print "failure with sample"
  print "offset got was: ",o
  print "should be: ",sample3_res
endif

cls
fh=freefile()
open "I",#fh,fn$
window$=input$(#fh,window_size)
print window$;
if not @check_string(window$)
  marker_end=@walk_file(fh)
else
  marker_end=4
endif

print
print "end of first marker at: ";marker_end
print "marker was: ";window$

!part 2 vvvvvvv
seek #fh,0
window_size=14
window$=input$(#fh,window_size)
print window$;
if not @check_string(window$)
  marker_end=@walk_file(fh)
else
  marker_end=4
endif

print
print "end of first marker at: ";marker_end
print "marker was: ";window$

end

function walk_file(handle)
  while not eof(#handle)
    nc$=input$(#handle,1)
    print nc$;
    window$=right$(window$,window_size-1)+nc$
    if @check_string(window$)
      return loc(#1)
    endif
  wend
  print "end of file reached"
  end
endfunction 

function walk_sample_string(string_in$)
  local start,end
  end=len(string_in$)-window_size
  for start=1 to end
    window$=mid$(string_in$,start,window_size)
    if @check_string(window$)
      return start + window_size-1
    else if start = end
      return -1
    endif
  next
endfunction

function check_string(string_in$)
  local i
  for i = 1 to len(string_in$)
    if tally(string_in$,mid$(string_in$,i,1)) > 1
      return FALSE
    endif
  next
  return TRUE
endfunction 
