## Scripts to filter out unique minimal triangulaitons

These scripts dig through directories to find triangulations, take the
minimal ones, remove duplicates, and then export them, sorted by PL-type. 


### Prerequisites

- Polymake
- PostgreSQL
- GNU Parallel

### How to use:

Create the database tables

```
CREATE TABLE triangulations (signature varchar, f_vector varchar, vertices integer, path varchar);
CREATE TABLE minimal_triangulations (signature varchar, f_vector varchar, vertices integer, path varchar);
```

Populate the triangulations table

```
find ~ -name *.poly -not -path "*comb_iso_classes*" -not -path "*flat*" | parallel --progress ./triangulation_bookkeeping.pl {}
```

Populate the minimal triangulations (by vertices) table by finding the
minimum triangulation for each signature

```
INSERT INTO minimal_triangulations SELECT DISTINCT ON (signature) * FROM triangulations ORDER BY signature, vertices 
```

Remove combinatorially isomorphic triangulations by running `triangulation_bookkeeping_minimal.pl`, and output sorted by type using `triangulation_bookkeeping_output.pl`
