# Refined Haar, Farey entropy, affine ownership, polynomial Hensel, and valuation contact

**Author:** ChatGPT
**Date:** 2026-09-02
**Status:** unconditional local theorems, exact obstruction theorems, and
explicit open gates; the standard abc conjecture is neither proved nor
disproved

## 1. Method and retirement rule

This checkpoint advances positive proof construction and counterexample
search at the same time.  A difficult estimate, missing source bridge,
incomplete formalization, or finite search without a hit never retires a
route.  A counterexample retires only an exactly quantified statement after
every one of its hypotheses has been checked.  A witness for a weakened
abstract interface is not silently promoted to a witness for the arithmetic
parent route.

The six continuations treated here are:

1. refined finite-etale Haar normalization and a pointed IUT-facing pilot;
2. Mersenne exact-order Farey denominator entropy;
3. ownership aggregation of maximal affine intersections;
4. polynomial Pell--Lucas Hensel specialization and all-index identities;
5. a divisor-valued Steinberg contact surface and calibrated five-term gate;
6. quadratic Veronese peeling and a prime-valuation layer flag.

All mathematical statements were written with proofs before their Lean
companions.  The formal modules deliberately omit open global inputs.  No
definition contains abc, Szpiro, an IUT comparison theorem, or an equivalent
conclusion as a hidden field.

## 2. Primary-source boundary

The literature cutoff is 2 September 2026.  The source archives accompanying
the route reports contain versioned primary PDFs and checksums.  In
particular, the review uses the current public LANA IUT interface, the recent
Lucas and powerful-value papers of Bates--Jesubalan--Lee--Lu--Shim and Cera da
Conceicao, the Fellini--Murty balancing-Pell proposal, and the arithmetic,
function-field, and entire-curve truncated-counting papers of Pasten,
Gasbarri--Guo--Wang, and Ru--Wang.

These papers live in different settings and none supplies an unconditional
integer proof or disproof of abc.  Published analytic inputs are cited in the
paper at the point of use; they are not represented as Lean theorems.  The
newest source-level IUT implication remains conditional on the comparison
interface whose construction is one of the open gates below.

An additional primary-source audit records three nearby 2025--2026
preprints.  Letendre's short-interval `omega` theorems assume the paper's new
Conjecture 1, which is proposed as stronger than abc.  Zhou's announced
effective inequality invokes the mu-six version of IUT III, Corollary 3.12 in
Proposition 1.9.  Falk--Harrington--Jones give exact generalized
Wieferich/Lucas congruence criteria for monogenic trinomials but no critical
fixed-base counting bound.  Their PDFs, extracted text, metadata, and hashes
are archived in `sources/latest_abc_proposals_2026_09_02/`; none is treated as
an unconditional missing gate.

## 3. Refined tensor Haar normalization

Let `K/Q_p` be a finite local factor with ramification degree `e`, residue
degree `f`, uniformizer `pi`, and residue cardinality `p^f`.  The elementary
local identities are

\[
 p=u\pi^e,\qquad [K:\mathbf Q_p]=ef,
 \qquad \mu(\pi^n\mathcal O_K)=p^{-fn}\mu(\mathcal O_K).
\]

Consequently scalar preimage by `p` changes logarithmic additive Haar volume
by `ef log p`.  If a finite-etale packet has factors of degrees
`n_i=e_i f_i` and total degree `N=sum_i n_i`, product Haar measure has raw
shift `N log p`.  Division by total degree gives exactly `log p`; equivalently
the relative weights `n_i/N` sum to one.

This proves the corrected coefficient inside the finite-etale Haar model.
It does not identify the model with the completed tensor algebra and integral
orders of the source capsule.  Two full-premise examples delimit only bad
normalizations:

- a single quadratic local factor has factor count one but degree two, so
  division by factor count leaves `2 log p`;
- for an unramified quadratic Galois extension,
  `K tensor_Qp K` splits as two factors, so copying parent weight one gives
  total weight two rather than one.

The Lean scalar witnesses are coefficient-level; the quadratic local fields
and tensor decomposition remain paper constructions.  Set-level examples
also refute envelope-only positivity and unpointed pilot comparison.  The
surviving positive gate is an actual pointed inclusion

