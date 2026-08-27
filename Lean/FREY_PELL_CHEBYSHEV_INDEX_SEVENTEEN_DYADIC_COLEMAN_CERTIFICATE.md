# The prime-seventeen Chebyshev curve: dyadic Selmer and Coleman--Chabauty certificate

## 0. Verdict

Let

\[
 C_{17}: y^2=4T_{17}(T)+5,
 \qquad g(C_{17})=8.
\]

This note closes the unique dyadic proposition isolated in
`FREY_PELL_CHEBYSHEV_INDEX_SEVENTEEN_OBSTRUCTION_AUDIT.md` and then applies
the supplied modulo-5 Coleman calculation.  Unconditionally,

\[
 \boxed{\ker(\lambda _2:W_3\to\mathscr N_2/L_2)
        =\langle D_1,D_9\rangle},                         \tag{0.1}
\]

\[
 \boxed{\operatorname {Sel}_2(J_{17}/\mathbf Q)
        =\langle D_1,D_9\rangle\cong(\mathbf Z/2)^2},     \tag{0.2}
\]

and

\[
 \boxed{\operatorname {rank}J_{17}(\mathbf Q)=2}.        \tag{0.3}
\]

The Coleman certificate then gives

\[
 \boxed{C_{17}(\mathbf Q)
   =\{O,(-1,\pm1),(1,\pm3)\}}.                            \tag{0.4}
\]

Consequently there is no integral solution of

\[
 y^2=4T_{17}(T)+5
\]

with \(T>1\).  No GRH, BSD, `abc`, bounded point search, or conjectural
finiteness assertion is used.

The new executable files are

* `audit_scripts/p17_chebyshev_dyadic_selmer.m` (Magma V2.29-9);
* `audit_scripts/p17_chebyshev_coleman.sage` (SageMath 10.9);
* `IUTThreeClosures/FreyPellChebyshevIndexSeventeenDyadicColemanCertificate.lean`
  (scalar trust-boundary companion).

## 1. Frozen global input

Use the monic model

\[
\begin{aligned}
f_m(X)={}&X^{17}-68X^{15}+1904X^{13}-28288X^{11}+239360X^9\\
 &-1148928X^7+2924544X^5-3342336X^3+1114112X+327680.
                                                               \tag{1.1}
\end{aligned}
\]

Its root algebra is isomorphic to \(K=\mathbf Q(a)\), \(a^{17}=2\), by

\[
 \theta=-(2a+a^{16})=-2(a+a^{-1}),\qquad f_m(\theta)=0.        \tag{1.2}
\]

The frozen PARI certificate
`audit_scripts/p17_chebyshev_class_cert.gp` returns `bnfcertify=1` and class
number one.  The frozen Magma certificate
`audit_scripts/p17_chebyshev_global_local.m` then proves, after its exact
support and 8191-product checks,

\[
 \dim K(S,2)=13,\qquad \dim W_3=8,                             \tag{1.3}
\]

where \(W_3\) is the norm-square space satisfying the full already imposed
condition at 3.  The frozen calculation by itself gives only
\(\operatorname {Sel}_2(J_{17}/\mathbf Q)\subseteq W_3\); the places 17 and
infinity must still be checked before reading the dyadic kernel as the full
Selmer group.

The new script performs both checks on every displayed basis vector.  At 17
the exact decomposition and localization matrices give

```text
LOCAL17_DECOMPOSITION=[ <17,1,17> ]
LOCAL17_COORD_RANK=0
```

There is one local factor, so the odd-prime local Kummer image has dimension
\(1-1=0\), and all eight vectors satisfy it.  At infinity, \(K\) has one real
embedding and eight complex pairs.  The complex factors contribute positive
norms; hence the real component has the sign of the rational norm.  The
norm-square condition forces that sign to be positive, and the script checks
the rational norms themselves are exact squares:

```text
REAL_PLACE_NORM_SQUARES=true
```

Thus every non-dyadic local condition is now proved on \(W_3\).  Stoll's
local-intersection description of odd-degree hyperelliptic 2-descent gives

\[
 \operatorname {Sel}_2(J_{17}/\mathbf Q)=
 \ker\!\left(W_3\longrightarrow\mathscr N_2/L_2\right),       \tag{1.4}
\]

with

