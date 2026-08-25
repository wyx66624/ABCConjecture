# Polyrelational Wronskians under fixed shears

**Status.** Offline research note. The exact common-Wronskian identities,
finite least-common-multiple divisor, rank-one pair determinant, weighted
Leibniz specialization, and the strict `u=2,3` degeneracy family are
formalized in
`IUTThreeClosures/PolyrelationalWronskianShears.lean`. The finite-product
resultant estimate below is a paper argument. This note does not prove the
abc conjecture.

## 1. Setup

Let

```text
a+b=c,                 gcd(a,b)=gcd(b,c)=gcd(c,a)=1,
d_u=c-u a>0.
```

For a natural number `n`, write

```text
R(n)=rad(n),            Q(n)=n/R(n).
```

Thus `Q(n)` is the powerful part used in the Lean development. Let `D` be
the free prime-weight arithmetic derivative

```text
D(n)=sum_{p|n} (n/p) v_p(n) x_p.
```

It satisfies the exact Leibniz rule and `Q(n)|D(n)`. Addition is not a rule
for `D`; every displayed additive compatibility below is a genuine linear
condition on the weights.

Put

```text
W=aD(c)-cD(a).
```

If

```text
D(a)+D(b)=D(c),
```

then

```text
W=aD(b)-bD(a).                                           (1.1)
```

The ordinary powerful-part argument therefore gives

```text
Q(a)Q(b)Q(c) | W.                                       (1.2)
```

No height estimate occurs in (1.1)--(1.2).

## 2. A shear adds one divisor of the same integer

Fix `u>=2`. The Leibniz rule says

```text
D(u a)=uD(a)+aD(u).
```

Impose the transparent coefficient condition `D(u)=0` and the additive
compatibility

```text
D(u a)+D(d_u)=D(c).
```

Then

```text
uD(a)+D(d_u)=D(c).                                      (2.1)
```

Multiplying (2.1) by `a` and using `c=u a+d_u` gives the exact identity

```text
W=aD(d_u)-d_uD(a).                                      (2.2)
```

Both `D(d_u)` and `d_u` are divisible by `Q(d_u)`, so

```text
Q(d_u) | W.                                             (2.3)
```

Consequently, for a finite parameter set `U`, simultaneous compatibility
implies

```text
L_U := lcm(Q(a)Q(b)Q(c), {Q(d_u):u in U})  | W.         (2.4)
```

The use of an LCM is essential. A product is available only after the
overlaps have been paid for.

The first term `u a` itself supplies no hidden extra copy. Prime by prime,

```text
Q(u a) | u Q(a).
```

Thus the divisibility `Q(u a)|uW` obtained by treating
`u a+d_u=c` as a separate abc relation contains only the old `Q(a)` after
the coefficient `u` has been cancelled. The genuinely new factor in (2.3)
is exactly `Q(d_u)`.

## 3. Exact rank-one collapse

Let `D_u=D(d_u)` and `D_v=D(d_v)`. From

```text
uD(a)+D_u=D(c),       vD(a)+D_v=D(c)
```

one obtains by direct expansion

```text
d_v D_u-d_u D_v=(u-v)W.                                (3.1)
```

Hence every pairwise remainder Wronskian is a fixed scalar multiple of the
same `W`. Adding shears adds congruences on one normal coordinate; it does
not create a second independent normal direction. This is the precise
relation with the existing rank-one projected-lattice obstruction.

In normalized logarithmic derivatives `ell_n=D(n)/n`, (2.1) is equivalent
to

```text
ell_{d_u}-ell_a = c/d_u (ell_c-ell_a),
W=a c(ell_c-ell_a).
```

All new normalized differences therefore lie on the same affine slope.

## 4. Resultant constants

The signed linear form is `d_u=c-u a`. Elementary subtraction gives

```text
d_u-d_v=(v-u)a.                                        (4.1)
```

Since `gcd(a,d_u)=gcd(a,c)=1`, every common divisor of `d_u,d_v` divides
`|u-v|`. The overlaps with the old tripod are

```text
gcd(a,d_u)=1,
gcd(c,d_u) | u,
gcd(b,d_u) | u-1.                                      (4.2)
```

The same bounds apply to the powerful parts. If

```text
Q_0=Q(a)Q(b)Q(c),       E_u=Q(d_u),
```

then

```text
gcd(Q_0,E_u) | u(u-1),
gcd(E_u,E_v) | |u-v|.                                  (4.3)
```

Here is a complete proof of the first assertion. A divisor `g` of
`gcd(Q_0,E_u)` divides `abc` and `d_u`. Since `gcd(a,d_u)=1`, cancel `a`
to get `g|bc`. Modulo `g`, the equations

```text
c=u a+d_u,       b=c-a
```

give `bc congruent to u(u-1)a^2`. Thus `g|u(u-1)a^2`; cancelling the
coprime factor `a^2` proves `g|u(u-1)`. The second assertion follows at
once from (4.1).

For positive integers `x_0,...,x_r`, prime valuations prove the finite
overlap lemma

