# The global Frey height gate and an obstruction in the entire rational isogeny class

Author: ChatGPT. Date: 2026-08-31.

Status: mathematical proof before formalization. This report changes no accepted
Lean file, TeX file, or PDF. After independent review of the mathematical
proof, a new bounded arithmetic Lean companion was authorized and checked;
its exact boundary is recorded in Section 10. The new result below is an
unconditional consequence of stated classical isogeny theorems and explicit
calculations; it is not a proof or a disproof of abc. No claim of priority
over the research literature is made.

## 1. The exact target and the route selected

The canonical definition in Lean/IUTThreeClosures/ABCStatement.lean is

\[
 \forall\varepsilon>0\ \exists C_\varepsilon\in\mathbb R\
 \forall (a,b,c),\qquad
 \log c\le(1+\varepsilon)\log\operatorname{rad}(abc)+C_\varepsilon ,
 \tag{1.1}
\]

where \(a,b,c\) are positive, pairwise coprime integers and \(a+b=c\).
The maximum in the Lean definition is \(c\) on this domain. The constant
must not depend on the triple. A fixed-exponent estimate is not (1.1).

NonCircularDownstream.lean makes the same uniform quantifier explicit
in its qEstimate field. Having no field whose conclusion is literally
ABCConjecture does not establish the field's uniform estimate. This report
does not use that IUT field or the newly proved local IUT results.

The independent route chosen here is the actual Frey family

\[
 E_{a,b,c}:\quad y^2=x(x-a)(x+b),
 \qquad c_4=16(a^2+ab+b^2),\quad
 \Delta_{\rm disp}=16a^2b^2c^2 .                  \tag{1.2}
\]

The existing reports already separate the modified Szpiro height
estimate from a bound on the minimal discriminant alone. They also
calculate the full rational **2-primary** isogeny graph on an endpoint
family. Repeating that calculation is not a new advance.

The new step in Sections 3--7 is to rule out **all odd-prime isogeny
exits**, including exits from any 2-isogenous vertex. This determines the
**entire** rational isogeny class on an explicit infinite subfamily. It
gives matching fifth-power bounds for the largest minimal discriminant and
matching first-power bounds for the smallest complex absolute \(j\)-invariant
in that entire class.

## 2. External mathematical inputs and source verification

The proof uses the following unconditional inputs, not conjectures.

1. A finite Galois-stable subgroup of an elliptic curve in characteristic
   zero has a quotient isogeny over the ground field; isogenies have duals;
   \(E[\ell]\) over an algebraic closure is a two-dimensional
   \(\mathbb F_\ell\)-space. A map whose kernel contains \(E[\ell]\)
   factors through \([\ell]\). These are the standard quotient and dual
   isogeny theorems, for example Silverman, *The Arithmetic of Elliptic
   Curves*, second edition, Chapter III, Sections 4 and 6.
