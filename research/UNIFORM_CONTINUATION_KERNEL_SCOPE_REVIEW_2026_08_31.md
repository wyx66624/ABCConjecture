# Kernel acceptance and statement-scope review: uniform continuation

Reviewer: ChatGPT, arithmetic-geometry route. Date: 2026-08-31.

Verdict: the final five-module acceptance record passes this review. The
97 public theorems and nine additional proof-bearing declarations match
the actual source declarations, generated audit commands, and 106 distinct
kernel dependency reports. No outstanding correction is required for this
scoped acceptance. This is not an acceptance of a proof or disproof of abc.

Only this new review file was written. The five modules, canonical goal,
central audit, scripts, TeX, PDF, and historical acceptance records were
read without modification. The review independently parses and hashes
the central evidence; it does not rerun or modify the central finalizer.
The reviewer authored the two geometry modules. The separate independent
height-source review by the analytic route is recorded in
research/FREY_ISOGENY_WEIL_HEIGHT_CROSS_REVIEW_2026_08_31.md,
SHA256 698dce0d5f2b941d634cff7f0887163b6f8c4b04c60fe0a60df67f600706fc5b.

## 1. The original target and downstream structure are unchanged

The actual files, not paraphrases of their names, were read.

| File in Lean/IUTThreeClosures | Current SHA256 |
|---|---|
| ABCStatement.lean | 1da397c7959c179809ad091f0bcd619583339cc5100844363a35c25c0f4ee457 |
| NonCircularDownstream.lean | 943718c1cc1107e0c63afbc5087565f41d87e5269100afaa97ab254b8e30dff2 |

Both hashes agree with their entries in all three frozen 705-, 506-, and
447-file manifests. They are not among the remapped mutable documents.

ABCConjecture still quantifies over every positive real epsilon, then one
real additive constant C, then every positive primitive natural-number
triple a+b=c. The right-hand side uses the actual product of distinct
prime divisors of abc. The constant is uniform in the triple, and no
two-prime, fixed-height, finite-family, or chosen-isogeny condition was
inserted into this target.

ABCPoint still carries its three positive natural coordinates, sum
equation, and pairwise coprimality. NonCircularIUTIVBridge still requires
its explicit uniform qEstimate and height/different/conductor comparisons.
Its abc theorem is conditional on an inhabitant of that bridge; none of
the five new modules constructs such an inhabitant. The audit's command
printing ABCConjecture only displays this unchanged definition.

## 2. Exact scope of the 106 audited declarations

The public declaration names were independently extracted after removing
Lean comments, then compared with declarations.json. Their order and
membership exactly match both the generated #check sequence and the
generated #print axioms sequence, with the section-local opened namespaces
resolved to their actual fully qualified names.

| Module | Public theorems | Additional audited declarations | Total |
|---|---:|---:|---:|
| ABCTwoPrimeSupport20260831 | 22 | 0 | 22 |
| TraceCovariantRationalReturn20260831 | 7 | 0 | 7 |
| ABCOddPartFibre20260831 | 18 | 4 | 22 |
| FreyEntireIsogenyArithmetic20260831 | 23 | 5 | 28 |
| FreyIsogenyWeilHeight20260831 | 27 | 0 | 27 |
| Total | 97 | 9 | 106 |

The nine additional declarations are not merely numerical aliases:

- ABCOddPartFibre20260831.parityMap constructs an actual Fin 2 value
  with its bound proof.
- ABCOddPartFibre20260831.fibreFinite proves finiteness through the
  proved injective parity map.
- ABCOddPartFibre20260831.exampleP and exampleQ contain all the proof
  fields of two actual ABCPoint values.
- FreyEntireIsogenyArithmetic20260831.prime3 and prime7 are the proved
  local primality Facts used by the finite-field objects.
- FreyEntireIsogenyArithmetic20260831.familyTriple contains the genuine
  positivity, sum, and coprimality proofs for every natural parameter.
