# The affine two-arm CRT packet: prescribed repeated-prime mass and an exact insufficiency counterexample

**Author:** ChatGPT  
**Date:** 2026-09-01  
**Scope:** the minimal-step affine shear with `R = rad(abc)`  
**Status:** unconditional elementary theorems and one exact counterexample to a specific strengthening; no proof or disproof of the abc conjecture

## 0. Verdict

Let `a+b=c`, `gcd(a,b)=1`, and

\[
 R=\operatorname{rad}(abc)<c.
\]

The minimal-step affine shear is

\[
 U=1+Rh,\qquad
 V=1+R(h+ck),\qquad
 W=1+R(h+bk).                                      \tag{0.1}
\]

The previous density attack proved that every exponent-`3/4` exception in the
upper-half canonical box must satisfy

\[
 Rc<8192E(V),\qquad Rc<8192E(W),                    \tag{0.2}
\]

where `E(n)=n/rad(n)`.  This continuation proves three new facts.

1.  The two inequalities in (0.2) combine with pairwise coprimality into a
    genuine joint carrier:

    \[
      (Rc)^2<8192^2E(V)E(W),\qquad
      \gcd(E(V),E(W))=1,\qquad E(V)E(W)\mid VW.     \tag{0.3}
    \]

    Thus the repeated-prime mass really occurs in two disjoint prime supports.

2.  The diagonal `h=k` is automatically admissible.  On this diagonal the two
    long arms become

    \[
      V=1+R(c+1)k,\qquad W=1+R(b+1)k.               \tag{0.4}
    \]

    Chinese remaindering prescribes independent square divisors
    `D^2|V` and `F^2|W`.  If `D,F` are squarefree, this forces

    \[
      D\mid E(V),\qquad F\mid E(W).                 \tag{0.5}
    \]

    This supplies an explicit arithmetic-progression packet with simultaneous,
    quantitatively chosen repeated-prime mass.

3.  For the seed `(a,b,c)=(1,242,243)`, `R=66`, the progression

    \[
                         k=h\equiv356\pmod{1225}     \tag{0.6}
    \]

    contains exactly `318,322,715` points in the upper-half canonical box.
    Every one has `5|E(V)` and `7|E(W)`, and hence satisfies both inequalities
    (0.2).  Its first point is nevertheless rigorously nonexceptional.  This is
    a complete counterexample to the natural assertion that the two long-arm
    inequalities are sufficient for an exception.

The affine route remains active.  The counterexample identifies the missing
input: a positive proof must force the **full coupled excess inequality**, not
only its two one-arm consequences.

## 1. Inherited arithmetic

The seed conditions imply

\[
 \gcd(a,c)=\gcd(b,c)=1,
\]

and `2|R`.  Every cofactor in (0.1) is `1 mod R`.  If
`gcd(U,k)=1`, then `U,V,W` are pairwise coprime, are coprime to the seed
product, and

\[
             aU+bV=cW.                                \tag{1.1}
\]

For a positive integer `n`, write

\[
 E(n)=\frac{n}{\operatorname{rad}(n)}.                \tag{1.2}
\]

The canonical scale is

\[
 M=\left\lfloor\frac{c^6}{4R}\right\rfloor,
 \qquad
 I_M=\{\lfloor M/2\rfloor+1,\ldots,M\}.              \tag{1.3}
\]

## 2. The joint two-arm carrier

### Theorem 2.1 (coprime joint excess carrier)

Let `V,W,T,K` be positive integers.  Suppose `gcd(V,W)=1` and

\[
                    T<KE(V),\qquad T<KE(W).            \tag{2.1}
\]

Then

\[
 \gcd(E(V),E(W))=1,\qquad E(V)E(W)\mid VW,             \tag{2.2}
\]

and

\[
                         T^2<K^2E(V)E(W).              \tag{2.3}
\]

#### Proof

Each powerful part divides its integer.  Divisor monotonicity of coprimality
therefore gives `gcd(E(V),E(W))=1`, while multiplication of the two
divisibilities gives `E(V)E(W)|VW`.  Multiplying the two strict positive
inequalities in (2.1) gives

