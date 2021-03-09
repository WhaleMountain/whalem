#!/bin/bash

DOMAINS=$1

if [ -z $DOMAINS ]; then
	echo "Please domain"
	exit 1
fi	

EMAIL="whalemountain4@gmail.com"
CMD="--email $EMAIL --domains $DOMAINS --http --accept-tos run"

docker run \
	-v /home/mk/whalemountain/lego/certs:/.lego \
	-p 80:80 \
	-p 443:443 \
	--rm -it \
	--name lego \
	goacme/lego:v4.1.3 $CMD
