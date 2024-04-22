#!/usr/local/bin/polymake --script

# Initialize table with triangulations

use application "topaz";
use strict;
use warnings;
use DBI;

my $dbh = DBI->connect("dbi:Pg:dbname=researchdata_test", '', '', {AutoCommit => 0});
my $sth = $dbh->prepare("INSERT INTO triangulations VALUES (?, ?, ?, ?);");

my $path = shift;

$path =~ m,([^/]+)\.poly$,;

my $regdesc = $1;

my $q=load_data("$path");

my $vert = @{$q->F_VECTOR}[0];


$sth->execute($regdesc, "@{$q->F_VECTOR}", $vert, $path);
$dbh->commit;


# after this run INSERT INTO minimal_triangulations SELECT DISTINCT ON (signature) * FROM triangulations ORDER BY signature, vertices ; to get a table of minimal triangulations of each complex
