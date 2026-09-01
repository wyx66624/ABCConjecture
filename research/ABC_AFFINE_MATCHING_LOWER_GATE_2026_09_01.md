# The affine matching-lower gate after minimal-support shearing

**Date:** 2026-09-01  
**Scope:** independent mathematical audit of the positive affine route  
**Status:** the matching lower bound is **not proved and not refuted**. The affine route remains active.

## 0. Executive verdict

Let

\[
 a+b=c,\qquad \gcd(a,b)=1,\qquad
 P=abc,\qquad \mathcal R=\operatorname{rad}(P).
\]

The original affine fibre uses step `P`. Its step can be reduced, without
losing any of the primitive or injective structure, to the smallest possible
support-killing step $Q=\mathcal R$. More generally, every positive integer
`Q` satisfying

\[
                         \mathcal R\mid Q
\]

works. For the canonical height box this replaces the raw `K=8` exponent

\[
                         12-2\rho
       \quad\hbox{by}\quad 12-2\sigma,
\]

where $P=c^{\rho+o(1)}$ and $\mathcal R=c^{\sigma+o(1)}$. This is a genuine
positive improvement in the supply of primitive targets.

It does **not** change the exceptional upper gate. For every such `Q`, the
pair-projection argument still gives

\[
             |\mathcal E_Q(c^8)|
             \ll_\varepsilon
             \mathcal R^{-2/3}c^{4+\varepsilon}.            \tag{0.1}
\]

Moreover, every $Q=s\mathcal R$ fibre in its canonical box is a subfamily of
the minimal-step fibre, obtained by replacing `(h,k)` with `(sh,sk)`. Thus
averaging over multiples of $\mathcal R$ does not enlarge the set of outputs.

The logical status of the desired matching lower bound can be stated exactly.
Once (0.1) is available, for fixed $\lambda<1$ and $\eta>0$, a uniform eventual
lower bound

\[
             |\mathcal E_{\mathcal R}(c^8)|
             \ge A\mathcal R^{-2/3}c^{4+\eta}              \tag{0.2}
\]

on every seed with $\mathcal R<c^\lambda$ is equivalent to boundedness of that
subcritical seed locus. In the bounded-to-lower direction the assertion is
vacuous: choose the lower threshold above the largest seed. Therefore (0.2)
is a valid contradiction route, but it is not an independently weaker
arithmetic statement after the upper bound is known. A finite small-height
counterexample cannot refute its eventual form.

The exact CRT calculation below proves a limited no-go. A fixed triple of
pairwise-coprime prime-power divisibility conditions has density `1/D` and
the deterministic lower certificate supplied solely by those divisibilities
is `Delta<=D`. At the required certified-excess scale its periodic main
term is negligible. This closes only a fixed-template/local-density
main-term mechanism. It does not control the large-modulus boundary, unions
of many templates, or accidental solutions.

An exhaustive exact computation for the subcritical seed `(1,8,9)` finds no
exception in all `447,120,793` admissible points of the minimal-step `K=8`
box. This refutes any lower bound applying to this seed with no eventual
threshold, and it shows that this concrete fibre can remain exception-free
despite its large raw cardinality.  It does not refute an asymptotic claim
whose unspecified threshold may lie beyond this box. Explicit triples with
all three cofactors perfect squares are also nonexceptional, so an
all-square certificate by itself is insufficient. These finite facts do not
refute (0.2).

Finally, the v29 contact-depth reductions concern primes already present in
the source endpoints. Every such prime has valuation zero in all three new
cofactors. Hence those contact depths do not directly become affine-cofactor
excess. The positive-contact closure can instead bound that class of seeds
directly; the zero and negative branches do not currently supply the missing
affine matching lower bound.

## 1. The generalized support-modulus shear

For positive integers `h,k`, define

\[
 \begin{aligned}
 U_Q&=1+Qh,\\
 V_Q&=1+Q(h+ck),\\
 W_Q&=1+Q(h+bk).
 \end{aligned}                                             \tag{1.1}
\]

The next theorem records all hypotheses. In particular, `Q` need not equal
`abc` and need not contain the full prime powers of the seed.

### Theorem 1.1 (primitive shear for every support-killing modulus)

Let `a,b,c,Q,h,k` be positive integers such that

\[
 a+b=c,\qquad \gcd(a,b)=1,\qquad
 \operatorname{rad}(abc)\mid Q,\qquad
 \gcd(U_Q,k)=1.                                            \tag{1.2}
\]

