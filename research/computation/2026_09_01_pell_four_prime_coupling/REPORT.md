# Second-order and reciprocity coupling for the balancing-Pell four-prime gate

**Date:** 2026-09-01  
**Author:** ChatGPT  
**Scope:** the two Pell channels at odd prime index  
**Status:** unconditional channelwise alternatives, two new packet couplings,
and an exhaustive finite certificate through `10^9`; neither abc nor its
negation is proved here

## 0. Result and claim boundary

Put

\[
u_0=0,\qquad u_1=1,\qquad u_{n+2}=6u_{n+1}-u_n,
\]

and write

\[
(1+\sqrt2)^n=A_n+B_n\sqrt2.
\]

The inherited prime-index theorem says that a squarefull `u_ell`, with
`ell` an odd prime, forces at least two repeated primes in each of the
coprime factors `A_ell,B_ell`, and an odd first-occurrence exponent at least
three in each channel.  This report does not prove that the forced packet is
impossible and does not construct one.  It obtains four narrower advances.

1. The perfect-power inputs give a **pointwise channel escape theorem**:
   except for the explicit `B_7=13^2`, each channel at every odd prime index
   has either an exponent-one prime or an odd-exponent depth-three prime of
   that exact prime rank.  Hence, separately in each channel, either simple
   prime divisors occur at all but finitely many prime indices, or infinitely
   many prime-rank depth-three primes occur in that channel.
2. Applying the repaired Fellini--Murty prime-order argument to the two
   signed bases `alpha` and `-alpha` gives a channel-split global
   alternative.  If there are not infinitely many depth-three rational
   balancing primes, then infinitely many prime indices have a simple
   `A`-channel divisor and infinitely many (not necessarily the same)
   prime indices have a simple `B`-channel divisor.
3. Expanding the complete prime factorizations one order farther gives a
   second-order quotient identity modulo `4 ell^2`.  It strictly refines the
   first-order ledger modulo `ell`.
4. Quadratic reciprocity gives a cross-channel character product involving
   every `A` prime, every `B` prime, and their full valuation vectors.

Two independent exhaustive implementations then test all `50,847,533` odd
primes `q<=10^9`.  The only balancing-Wieferich primes are still

\[
13,\quad31,\quad1546463,
\]

and each has exact depth two.  There is no depth-three hit.  Consequently
each of the two required depth-three primes in any actual squarefull
prime-index packet is greater than `10^9`.  This is a finite lower bound and
is not extrapolated to nonexistence.

## 1. Inherited exact setting

Let

\[
\delta=1+\sqrt2,\qquad \alpha=\delta^2=3+2\sqrt2,
\qquad \gamma=\alpha^2=17+12\sqrt2.
\]

For odd `n`,

\[
A_n^2-2B_n^2=-1,\qquad \gcd(A_n,B_n)=1,
\qquad u_n=A_nB_n,                                      \tag{1.1}
\]

and

\[
\alpha^n-1=2A_n\delta^n,
\qquad \alpha^n+1=2\sqrt2 B_n\delta^n.                 \tag{1.2}
\]

For an odd rational prime `q`, let `z(q)` be its rank in `u_n` and put

\[
e(q)=v_q(u_{z(q)}).
\]

If `ell` is an odd prime and `q|u_ell`, then

\[
z(q)=\ell,\qquad e(q)=v_q(u_\ell).                      \tag{1.3}
\]

The two channels are disjoint.  Their residue classes are

\[
q=1+2\ell k_q\quad(q\mid A_\ell),                       \tag{1.4}
\]

and

\[
r=s_r+2\ell h_r\quad(r\mid B_\ell),\qquad
s_r=\left(\frac2r\right)\in\{1,-1\}.                 \tag{1.5}
\]

Every `B`-channel prime is `1 mod 4`.  We also retain the exact order tower

\[
z(q^j)=z(q)q^{\max(0,j-e(q))}.                          \tag{1.6}
\]

Thus `e(q)>=3` is exactly the failure of order growth from level one through
level three.

## 2. A pointwise channel escape theorem

We first isolate the elementary exponent fact used below.

### Lemma 2.1 (escape from exponents one and two)

Let `N>1` be an integer which is not a perfect power.  Then either some
prime divides `N` to exponent one, or some prime divides `N` to an odd
exponent at least three.  In the latter case, if no exponent is one, `N`
has at least two distinct prime divisors.

**Proof.**  Suppose no prime exponent is one.  Then every positive exponent
is at least two.  If every exponent were even, `N` would be a square and
hence a perfect power.  Thus one exponent is odd, and an odd integer at least
two is at least three.  If only one prime divided `N`, then `N=p^a` would
again be a perfect power. \(\square\)

