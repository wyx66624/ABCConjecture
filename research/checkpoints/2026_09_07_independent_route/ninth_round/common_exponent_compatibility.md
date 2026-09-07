# CE1--CE4. Common pure exponents force progression support in the seed

Status: complete ordinary proof; both independent research peers and the
root researcher have completed full independent review with PASS. This note
does not change any frozen eighth-round file. No modularity, ABC,
uniform height theorem, or computational existence assertion is used.

Let a,b be positive coprime integers, c=a+b, and put

\[
 M=a^2+ab+b^2=c^2-ab,\qquad
 F=a^4+3a^3b+5a^2b^2+3ab^3+b^4.
\]

The actual norm identity is

\[
 F-M^2=ab c^2.                                      \tag{CE1}
\]

We investigate the simultaneous pure-power branch

\[
 M=R^p,\qquad F=Q^p,\qquad
 p\ge3\text{ an odd prime},\quad R,Q\in\mathbb Z_{>0}.
                                                        \tag{CE2}
\]

These are conditional statements about actual primitive seeds. We
do not assert the existence of such seeds, or infer their absence
from a finite search. The first norm's possible isolated factor 3
is not present in (CE2); `M=3 R^p` is a different branch.

## CE1. Cyclotomic allocation with its complete p-exception

Under (CE2), define

\[
 D=Q-R^2,\qquad
 S=\Phi_p(Q,R^2)=\sum_{j=0}^{p-1}Q^{p-1-j}R^{2j}.
\]

Then D is a positive integer and

\[
 DS=ab c^2,\qquad \gcd(Q,R)=1.                       \tag{CE3}
\]

For every prime q dividing S with q different from p, both Q and R
are q-units and

\[
 \operatorname{ord}_{\mathbb F_q^\times}(Q/R^2)=p,
 \qquad q\equiv1\pmod p.                            \tag{CE4}
\]

Moreover p divides S if and only if p divides D; in that case
v_p(S)=1. In particular the complete prime-power part of S supported
outside the progression `1 mod p` is either 1 or p.

Proof. Primitivity gives gcd(M,abc)=1: reducing M modulo a or b
gives the square of the other coprime coordinate, and modulo c gives
a^2. Hence (CE1) implies gcd(M,F)=1, and therefore gcd(Q,R)=1.
Since F>M^2, the positive p-th roots satisfy Q>R^2. Factoring
Q^p-R^{2p} proves (CE3).

If q divides Q or R, only one extreme term of S is nonzero modulo
q, so q cannot divide S. Thus t=Q/R^2 is a unit modulo q. Equation
`(t-1)(1+t+...+t^(p-1))=t^p-1` gives t^p=1. If t=1 then the sum
is p, contradicting q different from p. The order is exactly p,
proving (CE4).

In characteristic p, `S=(Q-R^2)^(p-1)`. Consequently p divides S
exactly when p divides D, including the cases where Q or R is
divisible by p. If p divides D then Q,R are p-units. Write
Q=R^2+D and expand

\[
 S=pR^{2p-2}+\binom p2 R^{2p-4}D+\cdots+D^{p-1}.
\]

All terms after the first are divisible by p^2: intermediate
binomial coefficients have a factor p and D has a factor p, while
p-1>=2 for the final term. The first term has valuation exactly
one, so v_p(S)=1. This proves the complete exceptional-prime claim.

## CE2. Exact allocation of the bad prime-power mass

For a positive integer n, define its full part outside `1 mod p` by

\[
 n_{\mathrm{bad},p}
 =\prod_{q\text{ prime},\ q\not\equiv1\bmod p}q^{v_q(n)},
 \qquad n_{\mathrm{good},p}=n/n_{\mathrm{bad},p}.
\]

Put U=(ab c^2)_bad,p. Then

\[
 U\mid pD,
 \quad
 a_{\mathrm{bad},p}b_{\mathrm{bad},p}
 c_{\mathrm{bad},p}^{\,2}=U.                        \tag{CE5}
\]

If the exponent prime p is itself omitted as well, the resulting
part of ab c^2 divides D, with no extra factor p. These are
divisibility statements about full valuations, rather than radicals.

Proof. For q outside `1 mod p` and q different from p, CE1 gives
v_q(S)=0. Therefore v_q(ab c^2)=v_q(D). At p, CE1 gives
v_p(ab c^2)<=v_p(D)+1. Combining these inequalities prime by prime
proves U|pD. The second equality is just additivity of valuations.
No assertion that D is supported only on bad primes is needed.

