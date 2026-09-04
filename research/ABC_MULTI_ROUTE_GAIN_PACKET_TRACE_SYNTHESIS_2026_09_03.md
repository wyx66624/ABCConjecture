# Canonical gain, packet compression, and signed Pell traces

**Author:** ChatGPT  
**Date:** 2026-09-03  
**Status:** three unconditional reductions, exact counterexample boundaries, and
two surviving forward gates; the standard abc conjecture remains unproved and
undisproved

## 1. Scope and retirement rule

This checkpoint advances proof construction and counterexample search in
parallel.  A failed computation, a difficult estimate, or the absence of a
bounded witness does not retire a route.  We retire only an exact statement for
which a counterexample satisfies every premise.  The counterexample then
retires that statement alone.

Three interfaces are combined here:

1. the canonical approximation/power-gain surface for a primitive abc triple;
2. the synchronized divisor-packet envelope and its radical excess; and
3. the signed-trace encoding of the fixed-parameter Pell squarefull gate.

Each displayed theorem below has an ordinary proof in its route report and a
kernel-checked Lean counterpart.  No open gate is installed as an axiom.

## 2. Canonical gain coordinates

Let `a+b=c`, `gcd(a,b)=1`, and `a,b>1`.  Put

\[
 M=abc,\qquad R=\operatorname{rad}(abc),\qquad
 h=\log c,\quad m=\log M,\quad r=\log R.
\]

The canonical approximation and power gains are

\[
 A_{\rm can}=\frac{h}{m},\qquad
 P_{\rm can}=\frac{m}{r}.
\]

### Theorem 2.1 (canonical corridor and factorization)

Every primitive nonunit triple satisfies

\[
 c^2<M<c^3,
 \qquad
 \frac13<A_{\rm can}<\frac12,
 \qquad
 q(a,b,c)=\frac{h}{r}=A_{\rm can}P_{\rm can}.
\]

**Proof.**  Since `a,b<c`, one has `ab<c^2`, hence `M=abc<c^3`.
Also `ab=a(c-a)\ge 2(c-2)>c` for the nonunit primitive range (the two
endpoint cases are immediate), so `M=cab>c^2`.  Positivity of the logarithms
reverses these inequalities into the stated corridor.  The factorization is
the cancellation `(h/m)(m/r)=h/r`.  The Lean proof avoids the informal
endpoint shortcut and derives both product inequalities directly from the
stored primitive-triple hypotheses.

Formal counterpart:
`ABCCanonicalGainSurface20260903.c_sq_lt_canonicalProduct`,
`canonicalProduct_lt_c_cube`,
`one_third_lt_canonicalApproximationGain`,
`canonicalApproximationGain_lt_one_half`, and
`standardQuality_eq_gainProduct`.

Define the power excess and approximation slack

\[
 X=\frac{m-r}{r},\qquad Y=\frac{m-h}{r}.
\]

### Theorem 2.2 (exact defect identity)

\[
 q(a,b,c)=1+X-Y.
\]

Consequently the logarithmic abc bound

\[
 h\le (1+\varepsilon)r+C
\]

is equivalent to

\[
 X-Y\le\varepsilon+\frac{C}{r}.
\]

**Proof.**  Subtract the definitions:
`X-Y=(m-r-m+h)/r=(h-r)/r=q-1`.  Multiplying the second inequality by
the positive number `r` gives the first, and division reverses the same step.

Formal counterpart:
`standardQuality_eq_one_add_powerExcess_sub_slack` and
`logarithmicABC_iff_defectBarrier`.

The finite defect-flag construction is an exact telescoping decomposition of
this same endpoint difference.  Its uniform budget is proved equivalent to
the repository statement `ABCConjecture`; it is not asserted or inhabited.
Thus higher-dimensional bookkeeping becomes useful only when an independent
estimate controls the individual flag costs.

The actual primitive triple `(3,125,128)` has `M=48000`, `R=30`, and
`M>R^3`.  This is a complete counterexample to the universal canonical bound
`P_can<=3`.  It is not an abc counterexample.  The broader gain route remains
active at the exact defect budget.

## 3. Packet compression and the product/height mismatch

For a synchronized packet `Q=(x,y,z)`, let

\[
 B(Q)=\bigl(\max(y,z)\max(x,z)\max(x,y)\bigr)^2.
\]

The earlier packet theorem gives `abc<=B(Q)`.  Put

\[
 E=\frac{abc}{R},
\]

