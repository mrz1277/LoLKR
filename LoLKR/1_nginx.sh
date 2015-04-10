#!/bin/sh

#  install_nginx.sh
#  LoLKR
#
#  Created by Jason Koo on 4/9/15.
#  Copyright (c) 2015 Jaesung Koo. All rights reserved.

# install
if hash brew 2>/dev/null; then
    brew update && brew install nginx
else
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install nginx
fi

# exceptions
if ! hash nginx 2>/dev/null; then
    echo "nginx가 설치되지 않았습니다."
    exit 1
fi

if [ ! -d "/usr/local/etc/nginx/" ]; then
    echo "nginx 설정 폴더(/usr/local/etc/nginx/)가 없습니다."
    exit 1
fi

# configuration
echo '
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
        rewrite      ^(.*)_kr/(.*)$   $1_na/$2;

        location / {
            proxy_pass  http://l3cdn.riotgames.com;
        }
    }
}
' > /usr/local/etc/nginx/nginx.conf

# start item
ln -sf /usr/local/opt/nginx/homebrew.mxcl.nginx.plist ~/Library/LaunchAgents/

# run
if ps ax | grep -v grep | grep nginx > /dev/null; then
    nginx -s reload
else
    nginx
fi