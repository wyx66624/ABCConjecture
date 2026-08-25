# Frey Critical Periods, Modular Nome/Eta, and Padé Specialization: Fully Quantified Equivalence and Unavoidable Prime-Valuation Depth

## 1. Final conclusions

Let

```text
a,b,c in Z_{>0},   a+b=c,   gcd(a,b)=1,
r=rad(abc),        E:y^2=x(x-a)(x+b),
omega=dx/(2y).
```

This paper directly attacks a Goldfeld-type lower bound.  The conclusions split
into an unconditional positive part and a decisive negative part.

The unconditional positive result is that the normalization constants relating
the classical elliptic integral, modular lambda, theta, Dedekind eta, and the
Weierstrass discriminant agree exactly.  At a given `p|c`, if a degree-`N`
specialization polynomial has `p`-integral coefficients and `p`-unit leading
coefficient, then it incurs the exact denominator depth `N v_p(c)`; for a
hypergeometric truncation, `p>2N` is a sufficient condition.  The unconditional
weak-abc theorem of
Stewart--Yu also gives a genuine real-period lower bound depending only on the
reduced prime support.

The decisive negative result is that the required critical-power lower bound

```text
Omega >= C_eta r^(-1/2-eta)                         (1.1)
```

is equivalent, on the positive primitive Frey locus, to the all-`epsilon` abc
inequality.  Here `Omega` is the primitive positive real period of
`omega=dx/(2y)`; replacing it by the `dx/y` period in Goldfeld's notes changes
it only by the fixed factor `2`.  Consequently, no genuinely abc-weaker uniform
proposition can imply `(1.1)` merely through the known identities.  Any new
bridge that actually proves `(1.1)` is itself an abc-strength input.

The failure of the standard tools is not a matter of an unoptimized constant.
It is expressed by three exact conservation laws:

```text
the six-element modular orbit of lambda preserves the height log c;
the archimedean eta cusp loss, combined with the model discriminant, recovers (1/2) log c;
the p-adic Tate nome preserves the full valuation depth at every odd bad prime;
a Padé or truncation specialization satisfying the local integrality/unit conditions above also preserves the full depth.
```

This paper does not claim a proof of abc.

## 2. Period normalization and the kernel

The preceding paper rigorously derived

```text
Omega = 2 c^(-1/2) K(sqrt(b/c))
      = pi c^(-1/2) 2F1(1/2,1/2;1;b/c).           (2.1)
```

Put

```text
H=log c,
R=log r,
Q=log(2K(sqrt(b/c))),
P=-log Omega.
```

Then one has the exact identity

```text
P=H/2-Q.                                           (2.2)
```

Since `K(k)>=pi/2`, one has `Q>=log pi>0`.  On the other hand, let
`k'=sqrt(a/c)`.  With `t=tan(theta)`, one may write

```text
K(k)=integral_0^infinity
       dt/sqrt((1+t^2)(1+k'^2 t^2)).               (2.3)
```

Splitting the integral into `[0,1]`, `[1,1/k']`, and
`[1/k',infinity]`, the three pieces are at most `1`, `log(1/k')`, and
`1`, respectively.  Since `a>=1`, it follows that

```text
K(sqrt(b/c)) <= 2+log(1/k') <= 2+(1/2)log c,
Q <= log(4+H).                                     (2.4)
```

For every `delta>0`, the inequality

```text
log x <= delta*x-1-log(delta)   (x>0)
```

allows the explicit choice

```text
B_delta=4delta-1-log(delta)
```

and yields

```text
Q <= delta H+B_delta.                              (2.5)
```

The complementary period is obtained by exchanging `a` and `b`, and the same
estimate remains valid.

## 3. Fully quantified equivalence of the critical-period and abc budgets

Define two uniform statements:

```text
A(epsilon): exists C_epsilon, forall primitive (a,b,c),
  H <= (1+epsilon)R+C_epsilon;

P(eta): exists D_eta, forall primitive (a,b,c),
  -log Omega <= (1/2+eta)R+D_eta.                  (3.1)
```

### Theorem 3.1

On the positive primitive Frey locus above,

```text
(forall epsilon>0, A(epsilon))
iff
(forall eta>0, P(eta)).                            (3.2)
```

The same conclusion holds for the complementary primitive period and for the
minimum of the two periods.