- FreyEntireIsogenyArithmetic20260831.residueCurve_isElliptic and
  familyCurve_isElliptic establish the required actual ellipticity instances.

All nine have their own successful type and dependency reports. In
particular, familyTriple is counted independently of the later theorems
that use it.

The height module also contains three private helpers:
isCoprime_of_residue, rat_den_le_num_natAbs, and corePolynomial_int_cast.
They are read here but are not incorrectly counted among the 97 public
theorems. Each is used in the audited public proof chain. Public endpoint
dependency reports recursively include any axioms used by those helpers.
The five height data definitions contain no proof fields and define
polynomial or reduced-coordinate data, not an alternative height.

This is a complete check of the stated concrete scope. It is not a claim
that a regular expression is a general parser for every possible Lean
declaration form or that all compiler-generated declarations are separately
listed in the number 106.

## 3. Actual objects and retained mathematical hypotheses

### 3.1. Two-prime support

The hypotheses in the final sharp inequality include the actual
primeFactors.card bound for abc, positivity, the sum equation, and
coprimality. The reduction to prime powers is proved from the support
cardinality; it is not a prime-power classification assumption.
The elementary geometric-sum and even-exponent arguments are supplied in
the module and do not import Catalan's theorem or abc.

The proved bound is 2c <= 3 rad(abc) for the complete subclass supported
on at most two primes. The stronger c <= rad(abc) has precisely the two
ordered eight-nine exceptions, whose radical is actually computed.
No claim extends this support bound to arbitrary primitive triples.
The standard single gcd(a,b)=1 formulation is connected to pairwise
coprimality by a proved lemma.

### 3.2. Trace and rational return

The maps are actual K-linear maps, the traces are Algebra.trace, and
the dimensions are Module.finrank. The scalar trace-transport identity
remains a visible hypothesis; it is not an axiom hidden in a new trace
definition. Before equal dimensions are assumed, both actual dimensions
remain in the trace balance.

Cancellation uses characteristic zero, finite-dimensional nontrivial S,
and equality of the two finranks. It does not require a residue prime
to be coprime to that dimension. Determining F(1) and the entire coefficient
line additionally requires one nonzero coefficient-field input with an
explicit coefficient-field return. The valuation conclusion requires
v(c)=0, not just that c is invertible in the field.

The module therefore proves the stated conditional algebraic constraints.
It does not prove the needed trace covariance or return for a particular
Galois/Kummer arrow, does not reconstruct a logarithmic map, and supplies
no global radical estimate.

### 3.3. Labelled odd-part fibres

oddPart is the actual natural-number ordCompl[2]. Fibre is the subtype
of the unchanged ABCPoint with three specified, labelled odd parts.
No finiteness assumption on this subtype is used: the injection into
Fin 2 and then its finiteness are proved. The proof also handles empty
fibres. The bound two is attained by the actual points (4,3,7) and (1,6,7).

This is an arithmetic fibre theorem. It is not a statement that an
unspecified transport preserves those odd parts or that the fibre is
a Galois orbit. It does not supply the missing orbit-membership or
global comparison hypotheses elsewhere in the project.

### 3.4. Actual Frey models and finite-field arithmetic

familyTriple is the genuine primitive family (1,1792n+1,1792n+2).
The four entries of model are actual WeierstrassCurve values, and
familyCurve_eq_canonical connects them to the pre-existing canonical
Frey/quotient equations. The invariant statements refer to their actual
c4 and Delta fields.

The count eight concerns the library's actual point type, including
infinity, through a proved equivalence to the seven affine solutions
plus infinity. The F3 polynomial root exclusion is a separate actual
finite-field theorem. Neither statement is relabelled as the unformalized
Frobenius theorem on torsion.

The discriminant bound applies to the displayed models. No minimal
discriminant definition or identification is introduced here. Likewise,
ModelLabel is explicitly a four-element model enumeration, not an
assertion that Lean has classified the entire rational isogeny class.
The latter classification and the Galois/Frobenius passage remain
the separately reviewed paper arguments with their stated external inputs.

