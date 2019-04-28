[A007] cncjs 설치 및 시험
================================

이 문서는 cncjs 프로그램을 깃트에서 소스로 설치하고 동작 시키기 위한 시험이다.

## 참조

* [cncjs](https://github.com/cncjs/cncjs)

* [머시닝 센터 GCODE](http://www20.icomis.com/~readcall2/nuky/mct-2/g-code.htm)

## 시험 PC

주 데스크의 USB 가 제대로 인식이 안되는 것 같아서 
192.168.10.60 데스크에서 진행하였다. 

## 다운 로드

~~~
$ git clone https://github.com/cncjs/cncjs.git cncjs-source
~~~

## 초기 빌드 

~~~
$ cd ~/cncjs-source
$ yarn
~~~

될까?

그런데 찾아 보니 도커 이미지를 제공하네?

한번 시도해 볼까나?

~~~
$ docker pull cncjs/cncjs:latest
~~~

~~~
$ docker run --privileged -p 8000:8000 --rm --name cnc cncjs/cncjs:latest
~~~

잘되야 할 텐데...


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


## 소스 빌드 문제 

소스 빌드가 제대로 안된다. 

목적은 내가 직접 만들고 go 언어로 만드는 것이다. 

소스를 분석하면서 만드는 것이 낫지 않을까?

룰룰룰

## 소스 분석 

아무래도 소스를 분석하면서 적어놔야 제대로 분석이 될 것 같다. 

얼핏 보니 구조가 일렐트릭 을 지원하는 구조다 보니 

브라우저 앱과 서버 앱으로 분리되는 구조로 보인다. 

시퀏느는 브라우저 앱에서 제어하고 있으며 부트스트랩을 사용해서 컴포넌트를 만들어 간것 같다. 

나는 VUE 로 작성할 예정이므로 브라우저 앱은 분석을 중심으로 해당 컴포넌트가 어떤 구조로 작성되었는가를 분석하고 
서버는 golang 으로 작성할 것이므로 이것 역시 분석을 중심으로 처리해야 할 듯 하다. 

우선 서버에 어떤 기능들이 있는지 생각해 보자. 

먼저 서버에 필요한 것은 다음 위치에 있다. 

### src/server

이 디렉토리가 서버 소스이다. 

다음과 같은 디렉토리 구조를 가지고 있다. 

access-control.js
app.js
api/ - API 를 구현한다. 
config/
constants/
controllers/
i18n/
index.js
lib/
services/
store/
views/

### src/server/services

서버에서 계속 동작해야 하는 서비스를 처리 한다. 

다음 디렉토리에 서비스가 존재한다. 

* [*] index.js
* [*] cncengine/
* [*] configstore/
* [*] monitor/
* [*] taskrunner/

#### src/server/services/index.js

다음 모듈을 제공하는 역활을 한다.

* cncengine
* configstore
* monitor
* taskrunner

#### src/server/services/monitor/

특정 디렉토리의 파일 상태 변화를 감시하고 지정된 파일을 읽는 기능을 제공한다. 

다음 두가지 파일로 모듈을 제공한다. 

* index.js      - 모듈을 노출한다. 
* FSMonitor.js  - 실제 파일을 감시 한다. 

index.js 는 다음과 같은 함수를 제공한다. 

* start(watchDirectory) : watchDirectory 디렉토리를 감시 하도록 한다. 
* stop()  : 현재 진행 중인 디렉토리 감시 서비스를 중지 한다. 

* getFiles() : 감시 중인 파일 목록을 얻는다. 
* readFile() : 파일을 읽는다. (UTF-8 텍스트 들이다. )

#### src/server/services/configstore/

환경 설정 데이터를 저장하고 관리한다. 

* index.js      - 모듈을 구현한다.

index.js 는 다음과 같은 함수를 제공한다. 

* load(fileName)           : fileName 에 해당ㅎ아는 환경 설정 정보를 로드 한다. 환경 변경을 감시하고 변화가 있다면 다시 읽어 드리도록 처리한다.
* reload()                 : 파일에 저장된 데이터를 다시 읽어 들인다. 
* sync()                   : 현재 데이터를 파일에 저장한다. 
* has(key)                 : 키가 있는가를 검사한다. 
* get(key, defaultValue)   : 키 값을 읽어 온다. 설정된 키값이 없다면 defaultValue 에 설정된 값을 반환한다.
* set(key, value, options) : 키 값을 설정한다. 설정 전에 reload() 를 이용하여 파일에서 데이터를 읽어 동기화 시킨다. 
* unset(key)               : 키를 제거한다. 제거 전에 reload() 를 이용하여 파일에서 데이터를 읽어 동기화 시킨다.  

#### src/server/services/taskrunner/

디폴트 쉘에서 명령을 수행하는 테스크(프로세스)를 생성한다. 

이 기능을 구현하기 위해서 spawn-default-shell 라는 모듈을 사용한다. 

* index.js      - 모듈을 구현한다.
* TaskRunner.js - 명령 쉘 프로세스를 생성한다. 

TaskRunner.js 의 클래스는 다음 함수를 제공한다. 

* run(command, title, options) : command 명령을 해당 운영체제에서 제공하는 디폴트 쉘에서 수행한다. 
* contains(taskId)             : taskId 가 수행 상태인가를 검사 한다. 

#### src/server/services/cncengine/

소켓 서버를 열고 접속을 기다린다. 
소켓에 클라이언트가 연결되면 해당 명령을 기다날나.ㄷ 

특정 디렉토리의 파일 상태 변화를 감시하고 지정된 파일을 읽는 기능을 제공한다. 

다음 두가지 파일로 모듈을 제공한다. 

* index.js      - 모듈을 노출한다. 
* CNCEngine.js  - 실제 웹 소켓을 열고 명령을 기다리고 처리한다. 

* start(server, controller) : 웹 서버인자와 컨트롤러 인자를 이용하여 서비스를 제공한다. 
* stop()  : 서비스를 중지한다. 

### src/server/api/

서버 REST API 에 대한 처리를 한다. 

다음 파일에서 API 별 처리를 수행한다. 

* [*] api.commands.js
* [*] api.controllers.js
* [*] api.events.js
* [*] api.gcode.js
* [*] api.machines.js
* [*] api.macros.js
* [*] api.mdi.js
* [*] api.state.js
* [*] api.users.js
* [*] api.version.js
* [*] api.watch.js
* [*] index.js
* [*] paging.js

#### src/server/api/paging.js

페이지 처리에 필요로 하는 페이지 값의 조정을 처리 하는 유틸리티이다. 

#### src/server/api/index.js

API 모듈을 외부로 노출하는 것 이외에 특별히 하는 일은 없다. 

이 모듈을 보면 다음과 같은 API 들이 존재함을 알 수 있다. 

version     : 버전 
state       : 상태 (무슨 상태일까?)
gcode       : GCODE 처리 
controllers : 컨트롤러
watch       : 시리얼 디바이스 파일 변화를 감시한다.
commands    : 명령(무슨 명령?)
events      : 이벤트( 무슨 이벤트?)
machines    : 머신(컨트롤러와 무슨 차이지?)
macros      : 매크로( 명령 매크로 인가? )
mdi         : CNC MDI 
users       : 사용자 

#### src/server/api/api.users.js

이 모듈은 사용자 관리를 한다. 


#### src/server/api/api.users.js

이 모듈은 사용자 관리를 한다. 

다음 함수를 모듈 외부로 노출한다.

signin()   : 로그인 처리 
fetch()    : 사용자 목록을 얻오온다.
create()   : 사용자 등록
read()     : id 에 해당하는 사용자 정보 얻기 
update()   : id 에 해당하는 사용자 정보 수정
__delete() : id 에 해당하는 사용자 삭제

config 파일에 데이터를 저장하고 읽는다. 

config 의 데이터 읽기 및 저장을 처리하는 것은 다음이다.

import config from '../services/configstore';

환경 설정 값은 

import settings from '../config/settings';

에 의해서 읽기로 설정된다. 

#### src/server/api/api.version.js

이 모듈은 cncjs npm 패키지의 마지막 정보를 npm 레지스트리 서버에서 가져와 
반환한다.

처리 함수는 getLatestVersion() 이다.

npm 저장소 서버에서 'cncjs' 패키지 정보를 얻기 위한 API 를 호출하기 위해서 superagent 라는 API 지원 모듈을 사용한다. 

> https://github.com/visionmedia/superagent

이 모듈은 무척 작은 모듈을 갖는다. 

브라우저에서는 

> https://github.com/koenpunt/superagent-use

를 사용하여 호출한다. 

검토 하다 보니 다음과 같은 UI 컴포넌트도 괜찮은 것 같다. 

> https://github.com/trendmicro-frontend/universal-web-components

#### src/server/api/api.watch.js

특정 디렉토리의 변화를 감시하는 모니터링 서비스에서 
현재 감시된 파일의 목록을 얻어 오거나 파일의 내용을 얻어온다.

이 모듈은 다음 함수를 제공한다. 

getFiles()  : 파일 목록을 읽어 온다. 
readFile()  : 파일을 읽어 온다. 

이 곳의 목적은 시리얼 디바이스의 생성이나 소멸을 감시하는 목적이다. 
변환 되거나 업로드, 다운로드 되어 생성되거나 변화된 파일을 감시하한다. 

파일의 감시는 다음 모듈에서 처리 된다. 

> import monitor from '../services/monitor';

#### src/server/api/api.controllers.js

컨트롤러 목록 반환

이 모듈은 다음 함수를 제공한다. 

get() : 컨트롤러들의 status 배열 반환

status 는 getter 함수 형태로 작성되어 있으며 status() 함수를 호출하여 리턴값으로 반환된다. 

다음과 같은 내용이 기술된다. 

~~~
 get status() {
        return {
            port: this.options.port,
            baudrate: this.options.baudrate,
            rtscts: this.options.rtscts,
            sockets: Object.keys(this.sockets),
            ready: this.ready,
            controller: {
                type: this.type,
                settings: this.settings,
                state: this.state
            },
            feeder: this.feeder.toJSON(),
            sender: this.sender.toJSON(),
            workflow: {
                state: this.workflow.state
            }
        };
    }
~~~

#### src/server/api/api.machines.js

머신 목록을 반환한다. 

컨트롤러와 머신은 다른 개념이다. 

머신은 실제 CNC 기계 전체를 나타낸다. 이 머신을 제어하는 컨트롤러가 컨트럴러이다. 

머신에 대한 정보는 현재 X,Y,Z 의 크기를 최소 위치와 , 최대 위치로 지정한다. 

이 모듈은 다음 함수를 제공한다. 

fetch()    : 머신 목록을 반환한다. 
create()   : 새로운 머신을 등록한다. 
read()     : id 에 해당하는 머신 정보를 반환한다. 
update()   : id 에 해당하는 머신 정보를 갱신한다. 
__delete() : id 에 해당하는 머신을 제거한다. 

#### src/server/api/api.state.js

상태를 설정하거나 제거한다.

아직 상태가 정확히 무엇을 말하는지 모르겠다.

이 모듈은 다음 함수를 제공한다. 

get()   : 키에 해당하는 상태값을 얻는다.
unset() : 키에 해당하는 상태값을 제거한다.
set()   : 키에 해당하는 상태값을 설정(저장)한다.

#### src/server/api/api.commands.js

명령 데이터를 관리한다. 

이 모듈은 다음 함수를 제공한다. 

fetch()    : 명령 목록을 반환한다. 
create()   : 새로운 명령을 등록한다. 
read()     : id 에 해당하는 명령을 반환한다. 
update()   : id 에 해당하는 명령을  갱신한다. 
__delete() : id 에 해당하는 명령을 제거한다. 

run()      : 명령을 실행한다. 

명령 실행은 

taskRunner 를 통하여 실행한다.

taskRunner 는 다음에 선언되어 있다.

import taskRunner from '../services/taskrunner';

#### src/server/api/api.macros.js

매크로 데이터를 관리한다. 

이 모듈은 다음 함수를 제공한다. 

fetch()    : 매크로 목록을 반환한다. 
create()   : 새로운 매크로를 등록한다. 
read()     : id 에 해당하는 매크로를 반환한다. 
update()   : id 에 해당하는 매크로를 갱신한다. 
__delete() : id 에 해당하는 매크로를 제거한다. 

#### src/server/api/api.gcode.js

GCODE 데이터를 관리한다. 

이 모듈은 다음 함수를 제공한다. 
fetch()    : 포트에 해당하는 GCODE 데이터를 반환한다. 
upload()   : 포트에 해당하는 컨트롤러에 GCODE 를 업로드 한다. 
download() : 포트에 해당하는 컨트롤러의 GCODE 를 다운로드한다.

#### src/server/api/api.mdi.js

MDI 데이터를 관리한다. 

이 모듈은 다음 함수를 제공한다. 

fetch()      : MDI 목록을 반환한다. 
create()     : 새로운 MDI를 등록한다. 
read()       : id 에 해당하는 MDI를 반환한다. 
update()     : id 에 해당하는 MDI를 갱신한다. 
bulkUpdate() : 여러개의 MDI를 갱신하거나 생성한다. 
__delete()   : id 에 해당하는 MDI를 제거한다. 

#### src/server/api/api.events.js

이벤트 데이터를 관리한다. 

이 모듈은 다음 함수를 제공한다. 

fetch()      : 이벤트 목록을 반환한다. 
create()     : 새로운 이벤트를 등록한다. 
read()       : id 에 해당하는 이벤트를 반환한다. 
update()     : id 에 해당하는 이벤트를 갱신한다. 
__delete()   : id 에 해당하는 이벤트를 제거한다. 

#### src/server/lib/ImmutableStore.js

키 값 저장소 구현 
키가 설정되거나 삭제되면 이벤트 발생이 됨 
키에 해당하는 값이 변경 될때는 이벤트가 발생하지 않음

#### src/server/store/index.js

실질적인 서버 저장소 구현 

controllers 키 값 기본 생성

### src/server/controllers/

CNC 컨트롤러에 대한 기능을 정의한 디렉토리이다. 

하부에 지원하는 컨트롤러들이 있다.

src/server/controllers/

Grbl/
Marlin/
Smoothie/
TinyG/
constants.js
index.js

### src/server/controllers/Grbl/

Grbl CNC 컨트롤러에 대한 기능을 정의한 디렉토리이다. 








