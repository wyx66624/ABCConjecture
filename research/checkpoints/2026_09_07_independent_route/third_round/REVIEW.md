# Third-round geometric results: independent review and limits

Date: 2026-09-07.

Ordinary-proof status: passed for QG1--QG5 in
`quartic_square_geometry.md`. The separate manuscript transcription is
`paper/quartic_square_geometry.tex`.

## Independent checks

Adversarial_audit independently checked the birational maps, exact multiples
of P=(3,3), the negative two-adic doubling valuation that proves infinite
order, the real identity component, dense multiples and positive open image,
and the rational-to-integer square conversion. This proves an actual infinite
positive primitive family, with no database rank assumption.

Critical_bottleneck, adversarial_audit, and root independently checked the
complete two-isogeny descent for the two small twists. Checks include the
isogeny image criterion, all dual square classes, the three parity residues
for each modulo-sixteen exclusion, the modulo-three exclusion, the quotient
by doubling, and the use of Mordell--Weil finite generation. Independent
finite-field counts give (8,8) and (4,8) at the good primes five and seven.
These counts bound torsion after rank zero has been proved; they do not
purport to compute rank. The reciprocal identity and d=3 coordinate scaling
were also independently checked.

Adversarial_audit and root independently checked the genus-three cover and
the dynamic tower, including geometric connectedness, root simplicity,
disjoint branch supports, absence of ramification at infinity, the precise
Riemann--Hurwitz calculation, and the actual norm homogenization.

The final requested clarifications are present in both note and TeX:

- The descent coefficients a,b are integers.
- Exceptional points in the isogeny image criterion are explicit; O is in
  the image, (0,0) is in the dual image exactly when b is square, and the
  formulas for addition through (0,0) and vertical lines verify alpha there.
- The covering coordinate is integral because it is rational with integral
  square.
- Eventual escape of fixed square-class pairs requires a sequence whose
  seed height tends to infinity. Merely unbounded height permits passage to
  such a subsequence; it does not imply eventual escape along arbitrary
  enumerations that repeat low seeds.

## Explicit external inputs

The finite-basis theorem and the prime-to-p torsion reduction theorem were
checked in the author-hosted J. S. Milne, Elliptic Curves, second edition:
https://www.jmilne.org/math/Books/EC2.pdf , Chapter IV opening theorem and
Chapter II Corollary 4.2. The standard group law/isogeny statements are also
identified; the actual descent maps and local arithmetic are written out.

The fixed-square-class finiteness invokes Faltings's theorem. The original
1983 paper was inspected in the author scan hosted at Chicago and its
EUDML original-article record is https://eudml.org/doc/143051 . The 1984
erratum is distinguished from the original. This input supplies finiteness,
not a claimed effective uniform bound on rational-point heights.

## Exact replay

`exact_geometry_replay.py` uses only exact integers and Python Fraction;
it does not invoke SageMath, a rank oracle, numerical analytic rank, or
floating-point factorization. Its canonical UTF-8 LF output is
`exact_geometry_results.json`, SHA256
`3bb92c3ea0f49a1b875a166a6168f0aab606be29fd46ae0a8490ae6b48f0f3a9`.

The successful replay includes 12 exact elliptic multiples and inverse maps,
seven successive two-adic denominator checks, all displayed local descent
certificates and good-reduction counts, 6241 integer homogeneous identities,
and five dynamic polynomial levels checked for degree, squarefreeness, and
pairwise coprimality. These checks do not replace the infinite proofs.

## Scope

The single-square family gives the specified second extraction lambda=1/2,
which does not meet NT4. The combined-norm obstruction excludes both even
exponents with both residual norms square, including the unit-residual case,
for every moving-root choice. It does not exclude general nonsquare
residuals or odd extraction exponents. Fixed square-class vectors give
finite seed sets, but there is no uniform control over moving vectors.

Parent root is separately formalizing the exact congruence and polynomial
arithmetic in Lean. The elliptic rank-zero theorem, the full combined-norm
obstruction, Mordell--Weil input, real density, isogeny theory, and Faltings
are not claimed as fully formalized by those arithmetic cores. No theorem
in this research round proves or disproves ABC.

All files in this third-round directory are new. Earlier published files
remain unchanged.
