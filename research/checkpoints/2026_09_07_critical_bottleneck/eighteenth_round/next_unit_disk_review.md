# Independent review of UD1--UD3 and its finite input

2026-09-07. Next-only review; no frozen publication file is changed.

I read the entire ordinary note
`2026_09_07_independent_route/eighteenth_round/next_unit_disk_certificate.md`,
SHA256 `08decc8f07b2a5ef5c69b5f4682106ae2b74d3b225a5e87c9bc8502a00bed978`.
I also re-read the actual ZS9 expression and the complete root DS1--DS3
symmetry note, rather than relying only on its peer review. **Full ordinary
PASS**, including the entire analytic tail and the exact two-zero claim.

The local coordinate substitution u=5s maps integral formal series to the
restricted Tate algebra. The derivative 2W=16 is a unit, and the two
quotient ordinates are units throughout this disk. The division-polynomial
recurrences therefore use only invertible denominators in Z5[[u]]. The
actual constants phi=omega9=1 modulo 5 imply invertibility on the full disk;
psi9 in 5A gives T in 5A without excluding nine-torsion points. The formulas
delta=-phi/omega9 and T=-phi psi9/omega9 remove the apparent division by
psi9 exactly.

I independently reopened Andrew Sutherland's MIT 18.783 Lecture 5 (2023),
section 5.5, printed pages 10--11, and checked the initial values,
recurrences, phi/omega definitions and Theorem 5.21 multiplication formula:
https://math.mit.edu/classes/18.783/2023/LectureNotes5.pdf . These agree with
the literal conventions in the ordinary note and the finite program.

The full logarithm tail in 25A follows from j-v5(j)>=2 for j>=2, not from
inspection of finitely many coefficients. ZS's two coefficient bounds
continue to hold after composition in the Gauss norm. They imply convergence
in Q5<s>, R0(T) in 25A, L(T)/9 in 5A, and f/5 in A because v5(alpha)=-1.
Differentiation is bounded on the restricted Tate algebra, so the same
control applies to derivatives. The integrated pullback-differential tail
is likewise in 25A, since j+1-v5(j+1)>=2 for j>=1.

The dual table yields beta=2 modulo 5. The Xi logarithm contributes s to
(f(s)-f(0))/5. The two squared elliptic logarithms contribute s+2s^2,
using ell1/5=4+4s, ell2/5=3+s and 5 alpha=(1,3). The exact rational center
identity supplies f(0)=0; it is already justified by the audited global
height identity and the complete away-from-five value set, not presumed
for other zeros. Hence the congruence is for the full function in A:
f/5=2s(s+1) modulo 5A.

The only residue roots are 0 and 4, with unit derivatives 2 and 3.
Restricted-series Taylor and divided-difference identities justify both
Newton existence and uniqueness on each subdisk. Thus the representative
disk has exactly two simple Q5 zeros, one at the rational center and one
with z=21, W=3 modulo 25. DS gives analytic isomorphisms to the other three
unit disks, preserving the function and multiplicity; hence exactly eight
zeros on those four disks. The new zeros are not asserted Q-rational, and
the zero, infinity and +/-2 orbits remain outside this certificate.

## Independent finite execution

I read the entire `next_replay_unit_disk.py`, SHA256
`caa29c57312979eb5809d3c46c242e3ff8f6c01f1b78123abcad42e5e557e25b`,
then actually ran its `--check` command. It passed with canonical JSON SHA256
`2f3d604e73a27acd59d2ed47b418595b40c717efa5588a78584e963ab9f00ce7`.

The program checks dual jets modulo 5 and 25, the multiplication curve
identity for indices 2 through 9, the full psi table through 11, and the
nonvanishing regular denominators. It derives the leading global constants
from the already audited exact rational ZS computation and compares the
modulo-25 formal parameter against a separate rational binary group-law
calculation. The full analytic tail and the rational-center identity remain
ordinary mathematical inputs; this finite run is not misreported as their
proof, as a rationality sieve, or as a Lean verification.
