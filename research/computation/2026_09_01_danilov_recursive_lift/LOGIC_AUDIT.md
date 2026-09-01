# Logic audit of a recursive prime-square lift on the Danilov survivor class

**Date:** 2026-09-01  
**Author:** ChatGPT  
**Status:** independent mathematical audit; no shared report or Lean source was
edited.

## 0. Verdict

The proposed recursive argument has a sound conditional core, but the current
global-index sieve does **not** yet supply its infinitary existence hypothesis.

* A local packet at a state `t = T + Q r` forces a unique residue of `r mod p`
  exactly as expected.  The statement and proof are given in Section 2.
* A nested chain using fresh primes really does constrain one and the same fixed
  hypothetical squarefull index `t`.  Every prime in the chain divides the
  single fixed nonzero integer `L_t`; hence an infinite chain, or arbitrarily
  long finite chains from the same root state, is impossible.  This gives a
  rigorous conditional no-squarefull theorem (Section 3).
* One local packet does not produce the next packet.  There is an explicit
  norm-one quadratic-orbit countermodel satisfying all of the local
  congruence, transfer, and nondegeneracy hypotheses in which the forced next
  state has no fresh eligible prime and a squarefull term survives (Section 4).
* In the actual Danilov orbit the missing existence statement has a sharp
  Fibonacci formulation.  At every recursively relevant state one has
  `3T + 1 = hQ` with `h in {1,2}`.  A fresh simple primitive divisor of
  `F_(10Q)` supplies the next nondegenerate packet.  Carmichael's primitive
  divisor theorem supplies a primitive divisor, but it does not say that its
  valuation is one.  The remaining obstruction is therefore a genuine
  Fibonacci-Wieferich/simple-primitive-divisor problem, not a quantifier trick.

The existing ten packets are completely consistent with this structure: all
ten displayed primes divide `F_9790` exactly once, and their listed roots obey
`3 rho + 1 = 0 mod p`.  After their CRT assembly, the published constants
satisfy `3 T_0 + 1 = 2 Q` exactly.

## 1. Audited scope

The files read were:

* `research/ABC_DANILOV_GLOBAL_INDEX_SIEVE_2026_08_31.md`, SHA-256
  `490abe2f1879433940e8d1ddba7eef44a38cc86135394ca74eb09432b774a444`;
* `Lean/IUTThreeClosures/DanilovGlobalIndexSieve20260831.lean`, SHA-256
  `bf8e3a8208b375a8c9d78322ea5af0810a51af9fed4dbe143641f375683bdb7a`;
* the archived `danilov_global_index_sieve_AUDIT.md`, SHA-256
  `785df1f4ee7c7085968096da4c9ec86b706f21ce1833be418c65b1700ddafbfd`;
* the saved JSON certificate, SHA-256
  `be46476e42272f80948a2c6d23d53ae665cd2105a0c1769f01c6f6717fa07ece`.

The independent standard-library verifier
`verify_fibonacci_structure.py`
recomputes the Fibonacci identities, the 4091-digit factorization check, the
common gcd, the ten exact valuations and root relations, the final invariant,
and the local countermodel.  Its deterministic output is saved as
`fibonacci_structure_output.json`.

The base certificate it consumes is archived beside the verifier as
`danilov_global_index_sieve_certificate.json`; replay therefore does not
depend on an ignored temporary directory.

The current Lean structure `LiftCertificate` is a valid one-level structure,
but it hard-codes the base `326` and step `979`: see fields `alpha_base` and
`eta_step` at source lines 402--406 and theorem `L_cast` at lines 431--433.
Thus the module proves the simultaneous ten-prime refinement of that one
progression.  It does not state an arbitrary-state recursive theorem, and it
does not assert existence of a packet after the final CRT state.  This is the
correct present formalization boundary.

## 2. The general local recursive step

Write

\[
  \mathcal R_m=(\mathbb Z/m\mathbb Z)[s]/(s^2-5),\qquad
  \alpha_t=\alpha_0\eta^t=x_t+y_t s,
  \qquad L_t=2x_t+11.
\]

Suppose `T >= 0`, `Q >= 1`, and `p` is an odd prime.  Assume in
`R_(p^2)` that

