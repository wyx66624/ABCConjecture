# An explicit Frey Q-curve for the second mixed norm

Status (2026-09-07): ordinary proofs FM1--FM5 below; FM1--FM4 have a full
independent audit by `adversarial_audit`, and FM5 has a full source and
representation audit by `critical_bottleneck`, who also independently
reviewed FM6. No
non-existence theorem for all powers, no ABC conclusion, and no full Lean
formalization is asserted. Previous rounds are unchanged.

Throughout, `a,b` are positive coprime integers and

\[
 F=F(a,b)=a^4+3a^3b+5a^2b^2+3ab^3+b^4,
 \qquad x=a^2+b^2,\quad y=a+b.
\]

Here `F` is exactly the second norm `M_1` in the two-step transport, not an
arbitrary quartic. A compressed presentation is `F=V Q^g`, with positive
integers `V,Q`, `Q>1`; its residual parameter is
`lambda=max(1,log V)/g`. The pure branch means `V=1`.

## FM1. Exact generalized-Fermat entry and its inverse gate

One has

\[
 x^2+3y^4=4F,\qquad 2x-y^2=(a-b)^2,
 \qquad \gcd(x,y)\mid2.                                      \tag{FM1}
\]

The identities follow by expansion. A common divisor of `x,y` divides `2ab`;
`gcd(ab,a+b)=1`, proving the gcd assertion. There are two exact parity charts.

* If `a,b` have opposite parity, `x,y,d=a-b` are odd, `gcd(x,y)=1`,
  `d^2=2x-y^2`, and `|d|<y`. Conversely, any such odd integers with `y>0`
  reconstruct positive coprime integers
  `a=(y+d)/2,b=(y-d)/2`. Integrality and positivity are immediate. An odd
  common prime of `a,b` would divide `x,y`; both cannot be even since `x` is odd.
* If both seeds are odd, put `X=x/2,Y=y/2,D=(a-b)/2`. Then
  `X` is odd, `gcd(X,Y)=1`, and

\[
 X^2+12Y^4=F,\qquad X-Y^2=D^2,\qquad |D|<Y.                  \tag{FM2}
\]

  Conversely, these conditions with `Y>0` reconstruct
  `a=Y+D,b=Y-D`. Since `X=Y^2+D^2` is odd, `Y,D` have opposite parity;
  `gcd(X,Y)=1` implies `gcd(Y,D)=1`. Thus the reconstructed seeds are odd and
  coprime. Their sum and square sum recover the proposed `X,Y`.

Consequently an arbitrary primitive solution of `x^2+3y^4=4VQ^g` cannot be
called a seed until the additional square and positivity gate has been checked.
The established results for `A^4+3B^2=C^p` do not directly apply: substituting
`A=3y,B=3x` gives `A^4+3B^2=108VQ^g` and non-coprime parameters.

## FM2. Uniform local restrictions on the actual norm

For every primitive seed, `F` is odd and `F=1 mod 3`. The oddness follows by
checking the three nonzero parity pairs. Modulo 3,
`F=(a^2+b^2)^2`; since `a,b` are not both zero modulo 3, this is 1.
In particular, `3` never divides `x`.

The previously proved actual bad-prime theorem says

\[
 13\mid F(a,b)\quad\Longrightarrow\quad v_{13}(F(a,b))=1.
                                                               \tag{FM3}
\]

Its dependency is the third-round quartic arithmetic / fifth-round exact
bad-prime theorem, not a statement about an arbitrary norm. Therefore if
`F=Q^g` with `g>=2`, then `gcd(Q,78)=1`. This is necessary and does not itself
exclude the pure branch.

## FM3. The curve and its complete behavior away from 2 and 3

Let `r=sqrt(-3)`, `K=Q(r)`, and

\[
 \alpha_+=3y^2+xr,\qquad \alpha_-=3y^2-xr.
\]

Attach the integral elliptic curve

\[
 E_{a,b}:\quad \mathcal Y^2=\mathcal X^3+
          12y\mathcal X^2+6\alpha_+\mathcal X.                \tag{FM4}
\]

It has a rational point `(0,0)` of order 2. With `A=12y,B=6alpha_+`,
the standard quotient by that point is

\[
 \mathcal Y^2=\mathcal X^3-24y\mathcal X^2+24\alpha_-\mathcal X.
\]

