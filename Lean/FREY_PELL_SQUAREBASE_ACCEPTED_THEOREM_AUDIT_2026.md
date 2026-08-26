# Accepted theorems versus the Pell square-base bottleneck: a 2020--2026 delta audit

## Abstract

Let

\[
 s_n+r_n\sqrt 3=(7+4\sqrt 3)^n,
 \qquad c_n=s_n^2-2=3r_n^2-1,
\]

and write uniquely

\[
 c_n=A_ny_n^2,
 \qquad A_n>0\text{ squarefree}.
\]

With

\[
 \lambda=97+56\sqrt3,
 \qquad H_n=n\log\lambda,
\]

one has \(\log c_n=H_n+O(1)\).  The remaining coefficient problem is

\[
 \log y_n=o(H_n),                                \tag{0.1}
\]

or equivalently

\[
 \log A_n\ge (1-o(1))H_n.                       \tag{0.2}
\]

This note is a delta audit of accepted results, especially those published
from 2020 through 26 August 2026, which might appear to control the powerful
part, square divisors, primitive divisors, or repeated prime factors of a
linear recurrence.  No accepted unconditional theorem found in this audit
proves (0.1).  The closest recent inputs still concern one of four different
objects:

1. the ordinary radical or the greatest prime factor;
2. exact squares, exact prime powers, or prime-times-square values;
3. a gcd of two independent polynomial values; or
4. the global abundance of non-Wieferich primes for a fixed base.

None controls the complete parity vector of the prime valuations of the
single shifted Pell value \(c_n\), at every index \(n\).

The 2025 Lucas-atom valuation theorem identifies the local obstruction very
cleanly.  Although

\[
 c_n=P_4(s_n,-1)
\]

is a Lucas atom, its Lucas parameters move with \(n\).  Every odd
\(p\mid c_n\) has rank of appearance \(4\) in that moving Lucas sequence, and
the theorem's first-appearance clause reads only

\[
 v_p(P_4)=v_p(U_4).
\]

This is an identity, not an upper bound.  The theorem gives valuation one at
later atoms of index \(4p^h\), but the Pell problem is precisely the
uncontrolled first atom.

The other sharp boundary is Fellini--Murty (Journal of Number Theory, August
2026).  Their infinitude theorem for non-Wieferich prime ideals assumes
Masser's number-field \(abc\) conjecture; their unconditional alternative is
conditional on the still unproved finiteness of base-\(\alpha\)
super-Wieferich primes.  Their quantitative theorem has the same disjunction.
Thus it is neither an unconditional input nor, even under its hypothesis, a
pointwise greatest-square-divisor theorem.

The exact surviving minimum must therefore remain a parity-core / greatest
square divisor statement.  Replacing it by a lower bound for the ordinary
radical changes the mathematical problem.

## 1. Exact target and invariant discipline

For a positive integer

\[
 m=\prod_p p^{e_p},
\]

define

\[
 \operatorname{rad}(m)=\prod_{e_p>0}p,
 \qquad
 \operatorname{core}_2(m)=\prod_{e_p\text{ odd}}p,          \tag{1.1}
\]

and

\[
 \operatorname{gsd}(m)=\prod_p p^{2\lfloor e_p/2\rfloor}.  \tag{1.2}
\]

Then

\[
 A_n=\operatorname{core}_2(c_n),
 \qquad
 \operatorname{gsd}(c_n)=y_n^2,                            \tag{1.3}
\]

and the exact logarithmic ledger is

\[
 \log c_n=\log A_n+2\log y_n.                              \tag{1.4}
\]

Consequently the clean, quantified version of the missing theorem is

\[
 \boxed{
 \forall\epsilon>0\ \exists C_\epsilon\ \forall n\ge1:
 \quad 2\log y_n\le\epsilon H_n+C_\epsilon .}              \tag{1.5}
\]

Using \(|\log c_n-H_n|\le B\), (1.5) implies

\[
 \log A_n\ge(1-\epsilon)H_n-(B+C_\epsilon),                \tag{1.6}
\]

and a bound of the form (1.6) conversely implies (1.5), with a
change of the additive constant.  Thus (1.5), the subexponential greatest
square divisor estimate

\[
 \operatorname{gsd}(c_n)=c_n^{o(1)},                       \tag{1.7}
\]

and coefficient-one growth of the parity core are the same target.

They are not *equivalent* to radical statements.  There is, however, one
useful one-way bridge which fixes the exact coefficient needed.  From
\(c_n=A_ny_n^2\),

\[
 \operatorname{rad}(c_n)
 \le A_n\operatorname{rad}(y_n)\le A_ny_n,                  \tag{1.8}
\]

and hence

\[
 \log y_n
 \le \log c_n-\log\operatorname{rad}(c_n).                 \tag{1.9}
\]

Therefore a genuinely coefficient-one pointwise radical theorem

