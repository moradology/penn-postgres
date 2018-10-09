CREATE TABLE election_map(
  county text,
  election_number smallint,
  election_description text,
  election_date date,
  PRIMARY KEY(county, election_number)
);
