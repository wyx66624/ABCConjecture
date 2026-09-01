# Structural tests for the global uniformity gates

Author: ChatGPT. Research date: 2026-08-30.

This note supplies mathematical proofs before their formalization. Its
tests concern specific proposed shortcuts and the algebraic core of the
all-open unit-lattice condition, not the truth of abc or IUT.
The full abc target and the definitions in `ABCStatement.lean` are unchanged.

## 1. Trace preservation alone still permits a common minimum layer

Let `k` be a field of characteristic different from two and let `V` be a
vector space over `k`. Let `t,l:V->k` be linear forms. Assume that a vector
`w` satisfies

\[
 t(w)=0,\qquad l(w)=1.                                      \tag{1}
\]

For any nonzero `x,y in V`, there is a linear automorphism `F` such that

\[
 t\circ F=t,\qquad l(Fx)\ne0,\qquad l(Fy)\ne0.              \tag{2}
\]

In fact, `F` can be chosen to be a possibly trivial transvection of the
displayed form. This assertion
does not assume that any Galois group realizes that transvection.

### 1.1 A functional avoiding two vectors

For any two nonzero vectors `u,v`, there is a functional `h` nonzero on
both. Choose `f` with `f(u)=1`. If `f(v)!=0`, use `h=f`. Otherwise choose
`g` with `g(v)=1`. If `g(u)!=0`, use `h=g`; if `g(u)=0`, use `h=f+g`.
Existence of a functional taking value one on a nonzero vector follows
by extending that vector to a basis. This argument works in characteristic
two as well. If either vector is zero, impose the requirement only on the
nonzero vectors; with both zero take the zero functional.

### 1.2 Explicit transvection proof

Set `P(v)=v-l(v)w`. This is a linear map and `P(w)=0`. Apply section 1.1
to the nonzero vectors among `P(x),P(y)` and choose a functional `h`
nonzero on all of them. Put `f=h composed with P`; then `f(w)=0`.

For a scalar `z` define

\[
 F_z(v)=v+z f(v)w.                                        \tag{3}
\]

Since `f(w)=0`, direct substitution gives `F_{-z}F_z=F_zF_{-z}=id`.
Thus `F_z` is a linear automorphism. Equation (1) gives

\[
 t(F_zv)=t(v),\qquad l(F_zv)=l(v)+zf(v).                  \tag{4}
\]

For `v=x` or `y`, the latter affine polynomial in `z` is not identically
zero. Indeed, if `l(v)=0` then `P(v)=v!=0`, whence `f(v)!=0` by construction.
Each polynomial therefore has at most one root. The three distinct
scalars `0,1,-1` cannot all be roots of these two polynomials. Choosing a
remaining scalar proves (2). All inverse and preservation identities have
been exhibited, rather than inferred from a dimension count.

If `t,l` are linearly independent, a vector as in (1) exists: otherwise
`l` would vanish on `ker(t)` and hence be a scalar multiple of `t`.
For a nonzero value `l(w_0)` on `ker(t)`, replace `w_0` by
`l(w_0)^{-1}w_0`.

### 1.3 Application to the full trace stabilizer of a tame log lattice

Let `E/Q_p` be finite Galois, `p>2`, and let its ramification index satisfy
`2<=e<=p-2`. Normalize `v(p)=1`, write `O=O_E`, and choose a uniformizer
`pi`. With `kappa=1-1/e`, the logarithm-convergence argument in the preceding
hull note gives

\[
 I=p^{-1}\log(O^\times)=\pi^{1-e}O.
\]

Because the extension is tame, this is the inverse different. The trace
pairing identifies it with the `Z_p`-dual of `O`, and `Tr:I->Z_p` is
surjective. Also `Tr:O->Z_p` is surjective in a tame extension: trace to
the maximal unramified subfield multiplies its elements by the unit `e`,
and the trace of the unramified extension is surjective modulo `p`.