\[
 T^2<K^2E(V)E(W).
\]

This proves all claims. ∎

For an affine exception, take `T=Rc` and `K=8192`.  This gives (0.3).  The
coprimality assertion matters: the lower bound cannot be paid twice by the
same repeated prime.

## 3. Prescribing two squarefree excess carriers

### Lemma 3.1 (a square divisor enters the powerful part)

Let `D,n` be positive integers.  If `D` is squarefree and

\[
                              D^2\mid n,                \tag{3.1}
\]

then

\[
                              D\mid E(n).               \tag{3.2}
\]

#### Proof

It is enough to work prime by prime.  If `p|D`, squarefreeness gives
`v_p(D)=1`; (3.1) gives `v_p(n)>=2`.  Since

\[
 v_p(E(n))=v_p(n)-1
\]

for every prime dividing `n`, we have `v_p(E(n))>=1`.  The distinct primes of
`D` therefore all divide `E(n)`, and their product `D` divides `E(n)`. ∎

### Theorem 3.2 (diagonal two-arm CRT packet)

Let `D,F` be positive, coprime, squarefree integers satisfying

\[
 \gcd(D,R(c+1))=1,\qquad \gcd(F,R(b+1))=1.             \tag{3.3}
\]

Put

\[
                              L=D^2F^2.                 \tag{3.4}
\]

There is a unique residue `k_0 mod L` such that every
`k` with \(k\equiv k_0\pmod L\), and with `h=k`, satisfies

\[
 D^2\mid V,\qquad F^2\mid W,\qquad \gcd(U,k)=1.    \tag{3.5}
\]

Consequently

\[
                         D\mid E(V),\qquad F\mid E(W). \tag{3.6}
\]

#### Proof

On the diagonal `h=k`, (0.1) becomes

\[
 U=1+Rk,\quad V=1+R(c+1)k,\quad W=1+R(b+1)k.       \tag{3.7}
\]

The two coprimality hypotheses in (3.3) make the two coefficients units modulo
`D^2` and `F^2`.  Thus there are unique residues

\[
 \begin{aligned}
 k&\equiv-[R(c+1)]^{-1}\pmod{D^2},\\
 k&\equiv-[R(b+1)]^{-1}\pmod{F^2}.
 \end{aligned}                                         \tag{3.8}
\]

Because `gcd(D^2,F^2)=1`, the Chinese remainder theorem gives a unique
residue `k_0 mod L` satisfying both.  These congruences are exactly the first
two divisibilities in (3.5).  The third follows without any sieve:

\[
                         \gcd(1+Rk,k)=1.                \tag{3.9}
\]

Lemma 3.1 gives (3.6). ∎

This theorem works as well for products of many prescribed primes: the two
squarefree carriers `D` and `F` may each contain an arbitrary finite set of
primes, subject only to (3.3) and disjointness.

## 4. A canonical packet meeting both long-arm gates

Take

\[
 (a,b,c)=(1,242,243),\qquad
 abc=2\cdot3^5\cdot11^2,\qquad R=66.                \tag{4.1}
\]

Then

\[
 M=\left\lfloor\frac{243^6}{4\cdot66}\right\rfloor
   =779890651873,                                      \tag{4.2}
\]

and

\[
 I_M=\{389945325937,\ldots,779890651873\}.             \tag{4.3}
\]

Choose `D=5` and `F=7`.  On `h=k`,

\[
 V=1+16104k,\qquad W=1+16038k.                       \tag{4.4}
\]

The two local conditions are

\[
 k\equiv6\pmod{25},\qquad k\equiv13\pmod{49},         \tag{4.5}
\]

and their CRT combination is

\[
                              k\equiv356\pmod{1225}.   \tag{4.6}
\]

Writing `k=356+1225t`, direct expansion gives

\[
 \begin{aligned}
 V&=25(229321+789096t),\\
 W&=49(116521+400950t).                                \tag{4.7}
 \end{aligned}
\]

The condition `k in I_M` is equivalent to

