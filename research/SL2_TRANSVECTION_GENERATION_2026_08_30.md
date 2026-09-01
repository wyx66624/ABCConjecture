# Generation of the actual group SL(2, F_p) by two opposite transvections

Author: ChatGPT. Date: 2026-08-30.

This note supplies a finite-group step used in the separate local Galois
calculations. It neither asserts an ABC theorem nor identifies a Frobenius or
Tate representation with a formal object. The mathematical proofs below were
written before the accompanying Lean module.

## 1. The prime-field generation theorem

Let p be any prime, let F = F_p, and write

    U(s) = [[1,s],[0,1]],       L(t) = [[1,0],[t,1]].

Both matrices belong to the actual determinant-one matrix group SL(2,F).
There is no lower bound p >= 5 in this argument.

**Theorem 1.** If H is a subgroup of SL(2,F), s and t are nonzero elements of
F, and U(s), L(t) belong to H, then H = SL(2,F).

**Proof.** Direct multiplication gives U(x)U(y) = U(x+y) and
L(x)L(y) = L(x+y). Induction on the nonnegative integer n therefore gives

    U(s)^n = U((n mod p)s),       L(t)^n = L((n mod p)t).

For an arbitrary c in F, choose the unique integer n in [0,p-1] representing
c/s. Then (n mod p)s = c, so U(c) belongs to H. Applying the same argument
to c/t puts L(c) in H for every c. In Lean this witness is exactly
`(c / s).val`, with the equality justified by `ZMod.natCast_zmod_val`;
no enumeration of matrices or subgroups is used.

For completeness, these two root groups generate SL(2,F) by elementary
matrix operations. If g = [[a,b],[c,d]] has determinant one and a is nonzero,
then

    g = L(c/a) diag(a,a^(-1)) U(b/a).

Indeed the lower-right entry of the right side is cb/a + a^(-1), which
equals d because ad-bc=1. The diagonal factor has the exact decomposition

    diag(a,a^(-1))
      = U(a)L(-a^(-1))U(a)U(-1)L(1)U(-1).

For example the first three factors give [[0,a],[-a^(-1),0]] and the last
three give [[0,-1],[1,0]]. If a=0, the determinant condition implies c is
nonzero, and U(1)g has nonzero upper-left entry c. The previous case applies
to U(1)g, and multiplication by U(-1) recovers g. Thus every g lies in H.
This also proves the result in characteristics two and three. QED.

The prime-field hypothesis matters: powers of U(s) in a nonprime finite
field only yield the F_p-line F_p s of upper parameters. The theorem as
stated does not replace F_p by an arbitrary finite field.

The Lean proof uses mathlib's already proved
`Matrix.SL2.transvection_induction` for the final
elementary-matrix generation step. Its local source is
`Lean/.lake/packages/mathlib/Mathlib/LinearAlgebra/Matrix/SpecialLinearGroup.lean`,
at the declaration following `diag2_decompose` (line 782 in this checkout).
The preceding argument independently supplies the mathematics behind that
last call. The matrices are mathlib's `SpecialLinearGroup.transvection`
with indices (0,1) and (1,0).

## 2. Retention in a normal subgroup of coprime index

**Lemma 2.** Let G be a group, N a normal subgroup of finite index m, and
x an element of G with x^n=1. If gcd(n,m)=1, then x belongs to N.

**Proof.** The image xbar in G/N has order dividing n, since xbar^n=1.
Lagrange's theorem also makes its order divide m. Hence its order is one,
so xbar is the identity and x belongs to N. QED.

The Lean statement permits an arbitrary natural number n and
uses mathlib's `N.index = Nat.card (G / N)`. Mathlib assigns cardinal zero
to an infinite quotient. If this index is zero, coprimality forces n=1
and the assertion is immediate. Thus no false finite-cardinality assertion
is introduced by using the general library index.

**Corollary 3.** For p prime, every normal subgroup N of SL(2,F_p) whose
index is coprime to p is the whole group.

**Proof.** For every s, the power formula gives U(s)^p=1 and L(s)^p=1.
Lemma 2 puts U(1) and L(1) in N. Their parameters are nonzero in F_p, so
Theorem 1 gives N=SL(2,F_p). QED.

More generally, if a group G contains the image of a homomorphism
rho: SL(2,F_p) -> G and N is normal in G with index coprime to p, each
rho(U(s)) and rho(L(t)) belongs to N by Lemma 2. Their images generate
the entire image of rho, so rho(SL(2,F_p)) is contained in N. Neither
injectivity nor surjectivity of rho is needed for this consequence.

## 3. Two distinct fixed lines: precise additional mathematical scope

The following linear algebra explains where Theorem 1 can be applied in
a matrix representation. It is stated separately so that a proof about
standard U and L matrices is not mistaken for an automatic statement about
the actual arithmetic representation.

**Proposition 4.** Let Gamma be a subgroup of GL(2,F_p). Suppose it contains
A=I+N_A and B=I+N_B, where N_A and N_B are nonzero, N_A^2=N_B^2=0, and
ker(N_A) and ker(N_B) are distinct. Then Gamma contains SL(2,F_p).

