# Global signed-tail direction: residual divisor collisions and private depth

Date: 2026-09-07. Status: new ordinary proofs, submitted for independent review.
This note does not assert a global signed-tail estimate or a proof of ABC.
It uses the exact Eisenstein boundary gcd identity and finite divisor algebra,
not a logarithmic-form estimate or a supposition that large primes are simple.

## 1. The remaining quantity after the lambda refinement

For an actual primitive profile `z = unit * gamma^e * v * w^g`, put
`T=|P(z)|`, `P(x+y*zeta)=xy(x+y)`, and `h=max(1,log N(v))`.
The reviewed lambda refinement gives balance and vanishing normalized full
small-prime mass when `lambda=h/g` tends to zero. One available cutoff is
`Y=lambda^(-1/6)`. The remaining signed product is

\[
 W_Y(T)=\prod_{\substack{p\mid T\\p>Y}}p^{v_p(T)-3}.
\]

The positive part of its logarithm remains uncontrolled in general.
We now vary small residuals while holding the common factor fixed. This
exposes an exact geometric constraint on sharing prime-power depth across
different residuals. It does not control a depth occurring in only one
residual, and the distinction is retained throughout.

## 2. Exact cross-residual boundary overlap

Let `H` be an Eisenstein integer, and let `v_1,v_2` be such that
`z_i=v_i H` are primitive. Put `A_i=|P(z_i)|`, and assume `A_i>0`.
Primitivity of `z_i` implies primitivity of `v_i`. Write `V_i=N(v_i)`.

**Theorem GC1.** The following equality holds as an equality of integers,
including all prime-power multiplicities and the primes two and three:

\[
 \boxed{\gcd(A_1,A_2)
 =\gcd\bigl(A_1,|P(v_2\bar v_1)|\bigr).}
 \tag{GC1}
\]

**Proof.** Use the previously established exact boundary overlap theorem:
for a primitive Eisenstein integer `x` and any Eisenstein multiplier `y`,

\[
 \gcd(|P(x)|,|P(yx)|)=\gcd(|P(x)|,|P(y)|).
 \tag{1}
\]

Apply it with `x=z_1` and `y=v_2 bar(v_1)`. Then

\[
 yx=v_2\bar v_1 v_1 H=V_1 z_2,
 \qquad |P(yx)|=V_1^3 A_2.
\]

Since `N(z_1)=V_1 N(H)`, the primitive norm-boundary coprimality theorem
implies `gcd(A_1,V_1)=1`. Cancel `V_1^3` in the left gcd of (1).
This proves (GC1). No prime must be discarded, and there is no coprimality
assumption between the two residuals.

Equation (1) already has a Lean proof in the repository's Eisenstein descent
checkpoint. The application (GC1) is ordinary mathematics in this note until
its actual statement is separately formalized; importing the existing identity
alone would not constitute that additional formalization.

**Lemma GC2.** If `v_1,v_2` are primitive and are not associates under the six
Eisenstein units, then `P(v_2 bar(v_1))` is nonzero. Consequently

\[
 \gcd(A_1,A_2)\le(V_1V_2)^{3/2}.
 \tag{GC2}
\]

**Proof.** A nonzero Eisenstein integer has zero boundary precisely when it
is an integer multiple of a unit, as is seen by setting each of its three
boundary linear factors equal to zero. Thus a zero cross-boundary would give
`v_2 bar(v_1)=m u`, and hence `v_2=(m/V_1)u v_1`.
A rational scalar relating two primitive integer coordinate pairs is either
one or minus one: in lowest terms its denominator divides both coordinates,
and after it is removed its numerator does likewise. Multiplication by a unit
preserves primitivity. Therefore zero cross-boundary would make the residuals
associates, contrary to the hypothesis.

For any Eisenstein integer `D`, the exact cubic identity and the triangle
inequality give

\[
 3\sqrt3\,|P(D)|=|D^3-\bar D^3|\le2N(D)^{3/2}.
\]

