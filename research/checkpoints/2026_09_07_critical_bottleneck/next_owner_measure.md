# Private depth as a joint finite residue object

Date: 2026-09-07. Status: new ordinary proofs, with independent review of
the local counting and entropy calculations. This is a probability and
geometry direction separate from the logarithmic-form estimates.

The measure here is explicitly a uniform measure on finite residue rings.
It is not asserted to describe the small-height integer residuals in the
ABC profiles. We prove a large-prime tail law for this measure, an actual
first-minimum distribution bound, and a precise obstruction to one overly
strong way of transferring that law to the integer problem.

## 1. One common factor acts on all local states at once

Let `S` be a finite set of rational primes greater than a real `Y>=5`.
Choose integers `E_p>=1`, set `m=product_{p in S} p^(E_p)`, and let

\[
 \Omega=\prod_{p\in S}(\mathcal O/p^{E_p}\mathcal O)^\times,
 \qquad \mathcal O=\mathbb Z[\zeta],\quad\zeta^2-\zeta+1=0.
\]

Put the uniform probability measure `mu` on this finite product.
Fix an Eisenstein integer `H` with `gcd(N(H),m)=1`. For `v in Omega`,
define `nu_p(vH)` to be the capped boundary valuation: the largest
`e in {0,...,E_p}` for which `P(vH)=0 mod p^e`, where
`P(a+b*zeta)=ab(a+b)`.

This definition depends only on the finite residue class. It is not the
uncapped valuation of an arbitrary integer lift. The distinction is necessary
when the boundary vanishes modulo the highest retained prime power.

Multiplication by the same `H` is a permutation of the entire product
`Omega`. In particular, if `w` is a unit at every prime in `S`, the sequence
of actions `v -> v w^g` preserves this measure for every exponent `g`.
The local factors remain independent because this action acts separately on
each coordinate of the product.

## 2. The exact joint law and the whole large-prime positive tail

Write `chi_p=1` for `p=1 mod 3` and `chi_p=-1` for `p=2 mod 3`.

**Theorem OM1.** For every `1<=e<=E_p`,

\[
 \boxed{\Pr_\mu[\nu_p(vH)\ge e]
 =\frac3{p^{e-1}(p-\chi_p)}.}
 \tag{OM1}
\]

These depth variables are independent across distinct primes, and their
joint law is independent of `H`.

**Proof.** The unit group modulo `p^e` has order

\[
 p^{2e-2}(p-1)(p-\chi_p).
\]

Indeed modulo `p` the algebra is the product of two copies of `F_p` in
the split case, and is `F_(p^2)` in the inert case. Lifting each of two
coordinates through `e-1` further digits multiplies its unit count by
`p^(2e-2)`.

Among these units, `a=0 mod p^e` gives exactly `phi(p^e)` solutions,
because `b` must be a rational unit. The same is true for `b=0`, and for
`a+b=0`, since the norm on that last line is `a^2`. The three sets are
disjoint on units. Moreover if their product is zero modulo `p^e`, at most
one factor is divisible by `p`, so that same factor contains the entire
prime-power depth. Thus there are exactly `3 phi(p^e)` solutions.
Their ratio to the unit count is (OM1). Projection from depth `E_p` to
depth `e` is uniform, and multiplication by `H` is a permutation. Product
measure proves independence.

Define the nonnegative, complete retained large-prime excess

\[
 F_Y(v;H)=\sum_{p\in S}(\nu_p(vH)-3)_+\log p.
\]

**Theorem OM2.** Uniformly in the number of primes, their precision, and
the common factor,

\[
 \boxed{\mathbb E_\mu F_Y
 \le\sum_{p\in S}\frac{3\log p}{p^2(p-1)(p-\chi_p)}
 \le\frac{10\log Y}{Y^3}.}
 \tag{OM2}
\]

**Proof.** For a nonnegative integer `n`, `(n-3)_+` is the sum of the
indicators `1_(n>=e)` for `e>=4`. Apply (OM1), sum the finite geometric
series, and bound it by its infinite version. This gives the first inequality.
For `p>=5`, `(p-1)(p-chi_p)>=16p^2/25`, so the summand is at most
`5 log p/p^4`. The decreasing function `log x/x^4` has integral
`(log a)/(3a^3)+1/(9a^3)` on `[a,infinity)`. Bound the integer sum above
`Y` by the integral starting at `floor Y`, use `floor Y>=4Y/5`, and enlarge
the numerical constant to ten. This proves the displayed uniform bound.

This is a theorem about the entire retained large-prime positive excess,
not merely primes below a moving window. It was obtained by exact counting;
no claim that large primes usually have valuation one was used as a premise.
It remains a theorem for the stated reference measure.