which is an integer because `R|abc`.

### Theorem 3.1 (packet radical-excess obstruction)

For natural numbers `u,v`,

\[
 B(Q)^u\le R^{u+v}
 \quad\Longrightarrow\quad
 E^u\le R^v.
\]

Equivalently, `R^v<E^u` forces `R^(u+v)<B(Q)^u` for every packet `Q`.

**Proof.**  From `abc=RE` and `abc<=B(Q)`,

\[
 R^uE^u=(abc)^u\le B(Q)^u\le R^{u+v} =R^uR^v.
\]

The radical is positive, so cancel `R^u`.  The second assertion is the exact
contrapositive.

Formal counterpart:
`compressionPower_forces_radicalExcessPower` and
`radicalExcessPower_obstructs_compressionPower`.

### Theorem 3.2 (infinite four-thirds counterfamily)

For every `k>=0`, set

\[
 a_k=2^{k+4},\qquad b_k=3,\qquad c_k=a_k+3.
\]

These are distinct primitive nonunit abc triples.  If `R_k` and `E_k` are
their radical and radical excess, then

\[
 R_k<E_k^3.
\]

Hence every synchronized packet over every member of the family satisfies

\[
 R_k^4<B(Q)^3.
\]

**Proof.**  Write `H=2^(k+3)`, so `a_k=2H` and `H>=8`.  Radical
submultiplicativity gives `R_k<=6(2H+3)`.  The identity `R_kE_k=6H(2H+3)`
then gives `H<=E_k`.  Finally

\[
 R_k\le6(2H+3)<64H\le H^3\le E_k^3.
\]

Apply Theorem 3.1 with `(u,v)=(3,1)`.  Injectivity follows from strict
growth of the first coordinate.

Formal counterpart:
`dyadicThree_abcRadical_lt_radicalExcess_cube`,
`dyadicThree_everyPacket_fails_fourThirdCompression`, and
`fourThirdObstructionLocus_infinite`.

This infinite family retires the exact proposal that, for every positive
`epsilon`, almost every primitive triple has a packet with
`B(Q)<=R^(1+epsilon)`: it already fails at `epsilon=1/3`.  It does not retire
the packet construction itself.

### Theorem 3.3 (surviving compensated gate)

If

\[
 B(Q)^u\le (ab)^uR^{u+v},
\]

then

\[
 c^u\le R^{u+v}.
\]

**Proof.**  Raise `abc<=B(Q)` to the `u`th power and combine it with the
hypothesis:

\[
 (ab)^uc^u=(abc)^u\le B(Q)^u\le(ab)^uR^{u+v}.
\]

Since `ab>0`, cancel `(ab)^u`.

Formal counterpart: `compensatedCompression_forces_cPower`.

This shows exactly why the original gate was too strong: it attempted to
compress the full product at the height scale.  The compensated estimate
targets `c`.  Its eventual form has finite failures, but no infinite
complete-premise counterexample is known, so it remains active.

## 4. Signed Pell traces

Define

\[
 (1+\sqrt2)^n=A_n+B_n\sqrt2,
 \qquad Z_n=A_{2n},\qquad U_n=A_nB_n.
\]

At odd `n`, the norm is `A_n^2-2B_n^2=-1`.

### Theorem 4.1 (signed trace-square identities)

For odd `n`,

\[
 Z_n-1=2A_n^2,
 \qquad
 Z_n+1=4B_n^2.
\]

**Proof.**  Multiplication in `Z[sqrt(2)]` gives
`A_(2n)=A_n^2+2B_n^2`.  Substitute `2B_n^2=A_n^2+1` from the odd norm
identity and rearrange.

Formal counterpart: `sqrtTwoOrbit_add`, `sqrtTwoOrbit_double`,
`odd_pellDoubleTrace_sub_one_eq_positive`, and
`odd_pellDoubleTrace_add_one_eq_negative`.

### Theorem 4.2 (exact support-depth doubling)

If an odd prime `p` divides `A_n`, then

\[
 p^4\mid Z_n-1\quad\Longleftrightarrow\quad p^2\mid A_n.
\]

If an odd prime `p` divides `B_n`, then

\[
 p^4\mid Z_n+1\quad\Longleftrightarrow\quad p^2\mid B_n.
\]

Exact coordinate depth two gives exact signed-trace depth four.

