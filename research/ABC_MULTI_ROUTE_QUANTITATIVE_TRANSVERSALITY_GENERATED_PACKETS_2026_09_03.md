# Quantitative Swarms, Fixed Pell Transversality, Generated Five-Term Boundaries, and Synchronized Packets

**Author:** ChatGPT
**Date:** 3 September 2026
**Checkpoint status:** five positive proof advances with adversarial
counterexample boundaries; the standard unconditional abc conjecture remains
unproved and undisproved.

## 1. Research rule and source cutoff

Every route in this checkpoint was run in both directions.  Positive
arguments were written before their Lean implementations.  Counterexamples
retire only the exact statements whose complete hypotheses they satisfy.
Computational difficulty, missing global estimates, formalization cost and a
finite search with no hit do not retire a route.

The public-source audit was refreshed through 3 September 2026.  The newly
archived item is Akilan Sankaran's *Variants on the abc-Conjecture using
Alternative Quality Metrics*, arXiv:2606.08416v1.  Its exact packing identity
is useful, but its alternative-quality divergence is neither a proof nor a
disproof of standard abc.  The audit also isolates two proof-scope cautions:
an invariant-complement lemma is later applied with a varying complement and
growing prime count, and a critical-boundary upper estimate is called exact
without a reverse bound.  Neither issue is imported as a Lean premise.

## 2. Route matrix

| Route | Positive result proved | Exact counterexample boundary | Surviving gate |
|---|---|---|---|
| Mersenne Farey swarm | Harmonic prefix, unconditional lcm scale bracket, cleared and divided finite swarm, failure-of-little-oh quantifiers, actual-row injection into the finite depth-three prime set | Full fibres at `T=1,H=2` attain the prefix coefficient one | Connect the frequent abstract swarm to enough actual prime/exact-order/depth-three rows and prove the critical global super-Wieferich count |
| Alternative quality packing | Exact `q_std=eta*q_DGM` transfer, AM--GM comparison, clustered-log efficiency lower bound | `q_D=n+1`, `eta=1/(n+1)`, `q_std=1` refutes metric-only divergence transfer | Prove a correlated packing estimate on actual primitive abc triples |
| Fixed `T=2` Pell | Prime-index matrix Frobenius congruences and unconditional derivative transversality at every actual support prime; squarefull is equivalent to simultaneous zero first displacement | The actual row `(ell,p,channel)=(7,13,B)` refutes only the ban on every individual zero displacement | Exclude simultaneous zero displacement at all support primes, equivalently exclude squarefull prime-index Pell coordinate products |
| Steinberg five-term | Algebraic and positive-realization-generated submodules lie in the exact boundary kernel and feed the calibrated finite-chain inequality | Every five-term generator has augmentation one, so it is a nonzero free chain with zero boundary; the positive `1/2,1/6` realization gives the same boundary noninjectivity | Construct a positive generated filling for every required target and prove the two Gate VF cost estimates |
| Synchronized divisor packets | Actual finite nonempty packet spectrum, product and sixth-power envelope, positive synchronization index, canonical-orientation rigidity, prime-power channels and an infinite proper exact-gap family | Actual packets refute corner uniqueness, cubic, quartic, product-square and constant-one quintic bounds | Produce a packet with pair-max energy at radical scale for all but finitely many primitive triples |

No row of this table contains `ABCConjecture`, its negation, or a hidden
equivalent assumption.

## 3. Mersenne: finite arithmetic bookkeeping is now explicit

The quantitative module proves

\[
 E_{\le T}\le H^2(1+\log T)
\]

and, from a total lower bound and a prefix budget,

\[
 T(\varepsilon-\kappa)A\le N_{>T}H,
 \qquad
 N_{>T}\ge\frac{T(\varepsilon-\kappa)A}{H}\quad(H>0).
\]

It also proves the exact filter statement

\[
 f\ne o(g)
 \Longleftrightarrow
 \exists\varepsilon>0:\operatorname{Frequently}(\varepsilon g<f)
\]

for nonnegative real sequences.  For actual exact-order endpoint rows, the
prime coordinate is injective and depth three transports to
`p^3 | 2^(p-1)-1`, so every finite packet injects into the literal finite
super-Wieferich set up to `X`.

This closes the harmonic, quantifier and finite row-to-prime seams of M-I1.
It does not prove the required supply of actual rows or their global counting
exponent.  Equality on full abstract fibres refutes only a universal strict
improvement of the prefix coefficient; it leaves the arithmetic route active.

## 4. Alternative qualities: the missing factor is visible

For positive packing efficiency, the exact identity gives

\[
 q_{\rm std}\le B
 \Longleftrightarrow
 q_{\rm DGM}\le B/\eta.
\]

If prime logarithms lie in a fixed-width interval `[L,L+C]`, then

\[
 \eta=G/A\ge L/(L+C),
\]

so a growing number of prime coordinates and one large coordinate do not by
themselves force efficiency to zero.  Conversely, the exact abstract witness
`q_D(n)=n+1`, `eta(n)=1/(n+1)` keeps standard quality identically one while
the alternative quality is unbounded.  This witness is not an integer abc
family.  It deletes the metric-only inference and identifies the positive
arithmetic task: control the product `eta*q_DGM` on actual triples.

## 5. Fixed Pell: P-I1B is split rather than renamed

Let

\[
 (1+\sqrt2)^n=A_n+B_n\sqrt2,
 \qquad
 M=\begin{pmatrix}1&2\\1&1\end{pmatrix}=I+K,
 \qquad K^2=2I.
\]

