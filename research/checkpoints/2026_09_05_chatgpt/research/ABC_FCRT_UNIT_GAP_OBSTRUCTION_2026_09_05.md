# Prime-power no-face obstructions and the exact remaining divisor problem

**Author:** ChatGPT  
**Date:** 2026-09-05  
**Base commit:** `6118955d20b4edd32e577e06d1060f3945358dd9`  
**Status:** ordinary proofs and exact finite computation. The Lean companion is
an uncompiled partial draft. No unconditional abc proof or disproof is obtained.

## 1. Exact inherited target and admissibility

Keep the September 4 mathematical FCRT-1 definition unchanged. For a primitive
positive triple `a+b=c`, sources are full prime powers `p^e || c`, `e>=2`,
with integer demand factor `d_p=p^(e-1)`. Sinks are distinct primes dividing
`ab`. A sink packet contains the **entire** power of each selected prime.
For source set `S` and sink set `T`, write

- `D_S = product(d_p, p in S)`;
- `m_S = product(p^e, p in S)`;
- `Q_T = product(q, q in T)`.

An admissible saturated block has nonempty `S,T`, `m_S | a_T+b_T`, and
`D_S <= Q_T`. Selected blocks are source-disjoint and sink-disjoint. An
optional one-hop surplus token targets a residual source `p` only via a
nonempty proper face `U` of its block satisfying `p^e | a_U+b_U`. Its
multiplicative credit is `min(Q_T/D_S,Q_U)`. Unused sinks may have one residual
source owner each. No capacity is counted twice and no overflow is re-emitted.

The target remains the original uniform bound on the optimized logarithmic
boundary, not mere existence of a certificate.

## 2. Concrete arithmetic certificate

For each block let `f_nu=min(Q_T/D_S,Q_U)` if used and `f_nu=1` otherwise.
For each residual source let `K_p` be the product of its owned sink primes and
its incoming `f_nu`. Define

`F = product(max(d_p/K_p,1), p residual)`.

**Proposition.** Every legal arithmetic configuration satisfies
`c <= rad(abc) * F`.

**Proof.** Each residual demand satisfies `d_p <= K_p*max(d_p/K_p,1)`.
Multiply over sources. Disjointness and one-owner conditions give

`product(d_p) <= product(D_S*f_nu) * Q_residual * F <= Q_all * F`.

The first product is `c/rad(c)`, and `rad(c)*Q_all=rad(abc)` by coprimality.
This constructs the endpoint mass bridge rather than assuming it. The
congruence and face premises restrict admissibility; the inequality itself
uses the capacity cap and disjointness. QED.

This is a mathematical concrete-to-accounting construction, not a claim that
all corresponding Lean structures have been connected by compiled code.

## 3. Optimal deletion, with its correct general residue target

Fix `M=p^e`. Let `Phi(T)` be the product of `q^v_q(a)` on the a-arm and
`q^(-v_q(b))` on the b-arm in the unit group modulo M. Compatibility means
`Phi(U)=-1`. Define `z_p(T)` as the smallest `Q_D` among nonempty subsets
`D` of `T` with `Phi(D)=-Phi(T)`, or infinity if none exists.

**Theorem.** A proper compatible face exists exactly when `z_p(T)` is finite.
For fixed block and target, the best credit factor is

`f* = Q_T / max(D_S,z_p(T))`.

**Proof.** For complementary `U,D`, `Phi(U)=-1` is equivalent to
`Phi(D)=-Phi(T)`. A nonempty `D` makes `U` proper. The case `D=T` would imply
`M|2`, impossible since `M>=4`, so U is nonempty. Its radical factor is
`Q_T/Q_D`; minimizing Q_D maximizes the credit. QED.

The deletion is an identity deletion only when `Phi(T)=-1`. Treating every
cross-source block as an identity-deletion problem would be incorrect.
The replay computes the exact minimum nonempty product per residue by a
finite dynamic program and compares the whole table with independent
exhaustive subset enumeration. The manuscript proves its induction invariant.

