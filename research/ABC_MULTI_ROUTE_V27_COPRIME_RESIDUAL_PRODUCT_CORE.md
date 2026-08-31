# ABC multi-route research note v27: coprime residual supports and the sixth-power split

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Purpose

The current endpoint program has reached two simultaneous conclusions.

First, every sufficiently strong hypothetical abc violation forces a positive
signed exponent-two defect on one of the two large coprime endpoints.  Second,
large square and cube divisors by themselves do not close the argument:
explicit Bezout families produce adjacent multiples of arbitrary coprime power
moduli, while the associated square--cube Mordell transformation is only a
nonprimitive rescaling of the original equation.

The missing information is therefore not merely the existence of extracted
powers.  It is the size of the residual coefficients that remain after power
extraction.  This note gives an exact deterministic theorem for combining
such residual support information at coprime exponent moduli, and then derives
a sharp square--cube--sixth-power trichotomy.

The results below are reductions, not a complete proof of the abc conjecture.

## 2. Finite exponent profiles

Let `S` be a finite set of prime coordinates, let `w_i >= 0` be logarithmic
weights, and let `e_i` be positive integer exponents.  Write

\[
T=\sum_{i\in S}e_iw_i,
\qquad
R=\sum_{i\in S}w_i.
\]

For a modulus `n`, define

\[
Q_n=\sum_{i\in S}\left\lfloor\frac{e_i}{n}\right\rfloor w_i,
\]

\[
K_n=\sum_{i\in S}(e_i\bmod n)w_i,
\]

and the residual radical weight

\[
E_n=\sum_{\substack{i\in S\\n\nmid e_i}}w_i.
\]

The exact decomposition is

\[
\boxed{T=K_n+nQ_n.}
\]

The support of the residue coefficient is precisely the support measured by
`E_n`.

## 3. Coprime-modulus product theorem

Let `m,n` be positive coprime integers.  If `mn` does not divide an exponent,
then at least one of `m,n` does not divide it.  Therefore

\[
\boxed{E_{mn}\le E_m+E_n.}
\]

Since every residue modulo `mn` is at most `mn-1`,

\[
K_{mn}\le(mn-1)E_{mn}.
\]

Combining these inequalities gives

\[
\boxed{
K_{mn}\le(mn-1)(E_m+E_n).
}
\]

Using `T=K_{mn}+mnQ_{mn}`, one obtains

\[
\boxed{
Q_{mn}\ge
\frac{T-(mn-1)(E_m+E_n)}{mn}.
}
\]

Thus residual-radical control at two coprime moduli produces a common
`mn`-th-power root.  This is the information absent from arguments that merely
extract unrelated large powers.

## 4. Sharp square--cube residue table

For the pair `(m,n)=(2,3)`, the six residue classes can be inspected exactly.
For every exponent `e>=0`,

\[
\boxed{
e\bmod6
\le
3\mathbf 1_{2\nmid e}
+
4\mathbf 1_{3\nmid e}.
}
\]

The coefficients `3` and `4` are sharp: residue `3` forces the first, and
residue `4` forces the second.

After weighting and summing,

\[
\boxed{K_6\le3E_2+4E_3.}
\]

Consequently

\[
\boxed{
Q_6\ge\frac{T-3E_2-4E_3}{6}.
}
\]

This improves the generic bound `K_6<=5(E_2+E_3)`.

## 5. Overlap of the square and cube roots

The exact residue table also gives

\[
\left\lfloor\frac e2\right\rfloor
+
\left\lfloor\frac e3\right\rfloor
\le
5\left\lfloor\frac e6\right\rfloor
+
2\mathbf 1_{2\nmid e}
+
3\mathbf 1_{3\nmid e}.
\]

Therefore

\[
\boxed{
Q_2+Q_3\le5Q_6+2E_2+3E_3.
}
\]

So simultaneous square-root and cube-root mass must either overlap in a large
sixth-power root or be paid for by the parity and cubic residual coefficients.

This identifies precisely what the existing adjacency no-go families exploit:
the perfect-power divisors can be large while the residual coefficients carry
the remaining arithmetic complexity.

## 6. Sharp signed-surplus ledger

The quantity relevant to the endpoint reduction is the signed exponent-two
surplus

\[
D_2=T-2R=\sum_{i\in S}(e_i-2)w_i.
\]

The six residue classes yield the sharper pointwise estimate

\[
e-2
\le
6\left\lfloor\frac e6\right\rfloor
+
\mathbf 1_{2\nmid e}
+
2\mathbf 1_{3\nmid e}.
\]

Hence

\[
\boxed{
D_2\le6Q_6+E_2+2E_3.
}
\]

