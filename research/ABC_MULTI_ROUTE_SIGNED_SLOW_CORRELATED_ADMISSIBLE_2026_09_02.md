# Signed rays, critical slow slack, correlated Lucas companions, and admissible IUT indices

**Author:** ChatGPT
**Date:** September 2, 2026

## Scope and retirement rule

This checkpoint advances four independent routes toward the standard abc
conjecture while running full-premise counterexample searches against every
new interface.  It does not prove or disprove abc.  A route is not abandoned
because an estimate is difficult, because a formalization is incomplete, or
because a bounded search has no hit.  A counterexample retires exactly the
statement whose complete hypotheses it satisfies; corrected parent routes
remain active.

## 1. Current-source IUT interface

The frozen public LANA `iut` snapshot is commit
`c65b28c9f9631635e742294c3a5df15759e7c74c`, observed on September 2, 2026.
Its README explicitly says that the repository does not verify IUT and treats
Corollary 3.12 as a conditional specification.  Its new concrete existence
layer constructs curve-indexed data and a conditional endpoint, but still
requires the proof package and the local, anabelian, theta, tower-arithmetic,
and prime-bound providers.

For a total set functional, a nonzero preimage-shift law quantified over all
sets is impossible: the empty set forces the shift to vanish.  Restricting
only to nonempty sets is still impossible, because the whole set is invariant
under preimage.  A narrow patch therefore introduces an explicit admissible
predicate, nonemptiness, preimage closure, and a shift law restricted to that
domain.  Exact patch replay against the frozen source and full upstream builds
of `Iut` and `Iut4Sec1` pass with 8,767 jobs.

The arithmetic seam is measured independently.  The difference map

\[
   \Delta_n:\mathbb Z^2\longrightarrow\mathbb Z/n\mathbb Z,
   \qquad (x,y)\longmapsto x-y
\]

has kernel the congruence order and is surjective, so the quotient has exact
index (n), including the natural-cardinality convention at (n=0).  For
(n>1) this order is proper although both coordinate projections are
surjective.  Thus component surjectivity cannot erase the product-order
index.

The active route must construct the actual local Haar volumes and admissible
families, calculate every factor/place tensor index, prove covariance through
the horizontal link and Ind3, and identify the pointed q-pilot after complete
transport.  None of these providers is postulated as a Lean axiom.

## 2. Mersenne critical slow slack

Let (L_m=\log\log(3m)) and let (\sigma(m)\to\infty) arbitrarily slowly.
The balanced parameters

\[
 F_\sigma(m)=\log(3m)L_m\sigma(m),\qquad
 H_\sigma(m)=\left\lfloor
 \sqrt{\frac{\log(3m)}{L_m\sigma(m)}}\right\rfloor
\]

keep the inherited low-prime and low-multiplier deep arms negligible.  Under
the proved paper-level asymptotics, failure of the Mersenne endpoint is
localized to either a high-multiplier deep arm or a near-square-root
one-copy arm.  If (\sigma=o(L_m^\eta)) for every fixed (\eta>0), these
survivors are strictly narrower than every preceding fixed-power window.
The explicit choice (\sigma(m)=\log(3+L_m)) realizes this regime.

Euler's criterion gives the exact sign

\[
  \left(\frac2p\right)=(-1)^{(p-1)/\operatorname{ord}_p(2)},
\]

and hence the full modulo-eight multiplier table.  The actual prime (1093)
has order (364), valuation two in (2^{364}-1), and multiplier three.  It
is a full-premise counterexample only to universal even multiplier.  A
saturated abstract label family separately refutes deriving the
(\sigma=1) little-oh endpoint from positivity, injectivity, and the
pointwise affine envelope alone.  It is not an exact-order prime family, so
the arithmetic (\sigma=1) target stays active.

## 3. Correlated Pell--Lucas all-order route

The companion Lucas staircase is reconstructed from the original odd-factor
product.  Its coefficients (c_j) satisfy the independently derived
correlation

\[
       (2j+1)c_j=\ell d_j,
\]

