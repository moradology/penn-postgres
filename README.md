# SQL, PostGIS, and QGIS

### Requirements

1. A working Docker installation
  - [Mac users](https://docs.docker.com/v17.12/docker-for-mac/install/)
  - [Windows users](https://docs.docker.com/v17.12/docker-for-windows/install/)
  - Linux users (you're fine)

> NOTE ON WINDOWS INSTALLATIONS:
> Windows Professional edition ships with 'Hyper-V', which is required
> for modern Docker installations. Very likely, you have the Home
> edition of Windows and will have to use [Docker Toolbox](https://docs.docker.com/toolbox/toolbox_install_windows/),
> which is an older, clunkier method of using Docker. It can work, but
> we won't be spending significant time assisting with installation issues.
> It is *highly* recommended that you come to the workshop with a
> working installation of Docker to ensure you get the most from
> in-person instruction. Barring that, you will be asked to pair with
> someone whose installation works.

2. A [QGIS 3.X](https://qgis.org/en/site/forusers/download.html) installation

3. A working internet connection


### Sections


#### Docker Introduction

Introduction to 'containers', Docker's command line tools, and the
features most relevant to running PostGIS with QGIS

1. docker concepts
2. what can docker do?
3. how to put files on docker
4. communication with processes inside docker


#### SQL Introduction

A brief introduction to relational databases, the SQL standard,
the Postgresql dialect of SQL, and the 'GIS' of 'PostGIS'

1. What is SQL?
2. What are databases?
3. SQL Queries
5. Geometry concepts (PostGIS)

The [PostgreSQL Manual](https://www.postgresql.org/docs/9.6/static/index.html)


#### Introduction to QGIS

Instruction on loading and viewing layers in QGIS; connecting QGIS
to a running PostGIS instance

1. Loading and viewing layers
2. Coloring layers
3. Viewing layer attributes
4. Connecting to a database


#### Solving Tough Geospatial Problems

Two complex, real world datasets will be provided (as well as some
instruction and assistance in making them available through
PostGIS/QGIS) which invite a host of interesting questions. Sample
queries will be demonstrated, we will work through queries suggested in
class, and participants will have an opportunity to ask their own
questions with instructor assistance.


#### PostGIS Utilities

Extra utilities that we may/may not have time to cover

1. Using the COPY command to do bulk inserts
2. pgsql2shp
3. Application programming (demonstration only)



