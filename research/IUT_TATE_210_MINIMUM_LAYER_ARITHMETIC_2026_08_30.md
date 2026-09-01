# A common minimum layer in the actual 210-torsion local Tate field

Author: ChatGPT (arithmetic_geometry_route). Research date: 2026-08-30.

This is a new local mathematical derivation, not a modification of the frozen
paper or Lean snapshot. The local field is the actual prime-to-residue-
characteristic torsion field of a split Tate curve with the specified parameter.
No global rational Frey curve with that exact Tate parameter is asserted, and
no global initial-data or prime-window condition is inferred from this example.

The integral JW basis and trace inputs were independently checked in
`IUT_MINIMUM_LAYER_ARITHMETIC_CROSS_REVIEW_2026_08_30.md`. The new
noncommutative cross-handle substitution in
`IUT_FULL_GALOIS_MINIMUM_LAYER_2026_08_30.md`, sections 3–4, has now passed
the independent analytic review and direct checks in the arithmetic review.
The arithmetic proof below specifies precisely which resulting source
maps are used; it does not assume arbitrary lattice maps lift to Galois maps.

Sections 1–6 first treat one coefficient. Sections 7–10 strengthen this to
one common automorphism for the three explicitly defined square-index
coefficients. Whether this fixed-carrier family is the same as a particular
published theta-source output remains a separate source audit.

## 1. Field and coefficients

Set

```text
p=139,   ell=7,   q=p^2,
K0=Q_p(mu_210),   pi^105=p,   E=K0(pi),
v(p)=1,   O=O_E,   I=(1/p)log(O^*).
```

Since `139^2=1 mod 210` but `139!=1 mod 210`, the field `K0/Q_p`
is unramified quadratic. The polynomial `X^105-p` is Eisenstein over
`K0`. The field `K0` contains `mu_105`, so `E` is the splitting field and

```text
[E:Q_p]=210,   e=105,   f=2.
```

For a split Tate curve with parameter `q`, its 210-torsion field is
`Q_p(mu_210,q^(1/210))`; here a choice of `q^(1/210)` is `pi`.
Thus the displayed `E` is that local torsion field. Adjoining `i` does not
enlarge it: `139=-1 mod 4` and `K0` already has unramified degree 2.

Because `1/e=1/105 > 1/(p-1)=1/138`, logarithm and exponential identify
principal units with `pi O`. Consequently

```text
I=pi^(-104)O,   pI=pi O,   pi I=pi^(-103)O.
```

Put `kappa=104/105`. The minimum valuation of a nonzero element of `I`
is `-kappa`, and an element reaches this minimum precisely when it is
not in `pi I`.

The native `2ell`-th root of `q` can be taken to be
`q^(1/14)=p^(1/7)=pi^15`. Define

```text
u   = log(1+p)/p,
tau = log(1+p*pi^15)/p,
t   = tau/p.
```

Then

```text
v(u)=0,   v(tau)=1/7,   v(t)=-6/7=-90/105.
```

In particular `u,t` both lie in `pi I`, but neither lies in `pI`.
So the previous 19-adic proof, which started with `t` already in the
lowest layer, cannot simply be copied.

## 2. Integral JW coordinates and the trace

The tame cyclotomic action on `mu_p` is nontrivial because `p-1=138`
does not divide the ramification index 105. In the full JW presentation,
the coefficient

```text
1-(g/(p-1))*sum_{j=1}^{p-1}h^j
```

is therefore 1 modulo `p`. Abelianizing its actual relation eliminates
`y_0` integrally. Hence `v_i=y_i/p`, `1<=i<=210`, form a `Z_p` basis
of `I`, not merely a rational basis. This is the same additional argument
as in the independent 19-adic review; Hoshi–Nishio Lemma 1.3 alone would
only supply rational independence.

Let

```text
a=v_1,   b=v_2,   W=direct_sum_{i=3}^{210} Z_p v_i.
```

