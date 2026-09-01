# The exact three-prime-support gate for primitive abc triples

Date: 2026-08-31. Author: ChatGPT.

Status: this note proves an unconditional structural reduction for every
positive primitive triple supported on at most three primes.  It also proves
several complete low-signature classifications.  One part of the strongest
classification uses Fermat's Last Theorem and one part uses a published
theorem on \(x^2+4=y^n\); neither external theorem is presently proved in
Mathlib.  The accompanying Lean module therefore formalizes only the
elementary equation-level exclusions for signatures \((2,3,3)\) and
\((2,3,6)\), without importing either external classification.  Nothing here
proves or disproves the general abc conjecture.

The preceding repository result treats \(\omega(abc)\leq2\) completely and
proves the sharp bound

\[
             c\leq\frac32\operatorname{rad}(abc),
\]

with equality only at \((1,8,9)\) and its input swap.  The purpose here is to
identify exactly what first appears when a third prime is allowed, rather than
to repackage that two-prime theorem.

## 1. Notation and elementary support bookkeeping

A primitive positive abc triple is

\[
 a,b,c\in\mathbb Z_{>0},\qquad a+b=c,\qquad \gcd(a,b)=1.
 \tag{1.1}
\]

Then \(a,b,c\) are pairwise coprime.  Put

\[
 \omega(n)=\#\{p:p\text{ prime and }p\mid n\},\qquad
 R=\operatorname{rad}(abc).
\]

Because the three prime supports are disjoint,

\[
 \omega(abc)=\omega(a)+\omega(b)+\omega(c).
 \tag{1.2}
\]

Exactly one of \(a,b,c\) is even.  Thus exactly one of the prime bases in any
support decomposition below is \(2\).

**Theorem 1.1 (exact support-three decomposition).**  Suppose (1.1) and
\(\omega(abc)\leq3\).

1. If \(a,b>1\), then \(\omega(abc)=3\), and there are pairwise distinct
   primes \(p,q,r\) and unique positive integers \(x,y,z\) such that
   \[
                      a=p^x,\qquad b=q^y,
                      \qquad c=r^z.                 \tag{1.3}
   \]
2. If one input is \(1\), then, after swapping the inputs, either the triple is
   \((1,1,2)\), or it has exactly one of the following forms, with all displayed
   prime bases distinct and all exponents positive:
   \[
   \begin{array}{ll}
   1+p^x=q^y,                         &(1,1)\text{ support split},\\
   1+p^x=q^y r^z,\quad q<r,           &(1,2)\text{ support split},\\
   1+p^xq^y=r^z,\quad p<q,            &(2,1)\text{ support split}.
   \end{array}                                             \tag{1.4}
   \]

Here the ordered pair in the annotation records the numbers of prime divisors
of the two nonunit consecutive integers.

**Proof.**  If \(a,b>1\), then each of \(a,b,c\) has at least one prime
divisor.  Equation (1.2) and the assumed upper bound force each support to
have cardinality one.  An integer greater than one with exactly one prime
divisor is a unique positive power of that prime.  Pairwise coprimality makes
the three bases distinct, proving (1.3).

Now take \(a=1\).  If \(b=1\), then \(c=2\).  Otherwise both \(b\) and
\(c=b+1\) are nonunits.  Their support cardinalities are positive and have sum
at most three, so the only possibilities are \((1,1),(1,2),(2,1)\).  Unique
prime factorization gives (1.4); ordering the two bases on a two-prime endpoint
removes the only naming ambiguity.  The parity assertion follows because two
of the three pairwise-coprime entries cannot be even, while either one input
or their sum must be even.  \(\square\)

This is a true exhaustion: the three-prime problem contains both a moving
three-prime generalized Fermat equation (1.3) and two moving semiprime
consecutive-power branches in (1.4).

## 2. What Catalan's theorem actually closes

Mihăilescu's theorem says that the only consecutive perfect powers with both
bases and both exponents greater than one are \(8\) and \(9\).  Applied to the
first line of (1.4), it gives the following exact statement.

**Corollary 2.1 (pure consecutive powers).**  If

\[
                        1+p^x=q^y,\qquad x,y>1,
\]

with \(p,q\) prime, then \((p,x,q,y)=(2,3,3,2)\).

