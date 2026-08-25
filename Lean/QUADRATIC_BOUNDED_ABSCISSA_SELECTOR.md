# A bounded-abscissa quadratic globalization of Frey local selectors

**Author: ChatGPT**

## Abstract

Let

\[
E_{a,b}: y^2=x(x-a)(x+b), \qquad a+b=c,
\]

be the Frey curve attached to a primitive positive abc triple. At every odd
prime of multiplicative reduction, the reduced cubic has only one singular
\(x\)-coordinate. We combine this fact with the Chinese remainder theorem,
a weighted double count, and uniform boundedness of torsion in degree two.
For every \(\delta>0\), this produces a non-torsion point

\[
P_j=\bigl(j,\sqrt{j(j-a)(j+b)}\bigr)
\]

over a field of degree at most two, with \(|j|\) bounded only by \(\delta\),
which lies in the identity component at all but a \(\delta\)-fraction of
both the exponent-excess mass and the reduced-radical mass.

This is a genuine unconditional selector theorem. It bypasses the rank-zero
obstruction over \(\mathbf Q\) and the Poitou--Tate obstruction to prescribing
rational Kummer classes. It does not prove abc. The quadratic twist and field
discriminant still have source-height conductor, and we give an infinite
family showing that this cost cannot be made \(o(\log c)\) by any fixed
finite universe of bounded abscissas. Thus the construction closes the
existence problem and rigorously retires the fixed bounded-abscissa
sublinear-conductor refinement. It does not rule out a proof using additional
global cancellation for the same points.

## 1. The unique singular residue

Write

\[
f_{a,b}(X)=X(X-a)(X+b).
\]

Let \(p\ne 2\) divide \(abc\). Primitivity implies that \(p\) divides exactly
one of \(a,b,c\). The reduced cubic has one double root and one simple root.
Its unique singular \(x\)-coordinate is

\[
\nu_p=
\begin{cases}
0,&p\mid a,\\
0,&p\mid b,\\
a\equiv-b\pmod p,&p\mid c.
\end{cases}
\tag{1.1}
\]

Consequently, an integral point whose \(x\)-coordinate is not congruent to
\(\nu_p\) reduces to a smooth point. It therefore belongs to the identity
component of the Néron model. Smoothness of the section persists after every
finite extension of \(\mathbf Q_p\).

Put

\[
e_p=v_p(abc),\qquad
E=\sum_{\substack{p\mid abc\\p\ne2}}(e_p-1)\log p,\qquad
R=\sum_{\substack{p\mid abc\\p\ne2}}\log p.
\tag{1.2}
\]

Thus the full odd multiplicative-depth mass is

\[
D=E+R=\sum_{\substack{p\mid abc\\p\ne2}}e_p\log p.
\tag{1.3}
\]

The separation of \(E\) and \(R\) is essential. Controlling a fraction of
\(D\) alone does not by itself control a prescribed fraction of \(E\) when
the exponent profile varies.

## 2. Weighted residue avoidance

### Lemma 2.1

Let \(S\) be a finite set of primes. For each \(p\in S\), choose a residue
\(\nu_p\in\mathbf F_p\) and a weight \(w_p\ge0\). Let \(L\ge1\). There are
integers

\[
j_k=r+Mk,\qquad 0\le k<L,
\tag{2.1}
\]

where

\[
M=\prod_{\substack{q\le L\\q\ {\rm prime}}}q,\qquad 0\le r<M,
\tag{2.2}
\]

such that:

1. \(j_k\not\equiv\nu_p\pmod p\) for every \(p\in S\) with \(p\le L\);
2. for every \(p\in S\) with \(p>L\), at most one \(j_k\) is congruent to
   \(\nu_p\pmod p\);
3. consequently,

\[
\sum_{k=0}^{L-1}
\sum_{\substack{p\in S\\j_k\equiv\nu_p\ (p)}}w_p
\le \sum_{p\in S}w_p.
\tag{2.3}
\]

#### Proof

For every prime \(q\le L\), prescribe a residue modulo \(q\). If \(q\in S\),
choose a residue different from \(\nu_q\); otherwise choose zero. The Chinese
remainder theorem supplies \(r\) modulo \(M\).

Now let \(p>L\). Since \(p\nmid M\), two collisions would imply

\[
p\mid M(k-\ell),\qquad\text{hence}\qquad p\mid k-\ell.
\]

But \(|k-\ell|<L<p\), so \(k=\ell\). Interchanging the two finite sums proves
(2.3). \(\square\)

## 3. Removing all degree-two torsion candidates

