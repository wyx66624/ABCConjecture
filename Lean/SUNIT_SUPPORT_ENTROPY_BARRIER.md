# Quantitative S-unit bounds with varying support: a support-entropy audit

## 1. Scope

For a primitive positive triple $a+b=c$, put

$$
x=a/c,\quad S=\{p:p\mid abc\},\quad
R=\prod_{p\in S}p=\operatorname{rad}(abc),
$$

$$
L=\log R,\quad r=|S|,\quad P=\max S,\quad h=\log c.
$$

The existing rational-tripod module proves exactly that $S$ is the prime
support of the two rational S-units $x$ and $1-x$, and that their logarithmic
height is $h$. The desired varying-support estimate is

$$
h\leq(1+\varepsilon)L+C_\varepsilon,
$$

with $C_\varepsilon$ independent of $S$.

This note only audits which support-dependent terms could be absorbed into
that shape. It does not prove an actual S-unit height estimate. Its
conclusions about Baker, the Subspace Theorem, and gap principles are limited
to the explicit common constant shapes examined below; they do not retire
those methods in every possible refinement.

## 2. The exact smooth/rough optimizer

Fix $Y>1$ and split

$$
S_{\rm sm}=\{p\in S:p<Y\},\qquad
S_{\rm rough}=\{p\in S:p\geq Y\}.
$$

Then

$$
|S_{\rm sm}|\leq\pi(Y),\qquad
|S_{\rm rough}|\log Y
\leq\sum_{p\in S_{\rm rough}}\log p\leq L.
$$

Consequently, for fixed $K\geq0$,

$$
Kr\leq K\pi(Y)+\frac{K}{\log Y}L.
$$

Given $\eta>0$, choosing $Y$ with $K/\log Y\leq\eta$ gives

$$
Kr\leq\eta L+C_{K,\eta}.
$$

No prime number theorem is needed. This is the useful uniform meaning of
$r=o(L)$ for finite sets of distinct primes.

More generally, let $g(p)\geq0$ satisfy

$$
\frac{g(p)}{\log p}\longrightarrow0.
$$

Choose $Y$ so that $g(p)\leq\eta\log p$ for $p\geq Y$. Then

$$
\sum_{p\in S}g(p)
\leq\sum_{p<Y}g(p)+\eta L
=C_{g,\eta}+\eta L.
$$

An arbitrary constant attached to the exact small support is also harmless:
there are only finitely many subsets of the fixed set of primes below $Y$,
so their constants have one common upper bound.

This is only a sufficient optimization lemma. The missing arithmetic theorem
would still have to produce such a tail-local cost for actual solutions.

## 3. A favorable intermediate height shape

Let $H=e^h$ be multiplicative height. If one could prove, with fixed positive
constants $A,B,C$,

$$
H(x)\leq C\,R\,A^r
\prod_{p\in S}(1+\log p)^B,
$$

then

$$
h\leq L+\log C+r\log A+
B\sum_{p\in S}\log(1+\log p).
$$

Both extra support sums have local cost $o(\log p)$, hence are absorbable by
Section 2. Thus this multiplicative-height envelope would imply the desired
coefficient $1+\varepsilon$.

The location of the logarithm is decisive:

- an $A^r$ factor multiplying $H$ becomes an absorbable $O(r)$ term in $h$;
- a rapidly growing expression occurring directly in an upper bound for
  $h$ need not be absorbable;
- a product of polylogarithmic local factors multiplying $H$ becomes a sum
  of iterated logarithms;
- the same product already present in a bound for $h$ can be superlinear.

No estimate of the displayed favorable form is proved here.

## 4. Strict non-absorption barriers

### 4.1 Fixed radical slope

If $0\leq\varepsilon<\delta$, no constant $C$ satisfies

$$
\delta L\leq\varepsilon L+C\qquad(L\geq0).
$$

Take $L>C/(\delta-\varepsilon)$. Therefore a bound with one fixed residual
term $\delta L$ cannot yield arbitrary epsilon merely by changing the
additive constant. Lean formalizes this fully quantified real inequality.

### 4.2 Largest-prime terms

For every odd prime $p$, the primitive triple

$$
(a,b,c)=(1,p,p+1)
$$

has largest support prime $P=p$. Indeed every prime divisor of $p+1$ is at
most $(p+1)/2\leq p$. Also

$$
R=p\operatorname{rad}(p+1)\leq p(p+1),\qquad
L\leq2\log p+\log2.
$$

Fix $\delta>0$ and $0\leq\varepsilon<\delta/2$. If a support-only
absorption

$$
\delta\log P\leq\varepsilon L+C
$$

held on this family, then

$$
(\delta-2\varepsilon)\log p\leq C+\varepsilon\log2.
$$

Arbitrarily large primes give a contradiction. A term $P^\alpha$ with fixed
$\alpha>0$ in a logarithmic-height bound is worse because
$p^\alpha/\log p$ tends to infinity.

This retires only the direct absorption of such a remaining term. A future
method could still work if it cancels, averages, or replaces the largest-prime
dependence before the final inequality.

### 4.3 Products of place logarithms

