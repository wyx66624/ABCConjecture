# Prime 19: pure-field square reduction and the dyadic no-go

## 0. Verdict

Put

\[
 K=\mathbf Q(a),\qquad a^{19}=2,
 \qquad q_t=a^2+ta+1,
 \qquad t=X/2.
\]

The neutral curve-level fake-two-cover condition is exactly

\[
 q_t\in K^{\times 2}.                                      \tag{0.1}
\]

This note records two unconditional conclusions about trying to use (0.1)
directly.

1. The necessary congruence `X = -4 (mod 96)` gives **no further dyadic
   obstruction**.  In fact every `t in Q_2` with
   `v_2(t+2) >= 2` makes `q_t` a square in the unique completion of `K` at
   two.  The target congruence has `v_2(t+2) >= 4`.
2. For `t != +/-2`, the global square question is exactly the irreducibility
   question for the explicit degree-38 polynomial

   \[
   G_t(Z)=(Z^2-1)^{19}-2(2Z+t)^{19}.                       \tag{0.2}
   \]

   Namely, `q_t` is a square in `K` if and only if `G_t` is reducible over
   `Q`; otherwise `G_t` is irreducible.  Thus this is an exact executable
   reduction, not a bounded search.

No proof that (0.1) forces `t=+/-2` is claimed here.  The result instead
rules out the tempting idea that the deep congruence at two itself performs
that classification.

## 1. Coordinate normalization

Let `theta` be the root used by the monic Chebyshev model.  In the pure-field
presentation,

\[
 \theta=-2(a+a^{-1}).                                      \tag{1.1}
\]

The neutral fake-two-cover says that `X-theta` is a square in `K`.  Now

\[
 {a\over2}(X-\theta)
   ={a\over2}\bigl(X+2(a+a^{-1})\bigr)
   =a^2+{X\over2}a+1.                                     \tag{1.2}
\]

Moreover

\[
 {a\over2}=a^{-18}=(a^{-9})^2,
 \qquad {2\over a}=a^{18}=(a^9)^2.                        \tag{1.3}
\]

Hence multiplication in (1.2) is by a square and the implication works in
both directions.  This verifies the coordinate convention without appealing
to a numerical embedding.

The visible values are

\[
 q_2=(a+1)^2,\qquad q_{-2}=(a-1)^2.                        \tag{1.4}
\]

## 2. The entire target dyadic disc is locally soluble

Let

\[
 K_2=\mathbf Q_2(a),\qquad a^{19}=2.
\]

The polynomial `Z^19-2` is Eisenstein at two.  Thus `K_2/Q_2` is totally
ramified of degree 19.  Normalize its discrete valuation by

\[
 v(a)=1,\qquad v(2)=19.                                   \tag{2.1}
\]

For `t in Q_2`, consider

\[
 F_t(Y)=Y^2-q_t
\]

at the approximate root `Y_0=a-1`.  Directly,

\[
 F_t(a-1)=-(t+2)a,
 \qquad F_t'(a-1)=2(a-1).                                 \tag{2.2}
\]

Since `a-1` is a unit, if `s=v_2(t+2)` then

