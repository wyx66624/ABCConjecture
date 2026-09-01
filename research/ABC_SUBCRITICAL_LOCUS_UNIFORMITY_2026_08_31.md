# Subcritical-locus uniformity: the exact positive gate from counting to abc

Author: ChatGPT. Date: 2026-08-31.

## 0. Status and purpose

This note develops a positive proof route while auditing the precise point at
which current counting results stop.  It does not assume or claim the abc
conjecture.  The principal unconditional theorem is an exact equivalence
between the standard logarithmic `ABCConjecture` and uniform boundedness of
every fixed subcritical radical locus.  The equivalence is proved directly,
so the new predicate is not substituted for the original target by
definition.

The note then applies this criterion to the mixed-full Campana locus treated
by Browning--Verzobio, *Sums of three powerful numbers*, arXiv:2608.24512v1
(25 August 2026).  Their genuine power-saving estimate has a positive
counting exponent.  A strict sparse countermodel below proves that such a
bound, even when combined with a square-size gap between successive heights,
cannot imply the pointwise boundedness required by abc.

Finally, two sufficient upgrades are isolated.  A decaying dyadic-shell
bound eventually below one forces the shells to be empty.  More usefully for
the present analytic and Frey routes, a single-source amplification whose
distinct fibre is larger than the entire counted target set forces the source
height to be bounded.  The latter pointwise argument needs no overlap bound
between fibres belonging to different sources.

No external counting estimate is introduced into Lean as an axiom.

## 1. The unchanged logarithmic target

For a positive primitive triple

\[
                 a+b=c,
 \qquad \gcd(a,b)=\gcd(b,c)=\gcd(c,a)=1,
\]

write

\[
 H(P)=\log c,
 \qquad
 R(P)=\log\operatorname{rad}(abc).
\tag{1.1}
\]

The standard logarithmic abc conjecture is

\[
 \forall\varepsilon>0\ \exists C_\varepsilon\ \forall P,
 \qquad
 H(P)\le (1+\varepsilon)R(P)+C_\varepsilon.
\tag{1.2}
\]

Define **subcritical-locus uniform boundedness** to be the following
statement:

\[
 \boxed{
 \forall\mu\in[0,1)\ \exists B_\mu\ \forall P,
 \quad R(P)\le\mu H(P)\Longrightarrow H(P)\le B_\mu .}
\tag{1.3}
\]

The constant in (1.3) may depend on the fixed slope `mu`, but it is
independent of the triple and of its prime support.

### Theorem 1.1 (exact subcritical-locus equivalence)

The standard logarithmic abc conjecture (1.2) is equivalent to
subcritical-locus uniform boundedness (1.3).

**Proof, abc implies (1.3).**  Fix `0 <= mu < 1` and put

\[
             \eta=\frac{1-\mu}{2}>0.
\tag{1.4}
\]

The coefficient left after inserting the subcritical radical bound is

\[
\begin{aligned}
 d
   &=1-(1+\eta)\mu\\
   &=\frac{(1-\mu)(2-\mu)}2>0.
\end{aligned}
\tag{1.5}
\]

Apply (1.2) with `eta`, and let `C_eta` be its uniform constant.  If
`R(P) <= mu H(P)`, then

\[
 H(P)
 \le (1+\eta)R(P)+C_\eta
 \le (1+\eta)\mu H(P)+C_\eta.
\]

Hence

\[
                      H(P)\le C_\eta/d.
\tag{1.6}
\]

Taking `B_mu=C_eta/d` proves (1.3).

**Proof, (1.3) implies abc.**  Fix `epsilon>0` and set

\[
                    \mu=\frac1{1+\varepsilon}.
\tag{1.7}
\]

Then `0<mu<1`.  Let `B_mu` be supplied by (1.3), and put
`C_epsilon=max(B_mu,0)`.  For an arbitrary primitive positive point `P`,
there are two cases.

If `R(P) <= mu H(P)`, then (1.3) gives `H(P)<=B_mu`.  Since
`R(P)>=0` and `C_epsilon>=B_mu`,

\[
                  H(P)\le(1+\varepsilon)R(P)+C_\varepsilon.
\]

If `R(P)>mu H(P)`, multiplication by the positive number `1+epsilon`
and `(1+epsilon)mu=1` give

\[
                  H(P)<(1+\varepsilon)R(P)
                       \le(1+\varepsilon)R(P)+C_\varepsilon.
\]

Thus one constant works for every point, proving (1.2).  \(\square\)

This theorem gives a positive route with exactly the right quantifiers.  To
prove abc it is enough, and also necessary, to rule out height-unbounded
families on every fixed slope `mu<1`.  It is not enough to show that such
families have density zero or a positive power saving.

## 2. Placement of the mixed-full Campana result

Suppose that the coordinates of `P` are respectively `p`-, `q`-, and
`r`-full.  The elementary radical-compression argument gives

\[
 R(P)\le\sigma_{p,q,r}H(P),
 \qquad
 \sigma_{p,q,r}=\frac1p+\frac1q+\frac1r.
\tag{2.1}
\]

