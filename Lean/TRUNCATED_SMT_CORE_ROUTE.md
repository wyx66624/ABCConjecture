# The degree-normalized truncated-SMT core

**Status.**  Offline research note.  The scalar rigidity, transfer,
counterexample, and Riemann--Hurwitz coefficient statements in this note are
formally verified in
`IUTThreeClosures/TruncatedSMTCoefficientRigidity.lean`.  The arithmetic
truncated second-main-theorem estimate isolated below is not proved or
assumed by the Lean module.  In particular, this note does not claim a proof
of `abc`.

## 1. The exact missing inequality

For a primitive positive triple

```text
a+b=c,                    lambda=a/c,
h=log c,                  q=log rad(abc),
```

the existing Lean modules prove exactly

```text
h(lambda)=h,
N_{0+1+infinity}^{(1)}(lambda)=q.
```

On the degree-`n^2` Fermat lift `P` over a number field `L`, the local
Kummer calculation gives, away from primes dividing `n`,

```text
normalized reduced boundary = gcd(n,m)/n,
normalized tame different   = 1-gcd(n,m)/n.
```

Their sum is one.  Including the fixed wild allowance gives

```text
N_{D_n}^{(1)}(P)+d(P) <= q+B(n).                    (1.1)
```

The still missing input is a point-uniform inequality of the form

```text
h_{K_{C_n}+D_n}(P)
  <= N_{D_n}^{(1)}(P)+d(P)+rho_n h_{K_{C_n}+D_n}(P)+C_n,eta,    (1.2)
```

with `rho_n <= epsilon/(1+epsilon)`.  No existing module proves (1.2).

## 2. Which uniformity in the constants is actually needed

There are two distinct quantifiers, and conflating them obscures the core.

Suppose a family of covers has a fixed error numerator `kappa`, so that

```text
rho_n = kappa/n^2.
```

Given `epsilon>0`, choose one `n=n(epsilon)` for which

```text
kappa/n^2 <= epsilon/(1+epsilon).
```

For this one cover, (1.1) and (1.2) imply

```text
h <= q + epsilon/(1+epsilon) h + B(n)+C_n,eta,
h <= (1+epsilon)q
     +(1+epsilon)(B(n)+C_n,eta).                    (2.1)
```

The number `B(n)+C_n,eta` may grow arbitrarily fast with `n`; after `epsilon`
is fixed, it is still a valid `C_epsilon`.  Thus **no uniform upper bound in
the cover degree is required for logarithmic `abc`**.

What is indispensable is different: for the selected `n`, the constant in
(1.2) must be independent of `a,b,c`, of their varying support, and of the
chosen lift `P`.  A fixed-`S` S-unit constant becomes circular if `S` is then
set equal to `supp(abc)`.

The Lean theorems `fixed_cover_error_rearrangement`,
`fixed_cover_local_budget_rearrangement`, and
`cover_degree_dilution_rearrangement` verify (2.1) without any estimate on
the growth of the cover-dependent constants.

## 3. Positive averaging cannot dilute the tame coefficient

For an arbitrary positive tame ramification index `e`, put

```text
b(e)=1/e,                 delta(e)=(e-1)/e.
```

Then

```text
b(e)+delta(e)=1.                                         (3.1)
```

This calculation is independent of the Kummer presentation.  It is the
local logarithmic Riemann--Hurwitz identity.  It remains one in a tower,
under a convex average of covering degrees, and after any positive Haar
average.  Ramification outside the chosen boundary adds a nonnegative term
and makes the budget larger.

Consequently no positive averaging of complete boundary--different packets
can lower the conductor coefficient.  A successful average would have to
share a global term between several height inequalities, exploit genuine
cancellation, or produce a separately proved sublinear height error.

## 4. Amortizing one discriminant across a product

A tempting genuinely different construction is to put `k` Kummer lifts in
a product and apply one higher-dimensional inequality.  If the product paid
the truncated boundary and field discriminant only once, its scalar shape
would be

```text
k h <= q + rho h + C.                                  (4.1)
```

Algebraically this gives

```text
h <= (q+C)/(k-rho).
```

The gain is real, but (4.1) is false on the correlated fibre curve when
`k-rho>2`.  Indeed, use the explicit primitive family

```text
(a,b,c)=(1,m,m+1).
```

It has unbounded `h=log(m+1)` and

```text
q = log rad(m(m+1))
  <= log(m(m+1))
  < 2 log(m+1)=2h.                                     (4.2)
```

Substitution into (4.1) would bound

```text
(k-rho-2)h <= C,
```

contradicting `h -> infinity`.  Thus any valid ambient theorem with a proper
exceptional set must be allowed to put the common-fibre diagonal curve into
that set.  The Lean theorem
`no_correlated_product_bound_above_two` formalizes the abstract implication
from (4.2), while `correlatedDiagonal_ne_univ` verifies that the entire
correlated family can lie in a proper exceptional subset.

This is a strict counterexample to the **unexceptional product-amortization
claim**, not to higher-dimensional Vojta theory: the exceptional set is
exactly what prevents the contradiction.

