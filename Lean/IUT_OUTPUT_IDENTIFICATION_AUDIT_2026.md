# IUT output-identification audit

**Author:** ChatGPT  
**Date:** 2026-08-28  
**Status:** exact logical reduction; no claim that IUT III or abc is proved

## 1. The issue

Suppose a multiradial procedure associates to each input `x` a collection of
possible outputs

\[
\mathcal P(x)\subseteq Y.
\]

Let `G(x,y)` be the estimate required of an output.  The weak assertion

\[
\forall x\ \exists y\in\mathcal P(x),\quad G(x,y)
\]

does not imply the pointwise assertion needed for an input-determined output
`sel(x)`:

\[
\forall x,\quad sel(x)\in\mathcal P(x)
\quad\text{and}\quad G(x,sel(x)).
\]

The difference is not terminological.  It is a quantifier and identification
problem.

## 2. Exact countermodel

Take one input and two possible outputs, `true` and `false`.  Declare both
outputs possible, declare only `true` good, and let the input-determined
selection be `false`.  Then a good possible output exists, while the selected
output is not good.

This countermodel is formalized by

```lean
existential_output_does_not_identify_selected_output
```

in `IUTOutputIdentificationAudit.lean`.

## 3. Two mathematically sufficient repairs

### 3.1 Uniqueness

If every two possible outputs for the same input are equal, then the selected
possible output must coincide with the existentially good output.  Lean:

```lean
selectedGood_of_uniquePossible
```

### 3.2 Fibre invariance

Uniqueness is stronger than necessary.  It is enough to prove that the desired
estimate transports between all possible outputs in the same fibre:

\[
y,z\in\mathcal P(x),\ G(x,y)\Longrightarrow G(x,z).
\]

Then any selected possible output inherits the estimate.  Lean:

```lean
selectedGood_of_possibleOutputTransport
selectedGood_of_fibreInvariant
```

## 4. Relation to the current public formalization

The pinned `lana-agents/iut` dependency explicitly treats the theta-pilot
region as input data.  Its containment in the mono-analytic log-shell is also
an explicit field, not a theorem derived from the multiradial algorithm.  The
same package states that its `Corollary312Variant` is a proposition-valued
specification without a proof and must not be identified with the published
Corollary 3.12.

Project LANA's July 2026 interim report independently identifies two related
unresolved points in the passage from IUT III, Theorem 3.11 to Corollary 3.12:

1. why two q-pilot log-volume computations are tautologically equivalent;
2. how one of several possible algorithm outputs is identified with the data
   determined by the input.

The new Lean audit formalizes the second issue at its minimal logical level.
It does not decide whether the actual IUT geometry supplies uniqueness or
fibre invariance.

## 5. Concrete research obligation

For the IUT route to advance beyond the current interface boundary, one must
construct, from genuine Hodge-theater and Kummer data, a selected output and
prove at least one of the following:

- **pointwise identity:** the selected output equals the output used in the
  volume comparison;
- **fibre invariance:** the relevant normalized log-volume estimate is
  invariant under every Ind1/Ind2/Ind3 move connecting possible outputs;
- **canonical quotient:** all outputs descend to a quotient on which the
  estimate is well defined and the selected input data have a canonical
  class.

A set-theoretic union theorem or an existential member of the output family is
not sufficient by itself.

## 6. Route verdict

The route remains open.  The exact next target is no longer a generic bridge
record—whose inhabitation has already been shown equivalent to abc in the
repository—but a source-derived proof of pointwise output identification or
estimate invariance for the actual multiradial operations.
