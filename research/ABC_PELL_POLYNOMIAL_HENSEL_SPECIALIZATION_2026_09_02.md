# Transverse Hensel specialization in the balancing Pell--Lucas packet

**Author:** ChatGPT
**Date:** 2026-09-02
**Status:** unconditional polynomial and Hensel identities, an exact
fixed-specialization reformulation of the squarefull gate, a global
moving-parameter counterexample to a stronger exclusion claim, and a
certified finite audit; no proof or disproof of the standard abc conjecture.

## 0. Result and route boundary

Let

\[
 F_0(T)=0,\quad F_1(T)=1,\quad
 F_{n+2}(T)=T F_{n+1}(T)+F_n(T),
\]

and let the companion sequence be

\[
 L_0(T)=2,\quad L_1(T)=T,\quad
 L_{n+2}(T)=T L_{n+1}(T)+L_n(T).
\]

At the fixed parameter `T=2`, these are the two coordinates of

\[
 (1+\sqrt2)^n=A_n+B_n\sqrt2:
 \qquad F_n(2)=B_n,\qquad L_n(2)=2A_n.                 \tag{0.1}
\]

The newest directly relevant primary source proves that, in odd
characteristic `p` not dividing `n`, the corresponding Fibonacci-type and
Lucas-type polynomials are square-free.  That theorem concerns
factor multiplicities in a polynomial ring.  It does not control the
valuation of the integer obtained after specializing `T`.

This report makes the specialization boundary exact.

1. Every support prime of `A_ell B_ell` at an odd prime index is a simple
   polynomial root at `T=2`.  This is proved directly from two derivative
   identities, without importing a discriminant formula.
2. A repeated support prime is therefore a *transverse Hensel coincidence*:
   the fixed integer `2` agrees with the unique lifted root modulo `p^2`.
   Squarefullness is exactly simultaneous zero first-lift displacement at
   every support prime.  A depth-three odd-kernel carrier also has zero
   second-lift displacement.
3. Polynomial square-freeness cannot exclude this coincidence.  The actual
   equality

   \[
   F_7(2)=B_7=169=13^2
   \]

   is a full-premise counterexample: the root is simple modulo `13`, remains
   fixed modulo `13^2`, and exits at the next digit.
4. More generally, simple roots can be steered simultaneously by the
   Chinese remainder theorem.  At index three this gives `T=282` and the
   genuine global negative-Pell point

   \[
   11213307^2-19882\,79525^2=-1,                       \tag{0.2}
   \]

   where `7^2` divides the first coordinate and `5^2` divides the second.
   This refutes the stronger moving-parameter claim that polynomial
   square-freeness plus the global norm identity forbids an opposite-channel
   repeated pair.

The fixed `T=2`, fixed coefficient `2` Pell route is not refuted.  No
counterexample satisfies its complete squarefull-packet premises, so that
route remains active regardless of its difficulty.

## 1. Primary-source audit

Bates--Jesubalan--Lee--Lu--Shim characterize powerful Fibonacci and Horadam
polynomials over finite fields.  For the present normalization, their
square-free input states that `F_n(T)` is square-free over a finite field of
odd characteristic `p` when `p` does not divide `n`; their generalized
Lucas result gives the analogous statement for the companion polynomial.
Their discriminant formulas are supported only at `2`, the index, and the
fixed leading/recurrence coefficients.

Cera da Conceicao develops Lucas sequences over integral domains and proves
polynomial-ring primitive-divisor theorems after correcting a missing
hypothesis in an earlier result.  This reinforces a quantifier point already
critical in the repository: an irreducible primitive polynomial factor does
not automatically become a rational prime of exponent one after evaluating
at an integer.

The source copies, TeX, versions, URLs, imported claims, and SHA-256 hashes
are frozen in

`research/sources/pell_hensel_powerful_polynomial_2026_09_02/`.

We use neither paper as an integer powerful-term classification.  Indeed,
the integer statement remains of abc-level difficulty in the literature,
and the index-seven example below demonstrates why the polynomial theorem
alone cannot settle it.

## 2. Exact differential Lucas identities

Put

\[
 \Delta=T^2+4.
\]

### Theorem 2.1 (polynomial norm and derivative identities)

For every `n>=0`, in `Z[T]` one has

\[
 \boxed{L_n(T)^2-\Delta F_n(T)^2=4(-1)^n,}             \tag{2.1}
\]