\[
 P_{\rm pilot}\subseteq\Theta_{\rm out}\subseteq H_{\rm global}
\]

for the same measured object after IPL, SHE, APT, log-Kummer, determinant,
and Ind3 transport.  Haar monotonicity then gives the needed numerical
sandwich.  No example satisfying these full source hypotheses is known, so
the route remains active.

## 4. Mersenne Farey denominator entropy

Write a depth-three exact-order row in its slope coordinates `(q,r)` and
let `H` be the multiplier cutoff.  Splitting denominators at `T` gives the
finite inequality

\[
 E\le {H(H-1)\over2}\sum_{q\le T}{1\over q}
       +{H\over T}N_{>T}.
\]

The proof simply sums `r/q` on each prefix denominator and uses `r/q<H/T`
on the tail.  Exact order makes the row-to-prime map injective, while
`p^3 | 2^d-1` and `d | p-1` transport depth three to the Fermat quotient at
`p`.

Taking `T` to be a small power of `log m`, the inequality proves the following
conditional positive reduction: linear endpoint energy forces a polynomial
swarm of distinct base-two super-Wieferich primes in a short interval.  A
global limsup counting exponent at most one half would therefore imply the
needed `o(log m)` energy estimate.  That global counting theorem is open and
is not a Lean input.

The common-index Farey construction based on `lcm(1,...,n)` has positive
linear energy but deliberately lacks primality, exact order, and depth three.
It is a complete counterexample only to the reduced combinatorial inference
with those three hypotheses deleted.  The exhaustive prime scan through
`10^9` finds only `1093` and `3511`, both at depth two; this finite no-hit is
neither a proof nor a counterexample to the asymptotic gate.

## 5. Affine maximal-intersection ownership

Order labels by divisibility.  Every repeated non-arm large label is dominated
by an exact pairwise gcd top, and a maximal top above it remains on the large
label's unique supporting line.  Distinct maximal supports therefore have
codegree at most one in this restricted catalogue.  If
`S_mu` is the owned mass, `E_mu` its cubic energy, `r_mu` its occupancy, and
`B_mu` its arithmetic budget, then

\[
 S_\mu\le B_\mu,\qquad (r_\mu-1)^3S_\mu\le E_\mu.
\]

Cauchy--Schwarz over maximal owners yields

\[
 S_{\rm non}^2\le E_{\rm non}\mathcal H_3.
\]

The strict non-arm ray bound gives

\[
 E_{\rm non}<KNS_{\rm non}
\]

on a nonempty domain.  Combining the two inequalities is a genuine strict
reduction, while the empty-domain case is kept non-strict.  The canonical
counting theorem uses `C=B+1`; an adversarial example showed that the earlier
weaker hypothesis `B<C` was insufficient, and every affected statement has
been repaired.  This is a premise correction rather than a counterexample to
the ownership route.

Full-premise witnesses retire reversed period monotonicity, unique-top
membership, a false `Q<=2w` estimate, and a pure linear-hypergraph saving.
They leave the parent problem unchanged: prove a canonical low-support
supersaturation or catalogue-sparsity bound strong enough to reverse the
normalized energy inequality.

## 6. Polynomial Pell--Lucas and Hensel displacement

In `Z[T]`, set

\[
 F_{n+2}=TF_{n+1}+F_n,\qquad L_{n+2}=TL_{n+1}+L_n
\]

with `(F_0,F_1)=(0,1)` and `(L_0,L_1)=(2,T)`.  Two-step induction proves

\[
 L_n^2-(T^2+4)F_n^2=4(-1)^n,
 \quad L_n'=nF_n,
 \quad (T^2+4)F_n'=nL_n-TF_n.
\]

For an arbitrary integer polynomial, integral Taylor expansion gives

\[
 f(t+p^eh)\equiv f(t)+p^ehf'(t)\pmod {p^{e+1}}.
\]

If `f(t)=p^e c`, `e>=1`, and `p!=0`, cancellation gives the exact digit law

\[
 p^{e+1}\mid f(t+p^eh)
 \quad\Longleftrightarrow\quad p\mid c+hf'(t).
\]

