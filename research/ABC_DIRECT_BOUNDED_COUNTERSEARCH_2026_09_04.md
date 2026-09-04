# Direct bounded countersearch for the standard abc conjecture

**Author:** ChatGPT  
**Date:** 4 September 2026  
**Status:** exact finite computation and adversarial audit; no proof or disproof of the standard abc conjecture

## 1. Outcome

The complete search domain was

\[
  1\le a<b,\qquad a+b=c,\qquad \gcd(a,b)=1,
  \qquad 3\le c\le 100000.                 \tag{1.1}
\]

It contains exactly

\[
                     1,519,825,376
\]

unordered primitive triples. Exactly 419 of them satisfy

\[
                     c>\operatorname{rad}(abc).               \tag{1.2}
\]

The greatest standard quality in this complete domain is attained at

\[
  1+4374=4375,\qquad
  4374=2\cdot3^7,\qquad 4375=5^4\cdot7,
\]

so that

\[
  \operatorname{rad}(abc)=2\cdot3\cdot5\cdot7=210,
  \qquad
  \frac{\log4375}{\log210}
  =1.56788726440046078458\ldots .                         \tag{1.3}
\]

The point of greatest *additive* excess need not be the point of greatest
quality. For \(\varepsilon=1/100,1/20,1/10,1/4\), the maximum in (1.1) is

\[
  343+59049=59392,\qquad
  (343,59049,59392)=(7^3,3^{10},2^{11}\cdot29),             \tag{1.4}
\]

with radical \(1218=2\cdot3\cdot7\cdot29\). At
\(\varepsilon=1/2\), the maximum returns to (1.3).

A separate, fully factored structured scan includes the exact point

\[
                 2+3^{10}\cdot109=23^5,                     \tag{1.5}
\]

whose radical is \(15042=2\cdot3\cdot109\cdot23\) and whose quality is

\[
                 1.62991168412704818463\ldots .              \tag{1.6}
\]

This point lies beyond the complete height cutoff. It is an adversarial
benchmark, not a claim about a global record.

No rigorous counterexample to the standard abc conjecture was found. No
infinite route is retired: every negative conclusion in this report has a
finite range, while every positive-excess row is only one finite row.

## 2. What a disproof must prove

For a positive integer \(n\), write

\[
                 \operatorname{rad}(n)=\prod_{p\mid n}p.
\]

For a primitive positive abc triple, put

\[
 h=\log c,\qquad r=\log\operatorname{rad}(abc),
 \qquad q_{\rm abc}=\frac h r,
\]

and, for \(\varepsilon>0\), put

\[
 E_\varepsilon=h-(1+\varepsilon)r
 =\log\frac{c}{\operatorname{rad}(abc)^{1+\varepsilon}}.     \tag{2.1}
\]

The standard conjecture says that, for every \(\varepsilon>0\), there is a
constant \(K_\varepsilon>0\) such that

\[
       c\le K_\varepsilon\operatorname{rad}(abc)^{1+\varepsilon}
                                                                    \tag{2.2}
\]

for every primitive positive triple. Its negation is

\[
 \boxed{\text{there is one }\varepsilon>0\text{ for which }
        \sup E_\varepsilon=+\infty.}                         \tag{2.3}
\]

Indeed, taking logarithms in (2.2) gives
\(E_\varepsilon\le\log K_\varepsilon\). Conversely, a finite upper bound
for \(E_\varepsilon\) exponentiates to a suitable constant in (2.2).

This quantifier calculation explains the limitation of every finite search.
A row with \(E_\varepsilon>0\) disproves only the special inequality with
constant \(K=1\). Any finite collection has a finite maximum
\(M_\varepsilon\), and the larger constant \(K=e^{M_\varepsilon}\) covers
the collection. A genuine standard-abc disproof must give an unbounded
sequence for one fixed epsilon and verify the identity, positivity and
primitivity for every member. For example, a family with

\[
 q_{\rm abc}\ge1+\delta,\qquad
 \operatorname{rad}(abc)\longrightarrow\infty
\]

would suffice for any fixed \(0<\varepsilon<\delta\), because then

