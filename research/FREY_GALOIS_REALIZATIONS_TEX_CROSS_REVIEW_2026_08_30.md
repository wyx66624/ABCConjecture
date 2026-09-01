# Independent mathematical review of the finite Frey English section

Author: ChatGPT. Review date: 2026-08-31 (local date).

Reviewed input: paper/frey_galois_realizations_2026.tex.

Checked snapshot: 12204 bytes, SHA256

    fa44977cc9956fdc4922fabec0aff1607dbe412c98180c910d9aaff33729a4b2

**Verdict:** no substantive mathematical correction is required. This
review covers the two level-7 examples at residue prime 139, the specific
balanced level-43 example at 1289, the elementary image lemma, and the
normalized-height and exceptional-set discussion. It is a review of
these statements, not a proof of a global pilot inequality or abc.
No reviewed source, Lean module, main input, or PDF was changed.

## 1. The matrix-image argument and its degree bound

For a nonidentity transvection \(T\) in dimension two, its image under
\(T-1\) equals its fixed line. If \(g\) fixes no line, that line and its
image under \(g\) give a common basis in which

\[
 T=U(s),\qquad gTg^{-1}=L(t),\qquad s,t\ne0.
\]

In the prime field their integer powers give every upper and every lower
root element. The displayed identity

\[
 W(t)=U(t)L(-t^{-1})U(t)
   =\begin{pmatrix}0&t\\-t^{-1}&0\end{pmatrix},\qquad
 W(t)W(-1)=\operatorname{diag}(t,t^{-1})
\]

is correct, including in characteristic two. Row elimination covers the
case of a nonzero upper-left entry; one upper operation makes that entry
nonzero when it is initially zero. Returning to the original basis is
legitimate because the determinant-one group is invariant under
conjugation in the full general linear group.

For \(H\triangleleft G\) of index prime to \(\ell\), the image of \(T\)
in \(G/H\) has order dividing both \(\ell\) and the index. Therefore
\(T\in H\), and normality retains \(gTg^{-1}\). This is the claimed
passage to the smaller arithmetic image.

The torsion field is Galois, and

\[
 [\mathbb Q(i,D[30]):\mathbb Q]\mid
 2|\operatorname{GL}_2(\mathbb Z/30\mathbb Z)|
 =2\cdot6\cdot48\cdot480=276480=2^{11}3^3 5.
\]

This conservative bound is valid for all the displayed curves and is
prime to both 7 and 43. The image over the torsion field is normal with
index dividing that field degree. No normality of a randomly chosen
subgroup or of a single inertia line is being assumed.

## 2. The two residue-139 examples

Independent integer arithmetic verified the stated factorizations and
primality of their displayed prime factors, including 1181. The endpoint
triples are primitive. At 139, the two reduced equations have respective
nodes at \(0\) and \(1\), each with tangent slopes \(1,-1\). The rational
invariants have unit \(c_4\) there and discriminant valuation two.

A fresh enumeration of the five possible \(x\)-coordinates and all five
possible \(y\)-coordinates, with the point at infinity added, gives
respectively 8 and 4 points over \(\mathbb F_5\). The resulting
Frobenius polynomials are exactly \(T^2+2T+5\) and \(T^2-2T+5\);
their common discriminant \(-16\) is a nonsquare modulo 7. The
Tate order two supplies a nontrivial order-7 transvection. Thus the
abstract lemma applies with its nonidentity hypothesis verified.

Full rational 2-torsion implies \(\sqrt q\in\mathbb Q_{139}\), not merely
an even valuation: the Galois ratio of a square root is in both
\(\{\pm1\}\) and \(q^{\mathbb Z}\), so valuation forces it to be one.
Also 139 has order two modulo 210. Therefore

\[
 K_0=\mathbb Q_{139}(\mu_{210})
\]

is unramified quadratic, and \(T^{105}-\sqrt q\) is Eisenstein over
\(K_0\). This gives the stated degree 210 and ramification index 105.
The equality with the full torsion field follows by fixing the two Tate
torsion classes; a root-of-unity multiplier that is a power of \(q\)
must be one. The unramified quadratic field contains \(i\).
No equality \(q=139^2\) is needed.

The two exact normalized bases were independently recomputed as

\[
 N_1=8105229,\qquad N_2=2790703.
\]

Both satisfy \(3^{25}<N_i^2<2^{49}\). Since \(2<\exp(1)<3\),
these inequalities have the correct direction to give
\(25<2\log N_i<49\).

## 3. The balanced level-43 arithmetic and all prime exponents

I recomputed \(A=1289(1289^{16}+428)\), its residues \(5\bmod8\) and
\(1\bmod215\), its exact 1289-valuation one, and the three endpoints.
The displayed rational coordinate change is an isomorphism, without a
quadratic twist. The proof of splitness at every odd bad prime and good
reduction at 43 is valid for these residues.