Catalan's theorem says nothing by itself when \(x=1\) or \(y=1\), and it does
not classify either semiprime line in (1.4).  In particular, replacing a
two-prime endpoint by a single unnamed perfect power would lose the actual
arithmetic condition that has to be proved.

The repository's two-prime-support proof obtains the stronger classification
needed there by elementary factorization, without importing Catalan.  The
corollary above is included only to mark the exact boundary of the published
theorem requested in this audit.

## 3. A common-exponent rigidity theorem

The first new rigidity inside (1.3) is unexpectedly sharp.

**Theorem 3.1 (common-exponent rigidity).**  Let \(p,q,r\) be pairwise
distinct primes and let \(x,y,z\geq1\) satisfy

\[
                         p^x+q^y=r^z.                \tag{3.1}
\]

If \(d=\gcd(x,y,z)>1\), then, up to swapping the two terms on the left,

\[
                         2^4+3^2=5^2.                \tag{3.2}
\]

**Proof.**  Set

\[
 X=p^{x/d},\qquad Y=q^{y/d},\qquad Z=r^{z/d}.
\]

Then \(X^d+Y^d=Z^d\).  Fermat's Last Theorem excludes \(d>2\), so
\(d=2\).  The triple \((X,Y,Z)\) is primitive.  Exactly one leg is even;
after swapping the legs, write \(X=2^A\).  Euclid's parametrization of a
primitive Pythagorean triple gives coprime integers \(m>n>0\) of opposite
parity such that

\[
                 X=2mn,\qquad Y=m^2-n^2,\qquad Z=m^2+n^2.       \tag{3.3}
\]

The identity \(2mn=2^A\) gives \(mn=2^{A-1}\).  Coprimality and opposite
parity force \(n=1\) and \(m=2^k\) for some \(k\geq1\).  Hence

\[
 Y=(2^k-1)(2^k+1)=q^{y/2}.                              \tag{3.4}
\]

The two factors in (3.4) are coprime positive odd integers.  A product of
two coprime integers which is a power of one prime has one factor equal to
one.  The larger factor cannot be one, so \(2^k-1=1\), whence \(k=1\).
Thus \((X,Y,Z)=(4,3,5)\), and squaring gives (3.2).  \(\square\)

The exceptional triple is harmless for a radical estimate:
\(25<\operatorname{rad}(16\cdot9\cdot25)=30\).  Thus any all-nonunit
three-prime triple with \(c>R\) has exponent gcd one.

## 4. The exact low-signature list

For (3.1) with \(x,y,z\geq2\), define

\[
                  \sigma(x,y,z)=\frac1x+\frac1y+\frac1z.
\]

The unordered exponent signature is the multiset \(\{x,y,z\}\); the choice
of which exponent occurs on the output still matters.

**Lemma 4.1 (reciprocal classification).**  After sorting
\(2\leq x\leq y\leq z\), the signatures with \(\sigma\geq1\) are exactly

\[
\begin{array}{ll}
\sigma>1:&(2,2,n)\ (n\geq2),\quad(2,3,3),\quad(2,3,4),
             \quad(2,3,5),\\[2mm]
\sigma=1:&(3,3,3),\quad(2,4,4),\quad(2,3,6).
\end{array}                                                \tag{4.1}
\]

**Proof.**  If \(x\geq4\), then \(\sigma\leq3/4\).  If \(x=3\), the
only way to reach one is \(y=z=3\).  Let \(x=2\).  If \(y\geq5\), then
\(\sigma\leq1/2+1/5+1/5<1\).  If \(y=4\), only \(z=4\) reaches one.
If \(y=3\), precisely \(z=3,4,5,6\) reach one.  Finally \(y=2\) gives
\(1+1/z>1\) for every \(z\geq2\).  \(\square\)

The next two propositions dispose of two complete signatures without an
external Diophantine classification.

**Proposition 4.2.**  There is no solution of (3.1) with exponent signature
\((2,3,3)\).

**Proof.**  If the output has exponent three, after swapping inputs the
equation is \(P^2+Q^3=R^3\).  Then

\[
 P^2=(R-Q)(R^2+RQ+Q^2).                                  \tag{4.2}
\]

The second positive factor is strictly larger than the first.  Since their
product is a prime square, the first factor must be one.  Thus \(R-Q=1\).
Consecutive primes force \((Q,R)=(2,3)\), but then (4.2) says \(P^2=19\),
which is impossible.

If the output has exponent two, the equation is \(P^3+Q^3=R^2\), so

