# Product-tripod rigidity and the unavoidable mixing divisor

Author: ChatGPT. Date: 2026-09-07.

**Status.** This is an independent geometric branch. The ordinary proofs below
are complete and have passed a separate adversarial-agent review; verification
details and the limits of that review are recorded separately.
The Lean file formalizes a finite algebraic core, not the geometric
classification theorem. No result here proves or disproves abc.

## 1. Exact target and relation to the existing frontier

Put

\[
U_k=\mathbb P^1_k\setminus\{0,1,\infty\},\qquad
R_n=k[x_1,\ldots,x_n,x_1^{-1},(1-x_1)^{-1},\ldots,
x_n^{-1},(1-x_n)^{-1}].
\]

Here `n >= 1` and `k` is a field of characteristic zero. Existing repository
arguments rule out degree-greater-than-one support-preserving self-maps of
`U_k`. The higher-dimensional escape to a fixed product `U_k^n` requires its
own audit: one-dimensional Riemann--Hurwitz alone does not classify maps from
that product.

**Theorem PR.** Every nonconstant regular `k`-morphism
`f : U_k^n -> U_k` is one of

\[
x_i,\quad 1-x_i,\quad x_i^{-1},\quad (1-x_i)^{-1},\quad
\frac{x_i}{x_i-1},\quad\frac{x_i-1}{x_i}
\tag{PR}
\]

for some coordinate `i`. Constant morphisms have values in `k - {0,1}`.

Consequently, every dominant regular endomorphism of `U_k^n` is an
automorphism given by a permutation of the coordinates followed by these six
transformations coordinate by coordinate.

This retires only the exact proposed child gate: **a globally regular,
genuinely mixing or degree-amplifying self-map of a fixed finite product of
tripods, with no new boundary divisor**. It does not retire higher-dimensional
varieties, correspondences, maps on proper subvarieties, moving families, or
maps with new divisors removed from their domain.

## 2. The finite rectangle lemma

Let `A,B,C,D` belong to an integral domain. Assume

\[
AD=BC,\qquad (1-A)(1-D)=(1-B)(1-C).
\tag{R1}
\]

Then

\[
A+D=B+C,\qquad (A-B)(A-C)=0.
\tag{R2}
\]

Hence either

\[
A=B\ \text{ and }\ C=D,
\qquad\text{or}\qquad
A=C\ \text{ and }\ B=D.
\tag{R3}
\]

**Proof.** Expand the second equality and cancel `AD=BC`, giving the first
equality in (R2). Substitute `D=B+C-A` into `AD=BC`. Rearrangement gives the
second equality in (R2). The integral-domain zero-product law then gives
`A=B` or `A=C`; the additive identity supplies the other equality in (R3).

The first equality in (R1) says that the matrix with rows `(A,B)` and `(C,D)`
has determinant zero. The second says the same for its entrywise complement.
The conclusion says that either both rows are constant or both columns are
constant. This is stronger than a derivative calculation at one point and
does not require characteristic zero.

## 3. Proof of product-tripod rigidity

### Step 1: units in the coordinate ring

The polynomial ring `k[x_1,...,x_n]` is a unique factorization domain. The
elements inverted to form `R_n` are precisely products of the distinct
irreducibles `x_i` and `1-x_i`. A unit and its inverse have product one;
unique factorization therefore shows that every unit of `R_n` has the form

\[
c\prod_{i=1}^n x_i^{a_i}(1-x_i)^{b_i},
\qquad c\in k^*,\quad a_i,b_i\in\mathbb Z.
\tag{U}
\]

No irreducible factor other than the inverted ones can appear, since its
valuation in a unit and in its inverse must both be nonnegative.

A morphism to `U_k=Spec k[t,t^{-1},(1-t)^{-1}]` is exactly an element
`f in R_n` such that `f` and `1-f` are units. Thus

\[
f=c\prod_i u_i(x_i),\qquad 1-f=d\prod_i v_i(x_i),
\tag{S}
\]

where each `u_i` and `v_i` is a product of integral powers of `x_i,1-x_i`.
Every displayed factor is nonzero at every point of `U`.