\[
 \alpha_T=x+ys,\qquad
 \eta^Q=(1+pe)+pds,\qquad
 L_T=pc.                                                    \tag{2.1}
\]

The hypothesis `eta^Q = 1 mod p` is exactly what permits the second display.
If `N(eta)=1`, then `N(eta^Q)=1` gives

\[
 (1+pe)^2-5p^2d^2=1\pmod {p^2},
\]

so `2e = 0 mod p`.  For odd `p`, one may set `e=0`; this recovers the
special form used in the current Lean certificate.  It is useful to retain
`e` in the general algebraic statement.

Because `(p(e+ds))^2=0 mod p^2`, for every `r >= 0`,

\[
 (\eta^Q)^r=1+rp(e+ds)\pmod {p^2}.
\]

Multiplying by `alpha_T` and taking twice the real coordinate gives

\[
 L_{T+Qr}
   =p(c+ar)\pmod {p^2},
 \qquad
 a=2(ex+5dy)\pmod p.                                      \tag{2.2}
\]

Under norm one, this is `a = 10dy mod p`, exactly the slope in the existing
report and Lean module.

### Local recursive-lift lemma

Assume in addition that

1. `p` does not divide the fixed transfer factors (for Danilov,
   `p` does not divide `3375`);
2. `a != 0 mod p`; and
3. squarefullness of `K_u`, together with `p | L_u`, implies `p^2 | L_u`.

Let

\[
                  \rho=-c a^{-1}\pmod p,
                  \qquad 0\leq\rho<p.                     \tag{2.3}
\]

Then for every `r >= 0`,

\[
 K_{T+Qr}\text{ squarefull}
       \quad\Longrightarrow\quad r=\rho+ps
       \quad\text{for some }s\geq0.                       \tag{2.4}
\]

Consequently

