[A002] GRBL GCODE SENDER 검토
================================

이 문서는 GRBL 을 제어하기 위해서 GCODE SENDER 를 검토하는 과정을 기록한 문서이다. 

## 참조

* [A command-line GCode sender and optimizer for CNC routers](https://github.com/kennylevinsen/gocnc)

## 배경

자작한 CNC 를 제어를 하기 위해서 GCODE SENDER 를 사용하기로 하였다. 

인터넷 검색 중에 다음과 같은 것이 검색 되었다. 

A command-line GCode sender and optimizer for CNC routers

> https://github.com/kennylevinsen/gocnc

## 하드웨어

GRBL 

현재 구매 된 것은 GRBL 이 동작하는 UNO 이다. 

프로그램을 부팅하면 동작 할 것으로 판단된다. 

UNO 가 부팅되면 /dev/ttyUSB0 과 같이 USB 시리얼 장치로 접근이 가능하다. 

장치 제어를 위해서 프로그램적 접근은 그리 어렵지 않다는 것이 겠죠?






