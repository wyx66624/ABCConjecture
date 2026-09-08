# UD1--UD3: independent ordinary, source and replay review

Status: **full ordinary proof PASS**, including its infinite analytic tail
arguments; the finite replay was separately read in full and actually run
with `--check`, terminal exit 0.

The actually read candidate `next_unit_disk_certificate.md` in the independent
route's eighteenth round has SHA256
`08decc8f07b2a5ef5c69b5f4682106ae2b74d3b225a5e87c9bc8502a00bed978`.
The replay `next_replay_unit_disk.py` has SHA256
`caa29c57312979eb5809d3c46c242e3ff8f6c01f1b78123abcad42e5e557e25b`.
Its canonical `next_unit_disk_exact.json` has SHA256
`2f3d604e73a27acd59d2ed47b418595b40c717efa5588a78584e963ab9f00ce7`.

The square-root derivative at the center is 6, and the integral implicit
function has unit derivative `2W=16`. Both quotient maps and all their
division recurrences are integral in the unscaled parameter. The modulus-five
center values `phi=omega9=1` and `psi9=0` therefore imply unit phi/omega and
`T in 5A` over the **whole** restricted disk after substituting `u=5s`.
They do not rely on avoiding nine-torsion points individually.

The normalized division-polynomial formulas and their multiplication-map
interpretation agree with the primary source actually reopened during this
review: [Sutherland, MIT 18.783 Lecture 5 (2023), section 5.5 and Theorem 5.21,
printed pages 10--11](https://math.mit.edu/classes/18.783/2023/LectureNotes5.pdf).
In particular `delta=-phi/omega9` has the correct sign and no factor-nine
discrepancy with the derivative formula in root's RD1.

The logarithm proof is uniform in the Tate algebra: the relative unit is
in `1+5sA`, and each omitted logarithm term has valuation at least
`j-v5(j)>=2`. The composition bounds use the previously proved **all-degree**
ZS coefficient bounds, not the 40-term replay. They give `R0(T) in 25A`,
`ell=L(T)/9 in 5A`, and, since `v5(alpha)=-1`, the squared-log term lies
in `5A`. Differentiation preserves these Gauss lower bounds because the
integer exponent multiplier has nonnegative valuation.

The pullbacks of the two invariant differentials are `2z/W` and `-2/W`.
Their center values, together with the actual sign `R2(0)=-P'`, give
`ell1/5=4+4s` and `ell2/5=3+s` modulo 5. Integration of every higher term
contributes valuation `j+1-v5(j+1)>=2`, so this calculation controls the full
series. The delta table gives beta=2; its logarithmic contribution is s.
The difference of the two squared-log terms contributes `s+2s^2`. Finally
the center constant is exactly zero by the already audited rational-height
identity and the complete LH away-from-five value set, rather than by a
truncation. This proves the stated `f/5 = 2s(s+1) mod 5A`.

For an integral restricted series, the Taylor remainder is in `h^2 Z5`
and the divided difference is integral. The two residue roots 0 and 4 have
unit derivatives 2 and 3; Hensel existence and the divided-difference
argument therefore prove one and only one zero in each residue class.
All other classes are excluded by the full reduction polynomial. This
also proves simplicity. The ordinate congruence at the second zero is
`W=8+30s=3 mod25`, as stated. DS acts on four distinct residue disks,
so the symmetry consequence counts exactly eight distinct local zeros.

The independently executed canonical check recomputes both complete dual
tables modulo 5 and 25, the division identities through the ninth multiple,
the global leading coefficients via the existing exact rational-series
routine, and the ninth-multiple parameter against rational binary addition.
Its use of the exact center height identity is labeled ordinary. This is
an independent execution and source audit of the author's verifier, not a
claim to have written a second dual implementation or formalized analysis.

The second zero and its orbit are only asserted to be Q5 points. Other
representative disks, the rationality sieve, intrinsic higher-genus QC
claims, moving exponents/residuals, and the parent ABC height bounds remain
outside this certificate. No missing parent interface is declared solved.
