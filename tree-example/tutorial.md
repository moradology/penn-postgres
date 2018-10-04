# Creating a PostGIS-enabled PostGres database, writing some SQL, and visualizing the results:

This tutorial is based off Tyler Dahlber's PostGIS blog post that can found [here](https://www.azavea.com/blog/2015/06/19/loading-spatial-data-into-postgis-with-qgis/)

It will use the same datasets, but will use Docker instead of the Boundless client to create a PostGres database.

Docker makes the process much easier (if you successfully have Docker running)

You can refer to Tyler's blog post for additional context, but this will be a self-contained tutorial

## An overview of the steps:  
1. Create a PostGres database in Docker.
2. Connect your database to QGIS
3. Add the data to PostGres through QGIS
4. Analyze the data through the SQL generator in QGIS
5. Display the results through QGIS

### 1. Create a PostGres database in Docker.
1a. From the terminal type in:

`docker run -p 5432:5432 -e POSTGRES_PASSWORD=mysecretpassword -d mdillon/postgis`

1b. You should see something like this:
![image](https://user-images.githubusercontent.com/8103418/46502813-0afcf680-c7f7-11e8-987c-a455ff329c81.png)

What did you just do? Let's break down those commands:  
a. `docker run` :   Initiates a new container 
b. `-p 5432:5432` Enables the docker port 5432 to talk to your local machines port 5432   
c.  `POSTGRES_PASSWORD=mysecretpassword` : sets the postgres password  
d. `-d mdillon/postgis` : This is the docker image            -d ???????????????????????????  


### 2. Connect your database to QGIS
2a. Open QGIS   
2b. Create a *New Connection* through the QGIS browser on the left   
![image](https://user-images.githubusercontent.com/8103418/46503311-7eebce80-c7f8-11e8-9726-c6f15710d8ee.png)
2c. Follow these configurations:   
![image](https://user-images.githubusercontent.com/8103418/46503395-b9ee0200-c7f8-11e8-9648-e585eba8f480.png)   
2c. *Test connection*
- username: postgres
- password: mysecretpassword   
2d.  Great success   

### 3. Add the data to PostGres through QGIS   
3a: Download the data:   
- Tree points
- Admin polygons   
### 4. Analyze the data through the SQL generator in QGIS   
4a. Connect asdfakjsf
4b.  askdfakl
### 5. Display the results through QGIS
5.a asdf 