## 3. A first-minimum distribution bound for the common-factor action

The same joint object permits a rigorous probabilistic statement about the
first minimum of the annotated lattices from GC6.

Let `q=product p^(e_p)` have primes at least five, and let `H` itself be
uniform on the units of `O/qO`. Fix one arm choice `sigma(p)` at every prime.
Let `L(q,sigma;H)` be the actual lattice of integer residuals satisfying
the chosen arm congruences for `vH`.

**Theorem OM3.** For `B>=1`,

\[
 \Pr_H[\exists\text{ primitive }v:\ N(v)\le B,
                 \ v\in\mathcal L(q,\sigma;H)]
 \le\frac{25B(5/4)^{\omega(q)}}q.
 \tag{OM3a}
\]

If the arm labels are not specified, then

\[
 \Pr_H[\exists\text{ primitive }v:\ N(v)\le B,
                        \ q\mid P(vH)]
 \le\frac{25B(15/4)^{\omega(q)}}q.
 \tag{OM3b}
\]

**Proof.** There are at most `25B` integer pairs of norm at most `B`:
both coordinate absolute values are at most `2 sqrt(B)`, so the containing
square has at most `(4 sqrt(B)+1)^2<=25B` integer points.
Fix a primitive pair `v`. If a prime in `q` divides `N(v)`, there is no
solution to its arm condition: multiplication by a unit preserves that
zero norm and the nonzero coordinate vector modulo the prime, whereas every
nonzero boundary arm vector has nonzero norm. Otherwise multiplication by
`v` permutes the local units. The probability of one specified arm at `p^e`
is `1/[p^(e-1)(p-chi_p)]`, by the count in OM1 before its factor of three.
The probabilities multiply across primes. Their product is

\[
 \frac1q\prod_{p\mid q}\frac p{p-\chi_p}
 \le\frac{(5/4)^{\omega(q)}}q.
\]

Sum over the at most `25B` possible primitive residuals. Summing over the
at most `3^omega(q)` arm choices gives (OM3b).

Thus an extremely short first vector has small probability in this exact
common-factor reference ensemble. A specified arithmetic orbit `H=w^g`
is not asserted to be uniform in that ensemble. The measure-preserving
action gives a correct joint covariance law, but it does not by itself
bound the visits of a special deterministic orbit to the rare first-minimum
event. That orbit-height transfer remains an explicit research target.

## 4. A sharp finite entropy transfer inequality

The uniform large-prime estimate has a useful exponential version.

**Theorem OM4.** For the finite state space of OM1,

\[
 \log\mathbb E_\mu\exp(F_Y/2)\le4Y^{-5/2}.
 \tag{OM4a}
\]

For any probability measure `nu` on the same finite state space, let
`D(nu||mu)=sum nu(x) log(nu(x)/mu(x))` be its relative entropy, with
zero-probability summands set to zero. Then

\[
 \boxed{\mathbb E_\nu F_Y
 \le2D(\nu\Vert\mu)+8Y^{-5/2}.}
 \tag{OM4b}
\]

**Proof.** For `K_p=(nu_p-3)_+` and `0<theta<1`, summation by tails gives

\[
 \mathbb E_\mu p^{\theta K_p}
 \le1+\frac{3(p^\theta-1)}
 {p^3(p-\chi_p)(1-p^{\theta-1})}.
\]

For `theta=1/2`, the ratio `(sqrt(p)-1)/(1-1/sqrt(p))` is exactly
`sqrt(p)`, so the increment after one is
`3/[p^(5/2)(p-chi_p)]`. Independence and `log(1+x)<=x` give

\[
 \log\mathbb E_\mu e^{F_Y/2}
 \le\sum_{p>Y}\frac3{p^{5/2}(p-\chi_p)}
 \le\frac{15}4\sum_{n>Y}n^{-7/2}
 \le4Y^{-5/2}.
\]

The last inequality follows by integrating from `floor Y>=4Y/5`:
the resulting constant is `(3/2)(5/4)^(5/2)<4`.

To prove the transfer, tilt `mu` by `exp(F_Y/2)` and normalize by
`Z=E_mu exp(F_Y/2)`, obtaining a positive probability measure `mu_*`.
Nonnegativity of `D(nu||mu_*)`, which follows from `log x<=x-1`, gives
`(1/2)E_nu F_Y<=D(nu||mu)+log Z`. Substitute (OM4a).

This is an exact sufficient bridge for any specified distribution `nu`.
It makes the missing approximation cost explicit, instead of silently
replacing integer residuals by uniformly random residues.