The candidate points live in different quadratic fields, so a separate
torsion bound for each field is not enough. One needs a bound on their union.

Uniform boundedness gives an integer \(B_{\le2}\) such that every torsion
point defined over a number field of degree at most two has order at most
\(B_{\le2}\). Define

\[
T_2=\sum_{n=1}^{B_{\le2}}n^2.
\tag{3.1}
\]

For a fixed elliptic curve \(E/\mathbf Q\), every degree-at-most-two torsion
point lies in the finite set

\[
\bigcup_{1\le n\le B_{\le2}}E[n](\overline{\mathbf Q}),
\]

whose cardinality is at most \(T_2\). Hence at most \(T_2\) distinct rational
\(x\)-coordinates can yield such torsion points.

Merel's theorem already supplies the required \(B_{\le2}\). The
Kamienny--Kenku--Momose classification makes the construction explicit:
one may take \(B_{\le2}=18\), hence the deliberately coarse bound
\(T_2=\sum_{n=1}^{18}n^2=2109\).

## 4. The quadratic selector

### Theorem 4.1

For every \(\delta>0\), there is \(H_\delta\) with the following property.
For every primitive positive abc triple, there exist an integer \(j\), a
number field \(K\), and a point \(P_j\in E_{a,b}(K)\) such that

\[
[K:\mathbf Q]\le2,\qquad |j|\le H_\delta,\qquad
x(P_j)=j,\qquad P_j\ \text{is non-torsion},
\tag{4.1}
\]

and, writing \(B_E,B_R\) for the exceptional masses at primes where
\(j\equiv\nu_p\pmod p\),

\[
B_E\le\delta E,\qquad B_R\le\delta R.
\tag{4.2}
\]

At every other odd bad prime, \(P_j\) belongs to the identity component at
every place of \(K\) above \(p\).

#### Proof

If \(E>0\) and \(R>0\), apply Lemma 2.1 to the normalized composite weight

\[
w_p=
\frac{(e_p-1)\log p}{E}+\frac{\log p}{R}.
\tag{4.3}
\]

Its total mass is \(2\). If one of \(E,R\) is zero, omit that summand; its
total mass is then at most \(2\). Choose

\[
L>T_2,\qquad \frac{2}{L-T_2}\le\delta.
\tag{4.4}
\]

For each candidate \(j_k\), set

\[
d_k=f_{a,b}(j_k),\qquad
K_k=\mathbf Q(\sqrt{d_k}),\qquad
P_k=(j_k,\sqrt{d_k}).
\tag{4.5}
\]

The \(j_k\) are distinct. Section 3 therefore shows that at least
\(L-T_2\) of the \(P_k\) are non-torsion. Restricting (2.3) to those
candidates, one of them has composite bad mass at most
\(2/(L-T_2)\le\delta\). Since both normalized summands in (4.3) are
nonnegative, each is separately at most \(\delta\), proving (4.2).

Finally,

\[
0\le j_k<ML,
\]

so one may take \(H_\delta=ML\), which depends only on \(\delta\).
The identity-component assertion follows from Section 1. \(\square\)

If \(d_j=D_js_j^2\) with \(D_j\) signed and squarefree, the point also gives
a rational point

\[
Q_j=(D_jj,D_j^2s_j)
\]

on the standard quadratic twist

\[
E^{D_j}:Y^2=X(X-D_ja)(X+D_jb).
\tag{4.6}
\]

Over \(\mathbf Q(\sqrt{D_j})\), the usual twist isomorphism sends \(Q_j\) to
\(P_j\), so non-torsion is preserved. Its Kummer class is an actual Mordell--
Weil class and therefore has zero image in \(\Sha(E^{D_j})[2]\). The selector
does not arise from assuming a Poitou--Tate compatibility condition.

## 5. The retained local-height mass

For a point over a number field \(K\), define the normalized contribution
above a rational prime by

\[
\Lambda_p(P)=\frac1{[K:\mathbf Q]}\sum_{v\mid p}\lambda_v(P),
\tag{5.1}
\]

where \(\lambda_v\) uses the local factor \(\log N(v)\). At an odd bad
prime, the Frey curve has type \(I_{2e_p}\). If the point lies on the
identity component at every \(v\mid p\), then

\[
\Lambda_p(P_j)=\frac{v_p(\Delta_{\min})}{12}\log p
=\frac{e_p}{6}\log p.
\tag{5.2}
\]

For an arbitrary component, the Bernoulli term is bounded below by
\(-e_p\log p/12\). Since (4.2) gives

\[
B_D=B_E+B_R\le\delta(E+R)=\delta D,
\]

