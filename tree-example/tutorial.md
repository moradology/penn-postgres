# Visualizing data with PostGIS and QGIS

This tutorial is based off Tyler Dahlber's PostGIS blog post that can found [here.](https://www.azavea.com/blog/2015/06/19/loading-spatial-data-into-postgis-with-qgis/)  

It will use the same datasets, but will create the Postgres database using Docker instead of the Boundless OpenGeoSuite.

Docker makes the process easier (assuming you successfully have Docker running, if not, get it [here for mac](https://docs.docker.com/v17.12/docker-for-mac/install/) and [here for windows](https://docs.docker.com/v17.12/docker-for-windows/install/)).

It may be helpful to refer to Tyler's blog post for additional context, but this will be a self-contained tutorial.

## An overview of the steps:  
1. Create a Postgres database in Docker.
2. Connect your database to QGIS
3. Add the data to Postgres through QGIS
4. Analyze the data through the SQL generator in QGIS
5. Display the results through QGIS

### 1. Create a Postgres database in Docker.
##### 1a. From the terminal type in:
  

`docker run -p 5432:5432 -e POSTGRES_PASSWORD=mysecretpassword -d mdillon/postgis`
  

##### 1b. You should see something like this:
![image](https://user-images.githubusercontent.com/8103418/46502813-0afcf680-c7f7-11e8-987c-a455ff329c81.png)   
If you do, you have a container running on your computer with a Postgres database.

But what did you just do? Let's break down those commands:  
a. `docker run` :   Initiates a new container   
b. `-p 5432:5432` Enables the docker port 5432 to talk to your local machines port 5432   
c.  `POSTGRES_PASSWORD=mysecretpassword` : sets the postgres password  
d. `-d mdillon/postgis` : This is the docker image and the -d flag make it run in the background  
e.  Read more about Docker commands [here](https://docs.docker.com/engine/reference/commandline/cli/).    


### 2. Connect your database to QGIS
##### 2a. Open QGIS. Get it [here](https://qgis.org/en/site/forusers/download.html).   
##### 2b. Navigate to the browswer window on the left side of the screen, find the Postgres elephant, right click to create a *New Connection*. This will only work if port 5432 is open and running on the docker container.       
![image](https://user-images.githubusercontent.com/8103418/46503311-7eebce80-c7f8-11e8-9726-c6f15710d8ee.png)   
##### 2c. Follow these configurations:     
![image](https://user-images.githubusercontent.com/8103418/46503395-b9ee0200-c7f8-11e8-9648-e585eba8f480.png)   
##### 2d. *Test connection*
- username: postgres
- password: mysecretpassword     

##### 2e.  Hopefully you have a made a successful connection    

### 3. Add the data to Postgres through QGIS     
    
We will be using an open dataset of trees from an Azavea product called [OpenTreeMap](https://www.opentreemap.org/) along with a dataset of neighborhoods from Edmonton, Canada. Points and polygons are a great way to get started with geospatial queries using PostGIS.   
  
##### 3a: Download the data:   
- [Tree points](https://www.opentreemap.org/edmonton/map/)
- [Neighborhood polygons](https://data.edmonton.ca/Administrative/City-of-Edmonton-Neighbourhood-Boundaries-Map-View/jfvj-x253)   
  
##### 3b. Load them into QGIS. The Neighobrhood data is a zipped shapefile which can be loaded directly. The tree data has fields for lat/long and will need to be added with an addition step.   

##### 3c. Turn the tree data into a spatial layer in QGIS

> It’s possible to add data into a PostGIS database through the command line, but QGIS is more user friendly for people familiar with desktop GIS. Through QGIS add the CSV as a delimited text layer under Layer > Add Layer > Add Delimited Text Layer. Set the coordinate reference system (CRS) as WGS 84 (EPSG:4326) if prompted, after configuring your settings similar to the image below:

![image](https://user-images.githubusercontent.com/8103418/46506763-54ebd980-c803-11e8-94b1-b28061b38eb4.png)
   
You'll have to zoom in, but you should see something like this:

![oct-04-2018 18-32-44](https://user-images.githubusercontent.com/8103418/46506939-1a367100-c804-11e8-8344-541bed22cc31.gif)   
   

##### 3d. Add the data into the Postgres database:

> Open the ‘Database’ drop-down, connect to your database. You will likely need to type in the username and password again. Then click ‘Import layer/file...’.  Once connected, press ‘Add’. It will open a prompt for you to navigate to your shapefiles. If you haven’t yet saved the Edmonton trees that you mapped as a shapefile, now is the time. Once you’ve added shapefiles for both trees and neighborhoods, hit OK. Note: When I performed this step, it took several minutes to load the trees layer.
  
![image](https://user-images.githubusercontent.com/8103418/46507866-b793a400-c808-11e8-8eb8-3c08b89c61b8.png)
   



### 4. Analyze the data through the SQL generator in QGIS   

##### 4a. Getting Started in QGIS
In QGIS, open up the DB Manager:   

Once in DB Manager, click the SQL Query Icon (a paper with a wrench) and it will open the query manager. The top empty box is where you write SQL queries, and the bottom box shows the results.   
   
Spatial Queries with PostGIS
Each of the following queries uses what’s known as a spatial join. Spatial joins append information from one layer to another based on overlap, and are one of the key features of a spatial database. In a way, the shared key for the join is space rather than an ID field. The queries below assume you have two different datasets in your database: Edmonton trees, and neighborhoods.    
    
Count Trees and Display by Neighborhoods    
We’ll start out with this simple query to count up the number of trees per neighborhood using the standard SQL COUNT() function. The spatial part is the PostGIS function ST_Intersects(). ST_Intersects() looks for overlap in the geometry, which is stored in a field called `geom`.     

```sql
SELECT neighborhood_pg.name, neighborhood_pg.geom, neighborhood_pg.id,
COUNT(trees_pg.id) AS tree_count
FROM trees_pg
JOIN neighborhood_pg
ON ST_Intersects(trees_pg.geom, neighborhood_pg.geom)
GROUP BY neighborhood_pg.name, neighborhood_pg.geom, neighborhood_pg.id
ORDER BY tree_count DESC
```
The query should result in a table of the number of trees per neighborhood in descending order:
   
![image](https://user-images.githubusercontent.com/8103418/46508348-2bcf4700-c80b-11e8-8244-c84b435ff4e1.png)
   
We can see that the neighborhood with the most overall trees is Summerside, Followed by River Valley Rundle, and then Terwillegar Towne.

   
### 5. Display the results through QGIS
   
##### Export Query Results as Maps
Next, let’s export the maps from the PostGIS database in QGIS. The SQL Window in the DB Manager of QGIS allows users to export query results directly into QGIS as a new layer. Run one of the queries above and then look for the button labeled ‘Load as new layer’ below the result pane. This should expand a menu.

Click the ‘Retrieve columns’ button on the right and it should automatically grab the `id` and `geom`.  Finally, give the layer a name, and then press ‘Load now!’ This should add the layer to QGIS’ table of contents.
   
##### Style a Map
Once you’ve managed to load your query result as a new layer in QGIS, you should make a map and show off your hard work!   

This map can be created by clicking through a few of the settings in the properties:   
![image](https://user-images.githubusercontent.com/8103418/46508674-959c2080-c80c-11e8-9bcc-627f2bbf05a6.png)
   
   
##### Basic Chloropleth map in QGIS

1. Set it to "Graduated" at the top for symbology
2. Change the column to "tree_count"
3. Hit "Classify"

Note: If it's running slowly, exporting the SQL-generated layer to a local copy of the geometry can make the display amd color altering faster. 


#### A few more queries 

Let's try another query using the tree and neighborhood 
The first query took me a few minutes to run. However, there are ways to speed up the process. To do so, we will build an index.

When entered into the SQL window, the following command builds an index on the tree geometry column:
   
   `CREATE INDEX trees_index ON trees_pg USING gist(geom);`
    
This should make the following queries significantly faster.


### Calculate Tree Density Per Neighborhood

```sql
SELECT neighborhood_pg.name, neighborhood_pg.geom, neighborhood_pg.id,
COUNT(trees_pg.id)/neighborhood_pg.area_km2 AS tree_density
FROM trees_pg
JOIN neighborhood_pg
ON ST_Intersects(trees_pg.geom, neighborhood_pg.geom)
GROUP BY neighborhood_pg.name, neighborhood_pg.geom, neighborhood_pg.id
ORDER BY tree_density DESC
```

###

```sql
SELECT neighborhood_pg.name, neighborhood_pg.geom, trees_pg.species, MAX(trees_pg.diameter) as tree_diam
FROM trees_pg
JOIN neighborhood_pg 
ON ST_Intersects(trees_pg.geom, neighborhood_pg.geom)
GROUP BY neighborhood_pg.name, neighborhood_pg.id, neighborhood_pg.geom, trees_pg.species
ORDER BY tree_diam
```
#### Syntax suggestions 
Creating table alias' makes the SQL queries much more readable. The following query shows how to create an alias for `trees_pg` as `t` and `neighborhood_pg` as `n` and shorten the query above quite significantly 


```sql
SELECT n.name, n.geom, t.species, MAX(t.diameter) as tree_diam
FROM trees_pg t
JOIN neighborhood_pg n
ON ST_Intersects(t.geom, n.geom)
GROUP BY n.name, n.id, n.geom, t.species
ORDER BY tree_diam
```