\[
 t=T+Qr
   =\underbrace{(T+Q\rho)}_{T'}
      +\underbrace{(Qp)}_{Q'}s.                            \tag{2.5}
\]

**Proof.**  Formula (2.2) first shows `p | L_(T+Qr)` for every `r`.
The transfer and squarefullness give `p^2 | L_(T+Qr)`.  Cancelling one
factor `p` in (2.2) yields `c+ar=0 mod p`.  Since `a` is a unit, (2.3) is
the unique solution.  The least-residue convention in (2.3) and `r >= 0`
give the nonnegative integer `s` in (2.4), and (2.5) follows.  QED.

This proof uses no finite-search extrapolation.  It is the correct general
version of the specialized theorem `parameter_mod_prime_of_K_twoFull` in the
current Lean file.

## 3. The exact quantifiers needed for an infinitary contradiction

Let a finite chain of states and packets be defined by

\[
 T_{n+1}=T_n+Q_n\rho_n,\qquad Q_{n+1}=Q_np_n,              \tag{3.1}
\]

where the local lemma applies to `(T_n,Q_n,p_n)` and

\[
                 p_n\nmid 3375Q_n.                         \tag{3.2}
\]

Condition (3.2) makes `p_n` fresh: every earlier `p_j` divides `Q_n`, so
the primes in the chain are pairwise distinct.

### Fixed-index chain theorem

Fix one nonnegative integer `t` such that

\[
 t=T_0+Q_0r_0,\qquad K_t\text{ is squarefull}.             \tag{3.3}
\]

For every length-`N` chain satisfying (3.1)--(3.2), there are nonnegative
integers `r_n` with

\[
       t=T_n+Q_nr_n\quad(0\leq n\leq N),                  \tag{3.4}
\]

and

\[
                         p_n\mid L_t\quad(0\leq n<N).      \tag{3.5}
\]

In particular,

\[
                         \prod_{n<N}p_n\mid L_t.            \tag{3.6}
\]

**Proof.**  Induct on `n`.  Given (3.4), apply the local lemma at state
`n` to `r_n`.  It gives `r_n=rho_n+p_n r_(n+1)`, which is exactly (3.4)
at `n+1` after (3.1).  Formula (2.2) also gives (3.5).  Pairwise
coprimality gives (3.6).  QED.

Since the Danilov `L_t` is positive and nonzero, either of the following is
sufficient to exclude (3.3):

* one infinite fresh nested chain; or
* fresh chains of arbitrary finite length starting at the same root state.

For the second formulation, choose a length larger than the number of
distinct prime divisors of the fixed integer `L_t`; compatibility between
chains of different lengths is not needed.  A uniform extension theorem
"every reachable state has a fresh packet" supplies arbitrary finite chains
by ordinary finite recursion (and an infinite chain by dependent choice).

The invalid weaker quantifier patterns are:

* a packet exists at each of infinitely many unrelated progressions;
* for each prime there is some base state on which it gives a packet;
* there are infinitely many one-step experiments, without nesting their
  updated `(T,Q)` states; or
* a prime can be reused after it already divides `Q`, without a higher-order
  valuation theorem.

None of these says that all displayed primes divide one fixed `L_t`.
Correct nesting does say so; the logical gap is existence of fresh packets,
not simultaneous applicability once nesting has been established.

## 4. Explicit countermodel: a valid packet need not have a successor

This example refutes any attempt to infer recursive continuation from the
local hypotheses alone.  It deliberately keeps the same quadratic algebra,
a norm-one positive step, the affine remainder `2 re(alpha)+11`, and the exact
squarefull transfer.

In `Z[sqrt(5)]`, put

\[
 u=9+4\sqrt5,\qquad
 \eta=u^8=5374978561+2403763488\sqrt5,\qquad N(\eta)=1,
\]

and

\[
 \alpha_0=19+\sqrt5,\qquad
 \alpha_r=\alpha_0\eta^r,\qquad
 L_r=K_r=2\operatorname{re}(\alpha_r)+11.
\]

All coefficients, and hence every `K_r`, are positive.  Modulo `7^2`,

\[
        \eta=1+35\sqrt5=1+7\cdot5\sqrt5,
        \qquad L_0=49.                                    \tag{4.1}
\]

At the state `(T,Q,p)=(0,1,7)`, take `d=5`, `y=1`, `c=0`.  The slope is

\[
                 a=10yd=50=1\pmod7,                       \tag{4.2}
\]

so the packet is nondegenerate and its root is `rho=0`.  Directly,

\[
                 L_r=7r\pmod {49}.                         \tag{4.3}
\]

The term `K_0=L_0=49` is squarefull and satisfies the forced residue.
The updated state is `(T',Q')=(0,7)`.  Any fresh next packet would require a
prime `q` with `q | L_0=49` and `q` not dividing `Q'=7`.  No such prime
exists.  Thus the recursion stops while a squarefull term survives.

The initial point in this countermodel does not have norm `-1`; that norm is
not used in the local recursive-lift lemma.  Accordingly, the example does
not refute a Danilov-specific fresh-prime theorem.  It proves that such a
theorem must use additional global structure and cannot be extracted from
the local packet axioms already formalized.

## 5. The Danilov orbit is a Fibonacci orbit

Let

\[
 \varphi={1+\sqrt5\over2},
\]

and write `F_n` and `Lucas_n` for the Fibonacci and Lucas sequences.  Exact
integer arithmetic gives

\[
 \alpha_0=682+305\sqrt5=\varphi^{15},\qquad
 \eta=1730726404001+774004377960\sqrt5=\varphi^{60}.
\]

Hence

\[
                       \alpha_t=\varphi^{15+60t}.           \tag{5.1}
\]

The recursive states relevant here have the invariant

\[
                       3T+1=hQ,\qquad h\in\{1,2\}.          \tag{5.2}
\]

It holds at the first common state because `3*326+1=979`.  It holds at the
published final state with `h=2`, since the exact constants obey

\[
 3\cdot122136955032565025967809449110840347537827+1
 =2\cdot183205432548847538951714173666260521306741.         \tag{5.3}
\]

From (5.1)--(5.2),

\[
             15+60T=20hQ-5.                               \tag{5.4}
\]

This exponent is odd, so `2 z_T = Lucas_(20hQ-5)`.  Using
`Lucas_5=11` and the standard addition formula with
`a=10hQ`, `b=10hQ-5` (which is odd) gives the exact factorization

\[
 \boxed{\quad
 L_T=2z_T+11
     =5F_{10hQ}F_{10hQ-5}.
 \quad}                                                    \tag{5.5}
\]

At `(T,Q,h)=(326,979,1)`, this says

\[
                         L_{326}=5F_{9790}F_{9785}.         \tag{5.6}
\]

An exact big-integer replay verified (5.6); both sides have 4091 decimal
digits.  It also found

\[
 \gcd\bigl(L_{326},\operatorname{im}(\eta^{979}),
                 \operatorname{re}(\eta^{979})-1\bigr)=F_{9790}. \tag{5.7}
\]

Thus the 2046-digit common factor seen by the prime-square sieve has a simple
closed form.

## 6. A positive recursive route via simple primitive Fibonacci divisors

Assume (5.2), and let `p` be an odd prime other than `5` with

\[
                              p\mid F_{10Q}.                \tag{6.1}
\]

The identity

\[
 \varphi^n=F_n\varphi+F_{n-1}
\]

and Cassini's formula show, for the even integer `n=10Q`, that
`varphi^n` is a scalar `s mod p` with `s^2=1`.  Therefore

\[
                         \varphi^{20Q}=1\pmod p.            \tag{6.2}
\]

Equations (5.2)--(5.4) now give

\[
 \alpha_T=\varphi^{-5}(\varphi^{20Q})^h
             =\varphi^{-5}\pmod p,
 \qquad
 \eta^Q=(\varphi^{20Q})^3=1\pmod p.                       \tag{6.3}
\]

Since

\[
                    \varphi^{-5}={-11+5\sqrt5\over2},      \tag{6.4}
\]

equation (6.3) implies `p | L_T`.  Thus every prime divisor of `F_(10Q)`
away from `2,5` satisfies the two mod-`p` conditions required by the local
recursive step.

Suppose more strongly that

\[
                             v_p(F_{10Q})=1,
 \qquad p\notin\{2,3,5\}.                                 \tag{6.5}
\]

Then `F_(20Q)=F_(10Q) Lucas_(10Q)` also has valuation one at `p`, because
`Lucas_(10Q)^2-5F_(10Q)^2=4`.  Cubing from exponent `20Q` to `60Q`
multiplies the first-order term by `3`, so (6.5) implies

\[
 \eta^Q=1+pd\sqrt5\pmod {p^2},\qquad d\ne0\pmod p.         \tag{6.6}
\]

The real first-order term vanishes because `N(eta^Q)=1` and `p` is odd.
The imaginary coordinate of (6.4) is `5/2`, so the local slope is nonzero.

There is also a useful exact description of the forced root.  Put
`zeta=varphi^(20Q)`.  Modulo `p^2`, write
`zeta=1+p d_0 sqrt(5)`, with `d_0 != 0 mod p`.  Then

\[
 \alpha_{T+Qr}=\varphi^{-5}\zeta^{h+3r},
\]

and taking twice the real coordinate yields

\[
 {L_{T+Qr}\over p}=25d_0(h+3r)\pmod p.                    \tag{6.7}
\]

Consequently squarefullness forces

\[
                         h+3r=0\pmod p.                    \tag{6.8}
\]

If `rho` is its least nonnegative solution and

\[
 T'=T+Q\rho,\qquad Q'=Qp,\qquad
 h'={h+3\rho\over p},                                     \tag{6.9}
\]

then `h'` is again in `{1,2}` and `3T'+1=h'Q'`.  More explicitly, a
prime `p=1 mod 3` preserves `h`, while a prime `p=2 mod 3` swaps `1` and
`2`.  This proves that the Fibonacci description is stable under every
nondegenerate recursive lift.

### Conditional no-squarefull theorem

Start from either the state `(326,979,1)` or the current final state
`(T_0,Q,2)`.  Assume that at every state generated by (6.8)--(6.9), the
Fibonacci number `F_(10Q)` has a primitive prime divisor `p` satisfying

\[
                             v_p(F_{10Q})=1.                \tag{SPD}
\]

Then no index in the starting progression has squarefull `K_t`.

**Proof.**  A primitive divisor of `F_(10Q)` is fresh.  In standard
rank-of-apparition language its rank is `10Q` and divides
`p-(5/p)`, so for the present large `Q` it cannot divide `Q`.  Sections 2
and 6 supply a nondegenerate fresh packet and preserve (5.2).  Thus (SPD)
constructs arbitrarily long fresh chains.  The fixed-index chain theorem in
Section 3 gives arbitrarily many distinct prime divisors of the one fixed
nonzero integer `L_t`, a contradiction.  QED.

This is a genuine positive proof route, but it is conditional.  Carmichael's
theorem guarantees a primitive divisor of `F_n` for `n` outside its small
exceptional set; it does not guarantee valuation one.  A primitive divisor
with `p^2 | F_(10Q)` is a Fibonacci-Wieferich/Wall--Sun--Sun-type divisor,
and for it (6.6) degenerates: `eta^Q=1 mod p^2`, so no residue of `r` is
forced.  No theorem in the audited sources excludes the possibility that all
primitive divisors at some recursively generated index have this repeated
valuation.  Replacing (SPD) by Carmichael's theorem would therefore be an
invalid strengthening.

Conversely, a hypothetical squarefull Danilov term forces any indefinitely
attempted simple-primitive recursion eventually to stop at a state where
`F_(10Q)` has no fresh primitive divisor of valuation one.  This is a precise
necessary obstruction and a useful target for both computation and theory.

## 7. Reinterpretation of the existing ten packets

For each prime in the saved certificate, direct fast-doubling computation
gives

\[
       p\mid F_{9790},\qquad p^2\nmid F_{9790}.
\]

The nonzero quotients `F_9790/p mod p` are:

| `p` | `F_9790/p mod p` | `(3 rho + 1)/p` |
|---:|---:|---:|
| 179 | 83 | 2 |
| 199 | 4 | 1 |
| 331 | 315 | 1 |
| 661 | 346 | 1 |
| 1069 | 473 | 1 |
| 9791 | 3803 | 2 |
| 39161 | 23230 | 2 |
| 68531 | 43300 | 2 |
| 474541 | 179674 | 1 |
| 1801361 | 1455823 | 2 |

Thus every packet is a concrete instance of Sections 5--6.  In particular,
the ten roots are not independent numerical accidents: each obeys

\[
                             3\rho+1=0\pmod p.              \tag{7.1}
\]

Combining them by CRT gives the published representative `R`.  The equality

\[
                  3R+1=2M
\]

for the product modulus `M` explains the final invariant `3T_0+1=2Q`.
The ten packets apply simultaneously to the same fixed hypothetical `t`
because they all use the common state `(326,979)`; there is no logical defect
in that part of the current proof.

## 8. Recommended Lean abstraction

The next formal module should parameterize the existing certificate by the
state:

```text
structure RecursiveLiftCertificate (T Q : Nat) where
  p x y c d a rho invA : Nat
  prime       : p.Prime
  fresh       : not (p divides 3375 * Q)
  alpha_base  : alphaMod (p^2) T = (x,y)
  eta_step    : pow (etaMod (p^2)) Q = (1,p*d)
  ...
```

The reusable conclusions should be:

```text
L (T + Q*r) = p*(c+a*r) mod p^2
K (T + Q*r) squarefull -> r = rho mod p
K (T + Q*r) squarefull ->
  exists s, T + Q*r = (T + Q*rho) + (Q*p)*s
```

A separate finite-chain structure should prove that every packet prime
divides the same terminal `L_t` and that their product divides `L_t`.  This
keeps the elementary recursion kernel separate from the paper-only existence
input (SPD), Fibonacci primitive-divisor theory, and any infinitary choice.

One can then formalize the unconditional algebraic identities
`alpha_t=phi^(15+60t)`, (5.5), and the implication

```text
p | F_(10Q) and v_p(F_(10Q)) = 1
  -> exists RecursiveLiftCertificate T Q
```

under `3T+1=hQ`, `h=1 or h=2`.  The universal (SPD) assertion must remain an
explicit hypothesis unless an external theorem proving simple primitive
divisors is supplied.

## 9. Final status

The recursive logic is conditionally correct and does force infinitely many
distinct primes to divide one fixed `L_t` when the packets form a fresh nested
chain.  The current research and Lean artifacts establish only a finite common
batch.  Their surviving class cannot be declared empty.

The sharp next theorem is not merely “a primitive divisor exists.”  It is the
simple primitive divisor condition (SPD) for the adaptive Fibonacci indices
`10Q`, or another theorem that always supplies a fresh nondegenerate divisor.
Until that condition is proved, the Danilov squarefull route remains active.
