# Mixed-full Campana points: an exact abc gate and the August 2026 counting frontier

Author: ChatGPT. Date: 2026-08-31.

## 0. Status and scope

This note records the mathematical proof before its Lean formalization.  It
incorporates the newest primary source found in this continuation:

* Tim Browning and Matteo Verzobio, *Sums of three powerful numbers*,
  arXiv:2608.24512v1, submitted 25 August 2026.

The archived author PDF is
`research/sources/powerful_sums_2026_08_31/`
`Browning_Verzobio_Sums_Three_Powerful_arXiv2608.24512v1.pdf`,
397312 bytes, SHA256
`1ff50f5b0b66a4c0750aae03ae54f8a67bf451b05d9a386dbc6f5851855e04c9`.

The new unconditional result proved below is the exact radical and
logarithmic-height inequality for a primitive abc point whose three
coordinates are allowed to have three different fullness exponents.  It
turns the log-general-type condition

\[
             \frac1p+\frac1q+\frac1r<1
\]

into two precise consequences:

1. the abc conjecture would uniformly bound the heights of all such points;
2. an unbounded family of such points would rigorously disprove abc.

Browning--Verzobio prove a genuine power saving in the number of these
points.  Their exponent remains positive, so their result does not supply
either the required boundedness or an unbounded counterexample family.  No
external counting theorem is introduced as a Lean axiom.

## 1. Definitions and the exact natural-number inequality

For an integer `m >= 1`, call a positive integer `n` **m-full** when every
prime divisor of `n` occurs with valuation at least `m`.  Write
`rad(n)` for the product of the distinct prime divisors of `n`.

Let `(a,b,c)` be a positive primitive abc triple:

\[
       a+b=c,\qquad \gcd(a,b)=\gcd(b,c)=\gcd(c,a)=1.
\]

Assume that `a` is `p`-full, `b` is `q`-full, and `c` is `r`-full, where
`p,q,r` are positive integers.  Put

\[
       L=pqr,\qquad M=qr+pr+pq.
\]

### Theorem 1.1 (mixed-full radical-power compression)

Under these hypotheses,

\[
        \boxed{\operatorname{rad}(abc)^{pqr}
               \le c^{qr+pr+pq}.}
\tag{1.1}
\]

**Proof.**  If `n` is `m`-full, prime factorization gives

\[
                 \operatorname{rad}(n)^m\mid n,
\]

and hence `rad(n)^m <= n`.  Raising the three instances to the powers
`qr`, `pr`, and `pq`, respectively, gives

\[
\begin{aligned}
 \operatorname{rad}(a)^{pqr}&\le a^{qr},\\
 \operatorname{rad}(b)^{pqr}&\le b^{pr},\\
 \operatorname{rad}(c)^{pqr}&\le c^{pq}.
\end{aligned}
\]

Primitivity makes the radical multiplicative across the three coordinates:

\[
        \operatorname{rad}(abc)
        =\operatorname{rad}(a)\operatorname{rad}(b)
          \operatorname{rad}(c).
\]

Moreover `a<c` and `b<c`, because both summands are positive.  Multiplying
the preceding inequalities and replacing `a,b` by the larger endpoint `c`
yields

\[
\begin{aligned}
 \operatorname{rad}(abc)^{pqr}
 &\le a^{qr}b^{pr}c^{pq}\\
 &\le c^{qr}c^{pr}c^{pq}
  =c^{qr+pr+pq},
\end{aligned}
\]

which proves (1.1).  This proof is purely arithmetic and has no asymptotic
or conjectural input.  \(\square\)

The integer inequality `M<L` is exactly the denominator-cleared form of
the log-general-type condition:

\[
       qr+pr+pq<pqr
       \quad\Longleftrightarrow\quad
       \frac1p+\frac1q+\frac1r<1.
\tag{1.2}
\]

## 2. The exact logarithmic conductor slope

For a primitive abc point `P=(a,b,c)`, define