**Proof.** A nonzero square-zero endomorphism of a two-dimensional vector
space has rank one, and its image equals its one-dimensional kernel.
Choose nonzero v_1 in ker(N_A) and v_2 in ker(N_B). Distinctness makes
(v_1,v_2) a basis. Since v_2 is not in ker(N_A), there is a nonzero s with
N_A(v_2)=s v_1. Similarly N_B(v_1)=t v_2 for nonzero t. Thus, in this
single common basis, A=U(s) and B=L(t). Both have determinant one.

If P is the change-of-basis matrix, the subgroup
(P^(-1) Gamma P) intersect SL(2,F_p) contains these U(s) and L(t), so is
all of SL(2,F_p) by Theorem 1. Finally P SL(2,F_p) P^(-1)=SL(2,F_p),
because conjugation preserves determinant. This gives the stated
containment in the original coordinates. QED.

**Corollary 5.** Suppose Gamma <= GL(2,F_p) acts irreducibly and contains
one nonidentity transvection A=I+N with N^2=0. Then Gamma contains
SL(2,F_p). If Delta is a normal subgroup of Gamma of index coprime to p,
Delta also contains SL(2,F_p).

**Proof.** Let ell=ker(N). If every gamma in Gamma fixed ell, the
representation would be reducible. Hence some gamma has gamma(ell)
different from ell. The conjugate B=gamma A gamma^(-1) is a nonidentity
transvection with fixed line gamma(ell), and Proposition 4 applies.
Also A^p=B^p=1: for a square-zero N, induction gives (I+N)^n=I+nN.
Lemma 2, applied in Gamma, puts A and B in Delta. Proposition 4 now
applies to Delta. QED.

This is not a classification of all subgroups of GL(2,F_p). In particular,
the requirement of a *nonidentity* unipotent element and the requirement
of two distinct fixed lines cannot be dropped from Proposition 4.

## 4. Formalization boundary and verification

The exclusive new module is
`Lean/IUTThreeClosures/SL2TransvectionGeneration20260830.lean`.
It formalizes the actual standard-matrix generation theorem, the
normal-subgroup coprime-index lemma, and directly applicable image
consequences. The proof choosing a common basis from two different fixed
lines in Section 3 remains a separate mathematical argument unless
explicitly listed as a checked Lean declaration below.

No axiom for irreducibility of an arithmetic representation, a Frobenius
polynomial, Tate uniformization, a local Galois group, or ABC is introduced.
No frozen source module, aggregate import, paper input, PDF, or source
manifest is changed by this work.

The actual checked namespace is
`IUTThreeClosures.SL2TransvectionGeneration20260830`. Its public theorems
are exactly the following twelve declarations:

| Declaration | Checked mathematical content |
| --- | --- |
| `transvection_nat_pow` | The root power formula over every commutative ring |
| `transvection_parameter_mem` | The explicit `(c/s).val` witness in F_p |
| `subgroup_eq_top_of_upper_lower` | Theorem 1 for actual SL(2,ZMod p) and Subgroup |
| `transvection_pow_prime` | Every standard transvection has p-th power one |
| `hom_mem_of_upper_lower` | Membership of every special-linear image |
| `hom_range_le_of_upper_lower` | Inclusion of the complete homomorphism range |
| `toGL_mem_of_upper_lower` | The same conclusion in the actual GL(2,ZMod p) |
| `mem_normal_of_pow_eq_one_of_coprime_index` | Lemma 2 with the general library index |
| `hom_mem_normal_of_coprime_index` | Retention of each special-linear image |
| `hom_range_le_normal_of_coprime_index` | Retention of the whole image subgroup |
| `normal_eq_top_of_coprime_index` | Corollary 3 for actual SL(2,ZMod p) |
| `toGL_mem_normal_of_coprime_index` | Actual embedded SL2 retained in a normal GL2 subgroup |

The two public definitions `upper` and `lower` are the actual determinant-one
matrices, not an abstract replacement group. No declaration in this table
asserts Proposition 4's change-of-basis step or Corollary 5's arithmetic
application to a particular Galois representation.

Verification on 2026-08-30:

* `lake env lean IUTThreeClosures/SL2TransvectionGeneration20260830.lean`,
  with working directory `E:\AImath\abc猜想\Lean`, returned exit 0 with no
  errors or warnings.
* Independently, the complete current source was passed to
  `lake env lean --stdin`, followed by `#print axioms` for **all twelve**
  public theorems and for both public definitions. This returned exit 0.
  Each of the fourteen audits listed only `propext`, `Classical.choice`,
  and `Quot.sound`; there were no additional axioms.
* Lean source SHA256:
  `57417673188b1bdebcf4c8f60acf363cac70a4976503cebcc5ce4fa2e68b8af6`.

Representative commands, after importing this new module, are:

```lean
#print axioms IUTThreeClosures.SL2TransvectionGeneration20260830.subgroup_eq_top_of_upper_lower
#print axioms IUTThreeClosures.SL2TransvectionGeneration20260830.toGL_mem_of_upper_lower
#print axioms IUTThreeClosures.SL2TransvectionGeneration20260830.mem_normal_of_pow_eq_one_of_coprime_index
#print axioms IUTThreeClosures.SL2TransvectionGeneration20260830.hom_range_le_normal_of_coprime_index
#print axioms IUTThreeClosures.SL2TransvectionGeneration20260830.normal_eq_top_of_coprime_index
```

Only the two new files named in this note were changed. No exhaustive
subgroup enumeration or additional arithmetic hypothesis was used to
establish the displayed matrix-group conclusions.