Then:

1. `aU_Q+bV_Q=cW_Q`.
2. Each of `U_Q,V_Q,W_Q` is coprime to `abc` (seed-prime avoidance).
3. The three cofactors are pairwise coprime.
4. The three endpoints `aU_Q,bV_Q,cW_Q` are pairwise coprime.
5. Each of the three maps
   \[
   (h,k)\mapsto(U_Q,V_Q),\quad
   (h,k)\mapsto(U_Q,W_Q),\quad
   (h,k)\mapsto(V_Q,W_Q)
   \]
   is injective. Consequently the ordered endpoint map is injective.
6. With $\mathcal R=\operatorname{rad}(abc)$,
   \[
   \operatorname{rad}(aU_QbV_QcW_Q)
   =\mathcal R\operatorname{rad}(U_Q)
      \operatorname{rad}(V_Q)\operatorname{rad}(W_Q).      \tag{1.3}
   \]

#### Proof

The equation is an identity:

\[
 \begin{aligned}
 aU_Q+bV_Q
 &=a(1+Qh)+b(1+Qh+Qc k)\\
 &=c(1+Qh)+bcQk
 =c(1+Qh+bQk)=cW_Q.
 \end{aligned}
\]

If a prime $p$ divides $abc$, then $p\mid\mathcal R\mid Q$, and every cofactor in
(1.1) is congruent to $1\pmod p$. This proves seed-prime avoidance. Notice
also that every cofactor is coprime to `Q`, whether or not a prime of `Q`
occurs in the seed.

The difference identities are

\[
 V_Q-U_Q=cQk,\qquad W_Q-U_Q=bQk,\qquad
 V_Q-W_Q=aQk.                                               \tag{1.4}
\]

Let `d=gcd(U_Q,V_Q)`. Then `d|cQk`. Because `d|U_Q` and
`gcd(U_Q,cQ)=1`, one has `d|k`; admissibility forces `d=1`. The same
argument with `bQk` gives `gcd(U_Q,W_Q)=1`. Since
$V_Q\equiv U_Q\pmod k$, admissibility also gives `gcd(V_Q,k)=1`.
If `d=gcd(V_Q,W_Q)`, then `d|aQk`, while `V_Q` is coprime to `aQ` and to
`k`; hence `d=1`.

The seed coordinates are pairwise coprime, because `gcd(a,b)=1` and
`c=a+b`. The prime supports of the three seed coordinates, and those of the
three new cofactors assigned to the other coordinates, are disjoint by the
previous two paragraphs. Thus the endpoints are pairwise coprime.

The recovery formulae are explicit:

\[
 \begin{array}{lll}
 (U_Q,V_Q):&h=(U_Q-1)/Q,&k=(V_Q-U_Q)/(cQ),\\
 (U_Q,W_Q):&h=(U_Q-1)/Q,&k=(W_Q-U_Q)/(bQ),\\
 (V_Q,W_Q):&k=(V_Q-W_Q)/(aQ),
   &h=(W_Q-1)/Q-bk.
 \end{array}                                                \tag{1.5}
\]

All denominators are fixed positive integers, so every projection is
injective. An endpoint determines its attached cofactor by division by the
fixed seed coordinate, proving endpoint injectivity. Finally, seed-prime
avoidance and pairwise coprimality of the cofactors give the radical
factorization (1.3). ∎

The condition `rad(abc)|Q` is the natural general condition for this proof.
It is used prime by prime; requiring `abc|Q` is unnecessarily strong.

## 2. Height, raw count, and the optimal step within this family

Fix a real `K` and define

\[
              M_Q=\left\lfloor {c^{K-2}\over4Q}\right\rfloor.
                                                                    \tag{2.1}
\]

### Proposition 2.1 (uniform height and raw count)

Suppose `M_Q` is sufficiently large. Among the pairs
`1<=h,k<=M_Q`, at least `M_Q^2/8` are admissible. At least
`M_Q^2/32` admissible pairs lie in the upper half box

\[
                  M_Q/2\le h,k\le M_Q.                    \tag{2.2}
\]

Every corresponding endpoint has height

\[
                         H=cW_Q<c^K                       \tag{2.3}
\]

for sufficiently large `c`. All these endpoints are distinct.

#### Proof

