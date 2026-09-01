# Independent review of the parameter-uniform initial-data criterion

Author: ChatGPT. Arithmetic geometry route. Date: 2026-08-31.

Read-only review of `IUT_INITIAL_DATA_POWERFREE_FAMILY_2026_08_31.md`,
cross-checked against `FREY_POWERFREE_CRT_EXISTENCE_FAMILY_2026_08_30.md`.
The earlier fixed-level covering review is reused only where its proof
is parameter-independent; all new arithmetic hypotheses were checked
again. No shared source file was edited.

**Conclusion:** no necessary mathematical correction found.
The parameter-uniform conclusion is a paper theorem relative to its
stated original inputs, not a Lean proof of the source definition.

The specific checks requested by the root review are:

- The criterion assumes a finite nonempty set S0 of odd primes and
  explicitly excludes ell from S0. Its multiplicative Tate-order
  condition is imposed at every place over S0 of F, not K.
  This is the field required in Mochizuki I Definition 3.1(c).
- F=Q(i,D[30]) is genuinely Galois, with degree dividing
  276480=2^11*3^3*5. Thus its degree is prime to every prime ell>=7.
  The criterion states semistable reduction over F and the actual
  G_F image containing SL2 as hypotheses; it does not infer either
  from the degree bound alone.
- In the power-free application, all odd bad primes are minimal
  split multiplicative. At 2 the positive j-valuation excludes
  multiplicative reduction. Rational full 3-torsion over each
  actual completion of F excludes additive reduction by the
  at-most-four component-group bound. This supplies semistability
  over the specified F, without an unspecified extra extension.
- The G_F image argument is uniform: A=1 mod 5 gives Frobenius
  polynomial T^2-2T+5; ell=43 mod 60 makes -16 nonsquare mod ell.
  The p-place supplies an order-ell transvection because its
  rational Tate order is four. A conjugate has a different fixed
  line, and their powers give the two complete root groups over
  the prime field F_ell. Both survive in the normal G_F image
  because the quotient has order dividing [F:Q], prime to ell.
- The negative-j prime in the general criterion is explicitly
  greater than five, so all four classified arithmetic j-values
  are integral there. In the application p>=30ell-1>5 and
  v_p(A)=1 give v_p(j)=-4. No genericity or non-CM shortcut is
  substituted for this four-class exclusion.
- The Tate-order split in equation (2.5) is essential and correct.
  If r divides A, the order is 4e(w/r)v_r(A), and the power-free
  theorem gives 1<=v_r(A)<=ell-1. It is unnecessary, and in
  general false, to infer that A^2 itself is ell-power-free.
  For the two quadratic factors the order is respectively
  2e(w/r)v_r(A^2+1) and 2e(w/r)v_r(2A^2+1). Those valuations
  also lie between one and ell-1. The cases are disjoint, and
  ell divides none of 2,4,e(w/r), or the displayed valuations.
  Also (a,b,c)=(1,2,3) mod ell proves ell is never in S_A.
- The quantifiers keep one H and one nonzero quotient cusp fixed
  for a chosen curve before selecting a place over each bad
  rational prime. The original source permits the independent
  section choices. This works for every nonempty S0 subset S_A
  and every such decorated pair; it does not claim one cover or
  field works for different parameters.

For the new oriented-cover explanation, Mochizuki I original
PDF pages 37--39 and 65 were read anew, in addition to the earlier
Definition 3.1 pages 61--63. Page 37 was also checked visually in
the existing source-page rendering. The hypothesis (*) uses the
mod-ell abelianization of the original un-underlined once-punctured
curve, so rational D[ell] over K suffices. It does not demand all
ell-torsion of D/H or an ell^2-torsion field.

The distinguished completion formulas were checked directly:
if varpi^e=b0=p^2*u0, e=15ell, then beta=varpi^((e+1)/2)/p
satisfies beta^e=p*u0^((e+1)/2) and varpi=u0^(-1)*beta^2.
Thus beta is the uniformizer and the native square-label root
has valuation 2/ell. Choosing a different allowed place gives
an isomorphic local field and does not replace the Tate unit.

The threshold for the family remains the threshold in the separate
existence theorem. No extra initial-data threshold is needed.
Unbounded heights only escape finite exceptional sets fixed before
the parameters vary; the reviewed report retains that quantifier
and does not identify the chosen ell with an existential prime in
Joshi IV. The complete pilot-family, normalization, Ind3 and
cross-Frobenius comparisons remain outside this conclusion.
