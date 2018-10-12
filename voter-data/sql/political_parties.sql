CREATE TABLE political_parties(
  code text PRIMARY KEY,
  description text
);

COPY political_parties FROM '/docker-entrypoint-initdb.d/political_parties.csv'