\[
 H(P)=\log\max\{a,b,c\}=\log c,
 \qquad
 R(P)=\log\operatorname{rad}(abc).
\]

Set

\[
                 \sigma_{p,q,r}
                    =\frac1p+\frac1q+\frac1r.
\tag{2.1}
\]

### Theorem 2.1 (mixed-full conductor-height inequality)

If `a,b,c` are respectively `p,q,r`-full, then

\[
             \boxed{R(P)\le \sigma_{p,q,r}H(P).}
\tag{2.2}
\]

**Proof.**  Positivity of all radicals and their multiplicativity give

\[
 R(P)=\log\operatorname{rad}(a)
      +\log\operatorname{rad}(b)
      +\log\operatorname{rad}(c).
\]

The elementary full-number inequality used in Theorem 1.1 gives

\[
 \log\operatorname{rad}(a)\le\frac{\log a}{p},\qquad
 \log\operatorname{rad}(b)\le\frac{\log b}{q},\qquad
 \log\operatorname{rad}(c)\le\frac{\log c}{r}.
\]

Since `1<=a,b<c` and the logarithm is increasing,
`log a,log b <= log c`.  Division by the positive integers `p,q,r`
preserves these inequalities.  Summing them proves (2.2).  \(\square\)

Equation (2.2) is stronger and cleaner than applying a single minimum
fullness exponent to the product: it retains the three different orbifold
weights exactly.

## 3. What abc would imply in the log-general-type range

Assume `sigma=σ_{p,q,r}<1`.  Since `sigma>=0`, there exists an
`epsilon>0` such that

\[
                     (1+\varepsilon)\sigma<1.
\tag{3.1}
\]

For example, when `sigma>0`, any
`0<epsilon<(1-sigma)/sigma` works; when `sigma=0`, every positive epsilon
works.  In the present application `p,q,r` are positive, so `sigma>0`.

### Theorem 3.1 (abc-conditional uniform height bound)

Assume the standard abc conjecture.  For fixed positive `p,q,r` satisfying
`sigma<1`, there is a real constant `H_0`, depending only on `p,q,r`, such
that every primitive positive abc point with the prescribed three fullness
conditions satisfies

\[
                         H(P)\le H_0.
\tag{3.2}
\]

Consequently there are only finitely many such triples.

**Proof.**  Choose epsilon as in (3.1).  The standard logarithmic abc
statement supplies a constant `C_epsilon` for which

\[
                 H(P)\le(1+\varepsilon)R(P)+C_\varepsilon.
\]

Insert (2.2) and put
`delta=1-(1+epsilon)sigma>0`.  Then

\[
                 \delta H(P)\le C_\varepsilon,
 \qquad
                 H(P)\le C_\varepsilon/\delta.
\]

This is (3.2).  Because `H(P)=log c`, it bounds the positive integer `c`;
there are only finitely many positive pairs `a,b` with `a+b=c`.  \(\square\)

This is an implication from the unchanged standard `ABCConjecture`; it is
not a reformulation used in place of that target.

## 4. A strict disproof gate

The preceding argument has an exact contrapositive that isolates a valid
counterexample route.

### Theorem 4.1 (unbounded mixed-full family disproves abc)

Fix positive `p,q,r` with
`1/p+1/q+1/r<1`.  If there exists a sequence of primitive positive triples

\[
                    a_n+b_n=c_n
\]

whose coordinates are respectively `p,q,r`-full and whose heights
`log c_n` are unbounded, then the standard abc conjecture is false.

**Proof.**  Theorem 2.1 gives the uniform radical slope
`R(P_n)<=sigma H(P_n)`.  Choose epsilon with
`(1+epsilon)sigma<1`.  If abc held with constant `C_epsilon`, then the proof
of Theorem 3.1 would give the same finite upper bound
`H(P_n)<=C_epsilon/delta` for every `n`, contradicting unboundedness.
\(\square\)

Thus an actual unbounded family here would be a rigorous disproof, not a
finite numerical challenge to a guessed abc constant.  No such family is
constructed in this note.

## 5. The Browning--Verzobio frontier

