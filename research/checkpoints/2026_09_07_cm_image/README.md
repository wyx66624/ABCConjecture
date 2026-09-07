# Eighth continuation: global image and pure-power support

Standard ABC remains unproved and undisproved. This checkpoint integrates
independently reviewed ordinary results, three exact finite replays, and
ten new scoped Lean declarations. It does not contain a complete formal
proof of the new modular or analytic theorems, or a solution of ABC.

## What is proved in the ordinary arguments

- CB: actual positive seeds have a large nonsolvable projective image at
  p>7. This excludes all CM residual candidates, including at varying levels
  and weights. The pure fixed-level branch leaves two non-CM orbits.
  An independent actual CM-boundary shadow family passes the specified
  finite local tests; it asserts no global power equation.
- BT: the level-288 and level-576 non-CM orbits are exact quadratic twists.
  Both independent implementations check every coefficient through 12288
  at the proved common level 36864. All coefficient embeddings and the
  four possible quadratic characters are retained. Consequently every
  actual F(a,b)=Q^p, p>7 prime, has the stated boundary residual module.
- TS: rational boundary two-torsion forces even traces. The ordinary
  local filtration excludes p dividing F and proves, for every prime q|Q,
  q >= (sqrt(2p)-1)^2 > p. Neither 7 nor 13 divides Q. The necessary
  support density is a fixed-p statement, with no uniform error estimate.
- HB: these pure powers satisfy p^p < F <= 13 max(a,b)^4 and the effective
  exponent budget p=O(log H/log log H). This is a point-height lower bound,
  not a uniform upper bound or a nonexistence theorem.
- AW: the actual sieved root window now works at all exponent indices,
  with endpoint floor[n^4 sqrt(log n)/(1+log log n)]. The full upper tail
  and prescribed exceptional roots remain open.

The full proofs and independent reviews are in the three agents'
`eighth_round` directories and `verification/ordinary_review.md`.
The next signed-arm research is kept in `ninth_round`; it is outside
this frozen checkpoint's mathematical claims and verification scope.

## Actual verification

Run in the pinned Lean 4.32.0 / PARI 2.15.4 Linux environment:

```sh
python3 research/checkpoints/2026_09_07_cm_image/verify_round.py
python3 research/checkpoints/2026_09_07_cm_image/verify_finite.py
```

The fresh scoped Lean build checks 10 new and 55 unchanged dependency
declarations, with only propext, Classical.choice and Quot.sound in the
complete axiom inventory. The explicit factor-congruence and p<Q
antecedents remain in the signatures. Elliptic representations, modularity,
Sturm's theorem, modular-form construction and real logarithms are outside
that module's formal scope.

The finite replays comprise 16 complete field rows / 81376 affine states /
32 actual CM shadows, and two independently implemented full-Sturm
comparisons. The first retains 12289 coefficient rows per form; the second
checks 98312 rational-coordinate equalities. They use exact PARI modular
algorithms. Both wrappers reject GP errors even if GP exits with code zero.
The earlier `twist_288_probe.gp` is a discovery record, not the verifier.

The full designated manuscript is compiled by `build_manuscript.py`.
`seal_manuscript.py` requires the matching rendered-page review and source
inventory before replacing the designated PDF. The final page count,
PDF hash, actual TeX input hashes and viewed raster hashes are recorded in
`verification/manuscript_validation.json`; compiler success alone is not
visual review. The GitHub workflow `abc-boundary-support.yml` reruns the
scoped Lean audit and all three finite certificates.

## Open gates

The surviving pure branch has not been excluded. The support restrictions
are compatible with moving large primes and arbitrarily high seeds.
Nonunit residual levels, moving covers' actual point heights, simultaneous
first-norm compression, and the full signed private-prime tail remain open.
No route is retired merely because these gates are difficult. The CM
candidate branch is removed by its exact projective-image contradiction.
