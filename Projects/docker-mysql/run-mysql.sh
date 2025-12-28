#!/bin/bash

docker stop vprodb 2>/dev/null
docker rm vprodb 2>/dev/null

docker run -d \
--name vprodb \
-e MYSQL_ROOT_PASSWORD=secretpass \
-p 3030:3306 \
-v /root/vprodbdata:/var/lib/mysql \
mysql:5.7
