# The prime-nineteen Chebyshev curve: an exact dyadic obstruction

## 0. Verdict

Let

\[
 C_{19}:y^2=4T_{19}(T)+5,
 \qquad J_{19}=\operatorname {Jac}(C_{19}),
 \qquad g(C_{19})=9.
\]

The proposed final dyadic assertion at index 19 was

\[
 \operatorname {rank}\bigl(W_{19}^{\rm odd}\longrightarrow
       \mathscr N_2/L_2\bigr)=7,
 \qquad
 \ker=\langle D_1,D_9\rangle .                    \tag{0.1}
\]

The exact calculation in
`audit_scripts/p19_chebyshev_dyadic_obstruction.m` disproves (0.1).  It
instead gives

\[
 \boxed{\operatorname {rank}=6},\qquad
 \boxed{\ker=\langle D_1,D_9,E\rangle},            \tag{0.2}
\]

where, in the displayed basis of the nine-dimensional odd-place survivor,

\[
 E=(0,1,1,1,0,0,1,1,0).                            \tag{0.3}
\]

In the fourteen-element global `pSelmerGroup` basis its coordinate vector is

\[
 (0,1,1,1,0,1,0,1,1,0,0,0,0,1).                  \tag{0.4}
\]

All remaining places are imposed in the same exact script.  Consequently
the accepted odd-degree hyperelliptic 2-descent intersection theorem yields

\[
 \boxed{\operatorname {Sel}_2(J_{19}/\mathbf Q)
       =\langle D_1,D_9,E\rangle\cong(\mathbf F_2)^3}.          \tag{0.5}
\]

The two known independent rational divisor classes give only

\[
 2\le \operatorname {rank}J_{19}(\mathbf Q)\le3.              \tag{0.6}
\]

Nothing here decides whether the third Selmer class is a Mordell--Weil
class or a nonzero element of \(\Sha(J_{19})[2]\).  In particular, (0.5)
must not be reported as rank three, and the rank-two Coleman input is no
longer certified.  This is a counterexample to the proposed fixed-index
rank-seven route, not a counterexample to the `abc` conjecture.

## 1. Global and non-dyadic input

Use the monic genus-nine model

\[
\begin{aligned}
 f_m(X)={}&X^{19}-76X^{17}+2432X^{15}-42560X^{13}
       +442624X^{11}-2782208X^9\\
 &+10272768X^7-20545536X^5+18677760X^3
       -4980736X+1310720.                                  \tag{1.1}
\end{aligned}
\]

In \(K=\mathbf Q(a)\), \(a^{19}=2\), set

\[
 \theta=-(2a+a^{18})=-2(a+a^{-1}).                           \tag{1.2}
\]

Exact arithmetic verifies that the minimal polynomial of \(\theta\) is
precisely \(f_m\).  The frozen PARI certificate
`audit_scripts/p19_chebyshev_class_cert.gp` proves unconditionally that
\(\operatorname {Cl}(K)=1\).  The new Magma script reconstructs the
fourteen generated \(K(S,2)\) representatives and independently checks:

* every representative has even valuation outside the four primes over
  \(2,3,19\);
* all \(2^{14}-1=16383\) nonempty products are nonsquares;
* the norm matrix has rank four;
* the complete \(3\)-adic condition leaves a nine-dimensional space
  \(W_{19}^{\rm odd}\).

The `SetClassGroupBounds("GRH")` switch is used only to generate the
representatives inside the official calculator's time limit.  Completeness
is deconditioned by the independent PARI class-number-one proof, the
theoretical dimension fourteen, the support test, and the exhaustive exact
square-relation test.  No GRH conclusion is used.

The script then checks the places not already imposed.  At 19,

```text
LOCAL19_DECOMPOSITION=[ <19, 1, 19> ]
LOCAL19_COORD_RANK=0
```

and all nine global rows localize to zero.  At infinity, every rational norm
is checked to be a positive exact square:

```text
REAL_PLACE_NORM_SQUARES=true
```

Thus the only remaining condition on \(W_{19}^{\rm odd}\) is the dyadic
Kummer image.