This is stronger for the endpoint problem than first bounding `K_6`, because
it retains the negative contribution of exponent-one primes.

## 7. Quantitative trichotomy

For arbitrary proposed thresholds `Q,A,B`, if

\[
6Q+A+2B<D_2,
\]

then at least one of

\[
Q<Q_6,
\qquad
A<E_2,
\qquad
B<E_3
\]

must hold.

Taking equal contributions gives the explicit split

\[
\boxed{
D_2>L
\Longrightarrow
Q_6>\frac{L}{18}
\ \text{or}\
E_2>\frac{L}{3}
\ \text{or}\
E_3>\frac{L}{6}.
}
\]

Thus a height-scale signed defect cannot remain a vague collection of repeated
prime factors.  It must appear in one of three concrete locations:

1. a height-scale canonical sixth-power root;
2. a height-scale square-residual coefficient radical;
3. a height-scale cube-residual coefficient radical.

## 8. Consequence for a hypothetical abc counterexample

The existing signed endpoint localization states that a violation

\[
\log c>(1+\varepsilon)
\log\operatorname{rad}(abc)+C
\]

forces one of the large coprime endpoints `x in {max(a,b),c}` to have a
positive signed defect of conductor scale, after including the small-endpoint
radical charge.

Applying the present trichotomy to the prime-exponent profile of that endpoint
shows that any unbounded counterexample family must repeatedly enter one of
the following regimes.

### Sixth-power regime

The endpoint contains a sixth power whose logarithmic root size is a fixed
positive proportion of the defect.  Writing the endpoint as

\[
x=\kappa_6 z^6
\]

leaves the moving coefficient `kappa_6`.  The remaining task is a uniform
moving-coefficient generalized-Fermat or Thue--Mahler estimate that also uses
the short additive gap.

### Parity-residual regime

A fixed positive proportion of the radical lies on primes whose exponents are
odd.  These primes survive the square extraction and form a large coefficient
in the square-based endpoint equation.

### Cubic-residual regime

A fixed positive proportion of the radical lies on primes whose exponents are
not divisible by three.  These primes survive the cube extraction and form a
large coefficient in the cube-based endpoint equation.

The last two alternatives explain why a proof based only on the extracted
power base cannot close: the residual coefficient radical must enter the
Diophantine estimate with its correct sign and scale.

## 9. Remaining arithmetic frontier

The new deterministic part is complete.  The unresolved input is now a
pointwise theorem for the additive equation

\[
M+m=c,
\qquad
\gcd(M,m)=\gcd(M,c)=\gcd(m,c)=1,
\]

in which one large endpoint has conductor-scale signed defect.

A successful closure must show that none of the three alternatives above can
persist together with an abc-violating radical budget.  More concretely, one
needs at least one of:

* a uniform moving-coefficient estimate for
  `v y^6-u x^6=m` that charges `rad(uvm)` with leading coefficient one;
* a modular or level-lowering theorem whose constants are uniform in the
  varying residual coefficients;
* a correlated short-interval theorem controlling the residual coefficient
  radical on both adjacent endpoints simultaneously;
* a new argument proving that the parity- and cubic-residual regimes force
  enough exponent-one radical compensation to destroy the positive signed
  defect.

Existing fixed-signature generalized-Fermat results do not currently provide
this all-coefficients uniformity.

## 10. Lean files

The generic coprime-moduli statements are formalized in

```text
Lean/IUTThreeClosures/CoprimeModuliResidualProductCore.lean
```

with principal declarations

```lean
residueWeight_le_modulusMinusOne_mul_residualRadicalWeight
productResidualRadicalWeight_le_add
productModulusResidueWeight_le
productPowerRootWeight_lower_bound
sixthPowerResidueWeight_le_five_mul_squareCubeResidualSum
sixthPowerRootWeight_lower_bound
```

The sharp modulo-six statements are formalized in

```text
Lean/IUTThreeClosures/SquareCubeResidualSixthPower.lean
```

with principal declarations

```lean
mod_six_le_square_cube_residual_budget
div_two_add_div_three_le_sixth_budget
sub_two_le_sixth_signed_budget
sixthResidueWeight_le_three_squareResidual_add_four_cubeResidual
squareRoot_add_cubeRoot_le_five_sixthRoot_add_residuals
signedTwoSurplus_le_sixthRoot_add_residuals
signedSurplus_forces_sixth_or_squareResidual_or_cubeResidual
positive_signedSurplus_forces_quantitative_square_cube_sixth_split
squareCubeRoots_force_sixth_or_residual
```

Neither module introduces an abc conclusion, a generalized-Fermat finiteness
statement, or a Diophantine height estimate as data.
