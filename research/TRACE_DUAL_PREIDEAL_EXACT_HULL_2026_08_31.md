# The exact hull of a maximal-order ideal transported before taking its span

Author: ChatGPT. Mathematical proof completed 2026-08-31.

This proves a stronger local result than the previously established sandwich.
It concerns the same explicitly defined maximal-order ideal, with the same
linear arrows. It is not an identification with the entire published IUT
pilot family, and is not an abc proof or disproof.

The proof below was completed and independently checked by the arithmetic
geometry research agent before any new Lean implementation of this step.
The existing local logarithm, inverse-different and Galois realization
theorems remain mathematical source dependencies, not new formal axioms.

## 1. The exact objects and the general upper bound

Let E/Q_p be a finite Galois extension with ramification index e. Assume its
different has valuation exponent e-1, as holds in the tame situation used
in the companion calculations. Normalize v(p)=1, choose a uniformizer beta,
and put kappa=(e-1)/e and I=beta^(1-e) O_E, the inverse different.
Let m>=1, and define

    T = E tensor_(Q_p) ... tensor_(Q_p) E,             m factors,
    A = O_E tensor_(Z_p) ... tensor_(Z_p) O_E,
    B = the integral closure of Z_p in T.

The tensor order A is regarded as its image in T. It is an integral full
lattice, and A is contained in B. The finite etale algebra T is a product
of copies of E. Under any of the usual Galois decompositions, B is the
product of the corresponding copies of O_E.

For a full lattice L in T, write

    L^vee = {x in T : Tr_(T/Q_p)(xy) in Z_p for every y in L}.

Here Tr_(T/Q_p) is the algebra trace, which is the sum of field traces on
the product factors. In particular,

    B^vee = product I,
    B^vee is contained in A^vee,
    A^vee = I tensor_(Z_p) ... tensor_(Z_p) I.          (1.1)

The first equality uses the individual product idempotents in B: trace
integrality is tested independently in each component. There is no factor
equal to the number of components. The containment reverses A contained
in B. For the last equality choose an integral basis of O_E and its
trace-dual basis of I in each factor. Trace on a pure tensor is the
product of the field traces, so the tensor bases are dual bases.

Fix nonzero a in O_E. Put

    z = a tensor 1 tensor ... tensor 1,
    r = v(a),           k = floor(r+kappa).

Let Gamma be any family of Q_p-linear maps Phi:T->T such that

    Phi(A^vee) is contained in A^vee.                 (1.2)

The maps need not be B-linear. Define the actual transported-ideal hull

    M_Gamma(a) = closure of Span_B {Phi(x) : Phi in Gamma, x in zB}.

**Theorem 1.** For these exact objects,

    M_Gamma(a) is contained in beta^(e*k-(e-1)*m) B.   (1.3)

**Proof.** In every component of T, the image of z has valuation r.
Since k<=r+kappa, every component of p^(-k)zB has valuation at least
-kappa. Therefore

    p^(-k) zB is contained in B^vee,
    zB is contained in p^k B^vee,
    zB is contained in p^k A^vee.                    (1.4)

Apply an arrow Phi. Its Q_p-linearity and (1.2) give

    Phi(zB) is contained in p^k A^vee.

Taking the B-span yields

    Span_B Phi(zB) is contained in p^k Span_B A^vee.

By (1.1), A^vee is the tensor product of m copies of the principal ideal
beta^(1-e)O_E. Its B-span has valuation -(e-1)m in each component and
is exactly beta^(-(e-1)m) B. Since p is a unit times beta^e, the last
containing ideal is beta^(e*k-(e-1)m) B. This is a closed product lattice,
so taking closure preserves the inclusion. This proves (1.3).

Equivalently, (1.4) can be checked directly against the trace pairing:
zBA is contained in zB, and every component of p^(-k)zB belongs to the
inverse different, so its product with each integral component has
integral trace. The proof does not move a B-span across a nonlinear
or non-B-linear arrow. QED.

## 2. Equality from the already constructed point witness

**Corollary 2.** If Gamma contains an arrow Phi_0 for which every component
of Phi_0(z) has valuation k-m*kappa, then

    M_Gamma(a) = beta^(e*k-(e-1)*m) B.               (2.1)

**Proof.** Since z belongs to zB, the element Phi_0(z) belongs to the
generating set defining M_Gamma(a). Its principal B-ideal is the whole
right side of (2.1), since its component valuations agree with those of
that ideal. This proves the reverse inclusion to (1.3). QED.

In the companion setting, Phi is a tensor product of m integral local
Galois--Kummer arrows F_i:E->E, each preserving I. Hence it preserves
A^vee=I tensor ... tensor I. The same diagonal arrow constructed by
finite-family avoidance gives the required point witness. The earlier
logarithm-to-root bridge proves the point valuations for z itself from
the Kummer-logarithm witness; it does not assert an equality of their
transported vectors. Thus both (1.2) and the exact lower witness have
already been supplied by the mathematical local constructions.

This also applies to any larger family of Q_p-linear maps preserving
A^vee and retaining that witness. Neither equality of the family with
all GL maps nor a homomorphic section of a linear-action map is needed.

## 3. The two applications and the remaining larger source

For the degree-210 native example at p=139, let

    e=105, kappa=104/105, a_j=q^(j^2/14),
    j=1,2,3, m=j+1, k_j=ceil(j^2/7).

The existing common point witness therefore gives exactly

    M_Gamma(a_j) = P_j
       = pi^(105*k_j-104*(j+1)) B_m.

The three exponents are -103, -207 and -206. For the separate whole
product source a_j I times I^(m-1), the previous proof still gives

    S_j = pi^(105*floor(j^2/7)-104*(j+1)) B_m = p^(-1)P_j.

In particular M_Gamma(a_j)=P_j is strictly smaller than S_j. The earlier
sandwich P_j contained in M_Gamma(a_j) contained in S_j remains correct;
the present argument settles the endpoint for the very same middle set.

For the general tame family with p=-1 mod 30*ell, e=15*ell and native
v(q)=4, put a_j=q^(j^2/(2*ell)) and 1<=j<ell/2. Then

    k_j=ceil(2*j^2/ell),       m=j+1,
    M_Gamma(a_j)=P_j=beta^(e*k_j-(e-1)*m) B_m,
    S_j=beta^(e*floor(2*j^2/ell)-(e-1)*m) B_m=p^(-1)P_j.

All labels use the one previously constructed simultaneous arrow.
Changing to standard logarithmic coordinates at all m tensor factors
scales each stated source and hull by p^m; the equality M=P is unchanged
after that consistent conversion. It does not authorize scaling just the
distinguished factor or changing one side of a volume comparison alone.

## 4. Scope of the improvement

The proof closes the pre-ideal versus point-hull gap for these specified
local objects. It leaves untouched the need to identify the complete
published global family, its markings and weights, the remaining Ind3
operation, and the comparison across Frobenius structures. In particular,
the equality M=P does not convert the larger whole-product source S into
the same source; their strict difference remains explicit.

No unconditional Lean term of type ABCConjecture, or of its negation,
follows merely from this local equality.
