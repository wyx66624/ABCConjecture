# The prime window and integral native hulls under full lattice collation

**Author:** ChatGPT  
**Research date:** 2026-08-30  
**Status:** a proved conditional classification of a local native construction; no disproof of IUT or ABC.

The preceding report is left unchanged by this continuation. Its explicit
109-adic example fails the prime window of Joshi IV 5.7.1. This note asks
whether that failure is structural when one also requires all the native
packet's holomorphic hulls to be integral. Merely combining a sufficient
integrality condition with the window would not answer the question.
Instead, the first theorem below computes the exact hull for a precisely
specified full-isomorphism collation.

The admissible arrows are an essential hypothesis: they include every
`Z_p`-linear automorphism of the integral logarithmic lattice. A family
restricted to field isomorphisms or to some narrower Galois-induced
collection is not substituted for that family. Conversely, this result
does not assert that the full lattice automorphism group is realized by
every intended interpretation of “provided by” in III 9.7.5.1.

## 1. Source conventions and the local model

The already archived originals used here are:

* [Joshi III, v4](https://arxiv.org/pdf/2401.13508v4), pp. 109–117:
  the root input, normalized coefficient, all-topological-isomorphism
  collation, and the background coefficient of unit native norm;
  pp. 103–104 and [IUT IV](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20IV.pdf),
  April 2020 PDF pp. 26–27, for the procession block `{0,...,j}`;
* IUT IV, PDF pp. 10–14, Propositions 1.2 and 1.4, for the integral
  logarithmic lattices and maximal-order-normalized log-volume;
* [Joshi IV, v2](https://arxiv.org/pdf/2403.10430v2), p. 51,
  Definition 5.4.1, and p. 53, Theorem 5.7.1, for the normalized Tate
  quantity `Q` and the window `sqrt(Q)<=ell`.

These are the copies listed in
`research/IUT_MIXED_WEIGHT_CONTINUATION_2026_08_30.md`; no new source
version or statistical search is used in the present argument.

Let `p>2` be prime, and let `E/Q_p` be a finite Galois extension, of
degree `d` and ramification index `e`, with

```text
e <= p-2.                                         (1.1)
```

Let `v` be the valuation on `E` normalized by `v(p)=1`. Write
`O=O_E`, choose a uniformizer `pi`, and set

```text
kappa = 1-1/e,
I = (1/p)*log(O^*) = pi^(1-e)*O.                   (1.2)
```

To justify the lattice identity, (1.1) gives `1/e>1/(p-1)`.
The logarithm and exponential are mutually inverse on `1+m_E`
and `m_E` in this range. The prime-to-`p` Teichmuller factor of
`O^*` has logarithm zero. Hence `log(O^*)=m_E`, proving (1.2).
The least valuation of a nonzero element of `I` is `-kappa`.

For `a in m_E minus {0}`, let

```text
lambda(x)=log(1+p*x)/p,
u=lambda(1),        tau=lambda(a),        r=v(a)>0,
k=floor(r+kappa).                                  (1.3)
```

The convergent logarithm series gives `v(u)=0` and `v(tau)=r`.
For example, for `x in O`, the term `px` has strictly smaller
valuation than every higher term of `log(1+px)`: for `n>=2`,
the difference is `(n-1)*v(px)-v_p(n)>0`. Dividing by `p`
therefore preserves the valuation of `x`.

Since `p^n I` has least valuation `n-kappa`, one obtains

```text
u in I minus pI,
tau in p^k I minus p^(k+1)I.                       (1.4)
```

In particular, `u` and `tau/p^k` are primitive vectors in the
free rank-`d` `Z_p`-module `I`.

For an integer `m>=1`, consider a tuple with one theta coordinate
`tau` and `m-1` background coordinates `u`, in marked copies of
`I`. The collation includes all integral `Z_p`-linear isomorphisms
of those copies into a fixed target `I`. Repeated source labels
use the same map. This includes applying a single automorphism
`F in Aut_{Z_p}(I)` after all the coherent field markings.

Take the closed nonarchimedean convex closure in the product, then
the set-theoretic tensor image in `T_m=tensor^m_{Q_p}E`, then the
module hull over the maximal order

```text
B_m = product_{Gal(E/Q_p)^(m-1)} O_E.
```

Call the final fractional module hull `H_m`. Existence is part of
the theorem below. More general source configurations may be
included if, under their markings, every background coordinate
has content zero in `I` and every theta coordinate has content
`k` in `I`; their inclusion does not change the answer.

For `c in (1/e)Z`, the notation `p^c B_m` means the product of
the fractional ideals whose elements have valuation at least `c`
in each field component. It does not invoke a real-power operation
on the local field.

## 2. One common automorphism attains the two minimum layers

**Lemma 2.1.** If `x,y in I minus pI`, there exists one
`F in Aut_{Z_p}(I)` for which

```text
v(F(x))=v(F(y))=-kappa.                            (2.1)
```

**Proof.** Let `V=I/pI`, a vector space of dimension `d` over
`F_p`. The reductions `xbar,ybar` are both nonzero. The dual
space `V^*` has `p^d` elements. The linear forms vanishing on
`xbar` form a hyperplane of size `p^(d-1)`, and the same is
true for `ybar`. Since `p>2`, their union has size strictly
less than `p^d`. Choose a linear form `ell` vanishing on neither.

The quotient map `V=I/pI -> I/pi I` is surjective. Choose any
nonzero `F_p`-linear coordinate on the residue-field vector space
`I/pi I`, and compose it with this quotient to obtain a nonzero
functional `ell_0` on `V`. There exists `A in GL(V)` with
`ell_0 composed with A=ell`: extend bases of the two kernels
by vectors on which the respective linear forms have value one,
and send one resulting basis to the other.

Choose a `Z_p` basis of `I`, represent `A` by an invertible
matrix over `F_p`, and lift its entries to `Z_p`. The lifted
determinant is a unit, so its adjugate gives an inverse matrix
over `Z_p`. It defines an automorphism `F` of `I` lifting `A`.
The images `F(x),F(y)` have nonzero image in `I/pi I`, because
their images under `ell_0` are nonzero. Thus both lie in
`I minus pi I`, which is exactly its minimum-valuation layer.
This proves (2.1). QED.

The same `F` works for both vectors. Therefore this argument is
compatible with a requirement that repeated labels share their
isomorphism; it does not invoke independent transformations in
different tensor slots.

## 3. Exact hull and exact integrality threshold

**Theorem 3.1.** For the full integral-isomorphism collation
specified in section 1,

```text
H_m = p^(k-m*kappa) B_m.                           (3.1)
```

Consequently,

```text
H_m subset B_m
 iff k >= m*kappa
 iff r >= ceil(m*kappa)-kappa.                     (3.2)
```

Equivalently, the threshold on the right of (3.2) is

```text
r >= m-1-floor(m/e)+1/e.                           (3.3)
```

**Proof.** Every allowed isomorphism sends a background coordinate
into `I` and the theta coordinate into `p^k I`. A product of
these closed `Z_p`-lattices is closed and nonarchimedean convex,
so the product convex closure is still in this product. In the
Galois decomposition of `T_m`, a pure tensor is the product of
Galois conjugates of its entries. Such conjugates preserve `v`.
Each component of every tensor-image point therefore has
valuation at least

```text
(k-kappa)+(m-1)*(-kappa)=k-m*kappa.
```

The product ideal `p^(k-m*kappa)B_m` contains the tensor-image
set, so it contains its `B_m`-module hull. This also bounds
that set and makes a compact fractional hull available.

Apply Lemma 2.1 to `x=u` and `y=tau/p^k`. Use its single
automorphism `F` after the coherent marking in every occurrence
of a source label. This is one of the allowed configurations.
It produces the tensor

```text
t_F = F(u) tensor ... tensor F(u) tensor F(tau),
```

where `v(F(u))=-kappa` and
`v(F(tau))=k-kappa`. Every component of `t_F` has valuation
exactly `k-m*kappa`, and is nonzero. Thus

```text
t_F B_m = p^(k-m*kappa) B_m.
```

The hull contains `t_F` and all its `B_m`-multiples, proving
the reverse inclusion in (3.1). The threshold (3.2) follows
because `k` is an integer and `k=floor(r+kappa)`. Finally
`ceil(m*(1-1/e))=m-floor(m/e)`, giving (3.3). QED.

This computation does not merely turn the earlier sufficient
integrality bound into a conjectured necessary condition. The
lower layer is reached by an exhibited class of allowed maps,
and its full product ideal is forced by the coefficient-ring
hull operation.

If `V_B=(1/d^m)*log(mu_{B_m})`, with `mu_{B_m}(B_m)=1`,
the exact log-volume is

```text
V_B(H_m)=(m*kappa-k)*log(p).                       (3.4)
```

This follows by applying the normalized determinant/Haar formula
to the uniform fractional ideal (3.1). Its sign need not be
negative. In particular, replacing this signed quantity by
`-abs(log(volume))/d^m` is not innocuous when (3.2) fails.

For the previous 109-adic example, `e=35`, `r=36/7`, so
`k=floor(214/35)=6`. The full-isomorphism model gives

```text
H_3=p^(108/35)B_3,       H_4=p^(74/35)B_4.
```

The previously chosen marking-preserving point had valuation
`180/35`. It remains inside these larger hulls. Thus the earlier
integrality estimate is attained in this explicitly full
isomorphism model, while its failure of the prime window has not
been remedied.

## 4. The prime-window obstruction in a tame ramified Frey branch

Let `ell>=7` be prime and `s=(ell-1)/2`. The largest procession
block has `m=s+1=(ell+1)/2` tensor slots. Let the native root
satisfy `a^(2ell)=q`, where

```text
n=v_p(q)>0,        r=n/(2ell).
```

Suppose the normalized global Tate quantity and chosen prime
satisfy the two numerical conditions

```text
Q >= n*log(p),       ell^2 >= Q.                   (4.1)
```

The first is the contribution of this rational split Tate place,
using the base-change-invariant normalized degree; the second
is the lower endpoint of IV 5.7.1's prime window. Its upper
endpoint is not needed for the argument.

**Proposition 4.1.** Under the hypotheses of Theorem 3.1 and
(4.1), if every procession hull is integral, then

```text
n >= ell*(ell-1)*kappa,
kappa*log(p) <= ell/(ell-1).                       (4.2)
```

**Proof.** Apply (3.2) at `m=(ell+1)/2`. Its exact threshold
implies the weaker but useful bound

```text
r >= ceil(m*kappa)-kappa >= (m-1)*kappa.
```

Multiplying by `2ell` gives the first inequality. Combine it
with `n*log(p)<=ell^2` from (4.1), and divide by the positive
number `ell*(ell-1)`, to get the second. QED.

**Corollary 4.2.** Suppose further that `p>=7` and `e>=3`.
Then (4.1) and integrality of every procession hull are
incompatible in the full-isomorphism native model.

**Proof.** Since `e>=3`, `kappa>=2/3`. Since `ell>=7`,
`ell/(ell-1)<=7/6`. But

```text
kappa*log(p) >= (2/3)*log(7) > 7/6,
```

contradicting Proposition 4.1. One elementary exact verification
of the strict inequality is `log(7)>7/4`: the exponential
series gives `exp(1)<3`, while `3^7=2187<2401=7^4`, so
`exp(7/4)<3^(7/4)<7`. QED.

**Corollary 4.3 (the indicated rational Frey branch).** Let a
primitive rational Frey curve have split multiplicative reduction
at a prime `p` not dividing `30ell`. Let

```text
L'=Q(i,C[30ell]),       E=L'_w,
```

and suppose `E/Q_p` is ramified but has `e<=p-2`. Then the
full integral-isomorphism native construction cannot have all
procession hulls integral while satisfying (4.1).

**Proof.** At an odd prime of multiplicative reduction of a
primitive Frey equation, `c4` is a unit and

```text
n=v_p(q)=v_p(Delta)=2*v_p(a_Frey*b_Frey*c_Frey)
```

is even. Since `p` is prime to `30ell`, the same Tate torsion
calculation as in the preceding report gives

```text
e = 30ell/gcd(30ell,n).
```

Here the unit radicals and roots of unity contribute only an
unramified extension; the denominator of `n/(30ell)` gives
the displayed ramification index. The numerator `30ell` has
exactly one factor of 2, and `n` is even, so `e` is odd.
As it is not one, `e>=3`. Also `p>=7`. Apply Corollary 4.2.
QED.

The assumption `ell>=7` is appropriate for the level field
`Q(i,C[30])`: choosing `ell=5` would make its mod-5
representation trivial on that field, so it could not contain
`SL_2(F_5)` as required in the indicated initial data.

## 5. What this settles, and what remains open

The preceding counterexample's combination of a deep native
theta input and integral full hull is therefore structurally
incompatible with the prime window in the tame ramified branch
just specified. Increasing its large exponent does not fix that
issue. This conclusion follows from an exact reachability and
hull computation, not from unsuccessful numerical searches.

There are material restrictions on this conclusion:

* If `e=1`, then `kappa=0` and `I=O_E`. The full-isomorphism
  hull is integral for every integral theta input. This argument
  does not forbid such local parameters from satisfying the
  window. It also does not convert them into a counterexample to
  a Step (v) assertion whose hypotheses require a distinguished
  ramified place.
* If `e>p-2`, or `p` divides `30ell`, the identity (1.2) is
  not provided by the logarithm-convergence argument used here.
  The actual logarithmic lattice and its contents must be
  computed. No claim for that branch follows from this note.
* If the admissible maps form a narrower family than all
  `Aut_{Z_p}(I)`, the upper lattice bound still holds, but the
  common automorphism in Lemma 2.1 need not be admissible. Then
  the necessity in (3.2), and hence the obstruction, requires
  its own source-level reachability proof.
* Fractional `B`-module hulls still exist in (3.1). Their failure
  to be integral does not mean there is no holomorphic hull in
  the original IUT setting. It specifically matters for a
  convention restricting ideal generators to the integer
  rings, such as the printed definition in Joshi III 9.10.7.
* Changing the input to a squared-exponent theta-pilot changes
  `r` and its lattice content. The same theorem can be applied
  with that new content, but it then gives a different lower
  bound and does not identify that input with the native
  unpowered family.

This note proves no global failure of the IUT construction and
no proof or disproof of ABC. It identifies a precise alternative
for continuing this route: determine the actual admissible
isomorphism family and logarithmic lattice, and work with the
resulting integral or fractional hull under the same prime
window and numerical normalization. The mathematical proof was
written first; no additional Lean theorem is claimed here yet.
