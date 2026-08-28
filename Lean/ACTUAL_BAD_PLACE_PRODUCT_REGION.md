# Actual finite bad-place product region

**Author:** ChatGPT  
**Status:** unconditional source-side construction relative only to the existing
`InitialThetaData` input; this is not a proof of the abc conjecture and not an
inhabitation theorem for the full IUT III source family.

## 1. Objective

The repository already constructs, for each actual bad finite place `w`,

- the completed local field `F_w`;
- its normalized additive Haar measure `mu_w`, with
  `mu_w(O_{F_w}) = 1`;
- the genuine Tate parameter `q_w`;
- the finite-positive region
  `U_{w,j} = q_w^(j^2) O_{F_w}`;
- the exact local formula

```text
log mu_w(U_{w,j}) = j^2 L_w,
```

where `L_w` is the source-derived signed local q-pilot Haar entry.

What was still missing was an honest finite product region whose canonical
measure realizes the sum of these local logarithms.  Merely defining the sum
of the numbers `L_w` does not by itself construct such a region.

## 2. Product construction

Let

```text
W(Q) = { w : finite place | w belongs to Q.badFinset }.
```

This is a finite dependent index type.  Put

```text
F_Q = product_{w in W(Q)} F_w,
mu_Q = tensor product_{w in W(Q)} mu_w,
U_{Q,j} = product_{w in W(Q)} U_{w,j}.
```

Every coordinate region is measurable and has finite nonzero measure.  Hence
`U_{Q,j}` is an element of the repository's honest
`FinitePositiveRegion` domain for `mu_Q`.

For a finite measurable rectangle, the product-measure formula gives

```text
mu_Q(U_{Q,j}) = product_w mu_w(U_{w,j}).
```

All factors are positive and finite, so real logarithms may be taken without
an empty-set or infinite-measure inconsistency.  Therefore

```text
logVol(U_{Q,j})
  = sum_w log mu_w(U_{w,j})
  = j^2 sum_w L_w.
```

In repository notation this is

```text
(packetRegion Q j).logVolume
  = j^2 * ActualBadPlaceQPilotPacket.signedHaarLogSum Q.
```

## 3. Arithmetic divisor identity

At label one,

```text
logVol(U_{Q,1}) = signedHaarLogSum Q.
```

The previously proved local-to-global residue-cardinality calculation and
finite q-divisor assembly give

```text
-signedHaarLogSum Q
  = arithmeticDivisorDegree (qArithmeticDivisor Q).
```

Consequently the newly constructed product region satisfies

```text
-logVol(U_{Q,1})
  = arithmeticDivisorDegree (qArithmeticDivisor Q),
```

and, after dividing by `[F:Q]`,

```text
normalizedPacketLogQ Q = arithmeticLogQ Q.
```

Under the separately stated `QPilotWeightDegreeCompatible Q` condition, the
same expression equals the public scalar `Q.logQ`.

## 4. Logical status

This closes a genuine finite-product measure-theoretic gap.  It does **not**
construct:

1. `InitialThetaData` for every abc input;
2. the full IUT III possible-image or multiradial output family;
3. the Ind1--Ind3 cross-label comparison;
4. a source-derived IUT IV height inequality;
5. an unparameterized term of type `ABCConjecture`.

No field of the new construction stores a desired component formula, q-bound,
abc inequality, or target-equivalent existence statement.  The product
identity follows from the existing local regions and Mathlib's finite product
measure theorem.

## 5. Lean files

- `IUTThreeClosures/ActualBadPlaceProductRegion.lean`
- `IUTThreeClosures/ActualBadPlaceProductRegionAxiomAudit.lean`

The principal declarations are:

```text
localRegion_logVolume_eq
packetRegion_logVolume_eq_sum
packetRegion_logVolume_eq_sq_mul_signedHaarLogSum
distinguishedPacketRegion_logVolume_eq_distinguishedLabelPacketLog
neg_qPacketRegion_logVolume_eq_arithmeticDivisorDegree
normalizedPacketLogQ_eq_arithmeticLogQ
normalizedPacketLogQ_eq_publicLogQ
```
