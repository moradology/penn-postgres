# SQL Queries

In [what_is_sql.md](./what_is_sql.md), we looked at the 'S' in SQL. This document
aims to provide an overview of much that is meant by the 'Q' in SQL. Namely, the
pieces that make up a query and the questions/queries SQL is capable of expressing.

> Note: in the sqlfiddle.com links provided, you can (and should!) play around and
> run experiments to better understand how queries behave. Be aware, however, that
> the popularity of sqlfiddle will sometimes mean it takes some time to get back to
> you. If it is sluggish, give it a minute and try again

#### Simple SELECTion

Let's turn back to the very simple skittles table we defined in
[what_is_sql.md](./what_is_sql.md): http://sqlfiddle.com/#!17/df5a9

On the right side of the screen, we can define queries we'd like to run against
the the table defined at left. Let's see what it looks like to ask for all and only
the red skittles:

In English, I might ask you to give me (`SELECT`), from among your skittles (`FROM`) only
on the condition (`WHERE`) they are red. In SQL, we say
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


#### Joins

Sometimes, SQL databases are called *relational database management systems* (RDBMS). This
is because they're far more capable than simply retrieving values from individual tables.
They're also capable of - again, with the assistance of types - answering complex queries
which include references to other tables. In our skittles case, that would be analogous to
asking for all the skittles whose colors I have previously mentioned liking. In
the real world, you'd have to consult your memory about the colors I like and use that data
to pick out the appropriate skittles. SQL expressions formalize this idea of comparing two
otherwise disconnected datasets with the concept of a join.

Joins come in a few flavors. These venn diagrams illustrate the relationships they encode:
![SQL joins](https://lukaseder.files.wordpress.com/2015/10/venn.png "SQL Joins as Venn Diagrams")




#### Types and coercion

TODO
