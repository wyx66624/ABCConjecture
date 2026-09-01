# Reproducible targeted counterexample search: balancing and Danilov families

**Date:** 2026-08-31  
**Scope:** finite exact computation only.  No finite non-hit is used to close a route.

## 1. Result at the permitted level of certainty

No nontrivial squarefull term was found in either certified finite range.

* For the balancing recurrence
  \(u_0=0,u_1=1,u_{n+2}=6u_{n+1}-u_n\), every one of the 999 terms
  \(u_n\), \(2\le n\le1000\), has an explicit prime \(p\) with
  \(p\mid u_n\) and \(p^2\nmid u_n\).  This includes all 168 prime indices
  in that interval.  The value \(u_1=1\) is the sole trivial positive
  squarefull value, with the usual vacuous convention.
* The exploratory balancing search continued through \(n=2000\).  It found
  verified exponent-one certificates for 1990 of the 1999 nonunit terms.
  The nine indices
  \[
  1009,1181,1667,1699,1723,1847,1873,1901,1951
  \]
  remain computationally unresolved here.  They are neither hits nor
  certified non-hits.
* For the forward Danilov orbit generated from \((z_0,w_0)=(682,305)\), all
  81 points with \(0\le t\le80\) have an explicit prime \(p\) with
  \(v_p(K_t)=1\).  Thus none of those 81 remainders is squarefull.  The
  largest checked \(K_t\) has 1006 decimal digits.

These statements do not prove eventual non-squarefullness, do not exclude a
later or different squarefull subsequence, and do not disprove either active
counterexample route.

## 2. Balancing search and certificates

For a proposed certificate \((n,p)\), the verifier recomputes the recurrence
modulo \(p^2\).  A residue
\[
u_n\equiv p q\pmod{p^2},\qquad 1\le q<p,
\]
proves exactly \(v_p(u_n)=1\), and therefore proves that \(u_n\) is not
squarefull.  The complete list for \(2\le n\le1000\) is in
`balancing_certificates_2_1000.csv`; the 1990 certified terms in the larger
exploratory range are in `balancing_certificates_resolved_2_2000.csv`.

The candidate search used three layers.

1. A sieve of all primes \(p\le200000\) ran the recurrence modulo \(p^2\).
2. At an unresolved prime index \(\ell\), a prime divisor of \(u_\ell\) has
   rank \(\ell\), so it must satisfy
   \(p\equiv\pm1\pmod{2\ell}\), with the sign compatible with
   \((32/p)\).  Searching these classes up to \(5\cdot10^8\) supplied the
   next layer.  A deeper bounded pass over
   \(5\cdot10^8<p\le5\cdot10^{10}\) supplied six further certificates in
   the exploratory range.
3. FactorDB was used only to discover candidates for the remaining terms;
   every accepted candidate was then checked locally modulo \(p^2\).  All
   accepted primes below \(2^{64}\) were rechecked with the deterministic
   seven-base Miller--Rabin criterion.  The two larger accepted primes,
   \(13558774610046711780701\) and \(27633725151978798737\), have locally
   checked Pocklington certificates in `pocklington_certificates.json`.
   Therefore the final exponent-one certificates do not depend on trusting
   a database primality label.

Some representative certificates are

| index | exponent-one prime |
|---:|---:|
| 7 | 239 |
| 29 | 44560482149 |
| 59 | 13558774610046711780701 |
| 937 | 27633725151978798737 |
| 1879 | 19351103221 |

The only composite index left by the first extended pass was
\(1711=29\cdot59\).  Reusing the index-29 prime \(p=44560482149\) and
recomputing directly gives
\[
u_{1711}\equiv870900556757118232308
=p\cdot19544235492\not\equiv0\pmod{p^2},
\]
so this index is also certified without a complete factorization.

The first 25 nonunit terms, \(2\le n\le26\), were completely factored
locally; every factor and product is independently verified in
`balancing_complete_factorizations_2_26.json`.  Beyond that range the search
usually stops after a decisive exponent-one prime and does not claim a
complete factorization.  For example,
\[
u_7=40391=13^2\cdot239,
\]
so the squared primitive divisor 13 does not make the term squarefull: 239
is an exponent-one obstruction.

