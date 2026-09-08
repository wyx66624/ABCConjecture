# Independent geometry inputs for descent and shift

The four ordinary sources have received complete independent reviews
from root, critical_bottleneck and adversarial_audit. The complete
mathematical TeX transcriptions have also received full reviews;
including the final minor domain/citation clarifications.
Exact byte hashes and review records are in
`geometry_source_inventory.json`.

The new proof resolves the distinct squared-unit cubic quotient

    y^2=-3s(s+1)(s^3-3s-1).

Its Jacobian has rank zero and rational group (Z/2Z)^2. The curve has
exactly the three rational branch points over s=0,-1,infinity. The
common-source biquadratic curve has exactly six rational boundary
points. This is an ordinary two-descent on the whole Jacobian, using
the stated standard external descent theorem. It does not come from
a finite search, analytic rank, or a software rank oracle.

Combining the independently established identity and zeta unit
branches gives the precise arithmetic exclusion: no positive coprime
integers a,b satisfy both

    a^2+ab+b^2=U^2,
    a^4+3a^3*b+5a^2*b^2+3a*b^3+b^4=Q^3.

The proof explicitly reconstructs the same integral Eisenstein source,
checks three-adic ramification, and exhausts all units. Each odd
multiple of three has the same positive-locus exclusion by a
projective morphism. Numerical perfect powers with any exponent
divisible by three reduce directly to the cubic statement; no even
geometric connectedness is claimed.

Inputs for the new appendix, in order:

1. `paper/zeta_squared_quotient.tex`: model, full cubic cover, local
   residue, two-torsion, complete finite certificates and the precise
   rank-zero-to-point-set implication.
2. `paper/zeta_squared_two_descent.tex`: entire-Jacobian descent,
   all finite-extension valuations including at two, class and unit
   arithmetic, full local image, real signatures, rank and points,
   and the actual three-unit connection with propagation.
3. `paper/ramified_cubic_exclusion.tex`: all three ramified
   common-source covers are empty over Q3; a separate exact integral
   extraction proves the stronger F=Q^3 implies 3 does not divide M.
   The complete projective propagation, three-adic input cases and
   numerical-local calibration are included.
4. `paper/bibliography_geometry.tex`: new StollTwoDescent2001 entry
   only. MilneANT2020 and StacksCurves2026 are existing keys.

Labels use z2x, zd2x and rsx prefixes. The finite certificate is fully
replayable with the standard library and --check; its canonical hash
is in the source inventory. No Lean theorem for the full descent,
PDF compilation, or visual inspection is asserted here. The parent
controls manuscript integration and publication.

The new ramified theorem excludes M=3R^h together with F=Q^g for
every positive h and every positive g divisible by three. Its
integral statement does not require the first norm to be three
times a square. This supplements the historical unramified source;
that frozen source has not been rewritten.

The local geometric exclusion is stronger than an affine-chart
calculation but is not a claim that the bare numerical norm
equations are locally insoluble. For example a=1,b=4 gives M=21,
F=541, and both required numerical roots exist over Q3. Global
integral UFD extraction supplies the extra common-source restriction.

The unramified nonsquare first norm with F a cube remains outside
these exclusions. General residuals for which the total norm is
not the requisite perfect power, other indices, uniform heights
for moving curves, and coverage of all ABC triples remain open.
These are complete ordinary fixed-family proofs, not an ABC proof.