\[
 \log\operatorname{rad}(c_n)\ge(1-o(1))H_n                 \tag{1.10}
\]

would be a sufficient, stronger route to (1.5).  No accepted theorem found
here has this scale: Stewart's logarithmic radical bound is \(o(H_n)\).
An ordinary lower bound with coefficient zero cannot be substituted for the
parity core.

For example, if \(z\) is any growing odd
squarefree integer and

\[
 m_z=2z^2,
\]

then

\[
 \operatorname{core}_2(m_z)=2,
 \qquad \operatorname{gsd}(m_z)=z^2,
 \qquad \operatorname{rad}(m_z)=2z.                        \tag{1.11}
\]

The radical tends to infinity while the parity core stays fixed and the
square divisor carries asymptotically the whole logarithmic height.  In
particular, a subexponential-in-index radical lower bound cannot be inserted
into (1.4) in place of \(\log A_n\).

### 1.1 An exact Pell square-factor certificate

The multiplicity issue occurs in the actual family, not only in model
integers.  Iterating

\[
 (s,r)\longmapsto(7s+12r,\,4s+7r)                           \tag{1.12}
\]

from \((1,0)\), with every operation reduced modulo \(23^3=12167\), gives

\[
 (s_{57},r_{57})\equiv(1960,10682)\pmod{12167}.              \tag{1.13}
\]

Consequently

\[
 c_{57}=s_{57}^2-2
 \equiv8993=17\cdot23^2\pmod{23^3},                         \tag{1.14}
\]

and therefore

\[
 v_{23}(c_{57})=2.                                          \tag{1.15}
\]

This is a finite exact modular certificate, independently reproducible in
PARI/GP or any integer CAS.  Thus \(23\mid y_{57}\), while \(23\nmid A_{57}\):
the ordinary radical counts a prime which the parity core deletes.  No
claim about the factorization of the cofactor is needed.

## 2. Audit protocol

For each theorem below, four quantifiers are kept separate.

* **Fixed data:** recurrence, polynomial, prime set, base, or coefficient
  fixed before a constant is chosen.
* **Index quantifier:** all sufficiently large indices, a density-one set,
  an infinite subsequence, or merely existence of infinitely many primes.
* **Measured invariant:** support, largest prime, exact-power status, a
  two-value gcd, or valuation parity.
* **Uniformity:** whether constants remain controlled when the squarefree
  coefficient or support moves.

An effective constant depending on a fixed multiplier \(A\) is not a uniform
bound in terms of \(\log A\).  A density-one conclusion is not a pointwise
conclusion.  A theorem about \(\operatorname{rad}(c_n)\) is not a theorem
about \(\operatorname{core}_2(c_n)\).  These are logical distinctions, not
questions of numerical sharpness.

The older Stewart radical theorem, Bilu--Hanrot--Voutier primitive-divisor
theorem, fixed-\(S\) results, and conditional Ribenboim--Walsh powerful-part
results are already treated in the repository's squareclass and
squarefull/primitive-divisor audits.  They are used here only as baselines;
the purpose of this note is to record genuinely newer literature and exact
conditional boundaries.

In particular, the detailed no-go proofs for the same-spectrum model,
large-prime cutoff, first-hit Kummer sieve, and Pasten's truncated-counting
scale remain in `FREY_PELL_SQUARECLASS_RECURRENCE_AUDIT.md`,
`FREY_PELL_SQUAREFULL_PRIMITIVE_DIVISOR_AUDIT.md`,
`FREY_PELL_FIRST_HIT_KUMMER_SIEVE_AUDIT.md`, and
`FREY_PELL_FOUR_POINT_TRUNCATED_BRIDGE.md`; they are not duplicated here.

## 3. Accepted recurrence results, theorem by theorem

### 3.1 Stewart 2023: greatest prime factors

Let \((u_n)\) be a nondegenerate binary recurrence in Stewart's notation.
His 2023 Theorem 1 first assumes that the two fixed quotients \(a/b\) and
\(\alpha/\beta\) are multiplicatively dependent.  It then asserts that
there is an effectively computable \(C=C(a,b,\alpha,\beta)>0\) such that
for every \(n>C\),

\[
 P(u_n)>n\exp\!\left({\log n\over104\log\log n}\right).     \tag{3.1}
\]

Theorem 2 removes the multiplicative-dependence hypothesis but weakens the
index quantifier: (3.1) holds for every positive \(n\), except possibly a
set of asymptotic density zero.

Neither theorem reaches the present target:

1. \(c_n\) has the minimal reciprocal cubic
   \((T-1)(T^2-194T+1)\), not a binary characteristic polynomial;
2. \(\log P(u_n)=O(\log n+\log n/\log\log n)=o(H_n)\); and
3. one support prime gives no information about whether its exponent in the
   target value is odd.

The density-zero exception in Theorem 2 is independently fatal to an
all-index abc construction.

### 3.2 Odjoumani--Ziegler 2021: exact prime-power terms

