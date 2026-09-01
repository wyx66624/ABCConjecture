# Actual algebra trace and return to the coefficient field

Author: ChatGPT. Date: 2026-08-31.

These mathematical proofs are recorded before the companion Lean module
`TraceCovariantRationalReturn20260831`. They isolate the algebraic part
of Section 3 of `ANALYTIC_UNIFORM_GATE_2026_08_31.md`. The local Galois
and logarithmic input is proved in the earlier source audit, but is not
assumed to have been formalized by these algebraic lemmas.

Let k be a characteristic-zero field. Let S and T be nonzero finite
dimensional commutative k-algebras, with dimensions d_S and d_T. A
finite field extension is the intended application; the proof also
allows the finite product algebras used in the preceding trace-dual
work. Write i_S and i_T for the algebra maps. Throughout, Tr means the
actual algebra trace of the multiplication operator, not a newly
postulated linear functional.

Fix a k-linear map F:S→T and c∈k. Suppose

```text
Tr_T(F(x)) = c * Tr_S(x)       for every x∈S.             (1)
```

This is an explicit property of the given map. The following conclusions
do not construct a local Galois arrow or assert that every such linear
map is admissible in IUT.

## 1. Exact dimension-weighted return

If F(i_S(a))=i_T(b), for a,b∈k, then

```text
d_T * b = c * (d_S * a).                                (2)
```

Indeed, multiplication by i_S(a) on the d_S-dimensional vector space S
is scalar multiplication by a; its matrix in any k-basis is a times
the identity. Its trace is therefore d_S*a. The identical argument in
T gives d_T*b. Apply (1) to i_S(a) and substitute the specified return
equality. This proves (2) with no cancellation of dimensions and no
assumption about their divisibility by a residue characteristic.

## 2. Equal dimension and a single nonzero return

If d_S=d_T=d, then d is a positive integer because the algebras are
nonzero and finite dimensional. In characteristic zero its image in k
is nonzero. Cancelling d in (2) gives

```text
b = c*a.                                                (3)
```

In particular no condition such as p∤d is required when k=Q_p.

There is a stronger conclusion when a≠0: this one return already
forces the entire coefficient line to be carried by the same scalar.
For any t∈k, linearity and i_S(a)=a·1_S give

```text
a * F(1_S) = i_T(b) = i_T(c*a) = a * i_T(c).
```

Scalar multiplication by nonzero a is injective on a k-vector space,
so F(1_S)=i_T(c). Consequently

```text
F(i_S(t)) = F(t·1_S) = t·F(1_S) = i_T(c*t).              (4)
```

Conversely, (4) supplies a return at t=1, with nonzero source 1. Thus,
under (1) and equal dimension, the existence of even one nonzero
coefficient-field input whose image belongs to the coefficient field
is equivalent to (4). The zero input alone does not imply this.

If the dimensions differ, the actual formula is
`b=c*(d_S/d_T)*a`. A valuation shift from d_S/d_T must then be retained.
Equal dimension is exposed in the statement and is not inferred from
linearity. For example the trace map S→k itself satisfies (1) with c=1
and sends i_S(a) to d_S*a. This shows exactly where the dimension enters.

## 3. Valuation preservation and exclusion of a prescribed return

Let v:k→G∪{∞} be an additive valuation, and require v(c)=0.
This requirement is stronger than merely saying c is nonzero in the
field. Equation (3), multiplicativity of v and v(c)=0 imply

```text
v(b) = v(c*a) = v(c)+v(a) = v(a).                       (5)
```

The equality includes a=b=0, since adding zero to ∞ leaves ∞.
Therefore different valuations of two specified elements a,b exclude
the pointwise return F(i_S(a))=i_T(b).

In the local application, c is an integral p-adic unit supplied by
coefficient-compatible Galois cohomology. For odd p and nonzero
ξ∈pZ_p, the logarithmic series gives v_p(log(1−ξ))=v_p(ξ), as proved
in the analytic report before formalization. Applying (5) to the two
rational logarithms then preserves the odd prime exponent of the
corresponding labelled abc endpoint. The logarithmic series, source
Galois realization, exact support condition, and arithmetic fibre bound
remain separate statements; none follows from replacing pointwise
return by membership in the same ideal hull.

## 4. Formalization boundary

The proposed companion module uses `Algebra.trace`,
`Algebra.trace_algebraMap`, actual finite module ranks, algebra maps,
linear maps and `AddValuation`. It proves the cancellation and rational-
line consequences from (1); it does not define a custom trace whose
desired value is assumed. It adds no axiom and does not modify
`ABCConjecture` or the protected downstream interface.

These are structural lemmas for the next S-unit gate, not a proof or
disproof of abc, not a general rational-return theorem for every
local Galois arrow, and not a claim that an IUT hull consists of
rational solutions.