For a prime `ell=2m+1`, integral matrix Frobenius gives

\[
 A_\ell=1+\ell r_A,
 \qquad
 B_\ell=2^m+\ell r_B.
\]

Thus the index divides neither coordinate.  Coordinate coprimality together
with the polynomial derivative identities makes every actual support prime a
simple root at `T=2`.  The earlier conditional all-support theorem can
therefore be instantiated without a rank-of-apparition assumption:

\[
 A_\ell B_\ell\text{ squarefull}
 \Longleftrightarrow
 \text{all actual support first displacements vanish}.
\]

The transversality half of P-I1B is closed.  The simultaneous vanishing half
is exactly the prime-index squarefull exclusion and remains open.  At index
seven, `B_7=13^2` supplies one genuine zero displacement, but
`A_7=239` has exponent one; hence the row refutes only the stronger
individual-zero ban.

## 6. Steinberg: generated boundary versus filling existence

The five-term module works in the actual finitely supported divisor lattice.
It defines a free symbol chain, its exterior boundary, the submodule spanned
by algebraic five-term generators, and the smaller submodule spanned by
positive rational realizations.  Each generator has zero boundary, so both
spans lie in the kernel.  Generated equivalence therefore preserves boundary
and supplies the exact premise needed by the earlier calibrated finite-chain
inequality.

The common-denominator construction and the odd-denominator subfamily give
actual positive moves, including five distinct cells at
`1/2,1/6,1/3,1/5,3/5`.  The augmentation of every five-term generator is one,
so the generator is not the zero free chain even though its boundary is zero.
This full-premise example retires literal chain cancellation and boundary
injectivity.  It supports the corrected quotient/generated-relation model.

The old S-I4C is now split: generator boundary and chain conversion are
closed; positive rational realization is constructive on large families;
arbitrary-target positive filling existence and both Gate VF analytic costs
remain open and unrefuted.

## 7. Autonomous structure: synchronized divisor packets

For a primitive nonunit triple `a+b=c`, a synchronized packet chooses
positive `x|a`, `y|b`, `z|c`, each greater than one, with

\[
 a\mid|y^2-z^2|,
 \qquad b\mid|x^2-z^2|,
 \qquad c\mid|x^2-y^2|.
\]

The full corner is always a packet.  Every packet has pairwise coprime
coordinates and satisfies

\[
 abc\mid D(Q),
 \qquad abc\le D(Q)\le B(Q)\le T(Q)^6.
\]

The quotient `kappa=D/(abc)` is positive, and `kappa=1` exactly when all three
gaps equal their corresponding arms.  The canonical signs inherited from
`a+b=c` are rigid: only the full corner carries all three.  The explicit
family

\[
 (a,b,c)=\bigl(2t+1,t(3t+2),(t+1)(3t+1)\bigr),
 \qquad Q=(2t+1,t,t+1)
\]

gives infinitely many proper exact-gap packets.

The spectrum is finer than a symmetric prime-log mean.  The triples
`(2,3,5)` and `(3,5,8)` have the same radical and packing efficiency, yet
their packet spectra have different cardinalities.  Actual packet examples
retire several overstrong height estimates, while the proved sixth-power
envelope survives.  The new route remains active at the radical-compression
gate

\[
 B(Q)\le\operatorname{rad}(abc)^{1+\varepsilon}.
\]

## 8. Finite evidence and its limits

The fixed-Pell producer and an independently written matrix verifier check
3,091,963 candidate pairs in the rectangle
`ell<=20000`, `q<=10^7`.  The only repeated support row is `(7,13,B)`;
there is no cubic-depth row or two-channel repeated pair inside the rectangle.
The 789 bounded unresolved indices and every larger prime remain unresolved.

The five-term scan checks all 59,049 small exterior-vector generators,
8,001 positive rational pairs of denominator at most 20, and the
common-denominator family through 100.  Universal boundary claims are proved
in Lean; the scan is a pressure test.

The synchronized-packet computation scans 3,795,230 primitive triples through
`c=5000`, fully enumerates the specified 151,244 packet fibres, and finds
151,711 packets, including 467 proper and 105 exact-gap packets.  The top 20
standard-quality triples in that finite domain have only the full packet.
This is adverse evidence for easy compression, not a counterexample to an
eventual statement.

## 9. Formal and global boundary

The five new modules contain exactly 169 theorem declarations, 79 definitions,
one abbreviation, seven structures and two named instances, for 258 counted
declarations.  They and their independent AxiomAudit companions compile with
warnings treated as errors.  The generated audit issues one `#print axioms`
query for every counted declaration; its dependency union is exactly
`propext`, `Classical.choice` and `Quot.sound`.  The umbrella target completes
9,265 jobs.  Generated declaration audit, aggregate build, evidence replay,
source-cache checks and the paper/PDF seal are recorded in
`../Lean/verification/2026_09_03_quantitative_transversality_generated_packets/`.
The resulting ChatGPT paper is a 237-page A4 PDF of 1,534,968 bytes with SHA256
`02d7e2d53bd77490e6ba0c6352750ec0779f430b6537a5b7ff54c77c4963f335`;
its final compiler log and rendered-page audit both pass.

The global target remains unchanged.  No module assumes abc, Szpiro, a
super-Wieferich density estimate, the fixed-Pell squarefull exclusion, a
positive Steinberg filling theorem, or synchronized radical compression.  A
proof or disproof of standard abc has therefore not been obtained in this
checkpoint, and every surviving parent route remains active.
