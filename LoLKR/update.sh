#!/bin/sh

#  update.sh
#  LoLKR
#
#  Created by Jason Koo on 4/10/15.
#  Copyright (c) 2015 Jaesung Koo. All rights reserved.
#
#  $> ./update.sh on 8010 8020 "/Application/League of Legends.app"

# arguments
if [ "$#" -lt 4 ]; then
    echo "Illegal number of parameters"
    exit 1
fi

if [ "$1" = "on" ] || [ "$1" = "off" ]; then
    echo ""
else
    echo "첫번째 전달인자는 on 또는 off 입니다."
    exit 1
fi

if [ ! -d "$4" ]; then
    echo "롤 설치 경로를 확인해 주세요."
    exit 1
fi

#
if [ "$1" = "on" ]; then
    sh "$5"
    echo "DownloadPath = /releases/Maclive
    DownloadURL = 127.0.0.1:$3
    Region = KR" > "$4/Contents/LoL/RADS/system/system.cfg"
    echo "업데이트를 허용 하였습니다. 롤을 다시 시작해서 업데이트를 진행하세요. 업데이트가 끝나면 다시 업데이트 방지로 변경해주세요."
fi

if [ "$1" = "off" ]; then
    echo "DownloadPath = /releases/Maclive
    DownloadURL = 127.0.0.1:$2
    Region = KR" > "$4/Contents/LoL/RADS/system/system.cfg"
    echo "자동 업데이트가 정상적으로 차단되었습니다. 한국 서버가 업데이트가 될때까지 이상태로 두시면 됩니다."
fi