### 3.5. Actual rational Weil heights

The height module starts with these actual curves and expands their real
library j-invariants through WeierstrassCurve.j. It proves the signed
integer fractions, full coprimality, positive denominators, and equality
with Rat.num and Rat.den. The zero-kernel numerator is negative Q^3
when n >= 1; the sign is not discarded before identifying the rational.

The height expressions are Height.mulHeight₁ and Height.logHeight₁.
Their rational numerator/denominator formulas are mathlib theorems.
The existing Heights.normalizedLogHeight divides by the actual field
degree, which is one over Q. The bridge is proved directly, not postulated.
There is no newly invented numerical function standing in for a library
height.

The IsLeast conclusions are attained minima over the actual model
enumeration, and the equality iff theorem proves uniqueness of zeroKernel.
Their value is 3 log(c²-16c+16). Positivity and minimum statements explicitly
require n >= 1; the rational signed-coordinate identities also hold at
n=0 without relying on positivity of Q there. The final strict logarithmic
double bound keeps that same parameter restriction.

No classification axiom turns this enumerated minimum into an entire-class
Lean theorem. No asymptotic radical estimate, bounded-gain limit, or abc
conclusion is being counted as a formal consequence of this module.

## 4. Kernel and source audit results

All five module hashes match declarations.json and the independently
captured eight input hashes in both the final build and final audit run.
Both runs report no inputs changed during execution. The eight inputs
are the five module sources, aggregate import, generated central audit,
and declaration manifest.

Source inspection, including an independent comment-stripped scan,
finds no new axiom declaration, sorry, admit, native_decide, or unsafe
declaration in the five modules. More decisively, the actual transitive
kernel reports contain no sorryAx or nonstandard axiom.

The 106 reports are all distinct, with no missing or unexpected name:

| Actual axiom set | Declarations |
|---|---:|
| propext, Quot.sound, Classical.choice | 92 |
| propext, Quot.sound | 6 |
| propext only | 5 |
| none | 3 |

The zero-axiom declarations are
ABCOddPartFibre20260831.point_eq_of_coordinates, exampleP, and exampleQ.
Thus “standard axioms only” means subsets of the permitted three axioms,
not that every nonempty report contains all three.

The final central audit command exits zero, with no diagnostic lines in
either bare or file-location-prefixed warning/error form. Its log SHA256 is

    1e75122f6e5e228d689551997590995ffbc27053c3e68d9c9add9500378cc925

The final full build exits zero and reports 9135 jobs. Independently
recounting the warning headers gives 265, and their complete multiset is
identical to the frozen previous build's warning multiset. No warning
for the five new modules or their central audit remains. The full build
log SHA256 is

    f70e0bb2cb312e6b4f6ac13a1c78bfb3f65b6ce2db99eaa870ad050b741e80c6

These are distinct scopes: the direct central audit verifies its types
and dependency outputs, while the project build also runs project-enabled
style checks. The earlier two height docstring warnings were fixed only
by comment wrapping; no linter was disabled and no proof was changed.

## 5. Scripts and historical replay

prepare_audit.py generates the scoped type and axiom commands from the
five named modules and the explicit nine-entry supplement. run_check.py
records the real subprocess command, return code, output, pre-run source
hashes, and post-run changed-input check. validate_audit.py checks exact
dependency membership, duplicate reports, allowed axiom sets, source
hashes, required run inputs, and audit success.

verify_proofs_and_history.py additionally resolves the audit print names,
checks the current and older audit scopes, checks broad diagnostic
patterns, and compares build warnings with the old multiset. Its
historical replay checks the fixed manifest hash, exact entry and mapping
counts, repository containment, file existence, and each file digest.

During the preliminary read, the last script still contained the old
9134-job completion string. This was immediately reported to the root.
The root corrected it to 9135 and added the final run-input hash checks
before producing the final JSON reviewed here. The final script has
the correct condition. There is no outstanding acceptance failure from
that superseded intermediate version.