The inherited theorems of Cohn say that `A_n>1` is never a perfect power.
The inherited Pell perfect-power classification of Ljunggren and Cohn says
the same for `B_n`, apart from `B_7=169=13^2`.

### Theorem 2.2 (pointwise channel escape)

Let `ell` be an odd prime.

* In the `A` channel, either there is a prime `q` with

  \[
  q\parallel A_\ell,
  \]

  or there is a prime `p|A_ell` with

  \[
  z(p)=\ell,\qquad e(p)=v_p(A_\ell)\ge3
  \]

  and `e(p)` odd.  If the first alternative fails, `A_ell` has at least two
  distinct prime divisors.
* If `ell!=7`, the identical alternative holds in the `B` channel.  At
  `ell=7`, the exceptional factor `B_7=13^2` has neither an exponent-one
  divisor nor a depth-three divisor.

**Proof.**  Apply Lemma 2.1 to `A_ell`, and to `B_ell` when `ell!=7`.
Equation (1.3) identifies each displayed factor exponent with its
first-occurrence exponent and gives rank `ell`.  The channel is fixed by the
factor in which the prime occurs.  The exceptional calculation at seven is
exact. \(\square\)

### Corollary 2.3 (cofinite-simple or infinite prime-rank depth three)

For the `A` channel, at least one of the following holds:

1. all but finitely many odd prime indices `ell` admit `q||A_ell`;
2. infinitely many distinct rational primes `p` have odd prime rank
   `z(p)=ell`, lie in the `A` channel at first occurrence, and satisfy
   `e(p)>=3`.

The same assertion holds for the `B` channel.

**Proof.**  Let `E_A` be the set of odd prime indices with no exponent-one
`A` divisor.  If it is finite, conclusion 1 holds.  If it is infinite,
Theorem 2.2 selects a depth-three prime of rank `ell` for every `ell in E_A`.
A rational prime has a unique rank, so different indices give different
selected primes.  The `B` proof is the same after deleting the single index
seven. \(\square\)

### Corollary 2.4 (synchronized cofinite escape under finite depth three)

If only finitely many rational balancing primes `p` satisfy `e(p)>=3`, then,
for all but finitely many odd prime indices `ell`, there are primes

\[
q_A\parallel A_\ell,\qquad q_B\parallel B_\ell.          \tag{2.1}
\]

In particular both simple divisors occur at the same prime index, and
`u_ell` is not squarefull.

**Proof.**  The finite set of depth-three primes has only finitely many
ranks.  Delete those ranks and the exceptional index seven from the odd
prime indices.  At every remaining index, the depth-three branch of each
part of Theorem 2.2 is impossible, so both exponent-one branches hold.
Since the channels are coprime factors of `u_ell`, either displayed prime
already proves that `u_ell` is not squarefull. \(\square\)

This is a pointwise reduction, but not an exclusion.  The second branch is
precisely the difficult prime-rank, channel-controlled depth-three
population which current Wieferich methods do not rule out.

## 3. A second-order quotient ledger

Factor

\[
A_\ell=\prod_{q\mid A_\ell}q^{a_q},\qquad
B_\ell=\prod_{r\mid B_\ell}r^{b_r}.                     \tag{3.1}
\]

Put `s_ell=(2/ell)` and

\[
a=\frac{A_\ell-1}{2\ell},\qquad
b=\frac{s_\ell B_\ell-1}{2\ell}.                       \tag{3.2}
\]

The inherited sign ledger is

\[
\prod_{r\mid B_\ell}s_r^{b_r}=s_\ell.                 \tag{3.3}
\]

Define

\[
K_A=\sum_q a_qk_q,\qquad K_B=\sum_r b_rs_rh_r,          \tag{3.4}
\]

and the quadratic product coefficients