the total odd bad-prime contribution satisfies

\[
\sum_{\substack{p\mid abc\\p\ne2}}\Lambda_p(P_j)
\ge \frac{D-B_D}{6}-\frac{B_D}{12}
\ge \frac{2-3\delta}{12}(E+R).
\tag{5.3}
\]

This coefficient is unchanged by base extension. If \(v\mid p\) has
ramification degree \(e_v\) and residue degree \(f_v\), the type becomes
\(I_{2e_pe_v}\). With the normalized local weight
\(\log N(v)/[K:\mathbf Q]\), the sum is

\[
\frac1{[K:\mathbf Q]}
\sum_{v\mid p} e_vf_v\,\frac{e_p\log p}{6}
=\frac{e_p\log p}{6}.
\tag{5.4}
\]

Equation (5.4) is the unambiguous normalized aggregation; an unnormalized
symbol \(\lambda_p\) should not be used across varying local fields.

## 6. The conductor and discriminant bill

Bounded \(x\)-coordinate does not imply bounded arithmetic complexity. Put
\(H=H_\delta\). Since \(a,b\ge1\),

\[
|f_{a,b}(j)|\le H(H+1)^2ab\le C_\delta c^2.
\tag{6.1}
\]

Thus

\[
|\operatorname{Disc}\mathbf Q(\sqrt{D_j})|
\le4|D_j|\le C_\delta c^2.
\tag{6.2}
\]

At tame odd primes, the conductor of the rational twist has the exact
variable part

\[
N_{\ge5}(E^{D_j})=
\frac{\operatorname{rad}_{\ge5}(abc)}
{\gcd(\operatorname{rad}_{\ge5}(abc),|D_j|)}
\operatorname{rad}_{\ge5}(D_j)^2.
\tag{6.3}
\]

The primes \(2\) and \(3\) contribute only a bounded local exponent. Hence

\[
\log N(E^{D_j})
\le \log\operatorname{rad}(abc)+2\log|D_j|+O(1)
\le \log\operatorname{rad}(abc)+4\log c+O_\delta(1).
\tag{6.4}
\]

The same cost appears in a coordinate-free form. If \(D_j\ne1\), so that
\(K=\mathbf Q(\sqrt{D_j})/\mathbf Q\) is genuinely quadratic, induction of
the two-dimensional \(\ell\)-adic representation gives

\[
N(E)\,N(E^{D_j})
=|\operatorname{Disc}K|^2\,
N_{K/\mathbf Q}(\mathfrak N_{E/K}).
\tag{6.5}
\]

Thus good relative reduction over \(K\) does not erase the absolute
discriminant cost; it moves that cost between the twist conductor and the
restriction-of-scalars conductor.

### Theorem 6.1: a fixed finite abscissa universe cannot have sublinear cost

