![icon](https://raw.githubusercontent.com/mrz1277/LoLKR/master/screenshots/icon.png)

# 문제

* [한국서버 Mac OS X 지원 관련 질문 - 리그 오브 레전드 공식 홈페이지에서 조회수 약 36,000, 댓글 156, 추천 237건을 받은 글](http://www.leagueoflegends.co.kr/?m=forum&mod=view&mod_context=topic&topic_id=7&thread_id=270482)

요약하자면 한국 맥 유저는 롤을 정상적인 경로로는 플레이 할 수 없습니다. 
공식적으로 지원되는 게임 클라이언트의 운영체제가 한국은 윈도우 밖에 없기 때문이죠. 
이에 대한 정확한 이유는 잘 모르겠으나 아마 결제 관련 문제 때문이 아닐까 싶습니다.

# 기존의 문제 해결 방법

그러나 기존 맥 클라이언트를 가지고 서버 주소만 한국으로 바꿔주면 이용할 수 있는데, 이게 기존에 알려진 `lol.properties` 파일을 수정하는 방법입니다. 하지만 이 방법엔 다음과 같은 한계가 있는데요,

1. 파일을 변조한 원래의 서버(예를 들면 북미 혹은 오세아니아)를 동시에 이용하지 못함.
2. 외국 서버가 업데이트 되면 한국 서버가 업데이트 될 때까지 게임을 할 수 없음.

이 중에서도 2번이 특히 불편합니다. 보통 한국이 북미보다 업데이트가 보통 3-4일 정도 늦기 때문에 그 동안 게임을 즐길 수 없죠. 그래서 어떤 사람들은 애초에 패럴러즈나 부트캠프에서 게임을 즐기기도 합니다. 이 문제를 해결하기 위해서는 Riot 에서 한국 서버에 맞는 업데이트 서버를 제공해야 합니다. 그렇지 않다면 약간의 꼼수를 쓰거나.

# 해결

그렇다면 북미서버가 업데이트 되어도 한국서버가 업데이트 될 때까지 클라 업데이트를 지연시키면 되지 않을까요?
로컬에 웹서버를 두고 롤 업데이트 서버주소를 로컬로 바라보게 하였습니다.
몇 가지 필요한 작업을 해주고 나니 외국 서버 업데이트가 진행되어도 한국 서버에 접속할 수 있게 되었습니다.
그리고 한국 서버가 업데이트 되고 나면 원래대로 클라 업데이트를 진행시켰습니다.

# 사용법

## 1. 앱 [다운로드](https://github.com/mrz1277/LoLKR/releases/download/v1.0/LoLKR.zip)
![앱 구동 화면](https://raw.githubusercontent.com/mrz1277/LoLKR/master/screenshots/app-1.png)

'패치 하기' 버튼을 눌러주세요.

## 2. 패치 시작 
![설정화면](https://raw.githubusercontent.com/mrz1277/LoLKR/master/screenshots/app-2.png) 

대부분은 그냥 확인 버튼을 누르시면 됩니다.

* 기본 롤 경로(/응용 프로그램/League of Legends)가 아니신 분들은 별도로 설정해주세요.
* `brew`를 이용해서 로컬에 nginx를 설치합니다. 이미 설치가 되신 분들은 포트만 겹치지 않게 nginx.conf 파일만 아래와 같이 따로 설정해주시면 됩니다.
```
worker_processes    1;

events {
    worker_connections  1024;
}

http {
    include       mime.types;
    default_type  text/plain;

    # disable auto-update
    server {
        listen       8010;
        server_name  localhost;

        location / {
            root        html;
            try_files   $uri $uri/ @cdn;
        }

        location @cdn {
            proxy_pass  http://l3cdn.riotgames.com;
        }
    }

    # enable auto-update
    server {
        listen      8020;
        server_name localhost;

        rewrite      ^(.*)_KR$        $1_NA;
        rewrite      ^(.*)_kr/(.*)$   $1_na/\$2;

        location / {
            proxy_pass  http://l3cdn.riotgames.com;
        }
    }
}
```
* 마지막 포트번호는 로컬에 8010이나 8020을 이미 사용하시는 분들은 다른 임의의 포트번호를 입력해주시면 됩니다.

패치가 완료되면 롤을 다시 시작해주세요.
![완료 화면](https://raw.githubusercontent.com/mrz1277/LoLKR/master/screenshots/app-3.png)

## 3. 업데이트 스위치
![스위치](https://raw.githubusercontent.com/mrz1277/LoLKR/master/screenshots/switch.png)

평소 자동 업데이트 방지에 스위치를 켜두고 있다가, 한국 서버가 정상적으로 업데이트 되면 그때 스위치를 잠시 끄고 롤을 실행하면 클라이언트가 정상적으로 업데이트됩니다. 업데이트가 완료되면 다시 스위치를 키고 자동 업데이트 방지에 두고 플레이 하시면 됩니다.

# 추가 기능

* 서버 목록에 대한민국이 별도로 추가된 모습. 언어도 기호에 맞게 한글/영어를 선택할 수 있게 추가했습니다.
![서버목록](https://raw.githubusercontent.com/mrz1277/LoLKR/master/screenshots/server.png)

참고! 다른 지역 서버에도 정상적으로 접속하시려면 이전에 변경하신 `lol.properties` 파일을 원래대로 복구하셔야 합니다.

* 인터넷에 떠도는 오래된 `lol.properties` 파일 내용을 수정해서 로비 화면(기존 찾을 수 없음 404)도 정상적으로 보이게 했습니다.
![로비](https://raw.githubusercontent.com/mrz1277/LoLKR/master/screenshots/lobby.png)

# 자동으로 설치되는 프로그램

* [brew](http://brew.sh/)(OS X 패키지 관리)
* [nginx](http://nginx.org/)(웹 서버)

# 지원 OS 버전

OS X 10.9(Mavericks) 이상

# 변경이력

* 2015-04-14 : v1.0 배포