The present review separately re-parsed all four audit logs and compared
every dependency dictionary and output hash with the final JSON:

| Audit | Distinct reports | Exact source/report match | Diagnostics |
|---|---:|---|---:|
| current continuation | 106 | yes | 0 |
| previous Galois lifts | 145 | yes | 0 |
| previous uniform gate | 89 | yes | 0 |
| previous continuation | 43 | yes | 0 |

The review also independently re-hashed every entry in the three frozen
manifests, using the recorded mappings without modifying any old stage:

| Manifest stage | Entries | Mapped paths | Hash mismatches |
|---|---:|---:|---:|
| 2026_08_30_galois_lifts | 705 | 6 | 0 |
| 2026_08_30_uniform_gate | 506 | 6 | 0 |
| 2026_08_30_continuation | 447 | 10 | 0 |

The manifest hashes remain, respectively,

    a05309cddfaa382f90398e4ec17fdddcf4572c93116e420a4658e625987606ce
    c470be98f60af38a31b8a00393d09f276e10d223c197034cfd1a1ee5628afe7a
    dbc5fdc869019dd21fd091e40c32a3d3cf607dcb8feda2819facd529d7e3684a

## 6. Exact reviewed source and acceptance hashes

The five module hashes, in the order of the scope table, are:

    ABCTwoPrimeSupport20260831
    485fe66436f10b944e64ebb5398eb5040a7f4d996d9395a7e52d0bde1f6bed98
    TraceCovariantRationalReturn20260831
    0dd1a8aa6761988e3c1e14829c346d8fdefad242d14bf20422b6010a252eb59a
    ABCOddPartFibre20260831
    af7aab52b80cdbd9a845f6800c804dc32c0d7809cb1b7b42b22a3e51083b2ce8
    FreyEntireIsogenyArithmetic20260831
    d31d9a21e912da6d120280e38a97db82950756fae8e36a8ddbaeff3725fb00fe
    FreyIsogenyWeilHeight20260831
    40421af9b48a4898b6e4982dbf68a0b1bdd17dd7885d8026bcfa734781a06587

The generated ResearchUniformContinuation20260831Audit.lean has SHA256
7d701360ba2b4d70ffda3a144717af8dd4309cbf1241cc5237bc4f9d14725125.
The following files are relative to
Lean/verification/2026_08_31_uniform_continuation:

| File | SHA256 |
|---|---|
| declarations.json | ec34ee58046621b0785217c4c9ca675a596d436bacd48c6fb40c2088fd4ef4b4 |
| audit-run.json | 2014cb5001e9e28c5413cdf014fb28cb0ce8bd7fa793f0d01b458a6f1bf48fea |
| build-run.json | e0b05e51d9261a515158248150b6ff4977f89bf68e3a821add08888404996772 |
| axiom-summary.json | cd6fda7751a8257933371bdf8ef94caac9f60d9921e911168bdc2f314758f923 |
| axiom-dependencies.json | 8cb7061ae42a81ead20f5da3461888b9c95b86494b8e6062be2abd7ed8b21a40 |
| proof-and-history-verification.json | f564af98122f97cdbc26139324774638096cc17bb70964d270fe3c399e871ffb |
| scripts/prepare_audit.py | 095709a17c671a404c8c31261083fb33f2b310c5a215685fa946f71af667d9b8 |
| scripts/run_check.py | 8344679c05c916a16b3f3659f47afc73b89dcfcfbf483f86bf33bfac432e04f2 |
| scripts/validate_audit.py | 24473a2052a666b19861474cb2c3315cdb86b86123d844455777cf57f11dd4c6 |
| scripts/verify_proofs_and_history.py | 982bb9ac42f76b73e2b06c0f6f296f0a1afe37d48e9234537c0ece846b8d9ef7 |

Both final central summary flags are true, and their detailed records
agree with the independent parsing and hashing above. Kernel acceptance
does not discharge a theorem's explicit hypotheses, prove the paper's
external classifications, or provide the still missing uniform abc
comparison. Those boundaries remain intact.
