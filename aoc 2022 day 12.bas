#RetroDevStudio.MetaData.BASIC:2049,BASIC V2
10 PRINT "ADVENT OF CODE 2022, DAY 12"
11 PRINT "ALLOCATING"
20 MX=160-1:MY=50-1:REM MAX X, Y
30 GX=0:GY=0:REM GRID ACTUAL SIZE
40 D1=0:D2=0:D=0:REM DISTANCES
50 QH=0:QT=0:QL=0:REM QUEUE
51 MQ=2*INT(SQR(((MX*.5)2)+(MY2)))
60 NX=0:NY=0:W=0:N=0:X=0:Y=0:H=0:NH=0
70 IB=0:HT=0:NV=0:REM CONDITIONS
71 REM HM=49152
80 DIMGD%(MX,MY):REM NEGATIVE FOR NOT VISITED
85 DIMGH%(MX,MY)
90 DIMSP(2),EP(2),CP(2),NB(4,2)
95 DIMQ%(MQ,2)
100 FORX=0TO3:FORY=0TO1:READNB(X,Y):NEXT:NEXT
101 FORY=0TOMY-1:FORX=0TOMX-1:GD%(X,Y)=-1:GH%(X,Y)=-1:NEXT:NEXT
110 TF$="DAY12TEST":FF$="DAY12INPUT"
200 PRINT"{CLR}";FRE(0);"BYTES FREE"
210 INPUT"1 FOR TEST,2 FOR FULL,X TO QUIT";A$
220 IF A$<>"1" AND A$<>"2" AND A$<>"X" GOTO 210
230 IF A$="1" THEN F$=TF$:GOSUB 5000
240 IF A$="2" THEN F$=FF$:GOSUB 5000
250 IF A$="X" THEN END
260 PRINT
261 STOP
270 GOSUB 4000
280 D1=GD%(SP(0),SP(1))
290 PRINT "DISTANCE FROM 'S' TO 'E': ";D1
300 D2=D1
400 FOR Y=0 TO GY-1
410 D=GD%(0,Y)
420 IF D>0 AND D<D2 THEN D2=D
430 NEXT
440 PRINT "PART 2 MIN DIST TO E: ";D2
450 END

4000 REM FIND DISTANCES FROM END POINT
4010 Q%(0,0)=EP(0):Q%(0,1)=EP(1)
4020 QH=0:QT=1:QL=1:D=0
4030 PRINT "FINDING DISTANCES TO END POINT"
4040 REM WHILE QL>0
4060 CP(0)=Q%(QH,0):CP(1)=Q%(QH,1)
4070 QH=QH+1:IF QH=MQ THEN QH=0
4080 QL=QL-1
4090 D=GD%(CP(0),CP(1))
4091 PRINT"POINT";CP(0);",";CP(1);"D";GD%(CP(0),CP(1))
4100 FOR N=0 TO 3
4110 NX=CP(0)+NB(N,0):NY=CP(1)+NB(N,1)

4112 PRINT TAB(3);"N:";NX;",";NY;" HT ";NH;
4120 IB=(NX<GX AND NX>=0 AND NY<GY AND NY>=0)
4130 IF NOT IB THEN PRINT "SKIP IB":GOTO 4210
4131 NH=GH%(NX,NY):H=GH%(CP(0),CP(0))

4140 HT=(H-NH<=1)
4150 NV=(GD%(NX,NY)=-1)

4160 IF NOT (HT AND NV) THEN PRINT "SKIP HT/NV": GOTO 4210
4170 Q%(QT,0)=NX:Q%(QT,1)=NY
4180 QT=QT+1:IF QT=MQ THEN QT=0
4190 QL=QL+1
4200 GD%(NX,NY)=D+1
4205 PRINT"ADD, D:";D+1;"QL:";QL
4210 NEXT N:REM SKIP
4215 IF QL > 0 GOTO 4040 :REM WHILE QL>0

4220 REM END
4230 PRINT:PRINT"DONE"
4240 RETURN

5000 REM READ FILE - NEED TO TRANSPOSE TO FIT EACH LINE
5001 OPEN 15,8,15
5010 OPEN 2,8,2,F$+",S,R"
5011 D=ST:INPUT#15,E,E$
5012 IF E<>0 OR DAND64<>64 THEN PRINTE$;E;D;" ABORTING":CLOSE2:CLOSE15:END
5020 PRINT "READING INPUT FILE"
5030 INPUT#2, L$
5050 PRINT ".";
5060 IF GX=0 THEN GY=LEN(L$)
5080 FOR W=0 TO GY-1
5090 H=ASC(MID$(L$,W+1,1))-64
5100 IF H=51 THEN SP(1)=W:SP(0)=GX:H=1:PRINT"S";
5110 IF H=37 THEN EP(1)=W:EP(0)=GX:H=26:PRINT"E";
5120 GH%(GX,W)=H

5130 NEXT W
5135 GX=GX+1
5140 IF (ST AND 64)<>64GOTO 5030 : REM WHILE NOT EOF
5150 CLOSE 2:CLOSE 15
5151 GD%(EP(0),EP(1))=0
5160 PRINT:PRINT"GRID SIZE IS:";GY;"C X";GX;"R"
5170 PRINT"START POINT AT ";SP(0);",";SP(1)
5180 PRINT"END POINT AT ";EP(0);",";EP(1)
5190 RETURN

6000 DATA0,-1,1,0,0,1,-1,0