# What is SQL?

SQL stands for 'Structured Query Language'. The 'structure' in sql is its row/column
storage format as well as its system of datatypes which both enable software to make inferences
about the sorts of questions which make sense to ask of a given table of data. If I hand
you a bag of skittles and ask that you give me all and only the skittles whose color is
greater than 3, you will rightly remind me that colors aren't quantities -
maybe I'm interested in the red or blue skittles? Whatever the case, you will certainly
know that I can't seriously want skittles 'whose color is greater than 3' (which is
literal nonsense).

Take a look at the datatypes [here](https://www.postgresql.org/docs/9.5/static/datatype.html).
Datatype selection is important for humans trying to understand what a column represents and
for the database itself, which will be able to ask more precise, meaningful questions
and to optimize its query plans to give you an answer more efficiently.


#### Our first table

In general, it is good practice to attempt translation of the programs you write (and
writing SQL *is* writing a program) into english and vice versa. You will catch mistakes
very easily in english that will be difficult to find in SQL and the practice will help
you to develop intuitions about the sorts of things that are possible in SQL. Let's
design a table to represent that bag of skittles.

First, we'll need to define the structure of the skittles table. Each skittle will need some
unique identifier (the DB needs this because otherwise records could be identical). Let's
try to keep things as simple as possible and include only the ID (which can simply be a
unique number) and the skittle color. For this first table, let's choose `integer`
(positive, whole numbers) for the ID and `text` for the color (we can just use the word
'red' to represent the concept red).

Creating a table
```SQL
CREATE TABLE skittles(
  id integer,
  color text,
  PRIMARY KEY(id)
);
```

Adding some skittles to the table
```SQL
INSERT INTO skittles (id, color) VALUES
  (1, 'red'),
  (2, 'red'),
  (3, 'purple');
```
http://sqlfiddle.com/#!17/473f8


#### Upgrading our first table

There are a couple of problems with this simple table. Let's fix those issues and see why they
matter.

1. Looks like we're repeating ourselves quite a bit and listing out information we don't actually
care about. Programmers are extremely lazy: they *never* like unnecessary work and very much
prefer to keep their code DRY (don't repeat yourself), so when it appears that you're repeating
yourself a lot, there's a good chance you're doing it wrong. The pattern of an incrementing ID
(which signifies nothing more than the identity of a row) is one such case. Computers are, if
anything, better at counting than we are so why should I be expected to tell it what comes after
2? You shouldn't and Postgresql supports a `Serial` datatype which simplifies things greatly. To
use this type, we'd simply replace `Integer` with `Serial`.

2. Skittles colors are not best represented as text. In the table we define above, 'a234dS$' would
be a valid color. But that's insane: we don't want our table to be polluted with values we can know
for certain are junk. To solve this problem, most SQL databases support the notion of an 'enum' type
(short for enumeration), which is some discrete set of options that can be used as a type. Skittles
colors are red, yellow, orange, green, and purple; so we want our table to choose from among these
options for the color column. By using an enum, we make ensure the database does not accept bad input.

Creating a `skittles_color` type
```SQL
CREATE TYPE skittles_color AS ENUM ('red', 'yellow', 'orange', 'green', 'purple');
```

Creating the table (note the types!)
```SQL
CREATE TABLE skittles(
  id Serial,
  color skittles_color,
  PRIMARY KEY(id)
);
```

Adding some skittles to the table (note the lack of id!)
```SQL
INSERT INTO skittles (color) VALUES
  ('red'),
  ('red'),
  ('purple');
```
http://sqlfiddle.com/#!17/df5a9

[enum types](https://www.postgresql.org/docs/9.6/static/datatype-enum.html)

We've already created our first table and carried out some useful optimizations on
it. Changing types (and thus, the structure) on our table can help to keep us sane
(so much less typing) and protect us from blundering future users (e.g. a future you).
Structure makes it possible to be sure that the questions we ask of our tables (i.e.
queries) are sensible. We won't be going further into the protections against user
error that exist within Postgres, but serious users and application developers
should take constraints seriously.

[table constraints](https://www.postgresql.org/docs/9.6/static/ddl-constraints.html)


#### Database Indexes

"Database Index" is an imposing term that stands for a simple notion. Consider
non-electronic dictionaries: by alphabetizing entries, finding one word out of tens of
thousands becomes a trivial task. Lacking an alphabetical index (being in some random
order), users would have to read every entry until they found the specific word of interest.
Database indexes do basically the same thing. By storing data in some predictable pattern,
the database is capable of skipping many - even most - irrelevant data.

```SQL
CREATE INDEX name ON table USING gin(column);
```

```SQL
CREATE INDEX name ON table USING gist(column);
```


We'll have use for indexes later, as we begin to ask some complex
spatial queries.

[index intro](https://www.postgresql.org/docs/9.6/static/indexes-intro.html)
[creating indexes](https://www.postgresql.org/docs/9.6/static/sql-createindex.html)
[types of index](https://www.postgresql.org/docs/9.6/static/indexes-types.html)

