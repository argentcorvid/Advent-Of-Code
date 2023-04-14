%
 � "ADVENT OF CODE 2022, DAY 12" 8 � "ALLOCATING" T MX�200:MY�50:� MAX X, Y u GX�0:GY�0:� GRID ACTUAL SIZE �( D1�0:D2�0:D�0:� DISTANCES �2 MQ�0:QH�0:QT�0:QL�0:MQ��(�(MX�2�MY�2)):� QUEUE �< NX�0:NY�0:W�0:N�0:X�0:Y�0:H�0:NH�0 	F IB�0:HT�0:NV�0:� CONDITIONS 	G HM�49152 D	P �G%(MX,MY):� NEGATIVE FOR NOT VISITED c	Z �SP(2),EP(2),CP(2),NB(4,2) q	_ �Q%(MQ,2) �	d �X�0�3:�Y�0�1:�NB(X,Y):�:� �	e �Y�0�MY�1:�X�0�MX�1:G%(X,Y)��1:�:� �	n TF$�"DAY12TEST":FF$�"DAY12INPUT" �	� �"�" 
� �"1 FOR TEST,2 FOR FULL,X TO QUIT";A$ 7
� � A$��"1" � A$��"2" � A$��"X" � 210 T
� � A$�"1" � F$�TF$:� 5000 q
� � A$�"2" � F$�FF$:� 5000 �
� � A$�"X" � � �
� �
� 4000 �
D1�G%(SP(0),SP(1)) �
"� "DISTANCE FROM 'S' TO 'E': ";D1 �
,D2�D1 �
�� Y�0 � GY�1 �
�D�G%(0,Y) �� D�0 � D�D2 � D2�D �� 9�� "PART 2 MIN DIST TO E: ";D2 ?�� c�� FIND DISTANCES FROM END POINT ��Q%(0,0)�EP(0):Q%(0,1)�EP(1) ��QH�0:QT�1:QL�1:D�0 ��� "FINDING DISTANCES TO END POINT" ��� WHILE QL>0 ��CP(0)�Q%(QH,0):CP(1)�Q%(QH,1) �QH�QH�1:� QH�MQ � QH�0 �QL�QL�1 1�D�G%(CP(0),CP(1)) b��"POINT";CP(0);",";CP(1);"D";G%(CP(0),CP(1)) p� N�0 � 3 �NX�CP(0)�NB(N,0):NY�CP(1)�NB(N,1) �NH��(HM�(NY�GX)�NX):H��(HM�(CP(1)�GX)�CP(0)) �� �3);"N:";NX;",";NY;" HT ";NH; IB�(NX�GX � NX��0 � NY�GY � NY��0) 2"� � IB � � "SKIP IB":� 4210 C,HT�(H�NH��1) Y6NV�(G%(NX,NY)��1) �@� � (HT � NV) � � "SKIP HT/NV": � 4210 �JQ%(QT,0)�NX:Q%(QT,1)�NY �TQT�QT�1:� QT�MQ � QT�0 �^QL�QL�1 �hG%(NX,NY)�D�1 �m�"ADD, D:";D�1 �r� N:� SKIP w� QL � 0 � 4040 :� WHILE QL>0 '|� END 5��:�"DONE" ;�� K�� READ FILE Y�� 15,8,15 o�� 2,8,2,F$�",S,R" |��15,E,E$ ��� E��0 � � 5200 ��� "READING INPUT FILE" ���2, L$ ��� "."; ��� GY�0 � GX��(L$) ��GY�GY�1 ��� W�1 � GX �H��(�(L$,W,1))�64 4�� H�51 � SP(0)�W�1:SP(1)�GY�1:H�1:�"S"; a�� H�37 � EP(0)�W�1:EP(1)�GY�1:H�26:�"E"; | � HM�((GY�1)�GX)�W�1,H �
� W �� (ST � 64)��64� 5030 : � WHILE NOT EOF �� 2:� 15 �G%(EP(0),EP(1))�0 �(�:�"GRID SIZE IS:";GX;"C X";GY;"R" !2�"START POINT AT ";SP(0);",";SP(1) F<�"END POINT AT ";EP(0);",";EP(1) LF� mP� 2:� 15:�E$;E;" ABORTING":� �p�0,-1,1,0,0,1,-1,0   