Indeed `A^2-4B=24alpha_-`. This is the quadratic twist by `-2` of the
Galois conjugate of (FM4). Thus `E` is a degree-two Q-curve, with curve and
displayed isogenies defined over `K(sqrt(-2))`. This is the explicit
degree-two isogeny construction, independent of any Fermat equation theorem.

Direct calculation gives

\[
 \begin{aligned}
 \alpha_+\alpha_-&=12F,\\
 c_4(E)&=2^5 3^2(5y^2-xr),\\
 c_6(E)&=2^8 3^3y(3xr-7y^2),\\
 \Delta(E)&=2^{11}3^4F\alpha_+ .
 \end{aligned}                                                \tag{FM5}
\]

For example, use `c4=16(A^2-3B)`, `c6=-64A^3+288AB`, and
`Delta=16B^2(A^2-4B)`. Since `F>0`, this discriminant is nonzero.

Let `q>3` be prime. If `q` does not divide `F`, (FM4) has good reduction at
every prime of `K` above `q`. If `q|F`, neither `x` nor `y` is divisible by
`q`, since otherwise the equation `x^2+3y^4=4F` would force both to vanish
and contradict `gcd(x,y)|2`. That equation also makes `-3` a nonzero square
modulo `q`; hence `q` splits into two primes of `K`.

The two elements `alpha_+,alpha_-` cannot vanish at the same prime above `q`:
their sum and difference would force `q|x,y`. If `m=v_q(F)`, their local
valuations are therefore `m,0`, in one order. At the corresponding primes
the last formula in (FM5) gives the two discriminant valuations `2m,m`.
The factor `5y^2-xr` in `c4` reduces respectively to `8y^2` or `2y^2`, and
is a unit. Thus the displayed equation is minimal and has multiplicative
reduction at both primes. We have proved

\[
 \{v_{\mathfrak q}(\Delta_{\min}):\mathfrak q\mid q\}
       =\{m,2m\},\qquad f_{\mathfrak q}(E)=1 \quad(q\mid F,q>3).
                                                               \tag{FM6}
\]

Because `F>=13` and `gcd(F,6)=1`, there is always a prime of multiplicative
reduction of residue characteristic greater than 3. In particular `E` has
no complex multiplication: its `j`-invariant has negative valuation there,
whereas a CM `j`-invariant is an algebraic integer.
The geometric isogeny degree is exactly two: in the non-CM case the
isogenies to the conjugate form a rank-one module, and every degree is
the minimum isogeny degree times an integer square. The existing degree-two
isogeny forces that minimum to be two, not one.

## FM4. General Tate proof at the two exceptional primes

The normalization of valuations is important. At the inert prime
`mathfrak p_2=(2)`, use `v_2(2)=1`, and the residue field is `F_4`.
At `mathfrak p_3=(r)`, use `v_3(r)=1`, so `v_3(3)=2`.

### The prime above 3

Since `x` is a 3-adic unit, `v_3(alpha_+)=1`. Thus
`v_3(Delta)=9`, and the displayed equation has

\[
 a_1=a_3=a_6=0,\qquad v_3(a_2)\ge2,\qquad v_3(a_4)=3.         \tag{FM7}
\]

These coefficients already satisfy the additive normalization of Tate's
algorithm. The auxiliary cubic is `T^3`, with triple root zero. The next
quadratic for type `IV*` is `T^2`, again with zero repeated root. The
stronger conditions on `a3,a6` needed after that zero translation hold
automatically. Since `a4/r^3` is a unit, the next test yields type `III*`.
Its eight geometric components give

\[
 v_3(\Delta_{\min})=9,\qquad f_{\mathfrak p_3}(E)=9+1-8=2.
                                                               \tag{FM8}
\]

This uses the actual branch tests of Tate's algorithm, not an inference from
the invariant valuations alone. The model is minimal; all changes used here
have scaling factor one.

### The prime above 2

For integers `U,V`, with `zeta=(1+r)/2`, the integral basis identity

\[
 U+Vr=(U-V)+2V\zeta
\]

shows, for every integer `n>=1`, that

\[
 U+Vr\in2^n\mathcal O_{K,\mathfrak p_2}
 \quad\Longleftrightarrow\quad
 2^n\mid U-V\quad\hbox{and}\quad2^{n-1}\mid V.               \tag{FM9}
\]

Both `alpha_+` and its conjugate have the same 2-adic valuation, and their
norm is `12F` with `F` odd. Hence `v_2(alpha_+)=1` and
`v_2(Delta)=12`. Make the integral change
`mathcal X=X'+R, mathcal Y=Y'+T`, where

