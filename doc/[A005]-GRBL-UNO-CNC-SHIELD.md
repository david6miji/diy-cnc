[A005] GRBL UNO CNC SHIELD
================================

이 문서는 UNO에 연결하는 CNC-SHIELD 에 대하여 기술한 문서이다. 

## 참조

* [Arduino UNO + Arduino CNC 실드 V3.0 + A4988 설치 가이드](http://osoyoo.com/2017/04/07/arduino-uno-cnc-shield-v3-0-a4988/)
* [DRV8825 장착 이미지](https://www.google.com/search?q=CNC-shield+DRV8825&lr=lang_ko&newwindow=1&tbs=lr:lang_1ko&source=lnms&tbm=isch&sa=X&ved=0ahUKEwiY1MrqrZzhAhWJH3AKHQPYCnk4FBD8BQgOKAE&biw=1920&bih=983#imgrc=Qy2u508AaFHLmM:)

## 소개 

STEPPING MOTOR : NEMA23 175oz

RED :  A+
GRN :  A-

YEL :  B+
BLU :  B-

 B2 : B-    B2 : B-
 B1 : B+    B1 : B+
 A1 : A+    A1 : A+
 A2 : A-    A2 : A-
 X label    Y label

 B2 : B-    B2 : B-
 B1 : B+    B1 : B+
 A1 : A+    A1 : A+
 A2 : A-    A2 : A-
 Z label    A label

 B2 : BLACK
 B1 : RED
 A1 : WHITE
 A2 : YELLOW 
   
모터        케이블   커넥터   보드   
A+ : RED  - BLACK      -      WHITE  :  A1
A- : GRN  - YELLOW     -      YELLOW :  A2
B+ : YEL  - WHITE      -      RED    :  B1
B- : BLU  - RED        -      BLACK  :  B2
