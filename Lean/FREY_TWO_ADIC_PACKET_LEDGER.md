# The two-adic packet ledger for the primitive Frey curve

## 0. Scope and normalization

Let

\[
 a+b=c,\qquad a,b,c>0,\qquad \gcd(a,b)=1,
\]

and put

\[
 E_{a,b}:y^2=x(x-a)(x+b).
 \tag{0.1}
\]

This note gives the complete part of the local calculation at $2$ which is
relevant to division packets and lower bounds for canonical heights.  The
normalization is

\[
 |2|_2=2^{-1},\qquad
 \lambda_2(P)=\left(\frac{v_2(\Delta_{\min})}{12}
              -\frac{q(\Gamma(P))}{2}+i_2(P,O)\right)\log 2.
 \tag{0.2}
\]

Here $\Gamma(P)$ is the component met by $P$, $q$ is the diagonal
entry of the inverse fibre Cartan matrix, and the intersection term
$i_2(P,O)$ is nonnegative.  Formula (0.2) is first stated for a section
meeting a smooth point of the minimal regular model.  It extends to an
algebraic point after finite base change with the usual local-degree weight.

The conclusions are:

1. the conductor exponent at $2$ is at most $5$;
2. nevertheless, if $e$ is the valuation of the unique even member of
   $\{a,b,c\}$, then for every $e\ge5$ the sharp geometric lower bound is

   \[
   \boxed{\displaystyle
   \lambda_2(P)\ge-\frac{e-4}{12}\log2,}
   \tag{0.3}
   \]

   and equality occurs on actual components met by rational two-torsion;
3. hence the two-adic *conductor* cost is $O(1)$, but a selected local
   height is not $O(1)$;
4. a full $m$-division packet has component average bounded below by
   $-(e-4)\log2/(12m^2)$, while a single asymmetric branch still has the
   unsuppressed lower bound (0.3).

Thus this calculation rules out only an argument which discards every
two-adic branch as a bounded error.  It does not rule out a global selector
which is proved to choose the identity component at $2$, or a genuinely
adelic cancellation among several branches.

## 1. Invariants and the parity parameter

For the integral equation (0.1),

\[
 \begin{aligned}
 a_1&=a_3=a_6=0,& a_2&=b-a,& a_4&=-ab,\\
 c_4&=16(a^2+ab+b^2),&
 \Delta&=16a^2b^2c^2,\\
 j&=\frac{256(a^2+ab+b^2)^3}{a^2b^2c^2}.
 \end{aligned}
 \tag{1.1}
\]

Primitivity implies that exactly one of $a,b,c$ is even.  Write

\[
 e=v_2(abc)=v_2(\text{the unique even member}).
 \tag{1.2}
\]

The quantity $a^2+ab+b^2$ is odd.  Therefore

\[
 v_2(c_4)=4,\qquad v_2(\Delta)=2e+4,
 \qquad v_2(j)=8-2e.
 \tag{1.3}
\]

To state the two possible minimal-model branches uniformly, translate $x$
when necessary so that the two roots separated by the even member are the
close pair.  Let $\rho$ be the signed isolated root and $d$ the signed even
separation:

\[
\begin{array}{c|c|c|c}
\text{even member}&\text{coordinate used}&\rho&d\\ \hline
b&x&a&b\\
a&x&-b&-a\\
c&z=x-a&-a&c.
\end{array}
\tag{1.4}
\]

In all three rows, $\rho$ is odd, $v_2(d)=e$, and the two branches are

\[
 \mathsf S:\rho\equiv3\pmod4,
 \qquad
 \mathsf A:\rho\equiv1\pmod4.
 \tag{1.5}
\]

The letter $\mathsf S$ anticipates the semistable model which appears at
depth at least $4$; $\mathsf A$ is the additive-star branch.

## 2. Explicit minimalization and the Tate table

After the translation in (1.4), write the equation as

\[
 y^2=z^3+A_2z^2+A_4z.
 \tag{2.1}
\]