If `Phi(T)=-1`, every nonempty identity deletion has coprime unequal packet
parts `a_D,b_D` congruent modulo M. Thus `a_D*b_D >= M+1`. With
`E=max(v_q(ab):q in T)` and `V_T=a_T*b_T/Q_T`, this implies
`Q_D^E >= M+1` and `Q_D*V_T >= M+1`. Full surplus reuse therefore needs
`D_S^E >= M+1` and `D_S*V_T >= M+1`. These are necessary, not sufficient.

## 4. Sharp arithmetic absence of proper faces

**Theorem.** Let `p^e || c`, `e>=2`, `M=p^e`. If `c-1=d*u`, `d,u>1`, and
`u=-1 mod M`, then

`c >= M*(2*M-1)`.

In particular this applies to any nonempty proper whole-prime-power packet
of `c-1` compatible with the full source modulus M.

**Proof.** Write `c=M*C`. Exactness of the full prime power gives `p` not
dividing C, hence `C != M`. The congruences `du=-1` and `u=-1 mod M` give
`d=1 mod M`. Write `d=M*t+1`, `u=M*s-1`, with positive integers s,t.
Expansion and cancellation give

`C+t = s*(M*t+1)`.

If `s=t=1`, then `C=M`, excluded. If `t>=2`, then
`C >= (M-1)*t+1 >= 2*M-1`. Otherwise `t=1`, `s>=2`, and
`C >= 2*M+1`. Multiplying by M proves the claim. QED.

**Sharpness.** For `M=2^(2k+1)`, `k>=1`, take `c=M*(2*M-1)`. Then
`c-1=(M-1)*(2*M+1)`, and the factors are coprime because `M=2 mod 3`.
They therefore define actual disjoint whole-prime-power packets. The first
has residue -1. Also `M` is the exact full 2-power in c. The threshold is
attained on infinitely many legitimate examples.

The exact valuation matters: with only `M|c`, the exceptional case `C=M`
cannot be excluded and the same proof gives only the weaker square threshold.

## 5. An infinite no-flag family inside the positive-defect region

Let `c=2^e*3^f`, `e,f>=2`, and suppose

`max(2^e,3^f) < 2*min(2^e,3^f)-1`.

For each of the two source moduli, its complementary factor is below
`2*M-1`. The preceding theorem excludes **every** nonempty proper compatible
packet at both sources. A proper face of a smaller block would still be a
proper face of the full packet. Thus **no configuration has a used flag**.

This is not confined to endpoints with zero scalar defect.

**Infinite-family construction.** The irrational number
`alpha=2*log(3)/log(2)` admits positive integer pairs `(u,v)` with v unbounded
and `u-alpha*v -> 0`, by the elementary fractional-part pigeonhole argument.
Set `e=21*u`, `f=42*v`. Then `2^e/3^f -> 1`, so the balance inequalities
hold eventually. Also `2^21=3^42=1 mod 49`. Hence `49|c-1`, and

`rad(c*(c-1)) = 6*rad(c-1) <= 6*(c-1)/7 < c`.

Select an increasing subsequence to obtain infinitely many distinct primitive
positive-defect endpoints without any proper flag. QED.

**Unbounded absolute defect.** Fix any `k>=2`. Replace 21 and 42 by
`3*7^(k-1)` and `6*7^(k-1)`. Raising a number that is 1 modulo `7^j` to
the seventh power makes it 1 modulo `7^(j+1)`. Thus the same construction
has `7^k|c-1` and

`c/rad(c*(c-1)) > 7^(k-1)/6`.

For each fixed k there are infinitely many such balanced endpoints. Increasing
k shows that their absolute logarithmic defects are unbounded. No lower
bound proportional to `log(rad(abc))` is obtained.

**Exact child retired:** the universal assertion that every positive-defect
two-source endpoint has a proper flag, including its eventual variant and
variants imposing only a large absolute defect. This was a possible
strengthening/shortcut, not a theorem established in the previous ledger.