\[
 (P+Q)(P^2-PQ+Q^2)=R^2.                                  \tag{4.3}
\]

Both factors exceed one, hence both would have to equal \(R\).  They are not
equal: indeed

\[
 P^2-PQ+Q^2-(P+Q)
   =(P-Q)^2+(P-1)(Q-1)-1>0                                \tag{4.4}
\]

for distinct primes \(P,Q\).  This is a contradiction.  These are all output
placements.  \(\square\)

**Proposition 4.3.**  There is no solution of (3.1) with exponent signature
\((2,3,6)\).

**Proof.**  There are three output placements, up to swapping inputs.

* If \(P^2+Q^3=R^6\), factor the difference of cubes:
  \[
  P^2=(R^2-Q)(R^4+R^2Q+Q^2).
  \]
  Positivity and the strict inequality between the factors force
  \(R^2-Q=1\).  For odd \(R\), the number
  \(Q=(R-1)(R+1)\) is composite.  For \(R=2\), one gets \(Q=3\) and
  \(P^2=37\), again impossible.
* If \(P^2+Q^6=R^3\), put \(Y=Q^2\).  The same factorization forces
  \(R-Y=1\), hence \(R=Q^2+1\).  For odd \(Q\) this is an even integer
  greater than two.  For \(Q=2\), one gets \(R=5\) and \(P^2=61\).
* If \(P^3+Q^6=R^2\), put \(Y=Q^2\).  Then
  \[
  (P+Y)(P^2-PY+Y^2)=R^2.
  \]
  Both factors exceed one, but the second is strictly larger because
  \[
  P^2-PY+Y^2-(P+Y)
       =(P-Y)^2+(P-1)(Y-1)-1>0.
  \]

Every case is contradictory.  \(\square\)

Together with Theorem 3.1, Propositions 4.2--4.3 also eliminate all three
Euclidean signatures in (4.1): \((3,3,3)\) and \((2,4,4)\) have a common
exponent divisor, while \((2,3,6)\) is Proposition 4.3.

## 5. Complete prime-base classification of signature \((2,2,n)\)

One published exponential-equation theorem closes the remaining infinite
low-signature row.

**Theorem 5.1.**  Let \(P,Q,R\) be pairwise distinct primes and \(n\geq2\).
Every equation obtained by assigning the exponent multiset \((2,2,n)\) to
the three terms of

\[
                         P^u+Q^v=R^w                       \tag{5.1}
\]

has, up to swapping the inputs, exactly the following solutions:

\[
                  2^4+3^2=5^2,\qquad 2^2+11^2=5^3.         \tag{5.2}
\]

**Proof.**  If \(n\) is even, then the three exponents have common divisor
two.  Theorem 3.1 forces the first solution in (5.2), including \(n=4\).

Now suppose \(n\geq3\) is odd.  First let the output carry exponent \(n\),
so the equation is \(P^2+Q^2=R^n\).  If \(R=2\), the left side is two odd
squares and is congruent to \(2\pmod8\), whereas \(2^n\equiv0\pmod8\).
Thus \(R\) is odd, so exactly one square base is \(2\); write

\[
                             S^2+4=R^n.                    \tag{5.3}
\]

Here \(S,R,n\) are odd.  Theorem 1 of Arif--Abu Muriefah, specialized to
\(m=1\) in \(x^2+2^{2m}=y^n\), says that its unique solution in odd
\(x,y,n\) is \((x,y,n,m)=(11,5,3,1)\).  This gives the second solution
in (5.2).

It remains to put exponent two on the output.  Write
\(P^n+Q^2=R^2\).  The output base cannot be \(2\), since then the left
side is at least \(2^3+2^2>2^2\); hence \(R\) is odd
and parity forces exactly one of \(P,Q\) to be \(2\).  If \(Q=2\), then

\[
                         (R-2)(R+2)=P^n.                   \tag{5.4}
\]

The two positive odd factors are coprime.  Their product is a power of one
prime, so \(R-2=1\), and (5.4) becomes \(P^n=5\), impossible for
\(n\geq3\).

If \(P=2\), write

\[
                    (R-Q)(R+Q)=2^n,\qquad
                    R-Q=2^a,\quad R+Q=2^b                 \tag{5.5}
\]

with \(1\leq a<b\).  Since \(v_2(2Q)=1\), subtraction in (5.5) gives
\(a=1\).  Put \(k=b-1\).  Then

