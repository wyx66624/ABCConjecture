# Prime-index Chebyshev curves at 19 and 23: exact odd-place scaling and the dyadic wall

## 0. Verdict

For an odd prime (p), put

\[
 C_p:y^2=4T_p(x)+5,\qquad g=(p-1)/2,
 \qquad K_p=\mathbf Q(a),\quad a^p=2.
\]

This note tests whether the exact descent obstruction isolated at (p=17)
shrinks at the next two prime indices.  It does not.

* At (p=19), PARI unconditionally certifies
  \(\operatorname {Cl}(K_{19})=1\).  An independently deconditioned Magma
  computation gives

  \[
  \dim K_{19}(S,2)=14\longrightarrow
  \dim\ker N=10\longrightarrow
  \dim W_{19}^{\rm odd}=9=g.
  \]

  Thus the fixed-index residual is exactly a rank-seven dyadic
  transversality assertion.
* At (p=23), the exact Magma matrices on its generated candidate space give

  \[
  17\longrightarrow13\longrightarrow11=g.
  \]

  The PARI class-group candidate is trivial, but an unconditional
  `bnfcertify` run was stopped after 27 minutes without returning.  The
  (p=23) line is therefore recorded only as a pattern diagnostic, not as an
  unconditional complete global descent.

Neither computation proves a uniform upper bound, eliminates (p=19) or
(p=23), or supplies a counterexample.  The stable pattern says that the odd
places consume exactly the expected factor-count directions and leave a
space of genus size.  All decisive information is still the *position* of
that space relative to the dyadic Kummer Lagrangian.

No GRH, BSD, finiteness of \(\Sha\), `abc`, or Szpiro statement is used in
the unconditional (p=19) conclusion.

## 1. Common dimension ledger

Let (S) consist of all primes of (K_p) over (2,3,p), and let

\[
 r_3=1+{p-1\over\operatorname {ord}_p(3)}
\]

be the number of factors of (X^p-2) over \(\mathbf Q_3\).  In the
non-Wieferich branch there is one prime above (p).  If the relevant
(S)-class 2-torsion vanishes, the (S)-unit theorem and the global norm
condition give

\[
 \dim K_p(S,2)=g+r_3+3,
 \qquad \dim\ker N=g+r_3-1.                       \tag{1.1}
\]

At (3), the local Kummer quotient has dimension (r_3-1).  Consequently,
if localization has full rank on those directions, the odd-place survivor
has dimension

\[
 (g+r_3-1)-(r_3-1)=g.                             \tag{1.2}
\]

Equation (1.2) is only dimension arithmetic until full rank is proved.  The
Magma computations below prove it for the displayed candidate spaces at
(19) and (23); no finite collection of samples proves it for general
(p).

The two rational half-divisors from the uniform descent have Kummer classes

\[
 D_1=[a-1],\qquad D_9=[3(a+1)],
 \qquad E_p=\langle D_1,D_9\rangle.               \tag{1.3}
\]

They are independent and belong to every local Kummer image.

## 2. The unconditional (p=19) certificate

### 2.1 Class group

The complete PARI/GP 2.15.4 input is
[`audit_scripts/p19_chebyshev_class_cert.gp`](audit_scripts/p19_chebyshev_class_cert.gp).
It returns

```text
CLGP=[1, [], []]
CERT=1
DISC=-518630842213417245507316350976
```

The last value is

\[
 -2^{18}19^{19},
\]

as predicted by the pure-field discriminant formula.  The value
`bnfcertify=1` certifies the complete class and fundamental-unit data
unconditionally.

### 2.2 Exact norm and (3)-local matrices

The complete Magma V2.29-9 input is
[`audit_scripts/p19_chebyshev_global_local.m`](audit_scripts/p19_chebyshev_global_local.m).
Its output is

```text
MOD3_FACTOR_DEGREES=[ <1, 1>, <18, 1> ]
GLOBAL_DIM=14 SIZE=16384 INV=[ 2, ..., 2 ]
S_SIZE=4
REPRESENTATIVES_S_SUPPORTED=true
NO_NONTRIVIAL_SQUARE_PRODUCT=true BADMASK=0
D1=G.1 + G.14 D9=G.11
NORM_RANK=4 NORM_KERNEL_DIM=10
LOCAL3_AMBIENT_DIM=4 LOCAL3_RANK=4
D1_LOCAL=(0 0 0 0) D9_LOCAL=(0 0 1 0)
AFTER_Q3_DIM=9 COUNTS=1024,512
```

Local squareclass coordinates depend on the chosen local bases; only zero,
linear independence, and matrix ranks are invariant.

