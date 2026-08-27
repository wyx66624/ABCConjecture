# Pythagorean transfer versus "abc almost always": an amplification audit

## 0. Scope and verdict

This note audits whether the repository's exact Pythagorean transfers can be
combined with unconditional exceptional-set estimates to prove `abc`.  It also
audits the claimed unconditional counterexample in Carella,
arXiv:2608.16764v2.  The literature cut-off is 2026-08-27.

The answer to both proposed shortcuts is negative.

* The exceptional-set theorems give power upper bounds, not finiteness.  The
  negation of `abc` supplies an unbounded exceptional count for one fixed
  exponent, but supplies no lower density or gap control.  An infinite bad
  sequence may therefore be arbitrarily lacunary.
* The fixed Pythagorean transfer sends source height `c` to abc height
  comparable with `c^4`.  Its entire target locus has only `O(T^(1/2))` points
  up to target height `T`, whereas every applicable published exceptional-set
  exponent is strictly greater than `1/2`.  Thus the published upper bounds
  do not even exclude the possibility that every point of this locus is bad.
* The usual tripod symmetries, primitive-Pythagorean parametrization, and
  same-support rational self-maps have only bounded fibres/orbits.  They cannot
  turn an arbitrarily lacunary infinite source set into a set that violates a
  positive-power upper bound.
* The moving-`D` transfer has quadratic rather than quartic target height, but
  it still produces one target per source and weakens, rather than improves,
  the known counting estimate.
* Carella's proposed construction would indeed give genuine `abc`
  counterexamples if the required low-`omega` smooth integers existed.  The
  first decisive failure is the passage from (4.7) to (4.8): an absolute
  Dickman-function error sums to `O(h/u^6)`, not `O(h rho(u))`.  Since
  `rho(u) = o(u^(-A))` for every fixed `A`, the only justified error bound has
  a scale much larger than the complete smooth-number main term and cannot be
  absorbed.  The moment estimates and the low-`omega` selection used in
  Theorem 5.1 consequently do not follow.

The companion file
`IUTThreeClosures/GlobalABCPTAlmostAllAmplificationAudit.lean` proves only the
elementary abstract-count and real-exponent inequalities used below.  It does
not formalize, assume, or re-export any external analytic theorem.

## 1. The exact exceptional-counting statements

For fixed `lambda > 0`, let

\[
 N_\lambda(X)=\#\{(a,b,c)\in[1,X]^3:\gcd(a,b,c)=1,
     \ a+b=c,\ \operatorname{rad}(abc)<c^\lambda\}.
                                                        \tag{1.1}
\]

Because the variables are positive and `a+b=c`, the box height in (1.1) is
exactly the condition `c <= X`.  Also, primitivity is equivalent to pairwise
coprimality in this equation.

The relevant results, with versions kept separate, are as follows.