where (d_j) are the first-staircase binomial coefficients.  This produces a
coherent paired correction at every multiplication order, a common recovered
half-companion residue, cross-order determinant cancellation, opposite signs
to depth six on a hypothetical depth-three pair, and vertexwise Legendre
incidence constraints.  In the nonsquare modulo-eight classes, a hypothetical
squarefull packet forces primes (q,r) with

\[
 v_q(A_\ell),v_r(B_\ell)\ge3,
 \qquad \left(\frac qr\right)=-1,
 \qquad 2\ell\mid q+r.
\]

Independent evidence proves that every odd prime index through (271) has an
exponent-one divisor, so the corresponding product is not squarefull.  The
bounded scan performs 527,352 candidate tests and finds only
(13^2\parallel B_7), with no depth-three hit.  The product-derived
coefficient verifier checks 138,675 pairs, and 228 polynomial evaluations
reconstruct the recurrence identities.  These are exact finite theorems and
audits, not an unbounded exclusion.  At index (11), a negative row has one
negative and one positive edge; this retires only all-negative-edge rigidity.

## 4. Affine signed-ray and selected-catalogue route

For a primitive signed direction ((s,t)), scale
(L=\max(|s|,|t|)), period (T_\lambda), capture (C_\lambda), large-label
product (D_\lambda>N^2), and shifted occupancy (a=n_\lambda-1), the exact
period calculation yields

\[
 aNL<C_\lambda,
 \qquad
 a^3T_\lambda^2L^3<C_\lambda N.
\]

On a non-arm direction this gives

\[
 a^3T_\lambda^2<(B+1)(C+1)N,
 \qquad (B+1)(C+1)L^2\le N\Longrightarrow n_\lambda=1.
\]

The three canonical constant-arm directions satisfy the exact linear caps

\[
       aN<d_U,\qquad aNC<d_V,\qquad aNB<d_W.
\]

The pointwise bridge (n^3\le1+7(n-1)^3) has optimal coefficient seven.
Euler owner moments then bound the cubic energy on the deduplicated union of
the selected powerful-kernel downward catalogues.  The membership phrase is
essential: in the actual ((B,C,M)=(1,2,10)) box, the weight of all large
arm-divisor labels is (972{,}496), whereas selected owner mass is only
(1{,}072).  This full-premise counterexample retires exactly the enlarged
owner statement with selected-catalogue membership deleted.

The independent audit checks 1,776,807 cubic ledgers, 2,390,018 normalized
quadratic ledgers, 15,840 directions, 43,403 exact arm captures, and selected
catalogues in actual boxes.  A stress box contains a repeated non-arm label
and exercises the inverse-period term.  The remaining gate is a uniform bound
for that non-arm inverse-period sum together with a comparison of singleton
mass against class multiplicity.

## 5. Formal checkpoint

The companion modules are:

1. `IUTAdmissibleScalingOrderIndex20260901.lean`;
2. `MersenneCriticalSlowSlackGate20260901.lean`;
3. `PellLucasCorrelatedAllOrderExclusion20260901.lean`;
4. `AffineSignedRayCanonicalCaps20260901.lean`.

They contain 90 theorem declarations and 16 definitions.  Each module passes
direct compilation with warnings treated as errors, and the aggregate
`IUTThreeClosures` target completes 9,233 jobs.  A generated same-scope audit
asks Lean for the axioms of every theorem; the union is exactly
`Classical.choice`, `Quot.sound`, and `propext`.  The computation and source
replays are kept separate from universal claims, and no `sorry`, custom
axiom, `admit`, unconditional `ABCConjecture`, or negated `ABCConjecture` is
introduced.

## 6. Surviving work

The four most concrete next gates are:

1. realize the admissible, index-aware IUT same-pilot comparison in the actual
   local/global objects;
2. control the high-multiplier deep and near-square-root Mersenne masses at
   the arithmetic critical endpoint;
3. couple Pell factor quotients uniformly to the correlated all-order
   projective system; and
4. bound the affine non-arm inverse-period energy and force enough catalogue
   reuse against singleton novelty.

Each remains open because a theorem is missing, not because a counterexample
has refuted the route.  Proof construction and counterexample search therefore
continue on all four.
