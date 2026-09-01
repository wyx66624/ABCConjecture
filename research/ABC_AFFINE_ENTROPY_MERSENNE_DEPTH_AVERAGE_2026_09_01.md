# Affine certificate entropy and Mersenne divisor-average depth

**Author:** ChatGPT  
**Date:** September 1, 2026  
**Status:** unconditional intermediate theorems, two narrowly scoped
counterexamples, and explicit open gates.  The standard abc conjecture remains
unproved and undisproved.

## 1. Proof and counterexample policy

This checkpoint advances positive proofs and counterexample searches in
parallel.  A route is not abandoned because its next estimate is difficult,
because the current literature is insufficient, or because a finite search
finds no counterexample.  Only a counterexample satisfying every premise of a
precise proposed statement closes that statement.  A counterexample to a
weakened auxiliary lemma does not close the corrected lemma or the broad
route.

For coprime positive integers `a+b=c`, the target is

\[
 \forall\varepsilon>0\ \exists C_\varepsilon\
 \quad \log c\le(1+\varepsilon)\log\operatorname{rad}(abc)+C_\varepsilon.
\]

Its negation requires one fixed positive `\varepsilon` and violations at
unbounded height.  No finite computation in this checkpoint has that
quantifier structure.

## 2. Affine route: a fixed-template entropy theorem

Let a primitive seed satisfy `a+b=c`, orient it by `b\ge c/2`, and put
`R=\operatorname{rad}(abc)`.  In the minimal radical-step affine fibre set

\[
 U=1+Rh,\qquad V=1+R(h+ck),\qquad W=1+R(h+bk).
\]

For one fixed divisibility template `d_U|U`, `d_V|V`, `d_W|W`, impose the
pairwise and coefficient coprimality conditions listed in
`ABC_AFFINE_TEMPLATE_ENTROPY_2026_09_01.md`.  If two template points have
difference `(x,y)`, then

\[
 d_U\mid x,\qquad d_V\mid x+cy,\qquad d_W\mid x+by.
\]

When all three linear factors are nonzero, pairwise coprimality gives

\[
 d_Ud_Vd_W\mid x(x+cy)(x+by),
\]

and therefore, with `H=\max(|x|,|y|)`,

\[
 d_Ud_Vd_W\le(c+1)^2H^3.                         \tag{2.1}
\]

The three zero-factor branches are separate.  For example, `x=0` lets one
cancel `c` and `b` and obtain `d_Vd_W|y`; the individual cap on `d_U` then
rules out `H\le L`.  The branches `x+cy=0` and `x+by=0` analogously require
the caps on `d_V` and `d_W`.  Thus the complete separation theorem includes
all three caps rather than silently dividing by a zero factor.

Take the canonical box and separation scale

\[
 M=\left\lfloor\frac{c^6}{4R}\right\rfloor,
 \qquad L=\left\lfloor\frac{c^4}{13}\right\rfloor.
\]

For a primitive seed with `c\ge6` and `R<c`, one has `R\ge6`.  The exact
constant checks are

\[
 49\cdot8192<36\cdot6\cdot13^3,
 \qquad 8192<13Rc^3,
\]

and

\[
 \left(\frac{13}{4}+\frac5{36}\right)^2
 =\frac{3721}{324}<12.
\]

Consequently every fixed full-strength template that certifies the required
three-arm divisor excess contains fewer than

\[
                         \frac{12c^4}{R^2}          \tag{2.2}
\]

canonical parameters.  For fixed real `\kappa,\eta>0`, if a union of `N` such templates contains at least
`\kappa R^{-2/3}c^{4+\eta}` parameters, (2.2) gives the strict entropy bound

\[
                  N>\frac{\kappa}{12}R^{4/3}c^\eta. \tag{2.3}
\]

This is a positive unconditional theorem.  It closes the large-modulus
boundary for one fixed certificate.  It does not exclude adaptive or
correlated templates, an unbounded template union, algebraic
parametrizations, or accidental residual excess.  Those affine mechanisms
remain active.

### Exact counterexample to deleting one cap

Set

\[
 B=1,\ C=2,\ L=1,\ T=10,\quad
 d_U=31,\ d_V=d_W=1,
\]

and use the two points `(30,1)` and `(30,2)`.  All divisibility,
coprimality, determinant, cubic-threshold, and the other two cap hypotheses
hold, while the sup distance is one.  The sole failed premise of the corrected
theorem is `d_U\le X_U` when `X_U=1`.  Hence this is a full-premise
counterexample only to the proposed cap-omitted strengthening.  It proves why
the individual cap is logically necessary; it does not refute the corrected
separation theorem or the affine route.

## 3. Mersenne route: the exact divisor-average endpoint

Let

\[
 M_m=2^m-1,\qquad W_m=M_m/\operatorname{rad}(M_m).
\]

For an odd prime `q`, put `d_q=\operatorname{ord}_q(2)` and
`w_q=v_q(2^{d_q}-1)`.  Define

\[
 E_d=\prod_{d_q=d}q^{w_q-1}.
\]

The corrected exact ledger is

\[
 W_m=L_m\prod_{d\mid m}E_d,\qquad L_m\mid m.       \tag{3.1}
\]