\[
 E_\varepsilon
 =\log c-(1+\varepsilon)\log R
 \ge(\delta-\varepsilon)\log R\longrightarrow\infty.        \tag{2.4}
\]

No family tested here satisfies such an all-index conclusion.

## 3. Why the bounded ranking is exhaustive

### Proposition 3.1 (primitive representatives at fixed height)

For every integer \(c\ge3\), the number of triples in (1.1) with this fixed
value of \(c\) is \(\varphi(c)/2\). Consequently the exact domain size is

\[
                 \sum_{c=3}^{100000}\frac{\varphi(c)}2
                 =1,519,825,376.                              \tag{3.1}
\]

**Proof.** Since \(b=c-a\),

\[
                 \gcd(a,b)=\gcd(a,c-a)=\gcd(a,c).
\]

Thus the ordered choices \(1\le a<c\) are precisely the \(\varphi(c)\)
reduced residues modulo \(c\). The involution \(a\mapsto c-a\) exchanges the
two orders of the same unordered triple. It has no fixed reduced residue for
\(c\ge3\), since \(a=c/2\) would have a nontrivial common divisor with
\(c\). Division by two proves the first assertion. The displayed integer was
computed by an Euler-totient sieve and independently checked against the
producer's direct enumeration. \(\square\)

The lower boundary matters. The present domain excludes the symmetric triple
\((1,1,2)\). If one instead used \(2\le c\le100000\) and \(a\le b\), the
count would be \(1,519,825,377\). This convention also explains a one-row
difference when comparing against repository searches that include \(c=2\).

### Proposition 3.2 (reduction to exact abc hits)

Let a finite domain contain a triple of quality greater than one. Its maximum
standard quality lies among the rows satisfying \(c>R\), where
\(R=\operatorname{rad}(abc)\). Fix \(\varepsilon>0\). If the domain contains
a row with \(E_\varepsilon>0\), its maximum epsilon excess also lies among
the rows satisfying \(c>R\).

**Proof.** Since \(R>1\),

\[
 q_{\rm abc}>1\quad\Longleftrightarrow\quad c>R.
\]

Thus a row with \(c\le R\) has quality at most one and cannot beat an
existing hit. Moreover, for such a row,

\[
 E_\varepsilon
 \le \log R-(1+\varepsilon)\log R
 =-\varepsilon\log R<0.
\]

It cannot beat an existing row of positive excess. \(\square\)

The complete scan found positive-excess rows for all five selected epsilon
values. Proposition 3.2 therefore proves that sorting the 419 exact hits gives
the maxima over all 1.52 billion triples; the other rows need not be stored.

### Proposition 3.3 (integer comparison for rational epsilon)

Write \(\varepsilon=u/v\) with positive integers \(u,v\). For two rows
\((c_1,R_1)\) and \((c_2,R_2)\),

\[
 E_{u/v}(c_1,R_1)>E_{u/v}(c_2,R_2)
\]

if and only if

\[
             c_1^vR_2^{v+u}>c_2^vR_1^{v+u}.                  \tag{3.2}
\]

Also \(E_{u/v}(c,R)>0\) if and only if

\[
                         c^v>R^{v+u}.                         \tag{3.3}
\]

**Proof.** Multiply the difference of the two excesses by \(v\), combine
logarithms, and use strict monotonicity of the logarithm. Setting the second
row's normalized quotient to one gives (3.3). \(\square\)

The program uses (3.2) and (3.3) with arbitrary-precision integers. Thus both
the signs and complete fixed-epsilon rankings are exact; floating-point
logarithms are display only for those rankings.

For the standard-quality order, the independent validator does more than
compare decimal approximations. After reducing an integer \(n\) to
\(n=2^km\) with \(1\le m<2\), it applies the positive series

\[
 \log m=2\sum_{j=0}^{N-1}\frac{z^{2j+1}}{2j+1}+T_N,
 \qquad z=\frac{m-1}{m+1},                                   \tag{3.4}
\]

with the exact rational remainder bound

\[
 0\le T_N\le
 \frac{2z^{2N+1}}{(2N+1)(1-z^2)}.                            \tag{3.5}
\]

