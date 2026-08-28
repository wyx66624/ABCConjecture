# The Chebyshev target-five simple-root core and the fixed-modulus barrier

## 0. Outcome and trust boundary

For the remaining curves

\[
 C_p:\qquad y^2=4T_p(X)+5,
\]

there is an exact obstruction to every proposed *fixed finite* congruence or
quadratic-character covering.  If `q >= 5` is a fixed prime and `p > q+1`
is prime, then `T_p` permutes `F_q`.  Hence there is a unique `t` with

\[
 T_p(t)=5,
\]

and `(t,5)` is a non-endpoint affine point of `C_p(F_q)`.  This point is
simple in the `X` direction, so it lifts to every `q`-power.  The exact
branches at `2` and `3`, followed by CRT, show that no finite collection of
fixed prime-power tests can exclude every sufficiently large prime `p`.

The new Lean module
`IUTThreeClosures/FreyPellChebyshevLocalSimpleRootCore.lean` formalizes all
finite algebraic inputs used in that sentence:

* `T_n(x)^2-1=(x^2-1)U_{n-1}(x)^2`;
* `T_n'(x)=nU_{n-1}(x)` after evaluation;
* `T_n(x)=5` and `24 != 0` imply `x != +/-1` and `U_{n-1}(x) != 0`;
* in `ZMod q`, the numerical hypotheses `q >= 5`, `p` prime and
  `p > q+1` make the derivative a unit;
* bijectivity of `T_p` implies a unique target-five preimage and, more
  generally, a unique abscissa for each ordinate on `C_p`;
* the pairwise scalar Chinese remainder theorem.

Dickson's permutation theorem and Hensel's lemma are accepted published
interfaces.  They are not Lean axioms.  The statement that the local points
lift to all depths uses Hensel externally.  Positivity, the fundamental-unit
condition, and existence of one *global integer* satisfying every local
condition are not claimed.

## 1. Exact comparison with the preceding local-permutation audit

The existing note
`FREY_PELL_CHEBYSHEV_PRIME_INDEX_LOCAL_PERMUTATION_BARRIER.md` already proves
on paper the stronger complete-residual version:

* its Section 3 selects the target `5`, reconstructs the half-angle factors,
  the four-consecutive block, both norm kernels, and the full unit-power
  coefficient;
* it proves the selected point is nondegenerate and invokes Hensel to all
  `q^e`;
* its Section 4 supplies the exact signed branches at `2` and `3` and the
  finite CRT conclusion;
* its Section 5 shows that even a moving order prime plus the visible
  quadratic splitting is not, by itself, contradictory.

The previous companion Lean module already checked

* the half-angle scalar reconstruction, once the half-angle identities and
  nonvanishing factors are supplied;
* the fixed four-consecutive block;
* nonvanishing of the abstract product `p*F*G`;
* the signed small-prime branch and the global power thresholds.

What it did **not** kernel-check was the direct polynomial seam from
`T_p(t)=5` to a unit derivative.  The present module fills precisely that
gap with Mathlib's actual `Polynomial.Chebyshev.T` and `.U`; it does not
duplicate the complete block reconstruction or the height argument.

## 2. The symbolic finite-field argument

Write `D_n(X,1)` for the first-kind Dickson polynomial.  The normalizations
satisfy

\[
 D_n(2X,1)=2T_n(X).
\]

Dickson's criterion states that `D_n(X,1)` permutes `F_q` if and only if

\[
 \gcd(n,q^2-1)=1.
\]