For a fixed linear recurrence satisfying their technical hypotheses,
Odjoumani and Ziegler study the exact equation

\[
 U_n=p^x.                                                   \tag{3.2}
\]

Their main result has the order of quantifiers

\[
 \exists\text{ an effectively computable finite prime set }E_U\quad
 \forall p\notin E_U:\quad
 \#\{(n,x):U_n=p^x,\ x>0\}\le1.                           \tag{3.3}
\]

This is a rigidity theorem for an exponent vector supported at one prime.
The factorization \(c_n=A_ny_n^2\) normally has many support primes and is
not the equation (3.2).  Even a theorem excluding every exact prime power
would allow \(p^{2e}q\), or a product of many high even powers, and therefore
would not bound \(y_n\).

### 3.3 Tzanakis--Voutier 2024: near-squares in one binary family

Fix \(a\ge3\) and the binary recurrence

\[
 u_0(a)=0,\quad u_1(a)=1,\quad
 u_{N+2}(a)=a u_{N+1}(a)-u_N(a).                           \tag{3.4}
\]

Writing \(\mathsf S\) for the set of squares, Theorem 2.2 says that, for
\(N\ge5\) and prime \(p\),

\[
 u_N(a)\in p\mathsf S                                    \tag{3.5}
\]

can hold only when \(p\ge5\), \(a\equiv2\pmod4\), and either
\((a,N,p)=(6,7,239)\), or \(N\ge19\) is prime with
\(N\equiv3\pmod4\).  Moreover, after a particular
\(a\equiv2\pmod4\) is fixed, there is at most one pair \((N,p)\)
satisfying (3.5).  The theorem's final complete-classification clause is
explicitly conditional on their Conjecture 2.1 and is not used here.

This is a genuine accepted theorem about a parity core consisting of one
prime.  It nevertheless does not imply (1.5):

* \(c_n\) is a shifted order-three recurrence, not (3.4);
* excluding cores with zero or one prime factor gives no lower bound for the
  numerical size of a core with two or more prime factors; and
* the theorem is a classification of exact membership in \(p\mathsf S\),
  not a bound for the full greatest square divisor.

This is the closest recent accepted result in *terminology*, but not in the
required quantitative conclusion.

### 3.4 Voutier 2024--2026: number of exact squares

Voutier's 2024 Theorem 1.4 fixes the parameters of the binary family defined
in that paper.  In its notation it assumes \(b=1\), positive integers
\(a,d\), nonsquare \(d\), \(N_\alpha<0\), and square \(-N_\alpha\).  In
each of two explicitly listed exceptional parameter configurations it gives
at most three distinct square values among the \(y_k\); in every other case
it gives at most two.  The published series continued in 2026 with further
sharp square-count results for related fixed binary families.

The outer quantifier is therefore: **fix the binary recurrence first**, then
count indices at which the whole term is a square.  This says only that the
parity core is \(1\) at few indices.  It neither applies to the shifted cubic
\(c_n\) nor bounds the size of a nontrivial moving parity core.

### 3.5 Bérczes--Hajdu--Ostafe--Shparlinski 2025

For a fixed simple nondegenerate recurrence \(\mathbf u\) of order
\(d\ge2\), let \(\mathsf M_s^*(M,N)\) count ordered \(s\)-tuples of
indices in \([M+1,M+N]\) whose corresponding terms are multiplicatively
dependent of maximal rank.  Their Theorem 1.1 says that, for every fixed
\(s\ge1\), uniformly in \(M\ge0\),

\[
 \mathsf M_s^*(M,N)
 \le N^{s(1-1/(4d-3))+o(1)}.                              \tag{3.6}
\]

If the recurrence also has a dominant root and

\[
 M\ge\exp\!\left(N{\log_3N\over\log_2N}\right),           \tag{3.7}
\]

Theorem 1.3 improves (3.6) to

\[
 \mathsf M_s^*(M,N)\le N^{s-1+o(1)}.                      \tag{3.8}
\]

For the recurrences in their theorem having a dominant root, their
Theorem 1.5 gives, uniformly over \(M\ge0\),

\[
 \mathsf M_2^*(M,N)=N+O(1).                               \tag{3.9}
\]

The square-free-factor input is their Lemma 2.1, inherited from Stewart.
For a fixed simple nondegenerate dominant-root recurrence there are effective
constants \(C_1,C_2\), depending only on that recurrence, such that for
every \(n\ge C_2\),

\[
 \operatorname{rad}(u_n)
 >n^{C_1\log_2n/\log_3n}.                                 \tag{3.10}
\]

The paper explicitly defines \(\operatorname{rad}(m)\) as the largest
squarefree divisor, i.e. the product of all distinct support primes.  The
new conclusions (3.6)--(3.9) count multiplicative relations among several
terms; they do not replace (3.10) by a parity-core estimate for one term.
For \(c_n\), the logarithm of the right side of (3.10) is still \(o(H_n)\),
and (1.11) prevents its reinterpretation as \(A_n\).