**Proof.**  The coefficients `2` and `4` in Theorem 4.1 are units at an odd
prime.  Cancel the relevant coefficient and compare prime valuations of a
square.  If the coordinate valuation is exactly two, its doubled valuation
is four, which also excludes divisibility by `p^5`.

Formal counterpart: `prime_fourth_dvd_positiveTrace_iff_square`,
`prime_fourth_dvd_negativeTrace_iff_square`, and the two
`*_exact_four_of_coordinate_exact_two` theorems.

It follows that the surviving fixed-parameter simultaneous-zero gate is
equivalent, with all support quantifiers preserved, to a signed fourth-power
trace packet on the adjacent factors `Z_ell-1` and `Z_ell+1`.  This is an
exact reformulation rather than a relaxation.

### Theorem 4.3 (projector defect and Newton lift)

Put

\[
 e=2B_n^2=A_n^2+1.
\]

Then

\[
 e^2-e=2U_n^2.
\]

For an integer `d=e^2-e`, define

\[
 N(e,d)=e-(2e-1)d.
\]

Then

\[
 N(e,d)^2-N(e,d)=d^2(4d-3).
\]

Thus the raw projector is sharp only modulo `U_n^2`, while one explicit
correction preserves its two channel residues modulo `U_n^2` and makes it
idempotent modulo `U_n^4`.

**Proof.**  Substitute `e=A_n^2+1=2B_n^2` and expand to obtain the first
identity.  For the second, use `(2e-1)^2=4d+1` and expand the definition of
`N`.  The correction is a multiple of `d=2U_n^2`, and its new defect contains
`d^2=4U_n^4`.

Formal counterpart: `pellChannelProjector_defect`,
`pellChannelProjector_precision_two_sharp`,
`newtonIdempotentCorrection_defect`, and
`pellProjector_newtonCorrection_mod_fourth`.

At `(ell,p)=(7,13)`, `13^2` divides `B_7` but `13^3` does not, and

\[
 A_{14}+1=4\cdot13^4
\]

is not divisible by `13^5`.  This complete counterexample retires the
universal depth-two-to-trace-five promotion.  A second certified collision
`(ell,p)=(773231,1546463)` occurs in the `A` channel and has the same exact
two-to-four boundary.  At index seven the opposite coordinate is the
exponent-one prime `239`, so that row is not squarefull.  The large row
certifies only its displayed `A`-channel collision; squarefullness of the full
coordinate product is unresolved.  The global signed fourth-trace exclusion
therefore remains active.

## 5. Combined route boundary

The three interfaces now meet without a hidden implication.

* The canonical surface identifies the exact target as control of the
  cancellation `X-Y=q-1`.
* The packet obstruction proves that uncorrected product compression cannot
  provide that control: radical excess alone creates infinitely many failures.
* The compensated packet inequality is a valid sufficient height estimate and
  remains unrefuted in eventual form.
* The Pell signed-trace route converts simultaneous squarefullness into an
  adjacent-factor fourth-power packet and supplies one explicit Newton step.
  Its global exclusion or construction remains open.

The next proof attack therefore has two exact forward targets:

1. bound a compensated packet envelope at exponent `1+epsilon`, with a
   constant allowed in the usual abc formulation; or
2. prove that the signed fourth-trace packet cannot occur at an odd prime Pell
   index, or construct an unbounded actual family and propagate it through the
   repository's conditional Pell disproof mechanism.

Counterexample search continues simultaneously against every proposed
strengthening of these targets.  A future hit will retire only the exact
strengthening whose full premises it satisfies.

## 6. Reproducibility

The mathematical details are in:

* `ABC_CANONICAL_GAIN_SURFACE_AND_DEFECT_FLAG_2026_09_03.md`;
* `ABC_SYNCHRONIZED_PACKET_RADICAL_EXCESS_OBSTRUCTION_2026_09_03.md`; and
* `ABC_PELL_SIGNED_TRACE_PROJECTOR_2026_09_03.md`.

Their Lean modules and one-for-one axiom audits are:

* `ABCCanonicalGainSurface20260903(.lean|AxiomAudit.lean)`;
* `SynchronizedPacketRadicalExcessObstruction20260903(.lean|AxiomAudit.lean)`;
  and
* `PellSignedTraceProjector20260903(.lean|AxiomAudit.lean)`.

The computation directories freeze the exact finite searches, independent
replays, source hashes, and claim-boundary checks.  The bounded searches are
evidence only within their recorded domains; no null search is used as a
universal theorem.
