# A split-prime counterexample to the prescribed-Frobenius strategy

## 0. Result and scope

For an odd index `p=2m+1`, write

```text
T_p(X)=X*H_m(X).
```

The post-prime-31 literature audit isolated the following sufficient target:
for every relevant `X` and every prime `p>=37`, find a primitive divisor
`q|H_m(X)` with

```text
(5/q)=-1.
```

That target is false.  The exact counterexample is

```text
X=47,       p=43,       m=21,
q=74004140258268729146484924335493884636794672907656673308440413484294395629906354561.
```

Lean checks the recurrence and residue identities, while an independently
verified exact Pocklington certificate proves the primality assertion:

```text
H_21(47)=q,       q is prime,       q=1 (mod 5).
```

Consequently `q` is the only prime divisor of `H_21(47)`, and it splits in
`Q(sqrt(5))`.  There is no inert divisor at all, hence certainly no inert
primitive divisor.  This refutes the proposed sufficient statement even in
the required base class

```text
47=23 (mod 24),       43>=37.
```

This is a counterexample to a **strategy**, not to the shifted-square
equation and not to `abc`.  Indeed

```text
4*T_43(47)+5=6 (mod 7),
```

which is not a square modulo seven.

## 1. Exact Chebyshev quotient

The repository defines the quotient without division by

```text
H_0(X)=1,
H_1(X)=4*X^2-3,
H_(m+2)(X)=(4*X^2-2)*H_(m+1)(X)-H_m(X).
```

It has already proved in Lean that

```text
T_(2m+1)(X)=X*H_m(X).
```

Twenty-one exact recurrence steps at `X=47` give

```text
H_21(47)
 =74004140258268729146484924335493884636794672907656673308440413484294395629906354561
 =q.
```

Thus there is no factorization or probable-prime inference hidden in the
identity `H_21(47)=q`.

## 2. Frozen exact partial Pocklington certificate

The primality proof uses a proved partial Pocklington criterion.  Given a
factored divisor `F | n-1` with `n < F^2`, it is enough to check

```text
a^(n-1)=1
```

and, for every prime `r | F`,

```text
gcd(a^((n-1)/r)-1,n)=1.
```

The companion `PocklingtonPrimality.lean` proves this criterion from element
orders in `ZMod n`; the criterion itself is not assumed as an oracle.  The
following large finite packet was checked independently by PARI and a BigInt
verifier and is frozen at an explicit external-computation boundary.

### Root

The root witness is `a=14`, with

```text
F = 241429 * 289001 * 322807 * 3511969 * 164076821 * 222817015248829
  = 2891864791871945515608754452033430326885833563,

F | q-1,       q < F^2.
```

### Recursive nodes

The remaining non-leaf nodes and witnesses are

```text
3511969:         a=7,
  n-1=2^5*3*36583;

164076821:       a=2,
  n-1=2^2*5*43*190787;

222817015248829: a=2,
  n-1=2^2*3*7*11*13^2*31*46028623;

46028623:        a=3,
  n-1=2*3*17*311*1451.
```

Every other factor needed by these four recursive nodes or by `F` is at most
`322807`.  The external verifiers check the factor products, root divisibility
and size inequality, all Fermat congruences, and all required coprimality
conditions.  This is an exact proof certificate, not a probable-prime test,
but its large modular leaves are not currently replayed in the Lean umbrella.

The Lean counterexample module therefore defines the transparent proposition

```text
FrozenPocklingtonPrimeCertificateFortyThreeFortySeven
  := Nat.Prime q
```

and takes it as an explicit theorem parameter.  It introduces no `axiom`,
`sorry`, opaque declaration, GRH premise, or conjectural number theory; the
formal strategy refutation is conditional precisely on this named frozen
exact-computation boundary.

## 3. The unique divisor is genuinely primitive

Primitivity is not needed to refute the target: the absence of **any** inert
prime divisor is already stronger.  Nevertheless an independent exact order
calculation shows that this unique divisor is precisely of the type produced
by the primitive-divisor theorems.  This auxiliary order calculation was
cross-checked by PARI and a separate BigInt program; it is not replayed by the
Lean companion and is not used by the formal strategy refutation.

Put

```text
D=X^2-1=2208,
s=33471118227733347266420844347221000586396539967671562981193279294410890828335551044,
lambda=X+s
 =33471118227733347266420844347221000586396539967671562981193279294410890828335551091
   (mod q).
```

Exact modular arithmetic gives

```text
s^2=2208 (mod q),
lambda^172=1,
lambda^86=-1,
lambda^4!=1.
```

Since the proper divisors of `172=4*43` either divide `86` or equal `4`,
these three checks give

```text
ord_q(lambda)=172=4p.
```

Thus `q` is a genuine primitive divisor of the relevant Lehmer/Chebyshev
block, and it occurs to exact exponent one because `H_21(47)=q`.

## 4. Why Frobenius selection fails

Quadratic reciprocity for five gives

```text
(5/q)=(q/5).
```

Here `q=1 (mod 5)`, so `(5/q)=1`.  The single, odd-multiplicity primitive
prime therefore lies in the split Frobenius class.  This one value realizes
simultaneously the strongest outputs of the existing primitive-divisor
package:

- a primitive divisor exists;
- its exact valuation is odd, in fact one;
- its order is `4p`;
- and it splits in `Q(sqrt(5))`.

There is no second divisor from which an inert Frobenius class could be
selected.  Hence neither “take another primitive divisor” nor an
odd-valuation refinement repairs the proposed route.

## 5. Formal companion and trust boundary

The Lean file

```text
IUTThreeClosures/FreyPellChebyshevPrescribedFrobeniusCounterexample.lean
```

kernel-checks the recurrence, quotient identity, residue, shifted-square
nonsquare obstruction, and every consequence of the named frozen primality
certificate.  The generic partial Pocklington theorem is separately proved in
Lean.  The large numerical Pocklington packet is supplied only through the
transparent proposition above: unconditionality at the paper level comes
from the independently verified frozen exact certificate, not from a hidden
Lean axiom.  The unique-divisor and strategy-refutation theorems retain that
certificate as a visible argument.

The mathematical conclusion is deliberately narrow.  It rules out one
natural uniform sufficient target.  It does not produce a shifted-square
solution, disprove the remaining `p>=37` exclusion, prove or disprove `abc`,
or justify any conjectural Frobenius distribution statement.