### Proof

First assume the abc budget.  Given `eta>0`, apply it with
`epsilon=2eta`.  By `Q>=0` and `(2.2)`,

```text
-log Omega <= H/2
           <= (1/2+eta)R+C_(2eta)/2.              (3.3)
```

Conversely, for a target `epsilon>0`, take

```text
eta=epsilon/8,
delta=epsilon/[8(1+epsilon)].                      (3.4)
```

Combining `P(eta)`, `(2.2)`, and `(2.5)` gives

```text
(1-2delta)H
 <= (1+2eta)R+2(D_eta+B_delta).                   (3.5)
```

while

```text
(1+2eta)/(1-2delta) <= 1+epsilon.                 (3.6)
```

Indeed, `(3.6)` is equivalent to

```text
1+epsilon/4 <= (1+epsilon)-epsilon/4,
```

the right-hand side minus the left-hand side being `epsilon/2`.  Since
`R>=0`, division by the positive number `1-2delta` gives

```text
H <= (1+epsilon)R+
     2(D_eta+B_delta)/(1-2delta).                  (3.7)
```

All quantifiers and all dependencies of constants are displayed, completing
the proof.

Goldfeld's period conjecture is precisely an `N^(-1/2-eta)` lower bound with
the Frey conductor `N` in place of `r`.  For primitive Frey curves, `N/r`
differs only by a bounded power of `2`.  Goldfeld's original statement and the
implication from the period conjecture to weak abc appear on page 7 of his
[notes on abc, modular forms, and elliptic curves](https://www.math.columbia.edu/~goldfeld/ABC-Conjecture).

Theorem 3.1 gives the stronger logical diagnosis needed here: if a proposition
`B` implies `(1.1)` for all positive primitive Frey triples, then `B`, together
with the classical identities used here, already implies abc.  Calling `B` a
"sufficient bridge weaker than abc" would conceal its actual logical strength.

## 4. All six modular branches of lambda retain the full height

Let

```text
lambda=b/c.
```

First clarify the meaning of "conjugate."  Since `lambda` belongs to `Q`, for
every number field `L` and every embedding `sigma:L->C` one has
`sigma(lambda)=lambda`; there are no nontrivial Galois conjugates to average.
The six quantities in the table below are not field-theoretic conjugates, but
the modular-parameter orbit of the same Legendre curve under `S_3`.  Thus,
"multiplying all conjugates and taking a norm" cannot by itself dilute the
denominator `c`; Lemma 9.2 gives the exact local cost of the number-field norm.

The six-element orbit of the Legendre parameter under `S_3` is

| Parameter | Reduced value for the Frey triple | Denominator | Logarithmic height |
|---|---:|---:|---:|
| `lambda` | `b/c` | `c` | `log c` |
| `1-lambda` | `a/c` | `c` | `log c` |
| `1/lambda` | `c/b` | `b` | `log c` |
| `1/(1-lambda)` | `c/a` | `a` | `log c` |
| `lambda/(lambda-1)` | `-b/a` | `a` | `log max(a,b)` |
| `(lambda-1)/lambda` | `-a/b` | `b` | `log max(a,b)` |

Primitivity ensures that every fraction in the table is reduced.  Since
`max(a,b)>=c/2`, the last two rows also satisfy

```text
log c-log 2 <= h <= log c.                        (4.1)
```

Thus no modular branch converts the specialization height into
`log rad(abc)`.  The branches merely redistribute the valuations of `a,b,c`
among the three singularities `0,1,infinity`.

The corresponding Klein invariant is

```text
j(lambda)=256(1-lambda+lambda^2)^3 /
          [lambda^2(1-lambda)^2]
         =256(a^2+ab+b^2)^3/(a^2b^2c^2).          (4.2)
```

Consequently, the `h(j)` and model-coefficient heights occurring in general
lower bounds for elliptic logarithms remain controlled by the full
specialization height.  In the explicit family

```text
(a,b,c)=(p^m-1,1,p^m),   p odd prime,             (4.3)
```

the denominator of `j` has exact exponent `2m` at `p`, because
`(p^(2m)-p^m+1)` is a `p`-adic unit.  This rules out any uniform replacement of
`h(j)` by reduced support without paying the valuation depth.

## 5. Theta, eta, and the discriminant: exact closure of constants

Set

```text
tau=i K(sqrt(a/c))/K(sqrt(b/c)),
q=exp(pi*i*tau).
```

Theta uses the nome `q`, while the standard nome for Dedekind eta is
`q^2=exp(2pi*i*tau)`.  The classical identities are

```text
lambda(tau)=theta_2(tau)^4/theta_3(tau)^4=b/c,
1-lambda=theta_4(tau)^4/theta_3(tau)^4=a/c,
theta_3(tau)^2=2K(sqrt(b/c))/pi,                   (5.1)

2 eta(tau)^3=theta_2(tau)theta_3(tau)theta_4(tau).
```

They give, term by term,

```text
Delta_mod(tau)=eta(tau)^24
 =2^(-8) lambda^2(1-lambda)^2 theta_3(tau)^24.     (5.2)
```

For the period lattice `Omega(Z+tau Z)`, the Weierstrass discriminant is
normalized by

```text
Delta_E=(2pi/Omega)^12 Delta_mod(tau).             (5.3)
```

The Frey model satisfies `Delta_E=16a^2b^2c^2`.  Substituting `(2.1)` and
`(5.1)`--`(5.2)` into `(5.3)` reduces both sides exactly to
`16a^2b^2c^2`, with no residual constant.  Solving for the period gives

```text
Omega=2pi eta(tau)^2/Delta_E^(1/12)
     =pi*2^(2/3) eta(tau)^2/(abc)^(1/6).           (5.4)
```

Thus the eta formula is not an additional period lower bound.  It and the
hypergeometric period formula are two coordinate descriptions of the same
discriminant identity.

## 6. The eta cusp loss exactly recovers `(1/2) log c`

After exchanging `a` and `b`, assume `b=min(a,b)`.  Then `lambda<=1/2`,
`Im(tau)>=1`, and

```text
0<q<=q_0=e^(-pi).                                  (6.1)
```

The Jacobi product gives

```text
lambda=16q product_(n>=1)
  [(1+q^(2n))/(1+q^(2n-1))]^8.                    (6.2)
```

Let

```text
A_0=8q_0/(1-q_0^2).
```

From `0<=log(1+x)<=x`, one obtains the explicit two-sided bounds

```text
16q exp(-A_0) <= lambda <= 16q,                   (6.3)

log(c/b)+log 16-A_0 <= -log q
                     <= log(c/b)+log 16.          (6.4)
```

Moreover,

```text
eta(tau)=q^(1/12) product_(n>=1)(1-q^(2n)).        (6.5)
```

Using `-log(1-x)<=x/(1-x)`, define

```text
B_0=12q_0^2/(1-q_0^2)^2,
```

Then

```text
log(c/b)+log 16-A_0
 <= -12log eta(tau)
 <= log(c/b)+log 16+B_0.                          (6.6)
```

Since `c/2<=a<c`,

```text
log(abc)-12log eta(tau)
 =log(a c^2)+log 16+O(1)
 =3log c+O(1).                                    (6.7)
```

and `(5.4)` gives exactly

```text
-log Omega
 =(1/6)[log(abc)-12log eta(tau)]
   -log(pi*2^(2/3))
 =(1/2)log c+O(1).                                (6.8)
```

This is the exact archimedean no-go statement: the eta product moves the full
height from the algebraic discriminant to the cusp loss and then moves it back
unchanged.  It does not produce `log rad`.

There is also an explicit stress family independent of any asymptotic result on
the distribution of primes.  Fix an odd prime `p` and let

```text
(a,b,c)=(p^m+1,p^m,2p^m+1).                       (6.9)
```

This family is always primitive, and

```text
lambda -> 1/2,   q -> e^(-pi),   eta(tau) -> eta(i),
v_p(b)=m -> infinity.                              (6.10)
```

Thus the archimedean modular shape converges to a fixed interior point while the
multiplicity of a single finite prime grows without bound.  This family is not
a counterexample to abc.  It strictly refutes the claim that the shape of the
complex nome alone can truncate `v_p` to `min(v_p,1)`.

## 7. The nome is not an algebraic number directly accessible to Baker theory

Since `lambda=b/c` is algebraic, `j(tau)` is algebraic as well.
Barré--Sirieix, Diaz, Gramain, and Philibert proved that if
`0<|q_std|<1` and `q_std` is algebraic, then the modular function
`J(q_std)` is transcendental; see their original paper
[Une preuve de la conjecture de Mahler--Manin](https://doi.org/10.1007/s002220050044).
Taking `q_std=q^2` shows that the `q` used here must be transcendental.

Therefore the ordinary Baker--Wüstholz theorem on linear forms in logarithms of
algebraic numbers cannot be applied directly to `log q`.  Schneider's
qualitative theorem says only that if both `tau` and `j(tau)` are algebraic,
then `tau` is imaginary quadratic; it gives no critical conductor exponent.

One may instead use the theory of elliptic logarithms, but the known
quantitative bounds explicitly involve `h(j)`, the heights of the model
coefficients `g_2,g_3`, point heights, and the degree of the coefficient field.
David's original explicit theorem is
[Minorations de formes linéaires de logarithmes elliptiques](https://numdam.org/item/10.24033/msmf.376.pdf),
and David--Hirata-Kohno establish the optimal dependence on coefficient height in
[Linear forms in elliptic logarithms](https://doi.org/10.1515/CRELLE.2009.018).
These theorems are powerful on a fixed curve.  When the Frey curve itself varies
with `a,b,c`, however, `(4.2)` brings `log c` back into the input height.  None
of these theorems replaces model height by conductor support.  The explicit
period theorem of Gaudron--Rémond likewise takes Faltings height and polarization
degree as inputs; see
[Théorème des périodes et degrés minimaux d'isogénies](https://arxiv.org/abs/1105.1230).
The replacement needed here is precisely a Szpiro/abc-strength
height--conductor bridge.

## 8. The p-adic Tate nome preserves full valuation, not reduced support

For an odd prime `p|abc`, write the Frey equation as

```text
y^2=x^3+(b-a)x^2-abx,
c_4=16(a^2+ab+b^2),
Delta=16a^2b^2c^2.                                (8.1)
```

Primitivity gives `v_p(c_4)=0`: if `p` divides `a`, `b`, or `c`, respectively,
the parenthesized expression reduces modulo `p` to `b^2`, `a^2`, or `a^2`.
Thus the model is minimal and has multiplicative reduction at every odd `p`,

```text
v_p(Delta_min)=2v_p(abc).                          (8.2)
```

In the split case, the Tate-curve formula is

```text
Delta(q_p)=q_p product_(n>=1)(1-q_p^n)^24;         (8.3)
```

The nonsplit case requires only an unramified quadratic extension.  The product
is a `p`-adic unit, so in all cases

```text
v_p(q_p)=v_p(Delta_min)=2v_p(abc).                 (8.4)
```

Thus `q_p` does not compress `p^e` to "one occurrence of `p`"; it records
exactly `2e`.  The archimedean nome `q` is a transcendental complex number,
whereas the various `q_p` lie in different local fields.  They cannot be
treated as a single global algebraic number and inserted into a product
formula.  Any adelic determinant assembled from these local quantities would
first require new proofs of global algebraicity and a height formula.

## 9. Exact specialization denominators for G-functions and Padé approximants

The hypergeometric series is

```text
F(z)=2F1(1/2,1/2;1;z)
    =sum_(j>=0) A_j z^j,
A_j=binom(2j,j)^2/16^j.                            (9.1)
```

The following local lemma fully quantifies the cost of the evaluation point.

### Lemma 9.1 (unique lowest valuation)

Let `p` be prime, let `e>0` and `v_p(z)=-e`, and suppose

```text
P(T)=u_0+u_1T+...+u_NT^N in Q_p[T],
v_p(u_j)>=0,   v_p(u_N)=0.                         (9.2)
```

Then

```text
v_p(P(z))=-eN.                                    (9.3)
```

Proof.  The highest-degree term has valuation `-eN`, while every other term has
valuation at least `-e(N-1)`.  The lowest valuation is therefore unique and
cannot cancel.

### Lemma 9.2 (the norm budget over all number-field conjugates)

Let `L/Q` be a number field of degree `d`, with `p^e||c` and `p` not dividing
`b`.  For each `mathfrak p|p`, normalize the discrete valuation by
`ord_mathfrak p(mathfrak p)=1`, and denote the ramification index and residue
degree by `e_mathfrak p,f_mathfrak p`.  Then

```text
ord_mathfrak p(b/c)=-e*e_mathfrak p.              (9.4)
```

If the coefficients in `(9.2)` lie in `L`, are integral at every
`mathfrak p|p`, and the leading coefficient is a unit at each such prime ideal,
then Lemma 9.1 applied prime ideal by prime ideal gives

```text
ord_mathfrak p(P(b/c))=-N*e*e_mathfrak p.
```

Consequently, the exact exponent of `p` in the absolute norm of the denominator
ideal of `P(b/c)` is

```text
sum_(mathfrak p|p) f_mathfrak p*N*e*e_mathfrak p
 =N*e*[L:Q]=N*e*d.                                (9.5)
```

Here we used `sum e_mathfrak p f_mathfrak p=d`.  Extending the coefficient
field and using all archimedean conjugates therefore does not truncate `e` to
`1`; the norm ledger replicates that depth by the degree of the field.  If one
deliberately gives the leading coefficient positive valuation at
`mathfrak p` to force cancellation, that valuation enters the coefficient
ideal and its height.  Such a cancellation would be a new global theorem, not
an automatic benefit of taking Galois conjugates.

For the family `(4.3)`, one has `z=b/c=p^(-m)`.  If `p>2N`, then
`A_0,...,A_N` are all `p`-adic units, so the degree-`N` hypergeometric
truncation satisfies

```text
v_p(sum_(j=0)^N A_j p^(-mj))=-mN.                 (9.6)
```

More generally, if an integer polynomial is written in descending degree as

```text
u_0T^N+u_1T^(N-1)+...+u_N,
```

then its numerator after clearing denominators at `T=p^(-m)` is

```text
u_0+p^m(u_1+p^m(...+p^m u_N)...).                 (9.7)
```

If `p` does not divide `u_0`, then `(9.7)` is congruent to `u_0` modulo `p`,
so the factor `p^(mN)` in the denominator cannot be cancelled at all.  For
every fixed `N>0`, letting `m` grow gives an explicit infinite family with fixed
prime and fixed degree but unbounded denominator depth.

This does not rule out every future Padé construction whose coefficients and
degree adapt to `(p,m)` and which cancels across several approximants.  What it
strictly refutes is the assertion that

```text
"general coefficient-denominator control for G-functions
 automatically replaces the full height of the evaluation point b/c by reduced support."
```

Chudnovsky's Padé method treats Diophantine approximation to values of
G-functions; the original framework is
[Padé approximations and diophantine geometry](https://doi.org/10.1073/pnas.82.8.2212).
Fischler--Rivoal explicitly place elliptic integrals and hypergeometric values
at rational points in the ring of G-function values; see
[On the values of G-functions](https://ems.press/journals/cmh/articles/12624).
Zudilin's general irrationality measure still writes a rational evaluation
point as `a/b`, with hypotheses depending directly on `b`; see
[On a measure of irrationality for values of G-functions](https://www.mathnet.ru/eng/im63).
These results control irrationality or linear forms, not a radical-sensitive
positive lower bound for `F(b/c)` itself.  Equations `(9.3)` and `(9.5)` explain
why neither the evaluation denominator nor the norms of all its conjugates may
be omitted.

## 10. The coefficient `1/2` is sharp for height-only lower bounds

Consider the primitive infinite family

```text
(a,b,c)=(n,1,n+1).                                (10.1)
```

By positivity of the integrand and
`1-z sin^2(theta)>=1-z`, for `z=1/(n+1)` one has

```text
pi/2 <= K(1/sqrt(n+1))
     <= (pi/2)sqrt((n+1)/n).                       (10.2)
```

Therefore

```text
pi/sqrt(n+1) <= Omega_n <= pi/sqrt(n).             (10.3)
```

In particular,

```text
-log Omega_n=(1/2)log(n+1)-log pi+o(1).            (10.4)
```

The fully quantified no-go statement is: for every `alpha<1/2` and every
`C>0`, there are infinitely many `n` such that

```text
Omega_n < C (n+1)^(-alpha).                        (10.5)
```

Hence no uniform period lower bound depending only on `c` can improve the
exponent to `<1/2`.  The exponent `1/2` itself is merely the elementary lower
bound from `(2.1)` and `K>=pi/2`; it still contains no radical information.

## 11. The best current unconditional support-sensitive lower bound

Here let `r=rad(abc)` denote the integer rather than its logarithm.
Stewart--Yu proved that there is an effective absolute constant `kappa>0` such
that every positive primitive solution satisfies

```text
log c <= kappa r^(1/3)(log r)^3.                  (11.1)
```

The original source is
[On the abc conjecture, II](https://repository.hkust.edu.hk/ir/Record/1783.1-12057),
Duke Math. J. 108 (2001), 169--181.  Combining it with
`Omega>=pi/sqrt(c)` gives unconditionally

```text
Omega >= pi exp[-(kappa/2)r^(1/3)(log r)^3].       (11.2)
```

This is a proved period lower bound that genuinely uses reduced support, but it
is much weaker than every fixed power `r^(-A)` and therefore remains
essentially distant from the Goldfeld critical exponent.  The best general abc
budget currently reached by ordinary and `p`-adic Baker theory is represented
by `(11.1)`, not by `log c=O_epsilon(log r)`.

There is another quantitative result closer to the modular parameter, but it
controls only "shape," not "scale."  For the narrowness ratio `varpi_E` of the
period lattice of a Frey curve, Pasten proved a bound of the form

```text
varpi_E <= exp[C log N_E/loglog N_E * logloglog N_E]
         =N_E^o(1).                                (11.3)
```

unconditionally; see
[Theorem 107](https://qspace.library.queensu.ca/bitstreams/db563ae1-dac0-45e4-8945-d9715cccbb15/download)
in Chapter 5 of his doctoral thesis.  Under the normalization `b<=a` used here,
this controls `Im(tau)`, and therefore the shape loss
`-log q=pi Im(tau)`, but it leaves the scale factor `c^(-1/2)` in `(2.1)`
completely unchanged.  Thus, even if `(11.3)` is taken as the best
conductor-sensitive modular-shape input, it still cannot imply an absolute
period lower bound of any fixed power `r^(-A)`.

## 12. The candidate bridge left open by this audit

By `(5.4)`, the Goldfeld lower bound is equivalent to

```text
eta(tau)^2
 >= C'_eta (abc)^(1/6) r^(-1/2-eta).              (12.1)
```

By Theorem 3.1, `(12.1)` is not a weaker conjecture; it is abc in eta
coordinates.  One potentially worthwhile, but presently entirely unproved,
mechanism would use the archimedean hypergeometric solution together with the
unit-root/Tate solution at every bad prime to construct a Frey-specific adelic
Padé determinant and prove

```text
finite-place denominator cost
- archimedean vanishing gain
 <= (1/2+eta) log r + o(log c).                    (12.2)
```

For `(12.2)` to be non-circular, one must prove each of the following:

1. The determinant is nonzero, without placing the target period lower bound
   among the hypotheses.
2. Its coefficients are global algebraic numbers, so that the product formula
   applies.
3. The valuation depths in `(8.4)` and `(9.3)` undergo genuine cancellation
   across primes.
4. The remainder estimate is uniform over all primitive triples.
5. The final error is `o(log c)`, rather than a hidden loss of `c^delta` or
   `(log c)^A`.

None of the cited G-function, Baker, elliptic-logarithm, or period theorems
provides these conclusions.  Hence `(12.2)` can only be listed as a genuinely
new research target, not as a proved lemma.

## 13. Lean boundary

The independent Lean file

```text
IUTThreeClosures/FreyCriticalPeriodPadeBarrier.lean
```

formalizes only the following non-circular scalar and arithmetic facts:

- a uniform abc budget implies the critical-period budget;
- the converse under a nonnegative radical and a uniformly sublinear kernel;
- the exact equivalence of the two all-epsilon statements;
- explicit sharpness of the coefficient `1/2` in a height-only model;
- the numerator after Horner denominator clearing is congruent modulo `p` to
  the leading coefficient;
- the factorization depth of the denominator carrier `p^(mN)` is exactly `mN`
  and is unbounded.

The Lean file does not formalize elliptic integrals, theta/eta products,
transcendence of modular functions, Tate uniformization, G-function/Padé
approximation theorems, the Stewart--Yu theorem, or abc.  Every difficult input
is explicitly marked in the paper as a classical external theorem, a
conditional candidate, or an unproved abc-strength proposition.