## 3. Danilov formula, unit step, and primitivity

The script first checks the polynomial identity coefficient by coefficient:
\[
(z^2+6z+4)^3-(z^2+1)(z^2+9z+19)^2=-27(2z+11).
\]
Let
\[
\varepsilon=9+4\sqrt5,\qquad N(\varepsilon)=1.
\]
Exact multiplication modulo 125 gives full ring order 250.  Starting from
\((682,305)\), the first positive power returning the congruence
\(z\equiv57\pmod{125}\) is the tenth.  Explicitly,
\[
\eta=\varepsilon^{10}
=1730726404001+774004377960\sqrt5
\equiv1+85\sqrt5\pmod{125}.
\]
The exhaustive residues for powers 1 through 10 are saved in
`danilov_unit_residues_1_10.csv`.  If \(z\equiv57\pmod{125}\) and
\(z^2-5w^2=-1\), then \(5\mid w\).  Hence multiplication by \(\eta\) gives
\[
z'\equiv z+5\cdot85w\equiv z\pmod{125},
\]
so this least step can be iterated.  Exact norm multiplication preserves
\(z^2-5w^2=-1\), and positivity is clear.

For every generated point put
\[
A=z^2+6z+4,\quad B=z^2+9z+19,\quad L=2z+11,
\]
\[
X=A/5,\qquad Y=wB/5,\qquad K=27L/125.
\]
The congruence gives \(125\mid L\), \(v_5(A)=1\), and \(5\mid w\), so these
are integers and the polynomial identity becomes
\[
X^3+K=Y^2.
\]

The primitivity argument was checked both symbolically and pointwise.
Because
\(B-A=3(z+5)\), \(A\equiv-1\pmod{z+5}\), and
\(A\equiv z^2+1\not\equiv0\pmod3\), one has \(\gcd(A,B)=1\).  If a prime
divides both \(A\) and \(w\), the Pell equation and
\(A\equiv3(2z+1)\) modulo that prime force it to be 5.  Since
\(v_5(A)=1\), \(\gcd(A,wB)=5\), and therefore \(\gcd(X,Y)=1\).  The Hall
identity then gives \(\gcd(X,K)=\gcd(Y,K)=1\).

Finally,
\[
K^2\le X
\quad\Longleftrightarrow\quad
3125A-729L^2=209z^2-13326z-75709\ge0.
\]
At \(z=682\) the right side is 88046875, and its derivative is positive for
all \(z\ge682\).  Thus the inequality holds throughout this forward orbit.
All 81 exact identities, gcds, and inequalities are recomputed in
`danilov_points_0_80.csv`.

For each checked point the exponent-one prime lies in
\(\{7,11,13,41,89\}\), never in \(\{3,5\}\).  Therefore
\(v_p(K)=v_p(L)=1\).  The first four remainders were also completely factored
locally; see `danilov_complete_factorizations_0_3.json`.  They begin with
\[
K_0=297=3^3\cdot11,
\]
and
\[
K_1=1019827620252441
=3^4\cdot7\cdot11\cdot13\cdot41\cdot2161\cdot141961.
\]

There is a concrete guard against extrapolation.  Modulo the squares of the
five certificate primes, the orbit is periodic, but their combined sieve
first fails to certify index \(t=326\).  The exact periods and covered residue
classes are in `danilov_small_prime_periods.json`.  Thus even the striking
coverage of the first 81 points supplies no all-index theorem.

## 4. What is and is not completely factored

| family/range | complete factorization? | decisive local check |
|---|---|---|
| balancing \(2\le n\le26\) | yes, locally | full product and deterministic primality |
| balancing \(27\le n\le1000\) | generally no | one proved exponent-one prime for every term |
| balancing \(1001\le n\le2000\) | generally no | 991 proved non-squarefull; nine unresolved |
| Danilov \(0\le t\le3\) | yes, locally | full product and deterministic primality |
| Danilov \(4\le t\le80\) | no | one proved exponent-one prime for every point |

Finite failure to find a squarefull term is not evidence that the infinite
route is false.  A route-level negative conclusion would require an
all-index valuation-one theorem or an actual structural contradiction, none
of which is supplied by this computation.
