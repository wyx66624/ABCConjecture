# Actual radicals, moving geometric families and admissible Galois maps

**Author:** ChatGPT  
**Research date:** 2026-08-30  
**Status:** completed partial results and explicit open interfaces; no proof or disproof of standard ABCConjecture.

This increment follows `ABC_CONTINUATION_2026_08_30.md`. Its purpose is to
move beyond finiteness of a prescribed Pell packet, sufficient radical
certificates, and freely chosen local matrices. Each new mathematical
argument was written before its Lean components. The protected abc
statement and pinned dependencies have not changed.

## 1. Results and the quantifiers they actually cover

### Actual-radical amplification

For a squarefree positive integer R and Y>=R, set X=Y/R. The original
explicit S-unit bound of Hirata-Kohno, Kawashima, Poels and Washio gives

    #{primitive positive (a,b,c): a+b=c, R|rad(abc), rad(abc)<=Y}
       <= 905 * 45^omega(R) * X * (1+log X)^44.

There is no height condition in this statement. To prove it, write
`rad(abc)=R D`, apply the original bound over the support of `R D`,
use the injective map `(a,b,c) -> (a/c,b/c)`, and sum over squarefree
`D<=X`. The elementary estimate `45^omega(n)<=d_45(n)` and a harmonic
sum give the displayed result, including X=1. The source constants
and its rational specialization are checked explicitly in
`ANALYTIC_ACTUAL_RADICAL_UNIFORM_GATE_2026_08_30.md`.

For a primitive seed `P=(a,b,c)`, write `R=rad(abc)`. For an integer
conic lift `a x^2+b y^2=c z^2` whose output is primitive, the exact
new-prime factor and excess E satisfy

    rad(output) * E = R*x*y*z.

Thus an actual small radical imposes a lower bound on excess; it
need not satisfy the earlier sufficient size certificate. Combining
the actual radical count with the complete-conic-fibre upper bound
gives, in the report's notation,

    output count <= c^(min(max(0,(K-rho)/2), K*mu-sigma)+epsilon),
    rho=log(abc)/log(c),  sigma=log(R)/log(c).

To beat the compared exceptional-set exponent by this method, it is
necessary that

    K > rho+4*sigma,
    3*sigma/K < mu < (3/4)*(1-rho/K).

This is a necessary window, not a construction attaining it. In
particular, the seed does not justify assuming sigma>=1. Explicit
projective cancellation and quadratic-tripod examples disprove the
particular proposed universal support/quality properties. They do
not eliminate arbitrary rational transformations or amplification.

### Geometry for every primitive triple

Use the actual prime factorization to write

    a=A u^3,  b=B v^3,  c=C w^3,

with cube-free pairwise coprime A,B,C. Each choice of an omitted
coordinate gives a proved integral point on a curve
`y^2=x^3+16(nr)^2`; all three have `|x|^3>=32c`.
Their exact prime costs, cubic resolvents, irreducibility conditions,
orders and indices are computed in
`GEOMETRY_GLOBAL_UNIFORM_GATE_2026_08_30.md`.
The Lean factorization uses `Nat.floorRoot 3`, the factorization root,
not the ordinary integer floor of a real cube root.

Retaining the pure cubic field regulator in Pasten's original 2026
preprint yields the stated effective relative bound

    H <= C*S*log(2S)^2*L*log(3SL),  L=log(2nr),

with an absolute effective C, under the report's explicitly proved
reduction. This is not the abc radical exponent: the remaining
dependence on the moving coefficient field is material.

All three points also lie, after their actual rational rescaling,
on one curve

    E_N: Y^2=X^3+16N^2,  N=A*B*C.

Their x-denominators and the translations by `(0,4N)` are exact.
This is rational 3-torsion on the common j=0 curve; it is not a
claimed 3-isogeny of the original Frey curve. For bounded residual
support `R0=rad(A B C)`, there are finitely many N, and the original
Siegel approximation theorem implies

    log(min(a,b))/log(c) -> 1

along triples of unbounded height with that support bound. Its
threshold is ineffective and depends on the support bound. It does
not become uniform when R0 varies. Conversely, the explicit
infinite-order point `(36,-108)` on `Y^2=X^3-34992` produces
infinitely many primitive triples with `R0=3` and unbounded height.
Their full radicals are not asserted to violate abc. The proof and
the exact meaning of this counterexample are in
`UNIFORM_GATE_STRUCTURAL_TESTS_2026_08_30.md`.

### Actual local IUT arrows