## 2. Exact dyadic Kummer image

### 2.1 Dimensions and coordinates

The polynomial \(X^{19}-2\) is Eisenstein at 2.  Hence
\(K_2/\mathbf Q_2\) is totally ramified of odd degree 19 and the monic
polynomial has no nontrivial local factorization.  Therefore
\(J_{19}(\mathbf Q_2)[2]=0\), and the standard local index formula gives

\[
 \dim_{\mathbf F_2}J_{19}(\mathbf Q_2)/2J_{19}(\mathbf Q_2)=9. \tag{2.1}
\]

Moreover

\[
 \dim K_2^*/K_2^{*2}=21,
 \qquad \dim\mathscr N_2=18.                                 \tag{2.2}
\]

As an independent audit of the local coordinate space, the script uses

\[
 \mathcal B=\{a\}\cup\{1+a^i:1\le i\le37, i\text{ odd}\}
                    \cup\{1+a^{38}\}.                       \tag{2.3}
\]

The exact 21-by-21 Hilbert-symbol Gram matrix of \(\mathcal B\) has rank
21.  Thus it detects every local squareclass direction.  The main row-space
calculation uses Magma's exact `LocalTwoSelmerMap(P2)` coordinates.

### 2.2 Nine proved local divisor classes

The two rational half-divisors have monic Mumford polynomials

\[
\begin{aligned}
 U_1={}&X^9-2X^8-32X^7+56X^6+336X^5-480X^4
       -1280X^3+1280X^2+1280X-512,\\
 U_9={}&X^9+2X^8-32X^7-56X^6+336X^5+480X^4
       -1280X^3-1280X^2+1280X+512.                           \tag{2.4}
\end{aligned}
\]

The exact horizontal identities

\[
 f_m-512^2=(X+4)U_1^2,
 \qquad f_m-1536^2=(X-4)U_9^2                            \tag{2.5}
\]

are asserted by the Magma script and proved again by `ring` in the Lean
companion.  Seven further monic polynomials are

\[
\begin{aligned}
h_3={}&X^5-185X^4+37170X^3-7104250X^2+760006225X-16597164509,\\
h_4={}&X^5+6940X^3-1899520X^2-106221680X-13680418896,\\
h_5={}&X^6+180X^5+21348X^4+11527776X^3+1320882288X^2\\
     &\quad+136720457280X+5573570416576,\\
h_6={}&X^5-80X^4+5560X^3-53360X^2+13991360X-49066816,\\
h_7={}&X^5-100X^4+6480X^3-500960X^2+8587840X-449775424,\\
h_8={}&X^5-80X^4+4880X^3-314240X^2+24531680X-980471440,\\
h_9={}&X^7-252X^5+135856X^4-3461920X^3+136310720X^2\\
     &\quad-1479802688X+26132215488.                         \tag{2.6}
\end{aligned}
\]

For every \(h_i\), `NumberField(h_i)` has one prime above 2, with
\((e,f)=(\deg h_i,1)\), and exact local arithmetic returns

```text
LocalTwoSelmerMap(P)(Evaluate(fm,beta)) = 0.
```

Thus \((\beta,\sqrt{f_m(\beta)})\) is a closed local point.  For a monic
degree-\(d\) closed point polynomial \(h\), its divisor Kummer value is

\[
 (-1)^d h(\theta).                                           \tag{2.7}
\]

Apply (2.7) to

\[
 (U_1,U_9,h_3,h_4,h_5,h_6,h_7,h_8,h_9).                    \tag{2.8}
\]

Their exact local squareclass rows have rank nine.  Every row lies in
\(L_2\), while (2.1) says \(\dim L_2=9\).  Hence these rows are not merely
a lower bound:

\[
 \boxed{\operatorname {RowSpan}(2.8)=L_2}.                   \tag{2.9}
\]

No finite-precision factor is used in this certificate; all seven added
closed points are verified in exact number fields and their dyadic
completions.

## 3. The strict reverse certificate