Consequently, when `sigma_{p,q,r}<1`, this fixed mixed-full locus is a
subset of one of the subcritical loci in (1.3).  Theorem 1.1 says that abc
would bound its height.  Conversely, an unbounded family in this locus would
disprove abc.  These two implications and the exact radical-power inequality
are proved separately in the repository's mixed-full Campana report.

Browning--Verzobio count this locus.  For `p=r+u`, `q=r+v`, with fixed
`u>=v>=0` and sufficiently large `r`, their Theorem 1.1 gives

\[
 N_{p,q,r}(B)
 \ll B^{\theta_{p,q,r}+\epsilon},
 \qquad
 \theta_{p,q,r}
   =\frac1p+\frac1q-\eta_{u,v}(r),
 \quad
 \eta_{u,v}(r)=\frac1{r^2}+O(r^{-5/2})>0.
\tag{2.2}
\]

The exponent `theta_{p,q,r}` remains positive in the ranges proved in the
paper.  Therefore (2.2) permits an unbounded sequence of mixed-full points.
It does not establish the boundedness demanded by (1.3), and it does not
construct such a sequence either.

Dyadic decomposition does not change this conclusion.  A cumulative bound
`N(B)<<B^theta` only gives the same positive-power upper bound for each shell.
It allows one point in infinitely many shells.

## 3. A strict sparsity-and-gap countermodel

The failure above is logical, rather than a weakness in a particular
constant.  Define a sequence of integer heights

\[
                       X_n=2^{2^n}\qquad(n\ge0).
\tag{3.1}
\]

It has the exact gap law

\[
                       X_{n+1}=X_n^2.
\tag{3.2}
\]

Let

\[
                A(X)=\#\{n\ge0:X_n\le X\}.
\]

For `X>=2`, taking two base-two logarithms gives

\[
                 A(X)\le 1+\log_2\log_2 X.
\tag{3.3}
\]

In particular, for every fixed `theta>0`,

\[
                         A(X)=O_\theta(X^\theta).
\tag{3.4}
\]

For completeness, (3.4) follows directly from exponential dominance.  Put
`t=log X`.  The elementary calculus inequality

\[
                \log t\le \frac{t^\alpha}{\alpha e}
                \qquad(t>0,\ \alpha>0)
\]

is obtained by maximizing `log(t)/t^alpha`; take, for example,
`alpha=theta/2`.  A second application of the same inequality, or simply
`(log X)^{theta/2}=o(X^theta)`, gives (3.4), with an explicit constant after
enlarging it over a bounded initial interval.

The set (3.1) is nevertheless infinite and height-unbounded.  It satisfies a
positive power-saving estimate for every positive exponent and has a
quadratic lower gap between successive points.  Hence the following proposed
inference is false:

> positive power-saving count + rapidly growing gaps => finitely many points.

The same example places one point in infinitely many widely separated dyadic
shells.  A lower gap principle makes a sequence sparser; it does not remove
its last infinitely many points.  To obtain finiteness from counting, one
needs an upper bound which eventually drops below the integer threshold one,
or a mechanism which turns each single source into too many counted targets.

This countermodel is not an abc counterexample.  It is a strict counterexample
to a proposed logical upgrade from sparse counting to pointwise boundedness.

## 4. Two sufficient counting upgrades

### Theorem 4.1 (decaying dyadic shells)

Let `E_k` be finite sets covering all objects of heights in the dyadic shells
`[2^k,2^{k+1})`.  Suppose there are constants `C>0` and `delta>0` such that

\[
                         |E_k|\le C2^{-\delta k}
\tag{4.1}
\]

for all sufficiently large `k`.  Then all sufficiently large shells are
empty, and the union of the objects has bounded height.

**Proof.**  Since `delta>0`, the right side of (4.1) tends to zero.  Choose
`K` so that it is strictly below one for every `k>=K`.  The cardinality
`|E_k|` is a nonnegative integer bounded above by a real number below one;
therefore `|E_k|=0`.  The finitely many preceding shells have bounded height.
\(\square\)

Browning--Verzobio's current exponent is positive, so their estimate grows
instead of decaying and does not meet this threshold.

### Theorem 4.2 (single-source amplification threshold)

Let `T(Y)` be a class of counted targets of height at most `Y`, and suppose

\[
                         |T(Y)|\le C Y^\theta
\tag{4.2}
\]

for `Y>=1`, where `C>0` and `theta>=0`.  Suppose every source object of
height `X>=1` in a specified bad locus produces a set `F_X` of **distinct**
targets.  Assume `kappa>=0` and `beta>=0`, and suppose

\[
            F_X\subseteq T(X^\kappa),
 \qquad
            |F_X|\ge X^\beta.
\tag{4.3}
\]

If

\[
                            \beta>\kappa\theta,
\tag{4.4}
\]

then the heights of all source objects in the bad locus are bounded by

