# Actual Haar, sigma-one exact-order coupling, affine catalogue novelty, and Pell endpoint curvature

**Author:** ChatGPT  
**Date:** 2 September 2026  
**Status:** four active proof routes with unconditional local advances, explicit
full-premise counterexamples to stronger subclaims, and precisely stated open
gates.  This checkpoint does not prove or disprove the standard abc conjecture.

## 1. Logical policy and common target

For coprime positive integers \(a+b=c\), the standard abc conjecture asserts
that, for every \(\varepsilon>0\), only finitely many triples satisfy

\[
 c>\operatorname{rad}(abc)^{1+\varepsilon}.
\]

Proof construction and counterexample search are pursued simultaneously.  A
route is not discarded because its next theorem is difficult, absent from
Mathlib, or unsupported by a bounded computation.  A counterexample retires
only the exact statement for which every premise has been checked.  In
particular, a counterexample to a local relaxation does not refute the
corresponding arithmetic realization, and a finite no-hit search is not an
asymptotic exclusion.

This checkpoint advances four independent seams.  Each paper proof was written
before its Lean companion.  Lean checks the stated algebraic, measure-theoretic,
finite-combinatorial, and numerical cores; external analytic estimates and the
remaining global realization theorems stay explicit.

## 2. IUT-facing actual Haar route

Let \(K\) be a nonarchimedean local field, \(\mu\) a nonzero additive Haar
measure, and \(\Delta:K^\times\to\mathbb R_{>0}\) its distribution character,
so that

\[
 \mu(aS)=\Delta(a)\mu(S).
\]

For every measurable \(S\) with \(0<\mu(S)<\infty\), change of variables gives

\[
 \mu(a^{-1}S)=\Delta(a)^{-1}\mu(S),\qquad
 \log\mu(a^{-1}S)=\log\mu(S)-\log\Delta(a).       \tag{2.1}
\]

The same hypotheses hold after taking the preimage, so the finite-positive
measurable domain is exactly stable under every nonzero scalar.  If \(\pi\) is
a uniformizer and \(\mu(\mathcal O_K)=1\), then

\[
 \mu(\pi^{-n}\mathcal O_K)=|k_K|^n,
 \qquad \log\mu(\pi^{-n}\mathcal O_K)=n\log |k_K|. \tag{2.2}
\]

The balls in (2.2) are nonempty compact open sets and form an injective orbit.
Consequently no finite-positive set can contain every orbit member: otherwise
monotonicity of Haar measure would bound \(|k_K|^n\) uniformly in \(n\).

At a rational prime \(p\), suppose \(p=u\pi^e\) and \(|k_K|=p^f\).  The raw
preimage shift is

\[
 -\log\Delta(p)=ef\log p.                            \tag{2.3}
\]

Dividing the component log-volume by the local degree \(ef\) produces the
canonical shift \(\log p\).  Hence a packet of component-normalized terms with
weights summing to one also shifts by exactly \(\log p\).  Ordinary weight
normalization without division by \(ef\) is insufficient: an unramified
quadratic component has \(e=1,f=2\), so the raw shift is \(2\log p\), not
\(\log p\).

This full arithmetic example retires only the raw-weight assertion.  The
corrected actual-Haar construction remains active.  Its open gates are the
uniform realization of (2.3) for every tensor/place component, construction of
the tensor admissible class, transport through the Ind1--Ind3 and theta data,
and the same-pilot horizontal comparison required at the Corollary 3.12 seam.

## 3. Mersenne endpoint at \(\sigma=1\)

For an exact-order row \(d\), let \(a_d\) be the logarithm of the repeated
prime-power part supported on primes \(p\) with \(\operatorname{ord}_p(2)=d\).
Writing \(p=1+d r_p\) and separating one-copy/deep and
low/high-multiplier contributions yields an exact four-arm decomposition

\[
 a_d=U_d+V_d+B_d+G_d.                                \tag{3.1}
\]

For \(m=dq\), take the endpoint scales

\[
 A_m=\log(3m),\quad L_m=\log A_m,\quad
 F_m=A_mL_m,\quad H_m=\left\lfloor\sqrt{A_m/L_m}\right\rfloor.
\]

A weighted Brun--Titchmarsh estimate for primes in the progression
\(1\pmod d\), combined with the uniform bound for \(d/\varphi(d)\) and the
divisor harmonic sum, proves at paper level that the low one-copy arm satisfies

\[
 \sum_{\substack{d\mid m\\m/d<A_m^k}}U_d(m)=o(m)       \tag{3.2}
\]

for each fixed \(k>0\).  This is an unconditional endpoint saving; the cited
analytic inputs remain outside Lean.

