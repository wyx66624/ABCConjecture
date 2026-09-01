# A two-prime bound and a rational-return obstruction for the S-unit route

Date: 2026-08-31. Author: ChatGPT.

Status: the three mathematical proofs below passed independent review.
The separate Lean companion now proves the complete two-prime result,
including the support reduction and equality classification; see Section 8.
This work changes neither the accepted paper nor its frozen verification
stage. It does not prove or disprove the general abc conjecture.

The scope is deliberately bounded. The first result is a uniform elementary
bound on all primitive triples with at most two distinct prime factors.
The second and third test a specific proposed transfer of local logarithmic
arrows to rational S-unit solutions. They do not identify a logarithmic hull
with a set of rational solutions.

## 1. Notation and the remaining global quantifier

A primitive positive triple means

\[
 a,b,c\in\mathbb Z_{>0},\qquad a+b=c,\qquad \gcd(a,b)=1.
 \tag{1.1}
\]

Its three entries are pairwise coprime. Write

\[
 R=\operatorname{rad}(abc),\qquad h=\log c,\qquad
 S=\{p:p\mid abc\},\qquad t=|S|.
 \tag{1.2}
\]

Here \(R\) is the integer radical, not the logarithmic radical denoted by
\(R\) elsewhere in the paper. Exactly one entry of every triple (1.1) is
even: both addends cannot be even, and their parities determine that of
the sum. In particular \(2\in S\).

The unresolved global target is

\[
 \forall\varepsilon>0\ \exists C_\varepsilon\in\mathbb R\
 \forall(a,b,c)\text{ satisfying (1.1)},\qquad
 h\le(1+\varepsilon)\log R+C_\varepsilon.
 \tag{1.3}
\]

The constant must be independent of the triple and of its prime support.
The following theorem establishes a stronger estimate on the entire
moving-support subclass \(t\le2\), but not on \(t\ge3\).

## 2. The sharp uniform bound for at most two prime factors

**Theorem 2.1.** Every triple (1.1) with \(t\le2\) satisfies

\[
                 c\le\frac32\operatorname{rad}(abc).
 \tag{2.1}
\]

Equality holds exactly for \((1,8,9)\) and \((8,1,9)\).
For every other triple in this class, \(c\le R\).

**Proof.** If all three entries exceeded \(1\), pairwise coprimality would
give at least one different prime divisor from each entry, and hence
\(t\ge3\). Thus one addend is \(1\). If both are \(1\), the triple is
\((1,1,2)\), for which \(c=R=2\).

Otherwise, exchange the addends if necessary and write the triple as
\((1,N,N+1)\), where \(N\ge2\). Each of the coprime integers \(N,N+1\)
has a prime factor. There are at most two primes altogether, and exactly
one of these integers is even. Consequently there is an odd prime \(q\)
and integers \(u,v\ge1\) such that

\[
                    \{N,N+1\}=\{2^u,q^v\}.
 \tag{2.2}
\]

We classify the case \(v>1\) using only factorization.

First suppose \(2^u=q^v+1\). If \(v\) is even, then
\(q^v\equiv1\pmod8\), so \(2^u\equiv2\pmod8\). This forces \(u=1\),
whereas \(q^v+1>2\), a contradiction. If \(v\ge3\) is odd, then

\[
 q^v+1=(q+1)
       (q^{v-1}-q^{v-2}+\cdots-q+1).
 \tag{2.3}
\]

The second factor is odd, since its \(v\) terms are all odd modulo \(2\).
It exceeds \(1\), since
\((q^v+1)/(q+1)\ge q^2-q+1>1\).
It cannot divide the power \(2^u\). Hence this ordering requires \(v=1\).

Next suppose \(q^v=2^u+1\). If \(v\ge3\) is odd, the factorization

\[
 q^v-1=(q-1)(1+q+\cdots+q^{v-1})
 \tag{2.4}
\]