\[
\begin{aligned}
C_A={}&\sum_q {a_q\choose2}k_q^2
      +\sum_{q<q'}a_qa_{q'}k_qk_{q'},\\
C_B={}&\sum_r {b_r\choose2}(s_rh_r)^2
      +\sum_{r<r'}b_rb_{r'}(s_rh_r)(s_{r'}h_{r'}).
\end{aligned}                                           \tag{3.5}
\]

The pair ordering in (3.5) is arbitrary; the sums range over unordered
distinct pairs and hence do not depend on it.

### Theorem 3.1 (second-order two-channel coupling)

The quotient coordinates satisfy

\[
a\equiv K_A+2\ell C_A\pmod {4\ell^2},\qquad
b\equiv K_B+2\ell C_B\pmod {4\ell^2},                  \tag{3.6}
\]

and therefore

\[
\boxed{
K_A-2K_B+\ell(K_A^2-2K_B^2)
       +2\ell(C_A-2C_B)\equiv0\pmod {4\ell^2}.}         \tag{3.7}
\]

**Proof.**  Write `x=2ell`.  For each `A`-channel prime,

\[
(1+xk_q)^{a_q}
\equiv1+a_qxk_q+{a_q\choose2}x^2k_q^2\pmod{x^3}.
\]

Multiplying all factors gives

\[
A_\ell\equiv1+xK_A+x^2C_A\pmod{x^3}.                  \tag{3.8}
\]

For a `B`-channel prime,

\[
r=s_r(1+xs_rh_r).
\]

After multiplying, (3.3) cancels the total sign in `s_ell B_ell` and the
same expansion gives

\[
s_\ell B_\ell\equiv1+xK_B+x^2C_B\pmod{x^3}.            \tag{3.9}
\]

Subtract one and divide the divisibilities in (3.8)--(3.9) by
`x=2ell`.  Since `x^3/x=4ell^2`, this proves (3.6).

The Pell equation and (3.2) give the exact identity

\[
a-2b+\ell(a^2-2b^2)=0.                                  \tag{3.10}
\]

Substitute (3.6).  In the linear terms the error is divisible by
`4ell^2`.  In the quadratic terms, replacing `a,b` by
`K_A+2ell C_A,K_B+2ell C_B`, respectively, and multiplying by `ell`
leaves only `ell(K_A^2-2K_B^2)` modulo `4ell^2`; every cross term has a
factor `4ell^2`.  The remaining linear second-order terms are
`2ell(C_A-2C_B)`.  This proves (3.7). \(\square\)

Reducing (3.7) modulo `ell` recovers the earlier first-order coupling
`K_A=2K_B mod ell`.  Thus (3.7) retains one genuinely new `ell`-adic digit.
It is a necessary constraint on the full packet, not yet a contradiction.

## 4. A cross-channel quadratic reciprocity ledger

### Theorem 4.1 (all-pairs character coupling)

For every odd prime `ell`,

\[
\boxed{
\prod_{q\mid A_\ell}\prod_{r\mid B_\ell}
  \left(\frac qr\right)^{a_qb_r}=s_\ell.}               \tag{4.1}
\]

Because every `B`-channel prime is `1 mod 4`, quadratic reciprocity also
permits every symbol in (4.1) to be written `(r/q)`.

If `u_ell` is squarefull, let

\[
O_A=\{q\mid A_\ell:a_q\text{ is odd}\},\qquad
O_B=\{r\mid B_\ell:b_r\text{ is odd}\}.
\]

Both sets are nonempty, every member has exponent at least three, and

\[
\boxed{
\prod_{q\in O_A}\prod_{r\in O_B}\left(\frac qr\right)
=s_\ell.}                                               \tag{4.2}
\]

**Proof.**  Fix `r|B_ell`.  The Pell equation gives

\[
A_\ell^2\equiv-1\pmod r.
\]

The channel theorem gives `r=1 mod 4`.  Euler's criterion therefore yields

\[
\left(\frac{A_\ell}{r}\right)
=(-1)^{(r-1)/4}
=\left(\frac2r\right)=s_r.                              \tag{4.3}
\]

The last equality is checked in the two possible classes `r=1,5 mod 8`.
Insert the prime factorization of `A_ell` in (4.3), raise the result to
`b_r`, and multiply over all `r|B_ell`.  The right side becomes `s_ell` by
(3.3), and the left side is (4.1).

Only odd products `a_qb_r` contribute to a quadratic character, proving
(4.2).  The nonemptiness of both odd-exponent sets follows from the
perfect-power classifications and Lemma 2.1. \(\square\)

Equation (4.2) is the first constraint here that sees every cross-channel
pair rather than the two factorizations separately.  It does not determine
the individual symbols, so it does not yet exclude a packet.

As a sign and normalization audit independent of the proofs, the artifact
script `verify_coupling_examples.py` computes and completely factors both
channels at every odd prime index through 43.  All thirteen cases satisfy
(3.6), (3.7), and (4.1) exactly; the machine-readable result is
`coupling_examples_verification.json`.  This finite check guards the formulas
against transcription errors and is not used as their proof.

## 5. Splitting the Fellini--Murty alternative by sign

For a prime ideal `mathfrak q` above an odd rational prime, let `f_x` be the
residual order of a unit `x` and let

\[
\Delta_x(\mathfrak q)=v_\mathfrak q(x^{f_x}-1).
\]

### Lemma 5.1 (the two signed bases have balancing depth)

For `x=alpha` and for `x=-alpha`,

\[
\Delta_x(\mathfrak q)=e(q).                              \tag{5.1}
\]

Outside the prime ideals above two, the base-`alpha` and base-`-alpha`
super-Wieferich sets coincide, and either signed base is super-Wieferich at
`mathfrak q` exactly when `e(q)>=3`.

**Proof.**  In both cases `x^2=gamma`.  If `t=f_x(mathfrak q)`, then the
order of `gamma` is `t/gcd(t,2)=z(q)`.  If `t=z(q)`, the other factor of
`x^{2t}-1=(x^t-1)(x^t+1)` is a unit at the odd prime.  If `t=2z(q)`, then
`x^t-1=gamma^{z(q)}-1`.  The source-typed dictionary for `gamma` proves
(5.1) in both cases.

Moreover, `t` divides `N(mathfrak q)-1`, and the quotient is prime to the
residue characteristic `q`, since `N(mathfrak q)-1` itself is prime to `q`.
The local lifting identity therefore gives

\[
v_\mathfrak q\left(x^{N(\mathfrak q)-1}-1\right)
=\Delta_x(\mathfrak q)=e(q).                            \tag{5.2}
\]

For odd residue characteristic, `N(mathfrak q)-1` is even, so

\[
(-\alpha)^{N(\mathfrak q)-1}=\alpha^{N(\mathfrak q)-1}.
\]

The two super-Wieferich congruences are therefore identical. \(\square\)

### Theorem 5.2 (signed-base channel alternative)

At least one of the following holds:

1. infinitely many odd rational primes `q` satisfy `e(q)>=3`;
2. infinitely many odd prime indices `ell` admit an odd prime
   `q||A_ell`, and infinitely many odd prime indices `m` admit an odd prime
   `r||B_m`.

The two infinite index sets in alternative 2 are not asserted to intersect.

**Proof.**  If the common signed-base super-Wieferich set is infinite,
Lemma 5.1 and the at-most-two prime ideals over one rational prime give
alternative 1.

Otherwise apply the repaired prime-order consequence of Fellini--Murty
separately to `alpha` and `-alpha`.  For `alpha` it supplies infinitely many
pairs with odd prime order `ell` and depth one.  Identity (1.2) then places
the corresponding rational prime to exact exponent one in `A_ell`.
For `-alpha`, odd prime order `m` means `alpha^m=-1`; the second identity in
(1.2) places the rational prime to exact exponent one in `B_m`.  The repaired
theorem already proves that infinitely many distinct prime orders occur.
This gives both parts of alternative 2. \(\square\)

The signed argument strengthens the earlier union conclusion to one
infinite simple-divisor set in each channel.  Its failure to synchronize the
two prime index sets is a real remaining quantifier gap.  Infinite subsets of
the primes may be disjoint, so no intersection is inferred from
Fellini--Murty.  Under the stronger hypothesis that the rational depth-three
set is finite, Corollary 2.4 supplies a synchronized cofinite conclusion by
the Pell perfect-power classifications.  That cofinite statement is an
independent elementary deduction and is not attributed to Fellini--Murty.

## 6. Exhaustive depth-three search through one billion

For every odd prime `3<=q<=10^9`, the producer evaluates

\[
u_{q-(2/q)}\pmod {q^2}.                                  \tag{6.1}
\]

The inherited exact valuation formula proves

\[
q^j\mid u_{q-(2/q)}\quad\Longleftrightarrow\quad e(q)\ge j.
                                                                    \tag{6.2}
\]

Thus the scan tests every depth-three rational balancing prime in the
interval, whether or not its rank is prime.

The producer uses a segmented Eratosthenes sieve and Lucas fast doubling.
It enumerates exactly `50,847,533` odd primes and returns three `q^2` hits
and zero `q^3` hits.  A second full pass uses a dense Eratosthenes sieve and
an independently coded binary powering algorithm in

\[
\mathbb Z[T]/(T^2-6T+1),                                 \tag{6.3}
\]

where the coefficient of `T` in `T^n` is `u_n`.  It obtains the identical
prime count and hit list.  Finally an arbitrary-precision Python replay
checks every rare hit modulo `q^3`:

| `q` | canonical index | `u_index mod q^3` | depth |
|---:|---:|---:|:---:|
| 13 | 14 | 507 | exactly 2 |
| 31 | 30 | 1922 | exactly 2 |
| 1546463 | 1546462 | 1164272437426319532 | exactly 2 |

Therefore

\[
e(q)\ge3\quad\Longrightarrow\quad q>10^9              \tag{6.4}
\]

for every rational balancing prime `q`.  In particular, both opposite-
channel depth-three primes forced by a squarefull prime-index packet exceed
`10^9`.  No complete packet satisfying the forced hypotheses was found.
The absence of a hit in a finite interval neither closes the proof route nor
refutes the existence of a full packet.

For clarity, the counterexample search boundary is:

| Forced hypothesis for an actual squarefull prime-index packet | Evidence status |
|---|---|
| `ell` is an odd prime and `A_ell,B_ell` are the actual Pell coordinates | required; no candidate packet was produced |
| at least two distinct support primes occur in each channel | required; none of the three isolated depth-two hits supplies this |
| every support exponent is at least two | required; not established at any candidate index |
| one odd exponent at least three occurs in each channel | required; the exhaustive scan proves that either prime would exceed `10^9` |
| all four selected primes have the same rank `ell` | required; the three finite hits have distinct ranks `7,15,773231` |
| the two channel exponent-vector gcds are one | required by the perfect-power classifications; not instantiated |
| the residue/sign ledgers, (3.7), and (4.2) all hold | required; verified as identities, but not instantiated by a squarefull packet |

Thus none of `13,31,1546463` is a counterexample to the full four-prime
exclusion target.  They close only the already recorded assertions that a
primitive, boundary-class, or prime-rank divisor must be simple.

## 7. Routes audited and the remaining gate

The following mechanisms were pursued but do not currently yield a
contradiction.

* The resultant of `X^ell-1` and `X^ell+1` is supported at two.  This proves
  the expected odd-prime separation of the channels but gives no upper bound
  on valuations at their different prime ideals.
* The norm identities
  `N(alpha^ell-1)=-4A_ell^2` and
  `N(alpha^ell+1)=8B_ell^2` double every rational valuation.  They cannot
  distinguish a simple rational divisor from a repeated one.
* The order tower modulo `q^2,q^3` is exact, but the local unit-group order
  only recovers the residue classes modulo `2ell` or `4ell`; it does not
  couple two different rational primes of the same rank.
* For fixed support, the powerful Pell equation is an `S`-unit or
  Thue--Mahler problem and has finitely many solutions.  In the forced packet
  the support and its largest primes vary with `ell`, so existing fixed-`S`
  bounds are not uniform enough.
* Equations (3.7) and (4.2) add a second quotient digit and all quadratic
  cross characters.  The quotient coordinates and individual cross symbols
  still have enough freedom that no inconsistency has been proved.

None of these broad routes is abandoned: no counterexample satisfies all
hypotheses of the opposite-channel depth-three exclusion statement.  The
remaining sufficient theorem is still

> for no odd prime `ell` do there exist primes `p_A|A_ell` and
> `p_B|B_ell` with `z(p_A)=z(p_B)=ell` and
> `e(p_A),e(p_B)>=3`.

The counterexample direction still requires an actual prime index with two
repeated primes in each channel, an opposite-channel depth-three pair,
gcd-one exponent vectors, the second-order congruence (3.7), and the
reciprocity product (4.2).  One finite packet would not by itself disprove
abc; an unbounded squarefull Pell family would still be required.

## 8. Lean and reproducibility boundary

The independent module

`Lean/IUTThreeClosures/PellFourPrimeCoupling20260901.lean`

kernel-checks the self-contained integer algebra behind the exact Pell
quotient identity, the quadratic truncation of an arbitrary finite product,
the cancellation giving a quotient congruence, and the transfer from the two
second-order channel congruences to (3.7).  It also checks the complete
numerical second-order certificate at `ell=7`.  No literature theorem,
number-field infinitude claim, or abc statement is inserted as an axiom.

The finite computation is frozen in

`research/computation/2026_09_01_pell_four_prime_coupling/`.

Its `REPRODUCE.md` gives the three independent replay commands.  The C++
executables are generated artifacts and are not part of the evidence
manifest.

## References

The exact source copies, hashes, and imported quantifiers are recorded in
the computation directory's `SOURCE_NOTES.md` and in the preceding global
packet bundle.  The inherited sources are Cohn's two perfect-power papers,
Ljunggren's square theorem, Sanna's Lucas valuation theorem, and
Fellini--Murty's 2026 number-field Wieferich theorem.