2. For an elliptic curve over \(\mathbb Q\) with good reduction at \(q\ne
   \ell\), Frobenius on \(E[\ell]\) has characteristic polynomial
   \(T^2-a_qT+q\) modulo \(\ell\), where
   \(a_q=q+1-\#E(\mathbb F_q)\).
3. The degrees of cyclic isogenies over \(\mathbb Q\) belong to
   \[
    \{1,\ldots,19,21,25,27,37,43,67,163\}.          \tag{2.1}
   \]
   We use just its consequence that a cyclic \(4\ell\)-isogeny with
   \(\ell\) an odd prime forces \(\ell=3\).
4. An integral Weierstrass model with \(c_4\) a \(q\)-adic unit is minimal
   at \(q\). A minimal discriminant has no larger valuation than any
   integral model of the same curve.

The original prime-degree theorem was read in
[Mazur, *Rational isogenies of prime degree*, 1978](https://www.math.columbia.edu/~goldfeld/Mazur-Goldfeld1978.pdf),
Theorem 1, printed pages 129--130. Printed page 131 carefully distinguishes
the then-unsettled composite levels; it must not be cited as already stating
the subsequently completed classification for every integer.

The complete statement (2.1) was checked in the published version of
[Balakrishnan and Mazur, *Ogg's torsion conjecture: Fifty years later*, 2025](https://celebratio.org/media/essaypdf/636_Orig.pdf),
Theorem 2.2, printed page 239 (PDF page 5). This is a statement by an
original author of the classification, not an inference from a database of
examples. Its references [55]--[58], printed page 266, identify the original
Kenku papers completing the remaining cases:

- \(X_0(39)\), 1979, DOI
  [10.1017/S0305004100055444](https://doi.org/10.1017/S0305004100055444);
- \(X_0(169)\), 1980, DOI
  [10.1112/jlms/s2-22.2.239](https://doi.org/10.1112/jlms/s2-22.2.239);
- \(X_0(65)\) and \(X_0(91)\), 1980, DOI
  [10.1017/S0305004100056462](https://doi.org/10.1017/S0305004100056462);
- \(X_0(125),X_1(25),X_1(49)\), 1981, DOI
  [10.1112/jlms/s2-23.3.415](https://doi.org/10.1112/jlms/s2-23.3.415).

The complete proofs of those four articles were not reread in this round.
Attempts to obtain Kenku's separate four-page 1982 isogeny-class-count paper
from its public publisher/CORE links failed; no local copy of it or
full-text inspection is claimed. That separate eight-vertex count is not
needed here. In particular, the argument below does not infer the desired
four-vertex answer merely from an eight-vertex upper bound.

Archived PDFs actually downloaded and read:

| File under research/sources/arithmetic_geometry_gate_2026_08_31/ | Pages | Bytes | SHA256 |
|---|---:|---:|---|
| Mazur_1978_Rational_isogenies_prime_degree.pdf | 34 | 1789871 | f3da9ef0d3d184225c4799951897be7b90d8b25050c5d508b69aeff70fd2ead3 |
| Balakrishnan_Mazur_2025_Ogg.pdf | 34 | 732299 | 2c6acd3452ced7f031c446e6f54a94f09681d0e9d8ee28d199e308ad46847d6d |

Here “read” means the relevant theorem and surrounding discussion, not a
claim to have reverified every proof on all 34 pages.

## 3. A universal restriction on odd isogenies with full rational 2-torsion

**Proposition 3.1.** Let \(E/\mathbb Q\) have full rational 2-torsion.
If \(E\) admits a rational isogeny of odd prime degree \(\ell\), then
\(\ell=3\).

**Proof.** Let \(\psi:E\to E'\) be the \(\ell\)-isogeny. Choose distinct
nonzero \(T_0,T_1\in E[2](\mathbb Q)\). Form

\[
 \phi_0:E\longrightarrow E_0=E/\langle T_0\rangle ,
 \qquad
 \phi_1:E'\longrightarrow E_1=E'/\langle\psi(T_1)\rangle .
\]

The point \(\psi(T_1)\) has order two because \(\ell\) is odd. All maps
and quotients are defined over \(\mathbb Q\). Consider

\[
 \Phi=\phi_1\circ\psi\circ\widehat{\phi_0}:
 E_0\longrightarrow E_1,\qquad \deg\Phi=4\ell .    \tag{3.1}
\]

We must prove that this composite is cyclic; its degree alone would not
justify using (2.1).

On \(E_0[2]\), the dual \(\widehat{\phi_0}\) has a kernel of order two.
Its image has order two and is contained in \(\ker\phi_0\), since
\(\phi_0\widehat{\phi_0}=[2]\). Hence that image is exactly
\(\langle T_0\rangle\). The restriction of \(\psi\) to \(E[2]\) is an
isomorphism, so the distinct lines
\(\langle T_0\rangle,\langle T_1\rangle\) have distinct images in
\(E'[2]\). It follows that

\[
 \ker\Phi\cap E_0[2]=\ker\widehat{\phi_0},
 \qquad \#(\ker\Phi)[2]=2.                        \tag{3.2}
\]

The 2-primary subgroup of \(\ker\Phi\) has order four. A noncyclic
group of order four would have four elements killed by two, contradicting
(3.2). Thus the 2-primary subgroup is cyclic. Its \(\ell\)-primary
subgroup has prime order, so it too is cyclic. Their orders are coprime;
therefore \(\ker\Phi\) is cyclic of order \(4\ell\).
By (2.1), \(4\ell\) can occur only when \(\ell=3\). QED.

This proposition concerns existence of an isogeny with a stable kernel,
not existence of a rational point of order \(\ell\). No replacement of an
isogeny hypothesis by a torsion-point hypothesis was made.

## 4. Prime-degree graph connectivity: removing the noncyclic-kernel issue

**Lemma 4.1.** If \(E,F/\mathbb Q\) are isogenous over \(\mathbb Q\), there is a cyclic
\(\mathbb Q\)-isogeny from \(E\) to \(F\). Consequently they are joined by
a finite path of rational prime-degree isogenies.

**Proof.** Duality makes the set of positive degrees of isogenies
\(E\to F\) nonempty. Choose one, \(\theta\), with least degree. If its
finite geometric kernel \(H\) were not cyclic, some prime \(\ell\) would
have \(\dim_{\mathbb F_\ell}H[\ell]=2\). Because \(H[\ell]\subseteq
E[\ell]\) and \(\dim E[\ell]=2\), this implies \(E[\ell]\subseteq H\).
The quotient theorem factors \(\theta\) as

\[
 E\xrightarrow{[\ell]}E\xrightarrow{\theta_1}F
\]

over \(\mathbb Q\), with
\(\deg\theta_1=\deg\theta/\ell^2<\deg\theta\), a contradiction.
Equivalently, descent of the factor follows from its uniqueness and the
fact that both \(\theta\) and \([\ell]\) are defined over \(\mathbb Q\).

Thus \(H\) is cyclic. Its unique subgroup of any divisor order is
Galois-stable. A subgroup chain with successive prime-order quotients,
followed by the final isomorphism to \(F\), gives the required path. QED.

It would be false to assert that **every given** rational isogeny itself
has a factorization into rational prime-degree maps: \([\ell]\) on a
curve with irreducible \(E[\ell]\) is the basic obstruction. The lemma
first replaces the map by one of minimal degree with the same endpoints.

**Lemma 4.2.** If \(E\) has no rational isogeny of an odd prime degree
\(\ell\), neither does any curve 2-power-isogenous to \(E\) over
\(\mathbb Q\).

**Proof.** Let \(F\) be such a curve and take a rational 2-power-degree
isogeny \(\alpha:F\to E\), using a dual if necessary. If \(C\subseteq
F[\ell]\) were a Galois-stable subgroup of order \(\ell\), then
\(\alpha|_{F[\ell]}\) would be an isomorphism, since \(\deg\alpha\) is
coprime to \(\ell\). Hence \(\alpha(C)\subseteq E[\ell]\) would be a
Galois-stable subgroup of order \(\ell\), giving the forbidden isogeny.
QED.

These lemmas justify passage from a complete 2-primary graph to an
entire rational isogeny class once all odd exits are excluded.

## 5. The actual infinite primitive abc family

For each integer \(n\ge1\), set

\[
 c_n=1792n+2,\qquad a_n=1,\qquad b_n=c_n-1.
 \tag{5.1}
\]

These are positive primitive abc triples: consecutive integers are
coprime and one endpoint is 1. The sequence \(c_n\) is strictly increasing,
and

\[
 c_n\equiv2\pmod8,\qquad c_n\equiv2\pmod7,\qquad c_n\ge1794.
 \tag{5.2}
\]

The corresponding **actual Frey curve**, not an auxiliary Mordell curve,
is

\[
 E_c:\quad y^2=x(x-1)(x+c-1).
\]

**Lemma 5.1.** \(E_c\) has no rational 3-isogeny.

**Proof.** The displayed discriminant is \(16(c-1)^2c^2\), which is a
7-adic unit by (5.2). Modulo seven the curve is \(y^2=x^3-x\).
The complete point count is

| \(x\) | 0 | 1 | 2 | 3 | 4 | 5 | 6 |
|---|---:|---:|---:|---:|---:|---:|---:|
| \(x^3-x\pmod7\) | 0 | 0 | 6 | 3 | 4 | 1 | 0 |
| Number of \(y\) | 1 | 1 | 0 | 0 | 2 | 2 | 1 |

There are seven affine points and the point at infinity; hence
\(\#E_c(\mathbb F_7)=8\) and \(a_7=0\). Frobenius on \(E_c[3]\)
has characteristic polynomial \(T^2+7\), which is \(T^2+1\) over
\(\mathbb F_3\). It has no root in \(\mathbb F_3\).

A rational 3-isogeny would give a Galois-stable line in \(E_c[3]\),
and Frobenius on that line would have an eigenvalue in \(\mathbb F_3\).
This is impossible. QED.

Combining Lemma 5.1 with Proposition 3.1 excludes every odd-prime
rational isogeny from \(E_c\).

## 6. Determination of the entire rational isogeny class

For clarity the elementary quotient computation from the earlier report
is included here, but it is not counted as new. For

\[
 y^2=u^3+A u^2+B u,
\]

the quotient at \((0,0)\) is

\[
 Y^2=X^3-2AX^2+(A^2-4B)X .
 \tag{6.1}
\]

It has extra rational 2-torsion exactly when \(B\) is a rational square:
the discriminant of its remaining quadratic factor is \(16B\).
An integer that is a rational square is an integer square.

For the kernels \(x=0,1,-(c-1)\) on \(E_c\), the three pre-quotient
values of \(B\) are respectively

\[
 -(c-1),\qquad c,\qquad c(c-1).
\]

The first is negative. Each of the other two is \(2\) modulo 8.
Thus each quotient has exactly one nonzero rational point of order two.
Its unique rational degree-two quotient is the dual edge back to
\(E_c\), up to \(\mathbb Q\)-isomorphism.

Write the three quotient curves as \(E_0,E_a,E_b\), where the last
subscript refers to the kernel at \(x=-(c-1)\). Their models and invariants
are:

| Curve | Integral equation | \(c_4/16\) | Displayed \(\Delta\) |
|---|---|---|---|
| \(E_c\) | \(y^2=x(x-1)(x+c-1)\) | \(c^2-c+1\) | \(16(c-1)^2c^2\) |
| \(E_0\) | \(Y^2=X^3+(4-2c)X^2+c^2X\) | \(c^2-16c+16\) | \(-256(c-1)c^4\) |
| \(E_a\) | \(Y^2=X^3-2(c+1)X^2+(c-1)^2X\) | \(c^2+14c+1\) | \(256c(c-1)^4\) |
| \(E_b\) | \(Y^2=X^3+(4c-2)X^2+X\) | \(16c^2-16c+1\) | \(256c(c-1)\) |

**Theorem 6.1.** Every elliptic curve over \(\mathbb Q\) isogenous to
\(E_c\) over \(\mathbb Q\), by an isogeny of any degree, is \(\mathbb Q\)-isomorphic to
one of the four curves in this table.

**Proof.** The preceding calculation exhausts the connected rational
2-isogeny graph. Every vertex in it has no odd-prime isogeny, by
Lemma 4.2 and the last conclusion of Section 5.

If another isogenous curve existed, Lemma 4.1 would give a prime-degree
path from \(E_c\) to it. An initial string of 2-edges stays in the four
listed vertices. The first odd edge would contradict the preceding
paragraph. Thus every edge is a 2-edge and the endpoint is already in
the list. QED.

Accidental isomorphisms between displayed vertices would only shorten
the list and do not affect any assertion. Neither non-CM nor any
unproved Galois-surjectivity conjecture is an assumption of this theorem.

## 7. Two matching quantitative bounds across the whole class

Let \(\mathcal I_c\) be the set of \(\mathbb Q\)-isomorphism classes in
Theorem 6.1, and define the intrinsic quantities

\[
 D_{\max}(c)=\max_{F\in\mathcal I_c}|\Delta_{\min}(F)|,\qquad
 J_{\min,\infty}(c)=\min_{F\in\mathcal I_c}|j(F)|.
\]

The finite set is nonempty. These definitions do not depend on displayed
nonminimal models.

**Theorem 7.1.** For every \(c=c_n\) in (5.1),

\[
 \frac{c^5}{32}\le D_{\max}(c)\le256c^5,
 \qquad
 2c\le J_{\min,\infty}(c)\le32c.
 \tag{7.1}
\]

**Proof of the discriminant bounds.** Each absolute displayed discriminant
in Section 6 is at most \(256c^5\). Passing to a minimal model cannot
increase any prime valuation. Theorem 6.1 therefore proves the upper
bound for the entire class, not just for immediate 2-quotients.

For the lower bound use \(E_0\). At any odd prime \(q\mid c\),
\[
 c_4(E_0)=16(c^2-16c+16)\equiv256\not\equiv0\pmod q.
\]
At any odd prime \(q\mid c-1\), instead \(c_4(E_0)\equiv16\pmod q\).
Thus the displayed model is minimal at every odd prime dividing its
discriminant. Since \(v_2(c)=1\), the complete odd part of its
discriminant is retained:

\[
 |\Delta_{\min}(E_0)|\ge
 (c-1)(c/2)^4=\frac{(c-1)c^4}{16}\ge\frac{c^5}{32}.
 \tag{7.2}
\]

This argument needs no unresolved classification of reduction at 2.

**Proof of the \(j\)-bounds.** Since \(c\ge1794>32\), each of the four
polynomials in the table's \(c_4/16\) column is at least \(c^2/2\).
For the only potentially delicate polynomial,
\[
 c^2-16c+16\ge c^2/2\qquad(c\ge32).
\]
For \(16c^2-16c+1\) the assertion already follows from \(c\ge2\);
the other two are immediate. Consequently \(|c_4|\ge8c^2\) on
every displayed curve, and
\[
 |j|=\frac{|c_4|^3}{|\Delta_{\rm disp}|}
 \ge\frac{512c^6}{256c^5}=2c .
\]
The ratio defining \(j\) is invariant under changes to a minimal model.
For the upper bound select \(E_0\):
\[
 |j(E_0)|=
 \frac{16(c^2-16c+16)^3}{(c-1)c^4}
 \le\frac{16c^2}{c-1}\le32c .
 \tag{7.3}
\]
This proves (7.1). QED.

In particular,

\[
 \lim_{n\to\infty}
 \frac{\log D_{\max}(c_n)}{\log c_n}=5,\qquad
 \lim_{n\to\infty}
 \frac{\min_{F\in\mathcal I_{c_n}}\log^+|j(F)|}{\log c_n}=1.
 \tag{7.4}
\]

The second assertion uses the **complex absolute \(j\)-invariant**, not
the global Weil height \(h(j)\) and not the height of a point on a curve.
Those three notions must not be interchanged.

**Corollary 7.2 (the precise strengthened proposal that is false).**
Fix any real \(\theta>5\) and \(C>0\). There are positive primitive abc
triples for which **no** elliptic curve \(F/\mathbb Q\) isogenous to the
actual Frey curve satisfies
\[
 c^\theta\le C|\Delta_{\min}(F)|.
 \tag{7.5}
\]

**Proof.** Choose \(n\) with \(c_n^{\theta-5}>256C\) and use (7.1).
QED.

Thus even the proposal allowing every rational isogeny degree cannot
provide a uniform \(c^{6-\delta}\)-lower bound for any
\(0<\delta<1\), nor a \(c^{6-o(1)}\)-lower bound. The
isogenous representative is allowed to depend arbitrarily on the triple;
this freedom does not change the counterexample.

Also, choosing a representative in the entire rational isogeny class
cannot keep its complex \(j\)-invariant in a fixed bounded set on this
family. This is the concrete part of the archimedean height left over by
the attempted discriminant optimization.

## 8. Why this closes a shortcut but leaves the uniform geometry route open

For a general primitive triple put \(R=\operatorname{rad}(abc)\) and
\(H=\log c\). From \(a^2+ab+b^2=c^2-ab\) and \(0<ab\le c^2/4\),

\[
 \frac34c^2\le a^2+ab+b^2\le c^2,\qquad
 16a^2b^2c^2\le c^6 .
\]

It follows, without any conjecture, that the modified displayed height

\[
 M(E)=\log\max\{|c_4(E)|^3,|\Delta_{\rm disp}(E)|\}
\]

satisfies

\[
 6H+\log1728\le M(E)\le6H+\log4096.              \tag{8.1}
\]

The existing FREY_EVENTUAL_MODIFIED_SZPIRO_GATE.md explains exactly why
an estimate
\[
 \forall\varepsilon>0\ \exists K_\varepsilon\
 \forall(a,b,c),\quad
 M(E_{a,b,c})\le(6+6\varepsilon)\log R+K_\varepsilon
 \tag{8.2}
\]
suffices for the canonical target. Its version valid above a uniform
height threshold also suffices; (8.1) handles lower heights. This report
does not prove (8.2).

One attempted positive route was to replace \(M(E)\) by the largest
minimal discriminant in the rational isogeny class, use a conjectural
classical Szpiro bound there, and recover the full sixth power of \(c\).
Theorem 7.1 shows that the required replacement fails by an entire power
of \(c\) on (5.1), even after all rational isogenies have been allowed.
It does **not** show that (8.2), any classical Szpiro conjecture, or abc
is false. It also does not rule out a different elliptic construction
outside this isogeny class, a cover of a moduli curve, or a joint
archimedean and nonarchimedean argument.

No assertion that the triples (5.1) violate an abc inequality is made:
we have proved no sufficiently small radical for them. Their role is
to refute the universal replacement of a curve height by an optimized
minimal discriminant.

### 8.1 The quantitative modular estimate that remains

The previously audited independent modular route uses an optimal
parametrization \(X_0(N)\to A\), its degree \(\delta_{1,N}\), the Manin
constant \(c_f\), and the unnormalized Petersson norm of its normalized
newform \(f\). With \(P_f=(2\pi)^2\|f\|_2^2\), its exact area identity is

\[
 h_{\rm rel}(A)=\frac12
 \left(\log\frac{\delta_{1,N}}{c_f^2}-\log P_f\right).
 \tag{8.3}
\]

The established comparisons on the Frey family give
\(N=2^tR\) with \(-1\le t\le7\), an absolute isogeny error for relative
Faltings height, and \(P_f\gg N/\log N\). Keeping every epsilon uniform,
the missing leading-exponent bound in that audit is

\[
 \forall\eta>0\ \exists C_\eta>0\
 \forall\text{ optimal forms from the Frey family},\qquad
 \frac{\delta_{1,N}}{c_f^2}\le C_\eta N^{2+\eta}.
 \tag{8.4}
\]

The precise normalizations and source chain, including the fixed-prime
additive-reduction issue, are in
Lean/FREY_MODULAR_DEGREE_EXPONENT_AUDIT.md. The area calculation and
the distinction between the normalized and unnormalized degree
conjectures were checked again against
[Pasten, *Shimura curves and the abc conjecture*](https://arxiv.org/pdf/1705.09251v4),
Section 3, printed pages 15--17. In this arXiv v4 the relevant discussion
is Remark 3.3; the revised published paper is JNT **254** (2024),
214--335, where the related discussion is Remark 3.5. Numbering between
these versions must not be silently mixed.

For example, (8.3)--(8.4) and the Petersson lower bound would give
\[
 h_{\rm rel}(E_{a,b,c})
 \le\frac{1+\eta}{2}\log N+\frac12\log\log N+O_\eta(1).
 \tag{8.5}
\]
The standard comparison with \(h(j)\), absorbing its logarithmic error
with a further arbitrarily small epsilon, would yield (1.1). The
quantifiers in (8.4) are indispensable; a bound with one fixed exponent
larger than 2 would not supply this conclusion.

This isolates a still-open mathematical estimate, not a new theorem
or a formal certificate. The present obstruction changes neither the
validity of (8.3) nor the possibility of proving (8.4) by another method.

### 8.2 The recent auxiliary-Mordell progress does not settle (8.4)

Pasten's [2026-08-24 preprint, v1](https://arxiv.org/abs/2608.23559v1)
proves power-saving integral-point bounds using truncated prime
exponents and logarithmic forms. The repository's
GEOMETRY_GLOBAL_UNIFORM_GATE_2026_08_30.md already constructs three
genuine integral points from every primitive abc triple, with exact
cube-extraction prime costs, and checks the changing pure cubic fields
in applying those results. Those unconditional improvements are
retained. They do not supply (8.4).

In particular, fixed-support/fixed-curve estimates there have constants
depending on that fixed support or curve; they cannot be read as uniform
while the abc triple varies. The current isogeny theorem does not concern
those auxiliary curves, and it does not invalidate their proven estimates.

## 9. Boundary and result ledger

| Statement | Status in this round |
|---|---|
| Full rational 2-torsion plus an odd-prime rational isogeny forces degree 3 | Proved in Section 3 using the stated cyclic-degree classification |
| Every pair of \(\mathbb Q\)-isogenous curves is joined by rational prime-degree edges | Proved in Section 4 via a least-degree cyclic map; no false factorization of every given map |
| Family (5.1) has no odd-prime isogeny exit anywhere in its 2-primary graph | Proved by the explicit \(\mathbb F_7\) count and coprime transport |
| Entire rational isogeny class is exhausted by the four displayed models | Proved in Section 6 |
| \(D_{\max}\asymp c^5\) and \(J_{\min,\infty}\asymp c\), with constants in (7.1) | Proved in Section 7 |
| Uniform sixth-power recovery by selecting any rationally isogenous curve | Rigorously refuted by the explicit infinite family |
| All-epsilon modified Szpiro/Frey height estimate or normalized modular-degree estimate | Open; neither assumed true nor called false |
| Unconditional canonical ABCConjecture or an abc counterexample | Not obtained |
| New Lean closed terms | Only the bounded arithmetic companion in Section 10 |
| Modifications to accepted Lean files or the frozen paper | None |

The substantive change relative to the earlier report is the removal
of the 2-primary limitation, followed by the two sharp intrinsic
isogeny-class estimates. The result concerns an unbounded family of
actual primitive triples, not a finite enumeration and not a change
in the canonical target.

## 10. The bounded Lean companion, added after mathematical review

The root reviewer independently checked Sections 3--7, the source's
complete degree list, the four-model calculations, and both estimates
in (7.1) before authorizing this stage.

New module:
Lean/IUTThreeClosures/FreyEntireIsogenyArithmetic20260831.lean.

Module SHA256:
d31d9a21e912da6d120280e38a97db82950756fae8e36a8ddbaeff3725fb00fe.

The module has 23 named theorem declarations and two ellipticity instances.
In addition, familyTriple is a proof-carrying definition of an actual
ABCPoint; its positivity, sum, and coprimality proofs require a separate
dependency audit rather than being omitted because the declaration is
not introduced by the theorem keyword. The central audit therefore
checks these 26 named artifacts. The substantive objects and results are:

| Declarations | What was actually checked |
|---|---|
| familyTriple; endpointC_strictMono; endpointC_mod_eight; endpointC_cast_mod_seven | An element of the unchanged ABCPoint type for every natural index, an unbounded endpoint progression, and its congruences |
| model; model_map; model_c4; model_discriminant | Four actual Weierstrass curves over any commutative ring, genuine coefficient base change, and invariants computed from the library definitions |
| familyCurve_eq_canonical | Exact equality to the repository's four pre-existing canonical rational models at the constructed ABCPoint |
| canonical_reduction_seven | The actual integral canonical Frey curve, mapped by the integer-to-ZMod-7 ring homomorphism, equals the curve counted below |
| residueCurve_point_card; residueCurve_count_trace | The library's actual elliptic-curve Point type has eight elements including infinity; its numerical point-count trace is zero |
| degree_three_polynomial_no_root | For every element of ZMod 3, its square plus one is nonzero |
| model_discriminant_upper; model_c4_lower | All four actual displayed discriminants satisfy the fifth-power upper bound over the rationals; their actual c4 invariants satisfy the quadratic lower bound |
| familyCurve_j_lower; zeroKernel_j_upper | The actual library j-invariants over the rationals satisfy the pointwise lower bound \(2c\) and the zero-kernel witness upper bound \(32c\), for every index at least one |

The absolute value in the final two Lean theorems is ordinary rational
absolute value. The report uses its usual complex embedding; no global
Weil height is substituted for it. The four models are indexed by an
inductive type, not by a type asserted to be the entire isogeny class.

Command, run from the Lean directory:

    lake env lean IUTThreeClosures/FreyEntireIsogenyArithmetic20260831.lean

The final clean execution exited with code 0 and emitted no errors or
warnings. Its output is saved in
Lean/verification/2026_08_31_uniform_continuation/frey-entire-isogeny-direct-lean.log.
Six representative axiom reports list only propext, Classical.choice,
and Quot.sound. The source contains no sorry, admit, axiom declaration,
or native_decide.

The following remain external mathematical steps, with **no new Lean
axiom or certificate field standing in for them**:

- the rational cyclic-isogeny degree classification;
- quotient/dual isogenies and the cyclic least-degree map argument;
- identification of the computed point-count polynomial with the
  Galois action on 3-torsion;
- identification of the four displayed curves with the entire rational
  isogeny class;
- minimal-discriminant local theory and retention of the odd
  discriminant part in (7.2);
- all-epsilon conductor-height estimates and ABCConjecture.

In particular, an axiom-free proof of a finite-field count is not an
axiom-free formal proof of the entire rational isogeny classification.