### 3.6 Alecci--Miska--Murru--Romeo 2025: Lucas-atom valuations

Fix once and for all integers \(s,t\), the associated first-kind Lucas
sequence \(U_j(s,t)\), and its Lucas atoms \(P_j(s,t)\).  Let \(p\ge3\)
be a prime for which the rank of appearance \(k=\rho(p,U)\) is defined, and
assume \(p\nmid t\).  Their Theorem 14 states, for every atom index
\(j\ge1\),

\[
 v_p(P_j)=
 \begin{cases}
  v_p(U_k),&j=k,\\
  1,&j=kp^h\quad(h\ge1),\\
  0,&\text{otherwise}.
 \end{cases}                                               \tag{3.11}
\]

The paper also gives the corresponding exact formulae at \(p=2\) and when
\(p\mid s,t\).  These are fixed-parameter, prime-by-prime formulae.

There is an exact contact with the present target:

\[
 P_4(s,t)=s^2+2t,
 \qquad c_n=P_4(s_n,-1).                                  \tag{3.12}
\]

But the contact exposes, rather than removes, the obstruction.  If an odd
prime \(p\mid c_n\), then modulo \(p\)

\[
 U_1=1,\quad U_2=s_n\ne0,\quad
 U_3=s_n^2-1\equiv1,\quad U_4=s_nc_n\equiv0.               \tag{3.13}
\]

Hence \(\rho(p,U(s_n,-1))=4\), and the first line of (3.11) gives

\[
 v_p(P_4(s_n,-1))=v_p(U_4(s_n,-1))=v_p(c_n).               \tag{3.14}
\]

The last equality uses \(p\nmid s_n\).  Thus (3.11) leaves the entire
first-hit depth unchanged.  The useful valuation-one clause applies to the
later atom indices \(4p^h\) **inside the Lucas sequence whose parameter is
the already chosen value \(s_n\)**.  The next Pell target \(c_{n+1}\) uses
a different Lucas parameter and is not that later atom.  Summing (3.14)
over the moving primes is exactly the unsolved square-base problem.

### 3.7 Grieve--Wang 2020: gcds with moving targets

Grieve--Wang Theorem 1.2 fixes a number field \(K\), a finite set of places
\(S\), and maps \(u_1,\ldots,u_r:\Lambda\to\mathcal O_{K,S}^*\).  It
allows coprime moving polynomials \(f_\alpha,g_\alpha\) of fixed positive
degrees whose coefficient heights are

\[
 o\!\left(\max_i h(u_i(\alpha))\right).                     \tag{3.15}
\]

For each \(\epsilon>0\), it concludes either:

1. on an infinite subset \(A\subseteq\Lambda\),
   \[
   \log\gcd(f_\alpha(u(\alpha)),g_\alpha(u(\alpha)))
   <\epsilon\max_i h(u_i(\alpha));                          \tag{3.16}
   \]
   or
2. all the points lie in a finite union of moving translates of proper
   algebraic subgroups, with translation height negligible on the same
   scale.

Their Theorem 1.7 specializes the philosophy to two algebraic linear
recurrences \(F(m),G(n)\): if

\[
 \log\gcd(F(m),G(n))>\epsilon\max\{m,n\}                   \tag{3.17}
\]

holds infinitely often, then at equal indices the recurrences have a common
factor in the recurrence ring; at unequal indices they are not separated
and the exceptional pairs obey one of finitely many asymptotically linear
relations.

Both the input and output concern a gcd of **two values**.  A high power
dividing a single simple polynomial value is not a gcd with its derivative.
The elementary example

\[
 F(X)=X-1,\qquad x=1+p^e                              \tag{3.18}
\]

