#!/bin/sh

docker run -it \
  -v $(pwd)/csv/election_map_20180917.csv:/docker-entrypoint-initdb.d/election_map_20180917.csv \
  -v $(pwd)/csv/geocoded_pa_voters.csv:/docker-entrypoint-initdb.d/geocoded_pa_voters.csv \
  -v $(pwd)/csv/political_parties.csv:/docker-entrypoint-initdb.d/political_parties.csv \
  -v $(pwd)/csv/voters.csv:/docker-entrypoint-initdb.d/voters.csv \
  -v $(pwd)/csv/zone_codes_20180917.csv:/docker-entrypoint-initdb.d/zone_codes_20180917.csv \
  -v $(pwd)/csv/zone_types_20180917.csv:/docker-entrypoint-initdb.d/zone_types_20180917.csv \
  -v $(pwd)/sql/election_map.sql:/docker-entrypoint-initdb.d/election_map.sql \
  -v $(pwd)/sql/geocoded_pa_voters.sql:/docker-entrypoint-initdb.d/geocoded_pa_voters.sql \
  -v $(pwd)/sql/political_parties.sql:/docker-entrypoint-initdb.d/political_parties.sql \
  -v $(pwd)/sql/voters.sql:/docker-entrypoint-initdb.d/voters.sql \
  -v $(pwd)/sql/zone_codes.sql:/docker-entrypoint-initdb.d/zone_codes.sql \
  -v $(pwd)/sql/zone_types.sql:/docker-entrypoint-initdb.d/zone_types.sql \
  quay.io/azavea/postgis:postgres9.6-postgis2.3
