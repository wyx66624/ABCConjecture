# The index-seventeen Chebyshev curve: exact descent obstruction and the Néron--Severi no-go

## 0. Verdict

Let

\[
 C_{17}:y^2=4T_{17}(T)+5
\]

and put \(X=-2T\).  The reduced equation is

\[
 C'_{17}:y^2=q_{17}(X),
\]

where

\[
\begin{aligned}
q_{17}(X)={}&-2X^{17}+34X^{15}-238X^{13}+884X^{11}-1870X^9\\
 &+2244X^7-1428X^5+408X^3-34X+5.
\end{aligned}                                                    \tag{0.1}
\]

This fixed-index audit gives the following unconditional information.

* PARI/GP certifies the full class and fundamental-unit data of
  \(\mathbf Q(2^{1/17})\), with class number one.
* An exact global/norm/\(3\)-local calculation leaves an
  eight-dimensional \(\mathbf F_2\)-space containing the full 2-Selmer
  group.  It contains the two known independent half-divisor classes.
* The missing condition is exactly one dyadic localization statement.  The
  official Magma implementations do not compute the required
  eight-dimensional \(2\)-adic Kummer image within the available run, and a
  finite point search is not substituted for it.
* Exact Frobenius data at \(67\), together with the known Chebyshev real
  multiplication, gives

  \[
  \rho\bigl(J_{17}/\mathbf Q\bigr)=1,
  \qquad
  \rho\bigl(J_{17,\overline{\mathbf Q}}\bigr)=8.          \tag{0.2}
  \]

  Thus the hoped-for extra **rational** Néron--Severi class does not exist;
  quadratic Chabauty's inequality is not improved by this real
  multiplication.

The index-(17) residual is **not eliminated** here.  No GRH, BSD, `abc`,
search cutoff, or conjectural finiteness statement is used as a completion
step.

## 1. The two exact half-divisors

Define

\[
\begin{aligned}
u_1={}&X^8+X^7-7X^6-6X^5+15X^4+10X^3-10X^2-4X+1,\\
u_9={}&X^8-X^7-7X^6+6X^5+15X^4-10X^3-10X^2+4X+1.
\end{aligned}
\]

Direct polynomial arithmetic gives

\[
q_{17}-1=-2(X-2)u_1^2,
\qquad
q_{17}-9=-2(X+2)u_9^2.                              \tag{1.1}
\]

The corresponding Mumford divisors are rational halves of the visible
classes above \((2,1)\) and \((-2,3)\).  The uniform two-descent audit proves
that their Kummer classes are independent.  Consequently

\[
\operatorname {rank}J_{17}(\mathbf Q)\ge2.           \tag{1.2}
\]

The companion Lean theorem checks (1.1) by normalization and `ring`; it
does not formalize Jacobians or descent.

For the descent computation use the monic model

\[
\begin{aligned}
f_m(Z)=2^{16}q_{17}(-Z/2)={}&Z^{17}-68Z^{15}+1904Z^{13}-28288Z^{11}\\
 &+239360Z^9-1148928Z^7+2924544Z^5\\
 &-3342336Z^3+1114112Z+327680.                       \tag{1.3}
\end{aligned}
\]

The transformed Mumford polynomials are

\[
\begin{aligned}
U_1={}&Z^8-2Z^7-28Z^6+48Z^5+240Z^4-320Z^3-640Z^2+512Z+256,\\
U_9={}&Z^8+2Z^7-28Z^6-48Z^5+240Z^4+320Z^3-640Z^2-512Z+256.
\end{aligned}                                                   \tag{1.4}
\]

## 2. Unconditional class certification

The root algebra of (1.3) is isomorphic to
\(K=\mathbf Q(a)\), \(a^{17}=2\).  The complete executable PARI/GP input is
[`audit_scripts/p17_chebyshev_class_cert.gp`](audit_scripts/p17_chebyshev_class_cert.gp):

