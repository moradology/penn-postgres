CREATE TYPE match_type AS ENUM ('Exact', 'Non_Exact', 'Tie', 'No Match');

CREATE TABLE geocoded_voters(
  id text PRIMARY KEY,
  address text,
  match boolean,
  match_type match_type,
  parsed_address text,
  tigerlineid integer,
  side text,
  lat float,
  lon float
);

COPY geocoded_voters FROM '/docker-entrypoint-initdb.d/geocoded_pa_voters.csv' WITH (FORMAT CSV, DELIMITER E',', QUOTE '"');