Let `V=I/pI`, let `t` be the trace modulo `p`, and let `l` be any nonzero
`F_p`-linear coordinate of the quotient `I/pi I`. The forms are independent.
Indeed, `O` is contained in `pi I` for `e>=2`, so `l` vanishes on the image
of `O`, while `t` does not. Consequently section 1.2 gives a trace-preserving
automorphism modulo `p` that sends any two primitive input vectors to
vectors nonzero in `I/pi I`.

This automorphism lifts to an integral automorphism preserving trace
exactly, not just modulo `p`. Choose a `Z_p` basis splitting the surjection
`Tr:I->Z_p`. In that basis trace is the first coordinate, and the residue
matrix of the chosen map has first row `(1,0,...,0)`. Lift the other rows
arbitrarily while leaving the first row exactly so. Its determinant is a
unit since its reduction is invertible; the adjugate provides an integral
inverse. This lift preserves trace and reaches the least native valuation
`-kappa` on both vectors.

In particular, for `u=log(1+p)/p`, `tau=log(1+pa)/p`,
`r=v(a)>0`, and `k=floor(r+kappa)`, a single element of the **full integral
trace stabilizer** can send `u` and `tau/p^k` to that minimum layer.
The proof of the preceding hull theorem then still gives

\[
 H_m=p^{k-m\kappa}B_m
\]

if all elements of this trace stabilizer are allowed in the collation.
Thus trace preservation by itself does not invalidate that conditional
formula. It also does not prove the formula for the actual Galois-induced
image, which may be a strictly smaller subgroup. Further source constraints
must be established rather than guessed.

## 2. A fixed cubic residual support does not bound abc height

For a positive integer `n` write

\[
 R_0(n)=\prod_{p\mid n,\;3\nmid v_p(n)}p.
\]

There are infinitely many positive primitive abc triples of unbounded
height with `R_0(abc)=3`. This refutes a proposed height bound depending
only on this residual support. It does not refute a bound using the full
radical, and is not an abc counterexample.

### 2.1 An infinite-order rational point

Consider the nonsingular elliptic curve

\[
 E:\quad Y^2=X^3-34992
\]

and its rational point `P=(36,-108)`. The tangent formula gives

\[
 2P=(252,3996),\qquad
 X(4P)=\left(\frac{882}{37}\right)^2-504
       =\frac{87948}{1369}.                              \tag{5}
\]