\[
 v(F_t(a-1))=19s+1,
 \qquad v(F_t'(a-1))=19.                                  \tag{2.3}
\]

For `s>=2`,

\[
 19s+1\ge39>38=2v(F_t'(a-1)).                             \tag{2.4}
\]

The strong Hensel lemma therefore supplies a root of `F_t` in `K_2`.
Equivalently,

\[
 v_2(t+2)\ge2\quad\Longrightarrow\quad q_t\in K_2^{\times2}.
                                                                    \tag{2.5}
\]

For the residual Pell branch,

\[
 X=-4+96k,qquad t=X/2=-2+48k.                             \tag{2.6}
\]

Thus `v_2(t+2)>=4` whenever `k != 0`, and `k=0` is the visible exact square.
Every value in the required congruence disc is therefore locally soluble at
two.  For example `X=92`, `t=46` is different from the visible value but is
a rigorously certified local square by (2.2)--(2.4).  This is a local
counterexample, not an assertion that `q_46` is a global square.

## 3. Exact Capelli reduction

Assume `t != +/-2` and define the rational function

\[
 \phi_t(Z)={Z^2-1\over 2Z+t}.                              \tag{3.1}
\]

The numerator and denominator are then coprime.  The polynomial
`U^19-2` is irreducible over `Q` by Eisenstein at two, with root `a`.
Capelli's irreducibility theorem for a polynomial composed with a rational
function says that the numerator of

\[
 \phi_t(Z)^{19}-2
\]

is irreducible over `Q` if and only if

\[
 Z^2-1-a(2Z+t)                                             \tag{3.2}
\]

is irreducible over `K`.  Its discriminant is

\[
 (-2a)^2-4(-1-ta)=4(a^2+ta+1)=4q_t.                       \tag{3.3}
\]

Since four is a square, (3.2) is reducible over `K` exactly when `q_t` is a
square in `K`.  Clearing the denominator in the composition gives precisely
`G_t` from (0.2).  Therefore

\[
 \boxed{
 q_t\in K^{\times2}
 \iff G_t\text{ is reducible over }\mathbf Q
 }
 \qquad(t\ne\pm2).                                       \tag{3.4}
\]

If the left side holds, (3.2) splits and `G_t` has two degree-19 factors.
If it does not hold, Capelli proves that `G_t` is irreducible of degree 38.

At the two excluded parameters the cancellation is explicit:

\[
\begin{aligned}
 G_2(Z)&=(Z+1)^{19}\bigl((Z-1)^{19}-2^{20}\bigr),\\
 G_{-2}(Z)&=(Z-1)^{19}\bigl((Z+1)^{19}-2^{20}\bigr).
\end{aligned}                                             \tag{3.5}
\]

Thus a proposed direct proof can be audited equivalently as a uniform
irreducibility theorem for (0.2) on the arithmetic progression
`t=-2+48k`, `k>0`.  A finite list of factorizations cannot supply that
uniform theorem.

## 4. Why the full neutral cover has no deck-translation intermediate
## quotient over `Q`

Over an algebraic closure, the full neutral pullback is an unramified torsor
under

\[
 J_{19}[2]\simeq\mathbf F_2^{18}.                          \tag{4.1}
\]

The Galois action on the 19 finite Weierstrass roots contains the 19-cycle
coming from `a -> zeta_19*a`.  Restricted to this cyclic subgroup, the
18-dimensional augmentation module is

\[
 \mathbf F_2[Z]/(\Phi_{19}(Z)).                            \tag{4.2}
\]

The multiplicative order of two modulo 19 is 18.  Hence `Phi_19` is
irreducible over `F_2`, and (4.2) is an irreducible module.  It follows that
`J_19[2]` has no nonzero proper Galois-stable subspace.

Consequently there is no proper intermediate quotient defined over `Q`
obtained by quotienting the neutral cover by a subgroup of its deck
translations.  The only such endpoints are the full degree-`2^18` cover and
the base genus-nine curve.  By Riemann--Hurwitz the full cover has genus

\[
 1+2^{18}(9-1)=2,097,153.                                 \tag{4.3}
\]

This statement does not rule out every imaginable non-deck rational map.
It does rule out the canonical source of an abelian intermediate
two-cover, so an elliptic or other low-genus quotient cannot simply be read
off from a proper rational two-torsion submodule.

## 5. Reproduction and trust boundary

Run

```text
sage audit_scripts/p19_chebyshev_purefield_dyadic_nogo.sage
```

The script checks exactly:

* the coordinate identity modulo `a^19-2` and both square multipliers;
* the visible factorizations and the two factorizations in (3.5);
* the degree-38 Capelli polynomial for the concrete local counterexample
  `t=46` (its irreducibility is a diagnostic, not the uniform theorem);
* `ord_19(2)=18`, irreducibility of `Phi_19` over `F_2`, and the cover genus;
* the valuation inequalities used by strong Hensel.

The mathematical implication (2.5) uses the standard strong Hensel lemma.
The equivalence (3.4) uses the standard Capelli theorem.  Neither result
uses abc, GRH, BSD, finiteness of `Sha`, a rank assumption, or a search
cutoff.  The companion Lean file checks the scalar and polynomial identities
but does not formalize local fields, Hensel's lemma, Capelli's theorem, or
the Galois-module interpretation.

## 6. Accepted references

* I. N. Stewart and D. O. Tall, *Algebraic Number Theory and Fermat's Last
  Theorem*, for the strong valuation form of Hensel's lemma.
* A. Capelli, the classical irreducibility theorem for compositions; any
  standard modern formulation over a field of characteristic zero gives the
  criterion used in Section 3.
* J.-P. Serre, *Linear Representations of Finite Groups*, for the cyclic
  module description and the cyclotomic irreducibility criterion over finite
  fields.