Here \(0\le z\le1/3\); the same formula at \(z=1/3\) encloses
\(\log2\). With \(N=120\), exact `Fraction` arithmetic separates every
adjacent unequal pair in the complete 419-row quality ordering. Equal
\((c,R)\) pairs are ordered by their integer tuple. The independently
computed 120-, 180- and 220-digit decimal orders agree with this rational
certificate.

## 4. Complete bounded results

The first six rows by standard quality are:

| rank | \((a,b,c)\) | \(R=\operatorname{rad}(abc)\) | \(q_{\rm abc}\) |
|---:|---:|---:|---:|
| 1 | \((1,4374,4375)\) | 210 | 1.567887264400460785 |
| 2 | \((343,59049,59392)\) | 1218 | 1.547075055632051835 |
| 3 | \((37,32768,32805)\) | 1110 | 1.482910047161104792 |
| 4 | \((1,2400,2401)\) | 210 | 1.455673100177368859 |
| 5 | \((7168,78125,85293)\) | 2730 | 1.435005817990213173 |
| 6 | \((3,125,128)\) | 30 | 1.426565329633543330 |

The fixed-epsilon results are:

| \(\varepsilon\) | exact number with \(E_\varepsilon>0\) | maximizing triple | \(R\) | maximum \(E_\varepsilon\) |
|---:|---:|---:|---:|---:|
| \(1/100\) | 370 | \((343,59049,59392)\) | 1218 | 3.815899713393331674 |
| \(1/20\) | 240 | \((343,59049,59392)\) | 1218 | 3.531701095462537981 |
| \(1/10\) | 152 | \((343,59049,59392)\) | 1218 | 3.176452823049045864 |
| \(1/4\) | 30 | \((343,59049,59392)\) | 1218 | 2.110708005808569514 |
| \(1/2\) | 2 | \((1,4374,4375)\) | 210 | 0.363000502715511783 |

For example, the first entry says only that the constant in the bounded set
must be at least

\[
 \frac{59392}{1218^{101/100}}
 =e^{3.815899713\ldots}=45.4176008298\ldots .                 \tag{4.1}
\]

It supplies no lower bound at later heights.

## 5. Structured adversarial families

The second scan uses exact identities and complete trial-division
factorizations throughout each displayed finite range.

| family and finite range | rows | rows with \(c>R\) | best tested quality |
|---|---:|---:|---:|
| \((1,2^n-1,2^n),\ 2\le n\le40\) | 39 | 9 | 1.137076498973614 at \(n=18\) |
| \((2^{k+4},3,2^{k+4}+3),\ 0\le k\le36\) | 37 | 3 | 1.176007963323007 at \(k=13\) |
| \((2^{2r},3^r,2^{2r}+3^r),\ 1\le r\le12\) | 12 | 2 | 1.114255116002032 at \(r=10\) |
| \((2,15^n-2,15^n),\ 1\le n\le8\) | 8 | 0 | 0.864308154683258 at \(n=8\) |
| \((1,8U_n^2,X_n^2),\ 1\le n\le14\) | 14 | 14 | 1.226294385530917 at \(n=1\) |
| first fully factored Danilov-orbit row | 1 | 1 | 1.092956683198398 |
| primitive Pythagorean squares, \(m\le1000\) | 202,861 | 344 | 1.265900450122228 at \((m,n)=(196,47)\) |
| \((1,p^2-1,p^2)\), prime \(p\le100000\) | 9,592 | 33 | 1.226384753136282 at \(p=4801\) |

For the balancing sequence,

\[
 U_0=0,\quad U_1=1,\quad U_{n+2}=6U_{n+1}-U_n,
\]

and the companion sequence \(X_0=1,X_1=3\) satisfies the same recurrence.
The script verifies the Pell identity

\[
                         X_n^2-8U_n^2=1                       \tag{5.1}
\]

and factors both coordinates for every tested index. The fact that all 14
rows have quality greater than one does not imply that their excess is
unbounded. In fact the best tested quality occurs at the first row
\((1,8,9)\).

For coprime \(m>n>0\) of opposite parity, the Pythagorean-square identity is

\[
 (m^2-n^2)^2+(2mn)^2=(m^2+n^2)^2.                            \tag{5.2}
\]

