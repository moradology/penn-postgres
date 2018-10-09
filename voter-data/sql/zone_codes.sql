CREATE TABLE zone_codes(
  county text,
  zone_number smallint,
  zone_code text,
  zone_description text,
  PRIMARY KEY(county, zone_number)
);
