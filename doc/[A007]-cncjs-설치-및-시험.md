[A007] cncjs 설치 및 시험
================================

이 문서는 cncjs 프로그램을 설치하고 실험한 문서이다. 

## 참조

* [cncjs](https://github.com/cncjs/cncjs)

## 소개 



하드웨어를 테스트 하기 위해서 일단 정상적으로 동작하는 것이 보장 된 것이 필요하다.

그래서 인터넷에서 여러가지를 검색했다. 처음에는 cncjs 가 있었는데 

찾다보니 GrblServer 라고 하는 것이 있었다. 그런데 실패해서 다시 cncjs 를 
설치하고 수행해 보기로 하였다.


## 시험 PC

주 데스크의 USB 가 제대로 인식이 안되는 것 같아서 
192.168.10.60 데스크에서 진행하였다. 

## node.js 설치 

현재 테스트 하려는 PC 에는 node.js 가 없다. 
그래서 다음과 같이 설치하였다. 

~~~
$ curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
$ sudo apt-get install nodejs
$ sudo apt-get install build-essential
$ node --version
v9.11.2
~~~

## Node Version Manager 설치

설치된 노드 버전이 다른 문제를 해결하는 nvm 을 다음과 같이 설치한다.

~~~
$ git clone https://github.com/creationix/nvm.git ~/.nvm
$ cd ~/.nvm
$ git checkout `git describe --abbrev=0 --tags`
$ cd ..
$ . ~/.nvm/nvm.sh
~~~

### ~/.bashrc  수정

~~~
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
~~~

## node 6 설치 및 사용 적용

~~~
$ nvm install 6
$ nvm use 6
~~~

## 설치 

~~~
$ sudo npm install -g cncjs
$ sudo npm install --unsafe-perm -g cncjs
~~~

아래 방식으로 시도 했지만 실패 했다. 
그냥 마음 편하게 

~~
$ sudo /bin/bash
# cncjs --controller Grbl 
~~

로 실행한다. 

그리고 

다음과 같이 브라우저에서 http://127.0.1.1:8000 를 접속하여 실행한다. 

끝...

이후 내용은 참조용이다. 

~~~
$ cd ~
$ mkdir cncjs
$ cd cncjs
$ npm install cncjs
$ npm install --unsafe-perm cncjs
~~~

## 사용자 등록 

시리얼을 일반 사용자가 사용할 수 있도록 다음과 같이 구룹을 등록한다. 

$ sudo adduser frog dialout

다음과 같이 실행한다. 

cd ~/cnc
nvm use 6
node_modules/cncjs/bin/cnc --controller Grbl

## 실행 시험

설치가 제대로 되어 있는지 확인하기 위해서 다음과 같이 실행한다.

~~~
$ cncjs -h
~~~

## CNC 동작 시험

~~~
sudo cncjs --controller Grbl
~~~

다음과 같이 브라우저에서 http://127.0.1.1:8000