| Seed condition | `R` | `T` |
|---|---:|---:|
| both odd, `y=0 mod4` | `2` | `2(r+1)` |
| both odd, `y=2 mod4` | `2` | `2(r-1)` |
| opposite parity, even seed `0 mod4` | `1+r` | `4` |
| opposite parity, even seed `2 mod4` | `1+r` | `2(r+1)` |

The new coefficients are

\[
 \begin{aligned}
 a'_1&=0,&a'_2&=A+3R,&a'_3&=2T,\\
 a'_4&=B+2AR+3R^2,&
 a'_6&=R^3+AR^2+BR-T^2.
 \end{aligned}                                                \tag{FM10}
\]

We claim the uniform exact divisibility pattern

\[
 v_2(a'_2)=1,\qquad v_2(a'_3)\ge3,\qquad
 v_2(a'_4)=3,\qquad v_2(a'_6)\ge5.                            \tag{FM11}
\]

Here is the complete congruence verification. For even `y`, `x=2 mod8` and
`a2'=12y+6` has valuation one. Write `T=2(r+s)`, with `s=1` or `-1` as in
the table. Then

\[
 \begin{aligned}
 a'_4&=6(H+xr),&H&=3y^2+8y+2,\\
 a'_6&=C+Dr,&C&=16+48y+36y^2,\quad D=12x-8s.
 \end{aligned}
\]

Both `H/2,x/2` are odd. The norm of an element `u+vr` with odd integers
`u,v` is `u^2+3v^2=4 mod8`, so its valuation at this inert prime is exactly
one. Therefore `v_2(a4')=3`. We have `16|D`. Moreover
`(C-D)/4=4+12y+9y^2-3x+2s` is zero modulo 8: use `x=2 mod8` and the two
values of `y mod4`. This proves `32|C-D`, and (FM9) proves the last claim.
Finally `v_2(T)=2`, so `v_2(a3')=3`.

For odd `y`, `x` is odd, and

\[
 a'_2=3(4y+1+r),\qquad
 a'_4=6(H+Jr),\quad H=3y^2+4y-1,\quad J=x+4y+1.
\]

The first bracket has valuation one. Both `H/2,J/2` are odd, so the same
norm test gives `v_2(a4')=3`. If `T=4`, then, writing `a6'=C+Dr`,

\[
 D=24y+18y^2+6x,\quad C-D=-24(1+2y+x).
\]

Here `x=1 mod8,y^2=1 mod8`, so `16|D`, while `x=1 mod4` gives `32|C-D`.
If `T=2(r+1)`, the corresponding formulas are

\[
 D=24y+18y^2+6x-8,\quad C-D=8(1-6y-3x).
\]

Now `x=5 mod8` proves `16|D`, and again `x=1 mod4` proves `32|C-D`.
In both cases `v_2(a3')=3`. This proves all of (FM11).

Tate's initial auxiliary cubic is consequently `Z^2(Z+b)`, with nonzero
`b=a2'/2` in `F_4`. Its double root is already zero. The first quadratic
in the `I_n*` branch has coefficients `a3'/4,a6'/16`, both zero in `F_4`;
it is `Z^2`. The next zero translation is unnecessary because (FM11)
already supplies `8|a3'` and `32|a6'`. The second quadratic is

\[
 (a'_2/2)Z^2+(a'_4/8)Z+a'_6/32.
\]

Its derivative is the nonzero constant `a4'/8`, so it has distinct roots
over the residue algebraic closure. The algorithm therefore terminates
with type `I_2*`. There are seven geometric components, and thus

\[
 v_2(\Delta_{\min})=12,\qquad f_{\mathfrak p_2}(E)=12+1-7=6.
                                                               \tag{FM12}
\]

All tests here are polynomial root and divisibility tests valid over `F_4`;
we do not import the shortcuts for square roots in `F_2` from rational-curve
pseudocode. The uniform conductor of the curve over `K` is therefore

\[
 \mathcal N(E)=\mathfrak p_2^6\mathfrak p_3^2
             \prod_{q\mid F,\ q>3}\mathfrak q\overline{\mathfrak q}.
                                                               \tag{FM13}
\]

The primary Tate-algorithm reference actually inspected is Cremona,
*Algorithms for Modular Elliptic Curves*, Chapter 3, printed pages 66--68;
the book explains the extension from the displayed rational pseudocode to
an arbitrary discrete valuation ring. In particular its double-root loop
and triple-root tests give precisely the two branches used above:
https://johncremona.github.io/book/fulltext/chapter3.pdf .

