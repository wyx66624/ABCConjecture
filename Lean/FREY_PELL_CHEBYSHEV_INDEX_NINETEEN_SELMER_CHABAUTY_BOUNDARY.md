# Prime 19: an unconditional seven-point bound and the Selmer--Chabauty boundary

## 0. Exact scope

Let

\[
 C_{19}:y^2=4T_{19}(T)+5,
 \qquad J_{19}=\operatorname {Jac}(C_{19}),
 \qquad g(C_{19})=9.
\]

The exact 2-descent in
`FREY_PELL_CHEBYSHEV_INDEX_NINETEEN_DYADIC_OBSTRUCTION.md` proves

\[
 \dim_{\mathbf F_2}\operatorname {Sel}_2(J_{19}/\mathbf Q)=3,
 \qquad 2\leq\operatorname {rank}J_{19}(\mathbf Q)\leq3.       \tag{0.1}
\]

The computations and standard Coleman local bound recorded here prove

\[
 \boxed{\#C_{19}(\mathbf Q)\leq7}.                            \tag{0.2}
\]

They also prove that the curve-level fake 2-Selmer set is the singleton
neutral class.  They **do not** prove that the five visible points

\[
 O,\qquad (-1,\pm1),\qquad (1,\pm3)                           \tag{0.3}
\]

are the complete rational-point set.  In particular, this note never treats
the third 2-Selmer class as a Mordell--Weil point or as a 5-adic logarithm.
If (0.3) is incomplete, (0.2), irreducibility, and the hyperelliptic
involution show that the missing points are one conjugate pair.

## 1. The exact good-reduction ledger at 5

For Coleman integration use the rationally scaled model

\[
 H:v^2={4T_{19}(T)+5\over2^{20}}.                             \tag{1.1}
\]

The scale does not change the rational `T`-coordinates.  The visible affine
points are

\[
 P_-=(-1,1/1024),\qquad P_+=(1,3/1024),                       \tag{1.2}
\]

together with their hyperelliptic conjugates.  SageMath 10.9 certifies good
reduction at 5 and gives

```text
C(F_5) = {infinity, (0,0), (1,2), (1,3), (4,1), (4,4)}.
```

There is one simple reduced Weierstrass point, at `T=0`.  The defining
polynomial is irreducible over the rationals, so its unique Hensel lift in
that disc is not rational.

Let `O` denote infinity.  Each of the two vectors

\[
 \left(\int_O^{P_\pm}{T^j\,dT\over v}\right)_{0\leq j\leq8}
\]

has 5-adic content exactly 5.  After division by 5, their rigorously known
reductions are

\[
 M=
 \begin{pmatrix}
 3&3&0&2&2&0&3&4&4\\
 1&3&4&3&1&2&3&2&3
 \end{pmatrix},
 \qquad \operatorname {rank}_{\mathbf F_5}M=2.               \tag{1.3}
\]

The transcript retains at least 30 digits of absolute 5-adic precision after
normalization.  Thus these residues are not guesses at the precision edge.
Put

\[
 W=\ker(M:\mathbf F_5^9\longrightarrow\mathbf F_5^2),
 \qquad \dim W=7.                                            \tag{1.4}
\]

## 2. The unknown-generator argument

Let `L` be the 5-adic logarithmic span of `J_19(Q)`, put

\[
 r_5=\dim_{\mathbf Q_5}L\leq\operatorname {rank}J_{19}(\mathbf Q),
\]

and let `V=L^\perp` be its annihilator in the space of regular
differentials.  If

\[
 A=(V\cap\mathbf Z_5^9)\bmod5,                               \tag{2.1}
\]

where the intersection is taken as the saturated integral lattice, then
(0.1) and (1.3) give

\[
 A\subseteq W,\qquad \dim A=9-r_5
 \geq9-\operatorname {rank}J_{19}(\mathbf Q)\geq6.            \tag{2.2}
\]

This step uses no representative of the extra Selmer class.

The vector

\[
 c_*=(1,0,0,0,0,0,0,0,3)\in W                              \tag{2.3}
\]

has values `1,4,4,3` at the four projective evaluation types
`T=0,1,-1,infinity`.  Consequently the kernel of each evaluation functional
inside `W` is a six-plane.  At any one type either:

1. `A` is not contained in the evaluation kernel, so some true annihilating
   differential has nonzero reduction there; or
2. `A` is exactly that six-plane.

The four six-planes are pairwise distinct, as checked by exact finite-field
row reduction in the Sage script.  Hence the second case occurs at at most
one evaluation type.  The two points above a fixed non-Weierstrass
`T`-coordinate have the same type.

For the four possible exceptional types the script exhibits the following
elements of `W`:

| type | numerator coefficients, constant first | reduced differential order |
|---|---|---:|
| `T=1` | `(1,0,0,0,0,0,4,3,2)` | 1 |
| `T=-1` | `(1,0,0,0,4,0,0,3,3)` | 1 |
| simple Weierstrass `T=0` | `(0,1,0,0,0,0,0,2,1)` | 2 |
| infinity | `(1,0,0,0,0,0,2,4,0)` | 2 |

Each witness belongs to the indicated six-plane and has the displayed exact
leading unit.  At a simple Weierstrass point, a simple zero of the numerator
has differential order two in a uniformizer; at infinity the orders of the
basis differentials are `16-2j`.

The local Coleman/Strassmann bound says that a residue disc in which the
reduced annihilating differential has order `d` contains at most `d+1`
zeros of its primitive in these cases (`d+1<5`).  A nonexceptional disc
therefore has at most one zero; an exceptional affine disc has at most two,
and an exceptional Weierstrass or infinity disc has at most three.

There is already a common zero in every disc: the five visible rational
points account for five discs, while the sixth contains the unique
`Q_5`-rational Weierstrass lift `W_0`.  The class `[W_0-O]` is 2-torsion, so
all nine of its Coleman logarithms vanish.  This sixth zero is not rational.

Now count rational points.

* If `T=1` or `T=-1` is exceptional, its two conjugate discs contribute at
  most four points; the other conjugate type contributes two, infinity one,
  and the Weierstrass disc none.  The total is at most `4+2+1=7`.
* If the Weierstrass type is exceptional, that disc has at most three
  Coleman zeros, one of which is the nonrational `W_0`.  It contributes at
  most two rational points, and the five visible points give a total at most
  seven.
* If infinity is exceptional, its disc contributes at most three rational
  points, the two affine types contribute four, and the nonexceptional
  Weierstrass disc contributes none.  Again the total is at most seven.
* With no exceptional type, the five visible points are the only possible
  rational zeros.

This proves (0.2) without deciding which rank in (0.1) occurs.

## 3. Why the modulo-5 witnesses do not prove completeness

It is false that reduced order `d` forces the characteristic-zero primitive
to begin in degree `d+1`.  Reduction only makes the lower coefficients
divisible by 5.  Two sharp exact counterexamples are

\[
 \omega_1=(5+t)dt,\qquad F_1(t)=5t+{t^2\over2},              \tag{3.1}
\]

with the two roots `0,-10` in `5 Z_5`, and

\[
 \omega_2=(3t^2-25)dt,\qquad F_2(t)=t^3-25t,                \tag{3.2}
\]

with the three roots `0,5,-5`.  Thus the orders one and two in Section 2
give bounds two and three, not uniqueness.  The Sage script checks the root
identities exactly over the rationals.

## 4. Why the extra 2-Selmer class gives no modulo-25 or modulo-125 lift

A local 2-Kummer class at 5 specifies a coset

\[
 G_0+2J_{19}(\mathbf Q_5).                                  \tag{4.1}
\]

Let `J_1(Q_5)` be the formal subgroup.  Since 2 is a 5-adic unit,

\[
 2J_1(\mathbf Q_5)=J_1(\mathbf Q_5),                        \tag{4.2}
\]

and the formal logarithm sends a sufficiently small open subgroup to a full
rank-nine lattice.  Replacing a representative by `G_0+2R` with
`R in J_1(Q_5)` preserves its mod-2 Kummer class but changes its logarithm by

\[
 \log(G_0+2R)-\log(G_0)=2\log R.                            \tag{4.3}
\]

The right-hand side ranges over an open full lattice.  In particular, the
mod-2 localization does not select the normalized third logarithm modulo 5,
25, 125, or any higher power.  The scalar companion records the explicit
inverses `2*13=1 (mod 25)` and `2*63=1 (mod 125)`.

For any proposed local curve integral vector, adjoining that vector to the
two known logarithms produces a locally compatible three-plane that makes
the proposed point a common zero.  This observation does not assert that the
plane comes from a global Mordell--Weil group; it proves precisely that the
given local mod-2 data cannot rule it out.  A finite enumeration of lifts
based only on the extra 2-Selmer class is therefore not a valid completion.

## 5. The singleton fake 2-Selmer set of the curve

Use the integral monic coordinate `X=4T` and

\[
\begin{aligned}
 f_m(X)={}&X^{19}-76X^{17}+2432X^{15}-42560X^{13}
       +442624X^{11}-2782208X^9\\
 &+10272768X^7-20545536X^5+18677760X^3
       -4980736X+1310720.
\end{aligned}                                                \tag{5.1}
\]

The official Magma V2.29-9 call `TwoCoverDescent` returns

```text
GENUS=9 FAKE_TWO_SELMER_SIZE=1 SET={ 0 } DELTA=1
```

with `PrimeBound := 30`.  Omitting later good-prime tests can only leave
extra candidates.  Visible rational points make the true fake Selmer set
nonempty, so a surviving singleton is exact once the global class/unit basis
is complete.  The GRH switch in the Magma script is only a speed device for
constructing that basis: completeness is independently deconditioned by
`p19_chebyshev_class_cert.gp` (`bnfcertify=1`), the theoretical
`K(S,2)` dimension, the support checks, and the exhaustive square-relation
test in `p19_chebyshev_dyadic_obstruction.m`.

Consequently every rational point lifts to the neutral 2-cover.  If `theta`
is the degree-19 root, the curve descent value `X-theta` is a square in the
root field.  In the pure-field presentation

\[
 a^{19}=2,\qquad \theta=-2(a+a^{-1}),                         \tag{5.2}
\]

multiplication by `a/2=a^{-18}=(a^{-9})^2` converts this to

\[
 v^2=a^2+{X\over2}a+1.                                      \tag{5.3}
\]

The visible fibres `X=4` and `X=-4` are `(a+1)^2` and `(a-1)^2`.
The singleton descent result says every rational point lies on this surviving
cover; it does not determine the rational fibres of (5.3).  The **full**
geometric pullback of `[2]:J_19 -> J_19` along the Abel--Jacobi embedding is a
connected etale cover of degree `#J_19[2]=2^18`: connectedness is the standard
geometric monodromy input that the Abel--Jacobi map induces the full mod-2
homology map, not an output of `TwoCoverDescent`.  Riemann--Hurwitz then gives
its genus

\[
 1+2^{18}(9-1)=2{,}097{,}153.                               \tag{5.4}
\]

No certified low-genus quotient or finite-index Mordell--Weil group for that
cover is supplied here.  Thus the singleton is not a point-list certificate.

## 6. Why one 4-descent and full-Sha parity do not choose the rank

Because `J_19(Q)[2]=0`, the Kummer exact sequence gives

\[
 0\longrightarrow J_{19}(\mathbf Q)/2J_{19}(\mathbf Q)
 \longrightarrow\operatorname {Sel}_2(J_{19}/\mathbf Q)
 \longrightarrow\Sha(J_{19}/\mathbf Q)[2]\longrightarrow0. \tag{6.1}
\]

Thus rank three would give `Sha[2]=0`, while rank two would leave a
one-dimensional `Sha[2]`.  There are two distinct Cassels--Tate facts here,
and they must not be conflated.

First, the finite-level Cassels--Tate pairing on `Sel_2(J_19)` has kernel
equal to the image of `Sel_4(J_19) -> Sel_2(J_19)`.  This statement does not
assume finiteness of `Sha`.  The rational point at infinity supplies a
rational theta characteristic: for the odd-degree genus-nine model,
`K_C ~ 16 O = 2(8 O)`.  Hence the finite-level pairing is alternating.  The
two known rational Kummer classes lie in its kernel because rational
Mordell--Weil classes always lift to `Sel_4`.  An alternating form on a
three-dimensional `F_2`-space has even rank.  Since its radical already
contains a two-plane, its rank is at most one and therefore zero.  The extra
class `E` is also in the radical, so

\[
 E\in\operatorname {im}(\operatorname {Sel}_4(J_{19})
          \longrightarrow\operatorname {Sel}_2(J_{19})).     \tag{6.2}
\]

Consequently the formerly tempting one-step plan "show that `E` does not
4-lift" is structurally impossible: `E` is forced to lift.  Merely producing
one 4-lift is also inconclusive; the lift can arise from Mordell--Weil or from
a 2-divisible Tate--Shafarevich class.  A higher obstruction (for example an
appropriate `Sel_8 -> Sel_4` calculation) could still help, but it is new
input beyond a single 4-descent.

Second, the Cassels--Tate pairing is nondegenerate only on the quotient of
`Sha` by its maximal divisible subgroup.  Without finiteness of `Sha`, a lone
2-torsion class can lie in the divisible 2-primary subgroup.  Therefore a
software `HasSquareSha`/square-order refinement whose proof assumes finite
`Sha` cannot be used to replace the rank upper bound three by two.  The
unconditional finite-level lift statement (6.2) does not imply that the full
`Sha` is finite or has square order.

## 7. Viable ways past the boundary

Any unconditional five-point conclusion requires additional arithmetic
information, for example:

* a higher 2-power descent that detects an obstruction beyond the forced
  first 4-lift;
* a third global divisor and its actual 5-adic logarithm;
* appropriate 5-power Selmer information constraining that logarithm;
* a certified analysis of the unique neutral cover or a low-genus quotient;
  or
* Stoll's *Chabauty without the Mordell--Weil group*, Algorithm 4.1, applied
  at 2 by computing the local `q`-sets and comparing them with the localized
  global 2-Selmer group.

The last route is particularly relevant because it is designed to avoid a
known Mordell--Weil basis.  The present dyadic Kummer matrices certify the
2-Selmer group, but they do not yet supply the required `q`-sets of local
halves on the target 2-adic discs.  Computing those sets is a separate
finite local task, not a consequence of the modulo-5 Coleman matrix.

There is no further Coleman obstruction once such a calculation confines a
target point to the saturation of the known horizontal direction.  Indeed,
columns zero and one of (1.3) have determinant `1 mod 5`.  Keep coefficients
two through eight of (2.3) fixed and solve the two exact equations that make
the differential annihilate both known logarithms.  The solution remains
congruent to (2.3), so its reduction is nonzero in all six residue discs.
This exact-lift construction is implemented in the Sage script.  It is a
conditional finishing lemma for the separate Selmer-group Chabauty
calculation; by itself it does not prove that the required saturation
condition holds.

## 8. Reproduction and trust boundary

Run the Coleman ledger under SageMath 10.9:

```text
sage audit_scripts/p19_chebyshev_unknown_generator_coleman.sage
```

Its decisive output is

```text
GENUS 9 IRREDUCIBLE True GOOD_REDUCTION_5 True
F5COUNT 6
F5ROOTS [(0, 1)]
LOG_CONTENT_VALS [1, 1]
DIRECT_LOG_RANK 2
KNOWN_REDUCED_ANNIHILATOR_DIM 7
ALL_DISC_WITNESS (1, 0, 0, 0, 0, 0, 0, 0, 3)
EXACT_KNOWN_SUBGROUP_ANNIHILATOR_REDUCTION (1, 0, 0, 0, 0, 0, 0, 0, 3)
EXACT_KNOWN_SUBGROUP_ANNIHILATOR_DOTS [O(5^42), O(5^42)]
FOUR_EXCEPTIONAL_KERNELS_PAIRWISE_DISTINCT True
AT_MOST_SEVEN_CASE_LEDGER [7, 7, 7, 7]
LIFT_COUNTEREXAMPLE_ORDER1_ROOTS [0, -10]
LIFT_COUNTEREXAMPLE_ORDER2_ROOTS [0, 5, -5]
MOD5_UNIFORM_COMPLETENESS False
```

Run the curve descent in Magma V2.29-9:

```text
load "audit_scripts/p19_chebyshev_curve_two_cover.m";
```

The Lean companion checks only scalar consequences copied from these
external transcripts.  It introduces no axiom, `sorry`, or `admit`, and it
does not pretend to formalize Sage, Magma, Coleman integration, or Selmer
descent.

## 9. Accepted references

* R. F. Coleman, *Torsion points on curves and p-adic abelian integrals*,
  Ann. of Math. 121 (1985), 111--168.
* J. S. Balakrishnan, R. W. Bradshaw, and K. S. Kedlaya, *Explicit Coleman
  integration for hyperelliptic curves*, ANTS IX, LNCS 6197 (2010), 16--31.
* M. Stoll, *Implementing 2-descent for Jacobians of hyperelliptic curves*,
  Acta Arith. 98 (2001), 245--277.
* M. Stoll, *Chabauty without the Mordell--Weil group*, in *Algorithmic and
  Experimental Methods in Algebra, Geometry, and Number Theory* (2017),
  especially Algorithm 4.1.
* B. Poonen and M. Stoll, *The Cassels--Tate pairing on polarized abelian
  varieties*, Ann. of Math. 150 (1999), 1109--1149.
* SageMath Reference Manual, `coleman_integrals_on_basis` for hyperelliptic
  curves over p-adic fields.
* Magma Handbook, `TwoCoverDescent` for hyperelliptic curves.