For distinct large odd primes $p,q$, the primitive triple

$$
(1,pq,pq+1)
$$

has support containing $2,p,q$ and

$$
L\leq\log(pq)+\log(pq+1)
\leq2(\log p+\log q)+\log2.
$$

Meanwhile

$$
\prod_{\ell\in S}\log\ell
\geq(\log2)(\log p)(\log q).
$$

As both primes grow, the latter divided by the former is unbounded. Hence a
bound for logarithmic height retaining two independently large place-log
factors cannot be converted into a uniform linear function of $L$. Lean
formalizes the exact core $t^2\not\ll t$.

### 4.4 Rank entropy

Linear cost $O(r)$ is absorbable. This does not extend automatically to
$r\log r$. For the first $r$ primes, standard prime-distribution estimates
give $L\asymp r\log r$. Thus a multiplicative-height factor with logarithm
$\delta r\log r$, for fixed positive $\delta$, already consumes a fixed
conductor slope on this extremal support. This paragraph is a paper-only
shape audit and is not imported into Lean.

## 5. Audit of common quantitative shapes

The following are schematic forms, not claims that every theorem in the named
methods has exactly these constants.

| Output shape | After substitution | Verdict for direct conversion |
|---|---|---|
| $H\leq C R A^r\prod(1+\log p)^B$ | $h\leq L+O(r)+O(\sum\log\log p)$ | sufficient |
| $H\leq C R^{1+\delta}A^r$, fixed $\delta>0$ | $h\leq(1+\delta)L+o(L)$ | fixed-slope loss |
| $h\leq C(r)P^\alpha\prod\log p$, with fixed $\alpha>0$ and $C(r)$ bounded below by a positive constant | largest-prime and multi-place products remain in $h$ | far too large by Section 4 |
| solution count at most $e^{O(r)}$ | no maximum height | logically insufficient alone |
| exceptional-subspace count at most $e^{O(r)}$ | counts pieces, not their last points | needs a separate height or descent input |

Classical effective Baker and p-adic logarithm reductions often expose
products of generator heights, residue-characteristic or largest-prime
factors, and rapidly rank-dependent constants in a bound for logarithmic
height. Any particular theorem must have its exact published constants
substituted. If the unfavorable terms above remain after substitution, the
direct route fails the coefficient-one test. This does not rule out a new
linear-forms estimate whose incremental cost for a large prime is
$o(\log p)$.

Quantitative Subspace-Theorem results can give strong counts of exceptional
subspaces or clusters. With varying $S$, one must separately control the
threshold height, the heights of those subspaces, and the points lying on
them. An $e^{O(r)}$ count is not itself a height estimate.

## 6. Why a count or ordinary gap principle does not locate the last point

Consider abstract points indexed by $t\geq0$. Give point $t$ exact support
$\{t\}$, mass $t$, and height $t^2$. Then:

- exact support multiplicity is one;
- every fixed finite support universe contains finitely many points;
- no constants $A,B$ satisfy $t^2\leq At+B$ for every $t\geq0$.

Lean proves all three statements. This is not a counterexample among actual
S-units. It strictly refutes the inference from a support-wise solution count
to a uniform maximum height.

A usual gap principle limits how many solutions fit into a height window. An
isolated solution can still lie arbitrarily high. A count could become useful
with an anchored descent: if excess height $h-L$ canonically generated at
least $\exp(\kappa(h-L))$ controlled descendants, while a theorem bounded
their number by $\exp(Ar+B)$, then

$$
h-L\leq\frac{A}{\kappa}r+\frac{B}{\kappa},
$$

and Section 2 would finish the optimization. No such descendant construction
is proved here.

## 7. Surviving target and exact boundary

A clean sufficient target is a tail-local entropy estimate

$$
h(x)\leq L+\sum_{p\in S}g(p)+C_Y(S_{\rm sm}),
$$

where $g(p)=o(\log p)$ uniformly and, for each chosen cutoff $Y$,
$C_Y$ is finite on the finitely many small supports. The smooth/rough lemma
then gives coefficient $1+\varepsilon$.

The hard content is still the coefficient-one occurrence of $L$. Neither
fixed-S finiteness, a quantitative count, nor any common Baker/Subspace shape
audited above supplies this target. The target remains open.

## 8. Lean ledger

IUTThreeClosures/SUnitSupportEntropy.lean proves:

1. exact small/tail decompositions of finite support mass and cardinality;
2. the threshold inequality for tail cardinality;
3. the general tail-local absorption inequality;
4. its constant-per-support-element corollary;
5. a finite envelope for constants indexed by small-support subsets;
6. the resulting pointwise coefficient-$1+\varepsilon$ bookkeeping lemma;
7. strict failure of absorbing a fixed positive mass slope;
8. strict failure of linearly absorbing a two-place quadratic interaction;
9. injectivity, fixed-support finiteness, and failure of a linear height bound
   in the count-only toy family.

It assumes no S-unit theorem, Baker bound, Subspace Theorem, prime-distribution
theorem, or abc estimate. The actual arithmetic height input required by
Section 7 is not hidden in a structure field.