The three unsquared coordinates are pairwise coprime, so their squared
triple is primitive. The best tested row is

\[
 (1310946849,339443776,1650390625),
 \qquad R=19118190,                                           \tag{5.3}
\]

coming from \((m,n)=(196,47)\), with quality
\(1.265900450122228\ldots\). Four rows in this family have positive
\(E_{1/4}\) in the tested box, but none has positive \(E_{1/2}\). Neither
finite fact retires the family.

For prime-square endpoints, the best tested parameter is \(p=4801\):

\[
                   1+23049600=23049601=4801^2,                \tag{5.4}
\]

with radical \(1008210\) and quality
\(1.226384753136282\ldots\).

The Danilov scan is deliberately restricted to the first orbit member for
which all three coordinates are completely factored here. Later repository
work has exponent-one certificates for many moving remainders, but a partial
factorization cannot support an exact standard-quality claim. The restriction
is an accuracy boundary, not abandonment of the Danilov route.

Finally, (1.5) passes every premise of being a primitive positive abc triple:
the identity is exact, its three supports \(\{2\}\), \(\{3,109\}\), and
\(\{23\}\) are disjoint, and all displayed factors are prime. It has positive
excess even for \(\varepsilon=1/2\):

\[
 E_{1/2}=1.249568728566225866\ldots .                         \tag{5.5}
\]

This is still one finite value of (2.1), so it does not satisfy (2.3).

## 6. Reproducibility and independent validation

The artifact directory is

`research/computation/2026_09_04_direct_abc_countersearch/`.

The producer uses two elementary facts.

1. If \(p\) is the smallest prime factor of \(n=pm\), then
   \(\operatorname{rad}(n)=\operatorname{rad}(m)\) when \(p\mid m\), and
   \(\operatorname{rad}(n)=p\operatorname{rad}(m)\) otherwise. This gives
   every radical up to the cutoff by induction.
2. For fixed \(c\), an integer \(a\) is coprime to \(c\) exactly when it is
   not a multiple of any distinct prime factor of \(c\). Marking those
   multiples enumerates exactly the representatives in Proposition 3.1.

The independent C++ validator does not reuse either enumeration mechanism.
It multiplies each prime into all its multiples to obtain radicals, scans the
pair threshold directly, applies `gcd` to threshold candidates, and computes
the total population by a separate totient sieve. It reproduces all 419 CSV
rows exactly.

The Python validator independently trial-divides every direct hit, recomputes
all fixed-epsilon power comparisons, checks the top 20 lists, verifies 105
distinct serialized structured certificates, and performs the rational
logarithm-interval proof (3.4)--(3.5). A clean replay regenerated
`ABC_HITS.csv`, `SCAN_SUMMARY.txt`, `STRUCTURED_OUTPUT.json`, and
`OUTPUT.json` byte for byte.

The key frozen hashes are:

| file | SHA-256 |
|---|---|
| `ABC_HITS.csv` | `1623e66693da53ec951bb023e3ef024c8bf76f40e9ce37d07b6b006cff582f8e` |
| `SCAN_SUMMARY.txt` | `081f0dc775c19710610998c8cade854f6e2e4ecfd096e08e34712e92c492dec3` |
| `STRUCTURED_OUTPUT.json` | `a688fd1410e417dfc055f8d5e8b5bda6979403d803966dafd3855f08790c3f17` |
| `OUTPUT.json` | `7055c292bb8255c9da35e043a26c7c7e89c4ac70919611afe767f1517b2565f2` |

## 7. Route decision

No complete-premise counterexample to standard abc was found, because no
unbounded fixed-epsilon sequence was constructed. No-hit statements for the
Mersenne, Pell, Danilov, Pythagorean, prime-square, balanced-two-prime, or
fifteen-power ranges are finite statements only. Accordingly:

- the direct counterexample route remains active;
- all tested structured families remain active outside their exact finite
  ranges;
- (1.3)--(1.6) are adversarial targets for any proposed positive inequality;
  and
- only a proposed bound contradicted by one of these fully checked rows may be
  retired, not the broader route from which that bound arose.
