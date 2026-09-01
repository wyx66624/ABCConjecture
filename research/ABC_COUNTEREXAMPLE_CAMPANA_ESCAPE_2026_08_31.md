# Counterexample search in the mixed-full Campana locus: kernel escape, rigidity, and a Pell upgrade gate

Author: ChatGPT. Date: 2026-08-31.

## 0. Result and status

This note develops the counterexample direction in parallel with the positive
proof program.  It does **not** claim a counterexample to the standard abc
conjecture.  No unbounded primitive family with a fixed mixed-full signature

\[
 (p,q,r),\qquad \frac1p+\frac1q+\frac1r<1,
\]

was found.

Three rigorous advances are recorded.

1.  The canonical power-residue decomposition, combined with Darmon--Granville
    finiteness, proves a **kernel-escape theorem**: every hypothetical
    unbounded mixed-full counterexample family in the strict range must use
    infinitely many different triples of residual coefficients.  Thus no
    finite collection of fixed generalized-Fermat equations with a finite
    induced residual-kernel packet can produce such a family.  A fixed Pell
    conic or elliptic source curve is not excluded when its varying integral
    or rational points induce infinitely many different kernel triples.
2.  Mason--Stothers proves a second strict no-go: a nonconstant one-parameter
    polynomial identity whose three pairwise coprime entries are respectively
    polynomial-`p`-, `q`-, and `r`-full cannot exist when the reciprocal sum is
    at most one.
3.  The classical Pell construction of consecutive powerful numbers gives a
    particularly sharp surviving gate.  If an unbounded subsequence of the
    Pell roots in

    \[
                     x^2-8y^2=1
    \]

    were squarefull, then the triples

    \[
                     (1,8y^2,x^2)
    \]

    would be a standard abc counterexample family.  The deterministic
    implication is proved below.  The squarefull-subsequence assertion is not
    proved and is not supplied by primitive-divisor theorems.

The numerical factorization of the first twelve Pell roots is included only
as an error check.  It is neither evidence of finiteness nor a proof of any
asymptotic statement.

The primary sources archived for this audit are listed in
`research/sources/campana_counterexample_2026_08_31/source-metadata.json`.
They are used together with the already archived Darmon--Granville paper and
the 25 August 2026 paper of Browning--Verzobio.

## 1. The strict mixed-full counterexample gate

For an integer `m>=1`, a positive integer `n` is `m`-full if every prime
dividing `n` occurs with valuation at least `m`.  Let `(a,b,c)` be a positive
primitive abc point:

\[
                    a+b=c,\qquad \gcd(a,b)=1.
\]

Primitivity and the sum relation imply pairwise coprimality.  If `a,b,c` are
respectively `p,q,r`-full, then

\[
 \operatorname{rad}(abc)^{pqr}
       \le c^{qr+pr+pq},                                      \tag{1.1}
\]

and hence

\[
 \log\operatorname{rad}(abc)
       \le \left(\frac1p+\frac1q+\frac1r\right)\log c.        \tag{1.2}
\]

These inequalities are proved independently in
`ABC_MIXED_FULL_CAMPANA_GATE_2026_08_31.md` and its Lean companion.  If the
reciprocal sum is strictly below one, an unbounded family satisfying (1.2)
contradicts the standard logarithmic abc inequality for one fixed positive
epsilon.  This is a valid disproof gate: it does not replace the standard
target by a weaker or specialized conjecture.

The problem addressed here is whether familiar parameter constructions can
actually supply the required unbounded family.

## 2. Canonical residue kernels

Fix `m>=1`.  For a positive integer `n`, define

\[
 \begin{aligned}
 \kappa_m(n)
   &=\prod_{\ell\mid n}\ell^{v_\ell(n)\bmod m},\\
 \rho_m(n)
   &=\prod_{\ell\mid n}\ell^{\lfloor v_\ell(n)/m\rfloor}.
 \end{aligned}                                                \tag{2.1}
\]

Both products are finite.  The elementary identity

\[
     e=(e\bmod m)+m\lfloor e/m\rfloor
\]

