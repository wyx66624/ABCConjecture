# Dual-route continuation toward the abc conjecture

Author: ChatGPT. Date: 2026-08-31.

## 0. Status

The standard abc conjecture remains open.  This report records two rigorous
continuation routes and their exact stopping points.  It neither proves nor
disproves abc.

The positive route replaces no quantifier in the standard conjecture: it
proves an equivalent uniform-boundedness criterion and isolates the precise
amplification inequality that would let a counting theorem establish that
criterion.  The counterexample route proves necessary structural conditions
for a strict mixed-full family and a conditional Pell construction; its one
unproved arithmetic premise is stated explicitly.

The mathematical sources summarized here are

* `research/ABC_SUBCRITICAL_LOCUS_UNIFORMITY_2026_08_31.md`, and
* `research/ABC_COUNTEREXAMPLE_CAMPANA_ESCAPE_2026_08_31.md`.

Six Lean modules check the elementary and abstract cores described in
Section 4.  External results such as Darmon--Granville, Mason--Stothers,
Bilu--Hanrot--Voutier, and the analytic mixed-full counting theorem are not
inserted into Lean as axioms.

## 1. The unchanged target

For a positive primitive triple

\[
                    a+b=c,\qquad \gcd(a,b)=1,
\]

put

\[
 H(P)=\log c,
 \qquad
 R(P)=\log\operatorname{rad}(abc).
\]

The target throughout the repository is the standard logarithmic statement

\[
 \forall\varepsilon>0\ \exists C_\varepsilon\ \forall P,
 \qquad
 H(P)\le (1+\varepsilon)R(P)+C_\varepsilon.                 \tag{1.1}
\]

No restricted signature, density-one version, exceptional-set estimate, or
newly defined predicate is called abc.  In Lean, the positive equivalence and
the conditional disproof theorem both refer to the existing
`ABCConjecture`.

## 2. Positive route: the exact uniformity gate

### 2.1 Subcritical loci are exactly equivalent to abc

Define the fixed-slope subcritical boundedness property

\[
 \forall\mu\in[0,1)\ \exists B_\mu\ \forall P,
 \qquad
 R(P)\le\mu H(P)\Longrightarrow H(P)\le B_\mu.              \tag{2.1}
\]

The bound may depend on the fixed value of \(\mu\), but it is independent of
the point and its prime support.  The repository proves unconditionally that
(1.1) and (2.1) are equivalent.

For the forward implication, fix \(0\le\mu<1\), take
\(\eta=(1-\mu)/2\), and apply abc with \(\eta\).  The remaining coefficient

\[
 1-(1+\eta)\mu=\frac{(1-\mu)(2-\mu)}2
\]

is positive, so every point with \(R\le\mu H\) satisfies a uniform height
bound.  Conversely, for a fixed \(\varepsilon>0\), take
\(\mu=(1+\varepsilon)^{-1}\).  Points with \(R\le\mu H\) are bounded by
(2.1), while points with \(R>\mu H\) satisfy
\(H<(1+\varepsilon)R\) directly.  One constant therefore works for every
primitive positive triple.

This equivalence identifies the positive goal exactly: prove uniform height
boundedness for every fixed \(\mu<1\).  A density-zero result, a positive
power saving, or a bound whose constants depend on the individual triple
does not meet (2.1).

### 2.2 Why present sparse counting is insufficient

The toy sequence

\[
                        X_n=2^{2^n}
\]

is infinite and unbounded, satisfies \(X_{n+1}=X_n^2\), and has cumulative
count at most \(1+\log_2\log_2 X\).  In particular its count is
\(O_\theta(X^\theta)\) for every fixed \(\theta>0\).  Thus even an arbitrarily
strong positive-power count combined with a square gap does not imply
eventual emptiness.  This is a logical countermodel to a counting inference,
not an abc counterexample.

The mixed-full counting result currently available in the strict Campana
range also has a positive exponent.  It can constrain a target population,
but it cannot by itself prove that a fixed subcritical locus has bounded
height.

### 2.3 The missing amplification theorem

The proved single-source gate is the following.  Suppose a counted target
class satisfies, for all \(Y\ge1\),

\[
                         |T(Y)|\le C Y^\theta,                 \tag{2.2}
\]