In particular `|P(D)| <= N(D)^(3/2)`. Apply this to
`D=v_2 bar(v_1)`, whose norm is `V_1V_2`, and then use (GC1).

Geometrically, the cross-boundary is the product of three determinant-type
linear incidence conditions. The proof avoids choosing, prime by prime,
which of the three boundary factors is divisible. Their product retains all
three possibilities and all valuations at once.

## 3. A total budget for valuation depth repeated across residuals

Let `v_1,...,v_K` be pairwise nonassociate primitive residuals, with all
`z_i=v_i H` primitive and nonzero boundary. Set `A_i=|P(z_i)|`,
`V_i=N(v_i)`, and `L=lcm(A_1,...,A_K)`, where `K>=1`.

Define the repeated-multiplicity integer

\[
 D=\frac{\prod_{i=1}^K A_i}{L}.
\]

**Theorem GC3.** One has

\[
 D\ \mid\ \prod_{i<j}\gcd(A_i,A_j)
 \quad\text{and}\quad
 \boxed{\log D\le\tfrac32(K-1)\sum_i\log V_i.}
 \tag{GC3}
\]

In particular, when every `V_i <= B`,

\[
 \log D\le\tfrac32K(K-1)\log B.
 \tag{2}
\]

**Proof.** Fix a prime and write `e_i=v_p(A_i)`, rearranged increasingly.
Its valuation in `D` is `sum_{i<K} e_i`. Its valuation in the product of
pairwise gcds is `sum_{i<K}(K-i)e_i`, which is at least that amount.
This proves the divisibility. Apply (GC2) to each pair and sum logarithms.
Each `log V_i` occurs in exactly `K-1` pairs, giving (GC3).

This bound holds for every `H`, independently of its size and prime support.
It therefore controls repeated depth even beyond the new lambda cutoff,
where a uniform single-profile first-depth bound is still missing.

## 4. Exact signed accounting: where the unproved depth resides

For each prime dividing `L`, assign it to one index with maximal valuation,
breaking ties by the smallest index. Call that index its owner. This is a
definition by actual integer valuations, not a probabilistic model.
For a real cutoff `Y>=1`, write

