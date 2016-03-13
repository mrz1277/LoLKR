#!/bin/sh

#  2_download_versions.sh
#  LoLKR
#
#  Created by Jason Koo on 4/9/15.
#  Copyright (c) 2015 Jaesung Koo. All rights reserved.
#
#  $> ./2_download_versions.sh

# nginx home folder check
if [ ! -d "/usr/local/var/www" ]; then
    echo "nginx 홈 폴더(/usr/local/var/www)가 존재하지 않습니다."
    exit 2
fi

# check folder structures
cd /usr/local/var/www
if [ ! -d "/usr/local/var/www/releases/Maclive" ]; then
    mkdir -p releases/Maclive && cd releases/Maclive
    mkdir -p projects/lol_air_client/releases
    mkdir -p projects/lol_air_client_config_kr/releases
    mkdir -p projects/lol_launcher/releases
    mkdir -p projects/lol_patcher/releases
    mkdir -p solutions/lol_game_client_sln/releases
    mkdir -p system
fi

# download files
cd /usr/local/var/www/releases/Maclive
BASE_URL="http://l3cdn.riotgames.com/releases/Maclive"
curl -o solutions/lol_game_client_sln/releases/releaselisting_KR $BASE_URL/solutions/lol_game_client_sln/releases/releaselisting_OC1
curl -o projects/lol_air_client/releases/releaselisting_KR $BASE_URL/projects/lol_air_client/releases/releaselisting_OC1
curl -o projects/lol_air_client_config_kr/releases/releaselisting_KR $BASE_URL/projects/lol_air_client_config_oc1/releases/releaselisting_OC1
curl -o projects/lol_launcher/releases/releaselisting_KR $BASE_URL/projects/lol_launcher/releases/releaselisting_OC1
curl -o projects/lol_patcher/releases/releaselisting_KR $BASE_URL/projects/lol_patcher/releases/releaselisting_OC1
curl -o system/filelist.versioninfo $BASE_URL/system/filelist.versioninfo