The other low arm is converted without discarding its correlation.  The slope
\(r_p=(p-1)/d\) is injective across exact-order fibres, and the relevant first
moment is exactly a localized Farey energy \(E_k(m)\).  The supplied
Yamada-type pointwise valuation estimate then shows

\[
 E_k(m)=o(\log m)\quad\Longrightarrow\quad
 \sum V_d(m)=o(m).                                   \tag{3.3}
\]

Stable lifting packages the two remaining arms as prime-power layers.  For a
repeated exact-order prime of depth \(w_p\), the exact criterion

\[
 \operatorname{ord}_{p^j}(2)=d\quad\Longleftrightarrow\quad j\le w_p
                                                               \tag{3.4}
\]

identifies layer two with \(B\) and higher layers with \(G\).  Therefore the
surviving endpoint is reduced to either of the two explicit estimates

\[
 E_k(m)=o(\log m),
 \qquad
 \sum_{(d,p,j,q)\in\mathcal C_k(m)}\log p=o(m).       \tag{3.5}
\]

The exhaustive scan of all \(50{,}847{,}534\) primes through \(10^9\) finds
exactly the base-two repeated primes \(1093\) and \(3511\), both of depth two.
The full exact-order fibre at \((p,d)=(1093,364)\) gives \(B>0,G=0\) in a
certified endpoint window, refuting every universal pointwise bound
\(B\le C G\).  The row \((3511,1755)\) gives a certified \(B\)-carrier below
the finite multiplier cutoff, refuting the all-\(m\) cutoff claim.  Neither
witness is asymptotic; (3.5) and the Mersenne parent route remain active.

## 4. Affine incidence and inverse-period catalogues

Partition the selected affine points into direction classes \(\kappa\), with
class multiplicity \(m_\kappa\) and common large-tail weight \(L_\kappa\).
The exact incidence identity is

\[
 I=\sum_\kappa m_\kappa L_\kappa.                    \tag{4.1}
\]

The sharp elementary inequality

\[
 n^3\le n+6(n-1)^3                                  \tag{4.2}
\]

has equality at \(n=2\), while coefficient three is optimal once \(n\ge3\).
After weighting, (4.2) gives

\[
 \sum_\kappa(m_\kappa^3-m_\kappa)L_\kappa
 \le 6\sum_\kappa(m_\kappa-1)^3L_\kappa,            \tag{4.3}
\]

so singleton classes cancel exactly.  If \(A_1\) is the multiplicity mass and
\(\Omega\) the cross-class singleton novelty, the shifted incidence is exactly
\(A_1+\Omega\), and Hölder yields

\[
 (A_1+\Omega)^3\le(A_0-\Omega)^2E_{\rm sh}.           \tag{4.4}
\]

For a point pair, the inverse period is retained in the local Euler factor

\[
 F(k,a)=\sum_{d\mid k}\frac{\varphi(d)\gcd(d,a)^2}{d^2},
                                                               \tag{4.5}
\]

whose prime-power values are evaluated exactly.  The resulting pair catalogue
obeys the three-way hybrid bound

\[
 Q(x,y)\le\min\left\{\prod F,
       \frac{C g^2G}{N^4},
       \frac{C g^2H(G)}{N^2}\right\}.                \tag{4.6}
\]

Every surviving primitive direction also satisfies the necessary powerful
excess conditions

\[
 T_g\mathfrak E(P_0)>N,\qquad \mathfrak E(P_0)>L.     \tag{4.7}
\]

For fixed \(C\), counting the original injective linear coefficient after
using \(\mathfrak E(A^{(R)})>Y\Rightarrow\mathfrak E(A)>Y\) gives the corrected
direction bound

\[
 O\!\left(\min\{N^2,\,C N^{11/6}\}\right).           \tag{4.8}
\]

Several complete affine witnesses delimit what (4.1)--(4.8) can prove.  The
canonical period-one example makes the constant six in (4.2)--(4.3) sharp.
A second actual packet shows repetition arising entirely from overlap of
singleton classes.  A third refutes deletion of the reduced-period Euler
correction.  Most strongly,

\[
 (B,C,R,M,N)=(8,9,6,22143,22142)
\]

has two singleton points on a primitive period-one direction with \(R<C\) and
exactly

\[
 Q_{\{x,y\}}=S_{\rm non}=w_\lambda,\qquad
 \frac{w_\lambda}{D}=\frac{23392}{23701}.
\]

Thus no strict saving follows merely from \(R<C\), singleton support, or
\(T\ge1\).  The remaining route must aggregate a divisibility-maximal
subcatalogue of powerful intersection tops while preserving the class-support
cover and comparing its energy with both \(A_1\) and \(\Omega\).  None of the
counterexamples satisfies premises that would refute this corrected target.