## FM5. Five necessary residual modular levels for the pure branch

Let `p>7` be prime and suppose `F=Q^p`. The necessary conclusion is
the existence of a weight-two newform of character `epsilon=psi_3` and
one of the levels

\[
 N=2^e3^2,\quad 2\le e\le6;
 \qquad N\in\{36,72,144,288,576\}.                           \tag{FM14}
\]

This conclusion uses the following explicit external-input chain,
independently reviewed separately from the local computation in FM1--FM4.

1. The fixed character of Pacetti--Villagra Torcomian, Theorem 3.2, with
   `d=3`, is unramified outside `mathfrak p_2`, has conductor dividing
   `mathfrak p_2^3`, satisfies `chi^2=epsilon|G_K`, and
   `sigma chi=chi psi_{-2}|G_K`. Here `epsilon=psi_3` has conductor 12.
   The theorem is a character construction over `K`, with no primitive
   Fermat-solution hypothesis. Its explicit 2-adic values are in Table 3.3.
2. The explicit isogeny in FM3 gives conjugate representations differing
   by the `-2` character, so `rho_E tensor chi` is conjugation invariant.
   The extension proof in their Theorem 4.2 applies; oddness invokes the
   general Q-curve theorem of Ribet expressly cited in that proof. It does
   not follow from Schur's lemma alone. We use
   that proof, **not** the local level formula for their different equation.
3. At every `q>3`, (FM6) and `F=Q^p` make the minimal discriminant
   valuations multiples of `p`. The standard Tate-curve criterion makes
   `E[p]` unramified away from `6p` and finite flat at places above `p`.
   For the latter statement, the Tate parameter has valuation divisible
   by `p`, so its Kummer class has a unit representative and gives a finite
   flat extension. Good reduction gives finite flatness directly.
   Here `K/Q` is unramified at `p`, and `chi` is unramified there;
   the unramified extension, descent, and twist preserve finite flatness.
4. At `mathfrak p_2`, the curve has potentially good reduction and its
   `ell`-adic determinant is unramified (`ell>3`). On each finite higher
   inertia group a nonzero fixed vector would, by determinant one and
   semisimplicity in characteristic zero, force the entire representation
   to be fixed. Thus its ramification has a single break. The conductor
   exponent 6 makes this break 2. Since `chi` has break at most 2,
   the twist has conductor exponent at most 6. Unramified quadratic
   restriction at 2 preserves the conductor exponent of the descent.
5. At 3, (FM8) is additive potentially good with Swan conductor zero.
   The character is unramified and `K_3/Q_3` is tamely ramified quadratic.
   Each of the two extensions is consequently tame and has conductor
   exponent at most 2. The conductor-of-induction formula makes their
   sum `2+2=4`; hence both exponents equal 2. The determinant at 2 has
   conductor exponent 2, so the descended exponent there is at least 2.
6. The big-image input is the **general Q-curve** Theorem 5.2 of the same
   paper: squarefree isogeny degree and some multiplicative prime greater
   than 3. FM3 verifies these geometric hypotheses; they do not involve
   replacing seed coordinates by the nonprimitive pair `(3y,3x)`.
   The source lists the bound `N_3=7`. Its small-prime improvement uses
   Koutsianas, Proposition 5.4, whose auxiliary newform statement was also
   checked directly. This use is external published input, not a newly
   verified modular-symbol computation in this repository.
7. Large image, odd descent, and the finite-flat condition at `p` give
   Serre weight 2 and the displayed prime-to-`p` levels. At 2 and 3 the
   finite inertial images have order supported at 2 and 3, so reduction
   modulo `p>7` preserves their conductor. The character remains
   `epsilon` modulo `p`.

Sources actually opened:

* Pacetti--Villagra Torcomian, *Q-curves, Hecke characters and some
  Diophantine equations*, Theorems 3.2, 4.1, proof of 4.2, and 5.2:
  https://sweet.ua.pt/apacetti/papers/Q-curves.pdf .
* Koutsianas, *On the generalized Fermat equation a^2+3b^6=c^n*,
  arXiv:1805.07127v4; Propositions 3.6--3.9 explain the same local
  finite-flat/unramified mechanism, and Proposition 5.4 supplies the
  auxiliary newforms for the bound improvement:
  https://arxiv.org/pdf/1805.07127 .

## FM6. A residual-level budget directly in terms of lambda