Although the script asks Magma for fast class bounds while generating
representatives, completeness does not depend on that request.  The PARI
certificate gives class number one.  The signature ((1,9)) and
(#S=4) therefore give the theoretical dimension (14).  The script then
checks that all fourteen representatives have even valuation away from
(S), and exhausts all (2^{14}-1) nonempty products with exact
number-field `IsSquare`.  Thus they are fourteen independent elements of a
fourteen-dimensional space and form an unconditional basis.

Since (X^{19}-2) has two factors over \(\mathbf Q_3\),

\[
 \dim J_{19}(\mathbf Q_3)/2J_{19}(\mathbf Q_3)=1.
\]

The nonzero image of (D_9) spans this local Kummer image.  Exhaustive
enumeration of the (2^{10}) norm candidates shows that exactly (2^9)
survive it.  Hence

\[
 \boxed{\dim W_{19}^{\rm odd}=9.}                  \tag{2.1}
\]

### 2.3 Exact dyadic residual

The extension \(\mathbf Q_2(2^{1/19})/\mathbf Q_2\) is totally ramified of
odd degree (19).  The standard local index formula gives

\[
 \dim\mathscr N_{2,19}=18,
 \qquad \dim L_{2,19}=9,
 \qquad \dim(\mathscr N_{2,19}/L_{2,19})=9.         \tag{2.2}
\]

Let

\[
 \lambda_{2,19}:W_{19}^{\rm odd}\longrightarrow
       \mathscr N_{2,19}/L_{2,19}
\]

be dyadic localization modulo the local Kummer image.  Since (E_{19}) is
already in its kernel, the desired fixed-index statement is

\[
 \boxed{\ker\lambda_{2,19}=E_{19}.}                 \tag{2.3}
\]

By (2.1), (2.3) is equivalently the assertion that the induced map

\[
 W_{19}^{\rm odd}/E_{19}\longrightarrow
 \mathscr N_{2,19}/L_{2,19}
\]

has rank (9-2=7).  A direct `PhiSelmerGroup` call did not finish in the
official 60-second limit, both with unconditional class bounds and with a
fast bound.  A timeout is not evidence for any Selmer dimension.

## 3. The (p=23) pattern diagnostic

The script
[`audit_scripts/p23_chebyshev_global_local.m`](audit_scripts/p23_chebyshev_global_local.m)
uses the pure-field presentation (a^{23}=2).  It returns

```text
MOD3_FACTOR_DEGREES=[ <1, 1>, <11, 1>, <11, 1> ]
GLOBAL_DIM=17 SIZE=131072
S_SIZE=5
D1=G.2 D9=G.4 + G.14 + G.15
NORM_RANK=4 NORM_KERNEL_DIM=13
LOCAL3_AMBIENT_DIM=6 LOCAL3_RANK=6
D1_LOCAL=(0 0 0 1 0 1)
D9_LOCAL=(0 1 1 1 1 1)
L3_DIM=2
AFTER_Q3_DIM=11 COUNTS=8192,2048
```

Here (r_3=3), so the two independent displayed local classes span the
entire two-dimensional (3)-adic Kummer image.  The exact matrix arithmetic
on the generated candidate space gives (13\to11), again leaving genus
size.

This is not yet an unconditional global certificate: the script uses a GRH
class bound to generate the 17 representatives, and the separate PARI run
did not finish its proof step.  In particular, the output must not be used
to assert that no additional (S)-class squareclasses exist.  Conditional
on completeness of this candidate space, the dyadic rank required at
(p=23) would be (11-2=9).

## 4. Uniform consequence and exact remaining theorem

The computations at (17,19,23) exhibit the same clean-branch pattern:

\[
 \dim W_p^{\rm odd}=g,
 \qquad \dim L_{2,p}=g,
 \qquad E_p\subset W_p^{\rm odd}\cap L_{2,p}.        \tag{4.1}
\]

Dimensions alone do not determine the intersection of two (g)-dimensional
subspaces in a (2g)-dimensional quadratic or symplectic space, even when a
fixed two-plane lies in the intersection.  The exact clean-branch theorem
still needed is

> The map
> \[
> \bar\lambda_{2,p}:W_p^{\rm odd}/E_p
>   \longrightarrow\mathscr N_{2,p}/L_{2,p}
> \]
> has full column rank (g-2) for every relevant prime (p\ge17).

For primes with surviving (S)-class 2-torsion, this must be enlarged by
the class-correction kernel in
`FREY_PELL_CHEBYSHEV_UNIFORM_SELMER_EXACT_RESIDUAL.md`; it is not legitimate
to assume the clean branch uniformly.  Under the BSPT hypotheses, ordinary
2-class group elements inject into the Selmer group, so a universal
two-dimensional Selmer theorem would itself imply a uniform pure-field
2-class vanishing theorem.

The accepted BSPT upper bound is only

\[
 \dim\operatorname {Sel}_2(J_p)
 \le \dim\operatorname {Cl}(K_p)[2]+g,
\]

and therefore stops at genus size even when the class group is trivial.
Stoll and Poonen--Schaefer provide exact fixed-field algorithms, not a
theorem forcing the rank-((g-2)) dyadic matrix above.  No accepted uniform
Coleman, modular, or moving-field descent theorem located in this audit
supplies that rank.

## 5. Trust boundary

The companion Lean file
`IUTThreeClosures/FreyPellChebyshevPrimeNineteenTwentyThreeOddPlaceAudit.lean`
checks:

* the exact (p=19) discriminant integer;
* the reduced (p=19) half-factor identities;
* the scalar dimension ledgers (14\to10\to9) and (17\to13\to11);
* the rank-((g-2)) consequence of a two-dimensional kernel.

Lean does not reimplement PARI, Magma, class groups, local fields,
Jacobians, Kummer maps, or Selmer groups.  The (p=23) computation remains
explicitly conditional as described above.  No axiom asserting (2.3), its
(p=23) analogue, or the uniform theorem of Section 4 is introduced.

Primary references are:

* D. Barrera Salazar, A. Pacetti, and G. Tornaría,
  *On the 2-Selmer group of Jacobians of hyperelliptic curves*,
  arXiv:2308.08663, especially Theorem 5.15;
* M. Stoll, *Implementing 2-descent for Jacobians of hyperelliptic curves*,
  Acta Arith. **98** (2001), 245--277;
* the official PARI/GP documentation for `bnfcertify`;
* the official Magma documentation for `PhiSelmerGroup`, `pSelmerGroup`,
  and `LocalTwoSelmerMap`.
