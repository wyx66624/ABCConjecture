# Signed endpoint selection and sharp difference-face thresholds

Author: ChatGPT  
Date: 2026-09-05, second supplement  
Inspected remote main: `6118955d20b4edd32e577e06d1060f3945358dd9`

**Status:** ordinary mathematical proofs; reproducible integer/rational computations;
partial **uncompiled** Lean draft. No proof or disproof of standard abc; no remote
commit or merge. Novelty outside the inspected project is not asserted.

## 1. The mathematical change

For a normalized primitive positive triple `a+b=c`, `a<=b`, keep the original
sum-endpoint FCRT boundary `B_c`, but also build a genuine signed configuration
for `c-a=b`. For a signed target `n=x+sigma*y`, `sigma in {+1,-1}`, a block
requires `M_S | x_T+sigma*y_T`, nonempty source and sink sets, disjointness,
and `D_S<=Q_T`. A token still needs an actual nonempty proper face and is
capped by both surplus and face weight. No free fractional pooling is added.

Let `F_c=exp(B_c)` and `F_b=exp(B_b)` for the two orientations. Define

`F_sel = min(F_c, (c/b)*F_b)`, `E=log(F_sel)`.

**Theorem.** `c <= R*F_sel`, and `Delta <= E <= B_c`.

**Proof.** The ordinary signed configuration certificate gives `c<=R*F_c`
and `b<=R*F_b`, with the same radical `R=rad(abc)`. Multiply the latter by
`c/b` and take the smaller bound. Both factors are at least one. QED.

## 2. An exact accounting equality, not only an upper bound

For every signed configuration, let:

- `U0` be the product of unowned residual sink primes;
- `S0=product(Q_T/(D_S*f))`, with `f=1` for an unused token;
- `O0=product(max(K_p/d_p,1))` over residual sources.

Then all three factors are at least one and

`F = (n/R)*U0*S0*O0`.

**Proof.** Multiply `max(d/K,1)=(d/K)*max(K/d,1)` over residual sources.
The demand product is `n/rad(n)` divided by the covered demand factors;
the credit product is the product of owned residual sinks and emitted tokens.
Disjointness and `rad(n)*Q_all=R` give the displayed equality. Saturation
and the token cap imply `S0>=1`. QED.

Let `L_c*` and `L_b*` be the minima of `log(U0*S0*O0)` for the two orientations.
Then, exactly,

`E = log(c/R) + min(L_c*,L_b*)`.

The positive-defect region therefore requires a bound on the abc defect AND
on the smaller of two concrete allocation losses. The scalar defect has not
been independently bounded here.

## 3. Positive theorem: removing the loss at a one-source neighbouring endpoint

For either sign, a target with at most one prime of exponent at least two
has exact boundary factor `max(n/R,1)`: assign every sink to its single
source and use the general lower bound. The case of no sources is immediate.
A target with `n<=R` has boundary one via the full saturated block.

Consequently, if `b` has at most one powerful prime and `R<=b`, then
`F_sel=c/R`. Without `R<=b`, the same hypothesis gives
`E<=Delta+log(c/b)<=Delta+log(2)`.

This repairs the previous divisor-gap obstruction on that stratum without
asserting any uniform abc defect bound in arbitrary parameters.

## 4. Sign-sensitive deletion rule

With `Phi(T)=x_T/y_T mod M`, a compatible face has label `-sigma`.
The complementary deletion has label `-sigma*Phi(T)`.
The minimum deletion MUST range over nonempty PROPER subsets.

For the plus sign, fullness is automatically impossible for `M>=4`.
For the minus sign, the full deletion always has its own target label;
allowing it would create an invalid empty witness face. The packet `(17,1;16)`
is an elementary counterexample to that careless sign substitution.

The corrected optimal token factor is
`Q_T/max(D_S,z_sigma(T))`, where `z_sigma` is the minimum radical product
among legal nonempty proper deletions with the required label.