1. Lichtman, [*The abc conjecture is true almost always*,
   arXiv:2505.13991v1](https://arxiv.org/pdf/2505.13991v1), defines `E(N)` by
   `rad(abc) < c^(1-epsilon)` in (1.2), p. 1, and proves

   \[
      |E(N)|=O(N^{2/3})                              \tag{1.2}
   \]

   in Theorem 1.1, p. 2.  The paper itself observes on p. 1 that `abc` would
   be the much stronger bound `O_epsilon(1)`.

2. The original three-author version of Browning--Lichtman--Teräväinen,
   [arXiv:2410.12234v1](https://arxiv.org/pdf/2410.12234v1), Theorem 1.2,
   p. 1, proves for fixed `lambda in (0,1.001)` that

   \[
      N_\lambda(X)=O(X^{33/50}).                    \tag{1.3}
   \]

3. The current version is Bernert--Browning--Lichtman--Teräväinen,
   [*Bounds on the exceptional set in the abc conjecture*,
   arXiv:2410.12234v2](https://arxiv.org/pdf/2410.12234v2), posted by arXiv on
   2026-05-09; the manuscript itself is dated 2026-05-12.
   It says explicitly on p. 2 that it merges the earlier three-author article
   with Bernert's improvement.  Its Theorems 1.2 and 1.3, p. 2, give, for
   every `delta > 0`,

   \[
   N_\lambda(X)\ll_\delta
       X^{(23\lambda+3)/40+\delta}\quad(0<\lambda\le2),       \tag{1.4}
   \]

   and

   \[
   N_\lambda(X)\ll_{\delta,\lambda}
       X^{3/5+\delta}\quad(0<\lambda<1).                      \tag{1.5}
   \]

   Proposition 1.1 on the same page records the de Bruijn-type baseline
   `N_lambda(X) << X^(2 lambda/3 + delta)`.

All of (1.2)--(1.5) have a positive exponent in the range relevant here.
They allow an unbounded exceptional count.

## 2. Why an infinite bad sequence need not violate an average bound

One standard finiteness form of `abc` is

\[
  \text{for every }\lambda<1,\quad N_\lambda(X)=O_\lambda(1).
                                                        \tag{2.1}
\]

Consequently, if `abc` is false, then for some fixed `lambda in (0,1)` the
function `N_lambda(X)` is unbounded.  Nothing in this negation gives a lower
bound such as `N_lambda(X) >> X^eta`, or even `>> log log X`.  At the level of
the quantifiers, bad heights could occur at

\[
        H_n=2^{2^n}.                                  \tag{2.2}
\]

Their prefix count is only of order `log log X`.  More generally, the gaps can
be chosen recursively so that the prefix count lies below any prescribed
unbounded envelope.  Thus an upper bound `O(X^theta)` with `theta>0` cannot,
by itself, distinguish a finite exceptional set from an infinite lacunary one.

Suppose a construction maps source exceptions to target exceptions and every
target has at most `K` source preimages.  For prefix counts this gives only

\[
     \#\text{targets}\ \ge {1\over K}\#\text{sources}.       \tag{2.3}
\]

A constant factor does not turn an arbitrarily slowly growing function into a
power.  Likewise, if a seed of height `H` can yield at most `H^A` certified
distinct outputs of height at most `H^B`, then even an ideal full batch from
one lacunary seed has scale at most

\[
       T^{A/B+o(1)},\qquad T\asymp H^B.               \tag{2.4}
\]

To contradict an upper bound `O(T^theta)` one needs a genuine lower-production
theorem with `A/B > theta`, or an independent density/gap theorem for the
source exceptions.  An upper bound on the fibre, by itself, is not such a
lower-production theorem.

## 3. Fixed primitive-Pythagorean transfer: exact exponent ledger

Let `a+b=c` be a positive primitive source triple and put
`R=rad(abc)`.  With the usual parity divisor `d in {1,2}`, define

\[
 X={|a^2-b^2|\over d},\qquad
 Y={2ab\over d},\qquad
 Z={a^2+b^2\over d}.                                  \tag{3.1}
\]

Then `(X,Y,Z)` is a primitive Pythagorean triple.  The elementary height and
radical ledger is

\[
 {c^2\over4}\le Z\le c^2,
 \qquad \operatorname{rad}(XYZ)\le 2R c^3.             \tag{3.2}
\]

The counting theorems in Section 1 count additive abc triples.  Therefore the
relevant target is

\[
          X^2+Y^2=Z^2,                                 \tag{3.3}
\]

namely the abc triple `(X^2,Y^2,Z^2)`, not the non-additive coordinate triple
`(X,Y,Z)`.  Its paper height is

\[
        T=Z^2,\qquad {c^4\over16}\le T\le c^4.          \tag{3.4}
\]

If the source is `lambda`-bad, `R<c^lambda`, then (3.2)--(3.4) imply, for
every

\[
          \mu>{\lambda+3\over4},                       \tag{3.5}
\]

and all sufficiently large `c`,

\[
 \operatorname{rad}(X^2Y^2Z^2)=\operatorname{rad}(XYZ)<T^\mu.
                                                               \tag{3.6}
\]

For `0<lambda<1` one can choose `(lambda+3)/4 < mu < 1`, but necessarily
`mu>3/4`.

### 3.1 The target-locus capacity is already too small

A primitive Pythagorean triple has, up to fixed sign and leg symmetries, the
unique parametrization

\[
   X=m^2-n^2,\qquad Y=2mn,\qquad Z=m^2+n^2.             \tag{3.7}
\]

The condition `Z^2<=T` permits only `O(T^(1/2))` pairs `(m,n)`: indeed
`m,n=O(T^(1/4))`.  Hence the entire squared primitive-Pythagorean locus has

\[
       \#\{(X^2,Y^2,Z^2):Z^2\le T\}=O(T^{1/2}).        \tag{3.8}
\]

Now compare `1/2` with every applicable exceptional exponent.

* Lichtman's headline exponent is `2/3 > 1/2`.
* The original BLT exponent is `33/50 > 1/2`.
* The current uniform exponent at `mu>3/4` satisfies

  \[
     {23\mu+3\over40}>{81\over160}>{1\over2}.          \tag{3.9}
  \]

* The current refined exponent is `3/5 > 1/2`.
* The de Bruijn exponent satisfies `2mu/3 > 1/2`.

Thus even the hypothetical assertion that **every point in (3.8) is an abc
exception** is compatible with all the published upper bounds.  This is
stronger than a lacunarity objection: the counting theorem is vacuous on the
whole algebraic locus reached by the fixed transfer.

### 3.2 The same mismatch in source height

Substituting `T asymp c^4` into the target upper bounds gives

\[
\begin{array}{c|c}
\text{target theorem}&\text{bound expressed in source height }c\\ \hline
\text{Lichtman }2/3 & O(c^{8/3})\\
\text{original BLT }33/50 & O(c^{132/50})=O(c^{2.64})\\
\text{current }3/5 & O(c^{12/5+o(1)})\\
\text{current }(23\mu+3)/40 &
 O(c^{(23\lambda+81)/40+o(1)})
\end{array}                                           \tag{3.10}
\]

where the last row takes `mu` down to the transfer threshold (3.5).  Since
`lambda>0`, its exponent is already greater than `81/40=2.025`.  But there are
only `O(c^2)` positive source triples of height at most `c`.  Consequently
every row of (3.10) is weaker than the trivial source count.

The map (3.1) has only a bounded ambiguity (source leg swap, and fixed sign or
target-leg conventions).  This cannot repair the exponent loss.

## 4. Why symmetries and orbits do not amplify

The rational abc coordinate `t=a/c` has marked divisor `{0,1,infinity}`.  Its
support-preserving automorphism group is the six-element `S_3` tripod orbit.
Applying all of it creates at most six representatives.

For the fixed Pythagorean parameter the relevant marked divisor is

\[
             D=\{0,\infty,1,-1,i,-i\}.                \tag{4.1}
\]

There is also a useful rigidity check.  If a rational self-map `f` of degree
`d` satisfies `f^(-1)(D) subset D`, let `m` be the number of distinct points
above the six marked target points.  Those fibres contribute `6d-m` to the
ramification divisor.  Riemann--Hurwitz gives

\[
       6d-m\le2d-2,\qquad m\ge4d+2.                   \tag{4.2}
\]

Since `m<=6`, (4.2) forces `d=1`.  The remaining Möbius stabilizer is finite
(at most `6*5*4=120`; in fact it is the order-24 octahedral group).  Therefore
there is no degree-greater-than-one same-support rational amplifier hiding in
the parameter line.

Other familiar operations do not change this conclusion.

* Scaling destroys primitivity; primitive reduction returns the same point.
* Allowing the whole rational conic orbit still stays inside the capacity
  bound (3.8).
* A fixed Pell or Gaussian-power orbit has exponentially growing coordinate
  height and hence only `O(log T)` points up to height `T`.
* A rational map that leaves the marked divisor introduces new numerator or
  denominator factors.  Proving that their radicals remain small uniformly is
  new arithmetic input, not a consequence of an exceptional-set upper bound.

## 5. The moving-`D` bridge does not help the count

Writing `a=A u^2`, `b=B v^2` with `A,B` squarefree gives a generalized
Pythagorean target

\[
        X^2+D Y^2=Z^2,\qquad D=AB,                    \tag{5.1}
\]

and hence the abc triple `(X^2,DY^2,Z^2)`.  The exact audit in
`GLOBAL_ABC_MOVING_D_PYTHAGOREAN_EQUIVALENCE_AUDIT.md` gives

\[
       T=Z^2\asymp c^2,
       \qquad \operatorname{rad}(DXYZ)\le 2Rc.         \tag{5.2}
\]

A `lambda`-bad source therefore transfers only at an exponent

\[
               \nu>{\lambda+1\over2}.                 \tag{5.3}
\]

There is again only one canonical target per source, with constant
symmetries.  Applying (1.5) at target height `T asymp c^2` yields
`O(c^(6/5+o(1)))`, whereas applying it directly to the source gives
`O(c^(3/5+o(1)))`.  Using (1.4), the moving-target exponent, taken down to
(5.3), is

\[
       {23\lambda+29\over40},                         \tag{5.4}
\]

while the direct-source exponent is `(23lambda+3)/40`; the transfer loses
`26/40`.  The smaller height distortion therefore does not compensate for the
weaker radical exponent, and there is still no amplification theorem.

## 6. Strict audit of Carella, arXiv:2608.16764v2

The object audited here is N. A. Carella,
[*Note on the Exceptional Set in the ABC Conjecture*,
arXiv:2608.16764v2](https://arxiv.org/pdf/2608.16764v2), 16 pages, revised
2026-08-24.  The rejection below is based on a specific failed estimate, not
on publication status.

### 6.1 What is claimed

Theorem 1.1, p. 2, claims that for every fixed small `epsilon>0` the exceptional
set is nonempty for all large height and has unbounded cardinality.  Theorem
5.1, pp. 12--13, is the proposed construction.  It sets

\[
 x=p^k,\quad k>3,\qquad h=x^{3/5},\qquad
 B=\exp\!\left(c_0(\log x)^{2/3}(\log\log x)^{4/3}\right),    \tag{6.1}
\]

chooses a `B`-smooth `c in [x,x+h]` with
`omega(c)<=2 log log x`, and takes

\[
          a=c-p^k,\qquad b=p^k.                        \tag{6.2}
\]

For large `x`, `p>B`, so the coprimality argument in Remark 5.1, p. 14, is
correct.

### 6.2 The cited short-interval theorem and its exact quantifiers

Carella's Theorem 3.1, p. 4, cites Khalid Younis,
[*Asymptotics for smooth numbers in short intervals*,
arXiv:2409.05761v1](https://arxiv.org/pdf/2409.05761v1), Theorem 1.1,
pp. 2--3.  For every **fixed** `theta` with

\[
             {17\over30}<\theta\le1,                  \tag{6.3}
\]

there exists `C=C(theta)>0` such that, uniformly when

\[
 x^\theta\le h\le x,
 \qquad
 \exp\!\left(C(\log x)^{2/3}(\log\log x)^{4/3}\right)
       \le y\le2x,                                    \tag{6.4}
\]

one has

\[
 {\Psi(x+h,y)-\Psi(x,y)\over h}
 = {\Psi(x,y)\over x}
   \left(1+O_\theta\!\left({\log(u+1)\over\log y}\right)\right),
 \qquad u={\log x\over\log y}.                       \tag{6.5}
\]

The base use with `theta=3/5`, `h=x^(3/5)`, and `B` as in (6.1) is legitimate
once `c_0>=C(3/5)`.  Together with the applicable long-interval smooth-number
asymptotic, it counts about `h rho(u)` total `B`-smooth integers.  In
particular, it supplies smooth integers; it says nothing about their value of
`omega`.

There is a first literal hypothesis gap on p. 8, (4.7).  For divisibility by a
prime `q`, Carella applies (6.5) at base `x/q` and interval length `h/q` while
retaining `theta=3/5`.  But

\[
       {h\over q}={x^{3/5}\over q}
          <\left({x\over q}\right)^{3/5}\quad(q>1),    \tag{6.6}
\]

so the lower bound in (6.4) is not met as written.  The same issue occurs for
`pq` in (4.17).  This particular defect is plausibly repairable: choose a fixed
`theta'` strictly between `17/30` and `3/5`; since `p,q<=B=x^o(1)`, (6.6) with
`theta'` reversed eventually holds after increasing `c_0`.  It is therefore
not the decisive rejection.

### 6.3 The first decisive non sequitur: equations (4.8)--(4.9)

Carella's Lemma 4.1 gives only the absolute approximation

\[
 \rho\!\left(u-{\log q\over\log y}\right)
   =\rho(u)+O\!\left({\log q\over\log y}\,{1\over u^6}\right).
                                                               \tag{6.7}
\]

Insert (6.7) into the first-moment sum in (4.7).  Mertens' weighted prime
estimate gives

\[
\begin{aligned}
 \text{summed absolute error}
 &\ll {h\over u^6\log y}\sum_{q\le y}{\log q\over q}\\
 &\ll {h\over u^6}.                                   \tag{6.8}
\end{aligned}
\]

Equation (4.8), p. 8, replaces this by `O(h rho(u))`; no such implication is
available.  Equation (4.9) itself records only the still weaker `O(h)`.

For the parameters (6.1), `u` tends to infinity and

\[
 \rho(u)=\exp(-u(\log u+\log\log u-1+o(1)))=o(u^{-A})
 \quad\text{for every fixed }A.                       \tag{6.9}
\]

Hence

\[
       {h/u^6\over h\rho(u)\log\log y}
       ={1\over u^6\rho(u)\log\log y}\longrightarrow\infty. \tag{6.10}
\]

Thus the only upper bound justified by (6.7) has a scale larger than the
proposed main term and cannot be absorbed into it.  This does not assert a
lower bound for the actual error; it shows that the displayed estimate is
insufficient.  Therefore Lemma 4.2, (4.5), is not proved.  In the second-moment
calculation (4.17)--(4.19), the corresponding justified error bound is of scale
`O(h log log y/u^6)`, which likewise cannot be absorbed; hence Lemma 4.4 and
Theorem 4.1 do not follow either.

This is also visible from the correct saddle-point weight.  Mehdizadeh,
[*An Erdos--Kac theorem for smooth and ultra-smooth integers*,
arXiv:1710.02117v1](https://arxiv.org/pdf/1710.02117v1), equations (8)--(9),
pp. 4--5, records, for the smooth-number saddle point `alpha`,

\[
       \sum_{q\le y}q^{-\alpha}
       =\log\log y+u+O(u/\log y)\qquad(y>\log x).       \tag{6.11}
\]

In Carella's range `u` is much larger than `log log y`.  The theorem of that
paper has the narrower hypothesis `u=o(log log y)` and cannot itself be
imported to settle Carella's short interval, but (6.11) identifies precisely
why replacing the local smooth weight by `1/q` is not a uniform relative
approximation here.

Even the weaker conclusion in the statement of Carella's Theorem 4.1--that
the high-`omega` subset is `o(h)`--would not suffice.  The complete smooth
population is only `h rho(u)=o(h)`, so every smooth integer could lie in an
`o(h)` subset.  The selection on p. 13 needs an error `o(h rho(u))`, which is
exactly what (6.8) fails to provide.

### 6.4 Conditional quality ledger: the proposed points would be real counterexamples

It is important not to reject the construction at the wrong step.  If one
could actually choose infinitely many smooth `c` in (6.1) with
`omega(c)<=2 log log x`, then

\[
 \operatorname{rad}(abc)
 \le a\,p\,\operatorname{rad}(c)
 \le x^{3/5+1/k+o(1)}.                                \tag{6.12}
\]

Thus their standard abc quality would satisfy

\[
 q(a,b,c)={\log c\over\log\operatorname{rad}(abc)}
 \ge {1\over 3/5+1/k+o(1)}.                           \tag{6.13}
\]

For every fixed `epsilon>0` satisfying

\[
           (3/5+1/k)(1+\epsilon)<1,                   \tag{6.14}
\]

the ratio `c/rad(abc)^(1+epsilon)` would tend to infinity.  This would
genuinely contradict `abc`, not merely produce isolated high-quality examples.
The missing input is exactly the low-`omega` selection, not the final radical
calculation.

There are several secondary textual errors which do not repair that missing
input.

* Theorem 5.1, (5.2), says the abc inequality "fails" but displays
  `c <= c_epsilon rad(abc)^(1+epsilon)`.  The failure should have the opposite
  inequality (for arbitrary fixed `c_epsilon` along the sequence).
* Formula (5.8), p. 14, inserts `(1+epsilon)` in the denominator of the
  "quality index".  Standard quality is (6.13), independent of `epsilon`.
  Table 2 uses the epsilon-dependent number with `epsilon=0.01`; Table 1 uses
  the correct threshold (6.14).
* The displayed rewrite `rho(u)=exp(-(log x)^(1/3+beta))` in (3.12) and
  (4.28) is false for any fixed `beta>0`.  Direct substitution gives an
  exponent of order
  `(log x)^(1/3)/(log log x)^(1/3)`, up to constants and lower-order factors.
  The qualitative fact `rho(u)->0` remains true.
* The definition (1.2), p. 2, uses `c>x`, so the sets decrease with `x`, while
  the proof on p. 15 calls them increasing.  Replacing it by `c<=x` repairs
  monotonicity but does not repair Section 4.

## 7. Exact no-go conclusion and what would be sufficient

The existing PT--abc equivalence bridges remain useful structural reductions,
but the known "almost all" estimates do not close them.  Any successful
amplification would need at least one genuinely new ingredient:

1. a lower-density or bounded-gap theorem for bad abc triples;
2. a construction producing more than `T^theta` distinct target exceptions
   below height `T`, with a proved lower multiplicity and controlled radicals;
3. an exceptional-set theorem with exponent strictly below `1/2` on the
   squared primitive-Pythagorean locus (or, ultimately, exponent zero);
4. a direct finiteness theorem adapted to that thin locus; or
5. in Carella's direction, a short-interval lower-tail theorem producing a
   `B`-smooth integer with `omega(c)<=2 log log x` at the scale (6.1), with an
   error measured relative to `h rho(u)`.

None of these inputs is supplied by the cited results.  Therefore this route
does not currently prove or disprove `abc` unconditionally.