The elementary sieve in
`research/ABC_AMPLIFICATION_GATE_ATTACK_2026_08_31.md`, Lemma 2.3, applies
word for word with `Q` in place of `P`: a bad pair has a prime `ell` dividing
both `1+Qh` and `k`; necessarily `ell` does not divide `Q`, and for each
such `ell` there is one residue class of `h mod ell`. The union bound gives
the stated absolute proportions, independently of `Q`.

For the height, `h,k<=M_Q` and `b+1<=c` give

\[
 \begin{aligned}
 H&=c+cQ(h+bk)\\
  &\le c+cQM_Q(1+b)
   \le c+{c^K\over4}<c^K
 \end{aligned}                                             \tag{2.4}
\]

once `c` is large. Distinctness is Theorem 1.1. ∎

Write

\[
 P=c^{\rho+o(1)},\qquad \mathcal R=c^{\sigma+o(1)}.
\]

For `Q=P`, Proposition 2.1 gives the old raw exponent

\[
                       2K-4-2\rho.
\]

For the minimal choice $Q=\mathcal R$, it gives

\[
                       2K-4-2\sigma.                       \tag{2.5}
\]

Thus at `K=8` the raw count improves from

\[
                       c^{12-2\rho+o(1)}
       \quad\hbox{to}\quad c^{12-2\sigma+o(1)}.            \tag{2.6}
\]

On the fixed locus $\mathcal R<c^\lambda$, one has, for sufficiently large
`c`,

\[
 M_{\mathcal R}
 \ge {c^{K-2-\lambda}\over8},
 \qquad
 \#\{\hbox{admissible points}\}
 \ge {c^{2K-4-2\lambda}\over512}.                          \tag{2.7}
\]

This is a substantial raw amplification. It says nothing by itself about
the radical of the output.

### Proposition 2.2 (multiples of the minimal step are nested)

Let $Q=s\mathcal R$, where `s` is a positive integer. Then

\[
 (U_Q,V_Q,W_Q)(h,k)
 = (U_{\mathcal R},V_{\mathcal R},W_{\mathcal R})(sh,sk).  \tag{2.8}
\]

If `(h,k)` is `Q`-admissible, then `(sh,sk)` is
$\mathcal R$-admissible. Moreover,

\[
                         sM_Q\le M_{\mathcal R}.            \tag{2.9}
\]

Consequently the `Q` fibre in its canonical box is a subset of the
minimal-step fibre in its canonical box.

#### Proof

Equation (2.8) follows by substitution. Since
$U_Q=1+s\mathcal R h$ is congruent to $1\pmod s$, it is coprime to `s`.
Together with `gcd(U_Q,k)=1`, this gives `gcd(U_Q,sk)=1`. Finally, if
$T=c^{K-2}/(4\mathcal R)$, then

\[
 sM_Q=s\lfloor T/s\rfloor\le\lfloor T\rfloor=M_{\mathcal R}.
\]

This proves all assertions. ∎

Proposition 2.2 is a strict obstruction to a modulus-average within this
particular family: varying `Q` over multiples of $\mathcal R$ only resamples
a sublattice already present at the minimal step. It does not rule out
averaging over seeds or constructing a different affine family.

## 3. The exceptional upper gate is unchanged

Define the repeated-prime excess

\[
                         E(n)={n\over\operatorname{rad}(n)}.
\]

For every output of Theorem 1.1, (1.3) gives the exact equivalences

\[
 \begin{aligned}
 \operatorname{rad}(aU_QbV_QcW_Q)<H^\mu
 &\iff
 \operatorname{rad}(U_Q)\operatorname{rad}(V_Q)
       \operatorname{rad}(W_Q)<{H^\mu\over\mathcal R}\\
 &\iff
 E(U_Q)E(V_Q)E(W_Q)>
 {\mathcal R\over c}U_QV_QH^{1-\mu}.                       \tag{3.1}
 \end{aligned}
\]

Let $\mathcal E_Q(X)$ denote the set of all distinct admissible outputs of
height `H<=X` satisfying (3.1).  The same estimate below applies, of course,
to every subset. The pair-projection radical theorem proved in
`research/ABC_AFFINE_EXCESS_LOWER_BOUND_2026_08_31.md` applies because
Theorem 1.1 supplies all three projection injectivities and (1.3). Hence,
uniformly in the seed and in `Q`,

\[
              |\mathcal E_Q(X)|
              \ll_{\mu,\varepsilon}
              \mathcal R^{-2/3}X^{2\mu/3+\varepsilon}.     \tag{3.2}
\]

At $K=8$, $\mu=3/4$, and $X=c^8$, this is