Let `p>7` be prime and `F=VQ^p`, where `V` is `p`-power-free and `p` does
not divide `V`. Then the same construction gives a weight-two newform with
character `epsilon=psi_3` and exact prime-to-`p` level

\[
 N=2^e3^2\operatorname{rad}(V),\qquad 2\le e\le6.             \tag{FM15}
\]

Indeed, the curve is still the same Q-curve and still has a multiplicative
prime greater than 3, so the generic large-image theorem is unchanged.
At a prime `q>3`, the two minimal discriminant valuations are `m,2m`,
where `m=v_q(V)+p v_q(Q)`. The residual inertia for a Tate curve is
nontrivial precisely when `p` does not divide the valuation of its Tate
parameter. Since `p` is odd, the two primes therefore contribute conductor
one precisely when `q|V`. At `q=p`, our condition `p` does not divide `V`
ensures finite flatness as before. The proof of FM5 at 2 and 3 is unchanged.
Note that `gcd(V,6)=1`, since `V|F`.

For `lambda=max(1,log V)/p`, (FM15) yields the explicit height-independent
level inequality

\[
 \frac{\log N}{p}\le\lambda+\frac{\log576}{p}.               \tag{FM16}
\]

There is also a simple dimension budget, which counts **all** the possible
residual integers within the bound, not merely a fixed `V`. For a level
in (FM15), put `D=rad(V)`. The modular-group index satisfies

\[
 I=[\mathrm{SL}_2(\mathbb Z):\Gamma_0(N)]
   =2N\prod_{q\mid D}(1+q^{-1})
   \le 2ND\le1152V^2.                                      \tag{FM17}
\]

The weight-two Sturm bound gives dimension at most `floor(I/6)+1`, hence
at most `193V^2`, even if we bound by the whole space rather than its
newspace. Summing over the five possible 2-adic exponents gives at most
`965V^2` dimensions. Consequently, for any `L>=0`, the sum of newspace
dimensions over all `1<=V<=exp(Lp)` satisfying the required hypotheses is
at most

\[
 965\exp(3Lp).                                               \tag{FM18}
\]

We may include inadmissible `V` in this upper bound: writing
`H=floor(exp(Lp))`, there are at most `H` summands, each at most `965H^2`.
Thus `L->0,p->infinity` gives a subexponential dimension budget. The bound
counts a Galois orbit with its coefficient-field degree, as a vector-space
dimension does; it is not just an orbit count. The index and Sturm-bound
conventions were checked against PARI's primary modular-form documentation:
https://pari.math.u-bordeaux.fr/dochtml/html-stable/Modular_forms.html#mfsturm .

This does not make the candidate spaces empty or bound the height of a
seed. A small value of `lambda` does not imply `p` does not divide `V`,
so that branch cannot be discarded. The subsequent FM7 supplement
`nonflat_weight_budget.md` includes it at weight `p+1`; uniform candidate
elimination remains open in both weight branches.
Likewise the pure branch of FM5 already has nonempty candidate spaces.

## What remains and how this meets the compression question

The spaces in (FM14) must be computed and
their candidate eigenforms tested against the actual seed family and
the inverse square gate. Their existence would be a necessary condition,
not a contradiction. We have not ruled out a single remaining newform.
For `V>1`, FM6 gives a level budget on the specified `p`-prime-to-`V`
branch. FM7 adds the non-finite-flat weight branch to the budget.
Elimination uniformly across these varying levels and weights remains
open.

The route addresses precisely the large odd-prime divisors of a pure
second-norm exponent left by PL5: if `p|g`, rewrite `Q^g=(Q^{g/p})^p`.
A contradiction for all sufficiently large `p` here, together with the
earlier fixed-exponent finiteness, would imply finiteness of the pure-power
seeds admitting an exponent `g>=3`. The exponent-two branch has a known
infinite family and is not included in that proposed implication.
No such contradiction has yet been obtained.
The moving-support Kummer-cover and point-height routes remain separate
and open. This note is an additional arithmetic-modular dependency chain,
not a replacement for them.

## Computation scope

`frey_local_probe.gp` calls PARI/GP 2.15.4 `elllocalred` on all 159 coprime
pairs `1<=a,b<=16`; the outputs agree with FM8 and FM12. This finite
computation suggested the coordinate changes. The ordinary universal
proof is the divisibility and Tate-branch argument above, not the sample.
The PARI package was obtained from the official Ubuntu package archive;
no Sage installation or external computation service was used.
