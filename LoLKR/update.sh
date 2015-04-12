#!/bin/sh

#  update.sh
#  LoLKR
#
#  Created by Jason Koo on 4/10/15.
#  Copyright (c) 2015 Jaesung Koo. All rights reserved.
#
#  $> ./update.sh on 8010 8020 "/Application/League of Legends.app"

# arguments
if [ "$#" -ne 3 ]; then
    echo "Illegal number of parameters"
    exit 1
fi

if [ ! ("$1" == "on" && "$1" == "off") ]; then
    echo "첫번째 전달인자는 on 또는 off 입니다."
    exit 1
fi

if [ ! -d "$4" ]; then
    echo "롤 설치 경로를 확인해 주세요."
    exit 1
fi

BASE_DIR="$1/Contents/LoL/RADS"

#
if [ "$1" == "on" ]; then
    sh ./2_download_versions.sh
    perl -pi -e 's/$2/$3/g' "$BASE_DIR/system/system.cfg"
    echo "업데이트를 허용 하였습니다. 롤을 다시 시작해서 업데이트를 진행하세요. 업데이트가 끝나면 다시 off 해주세요."
fi

if [ "$1" == "off" ]; then
    perl -pi -e 's/$3/$2/g' "$BASE_DIR/system/system.cfg"
    echo "자동 업데이트가 정상적으로 차단되었습니다. 한국 서버가 업데이트가 될때까지 off 해주시면 됩니다."
fi