\[
                       Q=2^k-1,\qquad R=2^k+1.             \tag{5.6}
\]

If \(k\) is odd, \(3\mid R\); primality gives \(R=3\), whence \(k=1\)
and \(Q=1\), not a prime.  If \(k\) is even, \(3\mid Q\); primality gives
\(Q=3\), hence \(k=2\), \(R=5\), and \(n=a+b=4\), contradicting the
assumed oddness of \(n\).  This exhausts the parity positions and proves
the theorem.  \(\square\)

The cited theorem is essential only for (5.3).  The other orientations and
the entire even-\(n\) reduction are proved above.

## 6. The strongest unconditional gate obtained

Combining the preceding results gives the following exact statement.

**Corollary 6.1 (three-prime gate above the radical).**  Let (1.1) satisfy
\(\omega(abc)\leq3\) and \(c>R\).  Then the already classified
\(\omega(abc)\leq2\) cases aside, exactly one of the following occurs.

1. One input is \(1\), and the two consecutive nonunit endpoints have
   support split \((1,2)\) or \((2,1)\) as in (1.4).
2. Both inputs are nonunits and
   \[
                          p^x+q^y=r^z                      \tag{6.1}
   \]
   for distinct primes.  Moreover \(z>1\), not both \(x,y\) are one,
   \(\gcd(x,y,z)=1\), and either
   * exactly one of \(x,y\) is one; or
   * \(x,y,z\geq2\), in which case the exponent signature is
     \((2,2,3)\), \((2,3,4)\), \((2,3,5)\), or is hyperbolic
     \(\sigma(x,y,z)<1\).

In the \((2,2,3)\) case, the only solution is
\(2^2+11^2=5^3\), which indeed has \(125>110=R\).

**Proof.**  Theorem 1.1 gives the alternatives.  In (6.1), \(z=1\) would
give \(c=r\leq pqr=R\), and \(x=y=1\) would give
\(c=p+q\leq pq\leq pqr=R\).  The common-exponent exception of Theorem 3.1
also has \(c<R\).  Thus a remaining triple has exponent gcd one and the
stated linear/all-nonlinear division.

For the all-nonlinear division, Lemma 4.1 lists every nonhyperbolic
signature.  Theorem 3.1 removes \((3,3,3)\) and \((2,4,4)\), Proposition
4.2 removes \((2,3,3)\), Proposition 4.3 removes \((2,3,6)\), and Theorem
5.1 classifies \((2,2,n)\).  Its \(n=4\) solution has \(c<R\), while its
\(n=3\) solution has \(c>R\).  The two stated spherical signatures and all
hyperbolic signatures remain.  \(\square\)

The linear-exponent alternative is a real obstruction to a naive radical
bound.  For example,

\[
                 7+181^2=2^{15},\qquad
 \frac{c}{R}=\frac{32768}{2\cdot7\cdot181}>12.             \tag{6.2}
\]

This is not an abc counterexample; it only disproves the proposed extension
\(c\leq R\) from two-prime support to three-prime support.

## 7. Exact relation to Fermat--Catalan

Darmon--Granville Theorem 2 proves that for each *fixed* exponent signature
\((x,y,z)\) with \(\sigma<1\), the generalized Fermat equation with fixed
nonzero coefficients has only finitely many proper integer solutions.  Our
prime-base solutions are proper, so that theorem applies one signature at a
time.  Its constant and finite exceptional set may depend on the signature.
It does not prove finiteness after taking the union over all varying
signatures.

The Fermat--Catalan conjecture asserts finiteness of that union for coprime
integer powers and follows from abc.  The prime-base hyperbolic branch in
Corollary 6.1 is a restricted subproblem of Fermat--Catalan, not an equivalent
reformulation of the full conjecture.  It remains open under the inputs used
here.

For \(\sigma=1\), Darmon--Granville record that the only positive proper
unit-coefficient solution is \(3^2+1=2^3\); our Propositions give a direct
prime-base exclusion.  For \(\sigma>1\), their Section 7 gives genus-zero
parametrizations for proper integer solutions.  Requiring all three variables
to be primes is an additional arithmetic condition.  This note completely
handles \((2,2,n)\) and \((2,3,3)\), but does not classify the remaining
prime-base signatures \((2,3,4)\) and \((2,3,5)\).

