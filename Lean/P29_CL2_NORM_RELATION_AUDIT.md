# P29 2-primary norm-relation audit

## Result and limitation

Let

\[
 K=\mathbf Q(2^{1/29}),\qquad
 k=\mathbf Q(\zeta_{29}),\qquad
 N=Kk,
\]

and write

\[
 G=\operatorname{Gal}(N/\mathbf Q)=P\rtimes C,qquad
 P\simeq C_{29},\quad C\simeq C_{28}.
\]

Thus `N^P = k` and `N^C = K` (up to the choice of a conjugate of `C`).
This note checks the 2-local norm-relation argument for the subgroup set
`H={P,C}`.

The conclusions are:

1. there is a BFHP norm relation supported on `P` and `C` whose denominator
   is odd;
2. if `r_K=dim_F2 Hom(Cl(K),F_2)` and
   `r_N=dim_F2 Hom(Cl(N),F_2)`, then the Galois-module amplification argument
   gives `r_N >= 28 r_K`;
3. BFHP Proposition 3.7 does **not** give `r_N <= r_K+r_k`.  A relation has
   one subfield-class-group summand for every term, including repetitions,
   and every such relation has at least 28 terms involving `C`.  Its resulting
   rank upper bound is therefore compatible with, rather than contradictory
   to, `r_N >= 28 r_K`.

In particular, the norm relation does not prove `Cl(K)[2]=0`.

## Primary reference

