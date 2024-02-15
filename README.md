# Mildly Interesting Triangulations

This repository contains triangulations in [polymake][polymake] JSON
format of various closed, orientable 4-dimensional manifolds. The
triangulations were obtained by conversion of [Regina][regina]
isomorphism signatures taken from a [census of manifolds][lofano] into
polymake files, and then simplifying them using `edge_contraction` and
`bistellar_simplification`. For each isomporphism signature, the
smallest triangulation by number of vertices was chosen, and then
duplicates (combinatorially isomorphic triangulations) were removed. 

## Contents

The triangulations are sorted by topological/PL-type, which was
determined by comparing them to a reference triangulation (or in the
case of the topology-ℂP², by computing the intersection form). The
triangulations are further sorted by number of vertices.

### ℂP²

The triangulation with 9 vertices is combinatorially isomorphic to the
[minimal triangulation][lutz-cp2] found in Frank H. Lutz's library of
triangulations. The triangulations with a larger amount of vertices
are triangulations which have been found to be PL-homeomorphic to ℂP²
using Regina's [retriangulate][retriangulate] tool, but elude
polymake's simplification capabilities. 

#### ℂP² (top)

This category are four triangulations which have been shown to be
homoeomorphic to ℂP² by computing the intersection form, however, it
is unknown whether they are also PL-homoeomorphic to ℂP² as they elude
all methods tried on them so far.

### ℂP²#S³xS¹

These 1464 triangulations have all been shown to be PL-Homeomorphic to
each other using retriangulate, however, polymake has big difficulties
in finding the PL-homeomorphisms between them. 




[polymake]: https://polymake.org/doku.php/start
[regina]: https://regina-normal.github.io/
[lofano]: https://github.com/davelofa/Census6Pentachora
[lutz-cp2]: https://www3.math.tu-berlin.de/IfM/Nachrufe/Frank_Lutz/stellar/library_of_triangulations/CP2.txt
[retriangulate]: https://regina-normal.github.io/docs/man-retriangulate.html
