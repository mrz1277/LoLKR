#!/bin/sh

#  1_nginx.sh
#  LoLKR
#
#  Created by Jason Koo on 4/9/15.
#  Copyright (c) 2015 Jaesung Koo. All rights reserved.
#
#  $> ./1_nginx.sh 8010 8020

# arguments
if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    exit 1
fi

# install
if type /usr/local/bin/brew 2>/dev/null; then
    /usr/local/bin/brew update && /usr/local/bin/brew install nginx
else
    echo "터미널에 다음 커맨드를 복사해서 brew를 먼저 설치해주세요. ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\""
    exit 1
fi

# exceptions
if ! type /usr/local/bin/nginx 2>/dev/null; then
    echo "nginx가 설치되지 않았습니다."
    exit 1
fi

if [ ! -d "/usr/local/etc/nginx/" ]; then
    echo "nginx 설정 폴더(/usr/local/etc/nginx/)가 없습니다."
    exit 1
fi

# configuration
echo "
worker_processes    1;

events {
    worker_connections  1024;
}

http {
    include       mime.types;
    default_type  text/plain;

    # disable auto-update
    server {
        listen       $1;
        server_name  localhost;

        location / {
            root        html;
            try_files   \$uri \$uri/ @cdn;
        }

        location @cdn {
            proxy_pass  http://l3cdn.riotgames.com;
        }
    }

    # enable auto-update
    server {
        listen      $2;
        server_name localhost;

        rewrite      ^(.*)_KR\$        \$1_NA;
        rewrite      ^(.*)_kr/(.*)\$   \$1_na/\$2;

        location / {
            proxy_pass  http://l3cdn.riotgames.com;
        }
    }
}
" > /usr/local/etc/nginx/nginx.conf

# start item
ln -sf /usr/local/opt/nginx/homebrew.mxcl.nginx.plist ~/Library/LaunchAgents/

# run
if ps ax | grep -v grep | grep -v 1_nginx | grep nginx > /dev/null; then
    /usr/local/bin/nginx -s reload
else
    /usr/local/bin/nginx
fi