The source is J.-F. Biasse, C. Fieker, T. Hofmann and A. Page,
*Norm relations and computational problems in number fields*,
*J. London Math. Soc.* **105** (2022), 2373--2414,
[doi:10.1112/jlms.12563](https://doi.org/10.1112/jlms.12563).  The audited
text is the corrected [arXiv:2002.12332v4](https://arxiv.org/abs/2002.12332)
(2025).

The precise results used are:

* Proposition 2.18: for a prime `p`, the denominator attached to a subgroup
  family is prime to `p` if and only if, for every simple `F_p[G]`-module
  `V`, at least one subgroup norm `N_H` acts nontrivially on `V`.  The
  proposition is explicitly formulated using the Jacobson radical, so it
  remains valid when `p` divides `|G|`.
* Proposition 3.7: after inverting the denominator `d`, the class group of
  the Galois field is isomorphic to a direct summand of a direct sum of class
  groups of the fixed fields occurring term by term in the norm relation.

No semisimplicity of the full algebra `F_2[G]` is assumed below.

## Classification of the simple `F_2[G]`-modules

Put `R=F_2[G]`.  Since `P` has odd order, restriction to `P` is semisimple.
There are two central `C`-stable idempotents in `F_2[P]`:

\[
 e_0=N_P=\sum_{u\in P}u,
 \qquad e_1=1-e_0.
\]

Here `29=1` in `F_2`, so `e_0^2=e_0`.  They split `R` into the block on
which `P` acts trivially and the block on which `P` acts nontrivially.

### The `P`-trivial block

Every simple module in this block is inflated from `G/P=C_28`.  In
characteristic 2 the normal 2-primary subgroup `C_4` of `C_28` acts trivially
on every simple module.  Thus the simple modules are the simple modules of
`C_7`.  We have

\[
 X^{28}-1=(X^7-1)^4,
 \qquad X^7-1=(X-1)f_3(X)f'_3(X)
\]

over `F_2`, where the two cubic factors are irreducible because
`ord_7(2)=3`.  Hence this block has exactly three simple modules, of
dimensions

\[
 1,\quad 3,\quad 3.
\]

On all three, `P` acts trivially and therefore

\[
 N_P=29\,\mathrm{id}=\mathrm{id}.
\]

### The nontrivial-`P` block

The polynomial `Phi_29` is irreducible over `F_2`, since
`ord_29(2)=28`.  The nontrivial part of the regular `F_2[P]`-module is
therefore irreducible of dimension 28.  The complement `C` permutes the
nontrivial `P`-characters transitively, and this module extends to the
28-dimensional augmentation module

\[
 A=\ker\left(\mathbf F_2[G/C]\xrightarrow{\sum}\mathbf F_2\right).
\]

This is the unique simple module in the `e_1` block.  More precisely, the
block `e_1R` has dimension `28^2` and its action on `A` identifies it with
`Mat_28(F_2)`.  Thus it is a defect-zero block: every module in this block is
a direct sum of copies of `A`, even though the other block of `R` is not
semisimple.

Consequently the complete list of simple `F_2[G]`-modules has dimensions

\[
 1,\quad3,\quad3,\quad28.
\]

## Action of the two subgroup norms

On `A`, the norm `N_P` is zero.  Identify the 29 points `G/C` with `F_29`,
so `C=F_29^times` fixes 0 and acts transitively on the 28 nonzero points.
For a basis vector `delta_x` with `x != 0`,

\[
 N_C\delta_x=\sum_{y\ne0}\delta_y.
\]

This vector is nonzero and lies in `A`, since its support has even size 28.
The vector `delta_0` is killed because `|C|=28=0` in `F_2`.  It follows that

\[
 \operatorname{rank}(N_C\mid A)=1.
\]

We have therefore checked the criterion of BFHP Proposition 2.18:

* on each of the simple modules of dimensions `1,3,3`, `N_P` acts as the
  identity;
* on the 28-dimensional simple module `A`, `N_C` acts nontrivially.

Hence the norm-relation denominator `d({P,C})` is odd.  Equivalently, there
is an identity

\[
 d=\sum_i a_iN_{H_i}b_i,
 \qquad H_i\in\{P,C\},\quad a_i,b_i\in\mathbf Z[G],
 \qquad 2\nmid d.
\]

This is an existence statement.  It neither says that `P` and `C` occur
only once nor supplies a two-term scalar relation.

## Several independent characters and the factor 28

Let

\[
 X=\operatorname{Hom}(\operatorname{Cl}(K),\mathbf F_2),
 \qquad r_K=\dim X.
\]

Base-change every quadratic unramified character from `K` to `N`, and let
`Y` be the `G`-submodule of `Hom(Cl(N),F_2)` generated by all their
conjugates.

### Injectivity of base change

The base-change map

\[
 j:X\longrightarrow Y^C
\]

is injective.  If a nonzero linear combination became trivial after base
change, its quadratic unramified extension `E/K` would be contained in
`N`.  But `N/K` is cyclic of degree 28 and its unique quadratic intermediate
extension is ramified above 29, whereas `E/K` is unramified there.

### Removing the trivial-block component

For each `x in X`, the cyclic `G`-module generated by `j(x)` is a quotient
of the 29-point permutation module

\[
 \mathbf F_2[G/C]=\mathbf F_2\mathbf1\oplus A.
\]

The one-dimensional trivial quotient is arithmetically impossible.  The
needed standalone lemma is the one proved in the Galois-module audit: the
primes above 2 and 29 split in every quadratic Hilbert class extension of
`K`; if the conjugate compositum over `N` had a central quadratic quotient,
the unique local primes would give a decomposition-group complement.  The
resulting quadratic field over `Q` would be unramified outside `{2,29}`.
The complete signed list has radicands
`-1,-2,-29,-58,2,29,58`.  The 2-adic local condition eliminates every
candidate except `Q(sqrt(29))`, which is already contained in `k subset N`.
No incorrect total-reality assertion about the conjugate compositum is used.

Now project `j` with the central block idempotent `e_1`.  If
`e_1j(x)=0` for a nonzero `x`, the cyclic quotient generated by `j(x)` would
lie in the `e_0` block.  But the `e_0` component of
`F_2[G/C]=F_2 1 direct_sum A` is only the one-dimensional trivial module,
which was just excluded.  Therefore

\[
 e_1j:X\hookrightarrow(e_1Y)^C
\]

is injective.

Since the defect-zero block is a matrix algebra, write
`e_1Y isomorphic A^m`.  The orbit calculation above also gives
`dim_F2 A^C=1`.  Hence

\[
 r_K\le\dim(e_1Y)^C=m,
 \qquad \dim Y\ge28m\ge28r_K.
\]

As `Y` is a character submodule of `Hom(Cl(N),F_2)`, this proves

\[
 r_N\ge28r_K.
\]

The block projection is essential.  Arguing separately with each character
without it would leave open the possibility that their normal closures share
the same copy of `A`.

## What Proposition 3.7 actually gives

Write a chosen odd-denominator relation term by term, with `m_P` occurrences
of `P` and `m_C` occurrences of `C`.  Proposition 3.7, localized away from
the odd integer `d`, makes the 2-primary class group of `N` a direct summand
of

\[
 \operatorname{Cl}(k)_2^{\oplus m_P}
 \oplus
 \operatorname{Cl}(K)_2^{\oplus m_C}.
\]

The repetitions cannot be discarded: the coefficients `a_i,b_i` describe
a sum of two-sided rank-one terms, not a single map for each subgroup type.

There is also a sharp elementary obstruction to making `m_C` small.  Apply
the relation to `A`.  All `P` terms vanish.  Each operator

\[
 \rho(a_i)\rho(N_C)\rho(b_i)
\]

has rank at most one, while `d rho(1)` is invertible and has rank 28.
Subadditivity of matrix rank forces

\[
 m_C\ge28.
\]

Thus Proposition 3.7 yields at best a rank inequality containing at least
`28 r_K` on its right-hand side.  It cannot contradict the lower bound
`r_N>=28r_K`.  The previously contemplated inequality

\[
 r_N\le r_K+r_k
\]

is withdrawn: it does not follow from Proposition 3.7.

## Lean formalization boundary

The following finite algebra is realistic to formalize without class field
theory:

1. `orderOf (2 : ZMod 29)=28` (now checked in `P29FiniteCore.lean`) and
   `orderOf (2 : ZMod 7)=3`;
2. the factorization pattern of `X^28-1` over `F_2`;
3. the decomposition of the 29-point permutation module into constants and
   augmentation;
4. `dim A=28`, `dim A^C=1`, `N_P|A=0`, and `rank(N_C|A)=1`;
5. the rank argument `m_C>=28` for any displayed norm relation;
6. the matrix-algebra description of the `e_1` block and the resulting
   multiplicity inequality.

The following bridges are not presently available as checked Lean theorems
in the repository and must not be silently introduced as axioms:

* BFHP Proposition 2.18 over integral and modular group rings;
* BFHP Proposition 3.7 for ideal class groups;
* class-field-theoretic construction and functoriality of the character
  spaces `X` and `Y`;
* injectivity of base change via ramification of the unique quadratic
  intermediate field of `N/K`;
* the local decomposition-group and square-class exclusion of the trivial
  quotient.

Accordingly, this audit is a rigorous mathematical dependency map, not a
claim that the 2-primary class-group result is already formalized in Lean.