\[
              |\mathcal E_Q(c^8)|
              \ll_\varepsilon
              \mathcal R^{-2/3}c^{4+\varepsilon}.          \tag{3.3}
\]

Thus reducing the step improves only the raw supply (2.6); the exceptional
upper exponent remains exactly the same.

There is also no change in the large-modulus localization. Orient the seed
so that $b\ge c/2$, restrict to the upper half box, take $Q=\mathcal R$ and
`K=8`, and use `M_Q>=c^6/(8Q)` for large `c`. Then

\[
 U_QV_QW_Q\ge {c^{20}\over8192}.
\]

Every $\mu=3/4$ exception therefore satisfies

\[
                  E(U_Q)E(V_Q)E(W_Q)>
                  {\mathcal R c^{14}\over8192}.            \tag{3.4}
\]

If

\[
 S(n)=\prod_p p^{\lfloor v_p(n)/2\rfloor},
\]

then `S(U_QV_QW_Q)^2|U_QV_QW_Q` and
`S(U_QV_QW_Q)^2>=E(U_QV_QW_Q)`. Hence an exception has

\[
                 S(U_QV_QW_Q)\gg \mathcal R^{1/2}c^7.      \tag{3.5}
\]

By contrast,

\[
                 M_{\mathcal R}\asymp {c^6\over\mathcal R},
 \qquad
 {\mathcal R^{1/2}c^7\over M_{\mathcal R}}
                 \asymp c\mathcal R^{3/2}.                 \tag{3.6}
\]

The desired points remain entirely in a square-divisor modulus range much
larger than the parameter side.

## 4. Exact quantifiers: matching lower versus boundedness

This section distinguishes an eventual matching lower bound from a statement
about every individual seed.

Fix $\lambda<1$, $\eta>0$, and any assignment
$s\mapsto\mathcal E(s)$ of an
exceptional affine fibre to each primitive seed `s=(a,b,c)`. Assume the
uniform upper property

\[
 \tag{U}
 \forall\varepsilon>0\ \exists C_\varepsilon>0
 \forall s:\quad
 |\mathcal E(s)|\le
 C_\varepsilon\mathcal R(s)^{-2/3}c(s)^{4+\varepsilon}.
\]

This includes the original step, the minimal step, and every generalized
step above. Consider:

\[
 \tag{L_{\lambda,\eta}}
 \exists A>0\ \exists c_0
 \forall s:\quad
 \bigl(\mathcal R(s)<c(s)^\lambda\ \wedge\ c(s)\ge c_0\bigr)
 \Longrightarrow
 |\mathcal E(s)|\ge
 A\mathcal R(s)^{-2/3}c(s)^{4+\eta};
\]

and

\[
 \tag{B_\lambda}
 \exists B\ \forall s:\quad
 \mathcal R(s)<c(s)^\lambda\Longrightarrow c(s)\le B.
\]

### Theorem 4.1 (quantifier equivalence and vacuity)

Under $(U)$, the statements $(L_{\lambda,\eta})$ and $(B_\lambda)$ are
equivalent.

#### Proof

Assume $(L_{\lambda,\eta})$, and apply $(U)$ with
$\varepsilon=\eta/2$. For a seed covered by the lower bound,

\[
 A\mathcal R^{-2/3}c^{4+\eta}
 \le |\mathcal E(s)|
 \le C_{\eta/2}\mathcal R^{-2/3}c^{4+\eta/2}.
\]

Canceling the positive common factor gives

\[
                         c^{\eta/2}\le C_{\eta/2}/A.       \tag{4.1}
\]

Seeds below `c_0` are already bounded, so $(B_\lambda)$ follows.

Conversely, assume $(B_\lambda)$. Choose `c_0>B`. There is no seed satisfying
the antecedent in $(L_{\lambda,\eta})$; therefore that universal implication
is true for any chosen `A>0`. This is precisely vacuous truth. ∎

This theorem has three practical consequences.

1. A proof of the matching lower remains a completely valid positive proof
   of boundedness by contradiction with (3.3).
2. After (3.3), it is logically as strong as boundedness on the same locus;
   one should not describe it as an easier consequence of local density
   without supplying the missing global argument.