Taking logarithms in (3.1) and using
`0\le\log L_m\le\log m=o(m)` proves the exact equivalence

\[
 \log W_m=o(m)
 \quad\Longleftrightarrow\quad
 \sum_{d\mid m}\log E_d=o(m).                     \tag{3.2}
\]

The previously targeted pointwise condition
`\log E_d=o(\varphi(d))` implies (3.2) because
`\sum_{d\mid m}\varphi(d)=m`, but it is stronger than necessary.  A
primorial-supported abstract sequence gives large pointwise normalized values
at sparse orders while its divisor averages are still little-oh, proving the
strict logical weakening.

Brun--Titchmarsh controls the repeated exact-order support only below
`\varphi(d)^2/\log\log(3d)`.  The available Erdős--Murty zero-density,
progression, dyadic-shell, and cyclotomic square-budget estimates supply no
uniform `o(\varphi(d))` saving in the remaining moving fibre.  An abstract
label model satisfies the coarse congruence, size, weighted global sparsity,
and numerical square budget while retaining linear fibre mass.  Its labels
are not actual orders or actual square divisibilities, so it refutes only the
coarse inference and does not refute the arithmetic Mersenne route.

## 4. Super-Wieferich depth: exact layer cake

Split

\[
 E_d=T_dD_d,
\]

where `T_d` contains one copy of every repeated exact-order prime and `D_d`
contains multiplicity beyond the second copy.  For `j\ge3`, define

\[
 \Theta_{d,j}=\sum_{d_q=d,\,w_q\ge j}\log q.
\]

Each prime of depth `w_q` occurs in exactly the layers
`j=3,\ldots,w_q`, so finite sum interchange proves

\[
                         \log D_d=\sum_{j\ge3}\Theta_{d,j}. \tag{4.1}
\]

For an integer threshold `K\ge3`, let

\[
 R_d(K)=\sum_{d_q=d,\,w_q\ge3}(w_q-K)_+\log q,
 \qquad
 S_d^{(3)}=\prod_{d_q=d,\,w_q\ge3}q.
\]

The integer identity

\[
 w-2=\min(w-2,K-2)+(w-K)_+
\]

gives the exact truncation and the bound

\[
 \log D_d\le(K-2)\log S_d^{(3)}+R_d(K).            \tag{4.2}
\]

Thus moving thresholds `K_d` satisfying

\[
 (K_d-2)\log S_d^{(3)}=o(\varphi(d)),\qquad
 R_d(K_d)=o(\varphi(d))
\]

control the deep factor pointwise.  The weaker endpoint obtained by combining
(3.2) and (4.2) is the divisor-average gate

\[
 \sum_{d\mid m}
 \bigl(U_d+(K_d-2)\log S_d^{(3)}+R_d(K_d)\bigr)=o(m), \tag{4.3}
\]

where `U_d` is the uncontrolled one-copy support after the proven small arm.
No cited theorem currently establishes (4.3), but its difficulty is not a
counterexample.  The depth route remains active.

### Exact odd-order counterexample at 3511

Pocklington certificates prove that `3511` is prime.  Direct modular
certificates give

\[
 2^{1755}\equiv1\pmod{3511^2},\qquad
 2^{1755}\not\equiv1\pmod{3511^3},
\]

and the residues at exponents `585`, `351`, and `135` exclude division of
the order by `3`, `5`, and `13`.  Hence

\[
 \operatorname{ord}_{3511}(2)=1755,
 \qquad v_{3511}(2^{1755}-1)=2.                    \tag{4.4}
\]

Equation (4.4) is a full-premise counterexample to the universal assertion
that every base-two Wieferich prime has even exact order.  Its depth is two,
so it is not super-Wieferich and contributes nothing to `D_{1755}`.  It does
not refute (4.2), (4.3), or the Mersenne route.

Two independent scans agree on all 664,579 primes at most `10^7`: the only
base-two Wieferich hits are `1093` and `3511`, both at depth two.  This is a
finite verification of the explicit certificates.  The no-hit for depth
three makes no asymptotic claim and does not retire the route.

## 5. Lean boundary and current decision

The mathematical arguments above precede their Lean counterparts:

- `AffineTemplateEntropy20260901.lean` checks the complete finite separation
  algebra, affine-step cancellation, canonical packing constant, entropy
  implication, and the cap-omission counterexample;
- `MersenneWeightedOrderTail20260901.lean` checks the finite shell algebra,
  divisor-mass transfer, and exact endpoint equivalence;
- `MersenneSuperWieferichDepth20260901.lean` checks the finite layer cake,
  truncation, threshold implications, canonical block identities, and all
  arithmetic certificates at `3511`.

The external analytic estimates are not inserted as axioms.  There is no
Lean term proving unconditional `ABCConjecture` or its negation.

Both broad routes are retained.  The affine route now asks how a sufficiently
large exceptional set could distribute across at least the entropy lower
bound (2.3), allowing templates chosen adaptively from the point.  The
Mersenne route now asks for the divisor-average support/depth estimate (4.3),
which is strictly weaker than the old pointwise target.  Positive proof and
full-premise counterexample searches continue on both interfaces.
