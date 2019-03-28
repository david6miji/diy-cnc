[A006] GrblServer 설치 및 시험
================================

이 문서는 GrblServer 프로그램을 설치하고 실험한 문서이다. 

## 참조

* [Overview](https://github.com/cho45/GrblServer)

## 소개 

하드웨어를 테스트 하기 위해서 일단 정상적으로 동작하는 것이 보장 된 것이 필요하다.

그래서 인터넷에서 여러가지를 검색했다. 처음에는 cncjs 가 있었는데 

찾다보니 GrblServer 라고 하는 것이 있었다. 

기존에 내가 개발하는 환경처럼 하려다 이것은 참조용이고 일시적인 것이라 
노드를 설치하고 그저 실행만 시키기로 결정하였다. 

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

## 설치 

!!! 여기서 실패 했다.


~~~
$ cd ~
$ git clone https://github.com/cho45/GrblServer.git
$ cd GrblServer
$ npm install
gyp ERR! command "/usr/bin/node" "/usr/lib/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js" "build" "--fallback-to-build" "--module=/home/frog/GrblServer/node_modules/serialport/build/serialport/v1.7.4/Release/node-v59-linux-x64/serialport.node" "--module_name=serialport" "--module_path=/home/frog/GrblServer/node_modules/serialport/build/serialport/v1.7.4/Release/node-v59-linux-x64"
gyp ERR! cwd /home/frog/GrblServer/node_modules/serialport
gyp ERR! node -v v9.11.2
gyp ERR! node-gyp -v v3.6.2
gyp ERR! not ok 
node-pre-gyp ERR! build error 
node-pre-gyp ERR! stack Error: Failed to execute '/usr/bin/node /usr/lib/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js build --fallback-to-build --module=/home/frog/GrblServer/node_modules/serialport/build/serialport/v1.7.4/Release/node-v59-linux-x64/serialport.node --module_name=serialport --module_path=/home/frog/GrblServer/node_modules/serialport/build/serialport/v1.7.4/Release/node-v59-linux-x64' (1)
node-pre-gyp ERR! stack     at ChildProcess.<anonymous> (/home/frog/GrblServer/node_modules/node-pre-gyp/lib/util/compile.js:83:29)
node-pre-gyp ERR! stack     at ChildProcess.emit (events.js:180:13)
node-pre-gyp ERR! stack     at maybeClose (internal/child_process.js:936:16)
node-pre-gyp ERR! stack     at Process.ChildProcess._handle.onexit (internal/child_process.js:220:5)
node-pre-gyp ERR! System Linux 3.19.0-32-generic
node-pre-gyp ERR! command "/usr/bin/node" "/home/frog/GrblServer/node_modules/serialport/node_modules/.bin/node-pre-gyp" "install" "--fallback-to-build"
node-pre-gyp ERR! cwd /home/frog/GrblServer/node_modules/serialport
node-pre-gyp ERR! node -v v9.11.2
node-pre-gyp ERR! node-pre-gyp -v v0.6.39
node-pre-gyp ERR! not ok 
Failed to execute '/usr/bin/node /usr/lib/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js build --fallback-to-build --module=/home/frog/GrblServer/node_modules/serialport/build/serialport/v1.7.4/Release/node-v59-linux-x64/serialport.node --module_name=serialport --module_path=/home/frog/GrblServer/node_modules/serialport/build/serialport/v1.7.4/Release/node-v59-linux-x64' (1)
~~~