If $e\ge4$, then $16\mid A_4$.  In branch $\mathsf S$ one also has
$A_2\equiv1\pmod4$.  The explicit substitution

\[
 z=4X,\qquad y=8Y+4X
 \tag{2.2}
\]

gives the integral equation

\[
 Y^2+XY=X^3+\frac{A_2-1}{4}X^2+\frac{A_4}{16}X.
 \tag{2.3}
\]

Its invariants are $c_4'=c_4/16$ and
$\Delta'=\Delta/2^{12}$.  Since $c_4'$ is odd, (2.3) is minimal.  It has
good reduction when $e=4$ and multiplicative reduction of type
$I_{2e-8}$ when $e\ge5$.

Conversely, in branch $\mathsf A$ the coefficient congruence needed in
(2.3) fails.  Completing the general admissible change

\[
 z=4X+r,\qquad y=8Y+4sX+t
 \]

modulo $4,16,64$, respectively, first forces $s$ odd and $r$ to be
the close-root residue and then forces $A_2\equiv1\pmod4$.  Hence no
integral change with scale $2$ exists in branch $\mathsf A$; the displayed
model is minimal.  The remaining steps of Tate's algorithm give the table
below.  The Kodaira symbols can also be checked from the fibre equations;
the conductor column follows from Ogg's formula
$f_2=v_2(\Delta_{\min})+1-m$, where $m$ is the number of geometric fibre
components.

\[
\begin{array}{c|c|c|c|c|c}
e&\text{branch}&\text{Kodaira type}&v_2(\Delta_{\min})&f_2&c_2\\ \hline
1&\mathsf S,\mathsf A&\mathrm{III}&6&5&2\\
2&\mathsf S&I_1^*&8&3&2\text{ or }4\\
2&\mathsf A&I_0^*&8&4&2\\
3&\mathsf S&\mathrm{III}^*&10&3&2\\
3&\mathsf A&I_2^*&10&4&4\\
4&\mathsf S&I_0&0&0&1\\
4&\mathsf A&I_4^*&12&4&4\\
e\ge5&\mathsf S&I_{2e-8}&2e-8&1&
  \begin{cases}2e-8,&\rho\equiv7\pmod8,\\2,&\rho\equiv3\pmod8,
  \end{cases}\\
e\ge5&\mathsf A&I_{2e-4}^*&2e+4&4&4.
\end{array}
\tag{2.4}
\]

For completeness, in the $e=2,\mathsf S$ row put $u=d/4$, with the
sign convention of (1.4).  The last quadratic in Tate's algorithm splits
over $\mathbf F_2$, and $c_2=4$, exactly when

\[
 \rho+2u\equiv1\pmod8;
 \tag{2.5}
\]

otherwise $c_2=2$.  For $e\ge5,\mathsf S$, the nodal tangents split
exactly when $\rho\equiv7\pmod8$, which gives the last-but-one row of
(2.4).

This proves in particular the uniform conductor statement

\[
 0\le f_2\le5.
 \tag{2.6}
\]

## 3. The exact component-height table

Let $q(\Gamma)$ denote the relevant inverse-Cartan diagonal.  The entries
needed here are

\[
\begin{array}{c|c|c}
\text{fibre}&\text{root lattice}&\text{nonzero values of }q\\ \hline
\mathrm{III}&A_1&1/2\\
I_0^*&D_4&1,1,1\\
I_1^*&D_5&1,5/4,5/4\\
\mathrm{III}^*&E_7&3/2\\
I_N&A_{N-1}&i(N-i)/N\\
I_n^*&D_{n+4}&1,(n+4)/4,(n+4)/4.
\end{array}
\tag{3.1}
\]

Substitution in (0.2) gives the sharp geometric minimum

\[
\frac{1}{\log2}\min_P\lambda_2(P)=
\begin{cases}
1/4,&e=1,\\
1/24,&e=2,\ \mathsf S,\\
1/6,&e=2,\ \mathsf A,\\
1/12,&e=3,\\
0,&e=4,\\
-(e-4)/12,&e\ge5.
\end{cases}
\tag{3.2}
\]

