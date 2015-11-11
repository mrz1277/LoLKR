*질문은 [이곳](https://github.com/mrz1277/LoLKR/issues)에 올려주세요. 새로운 질문을 올리기 전에 다른 분들의 질문글도 먼저 읽어보시기 바랍니다. 그리고 개인 이메일로 직접 문의는 받지 않습니다.*

# 임시 공지

최근들어 업데이트가 북미보다 한국이 더 빨라졌습니다. 오전에 한국이 먼저 업데이트되고 오후 8시쯤 이후에 북미가 업데이트 되는식입니다. 즉 기존의 북미가 한국보다 업데이트가 빠르다는 가정하에 제작된 본 패치는 대략 10시간 정도의 갭이 생기게 된 겁니다. 이 사이에 접속하기 위해서는 업데이트 서버를 북미가 아니라 오세아니아로 우회하는 작업을 아래의 순서대로 해주셔야 합니다. (그냥 저녁까지 기다리시는 방법도 있습니다.)

1. 롤 시작화면에서 우측 상단 서버명을 누르고 지역 위치를 오세아니아 서버로 바꿉니다. 그러면 오세아니아 서버 업데이트가 진행됩니다.
2. 롤을 종료하고 `/Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_air_client_config_kr` 폴더를 지웁니다. (파인더를 열고 ⌘+shift+G 를 누르고 위 경로를 복사해서 이동한 뒤 ⌘+↑ 를 눌러 상위 폴더로 이동하시면 됩니다.)
3. `/Applications/LoLKR.app/Contents/Resources` 폴더로 이동합니다.
4. `1_nginx.sh` 파일을 열고 아래 3 부분을 찾아 화살표 오른쪽 부분으로 수정합니다. [파일](https://github.com/mrz1277/LoLKR/wiki/1_nginx.sh-for-OC1)
  ```
\$1_NA; ==> \$1_OC1;
\$1_en_us/\$2; ==> \$1_en_au/\$2;
\$1_na/\$2; ==> \$1_oc1/\$2;
  ```

5. `2_download_versions.sh` 파일을 열고 아래 부분들을 모두 수정합니다. [파일](https://github.com/mrz1277/LoLKR/wiki/2_download_versions.sh-for-OC1)
  ```
releaselisting_NA ==> releaselisting_OC1
lol_air_client_config_na ==> lol_air_client_config_oc1
  ```

6.  `3_lol.sh` 파일을 열고 아래 부분을 수정합니다. [파일](https://github.com/mrz1277/LoLKR/wiki/3_lol.sh-for-OC1)
  ```
cp -r "$BASE_DIR/projects/lol_air_client_config_na" "$BASE_DIR/projects/lol_air_client_config_kr"
==>
cp -r "$BASE_DIR/projects/lol_air_client_config_oc1" "$BASE_DIR/projects/lol_air_client_config_kr"
  ```

7. `LoLKR` 앱을 열고 패치하기를 하고 스위치를 허용에 둡니다.
8. 대한민국 서버로 패치를하고 로그인 화면에 들어갔을때 업데이트 된 새로운 배경화면이 나오면 성공입니다.

![icon](https://raw.githubusercontent.com/mrz1277/LoLKR/master/screenshots/icon.png)

# [다운로드](https://github.com/mrz1277/LoLKR/releases/download/latest/LoLKR.zip)

[![Join the chat at https://gitter.im/mrz1277/LoLKR](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/mrz1277/LoLKR?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

업데이트는 LoLKR 실행하고 상단 메뉴바의 `롤 한국 서버 패치` 메뉴를 누르고 `업데이트 확인`을 누르시면 됩니다.

* 2015-09-01 : (v1.3.3) 로비 화면 UI 업데이트 [@billieyang](https://github.com/billieyang)님 제공
* 2015-07-22 : (v1.3.0) 부팅때 nginx가 켜지지 않는 문제, 패치 때마다 한국어 음성이 나오지 않는 문제 해결
* 2015-05-15 : (v1.2.3) 북미 및 한국 서버 버전 확인
* 2015-05-01 : (v1.2.2) 5.8패치 대응. `패치하기`를 먼저 한번 실행한 다음 업데이트 스위치를 끄면 5.8업데이트가 정상적으로 진행됩니다.
* 2015-04-21 : (v1.2.0) 10.9(Mavericks)에서 창이 안뜨는 문제 해결
* 2015-04-17 : (v1.1.0) 자체 업데이트 지원
* 2015-04-14 : (v1.0.0) 배포

# 시작 전 주의사항

본 프로그램은 한국 서버가 업데이트 되기전에 **미리** 패치해놓고 있어야 북미와 버전 차이가 나는 업데이트 기간 동안 정상적으로 접속이 가능합니다. 예를 들어 현재 한국 서버 버전은 아직 5.8인데 롤을 실행하여 5.9로 업데이트 되었다면 아래 앱을 설치한다고 해서 다시 5.8로 접속할 수는 없습니다. 즉 본 프로그램으로 미리 패치해서 업데이트 방지로 걸려있지 않는한 북미 업데이트 기간에 접속이 안된다고 질문글 올리셔도 방법이 없습니다.

# 개발하게 된 동기

* [한국서버 Mac OS X 지원 관련 질문 - 리그 오브 레전드 공식 홈페이지에서 조회수 약 36,000, 댓글 156, 추천 237건을 받은 글](http://www.leagueoflegends.co.kr/?m=forum&mod=view&mod_context=topic&topic_id=7&thread_id=270482)

요약하자면 한국 맥 유저들은 롤을 정상적인 경로로는 플레이 할 수 없습니다. 
공식적으로 지원되는 게임 클라이언트의 운영체제가 한국은 윈도우 밖에 없기 때문이죠. 
이에 대한 정확한 이유는 잘 모르겠으나 아마 결제 관련 문제 때문이 아닐까 싶습니다.

# 기존의 문제 해결 방법

그러나 기존 맥 클라이언트를 가지고 서버 주소만 한국으로 바꿔주면 이용할 수 있는데, 이게 기존에 알려진 `lol.properties` 파일을 수정하는 방법입니다. 하지만 이 방법엔 다음과 같은 한계가 있습니다.

1. 파일을 변조한 원래의 서버(예를 들면 북미 혹은 오세아니아)를 동시에 이용하지 못함.
2. **외국 서버가 업데이트 되면 한국 서버가 업데이트 될 때까지 게임을 할 수 없음.**

이 중에서도 2번이 특히 불편합니다. 보통 한국이 북미보다 업데이트가 보통 3-4일 정도 늦기 때문에 그 동안 게임을 즐길 수 없죠. 아래는 업데이트별 한국과 북미간 업데이트 지연 기간입니다. 

* 5.10 : 2015-05-27 ~ 2015-06-02 (7일)
* 5.9 : 2015-05-13 ~ 2015-05-19 (7일)
* 5.8 : 2015-04-28 ~ 2015-04-30 (3일)
* 5.7 : 2015-04-06 ~ 2015-04-09 (4일)
* 5.6 : 2015-03-24 ~ 2015-03-26 (3일)

그래서 어떤 사람들은 애초에 패럴러즈나 부트캠프에서 게임을 즐기기도 합니다. 이 문제를 해결하기 위해서는 Riot 에서 한국 서버에 맞는 업데이트 서버를 제공해야 합니다. 그렇지 않다면 아래와 같은 약간의 꼼수를 쓰거나.

# 새로운 해결 방법

그렇다면 북미서버가 업데이트 되어도 한국서버가 업데이트 될 때까지 클라 업데이트를 지연시키면 되지 않을까요?
로컬에 웹서버를 두고 롤 업데이트 서버주소를 로컬로 바라보게 하였습니다.
몇 가지 필요한 작업을 해주고 나니 외국 서버 업데이트가 진행되어도 한국 서버에 접속할 수 있게 되었습니다.
그리고 한국 서버가 업데이트 되고 나면 원래대로 클라 업데이트를 진행시켰습니다.

이 작업을 위해 필요한 과정들을 스크립트로 만들고 이를 다시 앱으로 패키징 하였습니다.
기존의 알려진 방법들과 비교해서 더 나은 점들은 다음과 같습니다.

1. 위 문제 두 개를 모두 해결할 수 있다.
2. 사용자가 직접 파일을 찾고 수정할 필요가 없다.
3. Riot 공식 지원 클라이언트 처럼 쓸 수 있다.([추가기능](#%EC%B6%94%EA%B0%80-%EA%B8%B0%EB%8A%A5)란 참조)

# 사용법

## 1. [brew](http://brew.sh/) 설치

먼저 `brew`(OS X 패키지 관리자)가 설치 안되어 있으신 분들은 설치해 주셔야 합니다. 그러고 나면 앱 안에서 `brew`를 이용해서 `nginx`(웹서버)를 자동으로 설치하게 됩니다.
```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
터미널에 위 명령어를 복사하시고 붙여넣기해서 실행해 주시면 설치가 진행됩니다. 설치 중간에 `/usr/local` 폴더 생성을 위해 맥북 관리자 비밀번호를 한번 요구합니다. 비밀번호 입력할 때 `password:` 다음 커서가 멈춰있는것처럼 보이는데 실제로는 비밀번호를 받고 있는 상태이니 그냥 비밀번호를 치고 엔터키를 누르시면 됩니다. 

이 부분은 `sudo` 권한으로 터미널에서 직접 폴더를 생성하셔도 되는 부분입니다.

## 2. 앱 [다운로드](https://github.com/mrz1277/LoLKR/releases/download/latest/LoLKR.zip)
![앱 구동 화면](https://raw.githubusercontent.com/mrz1277/LoLKR/master/screenshots/app-1.png)

'패치 하기' 버튼을 눌러주세요.

## 3. 패치 준비
![설정화면](https://raw.githubusercontent.com/mrz1277/LoLKR/master/screenshots/app-2.png) 

대부분은 그냥 확인 버튼을 누르시면 됩니다.

### 옵션 설명

* 기본 롤 경로(`/Applications/League of Legends`)가 아니신 분들은 별도로 설정해주세요. 롤 경로가 다르면 롤 아이콘 모양이 아니라 흰색 파일 아이콘 모양입니다.
* `brew`를 이용해서 로컬에 `nginx`를 설치합니다. 이미 설치가 되신 분들은 포트만 겹치지 않게 `/usr/local/etc/nginx/nginx.conf` 파일만 아래와 같이 따로 설정해주시면 됩니다. 단, `brew`로 설치한 `nginx`만 해당합니다. 다른 방법으로 설치한 `nginx`는 경로를 제대로 잡지 못하니 주의하세요.
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
            proxy_connect_timeout 60s;
            proxy_read_timeout 60s;
        }
    }

    # enable auto-update
    server {
        listen      8020;
        server_name localhost;

        rewrite      ^(.*)_KR$                                             $1_NA;
        rewrite      ^(.*)_ko_kr/(((?!files|releasemanifest).)*)$          $1_en_us/$2;
        rewrite      ^(.*)_kr/(((?!files|releasemanifest).)*)$             $1_na/$2;

        location / {
            proxy_pass  http://l3cdn.riotgames.com;
            proxy_connect_timeout 60s;
            proxy_read_timeout 60s;
        }
    }
}
```
* 마지막 포트번호는 로컬에 8010이나 8020을 이미 사용하시는 분들은 다른 임의의 포트번호를 입력해주시면 됩니다.

패치가 완료되면 롤을 다시 시작해주세요.

![완료 화면](https://raw.githubusercontent.com/mrz1277/LoLKR/master/screenshots/app-3.png)

패치는 최초 한번만 하시면 됩니다. 여기서 주의하실 점은 **롤 업데이트 기간동안 패치하기를 하면 안되는 것입니다.** 패치하기를 진행하면 자동으로 최신 버전의 업데이트 파일들을 내려받기 때문에 롤을 실행하게 되면 북미기준으로 업데이트가 진행됩니다. 업데이트 기간동안엔 아래의 스위치 조작을 하시면 됩니다.

## 4. 업데이트 스위치
![스위치](https://raw.githubusercontent.com/mrz1277/LoLKR/master/screenshots/switch.png)

평소 자동 업데이트 방지에 스위치를 켜두고 있다가, 한국 서버가 정상적으로 업데이트 되면 그때 스위치를 잠시 끄고 롤을 실행하면 클라이언트가 정상적으로 업데이트됩니다. 업데이트가 완료되면 다시 스위치를 켜고 자동 업데이트 방지에 두고 플레이 하시면 됩니다.

북미서버와 한국서버간의 버전차이가 있을때도 업데이트 방지에 스위치가 켜저있으면 버전이 서로 다른 각각의 서버에 정상적으로 접속됩니다. 아래는 2015년 5월 15일 23시에 북미(5.9)와 한국(5.8)서버를 번갈아가면서 접속하고 찍은 사진입니다. 왼쪽 상단에 버전명이 있습니다.

![한국서버 5.8](https://raw.githubusercontent.com/mrz1277/LoLKR/master/screenshots/kr-5_8.png)

![북미서버 5.9](https://raw.githubusercontent.com/mrz1277/LoLKR/master/screenshots/na-5_9.png)

# 추가 기능

아래의 추가기능들은 위에서 소개한 주 기능인 가상 한국 업데이트 서버 패치 이외에 부가적으로 패치되는 것들입니다. 간단하지만 그동안 다른 어떤 솔루션에서도 다루지 않았던 기능들입니다.

* 지역 목록에 대한민국이 별도로 추가 되었습니다. 다른 지역도 언제든 바꿔서 접속 가능합니다. 언어도 기호에 맞게 한글/영어를 선택할 수 있게 추가했습니다.

![서버목록](https://raw.githubusercontent.com/mrz1277/LoLKR/master/screenshots/server.png)

참고! 다른 지역 서버에도 정상적으로 접속하시려면 이전에 변경하신 `lol.properties` 파일이 있다면 원래대로 복구하셔야 합니다.([참조](https://github.com/mrz1277/LoLKR/wiki/lol.properties))

* 더이상 404 페이지는 그만. 인터넷에 떠도는 오래된 `lol.properties` 파일 내용을 업데이트해서 로비 화면을 윈도우에서처럼 정상적으로 보이게 했습니다.

![로비](https://raw.githubusercontent.com/mrz1277/LoLKR/master/screenshots/lobby.png)

# 자주 묻는 질문

[이곳](https://github.com/mrz1277/LoLKR/issues?q=is%3Aissue+is%3Aclosed)에서 기존에 다른 유저들이 올린 문제에 대한 부분을 먼저 검색해주세요.

### *명시되지 않은 오류가 발생했다며 롤이 실행되지 않습니다.*

![명시되지 않은 에러](https://raw.githubusercontent.com/mrz1277/LoLKR/master/screenshots/error-unspecified.png)

`nginx`가 제대로 실행되고 있는지 확인해 주세요. `LoLKR` 앱을 켰을때 nginx 부분이 회색이면 실행되고 있지 않다는 뜻입니다.

![nginx](https://raw.githubusercontent.com/mrz1277/LoLKR/master/screenshots/nginx.png)

터미널에서 아래 커맨드를 입력해서 실행시켜주세요. **`패치하기`버튼을 누르면 nginx는 재시작 되지만 업데이트 기간엔 절대 누르시면 안됩니다.**

```
nginx

# 참고: 재시작 명령어(이미 실행중일때)
nginx -s reload
```

### *`brew`를 이용한 `nginx` 설치가 잘 안됩니다.*

기존에 설치된 프로그램들과 충돌이 있는 경우가 있습니다. 터미널에 아래 커맨드를 입력해서 문제점을 진단해보세요.

```
brew doctor
```

### *업데이트 기간중에 패치가 되어버렸습니다. 다시 되돌릴 수 없나요?*

로컬에 웹서버를 둔 이상 로컬 메타파일이 업데이트 되면 다시 되돌리긴 어렵습니다. 그게 온라인상에 업데이트 서버가 있어야 하는 이유입니다. 

하지만 실수로 업데이트가 될 수도 있기 때문에 평소에 로컬에 업데이트 메타파일(`/usr/local/var/www`)과 인게임 클라이언트 폴더를(`/Applications/League of Legends.app/Contents/LoL/RADS/projects/lol_game_client_ko_kr/`) 백업해두면 도움이 됩니다. 

물론 본 패치앱이 해당 작업을 진행해주면 더 좋겠죠. 이건 시간날 때 구현하도록 아래 [TODO](#todo)에 남겨두도록 하겠습니다.

### 재부팅하면 nginx 가 자동으로 실행이 안됩니다.



### *다른 문제가 생겼어요.*

[이슈](https://github.com/mrz1277/LoLKR/issues)에 올려주세요. `closed` 탭에 들어가면 기존에 질문했던 내역들도 볼 수 있으니 올리기 전에 미리 검색해 보시면 도움이 됩니다.

롤이 에러를 뱉으며 문제를 일이킬시엔 로그도 첨부해주시면 분석하는데 도움이 됩니다. 로그 위치는 `/Applications/League of Legends.app/Contents/LoL/Logs` 가 하나 있고 다른 하위폴더(`RADS`)의 로그를 전부 압축하는 아래 커맨드를 터미널에서 실행하시면 됩니다.

```
find "/Applications/League of Legends.app/Contents/LoL/RADS/" -name '*.log' -print | zip logs -@
```

# 패치 삭제하기

이전으로 복원하는 가장 깔끔한 방법은 롤을 재설치 하는겁니다.

1. 기존에 설치된 롤을 `/Application` 폴더에서 삭제합니다.
2. 터미널에 아래 커맨드를 입력해 `nginx`를 삭제합니다.
  ```
  brew uninstall nginx
  ```
  
3. [북미 공식 홈](http://na.leagueoflegends.com/)에서 롤을 다운받아 설치합니다.

# 지원 OS 버전

OS X 10.9(Mavericks) 이상

# 한글채팅 입력 플러그인

이선엽 개발자님이 한글채팅 입력 플러그인 [LoLChatFix](http://lolchatfix.funso.me/) 을 제작해 주셨습니다.

# TODO

- [ ] 업데이트 기간중에 패치가 되었을때 다시 되돌리기(로컬 자동 백업/리커버리)
- [ ] 한글 채팅 자소 분리 문제

오픈소스인만큼 다른 능력있는 개발자분들이 pull request 해주시면 감사하겠습니다.

# 자매품

[LoL Stats](http://mrz1277.github.io/LoLStats?utm_source=github&utm_medium=link&utm_campaign=website) 

![lolstats](http://mrz1277.github.io/LoLStats/shot-3.png)

맥 네이티브 환경에서 동작하는 롤 인게임 정보 확인 앱입니다. 게임이 시작되면 롤 전적 사이트에서 인게임 정보 확인하는 번거로움을 줄이기 위해 제작되었습니다.