Let \(U\) be the 9-by-21 matrix of the local classes in (2.8), and let
\(W\) be the 9-by-21 localization matrix of the frozen basis of
\(W_{19}^{\rm odd}\).  Exact \(\mathbf F_2\)-linear algebra gives

```text
U_LOCAL_COORD_RANK=9
W_LOCAL_COORD_RANK=9
COMBINED_LOCAL_RANK=15
QUOTIENT_RANK=6
INTERSECTION_DIM=3
```

Indeed,

\[
 \dim(\operatorname {row}U\cap\operatorname {row}W)
 =9+9-15=3,                                                  \tag{3.1}
\]

and the script exhausts all \(2^9\) coefficient vectors.  The eight vectors
that land in \(\operatorname {row}U\) are

```text
000000000
100000000
011100110
111100110
000000001
100000001
011100111
111100111
```

so their space is exactly

\[
 \langle(1,0,0,0,0,0,0,0,0),
         (0,0,0,0,0,0,0,0,1),
         (0,1,1,1,0,0,1,1,0)\rangle .                       \tag{3.2}
\]

The first and ninth vectors are checked against the global coordinates of
\(D_1=[a-1]\) and \(D_9=[3(a+1)]\).  The third is outside their span.

There is a second, independent linear-algebra check.  The 9-by-9
Hilbert-symbol matrix on the local Kummer rows is zero, as required by
isotropy, while their Hilbert pairing with the nine global rows has rank
six.  Its kernel contains exactly the three vectors in (3.2):

```text
KUMMER_SELF_PAIRING_RANK=0
PAIRING_RANK=6
DYADIC_KERNEL_BASIS=[D1,D9,EXTRA]
DYADIC_KERNEL_DIM=3
```

The direct `LocalTwoSelmerMap` row-space intersection is the proof; the
Hilbert pairing is a cross-check with a separately constructed full local
squareclass basis.

## 4. Consequences and remaining boundary

Because the norm, 3-adic, 19-adic, real, and 2-adic conditions are all
imposed, (3.2) is the full 2-Selmer group, giving (0.5).  The Kummer exact
sequence only implies

\[
 0\longrightarrow J_{19}(\mathbf Q)/2J_{19}(\mathbf Q)
 \longrightarrow\operatorname {Sel}_2(J_{19}/\mathbf Q)
 \longrightarrow\Sha(J_{19})[2]\longrightarrow0.            \tag{4.1}
\]

Since \(J_{19}(\mathbf Q)[2]=0\) and two independent rational classes are
known, (4.1) proves (0.6).  Deciding between rank two and rank three requires
either showing that \(E\) is everywhere locally soluble but globally
insoluble as a 2-cover, or producing a third independent rational divisor.
The present certificate does neither.

Classical Chabauty remains dimensionally possible for either rank because
\(3<g=9\).  But one may not insert a Selmer class into the Mordell--Weil
logarithm space: a rank-three Coleman computation needs a certified third
Mordell--Weil generator or a rigorous annihilator construction valid for
both possible Mordell--Weil subspaces.  That is the next independent
problem; no rational-point conclusion at index 19 is claimed here.

## 5. Reproduction and trust boundary

Run in Magma V2.29-9:

```magma
load "audit_scripts/p19_chebyshev_dyadic_obstruction.m";
```

The complete frozen official-calculator rerun, including all assertions,
took 48.979 seconds and ended with `DYADIC_KERNEL_DIM=3`.

The companion Lean target is

```text
IUTThreeClosures.FreyPellChebyshevIndexNineteenDyadicObstruction
```

Lean proves the two polynomial identities and the scalar rank-nullity
ledgers.  It does not reimplement number fields, local fields, class groups,
Kummer maps, Jacobians, Selmer groups, PARI, or Magma.  The claims in those
domains are transparent external exact-computation certificates, not Lean
theorems or axioms.

The accepted mathematical inputs are the standard odd-degree hyperelliptic
2-descent/local-intersection theorem, the local multiplication-by-2 index
formula, the Kummer exact sequence, and elementary finite-dimensional linear
algebra.  No GRH, BSD, `abc`, finiteness of \(\Sha\), or bounded-search
assumption is used in (0.2)--(0.6).