at every prime gives

\[
                  \boxed{n=\kappa_m(n)\rho_m(n)^m}.            \tag{2.2}
\]

Moreover, every exponent in `kappa_m(n)` lies in
`{0,...,m-1}`, so `kappa_m(n)` is `m`th-power-free.  Unique factorization
shows that (2.2), with an `m`th-power-free coefficient, is unique.

When `n` is `m`-full, a prime in the residue-`s` part of the kernel has
original exponent at least `m+s`; fullness does not bound the primes or the
size of the kernel.  This observation is decisive: the extra variables in a
full-number decomposition are exactly moving generalized-Fermat
coefficients.

## 3. Kernel escape is necessary

Let `p,q,r>=2` be fixed with

\[
                        \frac1p+\frac1q+\frac1r<1.              \tag{3.1}
\]

For a mixed-full abc point put

\[
 \begin{aligned}
 A&=\kappa_p(a), & x&=\rho_p(a),\\
 B&=\kappa_q(b), & y&=\rho_q(b),\\
 C&=\kappa_r(c), & z&=\rho_r(c).
 \end{aligned}
\]

Equation (2.2) converts `a+b=c` into

\[
                         Ax^p+By^q=Cz^r.                         \tag{3.2}
\]

If a prime divided `x,y,z`, it would divide `a,b,c`, contrary to
primitivity.  Thus `(x,y,z)` is a proper solution of (3.2).

### Theorem 3.1 (fixed-kernel finiteness)

For any fixed positive coefficient triple `(A,B,C)`, equation (3.2) has only
finitely many proper integer solutions.

**Proof.**  This is exactly Darmon--Granville, Theorem 2, applied under
(3.1).  Their proof constructs appropriate covers of the thrice-punctured
line and invokes Faltings' theorem.  The theorem allows arbitrary fixed
nonzero coefficients; pairwise coprimality of `A,B,C` is not needed in the
form used here.  \(\square\)

### Theorem 3.2 (kernel-escape theorem)

Let `(a_n,b_n,c_n)` be an infinite family of distinct primitive mixed-full
abc points with the fixed strict signature `(p,q,r)`.  Then the set

\[
 \left\{
   \bigl(\kappa_p(a_n),\kappa_q(b_n),\kappa_r(c_n)\bigr):n\ge0
 \right\}                                                     \tag{3.3}
\]

is infinite.  In particular this holds for every height-unbounded family.

**Proof.**  Suppose (3.3) were finite.  For each coefficient triple in that
finite set, Theorem 3.1 gives only finitely many proper base triples
`(x,y,z)`.  Formula (2.2) maps each such base triple to one endpoint triple.
A finite union of finite sets is finite, contradicting the assumed infinite
family.  A height-unbounded family is automatically infinite.  \(\square\)

This theorem closes a broad class of tempting constructions.  A fixed
generalized-Fermat equation, or any finite packet of such equations, cannot
work.  It does **not** by itself exclude a fixed Pell conic or elliptic source
curve: the coordinates of varying points on that source curve may induce
infinitely many residual-kernel triples after the decomposition (2.2).  It
excludes finitely many Pell or elliptic source curves only under the additional
hypothesis that their relevant points produce a finite residual-kernel packet.
A genuine counterexample construction must make its residual coefficient
packet escape through infinitely many values while preserving primitivity and
a fixed fullness signature.

The conclusion does not say that kernel escape is sufficient.  It is only a
necessary condition, but it is unconditional and exact.

## 4. A polynomial-family no-go

There is an independent obstruction to algebraic identities in one
parameter.

Call a nonzero polynomial `F` over a characteristic-zero field
**polynomial-`m`-full** if every irreducible factor of `F` occurs with
multiplicity at least `m`.  Then

\[
                  \deg\operatorname{rad}(F)\le\frac{\deg F}{m}. \tag{4.1}
\]

### Theorem 4.1 (Mason obstruction to full polynomial tripods)

Let `p,q,r>=2` be integers.  Let `A,B,C` be nonzero pairwise coprime polynomials over a
characteristic-zero field, with

