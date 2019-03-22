[A004] GRBL UNO에 프로그램 쓰기
================================

이 문서는 UNO에 프로그램을 빌드하고 써 넣는 방법을 기술한 문서이다. 

## 참조

C 로 구현된 GRBL

* [This version of Grbl runs on an Arduino Mega2560 only](https://github.com/fra589/grbl-Mega-5X)

## 배경

알리익스프레스에서 GRGB 보드용 셋트를 구매 했다. 
그런데.. 

프로그램이 구워져 있는 줄 알았는데...

없다. 

처음에 내가 시리얼이 잘못된 줄 알았다. 

근데 없다. 

이런 씨부럴...

그래서 UNO 에 프로그램을 굽는 것 부터 해야 하는 상황이 발생해 버린거다. ㅠㅠ

대부분 윈도우에서 하다 보니


## 리눅스에서 쓰기 


다음과 같은 명령을 사용하여 쓸 수 있다. 

펌웨어 바이너리를 다음과 같이 받는다. 

릴리즈 사이트는 다음과 같다. 

> https://github.com/gnea/grbl/releases

다음과 같이 리눅스 명령창에서 받을 수 있다. 

$ wget https://github.com/gnea/grbl/releases/download/v1.1f.20170801/grbl_v1.1f.20170801.hex

grbl_v1.1f.20170801.hex


~~~
$ avrdude -v -patmega328p -Uflash:w:grbl_v1.1f.20170801.hex:i -carduino -b 57600 -P /dev/ttyUSBX
~~~