This is recovered explicitly from Proposition 2.4 of Bluher's paper.  See
[Bluher, Proposition 2.4](https://arxiv.org/pdf/1707.06877) and the published
[DOI](https://doi.org/10.1016/j.ffa.2021.101899).

Now fix `q >= 5`.  If `p > q+1` is prime, then `p` divides neither `q-1`
nor `q+1`, so `gcd(p,q^2-1)=1`.  Since multiplication by `2` is invertible,
`T_p` permutes `F_q`.

This gives more than one local point.  For every `y in F_q`, there is a
unique `x` satisfying

\[
 T_p(x)={y^2-5\over4}.
\]

Thus `C_p` has exactly `q` affine `F_q`-points.  Equivalently,

\[
 \sum_{x\in F_q}\chi(4T_p(x)+5)
 =\sum_{z\in F_q}\chi(4z+5)=0.
\]

This exact equality rules out a fixed-prime quadratic-character obstruction,
not merely the particular point chosen below.

For the complete residual, choose the unique `t` with `T_p(t)=5`.  The
Chebyshev identity gives

\[
 24=T_p(t)^2-1=(t^2-1)U_{p-1}(t)^2.
\]

Because `q >= 5`, neither factor on the right can vanish.  In particular
`t != +/-1`, and

\[
 T_p'(t)=pU_{p-1}(t)\ne0.
\]

The root of `T_p(X)-5` is simple.  Hensel's lemma therefore gives a unique
lift of this root to every `q^e`, while the ordinate remains `y=5`.

This argument applies simultaneously to any fixed finite list of primes once
`p` exceeds the largest `q+1`.  Iterated CRT then combines the local data.
It does **not** apply to primes chosen as a function of `p`, nor does it
encode the archimedean assertion that one coordinate is the positive
fundamental unit of the moving quadratic field.

## 3. Literature audit: what is accepted and what it actually gives

### 3.1 Hyperelliptic and polynomial equations

* [Bilu--Tichy, Theorem 1.1](https://matwbn.icm.edu.pl/ksiazki/aa/aa95/aa9534.pdf)
  classifies fixed pairs `f(x)=g(y)` having infinitely many rational
  bounded-denominator solutions.  In the coprime-degree case `(p,2)`, only
  the first and third standard pairs can occur.  The monomial case is
  excluded by the distinct critical points of `T_p`.  In the Dickson case,
  comparison of the degree-`p` and degree-`p-2` coefficients forces the
  common outer constant to be `+/-4`, whereas this curve has constant `5`.
  Hence the theorem gives finiteness for each fixed `p`, not emptiness and
  not a uniform exclusion as `p` varies.

* [Berczes--Evertse--Gyory, Theorem 2.2](https://arxiv.org/pdf/1301.7168)
  gives an explicit height bound for `f(x)=b y^2` when `deg f >= 3` and `f`
  has no repeated zero.  Applied here, its constants depend on the moving
  degree `p` and the coefficient height of `4T_p+5`; substitution gives a
  bound of roughly `exp(O(p^5))`.  This is effective pointwise finiteness,
  not a proof that no relevant point exists.  Its Theorem 2.3 bounds a
  varying *power exponent* for fixed `f`; here the exponent is always `2`
  while `f` varies, so that theorem does not address the problem.

* [Darmon--Granville, Theorem 1](https://www.math.mcgill.ca/darmon/pub/Articles/Research/12.Granville/pub12.pdf)
  is a finiteness theorem for fixed homogeneous forms/signatures.  The form,
  degree, quadratic field, and coefficients all move here.  It supplies no
  all-`p` emptiness statement.

### 3.2 Runge and uniform rational-point bounds

* Levin explains immediately before
  [Theorem 3.1](https://www.numdam.org/item/10.5802/jtnb.634.pdf) that ordinary
  Runge gives no information when the chosen coordinate has one pole.  The
  odd-degree model `y^2=4T_p(x)+5` has exactly one point above infinity.
  The covering criterion in Theorem 3.1 requires sufficiently large rational
  torsion rank.  Section 1 of the repository's
  `FREY_PELL_CHEBYSHEV_UNIFORM_TWO_DESCENT_AUDIT.md` proves uniformly, by
  the Eisenstein/tower-law argument, that `4T_p+5` is irreducible.  Thus
  `J_p(Q)[2]=0`, and the numerical inequality for the natural `2`-cover
  cannot start.  This does not rule out every possible odd-torsion cover,
  but no uniform such cover is supplied by the theorem.

* Caporaso--Harris--Mazur uniformity is conditional on Lang's conjecture and
  is therefore not an admissible unconditional closing theorem here.  The
  unconditional [Dimitrov--Gao--Habegger Theorem 1.1](https://arxiv.org/pdf/2001.10276)
  bounds `#C(F)` by `c(g,d)^(1+rank J(F))`.  Both the genus
  `(p-1)/2` and the rank input move, and a cardinality bound does not prove
  that the relevant integral subset is empty.

### 3.3 Primitive divisors and the modular method

* [Bilu--Hanrot--Voutier, Theorem 1.4](https://doi.org/10.1515/crll.2001.080)
  gives a primitive divisor for every Lucas or Lehmer term of index greater
  than `30`.  In the present quotient it gives the accepted moving prime and
  its order condition, but not the parity of its valuation.

* [Granville, Theorem 3](https://arxiv.org/pdf/1212.6306) gives an
  odd-valuation primitive divisor for Lucas recurrences with the explicit
  hypothesis `c == 2 (mod 4)`.  The relevant recurrence has parameters
  `(b,c)=(2X,-1)`, so `c == 3 (mod 4)`.  The theorem is not applicable.
  Even an odd valuation is compatible with the already audited split norm
  in `Q(sqrt(5))`, so it would not by itself finish the argument.

* [Darmon--Merel](https://www.math.mcgill.ca/darmon/pub/Articles/Research/18.Merel/paper.pdf)
  treats the fixed generalized Fermat equations `x^n+y^n=2z^n`, `=z^2`,
  and `=z^3` for primitive integer solutions.  The Kummer rewriting
  `W^2=x(2x^p+1)(x^p+2)` lives over a unit and a quadratic/biquadratic field
  moving with the original point; no reduction to one of their fixed
  primitive equations has been proved.  Fixed-number-field asymptotic
  Fermat theorems have the same quantifier mismatch.

No accepted result located in these primary sources gives the required
uniform exclusion for all prime `p` and all globally normalized Pell bases.

## 4. Exact finite diagnostic, not a proof

An independent exact recurrence calculation checked

* the `84` primes `37 <= p < 500`;
* the `43` primes `7 <= q < 200`;
* all `3612` pairs `(p,q)`;
* all residues `x in F_q`, after deleting both endpoints `x=+/-1`.

For every pair, at least one non-endpoint residue made
`4T_p(x)+5` a square.  There were zero local exclusions.  This finite scan
is only a diagnostic.  The Dickson argument in Section 2, not the scan,
proves the fixed-prime no-go for all sufficiently large prime indices.

## 5. Consequence and smallest live target

A successful uniform argument must use information invisible to every fixed
finite congruence packet.  The smallest remaining options are:

1. a prime or modulus growing with `p`, together with information that it is
   a divisor of the *same global integer point*, not merely the order and
   splitting pattern;
2. the global positive-fundamental-unit minimality/floor data;
3. the already isolated dyadic Selmer transversality and uniform Coleman
   nonvanishing problem;
4. a pointwise parity-core estimate beyond the active `4/31` threshold.

The local construction never produces a global integer solution.  It proves
only that fixed local and quadratic-character covers cannot produce the
desired contradiction.

## 6. Lean theorem ledger

The new kernel-checked declarations are:

* `PellChebyshevLocalSimpleRoot.t_sq_sub_one`;
* `PellChebyshevLocalSimpleRoot.derivative_t_eval`;
* `PellChebyshevLocalSimpleRoot.derivative_targetFive_eval`;
* `PellChebyshevLocalSimpleRoot.targetFive_curveEquation`;
* `PellChebyshevLocalSimpleRoot.targetFive_nondegenerate`;
* `PellChebyshevLocalSimpleRoot.targetFive_derivative_isUnit`;
* `PellChebyshevLocalSimpleRoot.existsUnique_targetFive_of_bijective`;
* `PellChebyshevLocalSimpleRoot.existsUnique_curveAbscissa_of_bijective`;
* `PellChebyshevLocalSimpleRoot.zmod_targetFive_simple`;
* `PellChebyshevLocalSimpleRoot.zmod_existsUnique_targetFive_simple_of_bijective`;
* `PellChebyshevLocalSimpleRoot.crt_pair`.

Their `#print axioms` output contains only the standard Lean/Mathlib logical
foundations (`propext`, `Classical.choice`, and `Quot.sound`).  It contains no
`sorryAx` and no new mathematical axiom.