3. The negation of the eventual lower is
   \[
   \forall A>0\ \forall c_0\ \exists s:\quad
   \mathcal R(s)<c(s)^\lambda,\quad c(s)\ge c_0,\quad
   |\mathcal E(s)|<A\mathcal R(s)^{-2/3}c(s)^{4+\eta}.
   \]
   In particular, it supplies an unbounded subcritical sequence whose
   normalized exceptional counts tend to zero. Such a sequence already
   contradicts the desired boundedness. A single finite seed can refute only
   a threshold-free version.

## 5. Exact local laws and isolation from source-prime contact

### Proposition 5.1 (source-prime isolation)

For every $Q$ with $\mathcal R\mid Q$ and every prime $p\mid abc$,

\[
             v_p(U_Q)=v_p(V_Q)=v_p(W_Q)=0.                 \tag{5.1}
\]

#### Proof

All three cofactors are congruent to $1\pmod p$. ∎

Thus high contact depths already carried by the seed endpoints cannot appear
at the same primes in the new cofactor excess. This is an exact local
statement, not an independence heuristic.

For completeness, the new-prime local distribution is also exact at the
minimal step. Let $Q=\mathcal R$, let `p` be a prime not dividing `abc`, and
let

\[
 \mathcal A_p=\neg(p\mid U_Q\ \hbox{and}\ p\mid k).
\]

Then

\[
                     \operatorname{meas}(\mathcal A_p)=1-p^{-2}.
\]

For each `F` in `{U_Q,V_Q,W_Q}` and `e>=1`,

\[
 \operatorname{meas}\{\mathcal A_p,\ v_p(F)=e\}
 =(1-p^{-1})^2p^{-e}.                                      \tag{5.2}
\]

To prove this, for each cofactor $F$ the affine change of variables
$(h,k)\mapsto(F,k)$ has determinant $Q$, a unit in $\mathbb Z_p$. Exact
valuation `e` in the first coordinate has measure
$(1-p^{-1})p^{-e}$. When $p\mid F$, local admissibility is equivalent to
$p\nmid k$: for $F=U_Q$ this is the definition, and for
$F=V_Q,W_Q$ it follows because $p\mid k$ makes
$F\equiv U_Q\pmod p$. The unit condition on `k` contributes the second
factor $1-p^{-1}$ in (5.2).

At one fixed prime the three events in (5.2) are disjoint. Indeed, two
cofactors divisible by `p` force `p|k` through (1.4), and then all relevant
forms are congruent modulo `p`, contradicting `mathcal A_p`. For any finite
set of distinct primes, arbitrary prescribed prime-power conditions factor
exactly by the two-coordinate Chinese remainder theorem: the residue space
modulo the product is the Cartesian product of the local residue spaces, so
their cardinalities multiply.

These facts justify neither global independence nor a lower bound in the
large-modulus tail. They say only:

- same-prime divisibility is negatively correlated by primitivity;
- finite data at different primes factor exactly;
- passing to a prime set or modulus growing beyond the box requires a new
  boundary estimate.

For $0<\alpha<1$, the exact local fractional moment of the `p`-part of
`E(U_Q)E(V_Q)E(W_Q)`, conditioned on `mathcal A_p`, is

\[
 1+{3(1-p^{-1})^2\over1-p^{-2}}
   \sum_{e\ge2}p^{-e}\bigl(p^{\alpha(e-1)}-1\bigr).        \tag{5.3}
\]

Its excess is $O_\alpha(p^{\alpha-2})$, so the Euler product converges for
every fixed $\alpha<1$. At $\alpha=1$, the sum diverges already at each fixed
prime. Fractional moments therefore give useful upper-tail controls, while
integer moments are dominated by arbitrarily deep powers. Neither direction
can be inverted into the desired lower bound.

## 6. What the v29 contact reductions do and do not contribute

To avoid collision with the seed radical $\mathcal R$, write the v29
powerful moduli as `R_0,S_0`, their squarefree residuals as `A_0,B_0`, and
the endpoint gap as `m`. The canonical relation is

\[
                         R_0A_0+m=S_0B_0.                  \tag{6.1}
\]

The v29 reports prove exact contact identities and recover the full exponent
heights as contact depths at primes in the source supports. Proposition 5.1
shows a strict limitation on feeding those identities into the standard
affine fibre: every one of those old primes is absent from all three new
cofactors. Hence a theorem about `v_p` of a source contact factor does not,
by itself, give any positive `v_p` contribution to
`E(U_Q)E(V_Q)E(W_Q)`.

This does not make the v29 work irrelevant. It can eliminate seeds before
amplification or impose global restrictions on the coefficients:

- **Exponent-height and contact-depth ledgers (v29, v29b, v29d).** A putative
  source counterexample forces both powerful endpoint moduli to be
  height-scale, and their full prime-power exponents occur as exact
  cross-endpoint contact depths. The one-sided target in v29d is therefore a
  genuine source-level p-adic problem. These are primes dividing the original
  endpoints, so Proposition 5.1 prevents only the *direct same-prime transfer*
  of those depths into affine-cofactor excess. The ledgers may still rule out
  the seed or constrain its coefficients globally.

- **Positive right contact (v29f).** If the scaled right contact is positive,
  the exact ledger gives
  \[
                          c\le2\mathcal R.                 \tag{6.2}
  \]
  On $\mathcal R<c^\lambda$, this implies
  $c^{1-\lambda}<2$, hence
  \[
                          c<2^{1/(1-\lambda)}.             \tag{6.3}
  \]
  Thus this branch is already bounded and needs no affine matching lower.

- **Zero contact (v29g).** The zero branch collapses to a square endpoint and
  admits the neighboring-triple descent recorded there. This is a direct
  source-level reduction; it does not force valuations in the new
  cofactors.

- **Strict negative contact (v29h).** On the unit-gap locus `m=1`, the
  canonical Bezout representative produces a strictly negative contact for
  which the transformed identity is the original equation multiplied by a
  factor. This is a rigorous local no-go against iterating the same contact
  transform as a universal descent. It does not forbid the source
  coefficients from exerting subtler global influence on the affine forms.

- **Integral derivative at unit gap (v29i).** Every nonzero compatible
  integral derivative value contains both powerful parts. After
  normalization, its smallest possible scale reproduces the abc inequality
  itself. This closes the unrestricted short-integral-derivative interface,
  not the affine matching route.

- **Support-only exponent control (v29c).** The family
  \[
  A_0=2,\ R_0=2^n,\ B_0=3,\ S_0=3^n,\quad
  m=3^{n+1}-2^{n+1}
  \]
  is a genuine primitive family and refutes a bound for exponent height in
  terms of the two residual supports alone. Its gap radical is not
  controlled. It is therefore not a counterexample to the subcritical
  affine gate.

The remaining negative-contact branch may still bound the source locus
directly, or its global coefficient restrictions may eventually help the
affine large-modulus problem. No such transfer theorem is currently proved.

## 7. The fixed CRT-template barrier, with exact scope

The following theorem covers arbitrary high powers, not only squares.

### Theorem 7.1 (density and excess of one CRT template)

Let `d_1,d_2,d_3` be pairwise-coprime positive integers, put
`D=d_1d_2d_3`, and assume `gcd(D,Q)=1`. Impose

\[
                   d_1\mid U_Q,\qquad
                   d_2\mid V_Q,\qquad
                   d_3\mid W_Q.                            \tag{7.1}
\]

Then:

1. Exactly `D` residue pairs `(h,k) mod D` satisfy (7.1). Thus the exact
   periodic density is `1/D` in the `D^2` residue pairs.
2. In the box `1<=h,k<=M`, the number of solutions is at most
   \[
                         {M^2\over D}+2M+D.                \tag{7.2}
   \]
3. Every solution certifies
   \[
   E(U_Q)E(V_Q)E(W_Q)\ge
   \Delta:=\prod_{i=1}^3{d_i\over\operatorname{rad}(d_i)},
   \qquad \Delta\le D.                                    \tag{7.3}
   \]

The same upper count holds after imposing affine admissibility.

#### Proof

Modulo `d_1`, the coefficient `Q` of `h` is a unit, so for every `k` there
is exactly one `h` satisfying `U_Q=0`; this gives `d_1` local pairs. The
same argument gives `d_2` pairs for `V_Q=0 mod d_2` and `d_3` pairs for
`W_Q=0 mod d_3`. Pairwise coprimality of the moduli and the two-coordinate
Chinese remainder theorem multiply these counts, giving exactly
`d_1d_2d_3=D` pairs modulo `D`.

Each residue pair has at most `(floor(M/D)+1)^2` representatives in the
box, so the total is at most

\[
 D(\lfloor M/D\rfloor+1)^2
 \le M^2/D+2M+D.
\]

If `d|n`, then prime by prime
`v_p(E(n))=max(v_p(n)-1,0)>=max(v_p(d)-1,0)`, proving
`E(n)>=d/rad(d)`. Multiplication gives (7.3), and $\Delta\le D$ is immediate.
Admissibility can only remove pairs. ∎

