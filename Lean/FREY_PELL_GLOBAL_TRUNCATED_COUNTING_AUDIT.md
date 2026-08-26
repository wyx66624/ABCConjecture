# Global truncated counting in the Pell radical pair

## Abstract

Let

\[
 s_n+r_n\sqrt3=(7+4\sqrt3)^n,
 \qquad b_n=s_n^2-3,
 \qquad c_n=s_n^2-2,
 \qquad X_n=b_nc_n,
\]

and put \(\lambda=97+56\sqrt3\).  This note tests whether the fixed global
units behind this pair allow existing subspace-theorem, gcd, or logarithmic-
form results to prove the required joint radical estimate.

There is one unconditional positive advance.  Yu's explicit dependence on a
split moving prime gives, uniformly for every odd \(p\mid X_n\),

\[
 v_p(X_n)\ll {p-1\over\log p}\log(64\max(n,3)).            \tag{0.1}
\]

Consequently the powerful excess supported on
\(p\le\sqrt{n/\log\log n}\) is
\(O(n/\log\log n)=o(n)\), pointwise for every sufficiently large index,
not merely on average.  Hence any remaining linear obstruction must migrate
through primes above this slightly sub-square-root scale.

There is also a sharper global gcd carrier.  For each fixed index gap \(d\)
one can construct a nonzero integer \(R_d\), made from sixteen norms of
differences of the three fixed units, such that

\[
 \gcd_{\rm odd}(X_m,X_n)\mid R_{|m-n|},
 \qquad \log |R_d|=O(d).                           \tag{0.2}
\]

Thus radical overlap in every fixed window is bounded independently of the
starting index.  This does not control a deep prime power occurring in only
one term.

The exact remaining statement is a one-orbit, four-target truncated counting
inequality on \(\mathbf P^1\).  Its conjectural coefficient is \(4-2=2\),
which becomes exactly one rational source-height unit because
\(h(\lambda^n)=\tfrac12n\log\lambda\).  Existing gcd and height theorems for
fixed groups are untruncated and do not supply this coefficient.  In
particular, requiring the whole powerful excess to be \(o(n)\) is almost twice
as strong as the estimate needed for the Pell abc family.  No unconditional
abc proof is obtained here.

## 1. The exact budget

Work in

\[
 L=\mathbf Q(\sqrt2,\sqrt3)
\]

and define

\[
 \gamma_b=5+2\sqrt6,
 \qquad
 \gamma_c=3+2\sqrt2.
\]

The four-target factorization is

\[
 \begin{aligned}
 4\lambda^n b_n
   &=(\lambda^n-\gamma_b)(\lambda^n-\gamma_b^{-1}),\\
 4\lambda^n c_n
   &=(\lambda^n-\gamma_c)(\lambda^n-\gamma_c^{-1}).
 \end{aligned}                                      \tag{1.1}
\]

The earlier first-hit audit proves that every odd prime in \(X_n\) is
\(1\) or \(23\pmod {24}\), hence splits completely in \(L\).  The four
roots in (1.1) are pairwise distinct at every such prime: the two
discriminant certificates are \(96\) and \(32\), while the cross resultant is
supported at \(2\).

Define the powerful excess

\[
 E_n=\sum_{p\mid X_n}(v_p(X_n)-1)\log p.             \tag{1.2}
\]

Since \(b_n,c_n\) are consecutive, they are coprime, and therefore

\[
 \log X_n
   =\log\operatorname {rad}(b_n)
    +\log\operatorname {rad}(c_n)+E_n.              \tag{1.3}
\]

Also

\[
 \log X_n=2n\log\lambda+O(1).                       \tag{1.4}
\]

It follows that the radical estimate needed by the Pell abc family,

\[
 \log\operatorname {rad}(b_n)+
 \log\operatorname {rad}(c_n)
 \ge (1-\eta)n\log\lambda-O_\eta(1),               \tag{1.5}
\]

is equivalent to

\[
 E_n\le(1+\eta)n\log\lambda+O_\eta(1).              \tag{1.6}
\]