\[
 \mathscr N_2=\ker(K_2^*/K_2^{*2}\xrightarrow N
                         \mathbf Q_2^*/\mathbf Q_2^{*2}),
 \quad
 L_2=\delta_2(J_{17}(\mathbf Q_2)/2J_{17}(\mathbf Q_2)).       \tag{1.5}
\]

The two rational half-divisors have transformed Mumford polynomials

\[
\begin{aligned}
U_1={}&X^8-2X^7-28X^6+48X^5+240X^4-320X^3-640X^2+512X+256,\\
U_9={}&X^8+2X^7-28X^6-48X^5+240X^4+320X^3-640X^2-512X+256.
                                                               \tag{1.6}
\end{aligned}
\]

In the frozen global basis their classes are

\[
 D_1=G_1,\qquad D_9=G_{12}+G_{13}.                            \tag{1.7}
\]

The new script reconstructs the same basis of \(W_3\):

```text
W3_BASIS=
1000000000000
0100001000001
0010000000001
0001000000000
0000101000000
0000011000001
0000000100000
0000000000011
W3_ENDPOINTS_ARE_D1_D9=true
```

Thus the first and eighth coordinates below are exactly \(D_1,D_9\), not
classes identified only after a dimension count.

## 2. The complete dyadic Kummer image

### 2.1 Local dimensions and exact squareclass coordinates

The polynomial \(X^{17}-2\) is Eisenstein at 2, so \(K_2/\mathbf Q_2\) is
totally ramified of degree 17.  The element \(\theta\) generates the same
degree-17 completion.  Hence \(J_{17}(\mathbf Q_2)[2]=0\).  The standard
local multiplication-by-2 index formula gives

\[
 \dim_{\mathbf F_2}J_{17}(\mathbf Q_2)/2J_{17}(\mathbf Q_2)=8. \tag{2.1}
\]

Also

\[
 \dim K_2^*/K_2^{*2}=17+2=19,
 \qquad \dim\mathscr N_2=19-3=16.                             \tag{2.2}
\]

As an independent coordinate audit, set

\[
 \mathcal B=\{a\}\cup\{1+a^i:1\le i\le33,\ i\ \mathrm{odd}\}
                  \cup\{1+a^{34}\}.                          \tag{2.3}
\]

The exact 19-by-19 Hilbert-symbol Gram matrix of \(\mathcal B\) has rank
19.  Thus these are a basis and a dual-coordinate system for the entire
local squareclass group.  Magma reports

```text
LOCAL17_DECOMPOSITION=[<17,1,17>] LOCAL17_COORD_RANK=0
REAL_PLACE_NORM_SQUARES=true
LOCAL_SQUARECLASS_DIM=19 HILBERT_GRAM_RANK=19
```

The proof below uses `LocalTwoSelmerMap(P2)` coordinates directly; the
Hilbert basis is an independent check that no local squareclass direction
has been lost.

### 2.2 Seven immediate local divisor classes

Besides \(U_1,U_9\), use

\[
\begin{aligned}
h_3={}&X^5-100X^4+14360X^3-599840X^2+34618240X-220850624,\\
h_4={}&X^5-185X^4+37170X^3-7104250X^2+760006225X-16597164509,\\
h_5={}&X^5+6940X^3-1899520X^2-106221680X-13680418896,\\
h_6={}&X^5-300X^4+21120X^3+2063600X^2+183837760X-7615171648,\\
h_7={}&X^6+180X^5+21348X^4+11527776X^3\\
 &\quad+1320882288X^2+136720457280X+5573570416576.
                                                               \tag{2.4}
\end{aligned}
\]

For \(h_3,\ldots,h_6\), the exact number field defined by \(h_i\) has a
unique prime above 2 with \((e,f)=(5,1)\); for \(h_7\) it has a unique prime
with \((e,f)=(6,1)\).  At each prime Magma returns

```text
LocalTwoSelmerMap(P)(fm(beta)) = 0.
```

Thus \(f_m(\beta)\) is a square in the corresponding completion and
\((\beta,\sqrt{f_m(\beta)})\) is a closed local point.  For a monic
degree-\(d\) polynomial \(h\), its divisor Kummer value is

\[
 (-1)^d h(\theta).                                            \tag{2.5}
\]

This gives seven proved classes from

\[
 U_1,U_9,h_3,h_4,h_5,h_6,h_7.                                \tag{2.6}
\]

### 2.3 The eighth direction and the finite-precision stability proof

Exact integer polynomial arithmetic gives

