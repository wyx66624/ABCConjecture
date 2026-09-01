# Exact Weil heights in the entire rational Frey isogeny class

Author: ChatGPT. Date: 2026-08-31.

Status: complete mathematical proof, before any new formalization.
Only this new report is written. No Lean module, accepted report,
TeX input, PDF, or verification snapshot is changed.

## 1. Family, definitions, and the previously proved input

Let

\[
 n\in\mathbb Z_{\ge1},\qquad
 c=1792n+2,\qquad u=c/2=896n+1.
\]

Then \(c\ge1794>32\), \(v_2(c)=1\), and \(u,c-1\) are odd positive
integers. The triple \((1,c-1,c)\) is positive and primitive.

We use the already proved entire-class theorem in Section 6 of
research/ARITHMETIC_GEOMETRY_UNIFORM_GATE_2026_08_31.md, whose reviewed
SHA256 is
bf8ccbb0e7821d0b1932f53b8dff132458a2db36cbac3e30854c2a428f507615.
Every elliptic curve over \(\mathbb Q\) rationally isogenous to the
actual Frey curve

\[
 E_c:\ y^2=x(x-1)(x+c-1)
\]

is rationally isomorphic to one of \(E_c,E_0,E_a,E_b\), with equations
and invariants given there. That result uses the stated rational
cyclic-isogeny classification and the good-reduction Frobenius theorem.
It is not being replaced here by a finite search or by an assertion
about an enumerated type in Lean.

Write

\[
 \begin{split}
 P&=c^2-c+1,\\
 Q&=c^2-16c+16,\\
 R&=c^2+14c+1,\\
 S&=16c^2-16c+1.
 \end{split}                                                   \tag{1.1}
\]

For a rational number \(z=N/D\), where \(N\in\mathbb Z\),
\(D\in\mathbb Z_{>0}\), and \(\gcd(N,D)=1\), the absolute logarithmic
Weil height is

\[
 \mathrm h(z)=\log\max\{|N|,D\}.                              \tag{1.2}
\]

Its multiplicative counterpart is
\(\mathrm H(z)=\exp(\mathrm h(z))\).
For rational \(z\), this is the normalized absolute height whether
computed over \(\mathbb Q\) or over a containing number field.
It must not be confused with \(\log^+|z|_\infty\).

Let \(\mathcal I_c\) be the entire rational isogeny class, modulo
rational isomorphism, and put

\[
 \mathrm h_{\min}(c)=\min_{F\in\mathcal I_c}\mathrm h(j(F)),\qquad
 J_{\min,\infty}(c)=\min_{F\in\mathcal I_c}|j(F)|_\infty.
\]

The original question's proposed height minimum is correct. In the
signed reduced fraction, however, \(j(E_0)\) has a minus sign.

## 2. All four reduced fractions

**Proposition 2.1.** The following fractions are reduced, with positive
denominators:

| Curve | Signed numerator \(N\) | Denominator \(D\) |
|---|---:|---:|
| \(E_c\) | \(64P^3\) | \(u^2(c-1)^2\) |
| \(E_0\) | \(-Q^3\) | \((c-1)u^4\) |
| \(E_a\) | \(8R^3\) | \(u(c-1)^4\) |
| \(E_b\) | \(8S^3\) | \(u(c-1)\) |

**Proof of the values.** The four actual invariants are

| Curve | \(c_4\) | Displayed \(\Delta\) |
|---|---:|---:|
| \(E_c\) | \(16P\) | \(16(c-1)^2c^2\) |
| \(E_0\) | \(16Q\) | \(-256(c-1)c^4\) |
| \(E_a\) | \(16R\) | \(256c(c-1)^4\) |
| \(E_b\) | \(16S\) | \(256c(c-1)\) |

Using \(j=c_4^3/\Delta\), these give, before substituting \(c=2u\),

\[
 \begin{split}
 j(E_c)&=\frac{256P^3}{c^2(c-1)^2},\\
 j(E_0)&=-\frac{16Q^3}{(c-1)c^4},\\
 j(E_a)&=\frac{16R^3}{c(c-1)^4},\\
 j(E_b)&=\frac{16S^3}{c(c-1)}.
 \end{split}                                                   \tag{2.1}
\]

Substitution of \(c=2u\) gives the claimed table. The ratio is the
actual invariant of the curve, so no assertion that the displayed
models are minimal at 2 is needed.

**Proof of the odd-prime part of coprimality.** Reducing (1.1) modulo
\(u\), respectively \(c-1\), gives