again gives an odd factor greater than \(1\) of a power of \(2\).
If \(v\) is even, put \(Q=q^{v/2}\), an odd integer at least \(3\).
The identity

\[
                       (Q-1)(Q+1)=2^u
 \tag{2.5}
\]

forces \(Q-1=2^r\) and \(Q+1=2^s\), with \(1\le r<s\).
Subtracting gives
\(2^r(2^{s-r}-1)=2\). Thus \(r=1,\ s=2,\ Q=3\).
It follows that \(q=3,\ v=2,\ u=3\). This is precisely the pair
\(\{8,9\}\).

Therefore either \(v=1\), or the triple is \((1,8,9)\) up to exchanging
the addends. In the first case \(R=2q\) and \(c\) is either \(q\) or
\(q+1\), so \(c\le R\). In the exceptional case \(R=6,\ c=9\).
Together with the initial case \((1,1,2)\), this proves all assertions.
\(\square\)

**Uniformity.** For every fixed \(\varepsilon>0\), every triple in
Theorem 2.1 satisfies

\[
 \log c\le\log R+\log(3/2)
       \le(1+\varepsilon)\log R+\log(3/2).
 \tag{2.6}
\]

Neither the estimate nor its constant depends on which odd prime occurs.
This is an elementary special-case argument; no novelty claim is made
for the underlying classification of consecutive prime powers. It uses
neither Catalan's theorem nor an ineffective finiteness theorem.

## 3. What a local logarithmic arrow preserves on rational return

We use the already proved cyclotomic trace identity from Proposition 4.1
of the repository's
[admissible-arrow report](E:/AImath/abc猜想/research/IUT_ADMISSIBLE_GALOIS_UNIFORM_GATE_2026_08_30.md).
Its source and normalization are recalled here to state exactly which
arrows are being tested.

