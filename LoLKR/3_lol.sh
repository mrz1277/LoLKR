#!/bin/sh

#  3_lol.sh
#  LoLKR
#
#  Created by Jason Koo on 4/9/15.
#  Copyright (c) 2015 Jaesung Koo. All rights reserved.
#
#  $> ./3_lol.sh "/Applications/League of Legends.app" 8010

# arguments
if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    exit 3
fi

if [ ! -d "$1" ]; then
    echo "롤 설치 경로를 확인해 주세요."
    exit 3
fi

BASE_DIR="$1/Contents/LoL/RADS"

# add korea server on menu
echo "na,            na,            en_US,                                                                                                                                                          A
br,            br,            pt_BR,                                                                                                                                                          A
tr,            tr,            tr_TR,                                                                                                                                                          A
euw,           euw,           en_GB|de_DE|es_ES|fr_FR|it_IT,                                                                                                                                  A
eune,          eune,          en_GB|cs_CZ|el_GR|hu_HU|pl_PL|ro_RO,                                                                                                                            A
ru,            ru,            ru_RU,                                                                                                                                                          A
la1,           la1,           es_MX,                                                                                                                                                          A
la2,           la2,           es_MX,                                                                                                                                                          A
oc1,           oc1,           en_AU,                                                                                                                                                          A
kr,            kr,            ko_KR|en_US,                                                                                                                                                    A
" > $BASE_DIR/projects/lol_patcher/managedfiles/0.0.0.0/regions.txt

echo "na,            NA,            lol_air_client_config_na,                                   NA1,                                                        prod.na1.lol.riotgames.com,                                 status.leagueoflegends.com
br,            BR,            lol_air_client_config_br,                                   BR1,                                                        prod.br.lol.riotgames.com,                                  status.leagueoflegends.com
tr,            TR,            lol_air_client_config_tr,                                   TR1,                                                        prod.tr.lol.riotgames.com,                                  status.leagueoflegends.com
euw,           EUW,           lol_air_client_config_euw,                                  EUW1,                                                       prod.euw1.lol.riotgames.com,                                status.leagueoflegends.com
eune,          EUNE,          lol_air_client_config_eune,                                 EUN1,                                                       prod.eun1.lol.riotgames.com,                                status.leagueoflegends.com
ru,            RU,            lol_air_client_config_ru,                                   RU,                                                         prod.ru.lol.riotgames.com,                                  status.leagueoflegends.com
la1,           LA1,           lol_air_client_config_la1,                                  LA1,                                                        prod.la1.lol.riotgames.com,                                 status.leagueoflegends.com
la2,           LA2,           lol_air_client_config_la2,                                  LA2,                                                        prod.la2.lol.riotgames.com,                                 status.leagueoflegends.com
oc1,           OC1,           lol_air_client_config_oc1,                                  OC1,                                                        prod.oc1.lol.riotgames.com,                                 status.leagueoflegends.com
kr,            KR,            lol_air_client_config_kr,                                   KR,                                                         prod.kr.lol.riotgames.com,                                  status.leagueoflegends.com
" > $BASE_DIR/projects/lol_patcher/managedfiles/0.0.0.0/shards.txt

echo "English, en_US
Português, pt_BR
Türkçe, tr_TR
English, en_GB
Deutsch, de_DE
Español, es_ES
Français, fr_FR
Italiano, it_IT
Čeština, cs_CZ
Ελληνικά, el_GR
Magyar, hu_HU
Polski, pl_PL
Română, ro_RO
Русский, ru_RU
Español, es_MX
English, en_AU
Korean, ko_KR" > $BASE_DIR/projects/lol_patcher/managedfiles/0.0.0.7/languages.txt

# change update server address
echo "DownloadPath = /releases/Maclive
DownloadURL = 127.0.0.1:$2
Region = KR" > "$BASE_DIR/system/system.cfg"

# change login server address
if [ ! -d "$BASE_DIR/projects/lol_air_client_config_na/releases" ]; then
    echo "북미 서버를 먼저 선택하고 업데이트가 완료되어야 합니다."
    exit 3
fi

if [ ! -d "$BASE_DIR/projects/lol_air_client_config_kr" ]; then
    cp -r "$BASE_DIR/projects/lol_air_client_config_na" "$BASE_DIR/projects/lol_air_client_config_kr"
fi

find "$BASE_DIR/projects/lol_air_client_config_kr" -name "lol.properties" | while read filename; do echo "host=prod.kr.lol.riotgames.com,prod.kr.lol.riotgames.com
xmpp_server_url=chat.kr.lol.riotgames.com
lq_uri=https://lq.kr.lol.riotgames.com
rssStatusURLs=null
regionTag=kr
lobbyLandingURL=http://frontpage.kr.leagueoflegends.com/ko_KR/client/landing
featuredGamesURL=http://spectator.kr.lol.riotgames.com:80/observer-mode/rest/featured
storyPageURL=http://www.leagueoflegends.co.kr/launcher/journal.php
ladderURL=http://www.leagueoflegends.co.kr
platformId=KR
ekg_uri=https://ekg.riotgames.com
riotDataServiceDataSendProbability=1.0" > "$filename"; done

echo "airConfigProject = lol_air_client_config_kr" > "$BASE_DIR/system/launcher.cfg"
echo "locale = ko_KR" > "$BASE_DIR/system/locale.cfg"
