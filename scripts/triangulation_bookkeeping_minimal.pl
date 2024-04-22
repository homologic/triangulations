#!/usr/local/bin/polymake --script

### removes duplicate (combinatorially isomorphic) triangulations

use application "topaz";
use strict;
use warnings;
use DBI;

my $dbh = DBI->connect("dbi:Pg:dbname=researchdata_test", '', '', {AutoCommit => 0});
my $vst = $dbh->prepare("SELECT DISTINCT(vertices) FROM minimal_triangulations");
my $pst = $dbh->prepare("SELECT path FROM minimal_triangulations WHERE vertices = (?)");
my $pathdel = $dbh->prepare("DELETE FROM minimal_triangulations WHERE path = (?)");



$vst->execute();

while (my @data = $vst->fetchrow_array) {
	my $vert = shift @data;
	print("$vert\n");
	my %complexes = ();
	$pst->execute($vert);
	while (my @data = $pst->fetchrow_array ) {
		my $path = shift @data;
		$complexes{$path} = load_data("$path");
	}
	my @ck = keys %complexes;

	foreach (keys %complexes) {
		my $c = shift @ck;
		foreach (@ck) {
			if (defined $complexes{$_} and defined $complexes{$c} and isomorphic($complexes{$c}, $complexes{$_})) {
				print "$c $_ \n";
				$pathdel->execute($_);
				delete($complexes{$_});
			}
		}
	}
}


$dbh->commit;