with fixed \(C>0\) and \(\theta\ge0\).  If every source of multiplicative
height \(X\ge1\) has a fibre of distinct targets such that

\[
 F_X\subseteq T(X^\kappa),
 \qquad
 |F_X|\ge X^\beta,                                            \tag{2.3}
\]

where \(\kappa,\beta\ge0\) are fixed and

\[
                              \beta>\kappa\theta,              \tag{2.4}
\]

then

\[
                         X\le C^{1/(\beta-\kappa\theta)}.       \tag{2.5}
\]

The proof is the pointwise chain
\(X^\beta\le|F_X|\le|T(X^\kappa)|\le C X^{\kappa\theta}\).
No overlap estimate between fibres belonging to different sources is needed.

The open positive step is therefore concrete.  For every fixed
\(\mu<1\), one must either

1. prove (2.1) directly; or
2. construct from every point with \(R\le\mu H\) a genuinely distinct fibre
   satisfying (2.2)--(2.4), with constants allowed to depend on \(\mu\) but
   not on the source point.

The audited CRT and conic constructions do not yet cross this exponent
threshold.  A decaying shell estimate that eventually becomes strictly less
than one would also suffice, but no such estimate is currently proved.

## 3. Counterexample route: moving kernels and a conditional Pell gate

### 3.1 Mixed-full compression and kernel escape

Call a positive integer \(m\)-full if every prime in its support occurs with
valuation at least \(m\).  If the three coordinates of a primitive abc point
are respectively \(p\)-, \(q\)-, and \(r\)-full, then

\[
 \operatorname{rad}(abc)^{pqr}
       \le c^{qr+pr+pq},
 \qquad
 R(P)\le
 \left(\frac1p+\frac1q+\frac1r\right)H(P).                    \tag{3.1}
\]

Consequently, an unbounded family with fixed \(p,q,r\ge2\) and reciprocal
sum below one would disprove the standard conjecture.  Formula (3.1) is a
disproof gate, not an existence theorem.

For \(m\ge1\), define the canonical residual kernel and power part by

\[
 \kappa_m(n)=\prod_{\ell\mid n}\ell^{v_\ell(n)\bmod m},
 \qquad
 \rho_m(n)=\prod_{\ell\mid n}\ell^{\lfloor v_\ell(n)/m\rfloor}.
\]

Then \(n=\kappa_m(n)\rho_m(n)^m\), with \(\kappa_m(n)\)
\(m\)-th-power-free.  A mixed-full abc point therefore yields

\[
                         A x^p+B y^q=C z^r,                    \tag{3.2}
\]

where \((A,B,C)=(\kappa_p(a),\kappa_q(b),\kappa_r(c))\) and
\(\gcd(x,y,z)=1\).

Darmon--Granville finiteness for a fixed nonzero coefficient triple in the
strict reciprocal range implies the kernel-escape theorem: every infinite
family of distinct primitive mixed-full points with a fixed strict signature
must use infinitely many distinct residual triples \((A,B,C)\).  This is a
necessary condition only.  It does not exclude a fixed Pell or elliptic
source curve whose varying points induce infinitely many residual triples.

### 3.2 Polynomial no-go

If nonzero pairwise coprime polynomials \(A+B=C\) over a
characteristic-zero field are respectively polynomial-\(p\)-,
\(q\)-, and \(r\)-full and at least one is nonconstant, the
Mason--Stothers theorem gives

\[
                       \frac1p+\frac1q+\frac1r>1.              \tag{3.3}
\]

Indeed, with \(D=\max(\deg A,\deg B,\deg C)>0\), polynomial abc gives
\(D+1\le\deg\operatorname{rad}(ABC)\), while fullness gives an upper bound
of \(D(1/p+1/q+1/r)\).  Thus no nonconstant pairwise-coprime polynomial
tripod can have a critical or strict full signature.

This does not rule out sparse integer specializations at which polynomials
with simple algebraic factors happen to take full values.  It closes only the
uniform polynomial-identity mechanism.

### 3.3 The surviving Pell squarefull-root gate

Let

\[
 x_n+y_n\sqrt8=(3+\sqrt8)^n,
 \qquad
 1+8y_n^2=x_n^2.                                               \tag{3.4}
\]

The resulting positive primitive triples are

\[
                         (1,8y_n^2,x_n^2).                      \tag{3.5}
\]