## 5. Sharp ordinary arithmetic theorem for the difference endpoint

Let `M=p^e || n`, `e>=2`. Suppose `n+1=d*u`, `d,u>1`, `gcd(d,u)=1`,
and `u=1 mod M`. Then

- `n>=M*(2*M+3)` for `p!=3`;
- `n>=M*(4*M+5)` for `p=3`.

**Proof.** Both factors are one modulo M. Write `d=M*s+1`, `u=M*t+1`.
Coprimality excludes `s=t`; interchange the factors so `1<=s<t`.
Then `n/M=M*s*t+s+t`. The minimum possible ordered pair `(1,2)` gives
`2*M+3`. At p=3 this pair violates exact valuation. The next pair `(1,3)`
produces two even factors and violates coprimality. Every remaining pair
has `M*s*t+s+t>=4*M+5`. QED.

**Sharpness.** For `p!=3`, use
`n=M*(2*M+3)`, `n+1=(M+1)*(2*M+1)`.
The factors are coprime and `p` does not divide `2*M+3`.
For `p=3`, use
`n=M*(4*M+5)`, `n+1=(M+1)*(4*M+1)`.
Their gcd is `gcd(M+1,3)=1` and the source valuation is exact.
Thus both thresholds are attained by actual whole-prime-power packets.

## 6. Certified 39-digit repair

`c=2^64*3^41=672808029771005150108072916419239477248`

`c-1=13^2*q`, where

`q=3981112602195296746201614890054671463` is prime.

Its primality is proved by the included recursive full-factor order
certificate: 25 certified prime nodes and 70 modular order witnesses.
The verifier uses only integer products, powers modulo integers, and gcds.

The old sum orientation has no proper faces, and its full optimum is
`F_c=2^63/13`. In the difference orientation the sole demand is 13 and
sink product is 6, so `F_b=13/6`.
Hence `F_sel=c/R`, with `R=78*q`.
The exact removed excess factor is `q/3^40 > 3*10^17`.
This huge artificial loss is NOT a huge abc defect.

## 7. A complete obstruction survives; the new route is not tautological

For `1+3024=3025`,

`3024=2^4*3^3*7`, `3025=5^2*11^2`, `R=2310`.

Both orientations have only full compatible blocks and no proper flags.
The full two-source blocks are unsaturated. Exact exclusive partitions give
`F_c=11/7`, `F_b=8/5` and

`F_sel=min(11/7,3025/3024*8/5)=11/7`.

But `c/R=55/42`, so the excess factor is `6/5`.
The paper lists every relevant proper packet and partition; the program
independently enumerates all legal configurations.

**Only the universal pointwise-collapse child is refuted.** Neither the
original FCRT uniform estimate, the signed selector uniform estimate, nor
abc is refuted by this finite point.

## 8. Live decisive target

Still open in this work:

`forall epsilon>0, exists C_epsilon, forall primitive triples,`
`E <= epsilon*log(R) + C_epsilon`.

A proof would imply abc. On `R<b`, it requires bounding both nonnegative
terms `log(c/R)` and `min(L_c*,L_b*)`. Neither is silently assumed.

The IUT all-place/Ind3/pointed bridge, canonical correlated defect,
compensated packet, Pell first-apparition valuation, Mersenne depth-three
counting, and geometric uniformity gates remain active as in the inspected
ledger. No new unconditional theorem closing one of those gates was obtained.

## 9. Formal and integration boundary

The new Lean draft contains 12 algebraic-core and exact-rational theorems,
with 12 planned axiom queries. It has NOT been compiled. It does not encode
the complete arithmetic optimizer or a proof of abc. It is not imported into
the repository's verified build.

The remote GitHub connection exposed reads but no write/merge action.
The local `git ls-remote` attempt failed to resolve github.com.
No remote write, PR, or merge was performed. Additive source patches and a
combined two-round archive are supplied instead; patch syntax checks are not
full-repository compilation or remote integration.