## 5. Support-preserving self-maps cannot escape the diagonal

One might replace the copies of `lambda` by infinitely many rational
self-maps `f(lambda)` while requiring no new primes.  Geometrically that
requires

```text
f^{-1}{0,1,infinity} subseteq {0,1,infinity}.             (5.1)
```

Let `d=deg f`.  The three target fibres in (5.1) are disjoint and supported
on only three source points.  Each fibre has total multiplicity `d`, so each
is one totally ramified point.  Their contribution to Riemann--Hurwitz is

```text
3(d-1).
```

A self-map of `P^1` has total ramification `2d-2`; hence

```text
3(d-1) <= 2d-2,
d=1.                                                     (5.2)
```

The degree-one maps preserving the unordered tripod are just its six
Moebius permutations.  They produce only finitely many correlated curves,
all of which may again be included in the exceptional set.  The numerical
implication (5.2) is the Lean theorem
`three_totally_ramified_fibres_force_degree_one`.

## 6. Allowing new branch points: the reduced-support coefficient formula

Now let `f:P^1->P^1` have degree `d`, without (5.1).  In the reduced pullback
of the target tripod, let

```text
r = number of distinct support points lying in the old source tripod,
s = number of all other distinct support points.
```

Thus `0<=r<=3`.  The three target fibres have total multiplicity `3d` and
`r+s` distinct points.  Their contribution to Riemann--Hurwitz is therefore
exactly `3d-(r+s)`, and hence

```text
3d-(r+s) <= 2d-2,
s >= d+2-r >= d-1.                                    (6.1)
```

For a fixed map, the elementary first-main estimate for the **reduced new
support divisor** is

```text
N_new^(1)(lambda) <= s h(lambda)+O_f(1).               (6.2)
```

On the other hand, `h(f(lambda))=d h(lambda)+O_f(1)`.  Thus the net height
coefficient after paying (6.2) satisfies

```text
G_red(f)=d-s <= r-2 <= 1.                              (6.3)
```

Because the data are integral, positive net gain forces

```text
G_red(f)=1,             r=3,             s=d-1.        (6.4)
```

Substitution into (6.1) gives equality, so all Riemann--Hurwitz ramification
is already consumed above the target tripod.  This is the precise
level-one, reduced-support extremal statement.

There is a related multiplicity surrogate.  If `M` is the total
multiplicity supported at the old three points and `E_mult=3d-M` is the
total multiplicity elsewhere, then `M-3<=2d-2`, so

```text
d-E_mult=M-2d<=1.
```

The existing Lean theorems `tripod_correspondence_net_gain_le_one` and
`positive_tripod_correspondence_gain_is_extremal` verify this surrogate as
an integer identity.  It must not be confused with level-one truncation:
`E_mult` counts multiplicity, whereas (6.1)--(6.4) use the distinct support
count `s`.  The new reduced-support Lean theorems verify (6.3)--(6.4)
directly.

A theorem proving that radicals of the extra divisor values are uniformly
smaller than their generic reduced-support height cost could improve the
argument, but that would itself be new arithmetic content, not a free
consequence of the cover.

## 7. A shear that genuinely escapes a fixed exceptional set

There is a useful correction to the diagonal construction.  Work on

```text
X=(P^1)^2,
D_X=pr_1^*{0,1,infinity}+pr_2^*{0,1,infinity},
K_X+D_X=O(1,1).
```

Instead of `(lambda,lambda)`, use

```text
P_u(lambda)=(lambda,u lambda),             u in Z_{>0}.  (7.1)
```

Let `Z` be any fixed proper closed subset of `X`.  On the affine chart,
choose a nonzero polynomial `F(t,s)` whose zero set contains all of
`Z intersect A^2`.  This treats all components of `Z` at once; replacing
several defining equations by one nonzero member of their ideal only makes
the set to be avoided larger.  Write

```text
F(t,s)=sum_{j=0}^r A_j(t)s^j.
```

Choose one nonzero coefficient `A_j0`.  The set

```text
T={t : A_0(t)=...=A_r(t)=0}
```

is contained in the finite root set of `A_j0`.  It contains every `t` for
which the whole vertical fibre may lie in `V(F)`, and hence every vertical
fibre component of `Z`.  For `t` outside `T`, `F(t,S)` is a nonzero
polynomial of degree at most `r`.  The `r+2` values

```text
S=2t,3t,...,(r+3)t
```

are distinct for `t!=0`; at most `r` are roots of `F(t,S)`, and at most one
equals `1`.  Hence, with the single finite set

```text
U_Z={2,...,r+3},
```

every `t notin T` with `0<t<1` admits a `u in U_Z` for which `P_u(t)` lies
outside both `Z` and the boundary.  The set `T intersect Q intersect (0,1)`
is finite.  The maximum height of its elements is therefore a finite number
depending only on `Z`, and all inequalities for those fibres can be absorbed
into the final additive constant.  This quantifies both the nonvertical
components and the finitely many whole vertical-fibre exceptions.  Thus a
bounded shear selected after seeing `Z` really does evade the
exceptional-set trap.