Coprimality of `f'(t)` and `p` supplies one digit, unique modulo `p`.

The moving parameter `T=282` realizes every premise of the two-channel
moving exclusion:

\[
 F_3(282)=5^2\cdot3181,
\]

\[
 L_3(282)/2=3^2\cdot7^2\cdot47\cdot541,
 \qquad (282^2+4)/4=2\cdot9941,
\]

and

\[
 11213307^2-19882\,79525^2=-1.
\]

The selected simple roots lift simultaneously and the coefficient is
squarefree, but both channels retain exponent-one primes.  This refutes only
the moving claim that the selected repeated carriers cannot coexist; it is
not a fixed-coefficient `D=2` point.  Likewise `F_7(2)=13^2` refutes the
claim that a simple polynomial root forces exponent one after specialization,
but `A_7=239` prevents a squarefull Pell packet.

The all-index identities, arbitrary-polynomial Hensel law, and the complete
`T=282` premise bundle are Lean-checked.  The fixed `D=2` unbounded
squarefull exclusion remains open, and the bounded search through more than
43 million canonical squarefull representations is not extrapolated.

## 7. Divisor contact surfaces and five-term fillings

For a rational coordinate `x`, let

\[
 \Omega(x)=d(x)\wedge d(1-x).
\]

For a primitive abc triple this is the three-leg exterior surface

\[
 (A-C)\wedge(B-C)=A\wedge B+B\wedge C+C\wedge A.
\]

It is the image under `wedge^2 d` of the standard Bloch boundary
`delta([x])=x wedge (1-x)`, before quotienting by Steinberg symbols; it is not
a new nonzero Milnor `K_2` invariant.  Bilinear expansion proves the exact
five-term cancellation.  With logarithmic coefficient weights its full area
`Phi`, radical skeleton `Psi`, and mixed polarization `M` satisfy exact scalar
identities and

\[
 3\Psi\le\rho^2,\qquad
 \Phi\ge H(H-\log2),\qquad M\le2H\rho.
\]

The primitive Pythagorean family

\[
 x=2t+1,\quad y=2t(t+1),\quad z=2t^2+2t+1,
 \quad x^2+y^2=z^2
\]

has radical height at most half full height on every leg and
`Phi/H -> infinity`.  It is therefore a full-premise infinite counterexample
to both single-cell Gates MC and SC.  Lean formalizes their complete uniform
quantifiers and contradictions.  These theorems do not refute abc: they show
that one contact cell cannot be compared sharply enough with its own
coefficient-one truncation.

For each integer leg, the supplemental construction takes the gcd of its
positive prime exponents, builds the canonical primitive base, and proves
the exact coherent/residual height split.  It also realizes divisor contact
surfaces as actual finite-support integer coordinates and proves their
weighted norm formula.  Consequently, for a finite signed chain `Gamma`
carrying the displayed exact integral surface-boundary equality, the weighted
`l1` triangle inequality proves

\[
 \Phi_0\le\tfrac12\{\mathcal Q(\Gamma)+\mathcal R(\Gamma)\}.
\]

Thus the surviving Gate VF consists of exactly two open estimates,

\[
 \mathcal R(\Gamma)\le\epsilon\mathcal Q(\Gamma)+K_\epsilon H,
 \qquad
 \mathcal Q(\Gamma)\le2H\rho+L_\epsilon H.
\]

It remains open to define the inductive relation generated by the permitted
positive rational five-term moves and prove that every generated chain has
this exact boundary equality.  No full-premise counterexample to arbitrary
multi-cell fillings is known.

## 8. Quadratic Veronese peeling and valuation layers

Specializing the five-term relation at `y=x^2` gives, on the exact domain
`x notin {0,1,-1}`,

\[
 \Omega(x^2)=2\Omega(x)-2\Omega\!\left({x\over1+x}\right).
\]

For a primitive positive abc triple `(a,b,c)`, the transformed triple

\[
 (a^2,b(a+c),c^2)
\]

again satisfies every abc premise.  On the consecutive Pythagorean family,
choosing `x=Y/Z` uses `Z-Y=1` and `Y+Z=X^2` to peel

