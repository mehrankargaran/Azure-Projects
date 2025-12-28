#!/bin/bash

docker stop nginx1 2>/dev/null
docker rm nginx1 2>/dev/null

docker run -d \
--name nginx1 \
-p 80:80 \
nginx