Let \(E,E'\) be finite extensions of \(\mathbb Q_p\). A
coefficient-compatible Galois arrow consists of a continuous isomorphism
\(\alpha:G_{E'}\longrightarrow G_E\) and an integral equivariant
isomorphism
\[
 \beta:\alpha^*\mathbb Z_p(1)_E
                      \longrightarrow\mathbb Z_p(1)_{E'}.
 \tag{3.1}
\]
It induces a \(\mathbb Q_p\)-linear logarithmic map
\(F:E\longrightarrow E'\), and there is a unit
\(\kappa\in\mathbb Z_p^\times\) such that

\[
 \operatorname{Tr}_{E'/\mathbb Q_p}(F(z))
       =\kappa\,\operatorname{Tr}_{E/\mathbb Q_p}(z)
       \quad(z\in E).
 \tag{3.2}
\]

For clarity, (3.2) comes from integral cohomology, not from an assumption
that the arrow is induced by a field isomorphism. The cyclotomic
character and inertia are preserved. The integral transport of
\(H^2(G_E,\mathbb Z_p(1))\cong\mathbb Z_p\) is multiplication by a unit.
Pairing unit Kummer classes with \(\log_p\chi_E\), the local
reciprocity cup-product formula identifies this pairing, up to the
fixed reciprocity sign, with
\(-\operatorname{Tr}_{E/\mathbb Q_p}(\log_p u)\).
Naturality gives (3.2) on the free unit logarithmic lattice and then
on \(E\) by scalar extension. This is the proof in the cited repository
proposition; the primary-source ingredients are recorded in Section 6.
An additional integral unit scalar changes \(\kappa\) only by a unit.
The orientation of the arrow can replace a unit by its inverse without
changing the conclusions below.

**Lemma 3.1 (equal-degree rational return).** Suppose
\([E:\mathbb Q_p]=[E':\mathbb Q_p]=d\) and a
\(\mathbb Q_p\)-linear map \(F\) satisfies (3.2).
If \(z\in\mathbb Q_p\subset E\) and its image
\(z'=F(z)\) lies in \(\mathbb Q_p\subset E'\), then

\[
                       z'=\kappa z.
 \tag{3.3}
\]

In particular, nonzero rational input and output have the same
\(p\)-adic valuation.

**Proof.** The two traces in (3.2) are \(dz'\) and \(dz\).
Cancel the nonzero element \(d\) in the field \(\mathbb Q_p\).
No condition \(p\nmid d\) is needed. Since \(\kappa\) is a unit,
(3.3) preserves nonvanishing and valuation. \(\square\)

The equality of absolute degrees holds for the local absolute-Galois
isomorphisms under consideration; see Mochizuki's Proposition 1.2.
It has nevertheless been stated in the lemma to expose the exact
linear-algebra hypothesis. If degrees \(d,d'\) were unequal, the same
calculation would instead give \(z'=\kappa(d/d')z\), with a possible
valuation shift. Also, dividing both source and target logarithmic
coordinates by the same \(p\) preserves (3.2)--(3.3); independently
rescaling them by different powers of \(p\) does not.

The lemma assumes rational return of the specified point. It does not
assert that an arbitrary Galois arrow preserves the rational line, or
that a vector in a logarithmic hull is a rational S-unit logarithm.

**Lemma 3.2 (odd-prime logarithmic depth).** Let \(p\) be an odd prime and let
\(0\ne\xi\in p\mathbb Z_p\). Then

\[
             v_p\bigl(\log_p(1-\xi)\bigr)=v_p(\xi).
 \tag{3.4}
\]

**Proof.** Put \(e=v_p(\xi)\ge1\), and use the convergent series
\[
                  \log_p(1-\xi)=-\sum_{n\ge1}\frac{\xi^n}{n}.
\]
The first term has valuation \(e\). For \(n\ge2\),
\(v_p(n)\le n-2\): for \(n=2\) this uses \(p\ne2\), and for \(n\ge3\)
one has \(v_p(n)\le\log_3 n\le n-2\).
Consequently
\[
 ne-v_p(n)-e=(n-1)e-v_p(n)\ge1.
\]
The remaining term valuations tend to infinity. The first term is
therefore the unique term of least valuation, proving both
nonvanishing and (3.4). \(\square\)

There is no assertion of (3.4) at \(p=2\) for all
\(\xi\in2\mathbb Z_2\). The corresponding series argument works when
\(v_2(\xi)\ge2\), but the theorem below deliberately uses only odd primes.

For each odd \(p\mid abc\), define a vanishing coordinate \(\xi_p\)
and a signed rational S-unit \(u_p=1-\xi_p\) by

| Endpoint divisible by \(p\) | \(\xi_p\) | \(u_p\) |
| --- | --- | --- |
| \(a\) | \(a/c\) | \(b/c\) |
| \(b\) | \(b/c\) | \(a/c\) |
| \(c\) | \(c/a\) | \(-b/a\) |

All denominators are \(p\)-adic units. Thus
\(\xi_p\in p\mathbb Z_p\), \(u_p\in1+p\mathbb Z_p\), and
\(v_p(\xi_p)\) is the exponent of \(p\) in its endpoint.
In the third row the identity is \(1-c/a=-b/a\); the negative real
sign does not prevent membership in \(1+p\mathbb Z_p\).

**Proposition 3.3 (preservation of an odd endpoint exponent).**
Let \((a,b,c)\) and \((A,B,C)\) be primitive positive triples.
Let an odd prime \(p\) divide the same labelled endpoint in both
triples, and form \(u_p,u'_p\) by the corresponding row of the table.
Suppose an equal-degree coefficient-compatible logarithmic arrow
satisfies the pointwise equality

\[
                         F_p(\log_p u_p)=\log_p u'_p .
 \tag{3.5}
\]

Then the exponent of \(p\) in that endpoint is the same for the two
triples.

**Proof.** Both logarithms are nonzero elements of \(\mathbb Q_p\),
by Lemma 3.2. Lemma 3.1 gives equality of their valuations.
Applying Lemma 3.2 to the two vanishing coordinates identifies these
valuations with the two endpoint exponents. \(\square\)

Membership of the two logarithms in the same ideal or hull is not the
pointwise equality (3.5). No such replacement is used here.

## 4. The sharp arithmetic fibre and its implication for arrows

For a positive integer \(n\), put
\[
                         n_0=n/2^{v_2(n)}.
 \tag{4.1}
\]
For a fixed seed \((a,b,c)\), let \(\mathcal F(a,b,c)\) be the set of
all primitive positive triples \((A,B,C)\) with
\[
                         (A_0,B_0,C_0)=(a_0,b_0,c_0).
 \tag{4.2}
\]
Equivalently, every odd prime has the same exponent in each of the
three labelled endpoints. This fixes the full prime support as well,
since \(2\) occurs in every primitive positive triple. It does not
fix which endpoint is even.

**Theorem 4.1 (sharp fibre bound).**
\[
                         |\mathcal F(a,b,c)|\le2.
 \tag{4.3}
\]
If the position of the even endpoint is also fixed to that of the
seed, the only triple in the fibre is the seed itself.

**Proof.** Exactly one endpoint of a target is even, with exponent
\(k\ge1\). The only possibilities are the following:

\[
\begin{array}{ll}
 \text{even }A: &(A,B,C)=(2^ka_0,b_0,c_0),
                  \quad 2^ka_0+b_0=c_0;\\
 \text{even }B: &(A,B,C)=(a_0,2^kb_0,c_0),
                  \quad a_0+2^kb_0=c_0;\\
 \text{even }C: &(A,B,C)=(a_0,b_0,2^kc_0),
                  \quad a_0+b_0=2^kc_0.
\end{array}
\tag{4.4}
\]

Each line has at most one solution \(k\), since its term \(2^k\)
multiplies a fixed positive integer and is strictly increasing.
Either of the first two lines implies \(c_0>a_0+b_0\). The third
implies \(c_0<a_0+b_0\). Hence the third line cannot coexist with
either of the first two. There are at most two triples in total.

If the even endpoint is fixed, only one line remains and it already
contains the seed. This proves the singleton assertion. No division
by a difference of odd parts has been used: if \(a_0=b_0\), pairwise
coprimality merely forces \(a_0=b_0=1\), and the same argument still
applies. If all three odd parts are \(1\), (4.4) gives only
\((1,1,2)\). \(\square\)

**Sharpness as an arithmetic statement.** The two distinct triples
\[
                         (4,3,7),\qquad(1,6,7)
 \tag{4.5}
\]
have the same labelled odd parts \((1,3,7)\), so the upper bound
in (4.3) is attained. Both are primitive, both have support
\(\{2,3,7\}\), and the odd prime labels \(3\mid b,\ 7\mid c\)
are unchanged.

**Corollary 4.2 (the specified rational-return class).** Fix a seed
\((a,b,c)\). Consider targets \((A,B,C)\) subject to all of the
following conditions:

1. The target is a primitive positive triple.
2. Its exact prime support is \(S\), with no new or missing primes.
3. Every odd prime in \(S\) belongs to the same labelled endpoint
   as for the seed. The position of the even endpoint is not prescribed.
4. For each odd \(p\in S\), an equal-degree coefficient-compatible
   local logarithmic arrow satisfies (3.5) for the displayed companion
   S-units.

There are at most two targets. If the even endpoint is prescribed
as well, the only target is the seed.

**Proof.** For each odd \(p\in S\), Proposition 3.3 preserves its
exponent in its assigned endpoint. Primitivity makes its exponents
in the other endpoints zero. Every odd prime outside \(S\) has
exponent zero in both triples by condition 2. Thus all odd parts
agree, and Theorem 4.1 applies. The identity arrows admit the seed
itself, giving the final assertion. \(\square\)

The arrows in this corollary may depend on the prime and on the
target. No common global arrow has been assumed. Conversely, exact
support and prime labels are hypotheses, not consequences of trace
transport. Testing only the old primes would not exclude new prime
factors. Removing these hypotheses defines a different problem.

**Sharpness and the coefficient convention.** The arithmetic
sharpness in (4.5) is independent of any Galois realization. It also
gives sharpness for the enlarged arrow class in which an
identity-Galois arrow may be paired with an arbitrary integral
Tate-module coefficient unit, as in (3.1). Here is the full verification.

For \(p=3\), the companion units for the two triples in (4.5) are
\(u_3=4/7\) and \(u'_3=1/7\). Their vanishing coordinates are
\(3/7\) and \(6/7\), both of valuation \(1\). For \(p=7\), the
companions are \(u_7=-3/4\) and \(u'_7=-6\), with vanishing
coordinates \(7/4\) and \(7\), again both of valuation \(1\).
Lemma 3.2 therefore gives
\[
             \kappa_p=\frac{\log_p u'_p}{\log_p u_p}
                          \in\mathbb Z_p^\times
                 \qquad(p=3,7).
 \tag{4.6}
\]
Take \(E=E'=\mathbb Q_p\), the identity on \(G_{\mathbb Q_p}\),
and multiplication by \(\kappa_p\) on \(\mathbb Z_p(1)\).
The latter is an integral equivariant coefficient isomorphism.
It induces multiplication by \(\kappa_p\) on unit Kummer
cohomology and hence on its logarithmic module, giving exactly
(3.5). At odd \(p\), logarithm is an isomorphism on
\(1+p\mathbb Z_p\), so no torsion ambiguity is hidden in these
specific principal-unit points.

This is a statement about pairs \((\alpha,\beta)\) with this
coefficient freedom. It is not a claim that every unit in (4.6)
is the logarithmic scalar of a strict automorphism of
\(G_{\mathbb Q_p}\) with a fixed Tate coefficient framing.
For that potentially smaller class the upper bound remains valid,
but this example alone does not establish sharpness. No arrow at
\(p=2\) has been imposed in Corollary 4.2.

## 5. What has and has not been advanced

Theorem 2.1 is a complete uniform estimate for all supports of
cardinality at most two, allowing the odd prime to vary without
bound. The logarithmic conclusions are different in kind:
Proposition 3.3 and Corollary 4.2 give an obstruction to amplifying
one rational S-unit solution by the particular native, rational-return,
unchanged-support and unchanged-odd-label construction.

The obstruction does not apply to a general Galois image which
leaves the rational line. In particular it does not contradict
previous common minimum-layer constructions over extensions of
\(\mathbb Q_p\). Those constructions concern vectors and integral
hulls; rational return to a new positive solution is an additional
arithmetic requirement. Multiplication by tensor-order coefficients,
addition, convexification and ideal generation do not automatically
preserve a point's trace. Therefore the fibre theorem cannot be
applied to such operations by replacing (3.5) with hull membership.

No IUT theorem, global initial-data construction, complete Ind3
operation, or general S-unit method is disproved by this note.
Allowing new prime support, changing prime labels, or passing through
nonrational points followed by a proved arithmetic descent remains
outside the obstruction. Those wider mechanisms have not been
abandoned.

The remaining universal estimate (1.3) for \(t\ge3\) is not provided,
even when \(t=3\) is fixed but the primes vary. Fixed-support
finiteness, a density-one estimate, or constants depending on the
individual triple would not supply it. No finite sample in this note
is an abc counterexample, and no unconditional ABCConjecture Lean
term is claimed.

## 6. Sources and reproducibility boundary

The proofs of Theorems 2.1 and 4.1 are elementary and fully given above.
Proposition 3.3 uses the previously audited trace theorem, whose
cohomological inputs are the following original or author-hosted
sources. No further literature expansion is needed for this note.

1. Shinichi Mochizuki, *A Version of the Grothendieck Conjecture for
   p-adic Local Fields*, International Journal of Mathematics 8
   (1997), 499--506.
   [Author PDF](https://www.kurims.kyoto-u.ac.jp/~motizuki/A%20Version%20of%20the%20Grothendieck%20Conjecture%20for%20p-adic%20Local%20Fields.pdf).
   PDF p. 3, Proposition 1.1 (cyclotomic character),
   Proposition 1.2 (absolute degree and residue cardinality), and
   Corollary 1.3 (inertia).
   [Archived PDF](E:/AImath/abc猜想/research/sources/uniform_gate_2026_08_30/Mochizuki_Local_Fields_IJM1997.pdf):
   103380 bytes; SHA256
   757670e59a4e9d4c69675fec91b5d6998b411d3554e721b40d445e61a867121e.
   The relevant page was re-extracted and visually inspected in this
   research session. This source does not state the present rational
   fibre bound; it supplies the specified local group invariants.

2. J. S. Milne, *Class Field Theory*, version 4.03, 6 August 2020.
   [Author PDF](https://www.jmilne.org/math/CourseNotes/CFT.pdf).
   Chapter III, Proposition 3.6 and Section 4, PDF pp. 118--122
   (printed pp. 109--113): local reciprocity, the cup-product formula,
   and the Kummer/invariant description. PDF pp. 121--122 contain
   the pairing steps used in the trace proof.
   [Archived PDF](E:/AImath/abc猜想/research/sources/uniform_gate_2026_08_30/Milne_CFT_v4.03_August2020.pdf):
   2072714 bytes; SHA256
   50d79af78250a9f1117ad9d337e0b231704a533fc707966ed1bfa52e13d498f5.
   These pages were re-extracted for the current proof check.

3. Repository proof:
   [IUT_ADMISSIBLE_GALOIS_UNIFORM_GATE_2026_08_30.md](E:/AImath/abc猜想/research/IUT_ADMISSIBLE_GALOIS_UNIFORM_GATE_2026_08_30.md),
   Section 4, Proposition 4.1, including the integral coefficient,
   reciprocity sign, unit-submodule and normalization arguments.
   Its accepted paper transcription is the proposition in the
   subsection “Integral Galois transport preserves trace depth” of
   [uniform_gate_admissible_arrows_2026.tex](E:/AImath/abc猜想/paper/uniform_gate_admissible_arrows_2026.tex),
   label prop:trace-transport. Neither source file was modified.

The initial delivery was a mathematical report only. The three proofs
above passed independent review by the root agent. The next authorized
step is the separate two-prime-support Lean module described below;
the frozen 66-page paper and 705-file verification stage remain unchanged.

## 7. Auxiliary arguments for the two-prime formalization

These elementary arguments are recorded before their Lean implementation.
They express the proof of Theorem 2.1 in forms convenient for the library's
finite prime-factor sets and integer geometric sums.

**Support additivity.** If \(a,b,c>0\) are pairwise coprime, their finite
prime-factor sets are pairwise disjoint and
\[
 \omega(abc)=\omega(a)+\omega(b)+\omega(c).
 \tag{7.1}
\]
Indeed, a prime divides a product exactly when it divides a factor, and a
prime common to two factors would divide their gcd \(1\). Cardinality of
a disjoint union gives (7.1). A positive integer greater than \(1\) has a
prime factor. Thus, in (1.1), \(c>1\); if \(\omega(abc)\le2\), at least
one of \(a,b\) equals \(1\). If \(a=1\) and \(b>1\), then \(c>1\) and
the two nonempty, disjoint supports have cardinalities summing to at most
two. Each has cardinality one, so unique factorization expresses
\(b=p^v,c=q^u\) with prime bases and positive exponents. Consecutiveness
makes one of the numbers even, forcing its prime base to be \(2\);
coprimality makes the other base different from \(2\).

**Odd cofactor elimination.** For integers \(x,y\) and a positive
integer \(v\), define
\[
 G(x,y,v)=\sum_{i=0}^{v-1}x^i y^{v-1-i}.
 \tag{7.2}
\]
The telescoping identity is
\[
             (x-y)G(x,y,v)=x^v-y^v.
 \tag{7.3}
\]
If \(x\) and \(y\) are odd and \(v\) is odd, each summand is \(1\)
modulo \(2\), so \(G(x,y,v)\equiv v\equiv1\pmod2\).

An odd integer divisor \(D\) of \(2^u\) has \(|D|=1\).
Indeed, the positive integer \(|D|\) is a divisor of a prime power,
so \(|D|=2^j\) for some \(j\le u\); oddness forces \(j=0\).
Consequently, if \(q>1\) is odd, \(v\) is odd, and either
\(q^v-1=2^u\) or \(q^v+1=2^u\), the cofactor in (7.3), with
\(y=1\) or \(y=-1\), respectively, is \(1\) or \(-1\).
The factor \(q-y\) and the right side are positive, excluding \(-1\).
The cofactor is \(1\), hence \(q^v=q\). Strict increase of
\(q^n\) in \(n\), for \(q>1\), gives \(v=1\).
This also explains exactly how the alternating factor in (2.3) is
handled without natural-number subtraction problems.

**Even exponent with the power of two larger.** Write \(v=2j>0\)
and \(Q=q^j\), which is odd and at least \(3\). If \(2^u=Q^2+1\),
then \(Q^2+1\equiv2\pmod4\). For \(u\ge2\) this contradicts
divisibility of \(2^u\) by \(4\). The remaining possibilities \(u=0,1\)
also contradict \(Q\ge3\). This modulo-\(4\) argument is sufficient
for the modulo-\(8\) exclusion in Section 2.

**Even exponent with the odd prime power larger.** If
\(Q^2=2^u+1\), then \((Q-1)(Q+1)=2^u\). The two positive
even factors are \(2^r,2^s\), with \(r,s\ge1\), and
\[
                         2^r+2=2^s.
 \tag{7.4}
\]
If \(r\ge2\), the right side exceeds \(4\), so \(s\ge2\);
both powers would be divisible by \(4\), contradicting (7.4).
Thus \(r=1\), and (7.4) gives \(s=2\). It follows that
\(Q=3\). Since \(q\) is prime and \(j>0\), \(q\mid q^j=3\),
forcing \(q=3\); injectivity of powers of \(3\) gives \(j=1\).
Finally \(v=2\) and \(2^u=8\) give \(u=3\).

**Radical evaluation.** For distinct primes \(2,q\) and positive
exponents \(u,v\), unique factorization gives
\[
 \operatorname{rad}(2^u q^v)=2q.
 \tag{7.5}
\]
This is precisely the product over the finite set of prime factors
\(\{2,q\}\), so it agrees with the repository definition abcRadical.
The regular case \(v=1\) has larger endpoint \(q\) or \(q+1\),
bounded by \(2q\). In the exceptional case the radical is
\(\operatorname{rad}(8\cdot9)=6\), and
\(2\cdot9=3\cdot6\). Thus the natural-number formulation
\[
 2c\le3\,\operatorname{abcRadical}(abc)
 \tag{7.6}
\]
and the stronger bound away from the two exceptional ordered triples
follow without real-number division or logarithms.

## 8. Completed two-prime Lean module and audit

The separate module is
[ABCTwoPrimeSupport20260831.lean](E:/AImath/abc猜想/Lean/IUTThreeClosures/ABCTwoPrimeSupport20260831.lean).
It contains exactly 22 public theorems, all under the namespace
IUTThreeClosures.ABCTwoPrimeSupport20260831. No additional definitions,
axioms, admitted proofs, or native_decide calls were introduced.

The principal declarations are:

| Declaration | Exact scope |
| --- | --- |
| one_addend_eq_one | Actual positive primitive triple and support cardinality at most two imply that an addend is one. |
| two_prime_powers_of_small_support | Two nontrivial coprime integers with the specified actual support bound are positive powers of distinct primes. |
| power_two_and_odd_prime_power | Consecutiveness forces one base to be two and the other an odd prime. |
| exponent_eq_one_of_prime_pow_add_one | In the ordering \(q^v+1=2^u\), the odd-prime exponent is one. |
| exponent_eq_one_or_eight_nine | In the ordering \(q^v=2^u+1\), the exponent is one or \((q,v,u)=(3,2,3)\). |
| radical_bound_or_exception | The actual triple satisfies \(c\le R\), or is one of the two ordered exceptional triples. |
| c_le_radical_of_not_exception | The stronger radical bound with both exceptional triples excluded. |
| two_mul_c_le_three_mul_radical | The complete sharp bound \(2c\le3R\) on the actual support subclass. |
| two_mul_c_eq_three_mul_radical_iff | Equality holds exactly for the two exceptional ordered triples. |
| two_mul_c_le_three_mul_radical_of_coprime | The sharp bound with only the usual gcd assumption on \(a,b\); pairwise coprimality is proved from \(a+b=c\). |

The final theorem hypotheses are \(a,b>0\), \(a+b=c\),
PairwiseCoprimeABC (or, for the last declaration, Nat.Coprime \(a\ b\)),
and \((a b c).\mathrm{primeFactors.card}\le2\).
Positivity of \(c\) follows from the first two assumptions. There is no
prime-power classification assumption in these final bounds. The module
uses the repository's actual abcRadical definition.

From the Lean project directory, the command

    lake env lean IUTThreeClosures/ABCTwoPrimeSupport20260831.lean

completed with exit code 0 and no warnings. The final source is 18564 bytes,
with SHA256
485fe66436f10b944e64ebb5398eb5040a7f4d996d9395a7e52d0bde1f6bed98.

The umbrella tactic import was subsequently replaced by the five required
narrow tactic imports. All 22 theorem statements and proof bodies remained
unchanged. The project-level import-linter check

    lake build IUTThreeClosures.ABCTwoPrimeSupport20260831

then completed successfully (8657 jobs), with no warning from this module.
It replayed only the pre-existing whitespace warning in ABCStatement.lean.
The result, source hash, and proof-body comparison are recorded in
[lake-build.json](E:/AImath/abc猜想/tmp/lean_audits/abc_two_prime_support_2026_08_31/lake-build.json)
and
[lake-build.log](E:/AImath/abc猜想/tmp/lean_audits/abc_two_prime_support_2026_08_31/lake-build.log).

An independent audit input copies that exact source text and appends
#check commands for the four principal bound/equality declarations and
#print axioms commands for all 22 public theorems. It also compiled with
exit code 0 and no warnings. All 22 axiom reports were present. Their
combined dependencies are exactly the standard axioms propext,
Classical.choice and Quot.sound; no nonstandard axiom appears.

The audit inputs and outputs are recorded in
[audit.json](E:/AImath/abc猜想/tmp/lean_audits/abc_two_prime_support_2026_08_31/audit.json),
[audit.log](E:/AImath/abc猜想/tmp/lean_audits/abc_two_prime_support_2026_08_31/audit.log),
and
[ABCTwoPrimeSupport_Audit.lean](E:/AImath/abc猜想/tmp/lean_audits/abc_two_prime_support_2026_08_31/ABCTwoPrimeSupport_Audit.lean).
This audit covers the complete public theorem list of this module, not
only the representative declarations displayed in the table.

The present module formalizes Section 2 and the auxiliary arguments in
Section 7. It does not claim a formalization of the local class field
theory and rational-return assertions of Sections 3--4, and it does not
produce an unconditional closed term of the unrestricted ABCConjecture.
