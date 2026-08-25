# Mersenne endpoint radical route: exact reduction to Wieferich mass

**Status.** Offline number-theoretic research note.  This route addresses the
straight-second-jet counterfamily

```text
(a,b,c)=(1,2^m-1,2^m)
```

by asking whether its radical can be controlled directly.  The answer is an
exact reduction, not an unconditional proof of the required bound: ordinary
LTE loss is harmless, while the remaining quantity is the total base-two
Wieferich excess.  No known elementary cyclotomic, resultant, or primitive
divisor argument bounds that excess at the required scale.

## 1. The exact size of the missing theorem

Put

```text
M_m=2^m-1,             r_m=rad(M_m),
Q_m=M_m/r_m.
```

The radical of the endpoint triple is `2r_m`.  Its abc inequality is

```text
2^m <= C_epsilon (2r_m)^(1+epsilon).                 (1.1)
```

For every fixed positive `epsilon`, (1.1) requires

```text
log r_m >= (log 2)/(1+epsilon) m-O_epsilon(1).        (1.2)
```

Because `epsilon` is arbitrary, the complete endpoint problem is equivalent
to

```text
log Q_m=o(m),                                           (1.3)
```

or, equivalently, `r_m=2^(m-o(m))`.  A polynomial lower bound for `r_m`, the
mere existence of one polynomial-size or otherwise sub-full-exponential
prime factor, or even `r_m>=exp(m^alpha)` with `alpha<1` is far too small.
(A single factor of size `exp((log 2-o(1))m)` would of course already be
enough.)  Conversely, any unconditional subexponential upper bound for `Q_m`
would settle this entire endpoint family.

The Lean definition `mersennePowerLoss` is exactly `Q_m`, and
`mersennePowerLoss_le_iff` proves the finite multiplicative equivalence

```text
Q_m<=K  <->  M_m<=r_m K.                               (1.4)
```

No proposed bound for `K` is assumed.

## 2. Cyclotomic factorization and what Zsigmondy supplies

The exact factorization

```text
2^m-1=product_{d|m} Phi_d(2)                           (2.1)
```

organizes primes by their multiplicative order.  Bang--Zsigmondy says that
for every `d>1`, except `d=6`, there is a prime primitive at level `d`.  Such
a prime satisfies

```text
ord_p(2)=d,              d | p-1,              p>=d+1. (2.2)
```

Primitive primes belonging to different levels are distinct.  Multiplying
one choice over the divisors of `m` therefore gives only a lower bound of the
shape

```text
r_m >= product_{d|m, d>1, d!=6} (d+1).                (2.3)
```

This is subexponential in `m`, and for prime `m` it is merely linear.  It is
nowhere near (1.2).  The fact that `Phi_d(2)` itself has exponential size does
not repair the argument: primitive-divisor existence supplies one distinct
prime but gives no upper bound for its exponent or the powerful part of the
remaining cyclotomic value.

## 3. Exact LTE decomposition

Let `p` be an odd prime dividing `M_m`, and put

```text
d_p=ord_p(2),             m=d_p k_p.
```

LTE gives the exact identity

```text
v_p(2^m-1)=v_p(2^d_p-1)+v_p(k_p).                     (3.1)
```

Since `d_p|p-1`, one has `p` not dividing `d_p`.  Hence

```text
v_p(k_p)=v_p(m).                                       (3.2)
```

Apply LTE once more to `p-1=d_p ((p-1)/d_p)`.  The second factor is positive
and smaller than `p`, so it is not divisible by `p`.  Therefore

```text
v_p(2^d_p-1)=v_p(2^(p-1)-1)=:w_p.                     (3.3)
```

Here `w_p>=1` by Fermat, and `w_p>=2` is exactly the base-two Wieferich
condition.  Consequently

```text
v_p(M_m)-1=(w_p-1)+v_p(m).                             (3.4)
```

Define the Wieferich excess carried by this Mersenne number by

```text
W_m=product_{p|M_m} p^(w_p-1)
I_m=product_{p|M_m} p^v_p(m).
```

Then (3.4) gives

```text
Q_m=W_m I_m,                I_m | m,                  (3.5)
```

and hence

```text
W_m <= Q_m <= m W_m.                                  (3.6)
```