The two nonunit entries are always squarefull.  If \(y_n\) is itself
squarefull, then \(8y_n^2\) is 3-full.  Treating the unit as 7-full gives the
fixed strict signature

\[
                         (7,3,2),
 \qquad
                         \frac17+\frac13+\frac12=\frac{41}{42}<1.
\]

Hence an unbounded subsequence of squarefull values \(y_n\) would disprove
abc.  The actual radical ledger is stronger:

\[
 \operatorname{rad}(8y_n^2x_n^2)^2<4x_n^3,
 \qquad
 R(P_n)\le\frac34H(P_n)+\log2.                                 \tag{3.6}
\]

The existence of an unbounded squarefull subsequence is open in the audited
work.  The Bilu--Hanrot--Voutier primitive-divisor theorem applies to this
Lucas sequence for indices greater than 30, but a primitive divisor need not
occur to valuation one.  It therefore neither proves nor refutes the
squarefull premise.

The sharp next decision for this particular route is:

* prove that squarefull \(y_n\) occur at unbounded indices, which together
  with (3.4)--(3.6) would give a genuine abc counterexample; or
* prove that every sufficiently large \(y_n\) has a prime divisor of
  valuation exactly one, which would rule out this Pell mechanism only.

A broader counterexample construction must produce an unbounded primitive
family of one fixed strict signature while allowing the residual kernels in
(3.2) to escape every finite set.

## 4. Exact Lean scope

The two principal route modules are the following.

### 4.1 `ABCSubcriticalLocusUniformity20260831.lean`

This module formalizes the two directions of the exact equivalence

\[
 `ABCConjecture`
 \quad\Longleftrightarrow\quad
 `SubcriticalLociHaveBoundedHeight`.
\]

It also proves the finite-cardinality threshold below one, the pointwise
fibre-versus-target inequality, the abstract logarithmic exponent bound
behind \(\beta>\kappa\theta\), and a double-exponential sparse model with an
exact square gap, an explicit positive-power count, and unbounded prefixes.
It does not formalize an external analytic counting theorem or an arithmetic
amplifier.

### 4.2 `PellCampanaCounterexample20260831.lean`

This module formalizes the integral Pell recurrence, its norm identity,
positivity and unbounded first coordinate; the fact that \(8y^2\) is always
2-full and is 3-full when \(y\) is 2-full; the actual primitive point
\((1,8y^2,x^2)\); its strict \((7,3,2)\) mixed-full signature; and the
conditional implication from an unbounded family of squarefull-root data to
`not ABCConjecture`.  It does not assert that the required squarefull-root
family exists.  Kernel escape, Mason--Stothers, the sharper slope (3.6), and
the Lucas--Wieferich analysis remain paper mathematics.

The four complementary modules have the following narrower conclusions.

### 4.3 `ABCMixedFullCampana20260831.lean`

For an actual `ABCPoint` with the specified fullness hypotheses, this module
proves the natural-number radical inequality in (3.1), the corresponding
logarithmic slope, the existence of a positive abc margin when the reciprocal
sum is below one, the abc-conditional uniform height bound, and the
conditional negation of the unchanged `ABCConjecture` from an actually
unbounded strict mixed-full family.  It assumes no such family and no
counting theorem.

### 4.4 `ABCThreePrimeSignatures20260831.lean`

This module proves elementary prime-power rigidity lemmas and rules out, for
prime bases and with the hypotheses stated in the declarations, every output
placement of the equation-level signatures \((2,3,3)\) and \((2,3,6)\).
It does not formalize the reduction from all triples with
\(\omega(abc)\le3\) to these equations, nor any use of Fermat's Last Theorem,
Mihailescu's theorem, Darmon--Granville, or unresolved Fermat--Catalan
signatures.  It is therefore not a classification of the full three-prime
support locus.

### 4.5 `FreyIsogenyConductorSharpness20260831.lean`

Despite the historical filename, the proved conclusion is one-sided.  On an
explicit power subfamily and for each of the four actual Weierstrass models,
the module proves the endpoint radical identities, the actual reduced
\(j\)-denominator identities inherited from the height module, and that for
every fixed \(0\le\theta<6\) and every constant \(C\), the quantity

\[
 h(j)-\theta\log(`conductorProxy`)
\]