\[
                 318322715\le t\le636645429.           \tag{4.8}
\]

There are exactly

\[
                636645429-318322715+1=318322715         \tag{4.9}
\]

such diagonal points.  Lemma 3.1 gives `5|E(V)` and `7|E(W)` at every one.
Since `Rc=16038`, all of them obey

\[
 16038<8192\cdot5\le8192E(V),\qquad
 16038<8192\cdot7\le8192E(W).                          \tag{4.10}
\]

This is a large, exact, canonical parameter packet meeting both necessary
long-arm gates.  It shows that simultaneous high excess is arithmetically
constructible; the remaining difficulty lies in reaching the much larger full
product threshold.

## 5. A full counterexample to two-arm sufficiency

Take the first parameter in (4.8):

\[
                  t=318322715,\qquad h=k=389945326231. \tag{5.1}
\]

The cofactors are

\[
 \begin{aligned}
 U&=25736391531247,\\
 V&=6279679533624025,\\
 W&=6253943142092779.                                  \tag{5.2}
 \end{aligned}
\]

Their exact factorizations are

\[
 \begin{aligned}
 U&=17\cdot1513905384191,\\
 V&=5^2\cdot23\cdot37\cdot139267\cdot2119433,\\
 W&=7^2\cdot17431\cdot7322098141.                      \tag{5.3}
 \end{aligned}
\]

All displayed residual factors are prime.  Hence

\[
                    E(U)=1,\quad E(V)=5,\quad E(W)=7.    \tag{5.4}
\]

The affine output is

\[
 \begin{aligned}
 A&=25736391531247,\\
 B&=1519682447137014050,\\
 C&=1519708183528545297,
 \end{aligned}                                         \tag{5.5}
\]

with `A+B=C` and pairwise gcd one.  It lies in the upper-half canonical box,
obeys `U<=c^6`, `V,W<=c^7`, has `C<c^8`, and satisfies both inequalities
(4.10).  Nevertheless its exact output radical is

\[
 \operatorname{rad}(ABC)
 =1905965152082355653156023025952426333444740670,       \tag{5.6}
\]

so

\[
             \operatorname{rad}(ABC)^4>C^3.             \tag{5.7}
\]

For a shorter certificate of (5.7), the squarefree number

\[
 d=139267\cdot2119433\cdot17431=5145057294975341        \tag{5.8}
\]

divides `ABC`, hence divides `rad(ABC)`, and direct integer comparison gives
`d^4>C^3`.

Therefore the following specific strengthening is false:

> Every canonical admissible affine point satisfying both long-arm
> inequalities in (0.2) is exponent-`3/4` exceptional.

The point (5.1)--(5.5) satisfies every hypothesis and negates the conclusion.
This counterexample does **not** refute Theorem 3.1 of the preceding report,
which asserted necessity only.  It also does not refute the affine route.

The numerical reason is exact: `E(U)E(V)E(W)=35`, whereas an exception in this
box would require

\[
                 8192E(U)E(V)E(W)>Rc^{14}.              \tag{5.9}
\]

The two marginal gates lose nearly all of the required product mass.

## 6. Audit of the August 2026 infinite-exception preprint

The latest searched preprint, N. A. Carella,
*Note on the Exceptional Set in the ABC Conjecture*, arXiv:2608.16764v2,
claims infinitely many fixed-epsilon exceptional triples.  If correct, that
would disprove the standard abc conjecture.  Its proof cannot be used in this
repository because a displayed error term is absorbed incorrectly.

In the proof of its Lemma 4.2, the Taylor replacement for the Dickman function
produces the error stated in its equation (4.9):

\[
 O\!\left(\frac{h}{\log y}\frac1{u^6}
                 \sum_{p\le y}\frac{\log p}{p}\right)=O(h). \tag{6.1}
\]

The next displayed formula records this contribution as `O(h rho(u))`.
But in the chosen range the same paper states `rho(u)->0`.  An `O(h)` error
cannot be replaced by `O(h rho(u))` without a new relative estimate.  The
second-moment calculation repeats the same loss.  Consequently the claimed
concentration of low-`omega` smooth values in the short interval, which is
the selection step for its exceptional triples, is not established by the
given argument.

