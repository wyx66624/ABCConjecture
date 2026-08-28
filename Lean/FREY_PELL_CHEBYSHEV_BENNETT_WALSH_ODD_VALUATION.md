# Bennett--Walsh/Cohn eliminates both Granville square classes

## 1. Result and scope

Let \(p\ge 31\) be prime, let \(X>1\) be an integer, and write

\[
 p=2m+1,\qquad
 H_p(X)=\frac{\mathcal T_p(X)}{X}
       =\operatorname{pellOddChebyshevQuotient}(m,X),
\tag{1.1}
\]

where \(\mathcal T_p\) is the first-kind Chebyshev polynomial.

> **Odd-valuation theorem.** The integer \(H_p(X)\) is neither a square nor
> \(p\) times a square. Consequently the Lucas-cyclotomic block
> \(\Phi^{L}_{2p}=H_p(X)\) has a primitive prime divisor occurring to an odd
> exact power.

The square exclusion is already a direct instance of Bennett--Walsh
Corollary 1.5. This note also gives a second derivation from their Theorem
1.2 and Cohn's theorem, because the same Pell-coordinate framework is needed
for the less immediate \(p\)-times-square exclusion.

This result repairs the valuation gap isolated in
FREY_PELL_CHEBYSHEV_PRIMITIVE_ODD_VALUATION_AUDIT.md. It does **not** prove
that

\[
 y^2=4\mathcal T_p(X)+5                                      \tag{1.2}
\]

has no integral solution, and it does not prove abc. Section 8 explains why
the new odd valuation remains compatible with the split norm in
\(\mathbf Q(\sqrt5)\).

## 2. Exact Pell and Chebyshev setup

Put

\[
 X^2-1=dS^2,                                                \tag{2.1}
\]

where \(d\) is squarefree and positive. Since \(X>1\), the integer
\(X^2-1\) is not a square: otherwise
\((X-S)(X+S)=1\), forcing \(X=1\). Hence \(d>1\).

Let

\[
 \varepsilon=R_1+V_1\sqrt d>1
\]

be the fundamental norm-one unit, and define

\[
 \varepsilon^n=R_n+V_n\sqrt d.                             \tag{2.2}
\]

The standard structure theorem for positive Pell solutions supplies an
integer \(k\ge1\), of completely arbitrary parity, such that

\[
 X+S\sqrt d=\varepsilon^k,\qquad R_k=X.                     \tag{2.3}
\]

Taking real parts after raising (2.3) to the \(p\)-th power gives

\[
 R_{kp}=\mathcal T_p(R_k)=\mathcal T_p(X)=XH_p(X).           \tag{2.4}
\]

Finally, take the squarefree part of \(X\):

\[
 X=B u^2,\qquad B>0\text{ squarefree}.                      \tag{2.5}
\]

Thus

\[
 R_k=B u^2,\qquad R_{kp}=B u^2 H_p(X).                      \tag{2.6}
\]

No step assumes that \(\varepsilon^k\) itself is fundamental. In
particular, no parity condition on \(k\) is introduced.

## 3. Exact Bennett--Walsh and Cohn inputs

For \(a>1\), let \(\alpha(a)\) be the least positive \(n\) for which
\(a\mid R_n\), and put \(\alpha(a)=\infty\) when no such \(n\) exists.

### 3.1 Bennett--Walsh Theorem 1.2

For fixed squarefree \(d>1\) and squarefree \(a>1\), there is at most one
index \(n\) such that

\[
 R_n=a w^2.                                                  \tag{3.1}
\]

Moreover, if it exists, that index is

\[
 n=\alpha(a).                                                \tag{3.2}
\]

This is exactly Theorem 1.2, not an asymptotic or fixed-height
reformulation.

### 3.2 The odd-multiple occurrence fact

The proof of Bennett--Walsh Lemma 3.3, under that lemma's standing
squarefreeness hypotheses, explicitly states that for every squarefree
\(a>1\),

\[
 a\mid R_n
 \quad\Longleftrightarrow\quad
 n=t\alpha(a)\text{ for some odd positive }t.                \tag{3.3}
\]

This is stronger than the bare divisibility \(\alpha(a)\mid n\). The word
odd is decisive in Section 5.2. The restriction \(a>1\) must be retained:
(3.3) is false for \(a=1\), since \(1\) divides every coordinate. None of
the uses below applies (3.3) to \(a=1\).

### 3.3 Bennett--Walsh Lemma 5.1

For an odd prime \(q\), Lemma 5.1 says

\[
\begin{array}{ll}
q\mid d &\Longrightarrow \alpha(q)=\infty,\\[2mm]
q\nmid d &\Longrightarrow
 \alpha(q)=\infty\text{ or }
 \alpha(q)\mid\dfrac{q-(d/q)}2.
\end{array}                                                  \tag{3.4}
\]