\[
                             A+B=C.                              \tag{4.2}
\]

Suppose they are respectively polynomial-`p`-, `q`-, and `r`-full.  If at
least one is nonconstant, then

\[
                             \frac1p+\frac1q+\frac1r>1.          \tag{4.3}
\]

**Proof.**  Put

\[
                 D=\max\{\deg A,\deg B,\deg C\}>0.
\]

Mason--Stothers, applied to `A+B-C=0`, gives

\[
 D+1\le\deg\operatorname{rad}(ABC).                             \tag{4.4}
\]

Pairwise coprimality and (4.1) give

\[
 \begin{aligned}
 \deg\operatorname{rad}(ABC)
  &=\deg\operatorname{rad}(A)
    +\deg\operatorname{rad}(B)
    +\deg\operatorname{rad}(C)\\
  &\le \frac{\deg A}{p}+\frac{\deg B}{q}+\frac{\deg C}{r}\\
  &\le D\left(\frac1p+\frac1q+\frac1r\right).
 \end{aligned}                                                  \tag{4.5}
\]

If the reciprocal sum were at most one, (4.4)--(4.5) would give
`D+1<=D`, a contradiction.  \(\square\)

Thus no polynomial identity can solve the strict mixed-full problem merely
by building the prescribed multiplicities into its three polynomial
factors.  This includes exact-power identities as a special case.

The theorem does **not** rule out a sparse sequence of integer parameters at
which polynomials with simple algebraic factors happen to take full integer
values.  Such a sequence is a vertical specialization problem, and the
moving valuations are precisely the unresolved arithmetic data.

## 5. Why Pell and elliptic constructions stop at the critical line

Darmon--Granville also explain the geometric trichotomy for a fixed equation

\[
                            Ax^p+By^q=Cz^r.                       \tag{5.1}
\]

In the strict range the proper solutions are finite.  On the equality line,
the corresponding covering curves have genus one; in the supercritical
range they are related to genus-zero constructions.

For ordered integers `2<=p<=q<=r`, the equality

\[
                         \frac1p+\frac1q+\frac1r=1               \tag{5.2}
\]

has exactly three solutions:

\[
                         (3,3,3),\qquad(2,4,4),\qquad(2,3,6).    \tag{5.3}
\]

Indeed, `p>=4` makes the sum at most `3/4`, so `p` is 2 or 3.  If
`p=3`, then `q>=4` makes the sum at most `5/6`, hence `q=3` and then
`r=3`.  If `p=2`, then `q>=5` makes the sum at most `9/10`; the cases
`q=2,3,4` give respectively no equality, `r=6`, and `r=4`.

These are exactly the familiar parabolic signatures behind elliptic
recurrences.  Nitaj proved that there are infinitely many pairwise-coprime
3-full triples on the `(3,3,3)` line.  Cohn strengthened this by showing that
infinitely many can be chosen with no coordinate a perfect cube.  Walsh gives
a Mordell--Weil construction for each odd prime `p` for which the Mordell curve
`Y^2=X^3-432p^2` has positive rank.  The resulting solutions of
`x^3+y^3=p^4z^3` again yield 3-full triples.  The abundance is genuine, but the
slope is exactly one and therefore gives no fixed abc epsilon margin.

To cross from such an elliptic family into the strict range, at least one
coordinate must acquire extra fullness on an unbounded subfamily.  For an
endpoint of the form `A X^3`, primes newly introduced by `X` occur to
multiplicity three.  Making that endpoint 4-full forces the new part of `X`
to be squarefull.  This is the same hard denominator or multiplier condition
isolated in the repository's Walsh squarefull-denominator route.

The conclusion is not that Pell or elliptic curves are irrelevant.  They are
natural launchpads on the critical line.  The missing theorem must control a
moving squarefull or higher-full part, and Theorem 3.2 says that its residual
kernels cannot stay in a finite coefficient list.

## 6. A concrete Pell upgrade gate

Consider positive solutions of

\[
                              x^2-8y^2=1.                         \tag{6.1}
\]

They are generated by