has \(p^e\mid F(x)\) and \(F'(x)=1\).  Hensel simplicity makes the lift
unique; it does not make the lift shallow.  The Pell target supplies one of
four mutually exclusive simple toric target congruences at a good prime, not
two independent vanishings.  Therefore (3.16)--(3.17) do not measure its
greatest square divisor.

### 3.8 Xiao 2024: gcds at almost units

Xiao's Theorem 1.3 fixes a number field, nonconstant coprime polynomials
\(f,g\in K[x_1,\ldots,x_r]\) not both vanishing at the origin, a finite
place set \(S\), and \(\epsilon>0\).  It asserts the existence of
\(\delta>0\) and a proper Zariski-closed
\(Z\subset\mathbf G_m^r\) such that

\[
 \log\gcd(f(u),g(u))
 <\epsilon\max_i h(u_i)                                     \tag{3.19}
\]

for every \(S\)-almost-unit point
\(u\in\mathbf G_m^r(K)_{S,\delta}\setminus Z\).  The explicit refinement,
Theorem 1.4, gives a constant
\(6(\deg f+\deg g)r^2\) times \(\delta^{1/2}\sum_i h(u_i)\), again outside
a proper closed set.

These are strong unconditional Subspace-Theorem consequences, but the
coprime two-polynomial hypothesis is the source of the truncation.  Taking
\(g=f'\) detects multiple roots of the polynomial modulo \(p\), not a deep
hit on a simple root as in (3.18).  Taking a second shifted Pell target
controls common support between two indices and misses an isolated first
hit.  No specialization of (3.19) yields
\(\sum_p\lfloor v_p(c_n)/2\rfloor\log p=o(H_n)\).

### 3.9 Other accepted support theorems do not change parity

Järviniemi's 2023 theorem assumes GRH, fixes a degree-\(d\ge3\) polynomial
with Galois group \(S_d\), and proves positive lower density for the set of
primes dividing at least one term of a recurrence having that characteristic
polynomial.  The Pell companion polynomial is reducible, and in any event a
global union over all indices contains neither an all-index statement nor
valuation parity.

The 2022 Bilu--Hong--Gun uniform explicit Stewart theorem supplies a strong
prime-by-prime valuation bound for a fixed target.  The repository's
large-prime audit already applies it to the four Pell targets and obtains an
\(o(H_n)\) contribution only below an explicit moving cutoff.  Its unresolved
large-prime first-hit tail is exactly the tail in (1.5), so that theorem is
not silently stronger when recast in square-base language.

## 4. Fixed \(S\), moving \(S_n\), and why Subspace results stop

Bugeaud--Evertse Theorem 1.1 first fixes a nondegenerate integer recurrence
\((u_n)\), a finite nonempty prime set \(S\), and \(\epsilon>0\).  For all
sufficiently large \(n\), it gives

\[
 |u_n|^{\delta-\epsilon}\le [u_n]_S
 \le |u_n|^{\delta+\epsilon},                              \tag{4.1}
\]

where \(\delta\) is fixed by the \(S\)-adic sizes of the characteristic
roots.  In particular, when the primes in \(S\) are coprime to all recurrence
coefficients, \(\delta=0\) and

\[
 [u_n]_S\le |u_n|^\epsilon.                                \tag{4.2}
\]

The exceptional threshold in this strongest exponent-\(\epsilon\) statement
is ineffective.  Their effective Theorem 1.2 assumes a dominant root and,
after the recurrence and \(S\) are fixed, produces computable
\(c_1,c_2>0\), both allowed to depend on \(S\), such that

\[
 [u_n]_S\le |u_n|^{1-c_1}\qquad(n\ge c_2).                 \tag{4.3}
\]

For binary recurrences Theorem 1.3 makes \(c_1\) independent of \(S\), but
the effective threshold \(c_2\) still depends on \(S\).  Thus every version
first chooses a finite prime set.  In the present problem the relevant set
would be

\[
 S_n=\{p:v_p(c_n)\ge2\},                                    \tag{4.4}
\]

which changes with the term being estimated.  Substituting \(S=S_n\) into a
constant or threshold already allowed to depend on \(S\) is a quantifier
error.

Likewise, the Subspace Theorem controls common smallness of several linear
forms, or a gcd of coprime target values.  At a good prime, \(c_n\) selects a
single simple target.  There is no second independent small linear form.  A
new multiplicity-sensitive, one-target theorem would be required.

## 5. Exact powers and the modular/Frey boundary

The modular method is exceptionally effective for equations in which a
fixed recurrence term, or a fixed polynomial expression, is an exact
\(q\)-th power.  For example, Bennett--Dahmen--Mignotte--Siksek prove the
complete fixed equation

\[
 x^{2q}\pm6x^q+1=8y^2,\qquad x,q>1,                        \tag{5.1}
\]

has no positive-integer solutions, using Frey curves over a real quadratic
field together with logarithmic forms.  Bennett--Patel--Siksek similarly
treat fixed shifted-power equations in Lucas--Lehmer sequences.

The quantifiers in the Pell square-base equation are different:

\[
 c_n=A_ny_n^2,                                              \tag{5.2}
\]

where the exponent is the fixed small exponent \(2\), while the squarefree
coefficient \(A_n\) moves with \(n\).  The conductor of a Frey object built
from (5.2) necessarily retains primes from the moving coefficient.  There is
no fixed level to which all \(n\) can be lowered, and exact-power exclusion
only treats \(A_n=1\) (or a separately fixed finite list of coefficients).

A uniform modular statement strong enough to force

\[
 H_n\le(1+o(1))\log A_n                                    \tag{5.3}
\]

would already be the missing height-versus-conductor estimate, rather than
a consequence of the presently accepted exact-power theorems.

## 6. The exact 2026 Fellini--Murty conditional boundary

Fellini and Murty call \(\alpha\in\mathcal O_K\) an admissible Wieferich
base when it is nonzero and not a root of unity.  For a prime ideal
\(\mathfrak p\), a base-\(\alpha\) non-Wieferich prime satisfies

\[
 \alpha^{N(\mathfrak p)-1}\not\equiv1\pmod{\mathfrak p^2}, \tag{6.1}
\]

and a super-Wieferich prime satisfies the congruence modulo
\(\mathfrak p^3\).

The numbering below follows the published JNT version: Theorems 2.1--2.4.
They are numbered 1.1--1.4 in the arXiv version.

The paper's exact theorem boundary is as follows.

* **Theorem 2.1 (unconditional structural theorem).**  Let \(d>2\) be
  squarefree, let \(K=\mathbf Q(\sqrt d)\), and write its fundamental unit
  as
  \[
  \varepsilon={\delta\over2}(t+u\sqrt d),
  \quad
  \delta=1\ (d\equiv1\pmod4),\quad
  \delta=2\ (d\equiv2,3\pmod4).
  \]
  Then \(d\nmid u\) if and only if, for at least one odd prime
  \(p\mid d\), the ramified prime ideal \(\mathfrak p\) above \(p\) is
  base-\(\varepsilon\) non-Wieferich.
* **Theorem 2.2.**  Fix a number field \(K\) and an admissible
  \(\alpha\in\mathcal O_K\).  **Assuming Masser's \(abc\) conjecture for
  number fields**, infinitely many prime ideals satisfy (6.1).
* **Theorem 2.3.**  For the same fixed data, **if there are only finitely many
  base-\(\alpha\) super-Wieferich prime ideals**, then infinitely many prime
  ideals satisfy (6.1).
* **Theorem 2.4.**  Under either of those two hypotheses,
  \[
  \#\{\mathfrak p:N\mathfrak p\le x,
       \ \alpha^{N\mathfrak p-1}\not\equiv1
          \pmod{\mathfrak p^2}\}
  \gg_{K,\alpha,\epsilon}{\log x\over\log\log x}.          \tag{6.2}
  \]
  The dependence on \(\epsilon\) belongs to the \(abc\) branch.

The authors explicitly state, concerning the expected predominance of
non-Wieferich primes, that “There is currently no unconditional result in
this direction.”  Publication metadata is: *Journal of Number Theory* 285
(August 2026), 209--229, DOI 10.1016/j.jnt.2026.01.002.

Theorem 2.1 can be specialized exactly, but it remains only a detector.  In
the Pell family \(A_n\equiv23\pmod{24}\), and the fundamental-unit audit
gives

\[
 \varepsilon_{A_n}=(c_n+1)+s_ny_n\sqrt{A_n}.                \tag{6.3}
\]

Every prime \(p\mid A_n\) is odd and satisfies
\(s_n^2\equiv2\pmod p\), hence \(p\nmid s_n\).  Therefore

\[
 A_n\nmid s_ny_n\quad\Longleftrightarrow\quad A_n\nmid y_n. \tag{6.4}
\]

The latter condition says that at least one parity-core prime occurs in
\(c_n\) with exponent exactly one.  Thus Theorem 2.1 converts the existence
of one valuation-one ramified prime into one non-Wieferich congruence, and
conversely.  It does not bound the product \(A_n\), and it is compatible with
all the remaining prime factors carrying arbitrarily deep odd valuations.

There are two independent reasons why this does not close (1.5).

1. The first branch assumes the conjecture that the repository is trying to
   prove.  The second branch assumes a different unproved finiteness
   statement.  Neither is an unconditional accepted input.
2. Even (6.2) is a global count of good prime ideals for one fixed base.
   It does not say that a good prime divides a specified \(c_n\), and it does
   not bound the sum of the even parts of all valuations of that \(c_n\).

The 2023 theorem of Anitha--Fathima--Vijayalakshmi on Lucas non-Wieferich
primes in arithmetic progressions has the same circular boundary: its
Theorem 3.1 begins by assuming number-field \(abc\).  It therefore cannot be
used as an input here.

## 7. Average or density-one information cannot be upgraded pointwise

The distinction can be made without any number theory.  Put

\[
 H_n=n,
 \qquad
 W_n=\begin{cases}
 n,&n\text{ is a power of }2,\\
 0,&\text{otherwise}.
 \end{cases}                                               \tag{7.1}
\]

Then, as \(N\to\infty\),

\[
 \#\{n\le N:W_n/H_n=1\}=O(\log N)=o(N),                    \tag{7.2}
\]

\[
 \sum_{n\le N}{W_n\over H_n}=O(\log N)=o(N),               \tag{7.3}
\]

and

\[
 \sum_{n\le N}W_n\le2N=o(N^2).                            \tag{7.4}
\]

Nevertheless \(W_{2^k}/H_{2^k}=1\) for every \(k\).  Thus all of the
following are insufficient for (1.5):

* a density-one pointwise estimate;
* mean convergence of \(W_n/H_n\) to zero; or
* a prefix total \(o(N^2)\) at the natural linear height scale.

For nonnegative \(W_n\), the much stronger bound

\[
 \sum_{n\le N}W_n=o(N)                                    \tag{7.5}
\]

would imply \(W_N=o(N)\), simply because
\(W_N\le\sum_{n\le N}W_n\).  None of the accepted counting or
density theorems above gives (7.5) for the logarithmic square-base weights.
In particular, a zero-density exceptional set cannot be discarded when the
construction requires every large \(n\).

## 8. 2026 preprint horizon: not an accepted substitute

Darsana--Rout, arXiv:2602.06667v2 (June 2026), treats parametric recurrence
specializations \(U_n(\zeta)\) at roots of unity.  Their Theorem 2.1 gives,
for all \(n\ge C_1\) and all but an explicitly bounded number of admissible
specializations \(\zeta\),

\[
 P(U_n(\zeta))
 >C_2\log n{\log\log n\over\log\log\log n},               \tag{8.1}
\]

and

\[
 N(Q(U_n(\zeta)))
 >n^{C_3\log\log n/\log\log\log n}.                       \tag{8.2}
\]

Here \(Q\) is the radical ideal.  Theorem 2.2 bounds the part supported on a
fixed finite prime-ideal set \(\mathcal S\), with constants depending on the
specialized recurrence and on \(\#\mathcal S\).

As of the audit date this is an arXiv preprint, not an accepted published
theorem.  More importantly, even if accepted tomorrow, (8.1)--(8.2) would
still concern largest support and the radical, and Theorem 2.2 would still
fix \(\mathcal S\) before choosing its constants.  None is a parity-core or
greatest-square-divisor estimate.

## 9. Exact surviving minimum

The audit leaves the following hierarchy.

| Available type of input | Exact defect relative to (1.5) |
|---|---|
| currently available ordinary radical lower bound | has logarithm \(o(H_n)\); only a new coefficient-one bound would suffice via (1.9) |
| greatest or primitive prime | supplies support, not an odd valuation or total parity mass |
| fixed-prime valuation formula | leaves first-hit depth, and then must be summed uniformly over moving primes |
| exact square / prime power / near-square classification | tests only parity cores of prescribed finite shape |
| fixed-\(S\) estimate | constants and threshold depend on \(S\); the relevant \(S_n\) moves |
| gcd / Subspace theorem | requires two independent values; one simple deep hit is invisible |
| density-one or average estimate | permits a sparse infinite bad subsequence |
| non-Wieferich prime abundance | global in the prime variable and presently conditional |
| fixed-coefficient modular theorem | the squarefree coefficient and level move here |

Accordingly the minimal new proposition should not be weakened to an
ordinary radical statement.  It is exactly either of the following
equivalent pointwise assertions:

\[
 \boxed{
 \forall\epsilon>0\ \exists C_\epsilon\ \forall n\ge1:
 \log\operatorname{gsd}(c_n)
 =2\log y_n\le\epsilon H_n+C_\epsilon,}                    \tag{9.1}
\]

or

\[
 \boxed{
 \forall\epsilon>0\ \exists C'_\epsilon\ \forall n\ge1:
 \log\operatorname{core}_2(c_n)
 =\log A_n\ge(1-\epsilon)H_n-C'_\epsilon.}                 \tag{9.2}
\]

The best accepted pointwise lower bound presently retained in the repository
comes instead from the fact that the associated norm-one Pell unit is
fundamental, together with the real quadratic class-number formula:

\[
 A_n\ge
 \left({64\over c_2^2}-o(1)\right)
 {H_n^2\over(\log H_n)^2},
 \qquad c_2=2-{2\over\sqrt e}.                              \tag{9.3}
\]

Thus

\[
 \log A_n\ge2\log H_n-2\log\log H_n+O(1)=o(H_n),           \tag{9.4}
\]

which is structurally useful but has coefficient zero on the source-height
scale.  No accepted theorem audited above upgrades (9.3) to (9.2).

## 10. Formal companion and scope

`IUTThreeClosures/FreyPellSquarebaseAcceptedTheoremAudit2026.lean` proves
only the scalar logic used in this note:

1. a greatest-square-divisor upper bound plus the lower height comparison
   gives the coefficient-one parity-core lower bound;
2. the converse follows from the upper height comparison;
3. the exact-height versions are equivalent;
4. a coefficient-one radical lower bound is a sufficient stronger input via
   \(\operatorname{rad}(A y^2)\le Ay\);
5. a half-height radical profile can coexist with zero normalized parity
   core and a full square-base term; and
6. a nonnegative prefix estimate transfers pointwise only when the prefix
   bound itself is on the pointwise \(H_N\) scale.

Lean does not formalize or assume any external recurrence theorem,
Subspace Theorem, modularity theorem, Wieferich theorem, asymptotic notation,
or \(abc\).  The literature audit is mathematical prose; the companion only
prevents changes of inequality direction or coefficient in the final scalar
ledger.

## References

* C. L. Stewart, *On prime factors of terms of binary recurrence sequences*,
  Acta Arith. 209 (2023), 173--189,
  [DOI](https://doi.org/10.4064/aa220601-7-3),
  [preprint](https://arxiv.org/abs/2206.01275).
* J. Odjoumani and V. Ziegler, *On prime powers in linear recurrence
  sequences*, Ann. Math. Québec 47 (2023), 349--366 (published online 2021),
  [DOI](https://doi.org/10.1007/s40316-021-00163-9).
* N. Tzanakis and P. Voutier, *Near-squares in binary recurrence sequences*,
  Int. J. Number Theory 20 (2024), 1591--1620,
  [DOI](https://doi.org/10.1142/S1793042124500787),
  [preprint](https://arxiv.org/abs/2106.04523).
* P. M. Voutier, *Bounds on the number of squares in recurrence sequences*,
  J. Number Theory 265 (2024), 291--343,
  [DOI](https://doi.org/10.1016/j.jnt.2024.05.002),
  [preprint](https://arxiv.org/abs/2401.01293).
* A. Bérczes, L. Hajdu, A. Ostafe and I. E. Shparlinski,
  *Multiplicative dependence in linear recurrence sequences*, Canad. Math.
  Bull. 68 (2025), 1278--1288,
  [DOI](https://doi.org/10.4153/S0008439525000475),
  [preprint](https://arxiv.org/abs/2501.17365).
* G. Alecci, P. Miska, N. Murru and G. Romeo, *On alternative definition of
  Lucas atoms and their p-adic valuations*, Monatsh. Math. 207 (2025),
  175--196,
  [DOI](https://doi.org/10.1007/s00605-025-02087-w),
  [preprint](https://arxiv.org/abs/2308.10216).
* Y. Bugeaud and J.-H. Evertse, *S-parts of terms of integer linear
  recurrence sequences*, Mathematika 63 (2017), 840--851,
  [DOI](https://doi.org/10.1112/S0025579317000298),
  [preprint](https://arxiv.org/abs/1611.00485).
* N. Grieve and J. Wang, *Greatest common divisors with moving targets and
  consequences for linear recurrence sequences*, Trans. Amer. Math. Soc.
  373 (2020), 8095--8126,
  [DOI](https://doi.org/10.1090/tran/8220),
  [preprint](https://arxiv.org/abs/1902.09109).
* Z. Xiao, *Greatest common divisors for polynomials in almost units and
  applications to linear recurrence sequences*, Math. Z. 306 (2024),
  [DOI](https://doi.org/10.1007/s00209-024-03453-4),
  [preprint](https://arxiv.org/abs/2110.01751).
* O. Järviniemi, *Positive lower density for prime divisors of generic linear
  recurrences*, Math. Proc. Cambridge Philos. Soc. 175 (2023), 467--478,
  [DOI](https://doi.org/10.1017/S0305004123000257),
  [preprint](https://arxiv.org/abs/2102.04042).
* Y. Bilu, H. Hong and S. Gun, *Uniform explicit Stewart theorem on prime
  factors of linear recurrences*, Acta Arith. 206 (2022), 223--243,
  [DOI](https://doi.org/10.4064/aa211116-13-11),
  [preprint](https://arxiv.org/abs/2108.09857).
* M. A. Bennett, S. Dahmen, M. Mignotte and S. Siksek, *Shifted powers in
  binary recurrence sequences*, Math. Proc. Cambridge Philos. Soc. 158
  (2015), 305--329,
  [preprint](https://arxiv.org/abs/1408.1710).
* M. A. Bennett, V. Patel and S. Siksek, *Shifted powers in Lucas--Lehmer
  sequences*, Res. Number Theory 5 (2019),
  [DOI](https://doi.org/10.1007/s40993-019-0153-2),
  [preprint](https://arxiv.org/abs/1811.10889).
* N. Fellini and M. Ram Murty, *Wieferich primes in number fields and the
  conjectures of Ankeny--Artin--Chowla and Mordell*, J. Number Theory 285
  (August 2026), 209--229,
  [DOI](https://doi.org/10.1016/j.jnt.2026.01.002),
  [author PDF](https://mast.queensu.ca/~murty/aacm.pdf),
  [preprint](https://arxiv.org/abs/2508.08472).
* K. Anitha, I. Mumtaj Fathima and A. R. Vijayalakshmi, *Lucas non-Wieferich
  primes in arithmetic progressions and the abc conjecture*, Open Math. 21
  (2023),
  [DOI](https://doi.org/10.1515/math-2022-0563),
  [preprint](https://arxiv.org/abs/2101.04901).
* N. Darsana and S. S. Rout, *Prime ideal divisors of parametric recurrence
  sequences*, [arXiv:2602.06667v2](https://arxiv.org/abs/2602.06667)
  (June 2026 preprint; not used as an accepted theorem).