\[
 \Omega(Y^2,X^2,Z^2)
 =2\Omega(Y,1,Z)-2\Omega(Y,Z,X^2).
\]

The positive full area is conserved exactly.  Visible coherent square cost
drops asymptotically to one quarter, but residual cost rises by the exact
missing amount.  The same full-premise family refutes total-area contraction,
the calibrated-boundary estimate for this fixed one-step chain, and a
declared outer-square residual estimate.  It does not refute further
five-term moves or a residual based on maximal exponent extraction.

For a prime-exponent vector `e_p`, define the valuation layers

\[
 R_k=\prod_{e_p\ge k}p.
\]

Then

\[
 \log n=\sum_{k\ge1}\log R_k,
 \qquad \log\operatorname{rad}(n)=\log R_1,
\]

and the full contact area is the exact sum over ordered pairs of layers.
This layer flag retains deep prime-power information that the single scalar
gcd of all exponents can miss.  It is a positive structural refinement, not
yet an estimate proving Gate VF.

## 9. Exact retirement ledger

| Exact statement | Decision | Full-premise reason |
|---|---|---|
| Factor-count Haar normalization and copied parent weights | **REFUTED** | Quadratic local-factor/tensor examples realize the stated weaker models. |
| Refined total-degree Haar and pointed same-pilot route | **OPEN** | Local algebra is proved; source maps and same-object inclusion are not contradicted. |
| Farey injectivity alone implies endpoint little-oh | **REFUTED** | The common-index reduced-slope model satisfies those reduced premises. |
| Arithmetic depth-three Mersenne endpoint | **OPEN** | The model lacks prime, exact-order, and depth premises; finite scans do not decide a limit. |
| Reversed affine period monotonicity and listed owner-free strengthenings | **REFUTED** | Canonical witnesses satisfy their complete local hypotheses. |
| Ownership-preserving affine catalogue aggregation | **OPEN** | The remaining canonical sparsity estimate has no counterexample. |
| Moving-parameter two-channel Pell exclusion | **REFUTED** | `T=282` realizes simple roots, repeated carriers, squarefree coefficient, and the norm identity. |
| Fixed `D=2` Pell squarefull exclusion | **OPEN** | Every known collision fails at least one coordinate squarefull premise. |
| Single-cell contact Gates MC and SC | **REFUTED** | The entire primitive Pythagorean-square family realizes every quantifier and premise. |
| Fixed one-step quadratic peeling policies | **REFUTED** | Exact cost identities give an unbounded violation on the same family. |
| Arbitrary calibrated multi-cell five-term filling | **OPEN** | The automatic inequality is proved for concrete finite-support chains carrying the exact boundary equality; the generated-move boundary theorem and two uniform cost estimates survive. |
| Standard unconditional abc conjecture | **OPEN** | No term of `ABCConjecture`, its negation, or an arithmetic violating family is produced. |

## 10. Formal and reproducibility boundary

The eight checkpoint modules contain 297 theorem declarations, 113
definitions, five abbreviations, four structures, and two named instances,
for 421 counted declarations.  They are compiled directly with warnings
treated as errors.  A generated cross-audit prints dependencies for every one
of the 421 declarations, including definitions, structures, abbreviations,
and instances; the exact union is Mathlib's standard `propext`,
`Classical.choice`, and `Quot.sound`.  No project axiom, admitted proof,
native-decision shortcut, opaque declaration, or unsafe definition is
permitted.  The integrated `IUTThreeClosures` target builds 9,255 jobs.
Computation bundles replay exact finite identities, witness factorizations,
scans, and hashes.  External searches are kept separate from Lean and never
upgraded to asymptotic theorems.  The complete record is
`Lean/verification/2026_09_02_refined_haar_farey_ownership_hensel_contact/`.

The remaining formalization items are recorded rather than hidden: analytic
limits in the Mersenne swarm theorem, the full concrete affine catalogue,
the quadratic local-field realization, source-level IUT transport, and the
inductive rational five-term move relation with its boundary theorem.
Their absence is a work list.  It is not evidence against the corresponding
mathematical route.
