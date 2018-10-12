CREATE TABLE zone_types(
  county text,
  zone_number smallint,
  zone_short_name text,
  zone_long_name text,
  PRIMARY KEY(county, zone_number)
);

COPY zone_types FROM '/docker-entrypoint-initdb.d/zone_types_20180917.csv';