In the finite second case, \((d/q)=\pm1\), so

\[
 \alpha(q)\mid\frac{q-1}{2}
 \quad\text{or}\quad
 \alpha(q)\mid\frac{q+1}{2}.                                \tag{3.5}
\]

In particular,

\[
 \gcd(\alpha(q),q)=1.                                       \tag{3.6}
\]

### 3.4 The coefficient-one theorem

Bennett--Walsh Theorem 1.1 quotes Cohn's 1997 theorem. If
\(R_1+V_1\sqrt d\) is fundamental, the only possible solutions to

\[
 W^4-dZ^2=1                                                  \tag{3.7}
\]

have

\[
 W^2=R_1
 \quad\text{or}\quad
 W^2=2R_1^2-1=R_2.                                          \tag{3.8}
\]

Both occur only for \(d=1785\). Since the positive Pell trace coordinates
are strictly increasing, the consequence used here is

\[
 R_n=W^2\quad\Longrightarrow\quad n=1\text{ or }n=2.        \tag{3.9}
\]

This is precisely the \(a=1\) endpoint omitted from Theorem 1.2.

## 4. The square alternative

### 4.1 Direct Bennett--Walsh Corollary 1.5

Bennett--Walsh define

\[
 P_m(x)=\frac{\mathcal T_{2m+1}(x)}x.                        \tag{4.1}
\]

Their Corollary 1.5 determines all integral points on

\[
 y^2=P_m(x).                                                 \tag{4.2}
\]

The endpoint points have \(x=1,y=\pm1\); because \(P_m\) is an even
polynomial, the corresponding \(x=-1\) points are automatic. The only
additional possible abscissa is \(x=0\), and it occurs only when

\[
 2m+1=r^2                                                    \tag{4.3}
\]

for an odd integer \(r\). Thus the complete abscissa ledger is

\[
 x=\pm1,\qquad
 \text{and, only for square odd index, }x=0.                 \tag{4.4}
\]

For \(2m+1=p\) prime, (4.3) is impossible. In particular, \(X>1\) gives

\[
 \boxed{H_p(X)\ne z^2}.                                     \tag{4.5}
\]

This is a direct published theorem; it does not require fixing \(p\) and
running a separate integral-point computation.

### 4.2 Independent Pell-coordinate derivation

Suppose instead that \(H_p(X)=z^2\). Equation (2.6) gives

\[
 R_k=B u^2,\qquad R_{kp}=B(uz)^2.                            \tag{4.6}
\]

If \(B>1\), these are two occurrences of the same squarefree coefficient
\(B\). Bennett--Walsh Theorem 1.2 makes their indices equal, contrary to
\(kp>k\).

If \(B=1\), then \(R_{kp}\) is a square. Cohn's theorem forces
\(kp\in\{1,2\}\), whereas \(p\ge3\) and \(k\ge1\) give \(kp\ge3\).
This proves (4.5) again and explicitly covers the coefficient-one case.

## 5. The \(p\)-times-square alternative

Assume, for contradiction, that

\[
 H_p(X)=p z^2.                                               \tag{5.1}
\]

Then

\[
 R_{kp}=pB(uz)^2.                                           \tag{5.2}
\]

There are two genuinely different squarefree-kernel cases.

### 5.1 Case \(p\mid B\)

Write

\[
 B=pc,\qquad c=B/p.                                         \tag{5.3}
\]

Squarefreeness of \(B\) implies squarefreeness of \(c\), and (5.2) becomes

\[
 R_{kp}=c(puz)^2.                                           \tag{5.4}
\]

If \(c>1\), Theorem 1.2 gives

\[
 kp=\alpha(c).                                               \tag{5.5}
\]

But \(c\mid B\mid R_k\). The occurrence fact (3.3) makes \(k\) an odd
multiple of \(\alpha(c)\), in particular

\[
 \alpha(c)\le k,                                            \tag{5.6}
\]

contradicting (5.5) and \(kp>k\).

The endpoint \(c=B/p=1\) cannot be silently discarded. In this case (5.4)
says that \(R_{kp}\) is a square. Cohn gives \(kp\in\{1,2\}\), again
impossible because \(kp\ge3\).

### 5.2 Case \(p\nmid B\)

Now \(Bp\) is squarefree and greater than one. From (5.2) and Theorem 1.2,

\[
 kp=\alpha(Bp).                                              \tag{5.7}
\]

Also \(p\mid R_{kp}\). Thus (3.3) supplies an odd positive integer \(t\)
with

\[
 kp=t\alpha(p).                                              \tag{5.8}
\]

This occurrence first handles the ramified branch. If \(p\mid d\), Lemma
5.1 says \(\alpha(p)=\infty\), contradicting \(p\mid R_{kp}\). Hence