### Step 2: a nonconstant factor excludes every other nonconstant factor

Extend scalars to an algebraic closure `K` of `k`. The extension is harmless:
an equality of rational functions over `k` can be checked over `K`.
Suppose `u_i` is nonconstant. Since `K` is infinite, there are points
`s_i,t_i in U(K)` with `u_i(s_i) != u_i(t_i)`.

Fix any `j != i`, choose arbitrary `s_j,t_j in U(K)`, and fix arbitrary
values for every other coordinate. Evaluate `f` at the resulting rectangle,
with rows indexed by `s_i,t_i` and columns by `s_j,t_j`, obtaining `A,B,C,D`.
The separated products (S) give both identities (R1). Moreover `A != C`,
since all fixed factors are nonzero and `u_i(s_i) != u_i(t_i)`.
The rectangle lemma forces `A=B`. Cancelling the nonzero factors gives
`u_j(s_j)=u_j(t_j)`.

Because `s_j,t_j` were arbitrary and `K` is infinite, `u_j` is constant as a
rational function. This holds for every `j != i`. If no `u_i` was
nonconstant, `f` itself was constant. Otherwise `f` belongs to `k(x_i)`.

### Step 3: the one-coordinate function has degree one

Write the nonconstant `f=P/Q` in lowest terms in `k[T]`. Then `P,Q,Q-P`
are nonzero and pairwise coprime. To justify the one-variable unit condition
explicitly, send every other coordinate to `2`. In characteristic zero this
is a homomorphism from `R_n` to the one-variable localization, fixes `f`, and
sends units to units. Thus `f` and `1-f` are units of
`k[T,T^{-1},(1-T)^{-1}]`, every zero of the product `P Q (Q-P)` lies in
`{0,1}` over `K`. Its reduced polynomial radical therefore has degree at
most two.

The characteristic-zero polynomial abc theorem (Mason--Stothers), applied
to `P+(Q-P)=Q`, gives

\[
\max(\deg P,\deg Q,\deg(Q-P))<2.
\]

The derivative-zero alternative cannot occur: in characteristic zero all
three derivatives zero would make all three polynomials constant. Thus `f`
has degree one. Its extension to `P^1` is a Mobius automorphism whose
inverse image of `{0,1,infinity}` is contained in that same three-element
set. A degree-one bijection therefore permutes those three points. The six
possible permutations give exactly (PR). This proves Theorem PR.

### Step 4: endomorphisms

Each coordinate of a regular map `U_k^n -> U_k^n` is constant or reads one
input coordinate through a transformation in (PR). If the map is dominant,
the output rational functions are algebraically independent. Therefore no
output coordinate is constant and no two read the same input coordinate.
With `n` inputs and `n` outputs the coordinate choices form a permutation.
The inverse permutation and inverse Mobius transformations are again regular
on `U_k^n`, giving the stated automorphism classification.

### Exact characteristic boundary

The rectangle argument and its one-active-coordinate conclusion use no
characteristic-zero assumption: one may still pass to the infinite algebraic
closure of a finite field. The degree-one conclusion does require that
assumption. In characteristic `p > 0`, the map `f=x_i^p` is a complete-premise
counterexample to degree-one rigidity: `1-f=(1-x_i)^p`, so both are units and
the map has degree `p` in that coordinate. This retires only a
characteristic-free strengthening of PR, not PR itself.

## 4. Codimension-two base loci do not evade the result

**Corollary PR2.** Let `Z` be a closed subset of `U_k^n` of codimension at
least two. Every regular map `U_k^n - Z -> U_k` extends uniquely to a
regular map `U_k^n -> U_k`, so satisfies Theorem PR.

**Proof.** Such a map gives a rational function `f` for which `f`, `1/f`,
`1-f` and `1/(1-f)` are regular off `Z`. Every irreducible divisor of the
factorial affine variety `Spec R_n` has its generic point outside `Z`.
Consequently the valuation of each of these four rational functions is
nonnegative at each irreducible of `R_n`. Unique factorization implies
that all four belong to `R_n`: in a reduced fraction its denominator can
have no nonunit irreducible factor. Therefore `f` and `1-f` are units.
The coordinate-ring morphism gives the extension, and equality in the
function field gives uniqueness.