This coefficient check matters.  The stronger proposal \(E_n=o(n)\) would
give

\[
 \log\operatorname {rad}(X_n)
   =2n\log\lambda-o(n),                              \tag{1.7}
\]

whereas (1.5) asks for only one of the two source-height units.  The minimal
new theorem is (1.6), not (1.7).

## 2. A uniform Yu bound for the moving primes

### Proposition 2.1

There are effective constants \(C>0\) and \(n_0\), depending only on the
fixed unit data in (1.1), such that for \(n\ge n_0\) and every odd prime
\(p\mid X_n\),

\[
 v_p(X_n)
 \le C\,{p-1\over\log p}\log(64\max(n,3)).         \tag{2.1}
\]

### Proof

Fix a prime \(\mathfrak p\mid p\) of \(L\).  Complete splitting gives residue
degree \(f_{\mathfrak p}=1\).  Root simplicity and (1.1) select exactly one

\[
 \gamma\in
 \{\gamma_b,\gamma_b^{-1},\gamma_c,\gamma_c^{-1}\}
\]

such that

\[
 v_p(X_n)=
 \operatorname {ord}_{\mathfrak p}(\lambda^n\gamma^{-1}-1). \tag{2.2}
\]

The expression in (2.2) is nonzero because
\(\lambda,\gamma_b,\gamma_c\) are multiplicatively independent.

Apply Theorem 1' of Yu to the two algebraic numbers
\(\lambda,\gamma^{-1}\), with coefficient vector \((n,1)\).  Here the base
field is \(K_0=L\), so \(D_0=4\), and complete splitting gives
\(e_0=f_0=1\).  This is a two-logarithm application.  A crucial point is that
Yu's admissible parameters are not constant when \(p\) moves: they must obey

\[
 V_j\ge\max\{\text{the fixed height terms},(\log p)/32\}.
\]

Choose both \(V_j\) at this scale.  Since the second coefficient is \(1\),
its \(p\)-adic order is minimal; in Yu's refined notation this permits the
corresponding smaller parameter \(V=V_1\).  Substitution in Theorem 1',
with \(B=\max(n,3)\), has the following complete \(p,V,B\)-dependence:

\[
 {p^{f_0}-1\over(\log p)^{r+2}}V_1V_2
 \log(4D_0^2B)
 \max\!\left\{
   \log(2^{13}3r(r+1)D_0^3V),{f_0\log p\over r}
 \right\}.
\]

For \(r=2,D_0=4,f_0=1\), the chosen parameters satisfy
\(V_1,V_2,V\le C_0\log p\).  The maximum in the last line is at most
\(C_1\log p\) for \(p\ge23\).  Thus the four logarithmic powers simplify
explicitly as

\[
 (p-1)(\log p)^{-4}(\log p)^2
 \log(64B)(\log p)
 \ll {p-1\over\log p}\log(64B),
\]

and Theorem 1' gives

\[
 \operatorname {ord}_{\mathfrak p}
   (\lambda^n\gamma^{-1}-1)
 \ll {p-1\over\log p}\log(64\max(n,3)).
\]

The support primes satisfy \(p\equiv\pm1\pmod {24}\), hence \(p\ge23\);
the finitely many harmless endpoint constants may be absorbed.  Taking the
maximum over the four fixed targets proves (2.1), uniformly in both \(p\)
and the prime above it.  \(\square\)

The residue-degree-one hypothesis is essential for this strength.  Yu's
general factor is \(p^f-1\); treating the theorem as having a constant
independent of a moving nonsplit prime would be incorrect.

### Corollary 2.2: a sub-square-root cutoff

For \(Y\ge23\), put

\[
 E_n(\le Y)=
 \sum_{\substack{p\mid X_n\\p\le Y}}
    (v_p(X_n)-1)\log p.
\]

Then

\[
 E_n(\le Y)
 \ll \log(64\max(n,3))\sum_{p\le Y}p
 \ll {Y^2\log(64\max(n,3))\over\log Y}.           \tag{2.3}
\]