\[
 p\nmid d.                                                   \tag{5.9}
\]

The finite branch of Lemma 5.1 and (3.6) give

\[
 \gcd(\alpha(p),p)=1.                                       \tag{5.10}
\]

From (5.8), Euclid's lemma yields \(\alpha(p)\mid k\). Write

\[
 k=s\alpha(p).                                               \tag{5.11}
\]

Substitution into (5.8), followed by cancellation of positive
\(\alpha(p)\), gives

\[
 sp=t.                                                       \tag{5.12}
\]

Both \(t\) and \(p\) are odd, so \(s\) is odd. Applying the reverse
direction of (3.3) to (5.11) proves

\[
 p\mid R_k.                                                  \tag{5.13}
\]

But \(B\mid R_k\) by (2.6), and \(\gcd(B,p)=1\). Hence

\[
 Bp\mid R_k.                                                 \tag{5.14}
\]

The occurrence fact for the composite integer \(Bp>1\) gives
\(\alpha(Bp)\le k\), contradicting (5.7).

This argument includes \(B=1\): then \(p\nmid B\), \(Bp=p>1\), and
\(B\mid R_k\) is automatic. It also shows exactly why no assumption on the
parity of \(k\) is needed. Oddness belongs to \(t=kp/\alpha(p)\); after
using Lemma 5.1 to remove the factor \(p\), it transfers to
\(s=k/\alpha(p)\).

Combining the cases gives

\[
 \boxed{H_p(X)\ne pz^2}.                                    \tag{5.15}
\]

## 6. Granville Corollary 5

Consider the Lucas sequence

\[
 L_0=0,\quad L_1=1,\quad L_{n+2}=2X L_{n+1}-L_n.            \tag{6.1}
\]

Its Lucas-cyclotomic block at index \(2p\) is

\[
 \Phi^{L}_{2p}
 =\frac{L_{2p}L_1}{L_2L_p}
 =\frac{\mathcal T_p(X)}X
 =H_p(X).                                                    \tag{6.2}
\]

Granville Corollary 5 says that, if \(L_n\) has no characteristic prime
factor occurring to an odd power and \(n\notin\{6,12\}\), then

\[
 \Phi^L_n=w^2
 \quad\text{or}\quad
 \Phi^L_n=r w^2,                                            \tag{6.3}
\]

where \(r\) is prime, \(r^a\mid n\) for some \(a\ge1\), and

\[
 \frac{n}{r^a}\le r+1.                                     \tag{6.4}
\]

At \(n=2p\), the only candidates for \(r\) are \(2\) and \(p\). For
\(r=2\), necessarily \(a=1\), and (6.4) would say \(p\le3\). This is false
for \(p\ge31\). For \(r=p\), (6.3) becomes \(H_p(X)=p w^2\). Therefore

\[
\begin{aligned}
&\text{no characteristic prime of odd multiplicity}\\
&\hspace{18mm}\Longrightarrow
H_p(X)=w^2\text{ or }H_p(X)=pw^2.                            \tag{6.5}
\end{aligned}
\]

Sections 4 and 5 exclude both alternatives. By contraposition there is a
characteristic prime at index \(2p\) with odd exact multiplicity.  Granville's
Corollary 3 also says that a characteristic prime divides the term
\(L_{2p}\) and its cyclotomic block \(\Phi^L_{2p}=H_p(X)\) to the same exact
power.  Hence this prime really divides \(H_p(X)\) to that odd exact
multiplicity; no valuation is lost when passing from the term to the block.

For completeness, this characteristic prime is primitive in Schinzel's
sense at index \(2p\):

* \(2\) already occurs in \(L_2=2X\);
* if an odd prime \(q\) divides the discriminant \(4(X^2-1)\), Granville's
  discriminant congruence gives
  \(L_n\equiv nX^{n-1}\pmod q\). Its first characteristic occurrence is at
  the prime index \(q\), not at the composite index \(2p\).

Thus the characteristic odd-multiplicity prime does not divide the
discriminant and is a primitive prime divisor.

## 7. Formal companion and trust boundary

The companion file
IUTThreeClosures/FreyPellChebyshevBennettWalshOddValuation.lean imports and
reuses the repository definition pellOddChebyshevQuotient. It contains no
axiom and no sorry.

The accepted results are represented by transparent propositions:

* BennettWalshTheoremOneTwo;
* Cohn1997TheoremOneOneConsequence;
* BennettWalshOddMultipleOccurrence;
* BennettWalshLemmaFiveOne;
* GranvilleCorollaryFiveAtTwicePrime, incorporating Granville Corollary 3's
  same-exact-power bridge;
* CharacteristicImpliesPrimitive.