\[
 \boxed{f_m(X)-256^2=(X+4)U_1(X)^2}.                          \tag{2.7}
\]

Over \(\mathbf Q_2\), certified p-adic factorization splits \(U_1\) into
two irreducible quartics.  An exact global decomposition check independently
returns two primes of type

```text
EXACT_U1_PRIME_DECOMPOSITION=[ <1,4,1>, <1,4,1> ].
```

Let \(q_8\) be the first exact \(\mathbf Q_2\)-quartic factor.  Its displayed
precision-40 coefficients are represented by the integer lift

\[
 h_8=X^4-54965098776X^3+109930197544X^2
          +439720790184X-16.                                  \tag{2.8}
\]

The second lift is

\[
 h_8'=X^4+54965098774X^3-109930197556X^2
          -439720790216X-16.                                  \tag{2.9}
\]

Magma verifies coefficientwise

\[
 q_8\equiv h_8\pmod {2^{40}},\qquad
 q_8'\equiv h_8'\pmod {2^{40}},                               \tag{2.10}
\]

and, independently,

\[
 \min_i v_2([X^i](h_8h_8'-U_1))=42.                          \tag{2.11}
\]

The point represented by the exact factor \(q_8\) lies on the horizontal
section \(y=256\) by (2.7), so its exact Kummer class is \([q_8(\theta)]\).
It remains to justify replacing \(q_8\) by the finite integer lift \(h_8\).

Normalize the valuation \(v=v_{K_2}\) by \(v(\mathfrak P_2)=1\).  The exact
Magma valuations are

\[
 v(2)=17,\qquad v(\theta)=16,\qquad v(h_8(\theta))=64.         \tag{2.12}
\]

Since \(\theta\) is integral, (2.10) implies

\[
 v(q_8(\theta)-h_8(\theta))\ge40\cdot17=680.                 \tag{2.13}
\]

Therefore

\[
 {q_8(\theta)\over h_8(\theta)}=1+\varepsilon,
 \qquad v(\varepsilon)\ge680-64=616.                         \tag{2.14}
\]

Apply Hensel's lemma to

\[
 F(z)=z^2-(1+\varepsilon)
\]

at \(z=1\).  Here

\[
 v(F(1))\ge616>34=2v(F'(1)).                                 \tag{2.15}
\]

Thus \(1+\varepsilon\) is a square in \(K_2\), and

\[
 [h_8(\theta)]=[q_8(\theta)]\in L_2.                         \tag{2.16}
\]

This is the required stability proof; the integer lift is not being treated
as an exact polynomial factor.

### 2.4 Eight independent rows are all of \(L_2\)

In the order

\[
 (U_1,U_9,h_3,h_4,h_5,h_6,h_7,h_8),                          \tag{2.17}
\]

the exact `LocalTwoSelmerMap(P2)` rows, written as 19-bit strings, are

```text
0000000011111100110
0000000011000000000
0000000000101011110
0000000000000100010
0000000000001000100
0000000000000011000
0000000000110110110
0101011100000111000
```

Their rank is 8:

```text
U_LOCAL_COORD_RANK=8
```

Every row is a proved local divisor class, so their span \(U\) lies in
\(L_2\).  Equations (2.1) and (2.17) give

\[
 \dim U=8=\dim L_2,
 \qquad\boxed{U=L_2}.                                        \tag{2.18}
\]

This proves completeness without a point-height or extension-degree search.

## 3. Direct computation of the dyadic kernel

Localizing the displayed basis of \(W_3\) gives the exact rows

```text
0000000011111100110
0011110011001110110
0000100100101001000
0111100011011000110
0111011011101000110
0110011100110101110
0001111100111011010
0000000011000000000
```

of rank 8.  Row reduction of the 16-by-19 matrix obtained by stacking the
\(L_2\) rows and the localized \(W_3\) rows gives

```text
U_LOCAL_COORD_RANK=8
W_LOCAL_COORD_RANK=8
COMBINED_LOCAL_RANK=14
QUOTIENT_RANK=6
INTERSECTION_DIM=2
INTERSECTION_COEFFS=
00000000
10000000
00000001
10000001
```

The first and eighth \(W_3\)-basis vectors are \(D_1,D_9\).  Therefore

\[
 \operatorname {loc}_2(W_3)\cap L_2
   =\langle\operatorname {loc}_2(D_1),
            \operatorname {loc}_2(D_9)\rangle,                \tag{3.1}
\]

which proves (0.1) directly.

### Hilbert/Tate cross-check

Under the usual explicit odd-degree descent identification with
\(H^1(\mathbf Q_2,J[2])\), local Tate duality makes the local Kummer image
maximal isotropic.  The exact Hilbert-symbol matrix on the eight rows of
\(L_2\) is the zero matrix.  The restriction against the eight localized
\(W_3\) rows is

\[
\begin{pmatrix}
0&0&0&0&0&0&0&0\\
0&0&0&0&0&0&0&0\\
0&1&0&0&1&1&1&0\\
0&1&1&1&1&1&0&0\\
0&0&1&1&1&0&1&0\\
0&1&0&0&0&0&0&0\\
0&0&0&1&0&0&1&0\\
0&1&0&0&0&1&0&0
\end{pmatrix},                                               \tag{3.2}
\]

and has rank 6.  Its first and last columns vanish.  Hence local Tate
duality independently gives the same two-dimensional kernel.  The proof of
(0.1) uses the direct coordinate intersection above, so it does not depend
on identifying every printed Hilbert-symbol convention with a Tate-pairing
normalization.

## 4. From the dyadic kernel to rank two

The accepted Poonen--Schaefer/Schaefer/Stoll descent theorem identifies the
odd-degree Kummer map with the appropriate norm-square subgroup of the root
algebra and gives the local-intersection equality (1.4).  Combining (1.4)
and (3.1),

\[
 \operatorname {Sel}_2(J_{17}/\mathbf Q)
  =\langle D_1,D_9\rangle.                                  \tag{4.1}
\]

Both classes come from the two rational half-divisors \(H_+,H_-\), and the
frozen uniform descent proves them independent in
\(J_{17}(\mathbf Q)/2J_{17}(\mathbf Q)\).  The Kummer exact sequence gives

\[
 J_{17}(\mathbf Q)/2J_{17}(\mathbf Q)
 \hookrightarrow\operatorname {Sel}_2(J_{17}/\mathbf Q).     \tag{4.2}
\]

The source has dimension at least 2 and the target has dimension exactly 2.
Moreover \(J_{17}(\mathbf Q)[2]=0\), since the odd-degree root polynomial is
irreducible.  Thus

\[
 \dim J_{17}(\mathbf Q)/2J_{17}(\mathbf Q)
 =\operatorname {rank}J_{17}(\mathbf Q)=2.                   \tag{4.3}
\]

This also shows \(\Sha(J_{17}/\mathbf Q)[2]=0\), but no assumption about
\(\Sha\), BSD, or its parity is used.

## 5. Coleman--Chabauty at 5

### 5.1 Good reduction and the six discs

Put

\[
 H:\quad v^2=h(T):={4T_{17}(T)+5\over2^{18}},
 \qquad v={y\over512}.                                      \tag{5.1}
\]

This is a monic odd-degree genus-eight model with good reduction at 5.
SageMath 10.9 returns

```text
GENUS 8
IRREDUCIBLE True GOOD_REDUCTION_5 True
F5COUNT 6
F5POINTS [(1:0:0),(0:0:1),(1:1:1),(1:4:1),(4:2:1),(4:3:1)]
F5ROOTS [(0,1)]
```

Thus there are six residue discs: infinity, the simple Weierstrass disc
above \(T=0\), and two discs above each of \(T=1,-1\).

The four visible affine rational points on \(H\) are

\[
 (-1,\pm1/512),\qquad(1,\pm3/512).                           \tag{5.2}
\]

Let \(O\) be infinity, \(P_-=(-1,1/512)\), and
\(P_+=(1,3/512)\).  Their divisor classes are twice the two rational
half-divisors.  Since 2 is a unit in \(\mathbf Q_5\), their Coleman
logarithms span the full rank-two Mordell--Weil logarithm space.

### 5.2 Directly saturated annihilator reduction

Use

\[
 \omega_i=T^i{dT\over2v},\qquad0\le i<8.                    \tag{5.3}
\]

Sage computes logarithm vectors \(\ell_-,\ell_+\) with coordinate
valuations

```text
LOGVALS [1,1,2,1,1,2,1,1] [1,2,1,1,1,1,1,1].
```

Both rows have content valuation 1.  Dividing each row by 5 and reducing
directly gives

\[
 \overline M=
 \begin{pmatrix}
 3&4&0&4&4&0&2&3\\
 1&0&4&2&2&3&1&2
 \end{pmatrix},\qquad \operatorname {rank}_{\mathbf F_5}\overline M=2.
                                                               \tag{5.4}
\]

The script constructs `DirectAnn=ker(Mbar)` and checks it equals the
reduction obtained from primitive rows of the \(\mathbf Q_5\)-kernel:

```text
LOG_CONTENT_VALS [1,1]
DIRECT_LOG_RANK 2
DIRECT_ANN_DIM 6
REDUCED_KERNEL_DIM 6
DIRECT_ANN_EQUALS_PRIMITIVE_KERNEL True
```

This is the saturation check: the six-dimensional reduction is not inferred
merely by normalizing an arbitrary p-adic kernel basis row by row.

An echelon basis of the common annihilator is

```text
(1,0,0,0,0,0,2,1)
(0,1,0,0,0,0,2,4)
(0,0,1,0,0,0,2,2)
(0,0,0,1,0,0,3,0)
(0,0,0,0,1,0,3,0)
(0,0,0,0,0,1,4,4).
```

Choose the first vector.  It is the reduction of a primitive integral
annihilating differential whose numerator reduces to

\[
 \bar c(T)=1+2T^6+T^7.                                     \tag{5.5}
\]

Its finite values and leading coefficient are

\[
 \bar c(0)=1,\qquad \bar c(1)=4,
 \qquad\bar c(-1)=2,\qquad c_7=1.                           \tag{5.6}
\]

Thus the differential is nonzero on all six reduced points.  At the simple
Weierstrass point use \(v\) as parameter and
\(2v\,dv=h'(T)\,dT\); both \(\bar c(0)\) and \(h'(0)\) are nonzero.

### 5.3 One zero in a nonvanishing disc

Let \(\eta\) be an integral regular differential with nonzero reduction on
a residue disc over \(\mathbf Z_5\).  If a Coleman primitive has one zero,
translate a local parameter so it is at \(t=0\).  Write

\[
 \eta=(a_0+a_1t+a_2t^2+\cdots)dt,
 \qquad a_0\in\mathbf Z_5^*.
\]

At a second point, \(t\in5\mathbf Z_5\) and \(m=v_5(t)\ge1\).  The
primitive difference is

\[
 a_0t+{a_1\over2}t^2+{a_2\over3}t^3+\cdots.                 \tag{5.7}
\]

The first term has valuation \(m\).  Every degree-\(n\ge2\) term has
valuation at least

\[
 nm-v_5(n)>m,                                                \tag{5.8}
\]

because \((n-1)m>v_5(n)\).  Hence the first term cannot cancel and the
primitive has at most one zero in the disc.  This local proof does not need
the frequently quoted global numerical hypothesis \(5>2g\).

### 5.4 The six zeros and the rational-point list

There is already one Coleman zero in each disc.

1. \(O\) is the base point.
2. The four points in (5.2) are zeros because the differential annihilates
   all of \(J_{17}(\mathbf Q)\).
3. The unique simple root \(\alpha\equiv0\pmod5\) of \(h\) gives a local
   Weierstrass point \(W=(\alpha,0)\).  Since
   \(\operatorname {div}(T-\alpha)=2W-2O\), the class \([W-O]\) is
   2-torsion, and its 5-adic logarithm is zero.  Sage independently reports

```text
Q5ROOT_REDUCTION 0 ROOT_COUNT 1
IWVALS [+Infinity,+Infinity,+Infinity,+Infinity,
        +Infinity,+Infinity,+Infinity,+Infinity].
```

The local lemma makes these the only six zeros.  The point \(W\) is not
rational: \(h\) is irreducible of degree 17 (equivalently, its root field is
the already certified degree-17 field in (1.2)).  Hence

\[
 H(\mathbf Q)=
 \{O,(-1,\pm1/512),(1,\pm3/512)\}.                           \tag{5.9}
\]

Undoing \(v=y/512\) gives (0.4), and therefore excludes every integer
\(T>1\).

## 6. Reproduction and trust boundary

Run the dyadic script in Magma V2.29-9:

```text
load "audit_scripts/p17_chebyshev_dyadic_selmer.m";
```

Its decisive terminal ledger is

```text
LOCAL_SQUARECLASS_DIM=19 HILBERT_GRAM_RANK=19
HORIZONTAL_IDENTITY=true PRODUCT_ERROR_MIN_V2=42
Q2_U1_FACTOR_DEGREES=[4,4] H8_MATCH=true H8B_MATCH=true
E=17 VTHETA=16 VH8THETA=64 ERROR_BOUND=680
RATIO_ONE_BOUND=616 HENSEL_THRESHOLD=34
U_LOCAL_COORD_RANK=8
W_LOCAL_COORD_RANK=8
COMBINED_LOCAL_RANK=14 QUOTIENT_RANK=6 INTERSECTION_DIM=2
SELF_PAIRING_RANK=0
PAIRING_RANK=6
DYADIC_KERNEL_BASIS=[D1,D9] DYADIC_KERNEL_DIM=2
```

Run

```text
sage audit_scripts/p17_chebyshev_coleman.sage
```

under SageMath 10.9.  The decisive Coleman ledger is

```text
GENUS 8
F5COUNT 6
F5ROOTS [(0,1)]
LOG_CONTENT_VALS [1,1]
DIRECT_LOG_REDUCTION [3 4 0 4 4 0 2 3]
                     [1 0 4 2 2 3 1 2]
DIRECT_LOG_RANK 2
DIRECT_ANN_DIM 6
REDUCED_KERNEL_DIM 6
DIRECT_ANN_EQUALS_PRIMITIVE_KERNEL True
CHOSEN (1,0,0,0,0,0,2,1) FINITEVALUES [1,4,2] INFINITYVALUE 1
FOUND True
Q5ROOT_REDUCTION 0 ROOT_COUNT 1
IWVALS [+Infinity,+Infinity,+Infinity,+Infinity,
        +Infinity,+Infinity,+Infinity,+Infinity]
```

The GRH switch in the new Magma script is only a speed device for regenerating
the already frozen global representatives.  Completeness of the global
basis comes from the unconditional PARI `bnfcertify=1`, the \(S\)-unit
dimension formula, and the exact support/8191-product checks in the frozen
global script.  All new local ranks, valuations, squareclass maps, Hilbert
symbols, and row reductions are exact Magma computations.  The only
finite-precision local factor is converted to an exact squareclass by
(2.12)--(2.16).

The Lean companion checks the integer polynomial identity (2.7), the scalar
dimension and Hensel ledgers, the Coleman values (5.6), the seventeenth
Chebyshev polynomial, and the elementary consequences of the externally
certified rational \(T\)-coordinate statement.  It introduces no `axiom`,
`sorry`, or `admit` and does not pretend to formalize Magma or Sage.

## 7. Accepted references

* M. Stoll,
  [*Implementing 2-descent for Jacobians of hyperelliptic curves*](https://www.impan.pl/shop/en/publication/transaction/download/product/83397),
  Acta Arith. 98 (2001), 245--277, especially Proposition 4.2, Lemma 4.4,
  and Section 6 (including Lemma 6.1) for the closed-point Kummer formula.
* B. Poonen and E. Schaefer,
  [*Explicit descent for Jacobians of cyclic covers of the projective line*](https://math.mit.edu/~poonen/papers/descent.pdf),
  J. reine angew. Math. 488 (1997), 141--188.
* E. Schaefer,
  [*2-descent on the Jacobians of hyperelliptic curves*](https://doi.org/10.1006/jnth.1995.1044),
  J. Number Theory 51 (1995), 219--232.
* B. Poonen and E. Rains,
  [*Random maximal isotropic subspaces and Selmer groups*](https://arxiv.org/abs/1009.0287),
  J. Amer. Math. Soc. 25 (2012), 245--269, Proposition 4.10 for the local
  Kummer image as a maximal isotropic space under local Tate duality.
* SageMath Reference Manual,
  [hyperelliptic curves over a p-adic field](https://doc.sagemath.org/html/en/reference/arithmetic_curves/sage/schemes/hyperelliptic_curves/hyperelliptic_padic_field.html),
  documenting `coleman_integrals_on_basis`.
* J. S. Balakrishnan, R. W. Bradshaw, and K. S. Kedlaya,
  [*Explicit Coleman integration for hyperelliptic curves*](https://arxiv.org/abs/1004.4936),
  ANTS IX, LNCS 6197 (2010), 16--31.
* R. F. Coleman,
  [*Torsion points on curves and p-adic Abelian integrals*](https://annals.math.princeton.edu/1985/121-1/p03),
  Ann. of Math. 121 (1985), 111--168.
