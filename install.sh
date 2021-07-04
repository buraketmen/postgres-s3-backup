#! /bin/sh

set -e
apk update
apk add postgresql-client
apk add python3 py3-pip
pip3 install awscli
apk add curl
curl -L https://github.com/odise/go-cron/releases/download/v0.0.6/go-cron-linux.gz | zcat > /usr/local/bin/go-cron
chmod u+x /usr/local/bin/go-cron
apk del curl
rm -rf /var/cache/apk/*
