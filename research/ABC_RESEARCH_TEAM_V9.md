# ABC Research Team, version 9

**Author and coordinator:** ChatGPT

## 1. Research protocol

The programme seeks either:

1. an unconditional theorem `ABCConjecture` accepted by the Lean kernel with no
   source hypothesis equivalent to the conclusion; or
2. a rigorous disproof: one fixed `epsilon_0>0` and an infinite primitive
   family with

   \[
     c/\operatorname{rad}(abc)^{1+\epsilon_0}\to\infty.
   \]

Every route follows the same order:

1. state the exact mathematical proposition;
2. prove it on paper from earlier established results;
3. test elementary and extreme cases;
4. formalize the proved proposition in Lean;
5. merge only after full-module kernel CI;
6. eliminate a route only after a counterexample, contradiction, or no-go
   theorem for that precise mechanism.

No claim from IUT, ATS, modularity, Arakelov geometry, analytic number theory,
or another external theory is imported merely because it appears as a named
theorem. Its precise hypotheses and numerical normalization must be checked.

## 2. Independent research agents

### Agent A: IUT/ATS numerical-source reconstruction

Goal: prove or refute the normed, weight-preserving Rosetta comparison for the
exact `j^2`-weighted theta locus, then construct the genuine Theorem 3.11
source and IUT IV component formula.

Current decisive tasks:

- same-locus lower and upper estimates;
- cross-norm and Haar-Jacobian preservation;
- procession/local-degree weights;
- genuine different/error bounds.

The route remains active; the version-6 conditional proof has been rejected,
not the possibility of a corrected source theorem.

### Agent B: Legendre parabolic Hodge--Arakelov route

Goal: derive

\[
  Q/6\le(1+o(1))(\log\operatorname{Diff}
    +\log\operatorname{Cond})+O(\log\ell)
\]

from the globally labelled three-cusp variation.

New v9 progress:

- the Hodge norm of the basic Legendre differential has only
  `O(log log c)` archimedean growth;
- every good finite prime has exact integral norm one;
- unspecified metric normalization is a strict no-go: the canonical
  Hodge/Petersson metric and all Jacobians must be fixed.

Remaining concentration: bad finite places, the level prime, and the arithmetic
maximal-slope theorem for the locally canonical monodromy filtrations.

### Agent C: exceptional-set amplification

Goal: combine a power-saving bound for exceptional triples with a concrete
amplifier satisfying

\[
  \beta>\gamma+\kappa\alpha.
\]

New v9 progress:

- the power-difference lift

  \[
    (a,b,c)\mapsto
    \left(a^m,
      b\frac{c^m-a^m}{c-a},
      c^m\right)
  \]

  preserves primitivity and transfers every sufficiently large
  `epsilon`-exception to an explicit smaller positive exponent;
- bounded-degree power-difference lifts have amplification exponent `beta=0`
  and are excluded as a stand-alone power-saving amplifier.

Surviving candidates: parameterized fixed-degree identities, modular/Hurwitz
correspondences, level structures with controlled return to rational triples,
and norm constructions with radical control.

### Agent D: powerful/square/cube-core geometry

Goal: exploit the large square and cube cores forced by every prospective
counterexample.

Current targets:

- uniform radical-height bounds on varying squarefree diagonal conics;
- uniform descent/Selmer estimates on varying cube-free diagonal cubics;
- balanced/unbalanced decomposition;
- interaction with determinant-method exceptional-set estimates.

### Agent E: local Galois and quantitative auxiliary primes

Goal: construct two actual Frey/Legendre Picard--Lefschetz inertia matrices in
one common torsion basis and select a prime with sublinear logarithmic height.

Most elementary prime-selection and finite-group work is already available.
The remaining source theorem is actual odd and two-adic local monodromy,
followed by a global height mechanism using the selected representation.

### Agent F: modularity/Szpiro and isogeny determinants

Goal: find a genuinely stronger consequence of modularity or evaluation
isogeny determinants than the already equivalent sharp Szpiro inequality.

The route must retain local discriminant multiplicity; stable Faltings-height
variation under isogeny alone has already been excluded as insufficient.

### Agent G: varying-S-unit and arithmetic differentiation

Goals:

- obtain an S-unit height theorem with essentially linear support dependence;
- construct an arithmetic multiplicity-lowering operator compatible with a
  product formula and global height.

Neither route is eliminated; both remain at the source-theorem stage.

### Agent H: disproof and computational anatomy

Goal: search for a fixed positive `epsilon_0` and an infinite family, while
proving structural constraints on any such family.

Finite high-quality records do not disprove abc. Candidate families are tested
against the exact fixed-epsilon asymptotic criterion.

## 3. New branch map

- `research/abc-power-difference-lifts-v9`
- `research/abc-legendre-period-bound-v9`
- `research/abc-metric-normalization-v9`
- `research/abc-team-v9`

Older active v8 routes remain preserved in the route registry.

## 4. Merge discipline

Mathematical Markdown or LaTeX results may enter a research PR after proof
review. Lean files enter `main` only after they are reachable from the complete
module audit and the pinned Lean kernel succeeds. A journal-style synthesis
paper will cite only merged or explicitly labelled conditional results.

## 5. Present global status

The abc conjecture is neither proved nor disproved. The v9 results narrow two
routes and eliminate two precise submechanisms, but the surviving global
height/source theorems remain open. This status line must remain in every paper
until an unconditional proof or a fixed-epsilon counterexample family is
actually obtained.