\[
 D_Y=\prod_{p>Y}p^{\sum_i v_p(A_i)-v_p(L)},
 \qquad
 E_Y=\prod_{\substack{p\mid L\\p>Y}}p^{\#\{i:p\mid A_i\}-1}.
\]

**Theorem GC4.** There is the exact signed identity

\[
 \boxed{\prod_iW_Y(A_i)=W_Y(L)\,\frac{D_Y}{E_Y^3}.}
 \tag{GC4}
\]

Moreover `D_Y` divides `D`, so its logarithm satisfies (GC3).

**Proof.** At a prime occurring in `s` of the `A_i`, the exponent on the
left is `sum_i e_i-3s`. On the right it is
`(max_i e_i-3)+(sum_i e_i-max_i e_i)-3(s-1)`, the same number.
The remaining claims follow directly from the definitions.

The negative credit `E_Y^(-3)` is kept explicitly. Dropping it gives a
valid upper bound but does not prove that either side is small.
In particular, small aggregate signed cost does not imply that most
individual signed costs are small; negative contributions could hide positive
ones. No Markov inequality is applied to a signed aggregate here.

For an individual index put

\[
 U_i(Y)=\prod_{\substack{p>Y\\i\text{ owns }p}}p^{v_p(A_i)-3},
 \qquad
 R_i(Y)=\sum_{\substack{p>Y,\ p\mid A_i\\i\text{ does not own }p}}
            v_p(A_i)\log p.
\]

The exact signed contribution from nonowned primes is at most `R_i(Y)`, so

\[
 \log W_Y(A_i)\le\log U_i(Y)+R_i(Y),
 \qquad \sum_iR_i(Y)=\log D_Y.
 \tag{3}
\]

Suppose now `H=w^g`, `N(w)=Q>=7`, and `V_i<=B`. Let `t_i=log c_i` for
the positive unit rotation of `z_i`. Then `t_i>=g log Q/2`, so

\[
 \frac1K\sum_i\frac{R_i(Y)}{t_i}
 \le\frac{3(K-1)\log B}{g\log Q}.
 \tag{4}
\]

Unlike a signed mean, this is a nonnegative quantity. Thus, if
`K log B=o(g log Q)`, for most residuals the full nonowned contribution at
all primes beyond every cutoff is simultaneously `o(t_i)`. Precisely, put
`delta=3(K-1)log B/(g log Q)` and apply Markov to `R_i(1)/t_i`.
When `delta>0`, outside at most a `sqrt(delta)` proportion of the indices,
all `Y>=1` satisfy `R_i(Y)/t_i<=sqrt(delta)`, since `R_i(Y)<=R_i(1)`.
If `delta=0`, every `R_i(Y)` is zero. More generally the exception proportion
is at most `delta/eta` for any positive threshold `eta`.
What remains for those residuals is the actual owner packet `U_i(Y)`.

This is a precise reduction of repeated first-depth mass, not a bound on
the remaining owner packets. A prime can have arbitrarily high depth at its
owner while having only depth one at another residual. The pairwise gcd
budget correctly charges only the smaller depth in that situation.

## 5. A deterministic packing consequence

**Corollary GC5.** In the setting `V_i<=B`, if an integer `q>B^3` divides
two of the `A_i`, those two residuals must be associates. Hence a family of
pairwise nonassociate residuals has at most one member divisible by a
specified `q>B^3`. In particular, a specified prime power `p^e>B^3` can
occur at depth at least `e` in at most one member.

**Proof.** Otherwise (GC2) would give
`q <= gcd(A_i,A_j) <= (V_iV_j)^(3/2) <= B^3`, a contradiction.

This statement permits arbitrarily many different large prime powers,
each with a different residual or attached to the same residual. It therefore
does not replace the remaining private-depth problem by a prime-count
assumption.

## 6. Annotated prime powers give an actual lattice of known index

The product of three boundary arms in (GC1) permits prime-by-prime changes
of arm. If the arms are retained as data, there is a sharper two-dimensional
packing statement.

Let `q=product p^(e_p)` be a positive integer coprime to `N(H)`.
For each prime dividing `q`, choose one of the three linear forms
`a`, `b`, `a+b` on `a+b*zeta`. Define the actual congruence lattice

\[
 \mathcal L(q,\sigma;H)
 =\{v\in\mathbb Z^2:
       \ell_{\sigma(p)}(vH)\equiv0\pmod{p^{e_p}}
       \text{ for every }p\mid q\}.
\]

**Theorem GC6.** This lattice has index `q` in `Z^2`. If `v,v'` in this
lattice are linearly independent over the rationals, then

\[
 N(v)N(v')\ge\tfrac34q^2.
 \tag{GC6}
\]

Consequently, when `q>2B/sqrt(3)`, all primitive lattice points of norm at
most `B` belong to at most one rational direction and hence to at most one
opposite pair.

**Proof.** Multiplication by `H=h_1+h_2*zeta` has integer matrix

\[
 \begin{pmatrix}h_1&-h_2\\h_2&h_1+h_2\end{pmatrix},
\]

whose determinant is `N(H)`. It is invertible modulo each prime power in
`q`. Each of the three chosen arm rows is unimodular modulo that prime,
so the map to `Z/p^(e_p)Z` defined by that row is onto.
The Chinese remainder theorem on the two integer coordinates makes the
combined map onto the product of these targets. Its kernel is exactly
`L(q,sigma;H)`, and its target has order `q`; this proves the index.

For two lattice vectors, the same row vanishes on both vectors modulo each
prime power. Invertibility of multiplication by `H` shows that their
determinant is zero modulo that prime power. Thus `q` divides
`det(v,v')`. Write `v=(a,b)` and `v'=(a',b')`. The exact positive-definite
identity

\[
 4N(v)N(v')-(2aa'+ab'+ba'+2bb')^2
 =3(ab'-ba')^2
\]

gives `N(v)N(v') >= 3 det(v,v')^2/4 >= 3q^2/4` when the determinant
is nonzero. The norm-ball consequence follows. Two primitive integer
vectors on the same rational line differ only by sign.

This theorem bounds the product of two independent solution heights. It
does not give a lower bound on the first nonzero solution height. A lattice
can have one very short primitive vector and a very long independent vector;
its index alone does not prohibit that configuration. The actual owner
problem is therefore concentrated into this first short direction, not
resolved by the determinant calculation.

**Corollary GC7 (a fixed-packet capacity bound).** If `gcd(q,N(H))=1` and
`q>2B/sqrt(3)`, the number of primitive integer pairs `v` with `N(v)<=B`
and `q | P(vH)` is at most `2*3^omega(q)`, where `omega(q)` counts distinct
prime divisors. Opposite pairs count separately here.

**Proof.** At every prime dividing `q`, primitivity of `v` and invertibility
of multiplication by `H` imply that the coordinates of `vH` are not both
zero modulo that prime. Exactly one of its three boundary arms is divisible
by that prime, and the full prime-power divisor of the boundary lies in that
arm. Each solution therefore selects one of at most `3^omega(q)` annotated
lattices. GC6 permits at most one opposite primitive pair per such lattice.

This bounds the capacity of one specified prime-power packet, including
packets involving large primes and large valuations. It is uniform in the
height of `H`. Summing it over packets chosen after seeing the residual is
not justified without a separate bound on that collection of packets.

## 7. An actual boundary for the collision shortcut

There is an elementary family showing why the smaller repeated depth cannot
be substituted for the maximal depth. Take

\[
 w=2+\zeta,\quad v_1=1,\quad v_2=1+5\zeta,
 \qquad g_k=2\cdot5^k\quad(k\ge1).
\]

The two products are primitive, since `N(w)=7` and `N(v_2)=31` have
disjoint rational support and each factor is primitive. Their residuals
are nonassociate, and both displayed lambda parameters tend to zero.
The actual homogeneous rank at five is two with first depth one:
`w^2=3+5*zeta`, whose boundary is `120`. The elementary rank/LTE law
therefore gives

\[
 v_5(|P(w^{g_k})|)=k+1.
\]

On the other hand `P(v_2)=30`. Equation (GC1) forces the minimum of the
two boundary valuations at five to be one, so

\[
 v_5(|P(v_2w^{g_k})|)=1.
\]

Thus the owner depth is unbounded while the repeated depth at that prime is
exactly one. This disproves the specific attempted inference that the
cross-residual collision budget itself bounds the maximal prime depth.
It does not disprove the global signed-tail gate: the fixed prime five lies
below the moving lambda cutoff for all sufficiently large `k`.

## 8. A sharper prime-power bound and a pointwise repeated-depth theorem

**Theorem GC8.** For two nonassociate residuals in GC1 and a common prime,

\[
 p^{\min(v_p(A_1),v_p(A_2))}
 \le\frac2{\sqrt3}\sqrt{V_1V_2}.
 \tag{GC8}
\]

**Proof.** A common boundary prime divides neither `V_1` nor `V_2` by
primitive norm-boundary coprimality. The cross element `D=v_2 bar(v_1)`
therefore has unit norm modulo that prime. Of its three boundary linear
factors, at most one is divisible by the prime. By GC1 the entire common
prime power is carried by that one nonzero factor. Each of the three factors
of `D=(a,b)` has absolute value at most `2 sqrt(N(D))/sqrt(3)`:
the identities `4N=3a^2+(a+2b)^2`, its symmetric version, and
`4N=3(a+b)^2+(a-b)^2` prove the three inequalities. Apply `N(D)=V_1V_2`.

This improves GC5's threshold from `B^3` to `2B/sqrt(3)` for a specified
prime power when all residual norms are at most `B`. For a packet with
several primes, the stronger associate-class version of GC7 is
`3^(omega(q)-1)`: the raw solution set is freely closed under the six units,
which preserve norm and boundary divisibility, so its bound can be divided
by six. Here `q>1`, as follows from `B>=1` and the strict packet threshold.

**Theorem GC9.** In a pairwise nonassociate residual family with `V_i<=B`,
every individual nonowned full-multiplicity contribution in (3),
simultaneously for all cutoffs, satisfies

\[
 R_i(Y)\le\log\operatorname{lcm}(1,\ldots,\lfloor2B/\sqrt3\rfloor)
 <4B\qquad(Y\ge1).
 \tag{GC9}
\]

The bound is independent of the number of residuals and of the common factor.
Thus, for `H=w^g`, all residuals satisfy

\[
 R_i(Y)/t_i\le\frac{8B}{g\log Q}.
\]

In particular `B=o(g log Q)` gives a pointwise sublinear repeated-depth
contribution at every residual and every cutoff, with no exceptional set.

**Proof.** If a prime is not owned by `i`, its owner has at least its depth.
GC8 implies `p^(v_p(A_i)) <= X=2B/sqrt(3)`. Thus the product of all nonowned
prime powers at `i` divides `lcm(1,...,floor X)`. Its logarithm is at most
`psi(X)=sum_{p^e<=X} log p`.

For integer `m>=1`, every prime power in `(m,2m]` contributes to the
corresponding prime valuation of `binom(2m,m)`. Each contribution at any
prime-power level is nonnegative, so
`psi(2m)-psi(m)<=log binom(2m,m)<=2m log 2`.
Summing over dyadic intervals gives `psi(X)<4X log 2<=3X` for `X>1`, using
`log 2<=3/4`; the latter follows, for example, from the trapezoidal upper
bound on the integral of the convex function `1/x` from one to two.
Consequently `psi(X)<=2 sqrt(3)B<4B`. The norm-height lower bound used in
(4) proves the normalized conclusion.

GC9 strengthens the average theorem in one regime; the earlier bound can
still be smaller for other parameter choices. Neither estimates an owner's
largest depth. For primes greater than `2B/sqrt(3)`, all supported depth is
already private to exactly one associate class.

## 9. Dependency chain and the next open subgoal

The proved chain is:

1. Primitive norm-boundary coprimality and the existing exact boundary gcd.
2. Exact cancellation of the common large factor in cross-residual overlap.
3. A small-residual bound on the full common prime-power mass.
4. An explicit total budget for depth repeated across a finite residual family.
5. Exact signed compensation and a reduction, on most small residuals, to
   each prime's actual maximal-depth owner packet.
6. A determinant bound for two independent short residuals satisfying the
   same actual annotated prime-power congruences.

The next precise open subgoal is to bound the positive part of `log U_i(Y)`
on a useful class, uniformly in `H=w^g`, while retaining the exact residual
height. The collision theorem suggests studying a determinant or lattice
certificate for a collection of distinct owner prime powers, rather than
assuming they have depth one. A satisfactory certificate must use a product
of actual congruence moduli and bound the height of its primitive solution;
single-modulus uniqueness alone supplies no such height lower bound.

No route is excluded merely because this certificate is not yet available.
The homogeneous primitive-divisor / rankwise-packet direction remains open
in parallel, and the collision argument applies to genuinely shifted residuals
that the homogeneous lifting-divides-exponent law does not cover.

## 10. Review status

The `adversarial_audit` agent independently reviewed GC1--GC5 in full and
approved the exact cancellation, nonassociate criterion, repeated-depth
divisibility, signed compensation, and individual nonnegative Markov use.
It proposed the simultaneous-all-cutoffs strengthening and the actual
owner-depth counterfamily, both included above. It also independently approved
GC6's exact lattice index, determinant divisibility, Gram identity and
second-minimum scope. GC7 is the direct finite union over its three arm labels.
It independently approved GC7 and supplied GC8--GC9, whose cancellation,
linear-factor bound, lcm budget, and dyadic prime-power estimate I checked.
No new result in this note is claimed Lean-verified.