| Polynomial | Congruence modulo \(u\) | Congruence modulo \(c-1\) |
|---|---:|---:|
| \(P\) | \(1\) | \(1\) |
| \(Q\) | \(16\) | \(1\) |
| \(R\) | \(1\) | \(16\) |
| \(S\) | \(1\) | \(1\) |

The first column uses \(c=2u\); the second uses \(c\equiv1\pmod{c-1}\).
Since \(u,c-1\) are odd, 16 is a unit modulo either integer. Thus
each polynomial is coprime to \(u(c-1)\). Every prime in any
denominator divides \(u(c-1)\), whereas the extra numerator
coefficients 64 and 8 have no odd prime divisor. This excludes
all odd common prime factors, including 3.

**Proof of the 2-part.** The polynomials \(P,R,S\) are odd. Moreover

\[
 Q=4(u^2-8u+4),
\]

and the expression in parentheses is odd. Hence

\[
 v_2(P)=v_2(R)=v_2(S)=0,\qquad v_2(Q)=2.
\]

The four numerator valuations are therefore \(6,6,3,3\), respectively.
All four denominators are odd. No further factor of 2 cancels.
Together with the odd-prime calculation this proves that all four
fractions are reduced. \(\square\)

## 3. Positivity and the exact complex-absolute-value minimizer

The following elementary inequalities will be used repeatedly:

\[
 \begin{split}
 Q-\frac{c^2}{2}&=\frac{c(c-32)}2+16>0,\qquad Q<c^2,\\
 P-Q&=15(c-1)>0,\\
 R-Q&=15(2c-1)>0,\\
 S-Q&=15(c^2-1)>0.
 \end{split}                                                   \tag{3.1}
\]

Thus \(P,Q,R,S\) are all positive on the stated family.

**Proposition 3.1.** The class represented by \(E_0\) is the unique
minimizer of the complex absolute \(j\)-invariant. Its value is

\[
 J_{\min,\infty}(c)
    =\frac{Q^3}{(c-1)u^4}
    =\frac{16Q^3}{(c-1)c^4}>2c>1.                          \tag{3.2}
\]

In particular all four absolute \(j\)-invariants are greater than 1.

**Proof.** Since \(Q>c^2/2\) and \(c-1<c\),

\[
 |j(E_0)|=\frac{16Q^3}{(c-1)c^4}>2c.
\]

The other three ratios to this positive quantity are exactly

\[
 \begin{split}
 \frac{|j(E_c)|}{|j(E_0)|}
   &=\frac{16c^2}{c-1}\left(\frac P Q\right)^3>1,\\
 \frac{|j(E_a)|}{|j(E_0)|}
   &=\left(\frac{cR}{(c-1)Q}\right)^3>1,\\
 \frac{|j(E_b)|}{|j(E_0)|}
   &=\left(\frac{cS}{Q}\right)^3>1.
 \end{split}                                                   \tag{3.3}
\]

Each strict inequality follows from (3.1) and \(c>1\).
The entire-class theorem reduces every class to one of these four
models. Strictness separates \(E_0\) from all the others, regardless
of any possible coincidence between other displayed models.
This proves both uniqueness and (3.2). \(\square\)

This strengthens the earlier bounds \(2c\le J_{\min,\infty}(c)\le32c\);
it does not change their meaning to a global height.

## 4. Exact Weil heights and their minimum

**Theorem 4.1.** The four absolute logarithmic Weil heights are

\[
 \begin{split}
 \mathrm h(j(E_c))&=\log64+3\log P,\\
 \mathrm h(j(E_0))&=3\log Q,\\
 \mathrm h(j(E_a))&=\log8+3\log R,\\
 \mathrm h(j(E_b))&=\log8+3\log S.
 \end{split}                                                   \tag{4.1}
\]

The unique minimizing class in the entire rational isogeny class is
\(E_0\), and

\[
 \boxed{\mathrm h_{\min}(c)=3\log(c^2-16c+16)},\qquad
 \min_{F\in\mathcal I_c}\mathrm H(j(F))=Q^3.                 \tag{4.2}
\]

**Proof.** Proposition 2.1 supplies reduced fractions with positive
denominators, and Proposition 3.1 shows that the absolute numerator
exceeds the denominator in every row. Definition (1.2) therefore
gives (4.1).

The inequalities \(P>Q\), \(R>Q\), and \(S>Q>0\) in (3.1), together
with \(64>1\) and \(8>1\), show that each height other than that of
\(E_0\) is strictly larger than \(3\log Q\). The entire-class theorem
again supplies the passage from the four actual models to every
rationally isogenous curve. This proves (4.2) and uniqueness.
\(\square\)

In particular,