Only the component term is minimized in (3.2); the nonnegative intersection
term cannot make the bound worse.  Every displayed minimum is attained after
a finite unramified extension by a section through a smooth point of the
corresponding component.

The coincidence of the two large-depth branches is worth isolating.  In
branch $\mathsf S$, with $N=2e-8$, the opposite component of $I_N$
has

\[
 \frac{N}{12}-\frac{1}{2}\frac{(N/2)^2}{N}
 =-\frac{N}{24}=-\frac{e-4}{12}.
 \tag{3.3}
\]

In branch $\mathsf A$, put $n=2e-4$.  The wild discriminant valuation is
$n+8=2e+4$, and either spinor component of $D_{n+4}$ has

\[
 \frac{n+8}{12}-\frac12\frac{n+4}{4}
 =-\frac{n-4}{24}=-\frac{e-4}{12}.
 \tag{3.4}
\]

Equivalently, (1.3) says that both branches become a Tate curve of depth
$-v_2(j)=2e-8$ after the potentially multiplicative quadratic base change.
The Bernoulli minimum is therefore
$-(2e-8)\log2/24$, again (0.3).  This also proves that (0.3) remains the
normalized sharp bound for algebraic division points over arbitrary finite
extensions.

## 4. Rational two-torsion and the four-branch ledger

Write

\[
 T_0=(0,0),\qquad T_a=(a,0),\qquad T_b=(-b,0).
\tag{4.1}
\]

Let the *close pair* mean the two torsion points whose abscissas differ by the
unique even member of $\{a,b,c\}$.  Thus it is

\[
\{T_0,T_b\}\ (b\text{ even}),\qquad
\{T_0,T_a\}\ (a\text{ even}),\qquad
\{T_a,T_b\}\ (c\text{ even}).
\tag{4.2}
\]

For $e\ge5$, direct tracing through the blow-ups in Tate's algorithm gives:

* in branch $\mathsf S$, the close pair meets the opposite component
  $N/2$ of $I_N$, while the isolated torsion point lies in the identity
  component;
* in branch $\mathsf A$, the close pair meets the same spinor component of
  $D_{2e}$, while the isolated torsion point is smooth modulo $2$ and lies
  in the identity component.  Thus rational $E[2]$-translation does not
  visit the vector component.

Consequently the exact torsion-component values, divided by $\log2$, are

\[
\begin{array}{c|c|c}
\text{branch}&\text{component}&\lambda_2/\log2\\ \hline
\mathsf S&\text{identity}&(e-4)/6\\
\mathsf S&\text{either close torsion}&-(e-4)/12\\
\mathsf A&\text{identity or isolated torsion}&(e+2)/6\\
\mathsf A&\text{either close torsion; same spinor}&-(e-4)/12.
\end{array}
\tag{4.3}
\]

After a finite unramified extension if necessary, choose $R$ in an
identity-component residue disc centred at a generic smooth point, distinct
from the reductions of $O$ and of the identity-component two-torsion.  Then
none of its four translates creates an extra intersection.  Their component
averages are

\[
 \frac{e-4}{24}\log2\quad(\mathsf S),
 \qquad
 \frac{e+8}{24}\log2\quad(\mathsf A).
 \tag{4.4}
\]

Both are nonnegative.  Thus the full four-branch average at $2$ is benign
for an identity-base packet even though two individual branches have an
unbounded negative contribution.

## 5. Arbitrary division packets

Over a common finite field on which the potentially multiplicative Tate
parameter and $E[m]$ are defined, write the component coordinate of a
chosen division point as $r\in\mathbf R/\mathbf Z$.  The $m^2$ torsion
translations shift it by

\[
 r+\frac{k}{m},\qquad 0\le k<m,
\]

each with multiplicity $m$.  With
$B_2(x)=x^2-x+1/6$, the multiplication identity

