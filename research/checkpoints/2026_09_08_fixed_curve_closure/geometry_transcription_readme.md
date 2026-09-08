# Fixed-curve geometry transcriptions

These new appendix inputs transcribe the completed ordinary proofs without
changing the existing published PDF, master TeX or historical proof files.

1. `paper/zero_slope_expansion.tex`: ZS1--4, including the translation and
   complementary-line comparison, exact rational recursions, full coefficient
   tails, cancelled ninefold functions, and the global constant precision.
2. `paper/certified_finite_disks.tex`: UD, SU and ZD, including all unit
   denominator and Gauss-tail arguments, exact finite residues, whole-disk
   Hensel uniqueness or obstruction, and every finite-fiber exception.
3. `paper/cubic_same_source_boundary.tex`: CB1--3, including all six points
   on the original quotient, the second square at the same source, exactly
   twelve boundary points, and the empty positive unit-zeta domain.
4. `paper/geometry_bibliography_additions.tex`: the additional normalized
   division-polynomial primary source, with the shared bibliography key
   `SutherlandDivisionPolynomials2023`.

The parent-owned RD/DS, IF and SM appendices supply the symmetry, infinity
certificate and complete rational sieve. They are independently reviewed in
`independent_root_geometry_transcription_review.json` and have a separate
publication inventory. In particular the complete fixed-curve rational-point
classification is used explicitly by CB, not inferred from a finite search.

`geometry_source_inventory.json` binds exactly the four inputs above, their
five ordinary source files, and all four exact replay scripts and canonical
results. The scripts have no external mathematical software dependency and
are replayed in place with `python <script-path> --check`. Their local imports
are listed; preserve those files together. The independent author and peer
write/check runs are already recorded by the ordinary-source checkpoints.

No new Lean declarations are introduced by these geometry transcriptions.
The local-height theory, complete analytic tails, curve morphisms and
rational sieve remain ordinary proofs with exact finite verification at the
specified arithmetic inputs. Neither the positive exclusion in one unit
class nor the fixed-curve classification proves uniform point heights for
varying exponents and residuals. The other nontrivial unit class is kept
separate until its own positive-domain argument is established.

Review state: root and both peers have completed full final review of all
three mathematical transcriptions and the bibliography, after the reported
TeX row/spacing corrections. All final hashes matched. Static environment
and math-delimiter checks pass. No new PDF compilation or visual review is
claimed by this geometry inventory.
