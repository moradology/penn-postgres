CREATE TABLE election_map(
  county text,
  election_number smallint,
  election_description text,
  election_date date,
  PRIMARY KEY(county, election_number)
);

COPY election_map FROM '/docker-entrypoint-initdb.d/election_map_20180917.csv' WITH DELIMITER E'\t' CSV;