Let \(J\subset\mathbf Z\setminus\{0,1\}\) be finite and nonempty, and put
\(m=\#J\). There are infinitely many primitive triples

\[
(a,b,c)=(1,b,b+1)
\]

such that:

1. the odd exponent-excess mass is at least
   \(\frac12\log c-O_J(1)\);
2. for every \(j\in J\), the squarefree part \(D_j\) of
   \(j(j-1)(j+b)\) contains a prime \(q_j\) of good reduction for the
   original Frey curve, and \(q_j\mid\operatorname{Disc}
   \mathbf Q(\sqrt{D_j})\);
3. the twist \(E^{D_j}\) has conductor exponent \(2\) at \(q_j\), and

\[
2\log q_j\ge \frac1{2m}\log c-O_J(1).
\tag{6.6}
\]

#### Proof

Enumerate \(J\). For arbitrarily large \(Q\), repeated use of Bertrand's
postulate in disjoint dyadic intervals gives distinct primes \(q_j\) with
\(Q\le q_j\le2^mQ\), all larger than every prime dividing
\(\prod_{j\in J}j(j-1)\). Put

\[
M=\prod_{j\in J}q_j^2
\]

and choose \(n\) with \(M\le3^n<3M\). The Chinese remainder theorem gives
\(b\) satisfying

\[
b\equiv0\pmod{3^n},\qquad
b\equiv -j+q_j\pmod{q_j^2}\quad(j\in J).
\tag{6.7}
\]

Choose a positive representative with \(b<6M^2\). Then
\(v_{q_j}(j+b)=1\), whereas \(q_j\) divides none of
\(j(j-1)b(b+1)\). Thus \(q_j\mid D_j\) and \(q_j\) is a good prime for
\(E_{1,b}\). Since \(D_j\) is squarefree, \(q_j\) also divides the quadratic
field discriminant. A squarefree quadratic twist at a good odd prime has
conductor exponent \(2\).

Moreover \(v_3(b)\ge n\), so

\[
E\ge(n-1)\log3\ge\log M-O(1)
\ge\frac12\log c-O_J(1).
\]

Finally \(c<6M^2+1\le C_JQ^{4m}\), while \(q_j\ge Q\), which gives (6.6).
\(\square\)

Theorem 6.1 proves that the source-height twist cost is not merely an
artifact of a coarse estimate. For every fixed bounded list of possible
abscissas, there is an actual infinite abc family on which every nontrivial
candidate pays a positive multiple of \(\log c\) in both new conductor and
quadratic-field discriminant. This retires the fixed bounded-abscissa
sublinear-conductor/discriminant refinement, but it does not exclude
cancellation among global terms, unbounded adaptive abscissas, or a
different auxiliary geometry.

## 7. Orthogonality of different quadratic characters

Suppose \(P_i,P_j\) lie in distinct nontrivial quadratic-character
eigenspaces inside a common multiquadratic extension. There is a Galois
element \(\sigma\) with

\[
\sigma P_i=-P_i,\qquad \sigma P_j=P_j.
\]

Galois invariance and bilinearity of the Néron--Tate pairing give

\[
\langle P_i,P_j\rangle
=\langle\sigma P_i,\sigma P_j\rangle
=\langle-P_i,P_j\rangle
=-\langle P_i,P_j\rangle,
\]

so \(\langle P_i,P_j\rangle=0\). If one character is trivial, interchange
the labels and use symmetry of the pairing. Consequently,

\[
\widehat h\!\left(\sum_i n_iP_i\right)
=\sum_i n_i^2\widehat h(P_i)
\tag{7.1}
\]

for points in pairwise distinct quadratic eigenspaces. Adding many such
selectors does not create a shorter Mordell--Weil vector.

## 8. What remains open

The local existence problem is solved: after a controlled degree-two
extension one can find a non-torsion point retaining almost all of both
\(E\) and \(R\). The fixed bounded-abscissa sublinear-conductor refinement
is closed negatively by Theorem 6.1; a global cancellation mechanism for
the same points is not excluded.

A surviving approach must therefore do at least one of the following:

1. use an unbounded, arithmetic-adaptive abscissa while controlling its
   field discriminant and conductor;
2. produce several useful points in one quadratic character space and prove
   a genuinely small vector theorem there;
3. obtain cancellation between finite, discriminant, and archimedean terms
   not visible in separate absolute-value estimates;
4. replace the quadratic twist by an auxiliary motive whose global
   conductor sees the retained local depth with coefficient below the
   critical abc slope.

None of these inputs is established here. In particular, no abc or Szpiro
estimate has been assumed.

## 9. Lean boundary

The companion module
IUTThreeClosures/QuadraticBoundedAbscissaSelector.lean formalizes:

1. uniqueness of collisions in an arithmetic progression;
2. the weighted owner/double-counting inequality;
3. selection below the surviving weighted average;
4. the exact local-height ledger
   \((D-B)/6-B/12=(2D-3B)/12\);
5. preservation of the coefficient under normalized local-degree sums;
6. the abstract Galois-sign orthogonality argument;
7. the scalar bridge from a hypothetical small adverse-height budget to an
   exponent-mass bound.

Lean does not currently formalize Merel's theorem, the CRT construction,
quadratic fields, Néron models, local height functions, Tate's algorithm,
the conductor formula (6.3), or the infinite family of Theorem 6.1. Those
are paper proofs, not hidden conclusion-bearing fields.

## References

1. L. Merel, *Bornes pour la torsion des courbes elliptiques sur les corps
   de nombres*, Invent. Math. 124 (1996), 437--449.
2. M. A. Kenku and F. Momose, *Torsion points on elliptic curves defined
   over quadratic fields*, Nagoya Math. J. 109 (1988), 125--149,
   DOI 10.1017/S0027763000002816.
3. S. Kamienny, *Torsion points on elliptic curves and q-coefficients of
   modular forms*, Invent. Math. 109 (1992), 221--229,
   DOI 10.1007/BF01232025.
4. J. Tate, *Algorithm for determining the type of a singular fiber in an
   elliptic pencil*, in Modular Functions of One Variable IV, Lecture Notes
   in Mathematics 476, Springer (1975), 33--52.
5. J. H. Silverman, *Computing heights on elliptic curves*, Math. Comp. 51
   (1988), 339--358, DOI 10.1090/S0025-5718-1988-0942161-4.
