# SQL Queries

In [what_is_sql.md](./what_is_sql.md), we looked at the 'S' in SQL. This document
aims to provide an overview of much that is meant by the 'Q' in SQL. Namely, the
pieces that make up a query and the questions/queries SQL is capable of expressing.

> Note: in the sqlfiddle.com links provided, you can (and should!) play around and
> run experiments to better understand how queries behave. Be aware, however, that
> the popularity of sqlfiddle will sometimes mean it takes some time to get back to
> you. If it is sluggish, give it a minute and try again

#### Simple Selection

Let's turn back to the very simple skittles table created in
[what_is_sql.md](./what_is_sql.md): http://sqlfiddle.com/#!17/df5a9

On the right side of the screen, we can define queries we'd like to run against
the the table defined at left. Let's see what it looks like to ask for all and only
the red skittles:

In English, I might ask you to give me (`SELECT`), from among your skittles (`FROM`) only
on the condition (`WHERE`) they are red. In SQL, this might be stated
```SQL
SELECT * FROM skittles WHERE color = 'red';
```
http://sqlfiddle.com/#!17/df5a9/2

The `*` tells SQL that we want all columns. Here's what the response looks like:
| id | color |
|----|-------|
| 1  | red   |
| 2  | red   |
| 7  | red   |
| 12 | red   |

If we wanted to be more precise, we could specify the exact columns we want back:
```SQL
SELECT id FROM skittles WHERE color = 'red';
```
http://sqlfiddle.com/#!17/df5a9/3

[query overview](https://www.postgresql.org/docs/9.6/static/queries-overview.html)


#### Joins

Sometimes, SQL databases are called *relational database management systems* (RDBMS). This
is because they're far more capable than simply retrieving values from individual tables.
They're also capable of - again, with the assistance of types - answering complex queries
which include references to other tables. In our skittles case, that would be analogous to
asking for all the skittles whose colors I have previously mentioned liking. In
the real world, you'd have to consult your memory about the colors I like and use that data
to pick out the appropriate skittles. SQL expressions formalize this idea of comparing two
otherwise disconnected datasets with the concept of a join.

Let's look at some queries that involve a join of two tables
```SQL
/* The table to join against with our existing skittles table */
CREATE TABLE people(
  name text,
  favorite_color text
);
```
http://sqlfiddle.com/#!17/6eb3e

> Watch out for types! We created an enum type for skittle colors, so we
> can't directly equality check people.color against skittles.color.
> What we need is some way to let the query know that we want to treat
> our skittles_color type like a normal text string. In programming, we
> refer to this as coercion: such a query is said to coerce one type
> into another.
> In SQL, we coerce with two colons - e.g. `skittles.color::text`
```SQL
SELECT skittles.color, people.name,
  FROM skittles.id, people
  WHERE skittles.color::text = people.favorite_color;

/* Alternatively */
SELECT skittles.id, people.name
  FROM skittles INNER JOIN people ON (skittles.color::text = people.favorite_color);
```
http://sqlfiddle.com/#!17/6eb3e/3

Joins come in a few flavors. These venn diagrams illustrate the relationships they encode:
![SQL joins](https://lukaseder.files.wordpress.com/2015/10/venn.png "SQL Joins as Venn Diagrams")

The different types are likely not all that important when you're first getting comfortable
with SQL. With that in mind, sticking to a simple `INNER JOIN` (the default case) is usually
fine when first trying to construct a query.

[join tutorial](https://www.postgresql.org/docs/9.6/static/tutorial-join.html)


#### Aggregation and Grouping

In the last section we were able to produce a table in which each row symbolizes
a skittle in our bag and a person whose favorite color that skittle is. It's kind of
difficult to see how that information could be used. Wouldn't it be more useful to
have a count of how many skittles match each person's preferences? No? Let's pretend.
But to do that, joining across tables won't be enough. Enter SQL aggregation.

The absolute simplest aggregation is to count up the rows in a table:

```SQL
SELECT COUNT(*) from skittles;
```
http://sqlfiddle.com/#!17/6eb3e/5

This simple count already illustrates something important to keep in mind: aggregations
take potentially many things and collapse them down into a single value. Taking the sum
of a list of numbers or finding the average or calculating the maximum value are all
common examples of aggregation. This might seem obvious, but this is easy to forget
when constructing complex queries.

Here's what adding a count of matching skittles would look like:
```SQL
SELECT count(skittles.id), people.name
  FROM skittles, people
  WHERE skittles.color::text = people.favorite_color
  GROUP BY people.name;

```
http://sqlfiddle.com/#!17/6eb3e/7

Note that there's no aggregation function on `people.name`. That's because we're
not aggregating anything on the name: we're using the name, rather, to collect up rows
for the sake of aggregation. The rule here is that values appearing in the `SELECT`
portion of your query must be either aggregations (`COUNT`, `MAX`, etc) or else
be found in the `GROUP BY` portion.

> Note that multiple columns appearing in `GROUP BUY` means that Postgres will
> build groups according to the Cartesian product of the provided columns

[list of aggregation functions](https://www.postgresql.org/docs/9.5/static/functions-aggregate.html)


