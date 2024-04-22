#!/usr/local/bin/polymake --script

### Outputs minimal triangulations into sorted directories

use application "topaz";
use strict;
use warnings;
use DBI;
use File::Copy;

my $dbh = DBI->connect("dbi:Pg:dbname=researchdata_test", '', '', {AutoCommit => 0});
my $types = $dbh->prepare("SELECT DISTINCT(type) FROM complexes;"); ## select the types



my $paths = $dbh->prepare("SELECT signature,vertices,path FROM minimal_triangulations WHERE signature IN (SELECT signature FROM complexes WHERE type = (?));");


my $outdir = "minimal_triangulations";
if (! -d $outdir ) {
	mkdir $outdir
}

$types->execute;
while (my @data = $types->fetchrow_array) {
	my $type = shift @data;
	if (not $type eq "") {
		print "$type\n";
		$paths->execute($type);
		if (! -d "$outdir/$type" ) {
			mkdir "$outdir/$type";
		}
		while (my @p = $paths->fetchrow_array) {
			my $sig = shift @p;
			my $vert = shift @p;
			if (! -d "$outdir/$type/$vert" ) {
				mkdir "$outdir/$type/$vert";
			}
			my $path = shift @p;
			copy($path,"$outdir/$type/$vert/$sig.poly");
		}
	}
}


$dbh->commit;