The last fraction is not an integer: its numerator has remainder `36`
modulo `37`. By the classical Nagell--Lutz integrality theorem, a torsion
rational point on a nonsingular model `Y^2=X^3+A X+B` with integral `A,B`
has integral affine coordinates. Thus `4P`, and hence `P`, has infinite
order. All hypotheses hold here (`B=-34992!=0`). A precise independent
source is Andrew Sutherland's MIT 18.782 Lecture 24, Theorem 24.21:
[lecture notes](https://math.mit.edu/classes/18.782/2013fa/LectureNotes24.pdf).
This theorem is an external, unconditional mathematical input; it is not
silently imported as a Lean axiom.

### 2.2 Primitive integral triples

The birational formulas

\[
 u=\frac{324+Y}{6X},\qquad v=\frac{324-Y}{6X}
\]

give `u^3+v^3=9`. Conversely,

\[
 X=\frac{108}{u+v},\qquad Y=\frac{324(u-v)}{u+v}.
\]

For a rational affine point of this real curve, `X` is nonzero, since
`X=0` would give a negative square. Also `u+v` is nonzero because its
vanishing would contradict `u^3+v^3=9`. The multiples of the infinite-order
point therefore give infinitely many distinct rational solutions.

Clear denominators to write `u=x/z`, `v=y/z` with `z>0` and
`gcd(x,y,z)=1`. Then

\[
 x^3+y^3=9z^3.                                           \tag{6}
\]

Neither `x` nor `y` is zero, since nine is not a rational cube. These
integers are pairwise coprime and `3` divides neither `x` nor `y`.
For a prime other than three, divisibility of two coordinates in (6)
forces divisibility of the third. If `3|x`, reduction modulo three gives
`3|y`; then divisibility by `27` on the left forces `3|z`, contrary to
primitivity. The same argument handles `3|y`. A common divisor of `x,z`
or `y,z` would now divide the other coordinate as well.

Since the right side of (6) is positive, either both left coordinates are
positive or exactly one is negative. In the first case use
`(a,b,c)=(x^3,y^3,9z^3)`. If `x<0`, use
`(a,b,c)=((-x)^3,9z^3,y^3)`, and similarly if `y<0`. These are positive
pairwise-coprime abc triples. Every prime other than three has exponent
divisible by three in their product, whereas the exponent of three is
`2+3v_3(z)`. Hence `R_0(abc)=3` exactly.

Only finitely many signed ordered rational solutions produce any one
positive abc triple by this recipe: the three magnitudes determine their
integer cube roots and the denominator, and there are only finitely many
placements and signs. Infinitely many rational solutions therefore give
infinitely many abc triples. There are only finitely many triples below
any fixed height, so their heights are unbounded.

This example leaves the primes whose exponents are divisible by three
fully active in the full radical. In the auxiliary Mordell/Thue reduction,
it explains why a field depending only on cubic residual coefficients may
be fixed while the point height and the remaining norm or denominator
terms grow. A field-height bound cannot be substituted for the missing
point-height estimate.

## 3. Algebraic rigidity from all line neighborhoods

The following proof is recorded before the corresponding Lean module.
It is a coordinate version of the all-sublattice argument in section 3
of `IUT_ADMISSIBLE_GALOIS_UNIFORM_GATE_2026_08_30.md`.

Let `R` be a commutative ring, let `pi in R`, and suppose

\[
 (\forall n\ge0,\;\pi^n\mid z)\quad\Longrightarrow\quad z=0.
 \tag{7}
\]

Let `L=R^d` with `d>=1` finite. Suppose an `R`-linear map `F:L->L`
satisfies, for every `v in L` and every `n>=0`,

\[
 F(v)\in Rv+\pi^n L.
 \tag{8}
\]

Then `F=lambda id_L` for some `lambda in R`. If `F` is an automorphism,
then `lambda` is a unit.

**Proof.** Write `e_i` for the standard basis vectors. If `j!=i`, the
`j` coordinate of (8) for `v=e_i` shows that every power of `pi` divides
`F(e_i)_j`. Thus (7) gives `F(e_i)_j=0`; write the remaining diagonal
coordinate as `lambda_i`.

For `i!=j`, use (8) with `v=e_i+e_j`. Its two corresponding coordinates
have the form

\[
 \lambda_i=a_n+\pi^n z_{n,i},\qquad
 \lambda_j=a_n+\pi^n z_{n,j}.
\]

Their difference is divisible by every `pi^n`. Applying (7) gives
`lambda_i=lambda_j`. Choosing any one index therefore gives a common
`lambda`, and equality on a basis proves `F=lambda id`. If `F` is
surjective, choose `v` with `F(v)=e_i`. Its `i` coordinate gives
`lambda v_i=1`, so `lambda` is a unit in the commutative ring. QED.

For `R=Z_p` and `pi=p`, hypothesis (7) holds without an extra axiom:
if `z!=0` had valuation `v`, divisibility by `p^(v+1)` would require
`v+1<=v`. Every module `Z_p v+p^n L` contains `p^n L` and hence has
finite index, since `L/p^n L` is finite. Thus preservation of every
finite-index sublattice implies (8). The local class field theory proof
that the actual Ism group preserves all these sublattices remains a
separate mathematical input; it is not encoded as a Lean axiom.

## 4. Formalization boundary

The first formalization constructs the actual rank-one linear
automorphisms in section 1.2 and verifies their common avoidance and trace
identities. The second certifies section 3, including (7) for the actual
p-adic integers. The local inverse-different and Galois-image identifications
remain separate mathematical statements. The infinite family in section 2
uses Nagell--Lutz; its full elliptic-curve and finiteness realization is not
claimed to be kernel-closed merely from the displayed rational identities.