\[
 \sum_{k=0}^{m-1}B_2\!\left(\left\{r+\frac{k}{m}\right\}\right)
 =\frac1m B_2(\{mr\})
 \tag{5.1}
\]

shows that the full packet component average is $m^{-2}$ times the
component value of its multiple.  Since $\min B_2=-1/12$, for $e\ge5$

\[
 \frac1{m^2}\sum_{T\in E[m]}\lambda_{2,\mathrm{comp}}(Q+T)
 \ge-\frac{e-4}{12m^2}\log2.
 \tag{5.2}
\]

The theta/intersection average is nonnegative.  Formula (5.2) is sharp as a
component statement.  In contrast, choosing only one branch gives merely
(0.3); there is no factor $m^{-2}$ without a packet-distribution theorem.

For odd $m$, multiplication acts invertibly on the exponent-two component
group of an $I_n^*$ fibre.  For even $m$, every full packet decomposes into
four-branch cosets under $E[2]$; after the common semistable base change this
is exactly the Bernoulli distribution just used.  This is why one must choose
the common field before comparing branch averages.

## 6. Strict unbounded families and the precise no-go

Two primitive families display both minimal-model branches.

### 6.1 Additive-star family

For every $e\ge5$, take

\[
 (a,b,c)=(1,2^e,2^e+1).
 \tag{6.1}
\]

Here $\rho=1$, so the fibre is $I_{2e-4}^*$,
$v_2(\Delta_{\min})=2e+4$, $f_2=4$, and $c_2=4$.  The rational torsion
points $T_0$ and $T_b$ meet the same spinor component, hence

\[
 \lambda_2(T_0)=\lambda_2(T_b)
 =-\frac{e-4}{12}\log2.
 \tag{6.2}
\]

### 6.2 Multiplicative family

For every $e\ge5$, take

\[
 (a,b,c)=(3,2^e,2^e+3).
 \tag{6.3}
\]

Here $\rho=3$, so (2.3) has type $I_{2e-8}$.  The fibre is nonsplit over
$\mathbf Q_2$ (using $a=7$ instead gives the split version), but the close
torsion components are rational and again

\[
 \lambda_2(T_0)=\lambda_2(T_b)
 =-\frac{e-4}{12}\log2.
 \tag{6.4}
\]

The right sides of (6.2) and (6.4) tend to $-\infty$, while the conductor
exponents remain $4$ and $1$, respectively.  Moreover, over
$\mathbf Q_2$ choose any non-torsion $R$ sufficiently deep in the formal
group and put $P=2R$.  The actual half-packet of $P$ contains
$R+T_0$ and $R+T_b$, which lie in the same adverse residue discs as the
torsion points.  Thus the obstruction is not an artefact of using a torsion
multiple.

Therefore the statement

> every two-adic local height in a Frey division packet is $O(1)$ because
> the prime and conductor exponent are fixed

is false.  What survives is the sharper statement:

> the two-adic conductor term is $O(1)$; the selected local height has sharp
> lower slope $-1/12$ in the excess depth $e-4$; a complete $m$-packet
> suppresses that slope by $m^{-2}$.

This leaves open, and cleanly identifies, the global alternatives: prove an
identity-component selector at $2$, retain a sufficiently large complete
packet, or establish cancellation with the archimedean and other compatible
branches.

## 7. Formalization boundary

`IUTThreeClosures/FreyTwoAdicPacketLedger.lean` checks the cycle-free scalar
core:

1. the discriminant shifts in the semistable and additive-star branches;
2. the equality of their sharp worst coefficients;
3. the identity, vector, spinor, and four-branch averages;
4. the $m^{-2}$ packet lower coefficient;
5. a strict unbounded-depth family of scalar losses.

It does not formalize Tate's algorithm, minimal regular models, Kodaira
fibres, inverse Cartan matrices, Néron local heights, or the assertion that a
given section meets a named component.  Those inputs are proved on paper
above and are not smuggled into Lean as axioms.