```text
product_i x_i
  | lcm_i(x_i) * product_{i<j} gcd(x_i,x_j).            (4.4)
```

Indeed, after arranging the `p`-adic valuations as
`e_0>=e_1>=...>=e_r`, the LCM contributes `e_0`, while just the pairs
`(0,j)` contribute `e_1+...+e_r` to the product of gcds.

Combining (4.3)--(4.4), for a set of distinct parameters `U` one gets the
fully explicit fixed resultant loss

```text
Q_0 product_{u in U} E_u | K_U L_U,

K_U = product_{u in U} u(u-1)
      * product_{u<v in U} |u-v|.                      (4.5)
```

For fixed `U`, `K_U` is independent of the abc point. It is not legitimate
to omit it when `U` grows with the height.

## 5. The exact height inequality points in the wrong direction

Assume `W` is nonzero. From (2.4)--(4.5),

```text
Q_0 product_u E_u <= K_U |W|.                          (5.1)
```

Let `R=rad(abc)` and

```text
M=|D(a)|/a+|D(b)|/b.
```

Since `RQ_0=abc`, (1.1) gives `|W|<=abM`, and exact cancellation in
(5.1) yields

```text
c product_u Q(d_u) <= K_U R M.                         (5.2)
```

This is genuine, but it is a lower bound on the cost of every
nondegenerate compatible derivative:

```text
M >= c product_u Q(d_u)/(K_U R).                       (5.3)
```

Therefore the additional divisors do not by themselves provide the upper
bound on `M` needed by an abc proof. They make the nondegenerate selection
problem stronger.

## 6. Audit of the proposed large/small-new-radical dichotomy

Because `Q(d_u)=d_u/rad(d_u)`, taking logarithms in (5.2) gives

```text
log c + sum_u(log d_u-log rad(d_u))
  <= log R + log M + log K_U.                          (6.1)
```

There are two cases, but neither closes without a new theorem.

* If the new radicals are small, the left side of (6.1) is large. This
  forces `M` to be large by (5.3); it does not give a contradiction. The
  rank-one identity (3.1) explains why an ordinary short-vector argument
  cannot independently shrink all these costs.
* If a new radical is large, it cancels its own powerful-part term in
  (6.1), but `rad(d_u)` is not part of `R=rad(abc)`. Converting that new
  support into a bound for `c` requires precisely a uniform level-one
  four-form/truncated estimate. That is the unresolved coefficient-two
  core, not a consequence of resultants.

Thus the dichotomy is cyclic unless one supplies either (i) a genuinely new
nondegenerate upper bound for `M`, uniform in the added equations, or (ii) a
uniform variable-prime truncation theorem controlling the new radicals.

## 7. Strict tests

### 7.1 Resultant-only radical gain fails

The companion sheared-four-form development proves three strict tests.

1. One fixed shear can have `d_u=2^(n+1)` and radical `2` in an unbounded
   primitive family.
2. Two adjacent, hence coprime, shears can simultaneously be
   `2^(n+1),1`.
3. There is a primitive family in which `d_2,d_3,d_4` are three squares in
   arithmetic progression; all three simultaneously violate every uniform
   proposed `2/3` radical lower exponent.

Accordingly, fixed resultants alone do not make the large-radical branch
occur.

### 7.2 Freezing coefficients can force exact degeneracy

Take the second family at `u=2`:

```text
A=2^(n+1)-1,
(a,b,c)=(A,2A+1,3A+1),
d_2=2^(n+1),          d_3=1.
```

Suppose the weighted derivative satisfies

```text
D(2)=D(3)=0
```

and is additively compatible with both shear relations. Since

```text
D(2^(n+1))=(n+1)2^n x_2=0,      D(1)=0,
```

the two compatibility equations reduce to

```text
2D(a)=D(c),            3D(a)=D(c).
```

Hence `D(a)=D(c)=0` and `W=0`. If original-tripod compatibility is also
imposed, then `D(b)=0` as well.

This is a strict counterexample to the claim that the fixed shears `2,3`,
with `D(u)=0`, always admit a nondegenerate compatible prime-weight
derivative. It does not rule out adapting the parameter set to the point,
allowing controlled nonzero `D(u)`, or finding a genuinely new selector.

## 8. Surviving targets

The following routes remain logically open.

1. Let `U` depend on the point and prove a worst-case selector theorem whose
   loss includes the full `log K_U` and still remains sublinear in `log c`.
2. Permit `D(u) != 0` and control the exact correction
   `a^2D(u)` in
   `W=aD(d_u)-d_uD(a)+a^2D(u)` without hiding fixed-prime costs.
3. Produce a second normal invariant not algebraically proportional to `W`;
   merely adding first-order shear relations cannot do this by (3.1).
4. Prove the missing variable-prime, level-one four-form inequality with a
   uniform constant and an audited exceptional set.

The verified conclusion is therefore sharp: polyrelational shears enlarge
the divisor of one Wronskian, but fixed-resultant information alone neither
produces a noncyclic height gain nor guarantees a nonzero compatible
Wronskian.