For `lambda=a/c` in lowest terms and fixed `u`, reduction can only lower the
height, and `gcd(u,c)<=u`; therefore

```text
h-log u <= h(u lambda) <= h+log u.                       (7.2)
```

Here it is essential that `N_{D_X}^{(1)}` means truncation of the **reduced
union divisor**.  At a finite prime `p`, its local value is

```text
min(sum of the component intersection multiplicities at p,1) log p.
```

It is not the sum of a separate level-one truncation for every component.
Consequently primes already occurring in `a` or `c` are paid only once even
though they occur in both coordinates.  After reducing the fraction
`u a/c`, cancellation can only remove primes, and one has the exact support
inclusion

```text
supp_DX(lambda,u lambda)
  subseteq supp(abc) union supp(u) union supp(c-u a).     (7.3a)
```

Thus the second tripod coordinate introduces, outside the original reduced
union, only the fixed primes of `u` and primes of `c-u a`.  If truncation
were instead summed component by component, an additional copy of the old
support mass `q` could occur and the coefficient calculation below would
not follow.  Since

```text
|c-u a| < (u+1)c,
```

its reduced-union counting function satisfies

```text
N_{D_X}^{(1)}(P_u(lambda))
  <= q+h+log(u(u+1)).                                    (7.3)
```

Suppose one had the surface truncated SMT

```text
h_{O(1,1)}(P)
  <= N_{D_X}^{(1)}(P)+eta h_{O(1,1)}(P)+C_eta            (7.4)
```

outside a proper `Z_eta`.  Choose the bounded shear above.  Combining
(7.2)--(7.4) gives

```text
(1-2eta)h <= q+O_eta(1).                                 (7.5)
```

Taking

```text
eta=epsilon/(2(1+epsilon))
```

turns (7.5) into `h<=(1+epsilon)q+O_epsilon(1)`.

This is a genuinely workable **exceptional-avoidance mechanism**: it does
not require any control of the degree or number of components of `Z_eta`
beyond finiteness for the fixed `eta`, because the resulting bound on `u`
may be absorbed into `C_epsilon`.

It is not yet a proof of `abc`, because (7.4) is precisely an arithmetic
truncated theorem of Vojta strength.  Since the chosen candidates satisfy
`u>=2`, restricting `D_X` to the shear curve gives the four distinct points

```text
{0,1,infinity,1/u} on P^1.
```

Its log-canonical degree is two.  The extra point contributes the `h` in
(7.3), leaving exactly the original coefficient-one tripod problem.  The
shear removes the higher-dimensional exceptional-set loophole but does not
manufacture truncation.

## 8. Why current Subspace and S-unit inputs stop here

The standard inputs have the wrong output type for (1.2) or (7.4).

1. A fixed-`S` S-unit theorem gives finiteness, or a number of solutions,
   after `S` has been chosen.  It does not bound the maximum height by a
   constant uniform in the varying set `S`.

2. Effective Baker bounds retain products such as
   `prod_{p in S} log p` and rapidly growing functions of `|S|`.  Already for
   two real place logs, `t^2` cannot be bounded by
   `alpha(2t)+C` uniformly in `t`.  Lean verifies this strict
   non-absorbability in `two_place_log_product_not_linearly_absorbable`.
   This does not refute adding new arithmetic structure to Baker's method; it
   proves that the displayed product dependence alone is too large.

3. Schmidt's Subspace Theorem controls proximity to a fixed collection of
   linear forms and permits exceptional subspaces.  It does not replace the
   variable-prime multiplicity by the level-one global counting function.
   A theorem that supplied exactly that truncation for (7.4) would, by the
   elementary shear transfer above, already prove `abc`.

4. Quantitative control of the number or degree of exceptional subspaces is
   not the main obstruction after the shear correction.  The bounded-shear
   argument handles any one fixed proper algebraic exceptional set.  The
   unresolved step is the global truncated inequality itself.

Thus current quantitative Subspace/S-unit inputs do not yield coefficient
`1+epsilon`.  The exact missing innovation is a number-field truncation
principle that controls repeated prime powers uniformly while the prime set
varies.  Cover-degree averaging, Kummer different cancellation, and
exceptional-set avoidance have now been separated from that core.

## 9. Honest next targets

1. Prove the local-field version of (1.1) in Lean, connecting actual DVR
   ramification and the different ideal to the already verified numerical
   coefficient identity.
2. Formalize the bounded-shear exceptional-avoidance lemma for a polynomial
   exceptional locus and the elementary height bounds (7.2)--(7.3).
3. Search for a restricted four-point truncated inequality for the special
   linear forms

   ```text
   a, c-a, c, c-u a
   ```

   whose constant is uniform in the support.  Any use of Baker or Schmidt
   must expose every support-dependent term before absorption.
4. A route may improve (6.2) only by proving a genuine radical estimate for
   the values of the new boundary divisor.  Such an estimate must be audited
   for equivalence to the original three-point `abc` statement.