eventually exceeds \(C\) simultaneously for all four models.  Thus the
tested route cannot yield a uniform coefficient strictly below six.  It does
not prove that coefficient six is attainable or optimal.  In Lean,
`conductorProxy` is an explicit radical integer; its interpretation as the
Neron conductor and the completeness of the rational isogeny class are
paper-level results, not formalized elliptic-curve APIs.

### 4.6 `IUTFiniteProductProjectionSpan20260831.lean`

For a finite heterogeneous product of commutative rings, this module proves
that membership in the submodule span over the product ring is equivalent to
membership of every coordinate in its projected span.  The reverse direction
uses the product's central idempotents.  It also proves the corresponding
coordinate-product inclusion and monotonicity of a finite sum with
nonnegative weights.  It does not formalize topological closure, a source
hull, Haar measure or volume, IUT possible-image membership, or any global
height/radical comparison.

## 5. Mechanical audit and manuscript status

The validation record is
`Lean/verification/2026_08_31_dual_route_continuation/VALIDATION.md`.
Its scope and outcome are:

* all six modules compile directly with exit code zero;
* 94 public theorems plus 15 definitions or structures were audited, for
  \(94+15=109\) declarations;
* the declaration audit reports no `sorryAx` and no unexpected axioms; the
  recorded kernel dependencies are exactly `Classical.choice`, `Quot.sound`,
  and `propext`;
* the full build completed 9142 jobs;
* the full build emitted 265 warning lines, exactly the frozen baseline
  multiset, so the six new modules introduced no warning; and
* protected statements, toolchain files, package pins, and the standard abc
  target match the frozen baseline.

The accompanying manuscript
`output/pdf/ChatGPT_ABC_Dual_Route_2026_08_31.pdf` is a 102-page A4 paper
authored by ChatGPT.  The audited final PDF has SHA256
`cbbd600376a9c27754e6969612efa9ed2833060f60cb1a48d4b64ed03c25bfc4`;
all pages were rendered and visually inspected, and the final TeX pass had
zero diagnostics in the audited categories.  This is a record of a rigorous
partial research program and its formal companions.  Internal review,
successful compilation, and presentation QA are not external peer review
and do not constitute a proof or disproof of abc.

## 6. Decisive continuation thresholds

The next steps can be tested against explicit pass/fail conditions.

1. **Positive direct threshold.**  Prove (2.1), with a constant depending
   only on each fixed \(\mu<1\), for all positive primitive abc points in that
   locus.  By the proved equivalence this would prove the standard abc
   conjecture.
2. **Positive amplification threshold.**  For every fixed subcritical slope,
   construct a pointwise distinct target fibre with uniform scale and count
   parameters satisfying \(\beta>\kappa\theta\).  A construction with
   \(\beta\le\kappa\theta\), an average fibre size, or constants depending on
   the source point does not pass this gate.  A counterexample to any proposed
   amplifier must refute only that construction, not the equivalence or abc.
3. **Pell disproof threshold.**  Establish an unbounded set of indices for
   which every prime divisor of \(y_n\) has valuation at least two.  The
   deterministic theorem then supplies an actual strict family and disproves
   abc.
4. **Pell falsification threshold.**  Prove an eventual exponent-one divisor
   theorem for the same Lucas sequence.  This would close the Pell
   squarefull-root gate but would not prove abc.
5. **General strict-family threshold.**  Produce a fixed strict signature
   and an unbounded primitive mixed-full family whose canonical residual
   kernels escape every finite set.  Fixed-kernel generalized-Fermat packets
   and full polynomial identities are already excluded by the audited
   theorems.
6. **Frey/IUT boundary.**  A Frey argument must supply the missing
   coefficient-six/all-epsilon upper estimate rather than a coefficient below
   six.  A product-hull argument must additionally prove the relevant source
   membership, topology/volume statements, and global comparison; the finite
   algebraic span lemma alone supplies none of these conclusions.

At this checkpoint the two routes are complementary.  The positive route has
an exact uniformity target but no amplifier crossing its exponent threshold.
The counterexample route has an exact conditional Pell mechanism and strong
rigidity constraints but no proof of its squarefull-subsequence premise.
Accordingly, the correct repository status is: rigorous partial results,
standard abc neither proved nor disproved.