\[
 6\log c-3\log2<\mathrm h_{\min}(c)<6\log c,\qquad
 \frac{c^6}{8}<\min_{F\in\mathcal I_c}\mathrm H(j(F))<c^6.
                                                                  \tag{4.3}
\]

The exact limiting assertion is stronger than an order estimate:

\[
 \mathrm h_{\min}(c)-6\log c
 =3\log(1-16/c+16/c^2)\longrightarrow0.                  \tag{4.4}
\]

No finite enumeration or conjectural bound enters this limit.

## 5. Why the complex minimum has a different leading term

The two minima are attained by the same curve. Their different sizes
come from the finite places, not from a change of minimizer.

For a reduced rational number \(z=N/D\), its finite-place contribution
to the absolute logarithmic height is

\[
 \sum_{q\ {\rm prime}}\log\max\{1,|z|_q\}=\log D.
\]

Indeed only primes dividing \(D\) contribute, and coprimality makes
their contributions exactly \(v_q(D)\log q\).
For \(j(E_0)\), its infinite contribution is \(\log|j(E_0)|\), since
the absolute value is greater than 1. Thus (3.2) and (4.2) give the
exact identity

\[
 \begin{split}
 \mathrm h_{\min}(c)-\log J_{\min,\infty}(c)
   &=\log((c-1)u^4)\\
   &=5\log c-\log16+\log(1-1/c).
 \end{split}                                                   \tag{5.1}
\]

Equivalently,

\[
 \frac{J_{\min,\infty}(c)}{c}
 =16\,\frac{(1-16/c+16/c^2)^3}{1-1/c}
 \longrightarrow16.                                         \tag{5.2}
\]

Consequently

\[
 \frac{\log J_{\min,\infty}(c)}{\log c}\longrightarrow1,
 \qquad
 \frac{\mathrm h_{\min}(c)}{\log c}\longrightarrow6.
                                                                  \tag{5.3}
\]

The denominator in the reduced \(E_0\) fraction accounts for the
entire missing contribution of asymptotic size \(5\log c\).
Replacing the absolute Weil height by the single complex term would
discard it.

There is also an exact bound on the gain from replacing the original
Frey curve by the best representative:

\[
 \mathrm h(j(E_c))-\mathrm h_{\min}(c)
    =\log64+3\log(P/Q).                                      \tag{5.4}
\]

Here \(1<P/Q<2\), since \(P<c^2\) and \(Q>c^2/2\). Therefore
this gain lies strictly between \(6\log2\) and \(9\log2\), and tends
to \(6\log2\) as \(n\to\infty\). Optimization within the entire
rational isogeny class saves only a bounded additive quantity on
this family.

## 6. The exact replacement statement refuted

**Corollary 6.1.** For every \(\delta>0\) and every real constant \(C\),
there is \(n\ge1\) such that every curve \(F/\mathbb Q\) rationally
isogenous to \(E_{c_n}\) satisfies

\[
 \mathrm h(j(F))>(6-\delta)\log c_n+C.                    \tag{6.1}
\]

Equivalently, for every \(\theta<6\) and \(C_0>0\), some member of the
family satisfies

\[
 \mathrm H(j(F))>C_0c_n^\theta
 \qquad\text{for every }F\in\mathcal I_{c_n}.              \tag{6.2}
\]

**Proof.** Choose \(n\) so large that
\(\delta\log c_n>C+3\log2\), and use the first inequality in (4.3).
For (6.2), choose \(c_n^{6-\theta}>8C_0\) and use its multiplicative
version. Such choices exist because \(c_n\) is unbounded.
\(\square\)

Thus allowing an arbitrary rationally isogenous representative does
not lower the leading sixth-power Weil-height size in this family.
This is the precise additional obstruction established here.

It does not refute a conductor--height estimate with a radical on
the right, a modified Szpiro conjecture, or abc. No small-radical
estimate for these triples has been proved. The uniform gate involving
the radical, and routes using arithmetic information outside this
isogeny class, remain open.

## 7. Proof and formalization boundary

The arithmetic of the reduced fractions uses \(v_2(c)=1\); the
strict comparisons above use \(c\ge32\). The assertion that these
four curves exhaust the whole rational isogeny class additionally
uses the previously proved result for \(c=1792n+2\), including its
modulo-seven and classical isogeny inputs. This report does not
claim the entire-class conclusion for arbitrary even \(c\).

The earlier Lean module verifies actual Weierstrass models and
some invariant/absolute-value bounds. It does not by itself prove
their rational isogeny-class completeness. No new Lean result about
reduced fractions, the absolute Weil height, or (4.2) is claimed here.
The present contribution is the preceding mathematical proof.