## 5. A proved obstruction to the full-state small-entropy shortcut

The bridge in OM4 cannot be completed just by declaring a small-height
integer ensemble to have negligible entropy loss in the entire local state
space. There is a cardinality obstruction.

**Theorem OM5.** If `nu` is supported on at most `K` points of `Omega`,

\[
 D(\nu\Vert\mu)\ge
 \left(2-\frac2{(Y-1)\log Y}\right)\log m-\log K.
 \tag{OM5}
\]

**Proof.** Uniformity gives `D(nu||mu)=log|Omega|-H(nu)`, and the entropy
of a distribution on at most `K` points is at most `log K`. The exact unit
count yields

\[
 |\Omega|=m^2\prod_{p\in S}(1-1/p)(1-\chi_p/p).
\]

The logarithm of each factor is at least `-2/(p-1)`: in the split case
apply `-log(1-1/p)<=1/(p-1)` twice, and in the inert case the second
logarithm is positive. Since `omega(m)<=log m/log Y`, summing gives (OM5).

For example, if `log m>=delta*t`, `log K=o(t)`, and `Y` tends to infinity,
then `liminf D/t>=2delta>0`. Small residuals of norm at most `B` have at
most `25B` integer states, so `log B=o(t)` falls directly within this
obstruction whenever the full local modulus has logarithmic size comparable
to `t`. There are no unproved distribution hypotheses in this conclusion.

OM5 rules out that particular full-state negligible-entropy premise. It does
not rule out probability or entropy methods. Observable distributions,
conditioned measures that retain the archimedean height, and the covariance of
the special power orbit may preserve more structure than this uniform full
state space. Those variants remain open and require their own explicit
estimates.

## 6. A primitive-residue variant that contains every actual residual

The norm-unit reference measure is useful for the common-factor action in
OM3, but an actual primitive residual can have norm divisible by a prime in
the retained set. There is a closely related reference space that includes
every primitive integer residual without such conditioning.

For each `p` let `Omega_p^prim` consist of the pairs modulo `p^(E_p)`
whose two coordinates are not both divisible by `p`, and put uniform product
measure `mu_prim` on their product. Multiplication by a common factor `H`
with norm coprime to `m` permutes this space as well.

**Theorem OM6.** Under `mu_prim`, the local capped depths are independent and

\[
 \Pr[\nu_p(vH)\ge e]=\frac3{p^{e-1}(p+1)}
 \qquad(1\le e\le E_p).
 \tag{OM6a}
\]

Consequently OM2 and OM4 hold with the same displayed numerical upper bounds
and with relative entropy taken against `mu_prim`. In addition, a distribution
supported on at most `K` states satisfies

\[
 D(\nu\Vert\mu_{\rm prim})\ge
 \left(2-\frac1{(Y^2-1)\log Y}\right)\log m-\log K.
 \tag{OM6b}
\]

**Proof.** There are `p^(2e-2)(p^2-1)` primitive coordinate pairs modulo
`p^e`. Each boundary arm has `phi(p^e)` such points, and the three arms
are mutually exclusive on primitive points. Their ratio proves (OM6a).
The proofs of the expectation and exponential-moment bounds are unchanged
after replacing `p-chi_p` by `p+1`; this denominator is larger and therefore
retains all the earlier upper bounds.

Finally the state count is exactly

\[
 |\Omega^{\rm prim}|=m^2\prod_{p\in S}(1-p^{-2}).
\]

Using `-log(1-p^(-2))<=1/(p^2-1)` and
`omega(m)<=log m/log Y` proves (OM6b), just as in OM5.

Every primitive integer residual reduces to this space. Thus this variant
fixes an actual domain mismatch; it does not resolve the entropy obstruction.
For norm at most `B`, the same support bound `K<=25B` applies, and the
full-state entropy loss is again linear in the retained modulus height when
that modulus is exponentially large compared with the residual norm.

## 7. A lossless excess observable and its exact scope

Push `Omega^prim` forward to the vector `K=(K_p)`, where
`K_p=(nu_p-3)_+`, and call its reference law `pi`. The total retained
positive excess is exactly `F=sum K_p log p`, so it loses no information
under this quotient.

**Theorem OM7.** For any distribution on actual finite residual states, with
observable pushforward `nu_K`,

\[
 \mathbb E F\le2D(\nu_K\Vert\pi)+8Y^{-5/2},
 \qquad D(\nu_K\Vert\pi)\le D(\nu\Vert\mu_{\rm prim}).
 \tag{OM7a}
\]

The full-state cardinality obstruction need not apply to the quotient. For
the actual primitive pair `v=(1,1)` and `H=1`, the boundary is two. Thus
the observable is identically zero at all retained primes, and its Dirac
distribution satisfies

