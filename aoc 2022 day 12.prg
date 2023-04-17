%
 � "ADVENT OF CODE 2022, DAY 12" 8 � "ALLOCATING" X MX�160�1:MY�50�1:� MAX X, Y y GX�0:GY�0:� GRID ACTUAL SIZE �( D1�0:D2�0:D�0:� DISTANCES �2 QH�0:QT�0:QL�0:� QUEUE �3 MQ�2��(�(((MX�.5)�2)�(MY�2))) �< NX�0:NY�0:W�0:N�0:X�0:Y�0:H�0:NH�0 	F IB�0:HT�0:NV�0:� CONDITIONS *	G � HM=49152 U	P �GD%(MX,MY):� NEGATIVE FOR NOT VISITED e	U �GH%(MX,MY) �	Z �SP(2),EP(2),CP(2),NB(4,2) �	_ �Q%(MQ,2) �	d �X�0�3:�Y�0�1:�NB(X,Y):�:� �	e �Y�0�MY�1:�X�0�MX�1:GD%(X,Y)��1:GH%(X,Y)��1:�:� 

n TF$�"DAY12TEST":FF$�"DAY12INPUT" %
� �"�";�(0);"BYTES FREE" O
� �"1 FOR TEST,2 FOR FULL,X TO QUIT";A$ w
� � A$��"1" � A$��"2" � A$��"X" � 210 �
� � A$�"1" � F$�TF$:� 5000 �
� � A$�"2" � F$�FF$:� 5000 �
� � A$�"X" � � �
� �
� �
� 4000 �
D1�GD%(SP(0),SP(1)) "� "DISTANCE FROM 'S' TO 'E': ";D1 !,D2�D1 2�� Y�0 � GY�1 A�D�GD%(0,Y) Y�� D�0 � D�D2 � D2�D _�� ��� "PART 2 MIN DIST TO E: ";D2 ��� ��� FIND DISTANCES FROM END POINT ��Q%(0,0)�EP(0):Q%(0,1)�EP(1) ��QH�0:QT�1:QL�1:D�0 	�� "FINDING DISTANCES TO END POINT" �� WHILE QL>0 <�CP(0)�Q%(QH,0):CP(1)�Q%(QH,1) W�QH�QH�1:� QH�MQ � QH�0 c�QL�QL�1 z�D�GD%(CP(0),CP(1)) ���"POINT";CP(0);",";CP(1);"D";GD%(CP(0),CP(1)) �� N�0 � 3 �NX�CP(0)�NB(N,0):NY�CP(1)�NB(N,1) � �3);"N:";NX;",";NY;" HT ";NH; +IB�(NX�GX � NX��0 � NY�GY � NY��0) K"� � IB � � "SKIP IB":� 4210 p#NH�GH%(NX,NY):H�GH%(CP(0),CP(0)) �,HT�(H�NH��1) �6NV�(GD%(NX,NY)��1) �@� � (HT � NV) � � "SKIP HT/NV": � 4210 �JQ%(QT,0)�NX:Q%(QT,1)�NY �TQT�QT�1:� QT�MQ � QT�0 ^QL�QL�1 hGD%(NX,NY)�D�1 5m�"ADD, D:";D�1;"QL:";QL Dr� N:� SKIP fw� QL � 0 � 4040 :� WHILE QL>0 p|� END ~��:�"DONE" ��� ��� READ FILE - NEED TO TRANSPOSE TO FIT EACH LINE ��� 15,8,15 ��� 2,8,2,F$�",S,R" ��D�ST:�15,E,E$ $�� E��0 � D�64��64 � �E$;E;D;" ABORTING":�2:�15:� ?�� "READING INPUT FILE" J��2, L$ U�� "."; k�� GX�0 � GY��(L$) |�� W�0 � GY�1 ��H��(�(L$,W�1,1))�64 ��� H�51 � SP(1)�W:SP(0)�GX:H�1:�"S"; ��� H�37 � EP(1)�W:EP(0)�GX:H�26:�"E"; � GH%(GX,W)�H �
� W 	GX�GX�1 5� (ST � 64)��64� 5030 : � WHILE NOT EOF B� 2:� 15 YGD%(EP(0),EP(1))�0 �(�:�"GRID SIZE IS:";GY;"C X";GX;"R" �2�"START POINT AT ";SP(0);",";SP(1) �<�"END POINT AT ";EP(0);",";EP(1) �F� �p�0,-1,1,0,0,1,-1,0   