\[
                    X\le C^{1/(\beta-\kappa\theta)}.
\tag{4.5}
\]

**Proof.**  Inclusion and (4.2)--(4.3) give

\[
 X^\beta\le |F_X|\le |T(X^\kappa)|
              \le C X^{\kappa\theta}.
\]

Here `X^kappa>=1` follows from `X>=1` and `kappa>=0`, so (4.2) is
applicable at the displayed target scale.  Moreover `kappa*theta>=0`, and
(4.4) makes the exponent `beta-kappa*theta` strictly positive.

Divide by the positive quantity `X^{kappa theta}` and use (4.4):

\[
                       X^{\beta-\kappa\theta}\le C.
\]

Taking the positive root gives (4.5).  \(\square\)

No multiplicity or overlap bound between `F_X` and `F_{X'}` is needed for
this pointwise conclusion.  Overlap is needed when one wants an upper bound
for the number of distinct source objects by double-counting all fibres at
once.  To rule out one source above a threshold, its own distinct fibre is
already bounded by the entire target count.

Applied to (2.2), the exact design inequality is

\[
               \boxed{\beta>
                 \kappa\left(\frac1p+\frac1q
                   -\eta_{u,v}(r)+\epsilon\right).}
\tag{4.6}
\]

Thus the Browning--Verzobio theorem can contribute to a proof of abc if one
constructs, from every point in a fixed subcritical radical locus, a distinct
mixed-full fibre satisfying (4.3) and (4.6).  This is a concrete positive
target.  The repository's audited CRT and square-completion amplifiers do not
currently meet the analogous exponent threshold, but (4.6) leaves other
variable-degree, level-structure, Galois, or geometric amplifiers open.

If such an amplification is proved for every `mu<1`, Theorem 4.2 supplies the
height bound (1.3) for every subcritical locus, and Theorem 1.1 then gives the
unchanged standard `ABCConjecture`.

## 5. Relation to the Frey critical coefficient

For the canonical Frey curve actually defined in the repository,
`FreyJHeightCorridor.lean` proves the exact bounded-discrepancy corridor

\[
 \left|H(P)-\frac16h(j(E_P))\right|
 \le \max\left\{\frac{\log8}{6},\frac{\log256}{6}\right\}.
\tag{5.1}
\]

The separate modified-height route proves
`6H(P)<=h_mod(P)<=6H(P)+log 4096`.  For the explicitly defined
discriminant-radical conductor `R_F(P)`, it also proves
`R_F(P)<=R(P)+log 2`.  Consequently a uniform estimate

\[
                 h_{\rm mod}(P)
                    \le6(1+\varepsilon)R_F(P)+C_\varepsilon
\tag{5.2}
\]

has exactly the coefficient required by the proved theorem
`abc_of_uniform_freyModifiedSzpiro` to imply abc.  These statements concern
the repository's canonical Frey model and its discriminant-radical
conductor; they do not assert an unformalized comparison for every elliptic
curve or identify this auxiliary integer with a Neron conductor.  The
repository's entire-isogeny-class paper audit gives an explicit infinite
family on which every coefficient strictly below six fails.  Theorem 1.1
explains why combining a subcritical Frey coefficient with an average
counting bound cannot bypass the critical issue: one still must uniformly
bound every fixed subcritical radical locus.

The viable Frey alternative is again pointwise.  Either prove the critical
`6(1+epsilon)` height--conductor estimate, or construct a source-dependent
family of auxiliary curves large enough to beat the relevant exceptional-set
count by Theorem 4.2.

## 6. Formalization boundary

The companion Lean module should contain no project-specific axioms,
placeholders, `sorry`, or `admit`.  Its kernel proofs may have the standard
Mathlib dependencies `propext`, `Classical.choice`, and `Quot.sound`.  It
contains:

1. the definition of subcritical-locus uniform boundedness;
2. both directions of Theorem 1.1 against the unchanged `ABCConjecture`;
3. the local integer-cardinality threshold saying a finite shell whose real
   cardinal is below one is empty;
4. the pointwise finite-fibre lemma: a fibre contained in a counted target set
   cannot have larger cardinality than that target set;
5. the linear logarithmic exponent calculation underlying (4.5);
6. an exact super-sparse sequence with `X_(n+1)=X_n^2`, strict growth, and
   finite prefixes of cardinal `n+1`; its exhaustive cutoff count satisfies
   the exact iterated-log bound and, for every integer `X>=2`, the genuine
   power saving `A(X)^2<=X`.  The prefix cardinalities are nevertheless
   unbounded, giving a kernel-checked witness that a power saving plus the
   square-gap law does not yield finiteness.

The Browning--Verzobio determinant-method estimate, the stronger all-positive-
exponents asymptotic statement `A(X)=O_theta(X^theta)`, and any future
arithmetic amplifier remain paper mathematics until their actual hypotheses
and proofs are formalized.  The concrete exponent-one-half estimate needed
for the strict logical counterexample is formalized.  External results must
not be inserted as structure fields that merely restate the missing uniform
result.
