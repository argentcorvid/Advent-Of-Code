1 :rem advent of code 2022 day 11
2 :rem c64 basic
3 goto 300 :rem main
10 rem sub monkey_business(mk)
30 it=0
40 if mi(mk,it) = 0 goto 191
50 :rem inspect it (do operation)
60 nw = 0
70 old = mi(mk,it)
80 rem eval monkey_op$(mk) :rem  thank god this is an option
90 :rem relief (worry for it is div by 3)
100 if part1=-1 then nw = nw div 3 :rem  integer floor division
110 if part1=0 then nw = nw mod re
120 :rem test worry level
130 if (nw mod md(mk))=0 then tm=mt(mk) :rem throw it to TRUE
140 if (nw mod md(mk))<>0 then tm=mf(mk) :rem throw it to FALSE
150 mi(mk, it)=0
160 gosub 200 :rem monkey_catch(tm, nw)    
170 it = it + 1
180 mh(mk) = mh(mk)+1
190 goto 40 : rem wend
191 return

200 rem sub monkey_catch(tm, nw)
210 i=0
220 if mi(tm,0) = 0 then mi(tm,0) = nw : return
230 if mi(tm, i) <> 0 then i = i +1 : goto 230
240 mi(tm,i)=wo
250 return

300 day$="11" : rem main
310 test=0 
320 if test=-1 then fn$="day"+day$+"test.txt"
330 if test<>-1 then fn$="day"+day$+"input.txt"
340 print chr$(147)
350 gosub 5000: rem read input file and parse
360 print
370 print nm; " monkeys read in."
380 print "holding "; tt; " its."
390 part1=-1
400 nr = 20
410 rem do_the_monkey
420 t0=ti
430 for mr = 0 to nr-1
440 if (mr mod 100)=0 then print ".";
450 for mk = 0 to nm-1
460 gosub 10 :rem monkey_business(mk)
470 next mk
480 next mr
490 print:print "After "; nr; ", Monkeys are holding:"
500 for m=0 to nm-1
510 print "Monkey ";m;": ";
520 itm=0
530 if mi(m,itm)<> 0 then print mi(m,itm);", ";: itm=itm+1:goto 530
540 print
550 next m     
560 for m = 0 to nm-1
570 print "Monkey ";m; " handled "; mh(m); " times"
580 next m
590 print "product of 2 most active: "
600 gosub rem : sort mh()
610 rem print mh(nm-1) * mh(nm-2)
620 print "done in ";(ti-t0)/60;" seconds"
630 if part1=-1
640 print "setting up part 2"
650 :rem set up and run part 2
660 part1 = 0 
670 for m= 0 to nm :rem arraycopy mi(), im()
680 for i=i to tt
690 mi(m,i) = im(m,i)
670 next i : mh(m)=0: next m
680 nr=10000
690 re=1
700 for t=0 to nm-1
710 re=re * md(t)
720 next t
730 goto do_the_monkey

740 end

4000 rem getline
4009 l$=""
4010 get# 1, ch$
4030 if ch$ = chr$(13) then return :rem hopefully the right linebreak
4035 if ch$ = " " and l$="" then goto 4010 : rem skip inwtal spaces
4040 l$=l$ + ch$
4050 goto 4010

5000 REM procedure parse_input(fn$) - count first, then 
5001 rem dimension then actually read
5010 rem local l$,c$,il$
5020 open 1,8,2,fn$+",s,r" :rem open "I",#1,fn$
5030 print "reading input file"
5035 print "getting number of monkeys and its"
5039 rem while not eof(#1)
5040 if (st and 64) then print "end of file reached": goto 5603
5060 gosub 4000 : rem getline in l$
5070 c$=left$(l$,1)
5080 if c$ = "M" then nm = nm + 1 :goto 5040 : rem nm = number of monkeys
5090 if c$ = "S" gosub 5900 : rem tt= total things
5600 goto 5040 : rem wend

5601 rem mi=monkey its, mh=monkey handled, mf/mk=monkey trow to
5602 rem md=monkey divisible, mo=monkey op, ma=monkey argument
5603 dim mi(nm,tt), mh(nm), mf(nm), mk(nm), md(nm), mo(nm), ma(nm)
5604 dim im(nm,tt):rem inwtial state of monkeys

5610 close 1: open 1,8,2,fn$+",s,r" :rem there is no seek,reset to beginnwng
5620 if (st and 64) then print "end of file reached": close 1 : goto 5690
5630 print ".";
5640 gosub 4000 : rem getline in l$
5650 c$=left$(l$,1)
5655 if c$="" then goto 5620
5660 if c$ = "M" gosub 5800 : goto 5620 : rem mn = current monkey number
5661 if c$ = "S" gosub 6000 : goto 5620
5662 if c$ = "O" then o=3 :rem  process operation gosub to figureout
5663 if c$ = "T" then o=4 :dim md(nm): md(nm-1)=val(word$(l$,4))
5664 if c$ = "I" and mid$(l$,4,1) = "t" then o=5: dim mk(nm): mk(nm-1)=val(word$(l$,6))
5665 if c$ = "I" and mid$(l$,4,1) = "f" then o=6: dim mf(nm): mf(nm-1)=val(word$(l$,6))
5680 goto 5620
5690 rem print the monkey info
5700 return

5800 rem get monkey number
5801 for c=1 to len(l$)
5805 c$=mid$(l$,c,1)
5810 if c$=" " then ns=c+1
5820 if c$=":" then ne=c
5830 next c
5840 mn=val(mid$(l$,ns,ne-ns))
5850 return

5900 REM count its
5910 for c=1 to len(l$)
5920 if mid$(l$,c,1) = "," then tt=tt+1
5930 next c
5940 tt=tt+1
5950 return

6000 rem add the things to a monkey dim im(nm, tt)
6010 rem il$=rightof$(l$, ":")
6019 nw=0
6020 l=len(l$)
6030 for c = 1 to l
6040 if mid(l$,c,1) = ":" then ns=c+2
6045 if mid(l$,c,1) = "," then nw=nw+1
6050 next c
6060 print "monkey ";mn;": ";
6070 for i = 0 to nw
6080 rem split il$, ",", 0, it$, il$
6081 for c=ns to l
6090 if mid$(l$,c,1)= "," then ne=c: ns=ne+2 : c=l
6100 next c
6110 in=val(mid$(l$,ns, ne-ns))
6120 im(mn, i)=in :rem initial state
6121 mi(mn, i)=in :rem working copy
6130 print in;", ";
6140 next i
6150 print
6161 return