By [Kondo, arXiv:2512.09231v2](https://arxiv.org/html/2512.09231v2),
Theorem 1.3, the trace kernel is `Q_p a + Q_p W`. Also

```text
I=direct_sum_{j=-104}^0 O_K0*pi^j,
Tr(I)=Z_p,
Tr(O)=Z_p,
O subset pi I.
```

For the trace assertions, all the displayed negative powers have relative
trace zero over `K0`, and `Tr_E(1/210)=1`; the denominator 210 is a unit.
Thus `beta=Tr(b)` is a unit and, in

```text
z=A_z a+B_z b+w_z,
```

all coefficients are integral and `B_z=Tr(z)/beta`. Subtracting
`Tr(z)/210` also proves that `ker(Tr) cap I` surjects onto `I/pi I`.

The 105 conjugates of `pi^15` over `K0` are its seven distinct
conjugates, each repeated 15 times. It follows that

```text
Norm_{E/K0}(1+p*pi^15)=(1+p^8)^15,
Tr(u)=210 log(1+p)/p,
Tr(t)=30 log(1+p^8)/p^2.
```

Hence

```text
B_u in Z_p^*,   v(B_t)=6.                           (1)
```

For every field automorphism `sigma` of `E/Q_p`, the same trace and
coefficient assertion holds for `sigma(t)`.

## 3. A real obstruction for the displayed parabolic subgroup

Pass to the finite vector space

```text
V=I/pI,   L=(pi I)/pI subset V.
```

It has dimension 210 over `F_p`, and `L` has codimension 2. Denote
the reduction of a coordinate vector by the same letter in this section.
The trace coordinate `B:V -> F_p` has

```text
ker B = F_p a direct_sum W,
B(u)!=0,   B(t)=0,
u,t in L,   t!=0.
```

The source operations under consideration fix `a` and have the following
integral linear actions before reduction:

```text
T_a(b)=b+a;                 T_a fixes a,W;
E_w(b)=b+w;  E_w(x)=x+omega(w,x)a for x in W;
S|W in Sp(W,Z),             S fixes a,b.
```

Here `w` may be any displayed basis direction; inverse operations supply
the corresponding negative direction. These actions generate a subgroup
of the symplectic stabilizer of `a`.

**Exact obstruction for this subgroup.** If `t` lies in the line `F_p a`,
then every one of these operations fixes `t` in `V`. Since `t!=0` and
`t in L`, necessarily `a in L`, so no product of these operations can
send `t` to the lowest layer. This is a genuine invariant of the displayed
subgroup, not a failed numerical search. It is not an invariant asserted
for the whole absolute Galois automorphism group.

## 4. Joint reachability off the fixed line

**Lemma.** Suppose `U,T in L`, `B(U)!=0`, and
`T in ker B` is nonzero but does not lie in `F_p a`. Suppose also that
`ker B -> V/L` is onto, as proved above. The displayed operations contain
one common map sending both `U` and `T` outside `L`.

**Proof.** Write `T=A_T a+w_T`. Its component `w_T in W` is nonzero.
Use the integral alternating form `omega` in the JW handle coordinates.

If `a notin L`, nondegeneracy of `omega` gives a displayed basis direction
`w` with `omega(w,w_T)!=0`. The cross operation gives

```text
E_w(T)=T+omega(w,w_T)a mod pI,
```

so it is outside `L`. If `E_w(U)` is already outside `L`, stop.
Otherwise apply `T_a` once: it adds `B(U)a` to that vector, which has
nonzero image in `V/L`. It leaves `E_w(T)` unchanged in `V` because
`B(T)=0`. This gives one common composition for the two vectors.

Suppose instead `a in L`. Then the map
`lambda:W -> V/L` is onto. If `lambda(w_T)!=0`, take `S` to be the
identity. Otherwise choose `r in W` such that

```text
lambda(r)!=0,   omega(r,w_T)!=0.                    (2)
```

Such `r` exists: the kernel of `lambda` and the kernel of the nonzero
functional `omega(-,w_T)` are two proper linear subspaces and cannot
cover `W`. Explicitly, if a vector satisfying the first inequality fails
the second and a vector satisfying the second fails the first, their sum
satisfies both.

Choose any integer coordinate lift `r_Z` of `r`, and take the integral
symplectic transvection

```text
S(z)=z+omega(r_Z,z) r_Z   on W.
```

This is in `Sp_208(Z)`: expansion preserves the alternating pairing,
the square of the added rank-one operator is zero, and changing its sign
gives the inverse. By (2),

```text
lambda(S w_T)=omega(r,w_T) lambda(r)!=0.
```

Thus `S(T)` is outside `L`. If `S(U)` is outside `L`, stop. Otherwise
choose a displayed basis vector `w` of `W` with `lambda(w)!=0`, which
exists by surjectivity of `lambda`, and apply `E_w`. Its effect on the
projection of `S(U)` is to add `B(U)lambda(w)!=0`. Its effect on that
of `S(T)` is zero: `B(T)=0` and `a in L`. The latter vector therefore
remains outside `L`. QED.

This proof needs an actual lift of the single integer symplectic matrix
`S`, not surjectivity onto `Sp_208(Z_p)`. Kondo's construction on p. 19
and Theorem 2.17 on p. 20 realize each integral symplectic matrix of the remaining handles by a
boundary-fixing surface automorphism and thence by a full JW automorphism
fixing `sigma,tau,x_0,x_1,x_2`. The new cross operation is the separate
full-relator calculation; its word is independent of the number of
untouched handles.

The even-degree clause is explicit in that construction. The later
odd-degree restriction before Theorem 2.19 is not a hypothesis of the
construction or of Theorem 2.17, and Theorem 2.19 is not used here.

## 5. Actual field inertia removes the fixed-line obstruction here

The logarithm tail gives the useful congruence

```text
t = pi^15/p mod pI.                                (3)
```

Indeed the second and all later terms of
`log(1+p*pi^15)/p^2` have valuation at least `2/7`, which is greater
than `1/105`, the minimum valuation of `pI`. For example, for the
`n`-th logarithm term with `n>=2`, use
`v_p(n)<=n-2` and `v(p*pi^15)=8/7` to bound its valuation after division
by `p^2` below by `2/7`.

Take the actual inertia automorphism

```text
sigma(pi)=zeta_105*pi,   sigma|K0=id.
```

It fixes `u`. Applying it to (3) gives

```text
sigma(t)=zeta_7*pi^15/p mod pI,
zeta_7=zeta_105^15.
```

The reduction of `zeta_7` has order 7 in `F_(139^2)^*` and does not
belong to `F_139^*`, since 7 does not divide 138. Therefore the images
of `t` and `sigma(t)` in `V` are linearly independent over `F_139`.
For detail, any proposed dependence with a scalar `c in F_139` would
force `(zeta_7-c)pi^15/p` into `pI`; its coefficient is a unit and its
valuation is `-90/105`, a contradiction.

At least one of these two nonzero vectors consequently lies outside
the single line `F_p a`. Both still belong to `L` and `ker B`. Choose
`g=id` or `sigma` accordingly and apply the lemma to `U=u`, `T=g(t)`.
The composition first using `g` and then the constructed common JW map
therefore satisfies

```text
v(F(u))=v(F(t))=-104/105,
v(F(tau))=1/105.                                   (4)
```

Thus the fixed-line invariant of section 3 does not obstruct the full
source automorphism family in this specific 210-torsion local field.
The field automorphism used to leave the line is an explicit genuine
automorphism, not an arbitrary change of the integral JW basis.

## 6. Kummer variance and the scoped tensor consequence

The operations just used are expressed in the covariant logarithmic
action reconstructed from local reciprocity. Under a contravariant
Kummer convention, local Tate duality gives `F_Kum=c M^(-1)` with
`c in Z_p^*`, where `M` is that covariant action. Use the inverse
source automorphism to obtain a unit multiple of the desired `M`.
It preserves all valuations in (4). The same choice must be made at
every occurrence of a repeated source label.

For the local orbit family of the fixed coefficients `u,...,u,tau`
with `m` slots, let `B_m` be the maximal order of `E tensor ... tensor E`.
Because `E/Q_p` is Galois, its field factors are copies of `E`.
Every integral source action preserves `I` and `pI`; hence every tensor
component has valuation at least

```text
1-m*kappa = 1-104m/105.
```

This remains so under the indicated `Z_p` convex closure. The one
common action in (4) gives a tensor whose every field component has
exactly that valuation. It is invertible in the tensor algebra, so its
`B_m` multiples fill the corresponding product fractional ideal. Thus
for this defined orbit family the `B_m`-module hull is exactly

```text
H_m = product_alpha pi^(105-104m) O_E.              (5)
```

No ambiguous choice of a fractional rational power of `p` is needed in
(5). It is nonintegral for every `m>=2`; for `m=4` its component
valuation is `-311/105`.

The source-level cross lift, the source-arrow convention, and the fixed
local orbit family are part of the statement. Equation (5) is not an
assertion that every global IUT packet has been instantiated, nor a
refutation of a result with different input powers or admissibility
conditions. It does show why the nonminimum initial value of `tau/p`
does not by itself block a common minimum layer in this actual local
Tate torsion field.

## 7. The three square-index coefficients and their integer contents

For `j=1,2,3`, put `s=j^2` and define, in this same fixed field,

```text
tau_s = log(1+p*pi^(15s))/p,
k_s = floor(s/7+104/105),
T_s = tau_s/p^k_s.
```

The integer `k_s` is exactly the largest integer `k` such that
`tau_s in p^k I`: that condition is `k <= v(tau_s)+104/105`.
The precise data are

| j | s | k_s | v(T_s) | v(Tr(T_s)) |
| --- | --- | --- | --- | --- |
| 1 | 1 | 1 | -90/105 | 6 |
| 2 | 4 | 1 | -45/105 | 9 |
| 3 | 9 | 2 | -75/105 | 13 |

All three vectors are in `pi I` and are nonzero modulo `pI`. Since none
of `1,4,9` is divisible by 7, the norm calculation is

```text
Norm_{E/K0}(1+p*pi^(15s))=(1+p^(s+7))^15,
Tr(T_s)=30 log(1+p^(s+7))/p^(k_s+1).                (6)
```

Thus the corresponding `b` coordinate is divisible by `p` in each case,
with exactly the valuations in the table. No trace cancellation estimate
is being used in place of these equalities.

The logarithm tail also gives

```text
T_s = pi^(15s)/p^k_s mod pI.                       (7)
```

Indeed its tail has valuation at least `1+2s/7-k_s`, which is respectively
`2/7, 8/7, 11/7`, all greater than `1/105`. This proves (7) in the
actual `Z_p` quotient `I/pI`, not just at the single lowest graded piece.

## 8. One inertia choice and the required cross operations

For `h=0,...,6`, the field automorphism `sigma^h` from section 5 sends the
leading term in (7) to

```text
zeta_7^(s h) pi^(15s)/p^k_s.
```

For each fixed `s`, these seven vectors determine seven distinct
`F_p` lines in `I/pI`. If two lines agreed, the quotient of their leading
coefficients would be an element of
`mu_7 cap F_139^*`, which is `{1}`; since `s` is invertible modulo 7,
their two indices `h` would be equal. Consequently, for each `s` there
is at most one value of `h` for which `sigma^h(T_s)` lies in `F_p a`.
Avoid the at most three excluded values. There remains one common `h`
such that all three resulting vectors are outside this fixed line.

The field automorphism fixes `u`, preserves `L`, and preserves the trace.
After this one choice, let `T_1,T_2,T_3` denote the resulting reductions
in `V`; all lie in `(ker B) cap L`, and all have nonzero `W` components.

It remains to justify that a single cross operation with any desired
integer coordinate vector can actually be used. Write `C_c` for the
linear action fixing `a,W` and sending `b` to `b+c a`, and `N_w` for
the cross action in section 3. Direct calculation gives identities
**of the induced linear actions**

```text
N_w N_v = C_(omega(w,v)) N_(w+v),
N_w^n = N_(n w)       (n in Z),
C_c C_d = C_(c+d).
```

The `C_c` commute with all the displayed operations. In particular, if
`w=sum_i n_i e_i` in the displayed integral basis of `W`, then

```text
N_w = C_(-sum_{i<j} n_i n_j omega(e_i,e_j))
      * product_i N_(e_i)^(n_i).                   (8)
```

The product has the fixed basis order from left to right, and maps compose
rightmost first. The sign of the displayed central correction uses this
order and the convention `omega(v_3,v_4)=1`.

Each basis cross has the verified full JW lift, and `C_1` is the
verified map `x_2 -> x_2 x_1`. All integer powers and compositions
therefore have full Galois lifts. Formula (8) shows that any integer
coordinate lift of a desired `w mod p` is available. It does not assert
these Heisenberg relations in the full nonabelian automorphism group;
only their canonical linear images need satisfy (8).

## 9. One common parabolic action for all three vectors and u

We now prove simultaneous reachability using the one inertia choice
already made. Write `T_j=A_j a+w_j` in `V`, with every `w_j!=0`.

If `a notin L`, choose `w in W` with

```text
omega(w,w_j)!=0   for j=1,2,3.
```

Each forbidden set is a proper hyperplane in the 208-dimensional
`F_139` vector space `W`; their union has at most `3*139^207`
elements, fewer than `139^208`. Take any integer lift of `w` and
use its actual cross action from (8). Since each initial `T_j` belongs
to `L`,

```text
N_w(T_j) mod L = omega(w,w_j) a mod L != 0.
```

All three are therefore at the minimum layer. If `N_w(u)` is not there,
apply `C_1`; it adds the nonzero class `B(u)a` to `u` and leaves
each `T_j` unchanged modulo `pI`, because every `B(T_j)=0` in `F_p`.
If `N_w(u)` was already at the minimum, use `C_0` instead.

If `a in L`, the map `lambda:W -> V/L` is onto. Select `r in W` such that

```text
lambda(r)!=0,
omega(r,w_j)!=0   for j=1,2,3.                     (9)
```

The union of the excluded sets has at most
`139^206+3*139^207` elements, less than `139^208`; equivalently
`1+3*139 < 139^2`. Thus (9) is possible. Lift `r` to an integer vector
and use the single integral symplectic transvection

```text
S(z)=z+omega(r_Z,z) r_Z   on W,
S(a)=a,   S(b)=b.
```

Its full Galois lift is supplied by the boundary-preserving handle
construction cited in section 4. Since `T_j in L` and `a in L`,
the initial projection `lambda(w_j)` is zero for every `j`. Hence

```text
S(T_j) mod L = omega(r,w_j) lambda(r) != 0.
```

There is no cancellation parameter to choose for this specific family:
the transvection parameter 1 works because all initial projections vanish.
More generally a variable integer parameter would exclude at most one
cancellation value per vector, but that extension is not needed here.

If `S(u)` is not at the minimum, choose one displayed basis direction
`w` with `lambda(w)!=0` and apply `N_w`. It changes the zero projection
of `S(u)` by `B(u)lambda(w)!=0` and leaves all three already nonzero
`T_j` projections unchanged, because `B(T_j)=0` and `a in L`.
If `S(u)` is already at the minimum, no further cross is needed.

This proves that **one and the same full Galois automorphism** has a
canonical action `M` satisfying

```text
v(Mu)=v(M T_1)=v(M T_4)=v(M T_9)=-104/105,
v(M tau_1)=1/105,
v(M tau_4)=1/105,
v(M tau_9)=106/105.                                (10)
```

Here the subscripts `1,4,9` in (10) return to the original square indices,
and the single `M` includes the common inertia automorphism. No section
from a mapping class group into the outer Galois automorphism group is
required: individual verified lifts are selected and composed; their
canonical linear action is functorial. The inverse/unit Kummer conversion
in section 6 preserves all four minimum valuations simultaneously.

## 10. Three attained local block hulls, with a common witness

For `j=1,2,3`, set `m=j+1` and use the fixed local source tensors

```text
F(tau_(j^2)) tensor F(u) tensor ... tensor F(u)
```

with the same arrow at repeated labels. Let `H_j` be their `B_m`-module
span as the full integral Kummer arrow varies. The universal upper bound
is given by `tau_(j^2) in p^k_(j^2) I`, while (10) supplies a **common
single arrow** attaining that bound in all three blocks. Thus

```text
H_1 = product_alpha pi^(-103) O_E,   m=2,
H_2 = product_alpha pi^(-207) O_E,   m=3,
H_3 = product_alpha pi^(-206) O_E,   m=4.             (11)
```

The exponents are `105*k_(j^2)-104*(j+1)` with `k=(1,1,2)`.
The same proof as section 6 shows that these spans are closed fractional
product lattices. Each is nonintegral. These conclusions apply to the
fixed-carrier square-index vector family explicitly defined here.

An independent source review by iut_route is checking whether that family,
with these markings and this coherent arrow, occurs in the particular
published holomorphic collation and powered-pilot setup. The existence
of (10) and (11) must not be used to silently assume that same-set
statement, global initial data, or an unrestricted choice of global level
prime. No such identification, global counterexample, or ABC conclusion
is included in this report.

## 11. The same proof for the actual Frey Tate parameter

The special equality `q=p^2` is not necessary. Let `C/Q_139` be any
elliptic curve with split multiplicative reduction, full rational
2-torsion, and native Tate parameter satisfying `v(q)=2`. Then there
is `b0 in Q_139` such that

```text
b0^2=q,   v(b0)=1.
```

Here is a direct justification for the square root. Tate uniformization
is an isomorphism of Galois modules
`C(Qpbar) = Qpbar^*/q^Z`. The class of a chosen square root of `q`
is one of its points of order 2. Its rationality says that every Galois
automorphism changes that square root by a power of `q`. On the other
hand the change is a sign. Comparing valuations forces the power of
`q` to be zero, and then the sign to be `+1`. Thus the square root
itself is fixed by Galois.

The precise uniformization input just used is Silverman, *The Arithmetic
of Elliptic Curves*, second edition (2009), Theorem C.14.1(a),(b),
printed p. 445 (PDF p. 456 in the already archived copy). The preceding
page gives `j(q)=q^(-1)+744+...` and the discriminant product. The original
was inspected at
`research/sources/global_uniform_gate_2026_08_30/Silverman_2009_Arithmetic_of_Elliptic_Curves_2nd.pdf`;
its source link is [the archived book source](https://www.pdmi.ras.ru/~lowdimma/BSD/Silverman-Arithmetic_of_EC.pdf).

Now choose

```text
pi^105=b0,
K0=Q_139(mu_210),
E=K0(pi),
r=pi^15=q^(1/14),
tau_s=log(1+p*r^s)/p,   s=1,4,9.
```

The polynomial `X^105-b0` is still Eisenstein over the unramified
quadratic field `K0`. Thus `(d,e,f)=(210,105,2)` and `I=pi^(-104)O`
are unchanged: `b0/p` is a unit, so the equality of fractional ideals
does not require `b0=p`. Moreover

```text
Q_139(C[210])=Q_139(mu_210,q^(1/210))=K0(pi)=E.
```

For completeness, Tate uniformization identifies all 210-torsion classes
with `zeta*q^(a/210)` modulo `q^Z`. An automorphism fixes the torsion
point represented by `q^(1/210)` only if its root-of-unity multiplier
belongs to `q^Z`, hence only if that multiplier is 1. Likewise it fixes
the root-of-unity torsion classes precisely when it fixes `mu_210`.
This proves the claimed full torsion field, not just containment in it.
Adjoining `i` again adds nothing since the unramified quadratic field
already contains it.

All integer contents `k_s=(1,1,2)`, all three valuations, and the
residue arguments remain the same. The exact trace formula becomes

```text
Tr(T_s)=30 log(1+p^7*b0^s)/p^(k_s+1).              (12)
```

Its valuation is still `s+6-k_s`, namely `6,9,13`. In the residue
calculation one keeps `pi^(15s)/p^k_s` instead of replacing it by a
bare power of `pi`; the intervening unit `(b0/p)^k_s` is rational
and fixed by inertia. Thus the same characters `zeta_7^s`, the same
seven distinct orbit lines, and the same common minimum-layer proof
give (10) and (11) for this actual parameter.

In particular this applies to every primitive rational Frey curve

```text
C: y^2=x(x-a)(x+b),  a+b=c,  gcd(a,b)=1,
```

for which `p=139` divides `abc` exactly once and the reduction at
139 is split multiplicative. Indeed the invariants are

```text
Delta=16*(abc)^2,   c4=16*(a^2+ab+b^2).
```

At a prime dividing one of the pairwise coprime endpoints, `c4` is
a unit. The displayed integral model has discriminant valuation 2,
so it is minimal, and `v(j)=-2`. Split Tate uniformization and its
`j` expansion give `v(q)=2`. Its full rational 2-torsion is visible
at the three roots `0,a,-b`. All the hypotheses above therefore hold.

This is an actual class of primitive Frey local fields and no longer
requires an exact globally prescribed Tate parameter `q=p^2`. It still
does not identify the fixed-carrier vector family with an entire
published collation, establish all global initial data, or supply
a global ABC contradiction.