\[
 D(\delta_0\Vert\pi)\le10Y^{-3},
 \tag{OM7b}
\]

uniformly in arbitrarily large `m`. This example only compares the two
entropy losses; it is not a nontrivial small-lambda power-profile theorem.

**Proof.** The moment of `exp(F/2)` is unchanged by pushing forward, so the
same finite tilt proof gives the first inequality. The second follows from
the finite entropy chain rule: full relative entropy is observable relative
entropy plus the averaged conditional relative entropy in the fibers.
For a cap `E_p>=4`,
`pi_p(0)=1-3/[p^3(p+1)]`; for smaller caps it is one. Therefore
`-log pi(0)` is at most twice the sum of these exceptional probabilities,
by `-log(1-x)<=2x` for `0<=x<=1/2`. Integral comparison of `sum p^(-4)`
gives (OM7b). Holding even one retained prime fixed and increasing its cap
makes the full-state Dirac entropy unbounded while this observable entropy
stays bounded.

There is, however, a second precise boundary: this observable entropy is
comparable to the positive excess itself. For `k>=1`, the nonterminal atom
and terminal cap atom are respectively

\[
 \pi_p(k)=\frac{3(p-1)}{(p+1)p^{k+3}},
 \qquad
 \pi_p(k)=\frac{3p}{(p+1)p^{k+3}}.
\]

Both lie between `p^(-(k+3))` and `3 p^(-(k+3))`. Summing atom
surprisals and subtracting Shannon entropy gives, for support size at most `K`,

\[
 D(\nu_K\Vert\pi)\ge
 \mathbb E F+
 \mathbb E\sum_{p:K_p>0}(3\log p-\log3)-\log K.
 \tag{OM7c}
\]

Conversely `(k+3)<=4k`, the zero atoms contribute at most `10Y^(-3)`,
and Shannon entropy is nonnegative. Thus

\[
 \tfrac12\mathbb E F-4Y^{-5/2}
 \le D(\nu_K\Vert\pi)
 \le4\mathbb E F+10Y^{-3}.
 \tag{OM7d}
\]

Consequently, along a growing-height family, observable entropy `o(t)` is
equivalent to `E F=o(t)` for this retained positive-excess target. The
quotient removes the irrelevant full-modulus cardinality loss, but it is not
a newly proved or weaker arithmetic premise. Any useful upper bound on its
entropy must come from independent geometry or orbit structure; computing it
from the same unbounded prime depths would be circular.

Moreover `F` is the sum of the positive parts at individual primes. It
upper-bounds the positive part of the signed logarithm, but it need not be
equal to it: negative prime credits can cancel positive depth in the signed
goal. The signed compensation identity in the collision note is retained.
This probability direction pursues a stronger sufficient target and does not
discard approaches that use those negative credits.

## 8. What these results add, and what still needs proof

The exact joint local law controls the whole retained large-prime positive
tail for a well-defined reference object. The first-minimum theorem shows
how the prime labels act together under a common multiplication, rather than
bounding only the second minimum. The entropy inequality quantifies a possible
transfer, and OM5 proves why its simplest full-state version does not work
for the required small-height residual ensembles.

The unresolved owner problem is now a question about a special arithmetic
orbit and its short-vector events, or about a height-sensitive observable
measure. No assertion is made that the rare-event law excludes that orbit.
The independent analytic route through homogeneous first-depth rank packets
remains active; neither its packet bound nor this height-to-measure transfer
has been proved here.

## 9. Review and formal scope

The `adversarial_audit` agent independently checked the finite-precision
requirement, the exact local counts, their joint independence, the expectation,
the exponential-moment calculation, and the full-state entropy obstruction.
It also supplied and independently checked the primitive-residue variant,
which I verified directly against the local counts and entropy calculation.
It subsequently independently approved OM3's zero-probability norm-divisor
case, the fixed-arm probability, the coordinate-ball count and both finite
union bounds. The specified packet and the distinction from a deterministic
power orbit were retained. Finite exact enumeration separately checked eight
prime/precision pairs, including all 375000 primitive states at `p=5,E=4`,
all retained depth distributions and their preservation by multiplication by
`3+zeta`; these computations are checks, not replacements for the proofs.
The parent and `adversarial_audit` independently derived and reviewed the
observable atom bounds, quotient transfer, zero-state example, and the
comparability boundary in OM7. I checked the same formulas before inclusion.
These are ordinary proofs, with finite sets throughout. No result in this
note is claimed Lean-verified, and none supplies a complete ABC proof.