\[
                   x_n+y_n\sqrt8=(3+\sqrt8)^n,
\]

or, integrally,

\[
 \begin{aligned}
 x_0&=1,& y_0&=0,\\
 x_{n+1}&=3x_n+8y_n,& y_{n+1}&=x_n+3y_n.
 \end{aligned}                                                   \tag{6.2}
\]

Direct expansion proves

\[
 (3x+8y)^2-8(x+3y)^2=x^2-8y^2,                                  \tag{6.3}
\]

so (6.1) holds for all `n`.  For `n>=1`, both coordinates are positive and
strictly increase, hence `x_n^2` is unbounded.

Every solution gives

\[
                         1+8y^2=x^2.                              \tag{6.4}
\]

The two nontrivial endpoints are consecutive and therefore coprime.  The
integer `x^2` is 2-full.  The integer `8y^2` is also 2-full for every
nonzero `y`: the prime 2 occurs at least three times, and every other prime
coming from `y` occurs at least twice.  This recovers the classical infinite
family of consecutive powerful numbers on the critical two-coordinate line.

### Proposition 6.1 (squarefull root upgrades the Pell endpoint)

If `y` is 2-full, then `8y^2` is 3-full.

**Proof.**  Let `ell` be a prime dividing `8y^2`.  If `ell=2`, then
`ell^3=8` divides `8y^2`.  If `ell` is odd, it divides `y`.  Since `y` is
2-full, `ell^2` divides `y`, so `ell^4` divides `y^2`, and in particular
`ell^3` divides `8y^2`.  \(\square\)

The coordinate 1 is `m`-full for every positive `m`.  Choosing `m=7`, the
three endpoints in (6.4) therefore have signature

\[
                              (7,3,2),
\]

whenever `y` is squarefull, and

\[
                         \frac17+\frac13+\frac12=\frac{41}{42}<1. \tag{6.5}
\]

### Theorem 6.2 (Pell-squarefull disproof gate)

Suppose there is a sequence of positive solutions `(x_j,y_j)` of (6.1) such
that every `y_j` is squarefull and `x_j` is unbounded.  Then the standard abc
conjecture is false.

**Proof.**  Equations (6.4), positivity, and consecutiveness give primitive
positive abc points

\[
                         P_j=(1,8y_j^2,x_j^2).
\]

By Proposition 6.1 and the preceding observations, these points have the
fixed mixed-full signature `(7,3,2)`.  Their heights `2 log x_j` are
unbounded, and (6.5) is strict.  The mixed-full counterexample gate (1.2)
therefore gives `not ABCConjecture`.  \(\square\)

There is also a sharper structural slope which does not spend the artificial
`1/7` contribution of the unit coordinate.  Since a squarefull `y` satisfies

\[
                         \operatorname{rad}(y)^2\le y,
\]

radical submultiplicativity and invariance under positive powers give

\[
 \begin{aligned}
 \operatorname{rad}(8y^2x^2)
   &\le 2\operatorname{rad}(y)\operatorname{rad}(x),\\
 \operatorname{rad}(8y^2x^2)^2
   &\le4yx^2.
 \end{aligned}                                                   \tag{6.6}
\]

From (6.1), `y<x`, so

\[
 \operatorname{rad}(8y^2x^2)^2\le4x^3.                          \tag{6.7}
\]

Taking logarithms and writing `H=log(x^2)` and
`R=log rad(8y^2x^2)` gives

\[
                              R\le\frac34H+\log2.                 \tag{6.8}
\]

Thus the actual Pell upgrade has asymptotic slope `3/4`, stronger than the
generic `(7,3,2)` slope `41/42`.  Either estimate is sufficient for a strict
disproof if the hypothesized unbounded squarefull subfamily exists.

## 7. The precise primitive-divisor boundary

The Pell roots `y_n` form the Lucas sequence

\[
                    y_0=0,\quad y_1=1,\quad
                    y_{n+2}=6y_{n+1}-y_n.                         \tag{7.1}
\]