Browning--Verzobio use the same `m`-full definition.  Their `N(B)` counts
positive primitive solutions `a+b=c` of height `c<=B` in which `a,b,c`
are respectively `p,q,r`-full.  On pages 1--2 they identify these triples
with Campana points on

\[
 (\mathbb P^1,\Delta_{p,q,r}),\qquad
 \deg K_{\mathbb P^1,\Delta}=1-\sigma_{p,q,r},
\]

and state exactly the radical argument of Sections 2--3: abc predicts
`N(B)=O_{p,q,r}(1)` when `sigma<1`.  They explicitly say that this
finiteness result is presently out of reach.

Their unconditional baseline, for `p>=q>=r`, is

\[
                         N(B)\ll_{p,q}B^{1/p+1/q}.
\tag{5.1}
\]

Theorem 1.1 of the paper takes `p=r+u`, `q=r+v`, with fixed
`u>=v>=0`, and proves for all sufficiently large `r`

\[
 N(B)\ll_{\varepsilon,u,v,r}
 B^{1/p+1/q-\eta_{u,v}(r)+\varepsilon},
 \qquad
 \eta_{u,v}(r)=\frac1{r^2}+O_{u,v}(r^{-5/2})>0.
\tag{5.2}
\]

For `p=q=r`, their argument gives
`N(B) << B^{2/r-eta_r+epsilon}` with
`eta_r=1/r^2+O(r^{-5/2})>0`.  Remark 4.5 proves a power saving for every
`r>=2` in the special nonsymmetric family
`(p,q,r)=(r+2,r+1,r)`.

The paper's main analytic input is its coefficient-uniform Theorem 1.2 for
the generalized Fermat surface

\[
             a_1x^p+a_2y^q+a_3z^r=0.
\]

For rectangular bounds `X,Y,Z>=2`, and

\[
 W=\exp\sqrt{\frac{\log X\log Y}{r}},
\]

it proves

\[
 \#S(X,Y,Z,f)\ll_{\varepsilon,p,q,r}(XYZ)^\varepsilon
 \left(
 W^2+W\max\{X,Y\}^{2/\sqrt{\max\{p,q,36\}}}
      +W\max\{X,Y\}^{1/r}
 \right),
\tag{5.3}
\]

uniformly in the nonzero coefficients `a_1,a_2,a_3`.  The proof combines
the determinant method with function-field Diophantine geometry; it is not
a hidden invocation of the integer abc conjecture.

Equations (5.2)--(5.3) are a substantive quantitative restriction on the
precise low-radical locus isolated by Theorem 4.1.  However, the exponent in
(5.2) is still positive.  A bound `N(B)<<B^alpha` with `alpha>0` does not
imply that `N(B)` is bounded, and it does not construct infinitely many
points.  Therefore the latest theorem supports neither side of the strict
gate by itself.

## 6. Formalization boundary

The Lean companion should prove, with no project-specific or nonstandard
axioms and with no placeholders (standard Lean/Mathlib logical axioms may
appear in kernel dependency reports):

1. the natural inequality (1.1), using the existing theorem
   `IsKFull.radical_pow_le` and actual radical multiplicativity for an
   `ABCPoint`;
2. the exact conductor-height inequality (2.2);
3. the epsilon margin under `sigma<1`;
4. the implication from an explicitly unbounded mixed-full family to
   `not ABCConjecture`, by applying the existing general subcritical-slope
   theorem to the standard target.

The analytic counting bounds (5.2)--(5.3) remain cited paper theorems.  The
current repository does not contain the determinant-method and
function-field infrastructure needed to reproduce their proofs.  Declaring
these estimates as axioms would add no formal evidence and is prohibited.

The exact remaining mathematical alternatives are now visible.  Proving
the Campana-predicted finiteness for every fixed log-general-type triple of
weights would verify this restricted consequence of abc.  Constructing one
unbounded family for one such triple would rigorously disprove abc.  The
August 2026 power saving advances the counting problem but reaches neither
endpoint.