This closes only that derivation.  It is not a counterexample to a corrected
smooth-number construction, so the broad counterexample route remains active.
The original Carella v2 and Jain short-interval source are pinned in
`research/sources/affine_two_arm_crt_2026_09_01/`.

## 7. Exact remaining theorem for a positive affine proof

The present work removes one possible misconception: local CRT compatibility
is not the missing ingredient.  It can create two prescribed square carriers
in a large explicit packet.

The minimal new positive input, within this affine density architecture, can
now be stated without a surrogate gate.  For each fixed `lambda<1`, it must
supply constants `eta>0` and `kappa>0` such that every sufficiently large
primitive seed with `R<c^lambda` has at least

\[
                 \kappa R^{-2/3}c^{4+\eta}               \tag{7.1}
\]

canonical admissible pairs for which the exact pointwise inequality

\[
 E(U)E(V)E(W)>
       \frac{RUVW}{(cW)^{3/4}}
   =\frac{R}{c}\,UV(cW)^{1/4}                            \tag{7.2}
\]

holds.  By the inherited injectivity, these pairs yield the matching lower
bound for distinct exceptional outputs needed by the route.  A theorem
proving only (0.2), or only fixed square divisors in both arms, is insufficient
by Section 5.

Two concrete active targets remain.

1. **Growing-carrier packet:** choose squarefree `D,F` growing with `c` and
   prove that the CRT progression still meets `I_M`, while the residual
   quotients in (4.7) contribute enough additional excess for (7.2) at the
   count in (7.1).
2. **Correlated powerful-value theorem:** obtain a uniform lower bound for
   simultaneous high powerful parts of the two nonparallel forms in (0.1),
   retaining the third factor `E(U)` rather than discarding it by a size cap,
   again with the uniform count in (7.1).

Neither target is abandoned.  No finite no-hit is used as a proof or as a
reason to close either route.

## 8. Formalization and reproducibility map

The mathematical proofs above precede the Lean file

`Lean/IUTThreeClosures/AffineTwoArmCRTPacket20260901.lean`.

The principal declarations are:

- `joint_long_arm_carrier`, formalizing (0.3);
- `squarefree_dvd_powerfulPart_of_square_dvd`, formalizing Lemma 3.1;
- `simultaneous_affine_roots`, `diagonal_crt_packet`, and
  `diagonal_crt_excess_packet`, formalizing the existence, uniqueness, and
  excess conclusions of Theorem 3.2;
- `packet_two_arm_gate`, `packet_in_upper_half_iff`, `packetK_injective`, and
  `canonicalPacket_card`, formalizing both directions of canonical membership
  and the exact distinct-value count in Section 4;
- `counterexample_full_data`, formalizing every seed, canonical-box,
  admissibility, height-cap, two-gate, and nonexceptionality hypothesis needed
  for the insufficiency counterexample.

The selected `#print axioms` checks report only Lean/mathlib's standard
`propext`, `Classical.choice`, and `Quot.sound`; the module contains no `sorry`
and introduces no custom axiom.  Replay it from `Lean/` with

```powershell
lake env lean IUTThreeClosures/AffineTwoArmCRTPacket20260901.lean
```

The exact replay bundle is

`research/computation/2026_09_01_affine_two_arm_crt_packet/`.

It verifies the CRT residue, the complete canonical interval count, every
factorization and primality certificate, both excess gates, the primitive abc
identity, and strict nonexceptionality.  It does not infer any asymptotic
statement from the finite certificate.

On the recorded Windows environment, replay the computation directly with

```powershell
& 'C:\Users\Admin\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe' `
  research/computation/2026_09_01_affine_two_arm_crt_packet/verify_two_arm_packet.py
```

The final line is `captured_output_match=true`.  Exact hashes of the script,
captured output, and reproduction notes are in the bundle's `SHA256SUMS`;
hashes of the pinned source PDFs are in
`research/sources/affine_two_arm_crt_2026_09_01/SHA256SUMS`.