## CE3. Quantitative seed support and an elementary height bound

Every representation (CE2) satisfies

\[
 1\le D\le\frac{4R^2}{9p},\qquad
 U\le\frac49 R^2.                                  \tag{CE6}
\]

Consequently

\[
 c_{\mathrm{bad},p}\le\frac23R
 <\frac23 c^{2/p},\qquad
 c_{\mathrm{good},p}>\frac32c^{1-2/p}.               \tag{CE7}
\]

In particular at least one actual prime divisor q of c is congruent
to 1 modulo p, and any such prime has q>=2p+1. The exact quantitative
mass statement is

\[
 \sum_{q\mid c,\ q\equiv1\bmod p}v_q(c)\log q
 >\left(1-\frac2p\right)\log c+\log\frac32.         \tag{CE8}
\]

The total complementary weighted mass satisfies

\[
 \sum_{q\not\equiv1\bmod p}
  \bigl(v_q(a)+v_q(b)+2v_q(c)\bigr)\log q
 \le \frac2p\log M+\log\frac49
 <\frac4p\log c+\log\frac49.                       \tag{CE9}
\]

There is also a height restriction valid without a modular input:

\[
 R^2\ge\frac{9p}{4},\qquad
 \log c>\frac p4\log\frac{9p}{4}.                  \tag{CE10}
\]

Proof. Because Q>R^2, each term of S is at least R^(2p-2), so
S>=pR^(2p-2). Set t=ab/c^2, which lies in (0,1/4]. Then

\[
 \frac{ab c^2}{M^2}=\frac{t}{(1-t)^2}\le\frac49.
\]

One direct proof of the last inequality is
`4(1-t)^2-9t=(1-4t)(4-t)>=0`. An equivalent integral certificate is

\[
 4M^2-9ab(a+b)^2
 =(a-b)^2(4a^2+7ab+4b^2)\ge0.                       \tag{CE12}
\]

Since M^2=R^(2p), (CE3) gives

\[
 D=\frac{ab c^2}{S}
 \le\frac{ab c^2}{pR^{2p-2}}
 \le\frac{4R^2}{9p}.
\]

CE2 now gives (CE6). In particular c_bad,p^2 divides U and is at
most U, yielding c_bad,p<=2R/3. The strict inequality R<c^(2/p)
follows from M<c^2. This proves (CE7), and taking logarithms proves
(CE8)--(CE9). The lower bound in (CE7) exceeds 1, so the good part
has a prime divisor. A prime congruent to 1 modulo the odd prime p
has the form kp+1 with positive even k, hence is at least 2p+1.
Finally D>=1 in (CE6) gives R^2>=9p/4. Raising to p and using
M<c^2 gives (CE10).

## CE4. Shared divisors of unequal pure exponents

Suppose instead M=A^h and F=B^g for positive integers A,B and
h,g>=2. Every odd prime p dividing gcd(h,g) gives an instance of
CE1--CE3 by setting R=A^(h/p), Q=B^(g/p). Thus all displayed
progression and height restrictions hold separately for each such p.
There is no claim that p equals h or g.

For a sequence of such seeds and chosen common prime divisors
p_j tending to infinity, (CE8) implies

\[
 \frac{\sum_{q\mid c_j,\ q\equiv1\bmod p_j}
       v_q(c_j)\log q}{\log c_j}\longrightarrow1.    \tag{CE11}
\]

Indeed the ratio is at most 1 and greater than 1-2/p_j. Equation
(CE10) simultaneously forces c_j to infinity. This is a uniform
moving-progression valuation-mass statement on the actual seed;
it is not a density assertion about arbitrary primes.

## Scope and the next compatibility question

This theorem uses the actual two-norm identity and makes the seed
denominator c carry a large amount of prime-power mass in a narrow
progression. It does not bound the size of those primes, their
valuations, or their total radical from below sharply enough for
ABC. No uniform upper bound on point height has been obtained.

The common-prime-divisor condition is essential to the displayed
cyclotomic factorization. Relatively prime exponents remain open.
The first norm `3 A^h`, nonunit residuals, and moving Kummer classes
remain open as well: replacing R^p by 3R^p changes the difference
to Q^p-9R^(2p), so it is not this homogeneous cyclotomic identity.
Failure to fit CE2 is not a counterexample to those other routes.

For fixed p the earlier fixed-exponent finiteness theorem remains
available. CE3 supplies a separate explicit inequality as p varies;
it does not convert fixed-p finiteness into uniform finiteness.
