# Finite-place normalization audit

## Executive result

The finite-place relation currently used by the pinned `lana-agents/iut` source is stronger than arithmetic lying-over.

For number fields `K/k`, a finite place `w` of `K` above a finite place `v` of `k` is represented by prime ideals

\[
\mathfrak P\subseteq \mathcal O_K,\qquad
\mathfrak p=\mathfrak P\cap\mathcal O_k.
\]

With the globally normalized finite absolute values used by Mathlib,

\[
|x|_v=N(\mathfrak p)^{-\operatorname{ord}_{\mathfrak p}(x)},\qquad
|y|_w=N(\mathfrak P)^{-\operatorname{ord}_{\mathfrak P}(y)}.
\]

If `e=e(𝔓/𝔭)` and `f=f(𝔓/𝔭)`, then for `x∈k`

\[
\operatorname{ord}_{\mathfrak P}(x)=e\operatorname{ord}_{\mathfrak p}(x),
\qquad N(\mathfrak P)=N(\mathfrak p)^f,
\]

and therefore

\[
|x|_w=|x|_v^{ef}.
\]

Thus literal equality `|x|_w=|x|_v` for every `x∈k`, which is what
`AbsoluteValue.LiesOver` records, normally holds only when the local degree
`ef` is one.  Ordinary lying-over requires only contraction of prime ideals.

## Concrete counterexample

Let `k=ℚ`, `K=ℚ(i)`, and consider the rational prime `3`.  It is inert in
`ℚ(i)`, so the unique prime `𝔓` over `(3)` has `e=1` and `f=2`.  Hence

\[
|3|_{\mathfrak P}=N(\mathfrak P)^{-1}=9^{-1},
\qquad |3|_3=3^{-1}.
\]

The prime ideal lies over `(3)` in the standard arithmetic sense, but the two
normalized absolute values are not literally equal after restriction.

## Consequences for the pinned IUT interface

Two source definitions use the strict relation.

1. `Iut.ValuationSection.sectFin_liesOver` asks for a strict lift of every
   finite place of the field of moduli to the torsion field.
2. `Iut.badPlacesOver` defines the bad places of `F` using the same strict
   relation.

The second use creates a non-vacuity problem.  The global structure requires
`V_mod^bad` to be nonempty, but this does not imply that the strict set
`badPlacesOver F E VBad` is nonempty.  If that strict set is empty, then the
following fields can be satisfied vacuously:

- multiplicative reduction at places over `V_mod^bad`;
- Tate parameters and uniformizers at bad places;
- coprimality with Tate orders;
- all constructions indexed by an actual bad Hodge-theater place.

The `q`-pilot bad-place finset may then be empty and its logarithmic sum may
collapse to zero, despite the intended nonempty bad locus.

There is also a global obstruction to the old valuation-section requirement.
For a nontrivial finite extension, a transitive Galois-closure action has a
derangement.  Chebotarev supplies primes with that Frobenius class, hence
primes having no local-degree-one factor.  Such a prime has no strict lift.
This argument is a mathematical diagnosis; the pinned Mathlib version does not
currently provide the Chebotarev theorem needed to certify the global no-go in
Lean.

## Lean-verified repair in this repository

`IUTThreeClosures/ValuationSectionNormalization.lean` introduces

```lean
def FiniteIdealLiesOver (w : FinitePlace K) (v : FinitePlace k) : Prop :=
  w.maximalIdeal.asIdeal.comap (algebraMap (𝓞 k) (𝓞 K)) =
    v.maximalIdeal.asIdeal
```

and proves, without any IUT or abc hypothesis:

- strict `AbsoluteValue.LiesOver` implies `FiniteIdealLiesOver`;
- every finite base place has an ideal-theoretic lift, by going-up;
- every nonempty finite-place locus has a nonempty corrected inverse image;
- every infinite place has an exact lift, by extension of complex embeddings;
- the corrected mixed finite/infinite valuation-section type is inhabited;
- the old strict bad-place set is contained in the corrected bad-place set.

The repair deliberately does **not** manufacture an inhabitant of the stronger
upstream `Iut.ValuationSection`.

## Correct normalization for later volume formulas

When local absolute values must be compared numerically, one must retain the
local degree.  Equivalent options are:

1. use the identity `|x|_w=|x|_v^(ef)` explicitly;
2. renormalize the restricted upstairs absolute value by the `ef`-th root;
3. formulate places as equivalence classes of nontrivial absolute values and
   carry `e`, `f`, and `ef/[K:k]` separately.

The third option matches the existing
`CanonicalLocalDegreeWeights.lean`, where primes above a base prime receive
weight

\[
\frac{e(\mathfrak P/\mathfrak p)f(\mathfrak P/\mathfrak p)}{[K:k]}.
\]

Those weights sum to one and are the correct quantities for global height and
product-formula marginalization.

## Revised construction boundary

After this repair, the source program separates into the following honest
obligations.

1. Replace strict finite-place preimages and sections by ideal-theoretic ones.
2. Record local degrees wherever normalized absolute values or volumes are
   transported across an extension.
3. Rebuild the nonempty bad locus and choose actual Tate parameters there.
4. Construct the orbicurve/core and tempered local theta data.
5. Bind the generated Ind1/Ind2/Ind3 output relation to those actual local
   objects; the current `ActualIUTOutputRelation` parameter `D` is otherwise
   phantom.
6. Prove the source-to-envelope and IUT IV uniform estimates without inserting
   the desired abc inequality as a field.

The normalization correction removes a false obstruction and a vacuity at the
source layer.  It does not by itself prove Corollary 3.12, the IUT IV bridge, or
the abc conjecture.