AcceptedPellOrbit is a certificate package intended to be instantiated by
the fundamental-unit trace sequence.  Its type records \(d>1\),
squarefreeness of \(d\), \(X>1\), the arbitrary positive index \(k\), the
squarefree decomposition of \(X\), the Chebyshev/Pell composition identity,
and each accepted interface.  It does not encode the Pell recurrence or
kernel-construct this package for every \(X\).  The Lean theorems do not
manufacture proofs of those propositions; each proposition must be passed as
a hypothesis.

Lean kernel-checks these nontrivial combination steps:

1. Lemma 5.1 plus actual occurrence implies
   \(\gcd(\alpha(p),p)=1\), including explicit rejection of \(p\mid d\).
2. The square exclusion handles \(B>1\) by Theorem 1.2 and \(B=1\) by Cohn.
3. The \(p\)-square exclusion handles separately \(p\mid B\), \(p\nmid B\),
   \(B/p=1\), \(B=1\), and arbitrary parity of \(k\).
4. Contraposition of Granville's two-shape classification gives an
   odd-multiplicity characteristic prime, which is transported through the
   characteristic-to-primitive interface.

The standalone target is checked with

    lake build IUTThreeClosures.FreyPellChebyshevBennettWalshOddValuation

Every material theorem has a print-axioms command. The reported kernel
dependencies are only the standard Mathlib foundations propext,
Classical.choice, and Quot.sound; there is no sorryAx and no native decision
axiom.

## 8. Why this still does not close the shifted-square equation

Suppose (1.2) holds and let \(q\mid H_p(X)\) be the new primitive prime of
odd multiplicity.  Primitivity at index \(2p\) gives
\(q\ne2,5\) and \(q\nmid X\): the prime \(2\) and every prime dividing
\(X\) already occur at \(L_2=2X\), while \(5\) has rank at most six and
cannot first occur at \(2p\ge62\).  Reduction modulo \(q\) gives

\[
 y^2\equiv5\pmod q.                                         \tag{8.1}
\]

For the relevant primitive primes \(q\ne5\), this says that \(q\) splits in
\(K=\mathbf Q(\sqrt5)\):

\[
 (q)=\mathfrak q\,\overline{\mathfrak q}.                   \tag{8.2}
\]

The shifted equation factors as

\[
 (y+\sqrt5)(y-\sqrt5)=4XH_p(X).                             \tag{8.3}
\]

The two conjugate factors cannot both be divisible by the same prime above
\(q\), because their difference is \(2\sqrt5\). If
\(q^e\mathbin\Vert H_p(X)\), then, because \(q\nmid4X\), after labeling the
two primes the allocation must be
\(\mathfrak q^e\) in one factor and
\(\overline{\mathfrak q}^{e}\) in the conjugate factor. Thus the same
prime ideal does not divide both factors, while the two conjugate prime
ideals occur symmetrically. A principal split prime ideal may occur to an
arbitrary exponent. Neither principality nor class number one forces that
exponent to be even.

Equivalently, the refined equation

\[
 u^2-5v^2=4H_p(X)                                           \tag{8.4}
\]

also admits split primes with odd valuation. The new theorem supplies the
previously missing odd valuation but no contradiction with (8.3) or (8.4).
A further genuinely global coupling condition is still required.

## 9. Primary sources

1. M. A. Bennett and G. Walsh, *The Diophantine equation
   \(b^2X^4-dY^2=1\)*, **Proceedings of the American Mathematical Society**
   127 (1999), 3481--3491. Theorem 1.1, Theorem 1.2, the proof of Lemma
   3.3, Lemma 5.1, and Corollary 1.5 are used above.
   [DOI 10.1090/S0002-9939-99-05041-8](https://doi.org/10.1090/S0002-9939-99-05041-8),
   [author PDF](https://personal.math.ubc.ca/~bennett/BW-PAMS.pdf).

2. J. H. E. Cohn, *The Diophantine equation \(x^4-Dy^2=1\), II*,
   **Acta Arithmetica** 78 (1997), 401--403.
   [DOI 10.4064/aa-78-4-401-403](https://doi.org/10.4064/aa-78-4-401-403),
   [publisher page and PDF](https://www.impan.pl/en/publishing-house/journals-and-series/acta-arithmetica/all/78/4/109529/the-diophantine-equation-x-dy-1-ii).

3. A. Granville, *Primitive prime factors in second-order linear recurrence
   sequences*, **Acta Arithmetica** 155 (2012), 431--452. Lemma 3's rank
   bound, Corollary 3's same-exact-power bridge, Corollary 5, and the
   discriminant-prime congruence are used in Sections 6 and 8.
   [DOI 10.4064/aa155-4-7](https://doi.org/10.4064/aa155-4-7),
   [author PDF](https://dms.umontreal.ca/~andrew/PDF/PrimitivePrimeFactors.pdf).