The original Ism definition requires preservation of the images of
unit groups for every open subgroup, not just one logarithmic
lattice. For a finite field extension E/Qp, local class field theory
realizes every finite-index sublattice of `log(U_E)` as a trace
lattice from a finite abelian extension. Galois equivariance then
forces its preservation. An elementary all-neighborhoods argument
shows that the action is a scalar in `Z_p` units, and compatibility
over extensions gives the same scalar on the entire logarithmic
module. See `IUT_ADMISSIBLE_GALOIS_UNIFORM_GATE_2026_08_30.md`.

In the native finite-etale tensor carrier, the actual Ind2 action
is therefore multiplication by a unit of the integral tensor order,
hence by a unit of its maximal order B. For every subset S,

    span_B(Ind2*S) = span_B(S),

also after taking closure. This equality is not an assertion that
Ind1 is B-linear or that Ind3 is trivial. It removes the specified
Ind2 step from a fixed module hull and nothing more.

The original mono-analytic processions allow local outer Galois
representatives in their capsule-full maps; their automorphisms do
not require a lift to the previously forgotten curve category.
This is a statement about representatives inside poly-morphisms,
not a one-to-one assignment of representatives to coarse
poly-automorphisms. The induced linear family is still an actual
Galois/Kummer image, not all of `GL(I_E)`. Its trace is preserved up
to a `Z_p` unit. The proved affine trace-depth distinctions separate
particular orbits but need not separate their B-module hulls. See
`IUT_PROCESSION_ADMISSIBILITY_CONTINUATION_2026_08_30.md`.

A trace-preserving integral transvection proves simultaneous
minimum-layer reachability for the larger linear trace stabilizer.
That theorem alone does not lift the matrix to a Galois
automorphism. A subsequent full Jannsen--Wingberg construction is
being investigated in separate research notes. It is outside the
completed formal and manuscript snapshot described below.

## 2. Formalization and independent checks

| New Lean module | Public theorems audited | Checked scope |
| --- | ---: | --- |
| AnalyticActualRadicalUniformGate20260830 | 18 | Actual radical/excess algebra, necessary exponent window, exact counterexample comparisons |
| GeometryGlobalUniformGate20260830 | 53 | Canonical factorization, actual Mordell points, prime costs, polynomial/order algebra, common-curve identities |
| IUTAdmissibleGaloisUniformGate20260830 | 8 | Explicit trace implications, valuations and scalar-orbit spans |
| IUTTracePreservingTransvection20260830 | 4 | Genuine linear equivalence, inverse, trace preservation and common avoidance |
| IUTAllOpenLatticeRigidity20260830 | 6 | Scalar rigidity from line neighborhoods and p-adic separatedness |
| **Total** | **89** | No new mathematical axioms |

All declarations were checked with `#print axioms`. Only `propext`,
`Classical.choice` and `Quot.sound` occur. The fresh audit of the
preceding continuation's 43 declarations passed as well. The final
default build reports 9121 jobs, no warnings in the new modules or
their audit, and 265 pre-existing warning entries. Initial style
warnings were fixed without disabling linters; that initial log is
retained. The checks do not silently grant complete formalizations
of the external S-unit, Siegel, Pasten, local class field theory,
Galois reconstruction or IUT comparison theorems.

Separate agents cross-reviewed the proofs, and the root agent
checked the source definitions and algebra independently. Detailed
cross-review files, declaration lists, compiler output, dependency
pins, unchanged-core hashes and PDF checks are indexed in
`Lean/verification/2026_08_30_uniform_gate/VALIDATION.md`.
These are internal checks by AI agents, not external human peer
review or publication acceptance.

## 3. Manuscript and preservation

The English manuscript `paper/ChatGPT_ABC_Uniformity_2026.tex`,
authored by ChatGPT, now contains 34 pages. Its PDF compiles with
zero final TeX warnings and all 34 pages were visually inspected.
The manuscript reports the proved partial results and their
formalization boundaries; it does not claim a solution to abc.

The previous 22-page paper and mutable status/import files were
captured byte for byte before updates. A recorded mapping of ten
paths replays all 447 entries of the previous snapshot manifest
with zero failures. The earlier ten-page paper and all original
research/source records remain preserved. The user's uploaded
PDFs were not changed. No route, core definition or pinned
dependency was deleted or weakened.

## 4. Work still required for the user's target

The analytic route needs an actual amplification lower bound in a
viable parameter window, or another uniform method excluding an
arbitrarily sparse sequence of bad triples. The geometric route
needs a uniform estimate for moving coefficient fields/support,
not just fixed-support finiteness or approximation. The IUT route
needs the exact genuine Ind1 image, the effect of Ind3 and the
source-faithful global pilot comparison with every initial-data
condition and normalization in place.

None of these missing conclusions is an axiom in the new Lean
modules. There is still no closed term of standard unconditional
`ABCConjecture`, and no rigorous counterexample family disproving
it. The final research goal remains active.