```gp
default(parisizemax, 4000000000);
b = bnfinit(x^17 - 2, 1);
print("CLGP=", b.clgp);
print("CERT=", bnfcertify(b));
print("DISC=", nfdisc(x^17 - 2));
quit;
```

PARI/GP 2.15.4 returns

```text
CLGP=[1, [], []]
CERT=1
DISC=54214017802982966177103872
```

According to the PARI documentation, `bnfcertify(b)=1` proves the class
group and fundamental units unconditionally.  This is the certification
step; a GRH class-bound switch used later to make the official Magma web
calculator finish generating representatives is not treated as a theorem.

## 3. Exact global, norm, and \(3\)-local ledger

Let \(S\) be all primes of \(K\) above \(2,3,17\).  The standalone Magma
V2.29-9 input is
[`audit_scripts/p17_chebyshev_global_local.m`](audit_scripts/p17_chebyshev_global_local.m).
It constructs \(K(S,2)\), imposes the global norm-square condition, and then
localizes at every prime above \(3\).  The complete output ledger is

```text
MOD3_FACTOR_DEGREES=[ <1, 1>, <16, 1> ]
GLOBAL_DIM=13 SIZE=8192 INV=[ 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 ]
S_SIZE=4 REPRESENTATIVES_S_SUPPORTED=true
REP_COORD_RANK=13 NO_NONTRIVIAL_SQUARE_PRODUCT=true BADMASK=0
D1=G.1 D9=G.12 + G.13
U1=X^8 - 2*X^7 - 28*X^6 + 48*X^5 + 240*X^4 - 320*X^3 - 640*X^2 + 512*X + 256
U9=X^8 + 2*X^7 - 28*X^6 - 48*X^5 + 240*X^4 + 320*X^3 - 640*X^2 - 512*X + 256
NORM_RANK=4 NORM_KERNEL_DIM=9
LOCAL3_AMBIENT_DIM=4 D9_LOCAL=(0 1 1 1) D1_LOCAL=(0 0 0 0)
AFTER_Q3_DIM=8 COUNTS=512,256
```

Here `LOCAL3_AMBIENT_DIM=4` is the dimension of the concatenated local
squareclass coordinate space, not the dimension of the Jacobian Kummer
image.  The factor degrees \(1,16\) give

\[
\dim_{\mathbf F_2}J_{17}(\mathbf Q_3)/2J_{17}(\mathbf Q_3)=2-1=1. \tag{3.1}
\]

The explicit divisor \(D_9\) maps to the nonzero local vector
\((0,1,1,1)\).  It therefore spans the entire local Kummer image.  Thus the
last line is an exact local condition, not a search for likely generators:
the norm kernel has \(2^9=512\) elements and its inverse image of

\[
\langle(0,1,1,1)\rangle
\]

has \(2^8=256\) elements.  Write this surviving space as \(W_3\).  Standard
odd-degree 2-descent gives

\[
\operatorname {Sel}^{(2)}(J_{17}/\mathbf Q)\hookrightarrow W_3,
\qquad \dim_{\mathbf F_2}W_3=8.                       \tag{3.2}
\]

In particular this certifies only the upper bound
\(\operatorname {rank}J_{17}(\mathbf Q)\le8\), not rank two.

### 3.1 Why the Magma `GRH` line is not an assumption

The official calculator's unconditional class-group proof exceeds its
60-second limit.  The script therefore calls

```magma
SetClassGroupBounds("GRH");
```

only while constructing candidate representatives.  We do **not** infer
that Magma's particular basis is complete merely because PARI certified its
own class and unit data.

