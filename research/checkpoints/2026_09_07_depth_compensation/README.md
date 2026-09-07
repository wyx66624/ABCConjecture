# Tenth continuation: actual prime logarithms and double oriented covers

Standard ABC remains unproved and undisproved. This checkpoint integrates
reviewed ordinary proofs, 41 new Lean declarations and two exact finite
replays. The full designated manuscript has 469 pages; the sealed build,
source hashes and actual visual-review coverage are recorded in
`verification/manuscript_validation.json`.

## Reliable results

- RC proves the reciprocal-cap budget, including all unrestricted-arm
  radical credit, and classifies its five maximal cap patterns. TD gives
  an infinite actual three-arm private-depth family outside every one of
  those cap patterns. Its selected depths cost less than height/n, so it
  does not refute the more general net-credit sufficient criterion.
- APL realizes the finite ledger with `Nat.factorization`,
  `Nat.primeFactors` and `Real.log`. It proves product and overlap laws
  and the complete finite two-arm compensation inequality from positive
  integer inputs, quotients and output bounds. Pairwise quotient
  coprimality is explicit; no coprimality with the old factor is required.
- FM locates almost all full multiplicity mass in the large-prime tail
  on most roots of an actual block. EA proves elementary angular and
  exact two/three-adic replacements on B>=n, removing logarithmic-form
  estimates from that block conclusion. Brun--Titchmarsh remains an
  established input. Exceptional roots and signed costs remain open.
- MX combines arbitrary first and second exponents in a generic Kummer
  model. DC uses the second integer's actual Eisenstein norm to produce
  a stronger degree-hg curve over the fixed quadratic field, of genus
  1+2hg-g-2h and coefficient height O(1+log V0+log V1). RD gives its
  smooth rational fiber product, with expanded coefficient height
  O(h+g+log V0+log V1). Neither construction bounds actual point heights.

The complete ordinary proofs and independent reviews are in the three
agents' `tenth_round` directories. The root formal bridge's ordinary
proof is `actual_prime_log_scope.md`; the final paper statements are in
`paper/`. `verification/ordinary_review.md` records the root's review.

## Reproduce the scoped checks

Use the repository-pinned Lean 4.32.0 Linux environment:

```sh
python3 research/checkpoints/2026_09_07_depth_compensation/verify_round.py
python3 research/checkpoints/2026_09_07_depth_compensation/verify_prime_logs.py
python3 research/checkpoints/2026_09_07_depth_compensation/verify_finite.py
```

The first command freshly compiles 17 reciprocal-depth declarations and
71 existing dependency declarations in an isolated Std-only project.
The second freshly compiles 17+7 actual-prime-log declarations against
Mathlib revision `81a5d257c8e410db227a6665ed08f64fea08e997`, reusing its
pinned compiled dependencies. All 41 new declarations have individually
checked axiom output; the union contains only `propext`, `Classical.choice`
and `Quot.sound`. This is not a whole-Mathlib or whole-repository rebuild.

The finite checks recompute ten actual CRT roots with thirty selected
private depths, and 571 actual block rows with 1,142 exact valuation
equalities. Their sources and canonical JSON outputs are checked byte
for byte. They do not completely factor all boundary quotients or prove
an infinite theorem by enumeration. The infinite constructions and
analytic/geometric proofs retain their separate ordinary status.

For a fresh dependency-only CI project, run `prepare_mathlib_project.py`,
then `lake update` and the selective `lake exe cache get` command in
`.github/workflows/abc-depth-compensation.yml`. Pass that project's path
to `verify_prime_logs.py --project`. The actual compiler, Mathlib revision,
source hashes and complete axiom-query inventory are recorded.

`build_manuscript.py` compiles the whole book three times and checks the
actual TeX inputs for stability. `seal_manuscript.py` additionally requires
the matching visual-review record, unchanged predecessor child sources,
fresh formal records and finite certificates before replacing the
user-designated PDF. Earlier evidence remains immutable.

## Next proof obligations

The primary analytic target is pointwise control of actual excess minus
radical credit at moving roots, including roots outside all simple cap
classes. The geometric target is a uniform actual point-height estimate,
or an actual compatible sequence meeting the two norm profiles. Rational
points require explicit integral reconstruction and primitivity conditions;
small coefficient height alone does not supply them. These gates are open.

Ordinary proof and independent mathematical review continue to precede
new formalization. No unrefuted parent route is retired. Subsequent
candidates are kept in `eleventh_round` directories until separately
reviewed and integrated.