For the minimal `K=8` upper-half fibre, a single template that certifies
the full target (3.4) must have

\[
                \Delta>{\mathcal R c^{14}\over8192},
 \qquad
                D\ge\Delta>{\mathcal R c^{14}\over8192}.  \tag{7.4}
\]

Since $M\le c^6/(4\mathcal R)$, its periodic main term satisfies

\[
 {M^2\over D}
 < {M^2\over \mathcal R c^{14}/8192}
 \le {512\over \mathcal R^3c^2}.                          \tag{7.5}
\]

This is the rigorous density/excess mismatch. The error terms in (7.2) are
larger than the main term in precisely this large-modulus range. Therefore
(7.5) does **not** prove that a template has no point. It proves that an
ordinary periodic-density main term cannot force the needed lower bound.

The exact replay example

\[
                  (d_1,d_2,d_3)=(25,49,121)
\]

has

\[
 D=148225,\qquad \Delta=385,
\]

and exactly `D` solutions modulo `D`, illustrating that each unit of
certified excess costs at least one unit of reciprocal density and here
costs a factor $D/\Delta=385$.

Theorem 7.1 does not close any of the following:

- large-modulus boundary solutions invisible to the main term;
- a union of many correlated templates;
- moduli chosen adaptively from `(h,k)`;
- algebraic parametrizations that create powers without paying a generic
  CRT density;
- an alternative lower bound not formulated through fixed divisibility
  templates.

## 8. Exact finite stress tests and what they refute

All computations in this section use integer arithmetic. They are checks and
finite counterexamples to explicitly stated universal subclaims; they are not
evidence for an asymptotic distribution assumption.

### 8.1 Full minimal-step `K=8` fibre for `(1,8,9)`

Take

\[
 (a,b,c)=(1,8,9),\qquad P=72,\qquad \mathcal R=6,
 \qquad Q=6.
\]

This seed lies in the $\lambda=9/10$ subcritical locus because

\[
                          6^{10}<9^9.
\]

The canonical side is

\[
                   M=\left\lfloor {9^6\over4\cdot6}\right\rfloor
                    =22143.                                \tag{8.1}
\]

The program `full_minimal_search.cpp` exhausts all `M^2=490,312,449`
pairs. It computes radicals by an exact sieve and computes the total
admissible count by exact Möbius inclusion-exclusion in each `h` row. For an
exception at $\mu=3/4$, $H<9^8$ implies the necessary condition

\[
 \operatorname{rad}(U_Q)\operatorname{rad}(V_Q)
 \operatorname{rad}(W_Q)
 \le \left\lfloor {9^6-1\over6}\right\rfloor=88573.        \tag{8.2}
\]

Only 46 raw pairs pass (8.2), and only 32 of them are admissible. On those
32 pairs the program checks the strict exceptional inequality exactly as

\[
 \bigl(6\operatorname{rad}(U_Q)\operatorname{rad}(V_Q)
 \operatorname{rad}(W_Q)\bigr)^4<H^3                       \tag{8.3}
\]

using unsigned 128-bit integers. All operands are far below `2^128` in this
filtered range. The result is

\[
\boxed{447,120,793\ \text{admissible points},\qquad
        |\mathcal E_{Q=6}(9^8)|=0.}                        \tag{8.4}
\]

By Proposition 2.2, every canonical fibre with step `Q` a multiple of `6`
is contained in this minimal fibre, so it also has zero exceptions for this
seed.

This is a strict counterexample to each of the following statements:

- every subcritical seed has a nonempty canonical affine exceptional fibre;
- a matching lower bound holds for every seed with no lower-height threshold;
- the concrete inference that this `447,120,793`-point raw fibre must contain
  an exception merely because of its size.

It is **not** a counterexample to $(L_{\lambda,\eta})$, because that statement
may choose `c_0>9`.

### 8.2 Perfect-square cofactors do not certify exceptionality

For the same seed, the replay verifies the exact rows

\[
 \begin{array}{c|c|c|c|c|c}
 Q&h&k&U_Q&V_Q&W_Q\\ \hline
 6&840&60&5041=71^2&8281=91^2&7921=89^2\\
 72&70&5&5041=71^2&8281=91^2&7921=89^2\\
 72&1160&798&83521=17^4&600625=775^2&543169=737^2.
 \end{array}                                                \tag{8.5}
\]

All three rows are admissible. Their full radicals are respectively
`3,450,174`, `3,450,174`, and `11,651,970`, and in every case

