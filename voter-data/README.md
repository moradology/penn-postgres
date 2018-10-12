### Preparing voter data

1. Pay ~$20 to download the dataset https://www.pavoterservices.pa.gov/pages/purchasepafullvoterexport.aspx
2. Remove quotes with find/replace or the use of
   [sed](https://www.gnu.org/software/sed/manual/html_node/Regular-Expressions.html)
3. Prepare your database with the appropriate tables/types (the [sql](./sql/)
   directory contains the table definitions used in demonstration, so feel free
   to reference them when constructing yours
4. Use [PostgreSQL's `COPY` command](https://www.postgresql.org/docs/9.6/static/sql-copy.html)
   to automatically ingest the CSV files you've cleaned. You'll likely have to
   run this command multiple times (and further clean your data to appease Postgres)
   before things actually work: iteration is to be expected

### Optional geocoding
5. Voter addresses exist within the downloaded voter file, so it is
   possible to extract that information and use one of the many services
   that will try to give you a point corresponding to each address. This
   is called geocoding and it is a must if you want to explore the
   spatial dimensions of a dataset
6. With python installed (preferably python 3) `pip install censusgeocode`, a python
   package that dramatically simplifies the task of geocoding 10s of thousands of addresses
7. Review this [example file](https://github.com/fitnr/censusgeocode/blob/master/tests/fixtures/batch.csv)
   and extract data of this format to a series of files that have - at most - 10,000
   entries per file (this is the maximum imposed on us by the (free!)
   [US census batch geocoder](https://www.census.gov/geo/maps-data/data/geocoder.html)
8. Submit each of those files for processing with the command line tool `censusgeocode`
   provides and [write the responses to a file](https://askubuntu.com/questions/420981/how-do-i-save-terminal-output-to-a-file)
   for storage: `censusgeocode --csv tests/fixtures/batch.csv >> geocoded_voters.csv`
9. Review [geocoded_pa_voters.sql](./sql/geocoded_pa_voters.sql) for table definitions
   and use Postgres' `COPY` as above
10. Don't forget to [turn lat/lon values into points](https://postgis.net/docs/ST_MakePoint.html)