Thus (1.3) is equivalent to

```text
log W_m=o(m).                                          (3.7)
```

This is the exact remaining obstruction.  Ordinary index lifting costs at
most the polynomial factor `m`; all potentially exponential loss lies in the
Wieferich excess at the first order level.

`IUTThreeClosures/MersenneRadicalWieferichBarrier.lean` formalizes (3.1) in
both `padicValNat` and factorization coordinates, its no-index-lifting
specialization, and the resulting equivalence of square divisibility.

## 4. A strict counterexample to deleting the Wieferich term

It is false that every primitive/order-level prime occurs only to the first
power.  Direct integer calculation gives

```text
1093^2 | 2^364-1,           1093^3 does not divide 2^364-1,
1093 does not divide 364.                                (4.1)
```

Moreover

```text
2^182 mod 1093 = 1092,
2^52  mod 1093 = 27,
2^28  mod 1093 = 121.                                  (4.2)
```

Since `364=2^2*7*13`, (4.2), together with
`2^364=1 mod 1093`, proves that no maximal proper divisor of `364` is an
exponent giving one.  Hence

```text
ord_1093(2)=364.                                       (4.3)
```

So `1093` is genuinely primitive at level `364`, and its square in (4.1) is
not inherited from a smaller index or from `1093|m`.  Lean kernel-checks all
integer divisibility and residue computations in (4.1)--(4.2).  This explicit
example strictly retires any route which simply declares the order-level
cyclotomic factors squarefree.

## 5. Why resultants and discriminants do not close (3.7)

Cyclotomic resultants control common primes between `Phi_d(2)` and
`Phi_e(2)`; apart from primes supported on the ratio of the indices, the
levels are separated.  Equation (3.5) is the valuation-level version of that
useful fact.  But it controls overlap **between** levels, not repeated powers
inside one value.

The discriminant of `Phi_d` likewise detects a repeated polynomial root
modulo `p`.  A prime satisfying `p^2|Phi_d(2)` may correspond to a simple root
modulo `p` which happens to lift to the fixed integer `2` modulo `p^2`.
Hensel lifting permits exactly this phenomenon; the polynomial discriminant
does not bound its valuation.  The example (4.1) makes the distinction
concrete.

Primitive-prime-divisor theorems also do not control `w_p-1`.  They provide a
new prime and the congruence `p=1 mod d`, while (3.7) asks for a uniform bound
on the total high-power mass of all order-level Wieferich primes.  Replacing
that missing bound by a claim that such primes are finite, sparse with a
quantitative weight, or have bounded excess would introduce a new unproved
number-theoretic hypothesis.

## 6. Exact research boundary

The endpoint has not been proved by this route.  It has been reduced to the
following concrete statement:

```text
For every eta>0, W_m <= exp(eta m) for all sufficiently large m.          (6.1)
```

Any proof of (6.1) would give the required endpoint abc estimate after the
harmless factor `m` is absorbed.  The following standard inputs do not give
(6.1):

1. one primitive prime per cyclotomic level;
2. the congruence `p=1 mod ord_p(2)`;
3. pairwise cyclotomic resultant control;
4. the cyclotomic discriminant;
5. LTE without a separate bound on the order-level term.

The surviving possibilities require genuinely new information about the
weighted distribution of base-two Wieferich primes across the divisors of
`2^m-1`, or a completely different treatment of the Mersenne endpoint.  A
polynomial or generic subexponential *lower* bound for the radical is not
close enough; the needed statement is the near-full exponential lower bound
(1.2).

## 7. Lean coverage

The companion module proves:

1. the exact radical--power-loss factorization and finite bound equivalence;
2. LTE for `v_p(2^(dk)-1)` and the same theorem for `Nat.factorization`;
3. absence of multiplicity growth when `p` does not divide `k`;
4. equivalence of square divisibility at the two exponents in that case;
5. primality of `1093`, its exact square-but-not-cube divisibility at exponent
   `364`, nondivisibility of the exponent, and the three order checks.

The global products (3.5), Bang--Zsigmondy, and the asymptotic equivalence
(1.3) remain paper-level.  No theorem or structure field assumes (6.1), abc,
or any finiteness statement about Wieferich primes.