The second estimate follows from the standard Chebyshev bound
\(\pi(t)\ll t/\log t\) and partial summation (or a dyadic decomposition).
In particular,

\[
 \boxed{
 E_n\!\left(\le\sqrt{n/\log\log n}\right)
   =O\!\left({n\over\log\log n}\right)=o(n).}       \tag{2.4}
\]

More generally, if \(\Omega(n)\to\infty\) and
\(\log\Omega(n)=o(\log n)\), the cutoff
\(Y=\sqrt{n/\Omega(n)}\) gives

\[
 E_n(\le Y)=O\!\left({n\over\Omega(n)}\right)=o(n).  \tag{2.5}
\]

All quantifiers in (2.4)--(2.5) are pointwise in \(n\).  This is the part of
the route for which the fixed global units really do overcome the moving-prime
constant problem.

## 3. Fixed-gap norm carriers

Let

\[
 \mathcal A=
 \{\gamma_b,\gamma_b^{-1},\gamma_c,\gamma_c^{-1}\}.
\]

For \(d\ge1\), define the positive integer

\[
 R_d=
 \prod_{a,a'\in\mathcal A}
 \left|N_{L/\mathbf Q}(\lambda^d a-a')\right|.       \tag{3.1}
\]

Every factor in (3.1) is nonzero.  Otherwise
\(\lambda^d a=a'\) would give a nontrivial multiplicative relation among
\(\lambda,\gamma_b,\gamma_c\).  All factors are algebraic integers, so
\(R_d\in\mathbf Z_{>0}\).

### Proposition 3.1

For distinct positive integers \(m,n\),

\[
 \gcd_{\rm odd}(X_m,X_n)\mid R_{|m-n|}.              \tag{3.2}
\]

### Proof

Assume \(n>m\), and let \(p^e\) divide both terms, with \(p\) odd.  At a
split prime \(\mathfrak p\mid p\), root simplicity selects \(a,a'\in\mathcal A\)
such that

\[
 \lambda^n\equiv a,
 \qquad
 \lambda^m\equiv a'
 \pmod {\mathfrak p^e}.                             \tag{3.3}
\]

Dividing the two unit congruences gives

\[
 \lambda^{n-m}a'-a\equiv0\pmod {\mathfrak p^e}.     \tag{3.4}
\]

Because \(p\) is completely split, (3.4) implies

\[
 p^e\mid N_{L/\mathbf Q}(\lambda^{n-m}a'-a).
\]

That norm is one factor of \(R_{n-m}\).  Multiplying over the prime powers in
the gcd proves (3.2).  \(\square\)

Standard height estimates for a fixed finite set of units give

\[
 \log R_d=O(d).                                     \tag{3.5}
\]

This improves the sum-index carrier when two indices are close.  It also
makes the fixed-window conclusion exact.  For every fixed \(M\),

\[
 \log\operatorname {rad}
   \left(\prod_{j=0}^{M-1}X_{n+j}\right)
 =\sum_{j=0}^{M-1}\log\operatorname {rad}(X_{n+j})
   +O_M(1).                                         \tag{3.6}
\]

Indeed, every prime counted in two window terms divides one of the finitely
many \(R_d\), \(1\le d<M\).  If \(M\) is allowed to grow, the elementary
pairwise-overlap budget obtained from (3.5) is \(O(M^3)\).

Equation (3.6) removes radical overlap as an explanation for failure in a
fixed window.  It does not bound the exponent of a prime appearing in only
one window term.  A model consisting of pairwise coprime prime powers has
zero pairwise gcds and arbitrarily small radicals, so no collection of gcd
bounds alone can close the internal multiplicity problem.

## 4. Audit of the proposed global tools

### 4.1 Corvaja--Zannier height and gcd theorems

The fixed-group theorems obtained from the Subspace Theorem control ordinary
heights of rational functions at \(S\)-unit points and gcds of two coprime
functions.  They are highly relevant to (3.2), but they are not truncated
counting theorems.

At a prime where one factor \(x-a\) has valuation \(e\gg1\), its derivative
is \(1\), a unit.  Thus a gcd estimate for a polynomial and its derivative
sees no contribution at precisely the prime whose loss
\((e-1)\log p\) must be bounded.  Likewise, \(b_n\) and \(c_n\) already have
disjoint support.  A codimension-two gcd theorem cannot control multiplicity
on one component of a divisor.

### 4.2 Fixed \(S\) versus moving support

The arithmetic Subspace Theorem is applied after fixing a finite set \(S\)
or a fixed finitely generated group.  It proves, for example, that the
contribution of any fixed finite set of primes is \(O_S(\log n)\).  In the
present problem the relevant set

\[
 S_n=\{p:p\mid X_n\}
\]

moves with \(n\).  Taking a union over all possible \(S_n\) changes the
quantifiers and loses uniformity in both the number and size of the places.
Proposition 2.1 is a legitimate moving-prime statement because Yu's factor
\(p-1\) was kept explicitly; a fixed-\(S\) constant cannot be used in its
place.

### 4.3 Linear forms beyond the cutoff

For split primes Yu gives the best useful uniform feature in this audit, but
the factor \(p-1\) remains.  After summation it proves (2.4), while beyond
the sub-square-root cutoff its aggregate upper bound need not be sublinear;
at the square-root scale it is already linear.  For a single very large prime
it may be weaker than the trivial bound coming from \(p^e\le X_n\).  Thus
(0.1) is not summable over the whole moving support with the coefficient
required in (1.6).

### 4.4 Ordinary averages and density-one statements

An estimate for almost all ambient integers \(s\le Z\) does not specialize to
the Pell orbit.  There are only \(O(\log Z)\) values \(s_n\le Z\), so an
ambient exceptional set of size even \(Z^\theta\), \(\theta>0\), can contain
the entire orbit.  The quantifier must be an average over the indices \(n\)
themselves.

Even a genuine density-one theorem in \(n\) would not imply (1.5), which is
required for every \(n\).  It would nevertheless be a valid partial theorem;
none of the primary results invoked in this note supplies such an
index-density truncated estimate.  An ordinary mean must not be reported as
a pointwise bound.

### 4.5 Products over nearby indices

Proposition 3.1 shows that fixed-window overlap costs only \(O_M(1)\), so a
nearby product faithfully aggregates the individual radicals.  But applying
Stewart's general square-free-factor theorem to the resulting fixed-order
recurrence still gives only

\[
 \log\operatorname {rad}(\text{window product})
 \gg {\log n\,\log_2n\over\log_3n}=o(n)             \tag{4.1}
\]

for fixed \(M\), far below the \(\Theta(Mn)\) window height.  Letting \(M\)
grow with \(n\) is not licensed by a theorem whose recurrence order and
constants depend on \(M\).  The same quantifier issue prevents a fixed-window
average from becoming an all-index result.

## 5. The exact four-target counting problem

Let \(D\) be the reduced divisor on \(\mathbf P^1_L\)

\[
 D=[\gamma_b]+[\gamma_b^{-1}]+[\gamma_c]+[\gamma_c^{-1}],
\]

and let \(S\) contain the archimedean places and the places above \(2\).
For \(x_n=\lambda^n\), use the absolute normalization

\[
 N^{(1)}_{L,S}(D,x_n)
 ={1\over[L:\mathbf Q]}
 \sum_{\mathfrak p\notin S}
 \min\{1,v_{\mathfrak p}(D(x_n))\}\log N\mathfrak p.
\]

Complete splitting of every odd support prime and (1.1) give the exact
identity

\[
 N^{(1)}_{L,S}(D,x_n)
 =\log\operatorname {rad}(X_n)-\log2.               \tag{5.1}
\]

The absolute Weil height is

\[
 h(x_n)=n h(\lambda)={n\over2}\log\lambda.          \tag{5.2}
\]

Therefore (1.5) is equivalent to the one-orbit truncated inequality

\[
 \boxed{
 N^{(1)}_{L,S}(D,\lambda^n)
 \ge(2-\varepsilon)h(\lambda^n)-O_\varepsilon(1)}   \tag{5.3}
\]

for every \(\varepsilon>0\).  The coefficient \(2=\deg D-2\) is precisely
the coefficient predicted by the truncated Second Main Theorem on
\(\mathbf P^1\).  By contrast, the full untruncated divisor has scale

\[
 N_{L,S}(D,\lambda^n)=4h(\lambda^n)+O(1).           \tag{5.4}
\]

Thus the stronger assertion \(E_n=o(n)\) would ask for the truncated count to
be \(4h-o(h)\), not merely the conjectural critical coefficient \(2h-o(h)\).

Vojta's formulation identifies truncated counting on \(\mathbf P^1\) with the
arithmetic radical problem; the ordinary Corvaja--Zannier height theorem does
not contain the truncation in (5.3).  Equation (5.3) is a special one-orbit
case and is weaker than a full abc theorem, but it is not supplied by the
known unconditional results audited here.

## 6. The smallest remaining new proposition

Combining (1.6) and (2.4), it is enough, and up to changing \(\eta\) also
necessary, to prove the following high-prime tail statement:

> For every \(\eta>0\),
> \[
> \sum_{\substack{p\mid X_n\\p>\sqrt{n/\log\log n}}}
>   (v_p(X_n)-1)\log p
> \le(1+\eta)n\log\lambda+O_\eta(1).               \tag{6.1}
> \]

Equivalently, one may prove (5.3).  A stronger uniform-integrability theorem
making the left side of (6.1) \(o(n)\) would certainly work, but its extra
coefficient is not needed.

The unresolved primes in (6.1) are moving, large, and may occur for the first
time with high shifted-Wieferich depth.  They can be pairwise disjoint across
indices, so neither (0.2) nor any large-gcd average detects them.  This is the
precise remaining boundary of the Pell joint-radical route.

## 7. Formalization boundary

The companion Lean module
`IUTThreeClosures/FreyPellGlobalTruncatedCountingAudit.lean` proves only:

* the scalar equivalence between the critical radical and excess budgets;
* that a sublinear excess would leave almost two source-height units, hence is
  stronger than required;
* the coefficient identities \((4-2)(H/2)=H\) and \(4(H/2)=2H\);
* an abstract finite moving-weight aggregation lemma; and
* the cleared-denominator scalar implication corresponding to the
  corrected Yu--Chebyshev sub-square-root cutoff.

Lean does not formalize Yu's theorem, prime splitting, Chebyshev estimates,
the norm divisibility in Proposition 3.1, Weil heights, truncated counting,
or (5.3).  No such statement is inserted as an axiom.

## References

* K. Yu, *Linear forms in p-adic logarithms III*, Compositio Mathematica 91
  (1994), 241--276,
  [primary text](https://www.numdam.org/article/CM_1994__91_3_241_0.pdf).
* C. L. Stewart, *On the greatest square free factor of terms of a linear
  recurrence sequence*, in **Diophantine Equations**, Tata Institute Studies
  in Mathematics 20 (2008), 257--264,
  [author's primary text](https://uwaterloo.ca/pure-mathematics/sites/default/files/uploads/documents/greatest_square_free_factor_0.pdf).
* P. Corvaja and U. Zannier, *A lower bound for the height of a rational
  function at S-unit points*, Monatsh. Math. 144 (2005), 203--224,
  [authors' preprint](https://arxiv.org/abs/math/0311030).
* Y. Bugeaud, P. Corvaja and U. Zannier, *An upper bound for the G.C.D. of
  \(a^n-1\) and \(b^n-1\)*, Math. Z. 243 (2003), 79--84,
  [journal record](https://doi.org/10.1007/s00209-002-0449-z).
* P. Vojta, *A more general abc conjecture* (1998),
  [primary text](https://arxiv.org/abs/math/9806171).