Thus the smallest unresolved pieces exposed by this route are:

* the two semiprime unit branches in (1.4);
* the linear-exponent equations in Corollary 6.1;
* the two remaining spherical prime-base signatures;
* the uniform union of hyperbolic prime-base signatures.

No finite search can close any of these moving-support statements.

## 8. Primary-source audit

The following original or author-hosted sources were checked.

1. H. Darmon and A. Granville, *On the equations \(z^m=F(x,y)\) and
   \(Ax^p+By^q=Cz^r\)*, **Bull. London Math. Soc. 27** (1995), 513--543.
   Theorem 2 is on PDF page 3 / printed page 515.  The reciprocal-one
   discussion is on PDF pages 23--24 / printed pages 535--536, and the
   spherical cases begin on PDF page 24 / printed page 536.
   Author-hosted URL:
   `https://www.math.mcgill.ca/darmon/pub/Articles/Research/12.Granville/pub12.pdf`.
   Local archive:
   `research/sources/three_prime_support_2026_08_31/Darmon_Granville_1995_Generalized_Fermat.pdf`,
   2,334,147 bytes, SHA-256
   `2A77462524AEBDCE6A34C540E99AFB3913C2C6113B597AF9792BED6C82376ACA`.

2. S. A. Arif and F. S. Abu Muriefah, *On the Diophantine equation
   \(x^2+2^k=y^n\), II*, **Arab J. Math. Sci. 7(1)** (2001), 67--71.
   Theorem 1 is on PDF page 72 / printed page 68 of the journal-issue file;
   it states the odd \(x,y,n\) classification for
   \(x^2+2^{2m}=y^n\).  Journal PDF URL:
   `https://ajms.ksu.edu.sa/sites/ajms.ksu.edu.sa/files/imce_images/v7n2.pdf`.
   Local archive:
   `research/sources/three_prime_support_2026_08_31/Arif_AbuMuriefah_2001_x2_plus_2k_eq_yn_II.pdf`,
   11,187,074 bytes, SHA-256
   `88442C1218C200A537BB70ED44010139DA8987CF3294D7F42E3C4BF4030DE700`.
   The proof invokes the primitive-divisor work of Bilu--Hanrot--Voutier,
   later published as **J. reine angew. Math. 539** (2001), 75--122,
   DOI `10.1515/crll.2001.080`.

3. P. Mihăilescu, *Primary cyclotomic units and a proof of Catalan's
   conjecture*, **J. reine angew. Math. 572** (2004), 167--195,
   DOI `10.1515/crll.2004.048`.  Publisher metadata was checked; publisher
   access did not yield a local PDF, so no local file is claimed.

4. Fermat's Last Theorem is used only in Theorem 3.1.  The primary proof
   sources are A. Wiles, *Modular elliptic curves and Fermat's Last Theorem*,
   **Ann. of Math. 141** (1995), 443--551, DOI `10.2307/2118559`, and
   R. Taylor--A. Wiles, *Ring-theoretic properties of certain Hecke algebras*,
   ibid. 553--572, DOI `10.2307/2118560`.  The official Annals issue and
   article metadata were checked; no local PDF is claimed.

The Arif--Abu Muriefah result is stronger than the single specialization
used in Theorem 5.1.  This note does not inherit any unneeded assertion from
its broader final classification.

## 9. Formalization boundary

`Mathlib/NumberTheory/FLT/Basic.lean` defines the full Fermat statement but
does not prove it for all exponents.  Mathlib does prove the exponent-three
and exponent-four cases and contains a Pythagorean-triple parametrization.
It does not contain Mihăilescu's theorem or the Arif--Abu Muriefah
classification used in (5.3).

Consequently, declaring Theorems 3.1 or 5.1 in Lean without hypotheses would
either import an unavailable theorem or conceal it behind an axiom.  No such
declaration was created.  The companion
`Lean/IUTThreeClosures/ABCThreePrimeSignatures20260831.lean` proves the
elementary equation-level content of Propositions 4.2--4.3: all input orders
and output placements for the signatures `(2,3,3)` and `(2,3,6)`.  It does
not formalize the preceding support decomposition, Fermat's Last Theorem,
Mihăilescu's theorem, the Arif--Abu Muriefah classification, Theorem 3.1 or
Theorem 5.1.  These scope limits prevent the elementary companion from being
misread as a Lean proof of the strongest theorem in this report or of abc.