The theorem of Bilu--Hanrot--Voutier says that every Lucas or Lehmer number
of index `n>30` has a primitive divisor.  The pair
`alpha=3+sqrt(8)`, `beta=3-sqrt(8)` is a nondegenerate Lucas pair, so the
theorem applies to (7.1).  It provides a prime dividing `y_n` and excluded
by the earlier terms and discriminant factors.  It does not contradict
squarefullness: the definition of primitive divisor permits its first
appearance to have valuation two or more, and the theorem does not assert
valuation one.

More precisely, let `ell` be a primitive prime divisor of `y_n` away from
the discriminant 32.  If `y_n` is squarefull, then automatically

\[
                              \ell^2\mid y_n.                     \tag{7.2}
\]

Writing `alpha=3+sqrt(8)` and `beta=alpha^{-1}`, one has

\[
                    y_n=\frac{\alpha^n-\beta^n}{\alpha-\beta}.
\]

Condition (7.2) is therefore a Lucas--Wieferich lifting condition: in the
appropriate quadratic residue algebra modulo `ell^2`, it forces

\[
                              \alpha^{2n}\equiv1\pmod{\ell^2}.    \tag{7.3}
\]

A theorem guaranteeing merely one primitive divisor says nothing about
whether (7.2)--(7.3) occurs.  To rule out the Pell counterexample gate, one
would need an exponent-one primitive divisor for every sufficiently large
candidate index, or another theorem forcing some valuation of `y_n` to equal
one.  To prove the counterexample gate, one would instead need infinitely
many indices at which **every** support prime has valuation at least two.
Neither conclusion follows from the currently audited primitive-divisor
literature.

This is a theorem-scope statement, not a claim that squarefull Pell roots are
likely.  It prevents the invalid inference

```text
eventual primitive support  =>  eventual non-squarefullness.
```

## 8. Finite computation used only as an error check

The first twelve positive Pell roots from (6.2) are:

| `n` | `x_n` | `y_n` factorization |
|---:|---:|:---|
| 1 | 3 | `1` |
| 2 | 17 | `2 * 3` |
| 3 | 99 | `5 * 7` |
| 4 | 577 | `2^2 * 3 * 17` |
| 5 | 3363 | `29 * 41` |
| 6 | 19601 | `2 * 3^2 * 5 * 7 * 11` |
| 7 | 114243 | `13^2 * 239` |
| 8 | 665857 | `2^3 * 3 * 17 * 577` |
| 9 | 3880899 | `5 * 7 * 197 * 199` |
| 10 | 22619537 | `2 * 3 * 19 * 29 * 41 * 59` |
| 11 | 131836323 | `23 * 353 * 5741` |
| 12 | 768398401 | `2^2 * 3^2 * 5 * 7 * 11 * 17 * 1153` |

Only `y_1=1` is squarefull in this table.  The factorization catches sign,
indexing, and recurrence mistakes and illustrates the exponent-one
primitive-prime obstruction.  Twelve terms cannot establish that there are
finitely many squarefull terms, positive density zero, or any other infinite
claim.

## 9. Route ledger

The counterexample search now has the following exact ledger.

* **Standard abc counterexample:** not obtained.
* **Fixed strict signature:** a counterexample obtained through this
  mixed-full gate must have one; the deterministic implication is proved.
* **Fixed generalized-Fermat coefficients:** rigorously impossible by
  Darmon--Granville finiteness.
* **Finite coefficient packet:** rigorously impossible by the kernel-escape
  theorem.
* **Fixed Pell or elliptic source curve:** not ruled out merely because the
  source curve is fixed; it is ruled out by kernel escape only if its induced
  residual-kernel packet is finite.
* **One-parameter polynomial-full identity:** rigorously impossible at or
  below the critical line by Mason--Stothers.
* **Critical Pell or elliptic family:** genuinely infinite and useful, but
  gives no epsilon margin by itself.
* **Pell squarefull-root upgrade:** a strict and structurally simple surviving
  gate; the existence of an unbounded squarefull subfamily is open in this
  audit.
* **Finite search:** used only for falsification of formulas, never as proof.

The most focused next disproof question is therefore:

