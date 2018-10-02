# Docker and PostGIS

[Note on installing Docker for Windows](docker-on-windows.md)


### What is Docker?

1. what can docker do?
2. how to talk to docker
3. how to put files on docker
4. docker compose to get programs to communicate with each other


### What is a database?

1. Types of DB
2. DB types (postgres + postgis)
2. Indices
3. Query Language
4. High level concepts

> Q: What's makes a database 'spatial'?
> A: Spatial predicates, spatial indices, GIS convenience


### Connecting to your database

1. Using Docker `exec` to get into your container
2. Forwarding ports with docker


### Ingesting Data

1. Creating tables
2. Inserting data
3. Updating data
4. Using the COPY command to do bulk inserts
5. QGIS insertion
5. Application programming (demonstration only)


### Queries

> Note: For a full list of Postgresql keywords, visit https://www.postgresql.org/docs/8.1/static/sql-keywords-appendix.html

1. Basics: SELECT; WHERE; FROM
2. Predicates
3. Spatial predicates


### Advanced Patterns

1. Joins
2. Subqueries & aliases & WITH
3. Grouping
4. Aggregations
5. TBD


### PostGIS Utilities

1. Geometry constructors
2. Spatial predication
  - Testing spatial relationships
  - Deriving measurements
3. ST_As . . .
4. QGIS export
5. pgsql2shp

### Visualizing

1. QGIS
2. ST_AsGeoJSON




