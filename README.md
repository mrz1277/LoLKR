# 맥 공식 어플리케이션 출시

http://www.leagueoflegends.co.kr/?m=download&mod=client_mac

--- 

**_이 프로젝트는 더 이상 유지되지 않습니다._**

업데이트는 LoLKR 실행하고 상단 메뉴바의 `롤 한국 서버 패치` 메뉴를 누르고 `업데이트 확인`을 누르시면 됩니다.

* 2016-95-06 : (v1.4.0) README.md 업데이트 -> nginx 설치 안될때
* 2016-03-13 : (v1.4.0) 6.5 패치 대응. 오세아니아로 기본 서버 변경.
* 2015-09-01 : (v1.3.3) 로비 화면 UI 업데이트 [@billieyang](https://github.com/billieyang)님 제공
* 2015-07-22 : (v1.3.0) 부팅때 nginx가 켜지지 않는 문제, 패치 때마다 한국어 음성이 나오지 않는 문제 해결
* 2015-05-15 : (v1.2.3) 북미 및 한국 서버 버전 확인
* 2015-05-01 : (v1.2.2) 5.8패치 대응. `패치하기`를 먼저 한번 실행한 다음 업데이트 스위치를 끄면 5.8업데이트가 정상적으로 진행됩니다.
* 2015-04-21 : (v1.2.0) 10.9(Mavericks)에서 창이 안뜨는 문제 해결
* 2015-04-17 : (v1.1.0) 자체 업데이트 지원
* 2015-04-14 : (v1.0.0) 배포

# 시작 전 주의사항

본 프로그램은 한국 서버가 업데이트 되기전에 **미리** 패치해놓고 있어야 북미와 버전 차이가 나는 업데이트 기간 동안 정상적으로 접속이 가능합니다. 예를 들어 현재 한국 서버 버전은 아직 5.8인데 롤을 실행하여 5.9로 업데이트 되었다면 아래 앱을 설치한다고 해서 다시 5.8로 접속할 수는 없습니다. 즉 본 프로그램으로 미리 패치해서 업데이트 방지로 걸려있지 않는한 북미 업데이트 기간에 접속이 안된다고 질문글 올리셔도 방법이 없습니다.

# 사용법

## 1. 오세아니아 롤 설치

더이상 북미 버전을 사용하지 않습니다. 아래 링크에서 오세아니아 서버 롤을 설치합니다. https://signup.oce.leagueoflegends.com/en/signup/redownload

## 2. [brew](http://brew.sh/) 설치

먼저 `brew`(OS X 패키지 관리자)가 설치 안되어 있으신 분들은 설치해 주셔야 합니다.
```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
터미널에 위 명령어를 복사하시고 붙여넣기해서 실행해 주시면 설치가 진행됩니다. 설치 중간에 `/usr/local` 폴더 생성을 위해 맥북 관리자 비밀번호를 한번 요구합니다. 비밀번호 입력할 때 `password:` 다음 커서가 멈춰있는것처럼 보이는데 실제로는 비밀번호를 받고 있는 상태이니 그냥 비밀번호를 치고 엔터키를 누르시면 됩니다.

## 3. 앱 [다운로드](https://github.com/mrz1277/LoLKR/releases/download/latest/LoLKR.zip)
![앱 구동 화면](https://raw.githubusercontent.com/mrz1277/LoLKR/master/screenshots/app-1.png)

'패치 하기' 버튼을 눌러주세요.

## 4. 패치 준비
![설정화면](https://raw.githubusercontent.com/mrz1277/LoLKR/master/screenshots/app-2.png)

대부분은 그냥 확인 버튼을 누르시면 됩니다. 자세한 옵션 설정은 [이곳](https://github.com/mrz1277/LoLKR/wiki/Install-options)을 참조해 주세요.

패치가 완료되면 롤을 다시 시작해주세요.

![완료 화면](https://raw.githubusercontent.com/mrz1277/LoLKR/master/screenshots/app-3.png)

패치는 최초 한번만 하시면 됩니다. 여기서 주의하실 점은 **롤 업데이트 기간동안 패치하기를 하면 안되는 것입니다.** 패치하기를 진행하면 자동으로 최신 버전의 업데이트 파일들을 내려받기 때문에 롤을 실행하게 되면 오세아니아 서버 기준으로 업데이트가 진행됩니다. 업데이트 기간동안엔 아래의 스위치 조작을 하시면 됩니다.

## 5. 업데이트 스위치
![스위치](https://raw.githubusercontent.com/mrz1277/LoLKR/master/screenshots/switch.png)

평소 자동 업데이트 방지에 스위치를 켜두고 있다가, 한국 서버가 정상적으로 업데이트 되면 그때 스위치를 잠시 끄고 롤을 실행하면 클라이언트가 정상적으로 업데이트됩니다. 업데이트가 완료되면 다시 스위치를 켜고 자동 업데이트 방지에 두고 플레이 하시면 됩니다.

# 자주 묻는 질문

[이곳](https://github.com/mrz1277/LoLKR/issues?q=is%3Aissue+is%3Aclosed)에서 기존에 다른 유저들이 올린 문제에 대한 부분을 먼저 검색해주세요.

### *명시되지 않은 오류가 발생했다며 롤이 실행되지 않습니다.*

![명시되지 않은 에러](https://raw.githubusercontent.com/mrz1277/LoLKR/master/screenshots/error-unspecified.png)

`nginx`가 제대로 실행되고 있는지 확인해 주세요. `LoLKR` 앱을 켰을때 nginx 부분이 회색이면 실행되고 있지 않다는 뜻입니다.

![nginx](https://raw.githubusercontent.com/mrz1277/LoLKR/master/screenshots/nginx.png)

터미널에서 아래 커맨드를 입력해서 실행시켜주세요.

```
nginx
```

nginx 가 이미 실행중일때 재시작하는 커맨드:

```
nginx -s reload
```

nginx가 그래도 안되는데 어떻게하나요?

```
brew install nginx
```
만약에 안되시면 이슈넣어주세요.
### *`brew`를 이용한 `nginx` 설치가 잘 안됩니다.*

기존에 설치된 프로그램들과 충돌이 있는 경우가 있습니다. 터미널에 아래 커맨드를 입력해서 문제점을 진단해보세요.

```
brew doctor
```

### *업데이트 기간중에 패치가 되어버렸습니다. 다시 되돌릴 수 없나요?*

로컬에 웹서버를 둔 이상 로컬 메타파일이 업데이트 되면 다시 되돌리긴 어렵습니다. 그게 온라인상에 업데이트 서버가 있어야 하는 이유입니다.

### *다른 문제가 생겼어요.*

[이슈](https://github.com/mrz1277/LoLKR/issues)에 올려주세요. `closed` 탭에 들어가면 기존에 질문했던 내역들도 볼 수 있으니 올리기 전에 미리 검색해 보시면 도움이 됩니다. *개인 이메일로 직접 문의는 받지 않습니다.*

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