**Exact surviving requirement.** Any genuinely mixed rational function
which defines a map to `U` somewhere on `U^n` must have a zero, pole, or
one-fibre along an actual divisor inside `U^n`. Deleting only a
codimension-two locus cannot remove this obstruction. This is a geometric
necessity, not an arithmetic lower bound for its specialized radical.

## 5. A minimal mixed map and its complete arithmetic cost

Take `f(x,y)=xy`. It maps

\[
U^2\setminus\{xy=1\}\longrightarrow U.
\]

It is genuinely mixed; the new divisor is the one-fibre `xy=1`. Specialize
at `(x,y)=(a/c,b/c)` with positive coprime integers `a+b=c`. Put

\[
N=c^2-ab=a^2+ab+b^2.
\]

The output is the primitive abc triple

\[
(ab,N,c^2).
\tag{M}
\]

Indeed `ab+N=c^2`, and a prime dividing `N` and one of `a,b,c` would, by
the formula modulo that entry, divide another entry, contradicting the
original coprimality. Thus

\[
\gcd(N,abc)=1,\qquad
\operatorname{rad}(abNc^2)=\operatorname{rad}(abc)\operatorname{rad}(N).
\tag{C}
\]

The output height is exactly `2 log c`, while

\[
\frac34 c^2\le N<c^2,
\tag{H}
\]

by `4ab <= (a+b)^2` and `ab>0`. Thus the new factor has full quadratic
size, and none of its radical can be absorbed by overlap with the old
support. Its radical can nevertheless be much smaller than its size;
(H) supplies no lower bound for that radical.

Writing `h=log c`, `r=log rad(abc)` and `s=log rad(N)`, the exact output
quality and fixed-epsilon excess are

\[
q'=\frac{2h}{r+s},\qquad
E'_\varepsilon=2h-(1+\varepsilon)(r+s).
\tag{Q}
\]

Equivalently,

\[
E'_\varepsilon
=2E_\varepsilon+(1+\varepsilon)(r-s).
\tag{E}
\]

This exposes a concrete surviving arithmetic gate: a mixed amplification
argument must control `s` relative to `r` on the actual selected points,
or use a different arithmetic correlation to pay for the new divisor.
Neither the classification theorem nor the elementary upper bound
`s <= log N < 2h` supplies this control. We do not postulate it as a theorem
or label it as progress toward the final global inequality.

## 6. Dependency chain and retained research questions

The rigorous chain is

```
localization UFD units
  -> f and 1-f multiplicatively separate
  -> rank-one/complement-rank-one rectangle identities
  -> one active coordinate
  -> characteristic-zero Mason
  -> coordinate/S3 classification
  -> a genuinely mixed map needs a new divisor.
```

A possible forward chain to abc would require additional inputs:

```
mixed map / correspondence with explicit new divisor
  + an independent uniform arithmetic control on that divisor
  + a verified descent or exceptional-set amplification theorem
  -> abc.
```

Only the first item and its exact ledger for (M) are supplied here. Both
additional global inputs remain open. There is no target-equivalent axiom
hidden in a definition or structure.

The surviving positive lines include non-product moduli spaces; finite
correspondences which are not everywhere-defined one-valued maps; adaptive
maps with explicitly charged new divisors; and norm constructions where
arithmetic relations among new factors can be proved. None is retired by PR.

## 7. Formal and source scope

`Lean/ProductTripodRectangle.lean` has verified ten integer theorems: the
rectangle identities, their row-or-column dichotomy, a global matrix
one-coordinate-dependence theorem, and elementary mixed-map identities and
size bounds. Its statements do not mention schemes, localized polynomial
rings, unit classification, Mason, rational-map degree, or the abc
conjecture. The full geometric theorem remains an ordinary proof.

The one-variable polynomial input is already recorded in
`Lean/MASON_SPECIALIZATION_BARRIER_ROUTE.md` and its Lean module.
The previous one-dimensional comparison is
`research/BELYI_AMPLIFICATION_RIEMANN_HURWITZ_BARRIER.md`.
No new external conjecture or unreviewed research paper is used.
