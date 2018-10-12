CREATE TABLE zone_codes(
  county text,
  zone_number smallint,
  zone_code text,
  zone_description text,
  PRIMARY KEY(county, zone_number, zone_code)
);

COPY zone_codes FROM '/docker-entrypoint-initdb.d/zone_codes_20180917.csv';
