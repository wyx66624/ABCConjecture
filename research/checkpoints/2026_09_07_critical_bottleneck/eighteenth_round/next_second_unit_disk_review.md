# Independent full ordinary review: SU1--SU3

2026-09-07. Next-only review; no frozen source is changed.

I read the full
`2026_09_07_independent_route/eighteenth_round/next_second_unit_disk_certificate.md`,
SHA256 `c92af5f48e1879dc107aeaa96c368eb1fa6a837aa04b3aecbb778602a8f8ac6b`.
**Full ordinary PASS**, including the full analytic tail, the nonsimple
residue-root obstruction and the resulting complete four-disk exclusion.

The square-root branch at z=2 has W=12 and W'=1 modulo 25. The quotient
coordinates remain integral and their ordinates units. The displayed
phi/omega constants give inverses in the full integral u-series ring;
after u=5s this is a unit statement in the restricted Tate algebra, not
only pointwise at the center. Thus the already checked UD arguments give
g=f/5 in Z5<s> and bounded differentiation on the whole disk.

I checked the reduction from the local data: beta=81/2-1=2 modulo 5;
the pullback slopes are 2 and 4; the elliptic logarithm constants divided
by 5 are 4 and 2. Using 5alpha=(1,3), Xi=14 modulo 25 and the correct
sign f=F0+(4/3)log5(3) gives the coefficients (4,3,4). Consequently the
FULL restricted function reduces to 4(s+1)^2, rather than merely agreeing
at a collection of sampled s.

The only surviving residue is s=4. At its exact center z=22, the branch
W=32 modulo 125, Xi=24 and T=(90,10) determine the rational-function
values to the required precision because all denominators are units.
The fourth-power unit logarithm formula has entire tail of valuation at
least 3, so log Xi=100 and log 3=95 modulo 125 are certified residues.

The stronger R0(T) and L(T)-T bounds in 5^4A are valid: R0 is even and
starts in degree 4, so the potentially weaker degree-5 bound does not
occur; all later bounds suffice. L-T starts in degree 5 and its coefficient
bound gives valuation at least 4. Squaring the logarithm creates an error
of valuation at least 5 before multiplying by alpha of valuation -1.
Hence these terms cannot alter f modulo 125. The transported global
constants 5alpha=(16,3) modulo 25 need only the already proved precision.
Substitution yields g(4)=15 modulo 25 exactly. No rational-height equality
is assumed for either of these nonrational centers.

Since g'(4)=0 modulo 5 and g is an integral restricted series, the full
Taylor expansion yields g(4+5t)=15 modulo 25 Z5<t>. This excludes the
entire candidate subdisk, including any possible lift of the double
residue root. The other residues are excluded already modulo 5. DS then
transfers the empty zero set to all four +/-2 disks. The zero and infinity
orbits and rationality of additional UD zeros are not settled by SU.

## Actual independent finite check

I read the complete `next_replay_second_unit_disk.py`, SHA256
`abaa1c39cfb23a0476d2180d0b3a450f34f40b2f099d41cc4bb20c129888afc1`,
including its imports of the previously reviewed dual arithmetic and exact
rational ZS calculation. I then independently ran `--check`, which passed
with canonical JSON SHA256
`9c41ff73fad3875408856ff49e32c340cd6e272819eb17db8889dcf037f06dfa`.

This verifies the stated finite Hensel residues, dual division-polynomial
tables, exact unit-log fractions, global alpha inputs and modulo-25
obstruction. It does not replace the ordinary infinite-tail and
whole-subdisk Taylor arguments, and it is not a Lean proof or a decision
about all rational points.