> Does the Lucas sequence `y_{n+2}=6y_{n+1}-y_n` contain an unbounded
> squarefull subsequence, or can one prove an eventual exponent-one divisor
> theorem for it?

Either answer is meaningful.  A positive answer to the first alternative
would disprove abc through Theorem 6.2.  A proof of the second would close
this natural Pell upgrade route without affecting other moving-kernel
constructions.

## 10. Formalization boundary

The Lean companion formalizes only the elementary, deterministic core: the
Pell recurrence and norm identity, positivity and unboundedness of its first
coordinate, the transfer from a squarefull root `y` to a 3-full endpoint
`8y^2`, construction of the primitive `(7,3,2)` point, and the conditional
implication from an unbounded family of such data to the unchanged standard
negation `not ABCConjecture`.  The Darmon--Granville kernel-escape theorem,
the Mason--Stothers polynomial obstruction, the sharper `3/4` logarithmic
slope, and the Lucas--Wieferich discussion remain paper-only.  In particular,
no external finiteness theorem or unproved squarefull-subsequence assertion is
introduced into Lean as an axiom.  The final Lean gate assumes unbounded real
height directly; the elementary analytic bridge from an unbounded sequence of
positive Pell coordinates `x_j` to unbounded `log(x_j^2)` is not formalized in
that companion.

## References and archived originals

* H. Darmon and A. Granville, *On the equations `z^m=F(x,y)` and
  `Ax^p+By^q=Cz^r`*, Bull. London Math. Soc. 27 (1995), 513--543.  Theorem 2
  is the fixed-coefficient finiteness input.  Archived at
  `research/sources/three_prime_support_2026_08_31/`.
* W. W. Stothers, *Polynomial identities and Hauptmoduln*, Quart. J. Math.
  Oxford Ser. (2) 32 (1981), 349--370,
  doi:10.1093/qmath/32.3.349.  This is the original polynomial-`abc` source
  used in Theorem 4.1.  Publisher metadata is recorded in
  `research/sources/campana_counterexample_2026_08_31/source-metadata.json`;
  no local full text is claimed.
* R. C. Mason, *Diophantine Equations over Function Fields*, London Math.
  Soc. Lecture Note Ser. 96, Cambridge University Press, 1984,
  doi:10.1017/CBO9780511752490.  This is a standard monograph source for the
  same polynomial-`abc` theorem; publisher metadata is recorded locally.
* Y. Bilu, G. Hanrot and P. M. Voutier, with an appendix by M. Mignotte,
  *Existence of primitive divisors of Lucas and Lehmer numbers*, J. reine
  angew. Math. 539 (2001), 75--122, doi:10.1515/crll.2001.080.  Its main
  theorem gives a primitive divisor for every Lucas or Lehmer term of index
  greater than 30.  The official HAL/Inria prepublication report RR-3792 is
  archived at `research/sources/campana_counterexample_2026_08_31/`.
* D. T. Walker, *Consecutive Integer Pairs of Powerful Numbers and Related
  Diophantine Equations*, Fibonacci Quarterly 14 (1976), 111--116.  Archived
  at `research/sources/campana_counterexample_2026_08_31/`.
* A. Nitaj, *On a Conjecture of Erdos on 3-Powerful Numbers*, Bull. London
  Math. Soc. 27 (1995), 317--318.
* J. H. E. Cohn, *A conjecture of Erdos on 3-powerful numbers*, Math. Comp.
  67 (1998), 439--440.  Archived at
  `research/sources/campana_counterexample_2026_08_31/`.
* P. G. Walsh, *A question of Erdos on 3-powerful numbers and an elliptic
  curve analogue of the Ankeny--Artin--Chowla conjecture*, arXiv:2404.03970;
  published in Rad HAZU Mat. Znan. 29 (2025), 83--87.  Archived at
  `research/sources/campana_counterexample_2026_08_31/`.
* T. Browning and M. Verzobio, *Sums of three powerful numbers*,
  arXiv:2608.24512v1 (25 August 2026).  Archived at
  `research/sources/powerful_sums_2026_08_31/`.