Instead, completeness is deconditioned in two separate exact steps.  The
field has signature \((1,8)\), the script finds \(\#S=4\), and class number
one implies \(\operatorname {Cl}(\mathcal O_{K,S})[2]=0\).  The \(S\)-unit
theorem therefore gives

\[
\dim_{\mathbf F_2}K(S,2)
=(1+8-1+4)+1=13,                                      \tag{3.3}
\]

where the final \(1\) is the class of \(-1\).  This dimension uses the
unconditional PARI certificate, not Magma's GRH bound.

Second, the script checks directly that the thirteen displayed number-field
elements have odd valuation only at \(S\), and exhausts all
\(2^{13}-1=8191\) nonempty products with the exact number-field
`IsSquare` predicate.  The output

```text
REPRESENTATIVES_S_SUPPORTED=true
NO_NONTRIVIAL_SQUARE_PRODUCT=true BADMASK=0
```

proves that they are thirteen independent elements of the
thirteen-dimensional space (3.3), hence a basis.  `REP_COORD_RANK=13` is a
separate internal-coordinate consistency check.  Only after these checks
are the exact norm and local matrices read as matrices on all of \(K(S,2)\).
The GRH switch affects speed, not any premise of (3.2).

## 4. The two official local failures

The new cyclic-cover implementation `PhiSelmerGroup(f,2)` reaches the
\(3\)-adic place with the correct expected dimension one but cannot construct
a nonzero representative.  The exact terminal diagnostic is

```text
Dimension of local J[2]: 1
Dimension of J(Q_3)/2J(Q_3): 1
Dimension generated by obvious torsion: 0
Searching effective divisors of degrees 2 through 9
Failed to compute local image: Tamely ramified extensions were not sufficient.
Expected dimension was 1.  Only found dim = 0.
```

This is an algorithmic failure, not a vanishing theorem.  Section 3 repairs
this particular step: the explicit global half-divisor \(D_9\) supplies the
missing nonzero local class.

The old implementation proceeds past \(3\), but at the official
calculator's 60-second cutoff its last output is

```text
A(2,S) = (Z/2Z)^13
Bound on Selmer group after Norm criterion: 9
Considering prime 2
Dimension of local selmer group: 8
Dimension generated by 2-torsion: 0
```

No final Selmer group follows from a timeout.  In particular, the numbers
\(9\) and \(8\) do not imply that the global and local subspaces meet in
dimension two.

## 5. The exact dyadic residual

The polynomial \(Z^{17}-2\) is Eisenstein over \(\mathbf Q_2\).  Hence the
local root algebra is one totally ramified degree-\(17\) field.  The standard
local index formula gives

\[
\begin{aligned}
\dim K_2^*/K_2^{*2}&=19,\\
\dim\ker(N:K_2^*/K_2^{*2}\to\mathbf Q_2^*/\mathbf Q_2^{*2})&=16,\\
\dim J_{17}(\mathbf Q_2)/2J_{17}(\mathbf Q_2)&=8.       \tag{5.1}
\end{aligned}
\]

Let \(L_2\) be that eight-dimensional Kummer image in the
sixteen-dimensional norm kernel, and let

\[
\lambda_2:W_3\longrightarrow
\ker(N:K_2^*/K_2^{*2}\to\mathbf Q_2^*/\mathbf Q_2^{*2})/L_2
\]

be localization.  The precise missing statement is

\[
\boxed{\ker(\lambda_2)=\langle D_1,D_9\rangle.}         \tag{5.2}
\]

Both displayed classes are already known to lie in the kernel and to be
independent.  Proving the reverse inclusion would give a complete
two-dimensional 2-Selmer group and hence rank two.

A rational-\(x\) dyadic scan found only one nonzero local squareclass in the
tested range.  That observation is deliberately not part of (5.2): a
finite height or denominator cutoff cannot enumerate the degree-\(1\)
through degree-\(8\) effective divisors needed for a complete local Kummer
image.  A valid next certificate must instead give eight independent local
Kummer classes, or equivalently eight exact Hilbert/Cassels-pairing rows,
and then row-reduce the localization of the eight generators of \(W_3\).

## 6. Exact Frobenius certificate at \(67\)

The complete SageMath 10.9 input is
[`audit_scripts/p17_chebyshev_frobenius.sage`](audit_scripts/p17_chebyshev_frobenius.sage).
It uses exact finite fields and exact rational-polynomial factorization.  In
particular, its root-of-unity test has no bounded search: Sage's exact
`is_cyclotomic()` predicate is applied to every irreducible factor of the
complete off-diagonal resultant.

The output is

```text
GOOD_REDUCTION_67 True
P67 x^16 + 2*x^15 + 304*x^14 + 754*x^13 + 51164*x^12 + 120146*x^11 + 5671504*x^10 + 12134482*x^9 + 446805222*x^8 + 813010294*x^7 + 25459381456*x^6 + 36135471398*x^5 + 1031011954844*x^4 + 1017994330678*x^3 + 27499348179376*x^2 + 12121423210646*x + 406067677556641
P67_IRREDUCIBLE True
MIDDLE_COEFFICIENT 446805222
MIDDLE_MOD_67 44
ORDINARY_67 True
RATIO_RESULTANT_DEGREE 256
Z_MINUS_ONE_MULTIPLICITY 16
OFF_DIAGONAL_FACTOR_DEGREES [(16, 1), (16, 2), (32, 2), (32, 2), (32, 2)]
OFF_DIAGONAL_IS_CYCLOTOMIC [(False, 1), (False, 2), (False, 2), (False, 2), (False, 2)]
NO_NONTRIVIAL_ROOT_OF_UNITY_RATIO True
```

Thus the full Frobenius polynomial is

\[
\begin{aligned}
P_{67}(x)={}&x^{16}+2x^{15}+304x^{14}+754x^{13}+51164x^{12}
 +120146x^{11}\\
&+5671504x^{10}+12134482x^9+446805222x^8
 +813010294x^7\\
&+25459381456x^6+36135471398x^5+1031011954844x^4\\
&+1017994330678x^3+27499348179376x^2
 +12121423210646x\\
&+406067677556641.                                    \tag{6.1}
\end{aligned}
\]

For completeness, the ratio polynomial is computed as

\[
R(z)=\operatorname {Res}_x(P_{67}(x),P_{67}(xz)).       \tag{6.2}
\]

It has degree \(256\).  The diagonal ratios contribute exactly
\((z-1)^{16}\).  After removing this factor, the complete irreducible-factor
degree/multiplicity list is

\[
(16,1),(16,2),(32,2),(32,2),(32,2),                   \tag{6.3}
\]

and none of the five factors is cyclotomic.  Therefore no quotient of two
distinct Frobenius roots is a root of unity.

## 7. Endomorphisms and the two Néron--Severi ranks

This section spells out every theorem used to pass from Section 6 to
(0.2).

### 7.1 The reduction has geometric Néron--Severi rank eight

Let \(A=J_{17,\mathbf F_{67}}\) and let \(\pi\) be its Frobenius.

1. `GOOD_REDUCTION_67=True` makes specialization available.  The middle
   coefficient is \(44\pmod {67}\), so \(A\) is ordinary.
2. The characteristic polynomial (6.1) is irreducible of degree \(16=2g\).
   In the Honda--Tate description it is the minimal polynomial of \(\pi\)
   with exponent \(e=1\).  The relation
   \(e^2=[\operatorname {End}^0_{\mathbf F_{67}}(A):\mathbf Q(\pi)]\)
   therefore gives

   \[
   \operatorname {End}^0_{\mathbf F_{67}}(A)=\mathbf Q(\pi),             \tag{7.1}
   \]

   a CM field of degree \(16\).  The ordinary check is consistent with and
   independently supports the commutative case; irreducibility supplies the
   decisive exponent \(e=1\).
3. If \(\mathbf Q(\pi^n)\) were a proper subfield of \(\mathbf Q(\pi)\), two
   conjugates of \(\pi\) would have equal \(n\)-th powers.  Their quotient
   would be a nontrivial root of unity, contradicting (6.2)--(6.3).  Hence

   \[
   \mathbf Q(\pi^n)=\mathbf Q(\pi)\quad(n\ge1).          \tag{7.2}
   \]

4. Tate's isogeny theorem identifies endomorphisms over
   \(\mathbf F_{67^n}\) with the centralizer of \(\pi^n\).  Equations
   (7.1)--(7.2), followed by the union over \(n\), give

   \[
   \operatorname {End}^0_{\overline{\mathbf F}_{67}}(A)=\mathbf Q(\pi).
                                                                  \tag{7.3}
   \]

5. For a polarized abelian variety,
   \(\operatorname {NS}\otimes\mathbf Q\) is the Rosati-fixed subspace of
   \(\operatorname {End}^0\).  Rosati acts as complex conjugation on the CM
   field in (7.3), whose fixed subfield has degree eight.  Consequently

   \[
   \rho(A_{\overline{\mathbf F}_{67}})=8.               \tag{7.4}
   \]

The non-root-of-unity resultant is essential here: irreducibility alone
controls endomorphisms over \(\mathbf F_{67}\), but would not by itself rule
out new endomorphisms after finite extension.

### 7.2 Chebyshev real multiplication supplies all eight geometric classes

Write

\[
D_{17}(X)=2T_{17}(X/2)=Xg(X^2-2),                       \tag{7.5}
\]

where \(g\) is the minimal polynomial used by
Tautz--Top--Verberkmoes.  Equation (0.1) is

\[
q_{17}(X)=-2\bigl(D_{17}(X)-5/2\bigr).                 \tag{7.6}
\]

Thus \(C'_{17}\) is geometrically a quadratic twist of the member \(t=-5/2\)
of their family

\[
Y^2=Xg(X^2-2)+t.
\]

The twisting cocycle is the hyperelliptic involution, which acts as the
central endomorphism \([-1]\) on the Jacobian.  Conjugating endomorphisms by
this cocycle is therefore trivial: the quadratic twist does not alter the
\(G_{\mathbf Q}\)-action on
\(\operatorname {End}^0(J_{\overline{\mathbf Q}})\) or on
\(\operatorname {NS}(J_{\overline{\mathbf Q}})\otimes\mathbf Q\).

Their Theorem 1 and explicit correspondences embed

\[
E=\mathbf Q(\zeta_{17}+\zeta_{17}^{-1}),
\qquad [E:\mathbf Q]=8,                               \tag{7.7}
\]

in the geometric endomorphism algebra.  More precisely, the generator is
\(\alpha=[\zeta_{17}]+[\zeta_{17}]^{-1}\); the canonical Rosati involution
sends \([\zeta_{17}]\) to \([\zeta_{17}]^{-1}\), so \(\alpha\) is
self-adjoint and Rosati fixes \(E=\mathbf Q(\alpha)\).  Moreover
\(\sigma_a(\alpha)=[\zeta_{17}^a]+[\zeta_{17}^{-a}]\).  Hence

\[
E\subseteq
\operatorname {NS}(J_{17,\overline{\mathbf Q}})\otimes\mathbf Q,
\qquad
\rho(J_{17,\overline{\mathbf Q}})\ge8.                 \tag{7.8}
\]

Specialization of Néron--Severi groups at a good prime is injective after
tensoring with \(\mathbf Q\).  Combining (7.4) and (7.8) gives

\[
\rho(J_{17,\overline{\mathbf Q}})=8,
\qquad
\operatorname {NS}(J_{17,\overline{\mathbf Q}})\otimes\mathbf Q=E
\tag{7.9}
\]

under the embedding supplied by the symmetric correspondences.

Finally, \(\sigma_a\in\operatorname {Gal}(E/\mathbf Q)\) sends the
correspondence generator to

\[
\zeta_{17}^a+\zeta_{17}^{-a}.
\]

The eight conjugates are distinct (equivalently, their eigenvalues on the
eight holomorphic differentials in the proof of Tautz--Top--Verberkmoes
Theorem 1 are distinct).  Thus the Galois action on the eight-dimensional
space (7.9) is the faithful natural action on \(E\), and

\[
E^{\operatorname {Gal}(E/\mathbf Q)}=\mathbf Q.         \tag{7.10}
\]

Taking invariants in (7.9) proves the rational rank in (0.2):

\[
\boxed{\rho(J_{17}/\mathbf Q)=1.}                       \tag{7.11}
\]

### 7.3 Consequence for quadratic Chabauty

The usual quadratic-Chabauty numerical hypothesis is

\[
r<g+\rho(J/\mathbf Q)-1.                               \tag{7.12}
\]

Here \(g=8\), (3.2) gives only \(r\le8\), and (7.11) makes the right side of
(7.12) equal to \(8\).  The strict inequality is therefore not proved.  The
geometric rank eight cannot be inserted in place of the rational
Néron--Severi rank.  This closes the proposed real-multiplication shortcut,
not the curve.

## 8. Exact remaining proposition

At fixed index \(17\), the smallest descent statement left by this audit is
equation (5.2).  A certificate for it may take either of two equivalent
forms.

1. Exhibit an exact basis of the eight-dimensional local Kummer space
   \(L_2\), localize a basis of \(W_3\), and row-reduce the quotient map.
2. Exhibit the corresponding exact \(2\)-adic Hilbert/Cassels-pairing
   equations and prove that their common kernel in \(W_3\) is precisely
   \(\langle D_1,D_9\rangle\).

Once (5.2) is proved, the lower bound (1.2) gives rank exactly two.  The
separate supplied modulo-\(5\) Coleman data can then be audited for the final
rational-point classification.  Neither later implication is asserted in
this note.

## 9. Reproduction, references, and trust boundary

The frozen files are:

* [`audit_scripts/p17_chebyshev_class_cert.gp`](audit_scripts/p17_chebyshev_class_cert.gp),
  unconditional PARI class/unit certification;
* [`audit_scripts/p17_chebyshev_global_local.m`](audit_scripts/p17_chebyshev_global_local.m),
  exact global/norm/\(3\)-local Magma ledger;
* [`audit_scripts/p17_chebyshev_frobenius.sage`](audit_scripts/p17_chebyshev_frobenius.sage),
  exact Frobenius, resultant, and cyclotomic-factor ledger;
* `IUTThreeClosures/FreyPellChebyshevIndexSeventeenObstructionAudit.lean`,
  the scalar Lean companion.

Accepted external theorems used here are odd-degree hyperelliptic
2-descent, the local multiplication-by-two index formula, Honda--Tate,
Tate's finite-field isogeny theorem, the Rosati
\(\operatorname {NS}\)--endomorphism identification, and injectivity of
Néron--Severi specialization at good reduction.

Primary references include:

* W. Tautz, J. Top, and A. Verberkmoes,
  [*Explicit hyperelliptic curves with real multiplication and permutation
  polynomials*](https://doi.org/10.4153/CJM-1991-061-x), Canadian J. Math.
  **43** (1991), 1055--1064, especially Theorem 1 and Sections 3.1 and 3.3;
* J. Tate, *Endomorphisms of abelian varieties over finite fields*, Invent.
  Math. **2** (1966), 134--144;
* W. Waterhouse, *Abelian varieties over finite fields*, Ann. Sci. École
  Norm. Sup. **2** (1969), 521--560;
* the official
  [PARI `bnfcertify` documentation](https://pari.math.u-bordeaux.fr/dochtml/html-stable/General_number_fields.html#bnfcertify).

Lean checks only (1.1), the reciprocal integer-coefficient ledger of
\(P_{67}\), and \(446805222\bmod67=44\).  It does not reimplement PARI,
Magma, Sage, number fields, Jacobians, local Kummer maps, Frobenius,
irreducibility, cyclotomic factorization, endomorphism algebras,
Néron--Severi groups, or Chabauty.  No `axiom`, `sorry`, `admit`, or opaque
proof of the desired residual statement is introduced.