For the finite small-prime certificate, I independently enumerated every
prime at most 511 by trial division, obtaining 97 primes, and multiplied
them to obtain the primorial. Euclidean arithmetic gives

\[
 \gcd(a,P)=3,\qquad \gcd(b,P)=2,\qquad \gcd(c,P)=17.
\]

The three Bezout identities stored in
research/GEOMETRY_43_1289_ARITHMETIC_CERTIFICATE_2026_08_30.json were
checked against independently recomputed endpoints and primorial.
Their right sides divide both terms, so they are exact gcd certificates.
The terminal residues give \(v_3(a)=2\), \(v_2(b)=1\), and
\(v_{17}(c)=1\).

The bounds \(a,b,c<2^{377}\) were also checked directly. For every
prime \(r\ge512\), one has \(r^{43}\ge2^{387}>a,b,c\). Combining
this large-prime bound with the finite certificate and pairwise
coprimality proves \(v_r(abc)<43\) for every prime \(r\). It does not
require a complete factorization of the large endpoints. The companion
Lean source indeed uses the genuine library primorial and ends with a
theorem quantified over every prime, rather than a assigned list of
possible factors.

Over \(F=\mathbb Q(i,D[30])\), the nonzero integral Tate orders are
\(2e(w/r)v_r(abc)\), with \(43\nmid e(w/r)\). The argument therefore
proves the statement over the field actually specified in the theorem.
It does not extend that assertion to the level-43 torsion field.

## 4. Reduction at two and source applicability

I reopened Silverman's original second-edition PDF, pages 204, 208,
212, and 216: these are respectively VII.2.1, VII.3.1(a),
VII.5.1(c), and VII.6.1. The component-group theorem in the last
location bounds the order by four in the additive case without excluding
residue characteristic two. All completions here are complete discretely
valued finite extensions of \(\mathbb Q_2\), with finite perfect residue
fields.

Under additive reduction, both the formal subgroup and the nonsingular
reduction group have no nontrivial 3-torsion. Thus the rational group
\(D[3]\) of order nine injects into the component quotient, contradicting
that bound. The computed \(j\)-valuation six excludes multiplicative
reduction, so the specific field \(F\) gives good reduction. This does
not appeal to an unspecified extra semistable extension.

## 5. Strict real height bounds and the local uniformizer

Put \(N=abc/2\). The height proof is justified by the following exact
integer/rational chain, independently checked:

\[
 p^{17}<A<2p^{17},\qquad A^6<N<3A^6,\qquad
 3^6<p<(8/3)^8,
\]
\[
 3^{1224}<N^2
   <9\cdot2^{12}(8/3)^{1632}
   <(8/3)^{1648}.
\]

For the last inequality, \(9\cdot2^{12}<3^{12}\) and
\(3^{28}<8^{16}\). Since \(8/3<\exp(1)<3\), it follows strictly that

\[
 \exp(1224)<N^2<\exp(1648),
 \qquad 1224<2\log N<1648<1849.
\]

The cancellation of the factor \([F:\mathbb Q]\) in the normalized
Tate degree is the standard sum of ramification times residue degrees;
good reduction at two accounts for the denominator two in \(N\).

At 1289, \(b_0=\sqrt q\) has valuation two. Setting
\(\pi^{645}=b_0\) does not make \(\pi\) a uniformizer. The formula in the
English section correctly gives, for \(\eta=p^2/b_0\),

\[
 \beta=\pi^{323}/p,\qquad
 \beta^{645}=p\eta^{-323},\qquad \pi=\eta\beta^2.
\]

The first relation is Eisenstein over the unramified quadratic
\(\mathbb Q_p(\mu_{1290})\), and the last proves equality of the two
generated fields. Thus the degree is 1290 and ramification index is
645. The native root \(q^{1/86}=\pi^{15}\) has valuation \(2/43\).
All unit factors have been retained.

## 6. The exceptional-set paragraph is properly qualified

I checked Joshi IV v2, PDF pages 51 and 53--55. Lemma 5.8.1(1)
really requires the lower Chebyshev estimate for every real argument
at least its threshold. As \(\theta(10)=\log210<6<20/3\), that
threshold must exceed ten. Under the normalized quantity of Definition
5.4.1 and Theorem 5.7.1, the small-height enlargement in the proof
therefore contains the two examples with square root below seven,
provided they belong to the stated bounding domain.

The opening sum on page 54 does omit the degree divisor. The English
section explicitly keeps that normalization conflict separate and does
not use the normalized \(Q_D\) values in an unnormalized formula. The
level-43 numerical window likewise is not identified with an existential
prime in the source theorem. The later initial-data construction is a
separate result. These limits are necessary and are present in the
reviewed input.

In total, 25 newly recomputed exact arithmetic checks passed, followed
by separate checks of the stored Bezout identities, complete prime
range, terminal residues, and cyclotomic residue orders. No floating
point logarithm was used for a strict inequality, and no long build
or modification of a frozen validation artifact was performed.
