[A001] GRBL 호스트 프로그램 설치
================================

이 문서는 GRBL 을 제어하기 위해서 호스트 프로그램을 설치하는 과정을 기록한 문서이다. 


## 참조

* [자작 CNC 라우터 v0.2 후기](http://www.kimsatgod.com/%EC%9E%90%EC%9E%91-cnc-%EB%9D%BC%EC%9A%B0%ED%84%B0-v0-2-%ED%9B%84%EA%B8%B0/)
* [GrblController Zpamaker](https://github.com/zapmaker/GrblHoming/blob/master/README)

## 설치 

GRBL 컨트롤러는 QT 베이스이고 다양한 운영체제에서 수행되고 있는 Zpamaker 를 사용해 보기로 하였다.

다운로드 위치는 다음이다.

> https://github.com/zapmaker/GrblHoming/releases

이중 리눅스 64 비트 버전은 다음에서 다운 받을 수 있다. 

> https://github.com/zapmaker/GrblHoming/releases/download/v3.6.1/GrblControllerLinuxInstallerx64-3.6.1

이 사이트에서 위 파일을 다운 받은 후 /tmp 로 복사해 놓는다. 

다음과 같은 에러가 나서 실패 했다. 

./GrblControllerLinuxInstallerx64-3.6.1: error while loading shared libraries: libxcb-sync.so.0: cannot open shared object file: No such file or directory

~~~ bash
$ cd /tmp
$ sudo apt-get install "^libxcb.*" libx11-xcb-dev libglu1-mesa-dev libxrender-dev

$ sudo apt-get install libxcb-randr0-dev libxcb-xtest0-dev libxcb-xinerama0-dev libxcb-shape0-dev libxcb-xkb-dev

$ chmod 755 GrblControllerLinuxInstallerx64-3.6.1

$ ./GrblControllerLinuxInstallerx64-3.6.1
~~~

32 비트 버전을 설치해 보기로 했다.

그것참..

> https://github.com/zapmaker/GrblHoming/releases/download/v3.6.1/GrblControllerLinuxInstallerx86-3.6.1

~~~ bash
$ chmod 777 GrblControllerLinuxInstallerx86-3.6.1
$ ./GrblControllerLinuxInstallerx86-3.6.1
~~~

이것도 다음과 같은 에러가 나면서 실패 했다. 

./GrblControllerLinuxInstallerx86-3.6.1: error while loading shared libraries: libxcb-render-util.so.0: wrong ELF class: ELFCLASS64

일단 포기.. 빠른 포기는 내 인생을 즐겁게 한다.

노드 웹 기반으로 cncjs 라는 것이 있다.

> https://github.com/cncjs/cncjs

이것을 설치해 보기로 했다. 

~~~
$ npm install -g cncjs
~~~

하 이것도 만만치 않네.. ㅠㅠ

퍼미션 문제로 실패 했다. 

흠.. 그렇다면...

직접 다운로드 받아서 할까?

일단 다른 곳에서 다시 시도해 보기로 했다. 

여기에 데스크 탑용 프로그램 리스트가 있다. 

> https://github.com/cncjs/cncjs/releases

> https://github.com/cncjs/cncjs/releases/download/master-latest/cncjs-app-1.9.16-pre-latest-linux-x86_64.AppImage


다운로드 받은 cncjs-app-1.9.16-pre-latest-linux-x86_64.AppImage 파일을 /app-cncj 로 복사해 놓는다. 

~~~ 
$ mkdir ~/app-cncjs
$ cd  ~/app-cncjs
$ chmod 755 cncjs-app-1.9.16-pre-latest-linux-x86_64.AppImage
$ ./cncjs-app-1.9.16-pre-latest-linux-x86_64.AppImage
~~~

처음 실행하면 설치할 것을 묻는데 예를 선택하자..

잘된다. 

이제 산 GRBL 보드를 PC 에 연결해 보자.

전원은 주변에 보니 12V 2.5A 가 있길래 이걸 사용하기로 하였다. 

GRBL 는 잘 켜진다. 

이제 USB 를 연결해 보기로 하였다.

어허 USB 연결 단자가 산업용이다. ㅋㅋㅋ

연결하면 다음과 같은 USB 목록이 생성되는 것을 확인 할 수 있다.

~~~ bash
$ lsusb
  :
Bus 001 Device 082: ID 1a86:7523 QinHeng Electronics HL-340 USB-Serial adapter
  :
~~~

그리고 /dev/ttyUSB0 디바이스 파일이 생성된다.

minicom 에서 확인

$ sudo minicom -s /dev/ttyUSB0

115200 으로 셋팅 한후 터미널이 시작된 후 아무키나 치면 다음과 같이 나온다. 

Grbl 0.9j ['$' for help]                                                     
$$ (view Grbl settings)                                                      
$# (view # parameters)                                                       
$G (view parser state)                                                       
$I (view build info)                       
$N (view startup blocks)                   
$x=value (save Grbl setting)               
$Nx=line (save startup block)              
$C (check gcode mode)                      
$X (kill alarm lock)                       
$H (run homing cycle)
~ (cycle start)
! (feed hold)
? (current status)
ctrl-x (reset Grbl)
ok

일단 정상적으로 동작한다는 의미이다. 

오케이 콜!

### 시리얼 포트 디바이스 권한 문제

설정이 실패하는데 솔찍하게 다음글이 도움이 되었다. 

> [TTY로 접근이 거부될 때](http://js-cristo.blogspot.com/2012/05/tty.html)

일단 따라해 보자. 

$ ls -al /dev/ttyUSB*
crw-rw---- 1 root dialout 188, 0  2월  4 13:02 /dev/ttyUSB0

dialout 그룹이다. 

이 그룹이 있는지 다음과 같이 확인해 보자

$ cat /etc/group | grep dialout
dialout:x:20:

이제 내 그룹 정보를 보자. 

$ id
uid=1000(frog) gid=1000(frog) 그룹들=1000(frog),3(sys),4(adm),24(cdrom) ...

일단 dialout 이 없다.

자 이제 내 계정에 dialout 그룹을 추가해 보자. 

그룹 추가는 usermod 명령어에 -G 옵션을 주고 추가할 그룹과 유저명을 입력하면 된다.

$ sudo usermod -G dialout frog

이제 내 그룹 정보를 다시 보자. 

$ id
uid=1000(frog) gid=1000(frog) 그룹들=1000(frog),3(sys),4(adm),24(cdrom) ...

그룹 적용이 되려면 로그 아웃 후 재 로그인 해야 하는데 어플리케이션들을 등록 상태 이므로 시스템을 리부팅 시켜 버리는 것이 편하다.
잘되었다.. 그동안 리부팅이 거의 없엇는데..

잘 동작 한다. 후후후...

좋은데?

자 이제 스텝 모터를 연결해서 동작 시켜 보자...

현재 내가 가지고 있는 스텝 모터는 다음이다. 

> 모델 : A2K-M243

42 가 유니폴라방식 2상 스테핑모터 토크 2.06Kg.cm 

* 유니폴라 타입의 6선 방식
* 42각(모터의 폭: 42mm)
* 1.8'
* 정격전류 : 1.2 A

핀은 다음과 같이 6개 이다. 

    +---             ---+
    | -  -  -  -  -  -  |
    +-------------------+
      주 흰 노 갈 흑 적 

    주 :   - A
    흰 : COM B
    노 :   - B
    갈 :   + A
    흑 : COM A
    적 :   + B

에레파츠에 다음과 같은 모델명이 나오고 있다. 

> http://m.eleparts.co.kr/goods/view?no=2618

결선도 없을 때 확인 방법

다음 글이 이런 경우의 해결 법인데..

> https://knowledge.ni.com/KnowledgeArticleDetails?id=kA00Z000000P7kCSAS&l=ko-KR


보드에 핀 아웃은 다음과 같이 예상하고 있다. 

    +--  -----  --+
    | -  -  -  -  |
    +-------------+
      B- B+ A- A+            

자 그러면 6P 과 4P 는 어떻게 연결하지 ?

찾아 보니 COM 단자를 전원 VCC 에 연결하여야 한다. 

자 그럼 다음과 같이 배선이 되겠다. 

    보드 
    ----

    +--  --+    +--  -----  --+
    | -  - |    | -  -  -  -  |
    +------+    +-------------+
      P  P       B- B+ A- A+            
      +  -

    스테핑 모터 
    -----------

      A  B  B  A  A  B
      -  C  -  +  C  +
    +---             ---+
    | -  -  -  -  -  -  |
    +-------------------+
      주 흰 노 갈 흑 적 
               보

    보드              스테핑 모터
    ----              ------------
    P+ 파             COM A  흑   
    P+                COM B  흰 

    A+                A+     보
    A-                A-     주
    B+                B+     적 
    B-                B-     노

근데 모터측 커넥터가 마땅하게 없다. 아아아~~~

