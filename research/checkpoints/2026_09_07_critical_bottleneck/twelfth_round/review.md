# Twelfth-round review ledger

MC1--MC4 ordinary proof was fully reviewed by root, adversarial_audit
and independent_route. The lower-cutoff strengthening Y=6n^3 was then
read in full by all three reviewers, with final ordinary PASS.
Reviewed final ordinary source SHA256:
3ec67af4b4b460cdb066228a57bbad044dca40582ae30a9cec9333a1824b4234.

The reviewers explicitly checked both split and inert finite rings,
the torsion reduction at fourth depth, the actual degree-three
determinant bound, positive ordered-pair divisor fibers including
diagonal pairs, and the square-root deep-root bound. The general
delta-window and the two separate exceptional fractions are retained.
The intermediate window has nonpositive signed cost without a
small-full-mass hypothesis. No bound on the larger tail or on all
exceptional roots is claimed.

I independently read rational_biquadratic_locus.md, RL1--RL4, in full:
ordinary PASS. The two rational norm-one parametrizations include
infinity and have the displayed inverses. The finite torsion groups
give exactly the asserted injectivity at odd and coprime-to-six
exponents. The fully projective coordinate pairs have no common
zeros; after base change their function fields match the BK twists.
The positive nonbranch chart and CI supply the actual integer inverse.
The Gaussian equation lifts every positive rational Eisenstein point
uniquely, so it cannot be treated as an additional exclusion of those
points. The single-curve ordered-seed bijection and the separate
larger-even-exponent condition are accurate. This review asserts
neither a point-height bound nor an independent finite replay.

## Independent ordinary reviews completed in this round

UG1--UG3, unramified_gaussian_cover.md, was read in full: PASS.
Reviewed SHA256 a12ddf72265a606842bb1f53dd36a0c582c90a0763ffbcb10f7c8b3961fad12e.
The same eight branch indices give an unramified relative cover of
degree g. The two formulas for W, its defining g-th power, and recovery
of Z are exact. The divisor has exact geometric order g because a
proper order would contradict the proved geometric extension degree.
Its K-rational Jacobian image uses an actual K-divisor; it does not
identify every rational Jacobian point with a rational divisor class.
The group-scheme torsor and the unique positive rational lift have
distinct, correctly stated scopes. I personally opened the Stacks
Riemann--Hurwitz section https://stacks.math.columbia.edu/tag/0C1B and
Milne's https://www.jmilne.org/math/xnotes/JVs.pdf and read the relevant
Theorem 1.1. This review includes ordinary mathematics, not Lean or
independent point computation.

HG1--HG3, hyperelliptic_quotients.md, was read in full: PASS.
The rational inverse, disjoint three branch fibers including infinity,
V4 field degree, and common order-two inertia at poles are correct.
The three genus g-1 quotients give a Q-isogeny by the proved divisor
identity Psi Phi=[2]. The exact odd torsion order survives in the
product; no unsupported single-coordinate claim is made for composite
g. The positive rational domain preserves the ordered seed and common
source coordinate. The displayed genus-two equations are computations
of models, not a computation of ranks or rational points.

PF1--PF4, phase_fiber_structure.md, was read in full: PASS.
Reviewed SHA256 4e5843debc584f7e03f2df5978de77a52bcbf4c2be6123bc95efa94ce6099c9f.
The divisor congruence modulo 3v is necessary and sufficient under the
stated reduced-phase hypothesis. Positive factors and block endpoints
are preserved in both directions. The sum progression has step 3v,
yielding the stated floor bound even for B=1 and diagonal pairs.
Both exact collision examples obey the actual block but do not assert
common deep-prime membership. Several marked primes require the
product image group; the low-denominator remainder is left explicit.

## Frozen phase arithmetic source

DeepRootPhaseArithmetic.lean has fifteen new declarations and was
freshly compiled with twenty-nine imported source declarations under
Lean 4.32.0 and the pinned Mathlib revision. All forty-four axiom
queries were actually executed, including declarations with no axioms.
Only the standard three Lean axioms appear. Source SHA256:
d001e6d61dfa6a9d98cdef75737cac15395033f2fd305ed5134d5326dce4a6c9.
Final author validation SHA256:
38bee4489e359f194e22d1cbd899e116a80ec7ec00392075535c1c13135203d4.
Root and independent_route have separately read all signatures and
proofs with full source/scope PASS. Those source reviews are not
described as extra compiler runs. The finite-ring divisibility input,
torsion count, Brun--Titchmarsh theorem, and asymptotic conclusions are
not hidden in the scope of the fifteen formal statements.

## Final ordinary and transcription approvals

PN1--PN4 received FULL ordinary PASS from root, adversarial_audit and
independent_route. Root and adversarial_audit separately opened the
BMOR primary source. All reviewers checked the half-density estimate,
its endpoint error, private ideal valuations, the fixed-moment
determinant bound, and the complete intermediate/deep layer budget.
The ordinary source is
473ba572cdbf69f74c9e0673762fe37913e3a919c23e9c692870c9da2897daa6.

MC and PN TeX received full final transcription PASS from
adversarial_audit. The subsequent root-build fix replaced legacy cal
with mathcal and inserted a line-break hint in a long module name.
No mathematical statement changed. The current MC TeX hash is
48359c4a0779858092fc89dbe8d08b1962edec2f65e396438f50d5085680b1eb;
the current PN TeX hash is
c1377ebb296ee983e5337da9977ae3fe795a6ffa5525697c5fe5bcd59d309f89.

I read root's ActualDeepRootCount.lean, all six signatures and proofs,
in full: source/scope PASS. Source hash:
06e2e8b5bbc7f0f3906de91964488bc6965a4b7fdb934a05c3b9823df41c9891.
The actual representative supplies unreduced positive u,v; no rational
normalization lemma is missing. The empty fiber, finite envelope at
zero, absolute-value casts, image partition, fourth-power threshold
and real square-root step all match the ordinary proof. I also read
its combined 21-new/29-dependency manifest and matched the source
hashes. This is not an additional compiler run by me.

Root's actual_finite_coherence.tex and twelfth_research_status.tex
were both read in full: final transcription and status-scope PASS.
The finite interface retains its assumptions; no torsion construction
or global bound is claimed among the twenty-one formal statements.
The private-support and quotient-curve status accurately distinguishes
ordinary proofs from finite evidence and formal declarations.

Independent-route final RL TeX was read in full: PASS.
UG TeX was read in full: PASS after specifying that simple zeros are
on the base P1, whereas their pullbacks on D have order g. Its final
hash is 9c54990e807e9086de902cf8b1f51efb49bb535a449e40d15fa4249fdf6b06f6;
the corrected ordinary hash is
61a4e3c9454ba3c2083de779da5f1c01f0995b0fbc72815dfb9a716e47c661e2.
HG TeX was read in full: final mathematical transcription PASS.
Its isogeny, exact odd torsion tuple, infinity and positive-domain
qualifications remain intact. No rank computation is claimed.
Adversarial PF TeX was read in full: final transcription PASS,
including the precise finite replay scope and multiple-mark remainder.

The final MC display was split into two lines to remove an overfull
box; this is a line-break-only change. Both MC and PN TeX also received
independent_route full final transcription PASS.