\[
 \boxed{L_n'(T)=nF_n(T),}                              \tag{2.2}
\]

and

\[
 \boxed{\Delta F_n'(T)=nL_n(T)-T F_n(T).}             \tag{2.3}
\]

#### Proof

Work temporarily in the quadratic extension of `Q(T)` containing
`sqrt(Delta)`, and write

\[
 \alpha=\frac{T+\sqrt\Delta}{2},\qquad
 \beta =\frac{T-\sqrt\Delta}{2}.
\]

Then `alpha+beta=T`, `alpha beta=-1`, and
`alpha-beta=sqrt(Delta)`.  The recurrences and initial conditions give

\[
 F_n=\frac{\alpha^n-\beta^n}{\alpha-\beta},\qquad
 L_n=\alpha^n+\beta^n.                                 \tag{2.4}
\]

Subtracting the two squares in (2.1) gives
`4(alpha beta)^n=4(-1)^n`.

Differentiation gives

\[
 \alpha'=\frac{\alpha}{\sqrt\Delta},\qquad
 \beta'=-\frac{\beta}{\sqrt\Delta}.
\]

Consequently

\[
 L_n'=n\frac{\alpha^n-\beta^n}{\sqrt\Delta}=nF_n,
\]

which is (2.2).  Differentiating the first expression in (2.4), using
`(sqrt(Delta))'=T/sqrt(Delta)`, gives

\[
 F_n'=\frac{nL_n}{\Delta}-\frac{T F_n}{\Delta},
\]

which is (2.3).  Both sides of all three formulas already belong to
`Z[T]`, so the identities hold there.  □

At `T=2`, equations (0.1), (2.2), and (2.3) become

\[
 L_n'(2)=nB_n,
 \qquad
 4F_n'(2)=nA_n-B_n.                                   \tag{2.5}
\]

### Theorem 2.2 (support transversality at the fixed Pell point)

Let `ell` be an odd prime.

* If an odd prime `p` divides `B_ell`, and `p` does not divide `ell`, then

  \[
  F_\ell(2)\equiv0\pmod p,
  \qquad F_\ell'(2)\not\equiv0\pmod p.                \tag{2.6}
  \]

* If an odd prime `q` divides `A_ell`, and `q` does not divide `ell`, then

  \[
  L_\ell(2)\equiv0\pmod q,
  \qquad L_\ell'(2)\not\equiv0\pmod q.                \tag{2.7}
  \]

For actual support primes at prime index, the inherited rank theorem gives
`p,q>ell`, so the coprimality condition is automatic.

#### Proof

The fixed norm equation is

\[
 A_\ell^2-2B_\ell^2=-1,
 \qquad \gcd(A_\ell,B_\ell)=1.                        \tag{2.8}
\]

If `p` divides `B_ell`, it does not divide `A_ell`.  Formula (2.5) gives

\[
 4F_\ell'(2)\equiv \ell A_\ell\not\equiv0\pmod p.
\]

The factors `4`, `ell`, and `A_ell` are all units modulo `p`, proving
(2.6).  If `q` divides `A_ell`, it does not divide `B_ell`, and

\[
 L_\ell'(2)=\ell B_\ell\not\equiv0\pmod q,
\]

which proves (2.7).  □

Thus a repeated rational factor is never caused by a multiple polynomial
root at the actual support primes.  It is caused by how accurately the fixed
integer `2` approximates a simple `p`-adic root.

## 3. Hensel displacement and exact squarefull reformulation

### Lemma 3.1 (one-digit Taylor--Hensel law)

Let `f` belong to `Z[T]`, let `p` be a prime, let `e>=1`, and suppose
`p^e` divides `f(t)`.  For every integer `h`,

\[
 \frac{f(t+p^e h)}{p^e}
 \equiv \frac{f(t)}{p^e}+h f'(t)\pmod p.              \tag{3.1}
\]

If `p` does not divide `f'(t)`, there is a unique residue `h mod p` for
which `p^(e+1)` divides `f(t+p^e h)`, namely

\[
 \boxed{h\equiv-\frac{f(t)}{p^e}f'(t)^{-1}\pmod p.}  \tag{3.2}
\]

In particular, the old representative `t` itself persists as the lifted
root if and only if `p^(e+1)` already divides `f(t)`.

#### Proof

The integral Taylor expansion has the exact form

\[
 f(t+z)=f(t)+zf'(t)+z^2G(t,z)
\]

for an integral polynomial `G`.  Put `z=p^e h`.  Since `2e>=e+1`, the last
term is divisible by `p^(e+1)`.  Divide the resulting congruence by `p^e`
to get (3.1).  The right side is an affine function of `h` with nonzero
slope modulo `p`, so it has the unique zero (3.2).  Taking `h=0` proves the
last assertion.  □

For a simple support root define its level-`e` Hensel displacement by

\[
 \lambda_{f,p,e}(t)
 =-\frac{f(t)}{p^e}f'(t)^{-1}\pmod p,                 \tag{3.3}
\]

whenever `p^e|f(t)`.

### Theorem 3.2 (fixed-point form of the Pell squarefull packet)

Let `ell` be an odd prime and let `S_A,S_B` be the rational prime supports
of `A_ell,B_ell`.  Then `A_ell B_ell` is squarefull if and only if

\[
 \lambda_{L_\ell,q,1}(2)=0\quad(q\in S_A),
 \qquad
 \lambda_{F_\ell,p,1}(2)=0\quad(p\in S_B).            \tag{3.4}
\]

If a support prime has exponent at least three, its level-two displacement
also vanishes.  Hence the opposite-channel odd-kernel pair forced in the
classes `ell=3,5 mod 8` must satisfy, at the same fixed parameter,

\[
 \lambda_{L_\ell,q,1}(2)=
 \lambda_{L_\ell,q,2}(2)=0,
\]

\[
 \lambda_{F_\ell,r,1}(2)=
 \lambda_{F_\ell,r,2}(2)=0.                            \tag{3.5}
\]

#### Proof

At odd primes, `v_q(L_ell(2))=v_q(A_ell)` because
`L_ell(2)=2A_ell`, while `F_ell(2)=B_ell`.  Theorem 2.2 makes every support
root simple.  Lemma 3.1 at `e=1` says that its displacement vanishes exactly
when the corresponding valuation is at least two.  Requiring this at every
support prime is the definition of squarefullness.  The same argument at
`e=2` proves (3.5).  □

This theorem does not solve the gate.  It replaces the valuation statement
by an adelic fixed-root statement with no loss of information.  A proof now
needs a global theorem showing that `T=2` cannot be the simultaneous fixed
lift in both channels at every support prime.  A moving-parameter Hensel
argument cannot provide that theorem, as the next section proves.

## 4. Simultaneous steering and a global moving-Pell counterexample

### Theorem 4.1 (finite simultaneous Hensel steering)

Let `f_1,...,f_m` be integral polynomials, let `p_1,...,p_m` be distinct
primes, and suppose `p_i|f_i(t_0)` but `p_i` does not divide `f_i'(t_0)`.
Then there is a unique residue class

\[
 t\pmod{\prod_i p_i^2}
\]

such that

\[
 t\equiv t_0\pmod{p_i},\qquad p_i^2\mid f_i(t)
 \quad(1\le i\le m).                                  \tag{4.1}
\]

#### Proof

Lemma 3.1 supplies a unique digit `h_i mod p_i` and hence a unique class

\[
 t\equiv t_0+p_i h_i\pmod{p_i^2}
\]

for each `i`.  The moduli `p_i^2` are pairwise coprime, so the Chinese
remainder theorem gives one and only one class modulo their product.  □

This theorem proves that a finite collection of transverse repeated-factor
requirements is locally abundant when the parameter may move.

### Proposition 4.2 (explicit opposite-channel global point)

At index `ell=3`, take

\[
 F_3(T)=T^2+1,\qquad L_3(T)=T^3+3T.                  \tag{4.2}
\]

At `t_0=2`, the `L`-channel prime `q=7` and the `F`-channel prime `r=5`
are simple roots.  Their unique lifts are

\[
 t\equiv37\pmod{49},
 \qquad t\equiv7\pmod{25}.                            \tag{4.3}
\]

The simultaneous solution is

\[
 \boxed{t=282\pmod{1225}.}                            \tag{4.4}
\]

At the least positive representative,

\[
 F_3(282)=79525=5^2\cdot3181,                         \tag{4.5}
\]

\[
 \frac{L_3(282)}2=11213307
 =3^2\cdot7^2\cdot47\cdot541.                        \tag{4.6}
\]

Moreover `D=(282^2+4)/4=19882=2*9941` is squarefree and

\[
 \boxed{11213307^2-19882\,79525^2=-1.}                \tag{4.7}
\]

#### Proof

At `T=2`,

\[
 L_3(2)=14,\quad L_3'(2)=15,
 \qquad F_3(2)=5,\quad F_3'(2)=4.
\]

The first Hensel digits are

\[
 -\frac{14}{7}\,15^{-1}\equiv5\pmod7,
 \qquad
 -\frac55\,4^{-1}\equiv1\pmod5,
\]

which gives (4.3).  Direct CRT gives (4.4), and direct evaluation and
factorization give (4.5)--(4.6).  Finally specialize (2.1) at odd index
three and divide by four.  Because `T=282` is even, both `L_3(T)/2` and
`(T^2+4)/4` are integers, yielding (4.7).  Trial division through the square
root proves `9941` prime.  □

Consider the precise stronger claim:

> **H-global-move.**  If an odd prime index has opposite-channel simple
> roots at one integral parameter, then no integral parameter in their joint
> residue classes can make both selected primes repeated while retaining the
> global Lucas norm identity with squarefree Pell coefficient.

Proposition 4.2 satisfies every premise and falsifies the conclusion, so
`H-global-move` is retired.  It is not a counterexample to the fixed
balancing-Pell packet: its Pell coefficient is `19882`, not `2`, and both
coordinates in (4.5)--(4.6) still contain exponent-one primes.  The exact
fixed-coefficient route remains active.

## 5. The actual index-seven specialization collision

### Proposition 5.1 (a simple root fixed through exactly two levels)

One has

\[
 F_7(T)=T^6+5T^4+6T^2+1,
\]

\[
 F_7'(T)=6T^5+20T^3+12T.                              \tag{5.1}
\]

At `T=2`,

\[
 F_7(2)=169=13^2,\qquad F_7'(2)=376\equiv-1\pmod{13},\tag{5.2}
\]

and `13^3` does not divide `F_7(2)`.  The next Hensel digit is `1`; more
precisely,

\[
 13^3\mid F_7(2+13^2)=F_7(171),
 \qquad 13^4\nmid F_7(171).                            \tag{5.3}
\]

#### Proof

The polynomial and derivative follow from the recurrence and ordinary
differentiation.  Direct substitution gives `169` and `376`; the latter is
`-1 mod 13`, so the root is simple.  Since `F_7(2)/13^2=1`, formula (3.2)
at level two gives

\[
 h\equiv-1\cdot(-1)^{-1}\equiv1\pmod{13}.
\]

Direct evaluation gives

\[
 F_7(171)=25006385400373,
\]

whose `13`-adic valuation is exactly three.  □

This is a full-premise counterexample to the claim that a square-free
Fibonacci polynomial modulo a support prime must take a value of exponent
one at every integer specialization.  It does not refute the full Pell
packet because `A_7=239` has exponent one.

The three balancing-Wieferich primes in the existing exhaustive scan through
`10^9` have exact depth two.  Their level-two parameter exit digits are:

| prime `p` | rank | channel | level-two exit digit |
|---:|---:|:---:|---:|
| 13 | 7 | `F/B` | 1 |
| 31 | 15 | `L/A` | 8 |
| 1546463 | 773231 | `L/A` | 400849 |

All three digits are nonzero, which is the Hensel form of their exact
depth-two status.  In particular, none supplies a depth-three carrier for a
hypothetical squarefull packet.

### Certified computation 5.2 (complete bounded moving-parameter search at index three)

For every positive even parameter `T=2s` with

\[
 1\le s\le10^7,
\]

the only squarefull value of the entire `F` channel

\[
 F_3(T)=4s^2+1
\]

occurs at `s=341`, or `T=682`.  It is

\[
 F_3(682)=465125=5^3\cdot61^2.                         \tag{5.4}
\]

At that parameter the opposite channel is

\[
 \frac{L_3(682)}2=158608307
 =11\cdot13\cdot31\cdot37\cdot967,                    \tag{5.5}
\]

so it is not squarefull.  The associated global point is

\[
 158608307^2-116282\,465125^2=-1,                      \tag{5.6}
\]

where `116282=2*53*1097` is squarefree.

#### Proof

Every positive squarefull integer has a unique representation

\[
 N=a^2b^3
\]

with `b` squarefree: at a prime of even exponent put the entire half
exponent into `a`, and at a prime of odd exponent at least three put one copy
into `b` and the remaining even exponent into `a`.  Conversely every such
representation is squarefull.  The producer enumerates all squarefree `b`
and every `a` with

\[
 a^2b^3\le4\cdot10^{14}+1.
\]

There are `43,355,470` such representations.  Testing whether
`(a^2b^3-1)/4` is a square in the prescribed interval leaves exactly
`(s,a,b)=(341,61,5)`.  Independent C++ code uses a separate squarefree sieve
and integer-square implementation and obtains the same count and singleton.
Trial division gives (5.5), and direct substitution gives (5.6).  □

This is a reproducible exhaustive computation rather than a theorem whose
entire enumeration is presently replayed by the Lean kernel.  Lean checks the
singleton's displayed identities, factor divisibilities, nonsquarefull
witness, Pell identity, and squarefree coefficient.  The remaining formal
task is to replace the 43-million-case loop by a compact certificate that
Lean can verify without trusting either executable.

This is a rigorous finite exclusion, not an unbounded theorem.  It supplies
a genuine whole-channel squarefull example and simultaneously shows that
one squarefull channel does not force the other.

## 6. Computation and adversarial counterexample audit

The replay bundle is

`research/computation/2026_09_02_pell_hensel_specialization/`.

Its producer and independent verifier use different recurrence engines.
They check:

1. the polynomial recurrences, derivatives, norm identities, and exact
   index-seven valuations;
2. both index-three Hensel digits, CRT congruences, complete displayed
   factorizations, squarefreeness of `D=19882`, and the global negative-Pell
   identity;
3. the level-two exit digits of all three rare depth-two primes from the
   frozen `p<=10^9` scan; and
4. all `43,355,470` canonical powerful representations needed for the
   complete index-three search through `T=20,000,000`, independently replayed
   in C++; and
5. the logical counterexample matrix distinguishing polynomial
   square-freeness, selected repeated carriers, full channel
   squarefullness, fixed coefficient `2`, and an unbounded abc-disproof
   family.

No finite no-hit is interpreted as an asymptotic theorem.  The moving point
is a counterexample only to `H-global-move`.  The index-seven point is a
counterexample only to the specialization claim in Section 5.  Neither
point satisfies the full fixed-Pell squarefull premises.

## 7. Lean boundary

The companion module is

`Lean/IUTThreeClosures/PellPolynomialHenselSpecialization20260902.lean`.

It kernel-checks the exact integer divisibility core of the Taylor--Hensel
law, uniqueness of a Hensel digit under a coprime derivative, the fixed-digit
criterion, transversality consequences from supplied derivative readouts,
the index-three Taylor congruences and CRT data, the numerical global moving
counterexample, and the exact index-seven collision and exit.  It also checks
every displayed identity at the bounded-search singleton, but not the
43-million-case exhaustive loop.  In this original module, the all-index
polynomial recurrences and three identities in Theorem 2.1, full-quantifier
Taylor lemma, all-support squarefull equivalence in Theorem 3.2, general
simultaneous steering theorem, and one bundled `H-global-move` witness were
still paper-level obligations.

The supplemental module
`Lean/IUTThreeClosures/PellPolynomialAllIndexFormalization20260902.lean` now
kernel-checks those exact items: the all-index recurrences and identities,
arbitrary-polynomial Taylor--Hensel law, all-support equivalence under the
displayed scale-unit and transversality hypotheses, finite simultaneous CRT
steering, and a single `HGlobalMoveWitness` structure at `T=282` carrying the
simple-root, repeated-carrier, squarefree-coefficient, primality, and Pell
identity premises.  It still does not establish the actual fixed-`T=2`
all-support transversality/rank input or its simultaneous zero-displacement
exclusion.  The primary-source theorems, the Lucas rank theorem, the unbounded
depth-three exclusion, a fixed-parameter squarefull packet, and abc are not
introduced as axioms.

## 8. Remaining fixed-parameter gate

The smallest surviving target is now:

> Prove that at every odd prime index `ell`, at least one support prime has
> nonzero level-one displacement at `T=2`; equivalently, at least one of
> `A_ell,B_ell` has an exponent-one divisor.  It would suffice more narrowly
> to rule out a simultaneous opposite-channel pair with zero level-one and
> level-two displacement under the full rank, character, factor-quotient,
> all-order-tail, endpoint-curvature, and global negative-Pell constraints.

The first formulation is exactly the nonsquarefullness target, not a solved
restatement.  The second is a sufficient subtarget tailored to the existing
odd-kernel packet.  Theorem 4.1 proves why a local or moving-parameter
argument cannot settle it.  A future proof must use the rigidity of the
single fixed parameter `2`, couple distinct rational primes globally, or
produce a uniform height/radical estimate.  No full-premise counterexample
is known, so this route is retained.

## References

* Graeme Bates, Ryan Jesubalan, Seewoo Lee, Jane Lu, and Hyewon Shim,
  *Powerful Fibonacci polynomials over finite fields*, arXiv:2601.02664v1,
  2026.
* Joaquim Cera Da Conceicao, *Primitive Divisors of Lucas Sequences in
  Polynomial Rings*, arXiv:2410.04957v2, 2025.
* M. Aktaş and M. Ram Murty, *Fundamental units and consecutive squarefull
  numbers*, International Journal of Number Theory 13 (2017), 357--369.
* The fixed-orbit rank, valuation, perfect-power, character, factor-quotient,
  and all-order results are proved and source-audited in the preceding Pell
  reports in this repository.