**Not retired:** the original anchored-prefix theorem with its entropy
premise, FCRT-1, SCRT-0, the parent incidence program, or abc. An unbounded
`c/rad(abc)` is not the fixed-positive-epsilon disproof required for abc.

## 6. Exact divisor-gap successor on this stratum

Put `Q=rad(c-1)`, `A=2^(e-1)`, `B=3^(f-1)` and assume `A*B>Q`.
Every compatible block uses the full sink set. There can be at most one such
block; the two-source block is unsaturated, and a singleton-source block is
no better than assigning all sinks exclusively to that source. Flags are
absent. Therefore

`B_FCRT = B_SCRT = B_PBT`

and their common boundary is

`log min_{H|Q} max(A/H,1)*max(B*H/Q,1)`.

Let `D=log(A*B/Q)>0`. Splitting into the three possible positions of `log H`
relative to the interval proves the exact identity

`B_FCRT = D + min_{H|Q} dist(log H, [log(Q/B),log A])`.

This is a reduction of the full finite optimization on the specified
arithmetic stratum, not only a lower bound. The scalar optimum is attained
exactly when some divisor satisfies `Q/B <= H <= A`.

For squarefree `Q=q_1*...*q_n` with increasing primes, the maximum consecutive
divisor ratio is the classical dense-divisor quantity

`G(Q)=max_j q_j/(q_1*...*q_(j-1))`.

The manuscript proves this elementary special case and obtains

`D <= B_FCRT <= D + (max(log G(Q)-D,0))/2`.

The interval either contains a divisor logarithm, or lies within one divisor
gap; its nearer endpoint is at most half the gap length minus interval length
away. No uniform bound for D or for this special sequence's divisor-gap
penalty has been established.

## 7. Fully checked 25-digit witness: no flags but no loss

For `e=41`, `f=26`,

`c = 5589622068988418728132608`

and

`c-1 = 7^2 * 439 * 857 * 2729 * 292183 * 380261663`.

The six factors are prime by deterministic trial division. Both balance
inequalities hold. Thus no flags exist and `R=6*(c-1)/7<c`.
Nevertheless

`H=2729*380261663=1037734078327 <= 2^40=1099511627776`

and

`Q/H=7*439*857*292183=769481753663 <= 3^25=847288609443`.

The partition reaches the scalar optimum. The common boundary factor is

`931603678164736454688768 / 798517438426916961161801 = c/R`.

This is a direct demonstration that absence of flags does not itself refute
the broader transport route. The large symbolic pair `(e,f)=(399,252)` also
satisfies balance and `49|c-1`, but its 241-digit neighbor was not factored.

## 8. Route state and the outstanding target

The present proofs use no ABC, GRH, disputed IUT comparison, conjectural
prime-producing polynomial, or conjecture about Wieferich primes. IUT,
Pell/Mersenne, compensated packets, and geometric uniformity remain active;
this checkpoint does not close their separate global obligations.

The needed FCRT theorem is still

`for every epsilon>0 there is C_epsilon such that, for every primitive triple,`

`B_FCRT <= epsilon*log(rad(abc)) + C_epsilon`.

On the balanced positive-defect stratum, the new exact formula separates
scalar defect from divisor fragmentation. Both terms are nonnegative, so a
uniform sublinear bound for their sum requires such bounds for both. Merely
putting either missing bound into a Lean hypothesis would not prove it.

## 9. Formal and integration status

Ordinary proofs preceded the partial Lean scripts. No Lean compiler was
available in this execution environment and installation/download attempts
did not yield one. The Lean file is therefore in `Lean/drafts/` and is
explicitly uncompiled. The infinite-family argument, complete owner mapping,
dynamic-program invariant, and complete optimization theorem are not fully
formalized by it. The Python replay does not change that status.

The GitHub connection allowed reads but exposed no write/commit/merge action.
No remote write was made. The additive source patch leaves old status ledgers
and build imports intact. This note and the manuscript are reviewable
research results, not evidence of a completed remote merge or a journal
submission/acceptance.
