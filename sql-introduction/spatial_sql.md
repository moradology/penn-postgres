# Primer on Spatial SQL

Most SQL databases that are regularly used in production contexts have
extensions which enable them to process data with spatial properties. It is beyond
the purview of this document to describe spatial indexing strategies,
but they're the primary technology which makes spatial SQL possible. The
[PostGIS manual](https://postgis.net/docs/manual-2.5/) is an excellent
resource to consult as you develop your skills.

[spatial indexes](https://postgis.net/docs/manual-2.5/using_postgis_dbmanagement.html#idm2246)


#### spatial comparison

Joins in most SQL queries will simply check equality between two rows.
That's not really all that useful in space - it is extraordinarily rare
for two geometries of any complexity to be identical - so we need to be
able to construct predicates which recognize spatial similarity in its
various forms: in space, shapes can contain, intersect, lie within, and
cover other shapes. A proper spatial database needs to provide these
comparisons.

[spatial relationships and measurements](https://postgis.net/docs/reference.html#Spatial_Relationships_Measurements)


#### Consuming Shapefiles

Shapefiles are a very common format for storing and shipping spatial data.
For that reason, PostGIS comes with a command line tool to create tables
from shapefiles. It is good practice to experiment with real data when learning a
programming language, so you should take advantage of tools that make it
easy to start writing queries

[shp2pgsql](https://postgis.net/docs/manual-2.5/using_postgis_dbmanagement.html#shp2pgsql_usage)


#### Serialization

Serialization (storage in a specific, recoverable format) will involve
either [Well Known Text (WKT) or Well Known Binary
(WKB)](https://en.wikipedia.org/wiki/Well-known_text). PostGIS
provides functions to read and to write geometries out in either WKT, a text
format, or in WKB, a compact binary representation. If dumping results to a
CSV, one of these will commonly be used for a serialization strategy

[geom -> text](https://postgis.net/docs/ST_AsText.html)
[text -> geom](http://www.postgis.net/docs/ST_GeomFromText.html)
[geom -> binary](https://postgis.net/docs/ST_AsBinary.html)
[binary -> geom](http://www.postgis.net/docs/ST_GeomFromWKB.html)


#### Projections

This cannot be overstated: *DO NOT FORGET PROJECTIONS.* PostGIS allows
you to constrain spatial columns to a specific spatial projection - this
is advisable because it will fail instead of let you make nonsense
queries that compare geometries of different projections.

Projections are stored in PostGIS as Spatial Reference Identifier numbers.
99% of the maps you come across on the internet will be projected in web
mercator, which is SRID 4326.

[a function to set an SRID](https://postgis.net/docs/UpdateGeometrySRID.html)
[a function to reproject geometries](https://postgis.net/docs/ST_Transform.html)
[to project or not to project?](https://postgis.net/2013/08/30/tip_ST_Set_or_Transform/)

> NOTE: if SRIDs are not set appropriately, you may have to coerce types
> to appease PostGIS

