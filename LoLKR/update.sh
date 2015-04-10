#!/bin/sh

#  4_update_on.sh
#  LoLKR
#
#  Created by Jason Koo on 4/10/15.
#  Copyright (c) 2015 Jaesung Koo. All rights reserved.

if [ -z "$1" ]; then
    echo "전달인자가 필요합니다. on 또는 off"
    exit 1
fi

BASE_DIR=""
if [ -z "$2" ]; then
    BASE_DIR="/Applications/League of Legends.app/Contents/LoL/RADS"
else
    BASE_DIR="$2/Contents/LoL/RADS"
fi

if [ ! -d "$BASE_DIR" ]; then
    echo "롤 설치 경로를 확인해 주세요."
    exit 1
fi

if [ "$1" == "on" ]; then
    sh ./2_download_versions.sh
    perl -pi -e 's/8010/8020/g' "$BASE_DIR/system/system.cfg"
    echo "업데이트를 허용 하였습니다. 롤을 다시 시작해서 업데이트를 진행하세요. 업데이트가 끝나면 다시 off 해주세요."
fi

if [ "$1" == "off" ]; then
    perl -pi -e 's/8020/8010/g' "$BASE_DIR/system/system.cfg"
    echo "자동 업데이트가 정상적으로 차단되었습니다. 한국 서버가 업데이트가 될때까지 off 해주시면 됩니다."
fi