## 5. Pell--Lucas factor quotients and endpoint curvature

Write

\[
(1+\sqrt2)^n=A_n+B_n\sqrt2,\qquad
U=A_\ell B_\ell,\qquad v=2A_{2\ell}.
\]

The elementary symmetric triples of the two factor-quotient lists determine
companion jets \(V_A,V_B\).  Their exact difference is

\[
 V_A-V_B=16\ell L-64\ell^4(C_A^2-2C_B^2),            \tag{5.1}
\]

where \(L\) is the complete third-order ledger.  Hence
\(L\equiv0\pmod{8\ell^3}\) implies equality of the jets modulo
\((2\ell)^4\).  The converse recovers only \(L\equiv0\pmod{\ell^3}\): an
explicit coefficient-level witness proves that the missing factor eight is
real.  This corrects an earlier temptation to call the two statements
equivalent.

The highest adjacent correlated determinant has the exact closed form

\[
 \Delta_{\rm top}=2v\,32^{\ell-1}U^2.                \tag{5.2}
\]

The Pell norm identity \(v^2-32U^2=4\) gives

\[
 \gcd(2v32^{\ell-1},U)=1.                            \tag{5.3}
\]

Thus every prime supporting \(U\) occurs in \(\Delta_{\rm top}\) with exactly
twice its exponent in \(U\); the modulus \(U^2\) is sharp.  The curvature
quotient in (5.2) also has a directly reconstructed \(2\ell\)-adic jet from
each factor-quotient channel.

There are three exact counterexample boundaries.  A coefficient-level example
refutes the reverse implication from equal jets to the complete ledger.  The
local packet \((\ell,q,r)=(3,7,797)\) satisfies the forced residues, depth-three
carrier data, character signs, and full ledger modulo \(8\ell^3\), but fails
the global negative-Pell equation; it retires only local-ledger inconsistency.
Finally, the actual Pell index \(\ell=7\) has
\(U^3\nmid\Delta_{\rm top}\), refuting the proposed cubic strengthening.  It
is not a squarefull packet because \(239\parallel A_7\).

Independent certificates show that all 57 odd prime indices through 271 have
an exponent-one prime divisor, so no squarefull packet occurs in that finite
range.  This does not settle the unbounded problem.  The live gate is to use
the global negative-Pell realization to rule out or construct an unbounded
family simultaneously satisfying two-channel squarefullness, opposite
depth-three character incidence, the full ledger, all correlated tails, and
the exact curvature law.

## 6. Formal and computational boundary

The four companion modules are:

1. `IUTActualHaarAdmissibleOrbit20260902.lean`;
2. `MersenneSigmaOneExactOrderCoupling20260902.lean`;
3. `AffineInversePeriodCatalogueNovelty20260902.lean`;
4. `PellLucasFactorQuotientProjectiveCoupling20260902.lean`.

Together they contain 102 theorem declarations, 18 definitions, two
structures, and one abbreviation, for 123 counted declarations.  Their axiom
audits issue exactly 102 `#print axioms` queries, one per theorem.  All four
direct warning-as-error compilations pass, and the aggregate
`IUTThreeClosures` target completes 9,239 jobs.  The dependency union is only
`propext`, `Classical.choice`, and `Quot.sound`.  The computation directories
replay the actual Haar
normalization witness, the complete prime scan through \(10^9\), every affine
arithmetic witness and catalogue identity, and the 57-index Pell certificate
table.  Input hashes and the sealed validation digest are recorded by the
companion verification package.

Lean does not formalize the weighted Brun--Titchmarsh theorem, the uniform
totient-ratio estimate, the Yamada-type asymptotic input, a complete IUT tensor
and same-pilot realization, the final affine subcatalogue aggregation, or the
global Pell exclusion.  None is introduced as an axiom.  These are the exact
remaining mathematical obligations rather than reasons to retire their
routes.

## 7. Checkpoint verdict

All four parent routes remain active.  The checkpoint supplies new positive
structure and stronger obstruction tests:

* actual finite-positive Haar regions and their unbounded uniformizer orbit;
* an unconditional paper-level closure of the Mersenne low one-copy arm at
  \(\sigma=1\), with the other arms reduced to two explicit estimates;
* exact singleton cancellation and inverse-period Euler structure in the
  affine energy;
* a sharp \(U^2\) Pell endpoint determinant and a direct factor-quotient jet.

It also removes only the false subclaims exposed by full-premise witnesses:
raw weight normalization, pointwise domination between the two surviving
Mersenne arms, several incidence-only affine savings, reverse jet/ledger
equivalence, local-ledger inconsistency, and cubic Pell determinant
divisibility.  No witness here is a counterexample to abc, and no theorem here
is an unconditional proof of abc.