\[
             \operatorname{rad}(aU_QbV_QcW_Q)^4\ge H^3.
\]

Thus even making all three cofactors squares, or more powerful squares, does
not by itself supply enough excess for $\mu=3/4$. This refutes only the
certificate

> all three cofactors are perfect squares, therefore the output is
> exceptional.

It does not refute a carefully sized square parametrization, a Pell family
with additional radical control, or a lower bound obtained from a much
larger square part.

## 9. Other mechanisms examined

The following avenues were tested against the exact scale (3.4).

1. **Second and higher moments.** The local law (5.3) makes fractional
   moments finite and therefore useful in the upper-tail direction. At and
   above the first moment, deep prime powers dominate. A Paley-Zygmund or
   second-moment lower argument would first need a uniform lower estimate for
   mass at the scale $\mathcal R c^{14}$, plus a matching upper moment; the
   local Euler factors do not provide it. No lower inversion is valid.

2. **Large sieve.** In the small-modulus range, the sieve sees the same
   reciprocal-density cost as Theorem 7.1. The required square-root modulus
   is larger than the parameter side by (3.6), where standard equidistribution
   leaves a boundary problem rather than a main term. No large-sieve theorem
   found in the audited material yields a uniform lower count there.

3. **Different-prime independence.** Finite distinct-prime data factor
   exactly by CRT, while same-prime events are disjoint. Extending the finite
   factorization to the growing moduli needed for (3.4) is the missing
   theorem. Treating the forms as globally independent would be heuristic
   and is not used here.

4. **Parametrizing perfect powers.** The exact square rows show that power
   structure can occur but must have the correct magnitude. Requiring all
   forms to be fixed perfect powers leads to Pell or higher-genus conditions,
   and the existing one-dimensional square-completion audit gives only a
   sparse family. A fixed polynomial identity producing uniformly
   subcritical radical would also meet the Mason--Stothers obstruction in
   `research/POLYNOMIAL_PERFECT_POWER_GAP_NOGO.md`. Sparse integer
   specializations are not excluded.

5. **Averaging over the step.** Proposition 2.2 strictly removes this option
   for multiples of $\mathcal R$ in the present shear: they are sublattices of
   the minimal fibre. Seed averaging is a different question, but an average
   lower bound would not imply the required uniform statement without an
   additional dispersion or exceptional-seed theorem.

6. **v29 contact transfer.** Proposition 5.1 prevents a direct transfer of
   source-prime contact multiplicity into cofactor excess. A global transfer
   through coefficient geometry remains possible and has not been ruled out.

No alternative lower bound sufficient to contradict (3.3) was proved. No
unbounded subcritical counterfamily was found. Accordingly, the affine route
must remain open.

## 10. Formalization and retained boundary

The companion module
`Lean/IUTThreeClosures/AffineRadicalStep20260901.lean` was written after the
mathematical proof and formalizes the deterministic core of Theorem 1.1:
the support-modulus shear identity, avoidance of the seed support, pairwise
coprimality, the primitive `ABCPoint`, and all three pair-projection
injections.  It also checks the multiple-step embedding of Proposition 2.2,
the abstract quantifier equivalence and vacuous converse in Theorem 4.1, and
the exact radicals and nonexceptionality of two displayed square rows.

The full asymptotic parameter count and height estimate of Proposition 2.1,
the analytic exceptional upper bound, and the general CRT density/excess
theorem remain paper proofs.  In particular, the module does not assume or
prove the still-missing matching lower bound.

The analytic de Bruijn radical-tail estimate underlying (3.2) should remain
an external documented input unless its source theorem is added to the Lean
dependency graph. It must not be introduced as an axiom merely to close the
file.

## 11. Reproduction and source audit

The accompanying files are:

- `verify.py`: exact finite identity, local-count, nesting, CRT, and square-row
  checks using only the Python standard library;
- `full_minimal_search.cpp`: exhaustive exact search for (8.4);
- `OUTPUT.txt`: captured output of both programs and compiler version;
- `REPRODUCE.md`: replay commands and an explanation of the exact filters;
- `INPUT_SHA256SUMS.txt`: hashes of the reports, Lean modules, and paper
  sections audited for this note;
- `SHA256SUMS`: hashes of the deliverables themselves.

The replay output is evidence only for the finite assertions in Section 8.
Every asymptotic statement in this report is proved above or explicitly
cited to an audited repository theorem.
