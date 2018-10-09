#!/bin/sh

docker run -it -v $(pwd)/sql/:/docker-entrypoint-initdb.d/ quay.io/azavea/postgis:postgres9.6-postgis2.3
