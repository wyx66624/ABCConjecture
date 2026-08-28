# Moving primitive divisors do not close the Chebyshev branch

## 1. Scope and verdict

Write

\[
 p=2m+1,\qquad H_p(X)=\frac{T_p(X)}{X},\qquad
 y^2=4T_p(X)+5,
\]

where `p>=31` is an odd prime, `5 \nmid p`, and the live ramified Pell
branch has `X=5A_5` and `X \equiv 23 (mod 24)`.  Here and below
`A_5=X/5` is the five-adic quotient; it is not a neighboring squarefree
kernel.  This note audits whether a primitive divisor which is allowed to
move with `p` can close that branch.

The answer for the presently available primitive-divisor package is **no**.
The exact-order congruence, splitting in `Q(sqrt(5))`, quadratic
reciprocity, an arbitrarily prescribed positive valuation of the primitive
factor, and the genuine Pell fundamental-unit constraints are mutually
compatible at every prescribed finite five-adic depth.  This is an
unconditional no-go statement about that package; it is not a claim that
the global integer equation has a solution.

There are three positive results, the second coming from the separate
Bennett--Walsh/Cohn companion.

1. Granville's direct Theorem 3 odd-valuation result cannot be reached by
   an equivalent integral Lucas or Lehmer normalization: its hypothesis
   `c \equiv 2 (mod 4)` contradicts coprimality invariantly.
2. Bennett--Walsh Theorem 1.2, Cohn's coefficient-one theorem, and
   Granville Corollary 5 together exclude both `H_p(X)=z^2` and
   `H_p(X)=p z^2`.  Hence `H_p(X)` does have a primitive prime divisor of
   odd exact multiplicity.  This stronger theorem still does not contradict
   the split norm in `Q(sqrt(5))`.
3. Independently, if the exceptional shape were `H_p(X)=p z^2`, then the
   actual residue `X \equiv -1 (mod 24)` forces `p \equiv 1 (mod 24)`.  Together
   with `p \equiv \pm1 (mod 5)`, this leaves `p \equiv 1,49 (mod 120)`.
   This remains a useful kernel-checked cross-check, although the companion
   theorem now excludes the shape globally.

The finite algebra and an explicit `p=41` diagnostic are checked in
`IUTThreeClosures/FreyPellChebyshevMovingPrimitiveNoGoCore.lean`.

## 2. Exact Lucas and Lehmer normalizations

Put

\[
 \lambda=X+t\sqrt D,\qquad \lambda^{-1}=X-t\sqrt D,
 \qquad \lambda+\lambda^{-1}=2X,
\]

with `X^2-Dt^2=1`.  Then

\[
 H_p(X)
 =\frac{\lambda^p+\lambda^{-p}}{\lambda+\lambda^{-1}}
 =\lambda^{1-p}\Phi_{4p}(\lambda).
\]

Equivalently, for the Lucas sequence with roots `lambda,lambda^{-1}` and
parameters `(P,Q)=(2X,1)`, `H_p(X)` is its cyclotomic atom at index `2p`.
For the Lehmer pair whose root ratio is `-lambda^2`, it is the corresponding
Lehmer term at index `p`.  These are identities, not heuristic analogies.

The hypotheses in the Bilu--Hanrot--Voutier terminology are visible here.
For the Lucas pair `(lambda,lambda^{-1})`, the sum and product are the
coprime nonzero rational integers `2X` and `1`, and the root ratio
`lambda^2` is not a root of unity because `X>1`.  For the Lehmer pair
`(alpha,beta)=(lambda,-lambda^{-1})`,

\[
 (\alpha+\beta)^2=4(X^2-1),\qquad \alpha\beta=-1,
\]

so the two rational-integer parameters are again nonzero and coprime, while
`alpha/beta=-lambda^2` is not a root of unity.  Thus BHV Theorem 1.4 applies
at the prime Lehmer index `p>30` (or at the corresponding Lucas atom).

Let `L_n` be the Lucas sequence with roots `lambda,lambda^{-1}`.  For
positive discriminant, Carmichael's Theorem XXI supplies a characteristic
prime at the Lucas index `2p`; the exceptional indices `1,2,6` and the
two signed Fibonacci forms at index `12` do not occur in the live range.
This prime is
automatically primitive in Schinzel's sense.  Indeed `2` already occurs in
`L_2`.  If an odd prime `q` divides the discriminant, then `X=+/-1 (mod q)`
and

\[
 L_n\equiv n(\mathord{+/-}1)^{n-1}\pmod q.
\]

Thus `q|L_(2p)` would force `q=p`, but then `q|L_p` already, contradicting
characteristicity at `2p`.  The characteristic prime therefore does not
divide the discriminant and divides the cyclotomic atom `H_p(X)`.  Hence
the Bilu--Hanrot--Voutier theorem is stronger than is needed merely to
obtain a primitive prime in this positive-discriminant family.  BHV
Theorem 1.4 remains a second accepted route: every Lucas or Lehmer term of
index greater than `30` has a primitive divisor.

Neither theorem controls the parity of that prime's valuation.

## 3. Granville's hypothesis cannot be recovered by reparameterization

Granville writes a Lucas recurrence as

\[
 x_{n+2}=b x_{n+1}+c x_n,
 \qquad R+S=b,\qquad RS=-c,
\]

with nonzero coprime integers `b,c`.  His Theorem 3 assumes
`c \equiv 2 (mod 4)` and positive discriminant, and then gives a primitive
prime which occurs to an odd power (apart from indices `1,2,3,6`).  The
preceding Theorem 2 is the corresponding characteristic-prime statement
(with exceptions `1,2,6`); the primitive conclusion used in this audit is
Theorem 3.

Suppose first that an integral reparameterization preserves the Lucas root
ratio, up to inversion:

\[
 R/S=\lambda^2\quad\hbox{or}\quad\lambda^{-2}.
\]

The ratio alone gives

\[
 \frac{b^2}{RS}=\frac{(R+S)^2}{RS}
 =\lambda^2+2+\lambda^{-2}=4X^2,
\]

and hence

\[
 b^2=-4cX^2. \tag{3.1}
\]

For the Lehmer ratio `R/S=-lambda^2` (again allowing inversion), the same
calculation gives

\[
 \frac{b^2}{RS}=2-\lambda^2-\lambda^{-2}
 =-4(X^2-1),
 \qquad b^2=4c(X^2-1). \tag{3.2}
\]

If `c \equiv 2 (mod 4)`, then `2|c`; either (3.1) or (3.2) makes `b^2`
even, hence `2|b`, contradicting `gcd(b,c)=1`.  This includes common
scaling of the two roots whenever the new parameters remain integral,
changing both root signs, swapping the roots, and inverting the root ratio.
The two contradictions are kernel-checked as
`granville_lucasRatio_no_coprime` and
`granville_lehmerRatio_no_coprime`.

The scope matters.  This rules out a legitimate equivalent recurrence
which preserves the algebraic root ratio.  It does not rule out an
unrelated recurrence whose one numerical term happens to equal
`H_p(X)`.  No uniform identity of that unrelated kind is presently known.
Granville's Section 7 statement for general non-periodic Lucas sequences
is explicitly a conjecture, not an accepted theorem.

## 4. What reciprocity actually says

Let `q` be an odd primitive prime of `H_p(X)`, away from `2pD`, and set

\[
 \chi=\left(\frac Dq\right)\in\{1,-1\}.
\]

Primitivity says that `lambda` has exact order `4p` in the norm-one group,
so

\[
 4p\mid q-\chi. \tag{4.1}
\]

Reducing (4.1) modulo `4` gives `q \equiv chi (mod 4)`.  Therefore

\[
 \left(\frac{-1}{q}\right)=\chi,
 \qquad \left(\frac{-D}{q}\right)=1. \tag{4.2}
\]

Quadratic reciprocity also gives, in both the split and nonsplit cases,

\[
 \left(\frac pq\right)=1. \tag{4.3}
\]

Indeed, if `chi=1`, then `q \equiv 1 (mod 4p)`.  If `chi=-1`, both the
factor `(q/p)=(-1/p)` and the reciprocity sign equal
`(-1)^((p-1)/2)`, so they cancel.

The exact factorizations

\[
 T_p(Z)+1=(Z+1)S_-(Z)^2,
 \qquad T_p(Z)-1=(Z-1)S_+(Z)^2
\]

for odd `p`, evaluated at `T_p(X)=0 (mod q)`, yield

\[
 \left(\frac{X+1}{q}\right)=1,
 \qquad
 \left(\frac{X-1}{q}\right)=\left(\frac{-1}{q}\right)=\chi. \tag{4.4}
\]

Thus, if the neighboring Pell decompositions are

\[
 X-1=Ka^2,\qquad X+1=3Bb^2,
\]

then `(K/q)=chi` and `(3B/q)=1`.  These are consistent requirements, not
a reciprocity contradiction.  The active five-split condition is also
consistent: choose the split branch `q \equiv 1 (mod 5)`.  The congruence
`X \equiv 23 (mod 24)` concerns a different modulus and is combined by
CRT.  No fourth-power datum is forced by the equation, so quartic
reciprocity has no additional input on which to act.  Even requiring `5`
to be a fourth power is compatible, as the explicit example below shows.

## 5. The valuation remains free at first rank

At a primitive root `X_0 (mod q)`, differentiation gives

\[
 H_p'(X_0)=\frac{pU_{p-1}(X_0)}{X_0}\ne0\pmod q.
\]

Here `X_0` is nonzero, `q` does not divide `p(X_0^2-1)`, and
`T_p^2-1=(X^2-1)U_{p-1}^2` shows that `U_{p-1}(X_0)` is nonzero.  Hence
the root is simple.  Its unique Hensel lift has one distinguished next
digit.  At level `q^(e+1)`, choosing any of the other `q-1` digits after
agreeing through level `q^e` gives

\[
 v_q(H_p(X))=e.
\]

This realizes every positive valuation locally, including every even and
odd valuation.

Alecci--Miska--Murru--Romeo, Theorem 14, completely describes the
valuation of a Lucas atom at a prime `q` not dividing the second parameter.
In their notation the present Lucas recurrence has parameters
`(s,t)=(2X,-1)`; the primitive prime has `q>=3`, hence `q` does not divide
`t`, and its first rank is `k=2p`.  At `n=k` their formula is precisely
`v_q(P_k)=v_q(U_k)`; it places no parity or size restriction on that first
valuation.  The value becomes exactly one only at the later indices
`k*q^h`.  Our atom occurs at the first rank `k=2p`, so this modern complete
formula confirms rather than removes the obstruction.

Largest-prime-factor estimates such as Stewart's Theorem 1 are also not a
closure: their constants depend on the sequence/field, which moves with
`X`, and they provide neither an upper bound nor valuation parity.

## 6. A genuine fundamental-Pell compatibility family

The following template keeps the neighboring squarefree kernels and the
fundamental-unit condition, rather than only the scalar residue of `X`.
For a positive integer `B`, put

\[
 C=24B-1,\quad K=2C,\quad X=48B-1,\quad
 D=6BC=3KB.
\]

Then

\[
 X-1=K,\qquad X+1=3B\cdot4^2,
 \qquad X^2-D\cdot4^2=1. \tag{6.1}
\]

If `B \equiv 23 (mod 24)` and both `B,C` are squarefree, then `K,B` are
positive coprime squarefree integers, `3 \nmid KB`, and

\[
 K\equiv22\pmod{24},\quad X\equiv23\pmod{24},
 \quad D\equiv6\pmod8.
\]

Indeed `gcd(B,C)=1`, while `B,C` are odd and neither is divisible by `3`;
therefore `K=2C` and `B` are coprime squarefree and `D=6BC` is squarefree.

Moreover `X+4sqrt(D)` is the fundamental positive norm-one unit.  Since
`D \equiv 2 (mod 4)`, the ring of integers is `Z[sqrt(D)]`.  First, the
negative Pell equation is impossible modulo `8`: its right-hand square
residue would have to be `5` for odd `y` or `7` for even `y`.  Thus every
unit strictly between `1` and `X+4sqrt(D)` has positive norm.  Writing it
as `x+y sqrt(D)`, positivity gives `x>0`, and monotonicity of the positive
norm-one expression in `y` gives the integer bound `0<y<4`.  Odd `y` is
impossible modulo `8`.  If `y=2`, then `4x^2=X^2+3`, so
`(2x-X)(2x+X)=3`; both factors are positive and this would force `X=1`,
contrary to `X>=47`.  Hence the displayed unit is the least unit greater
than one, and no negative-norm unit changes the generator.

The live application has `p>=31`, but the following compatibility
construction itself works for any odd prime `p` with `5 \nmid p`.  Fix
such a `p`, a finite five-adic depth `N>=1`, and a desired exponent `e>=1`.

1. By Dirichlet choose a prime
   `q \equiv 1 (mod lcm(20p,24))`.
2. By cyclicity of `F_q^*`, choose `lambda` of exact order `4p` and put
   `X_0=(lambda+lambda^{-1})/2`.  Then `X_0` is neither `0` nor `+/-1`,
   `q` is primitive for `H_p`, and `5` is a square modulo `q`.
3. Use the simple root to select one class modulo `q^(e+1)` in which
   `v_q(H_p(X))=e`.
4. Use the already proved five-adic implicit-function graph for the actual
   equation to select an `X=5A_5` class giving a solution modulo `5^N`.
5. Transport both classes through `X=48B-1`, add `B=23 (mod 24)`, and
   combine them by CRT.

For primes outside the fixed CRT modulus, squarefreeness of `B` and
`24B-1` removes at most two residue classes modulo `ell^2`.  If
`rho(ell)<=2` is the exact number removed, the finite-sieve density is
`product(1-rho(ell)/ell^2)`, bounded below by the positive convergent
product `product(1-2/ell^2)`; the unsieved tail is
`O_W(M/R+sqrt(M))` among the first `M` progression terms, where the
implicit constant may depend on the fixed progression modulus `W`.

The primes in the fixed modulus `24*5^N*q^(e+1)` are admissible explicitly.
The class `B=23 (mod 24)` makes both `B` and `C=24B-1` units at `2,3`.
At `5`, `X=48B-1 \equiv0` gives `B\equiv C\equiv2 (mod 5)`.  At `q`, the identities
`48B=X+1` and `2C=X-1`, together with `X_0 != +/-1`, make both forms units.
Thus no prime dividing the progression modulus forces a square factor.
The standard simultaneous squarefree sieve for two linear forms therefore
gives infinitely many positive `B` in the combined progression.

Consequently every prescribed finite five-adic depth and every prescribed
positive primitive valuation are compatible with infinitely many genuine
fundamental Pell bases.  The target also has a `q`-adic square root because
it is `5 (mod q)` and `5` is a square; it has `2`- and `3`-adic square
roots because the right side is `1 (mod 8)` and `1 (mod 3)`.

This construction **does not** produce a global integer `y`.  It also does
not assert that one ordinary integer realizes an entire preselected
infinite five-adic path.  Its quantified conclusion is finite-depth local
compatibility, which is exactly what is required to refute a proposed
finite primitive-divisor/reciprocity sieve.

The polynomial identities and residue transport in this section are
kernel-checked by `primitivePellTemplate_identities`,
`primitivePellTemplate_residues`, and
`primitivePellTemplateX_map_modEq`.  Dirichlet, CRT, the squarefree sieve,
and the fundamental-unit interpretation are accepted mathematical
interfaces; no Lean axiom is introduced for them.

## 7. The modulo-24 cross-check

The recurrence congruence and the endpoint value give

\[
 X\equiv-1\pmod{24}\quad\Longrightarrow\quad
 H_p(X)\equiv H_p(-1)=1\pmod{24}. \tag{7.1}
\]

Every invertible square modulo `24` is `1`.  Therefore an actual equality
`H_p(X)=p z^2` implies `p \equiv 1 (mod 24)`.  Combining with
`p \equiv +/-1 (mod 5)` gives

\[
 p\equiv1\quad\hbox{or}\quad49\pmod{120}. \tag{7.2}
\]

These are the Lean theorems
`pellOddChebyshevQuotient_mod_twentyFour_of_negOne`,
`primeSquareShape_forces_index_mod_twentyFour`, and
`primeSquareShape_active_crt`.  By itself, (7.2) only removes the
`p`-times-square alternative for the other index classes and says nothing
about the ordinary-square alternative.  The separate file
`FREY_PELL_CHEBYSHEV_BENNETT_WALSH_ODD_VALUATION.md` now excludes both
shapes uniformly by Bennett--Walsh/Cohn and then applies Granville
Corollary 5.  Thus (7.2) is retained as an independent finite congruence
check, not as the strongest current exclusion.

## 8. Exact `p=41` diagnostic and its global failure

Take

\[
\begin{aligned}
 q&=19681, & \lambda&=3109,\\
 B&=12317469801647, & C&=295619275239527,\\
 K&=591238550479054, & X&=591238550479055,\\
 D&=21847688973285879210624605814.
\end{aligned}
\]

The exact certificates are:

- `q` is prime;
- `lambda^164=1`, `lambda^82=-1`, and `lambda^4=2180 != 1`
  modulo `q`, so `lambda` has exact order `164=4*41`;
- `lambda^{-1}=17573`, its half-trace is `10341`, and
  `X=10341 (mod q)`;
- `17873^2=D (mod q)` and `X+4*17873=lambda (mod q)`;
- `3016^4=5 (mod q)`, so even the stronger quartic-five condition is
  compatible;
- `287^2-5*27^2=4q`, so `q` splits in `Q(sqrt(5))` by an exact norm;
- `H_41(X) mod q^2 = q*15953`, hence `v_q(H_41(X))=1`;
- `X=23 (mod 24)`, `X=305 (mod 625)`, and `X=930 (mod 3125)`;
- with `y=5`, the target equation holds modulo `3125`.

The neighboring factors are

\[
 B=23\cdot31\cdot907\cdot2357\cdot8081,
 \qquad C=19\cdot71\cdot219139566523.
\]

The standard-library script
`audit_scripts/p41_moving_primitive_nogo_verify.py` deterministically checks
these factorizations and primalities (using the proven 64-bit
Miller--Rabin base set).  Hence this is a genuine instance of the squarefree
fundamental-Pell template, not just a trace residue.

Nevertheless `X=3 (mod 7)`, `T_41(X)=3 (mod 7)`, and

\[
 4T_{41}(X)+5\equiv3\pmod7,
\]

which is not a square.  Thus this explicit integer has **no global integer
`y`**.  The Lean theorem `p41Example_no_global_shiftedSquare` proves that
statement for every integer `y`.  The example demonstrates the intended
logical separation: a rich compatible local/primitive package is not a
global solution and not a counterexample to the original Diophantine
claim.

## 9. Difference from the earlier primitive-valuation audit

`FREY_PELL_CHEBYSHEV_PRIMITIVE_ODD_VALUATION_AUDIT.md` already recorded
the Lucas/Lehmer atoms, the order congruence, simple-root interpolation of
arbitrary valuations, the failure of the displayed standard Granville
normalization, and compatibility with the `Q(sqrt(5))` norm.

The present note adds:

1. the invariant root-ratio proof excluding **every** coprime integral
   equivalent normalization satisfying `c=2 (mod 4)`;
2. Carmichael's positive-discriminant theorem directly at index `2p`;
3. the exact symbols `(p/q)=1`, `(-D/q)=1`, `(X+1/q)=1`, and
   `(X-1/q)=chi`;
4. a simultaneous squarefree template proving finite-depth compatibility
   with genuine Pell fundamental-unit minimality;
5. the conditional modulo-24 cross-check on the `p*z^2` shape;
6. the separate Bennett--Walsh/Cohn exclusion of both Granville square
   shapes, which supplies an odd-multiplicity primitive divisor but no
   shifted-square contradiction;
7. an exact `p=41` scalar witness, including the modulo-seven global
   obstruction; and
8. the 2025 complete Lucas-atom valuation theorem, whose first-rank case
   explicitly leaves the valuation unrestricted.

## 10. Trust ledger

### 10.1 Lean-kernel checked

The new module checks, without `sorry`, `admit`, or a declared mathematical
axiom:

- both invariant Granville parity contradictions;
- all polynomial Pell-template identities and stated residues;
- the quotient congruence modulo `24` and the two CRT index classes;
- primality of `19681`;
- the displayed `p=41` arithmetic, finite-field order/trace/Pell data,
  exact first valuation, and target congruence modulo `3125`; and
- the modulo-seven proof that no global integer `y` exists for the
  displayed base.

The finite computations use ordinary kernel-reduced `decide` and
`norm_num`, not `native_decide`.  The displayed `#print axioms` output has
no `sorryAx`, declared mathematical axiom, or compiler-generated native
decision axiom; it contains only the standard `propext`,
`Classical.choice`, and `Quot.sound` profile as applicable.

### 10.2 Accepted mathematical interfaces

- Carmichael, Theorem XXI, and BHV, Theorem 1.4;
- Granville, Theorem 3, used only to audit its hypotheses (with Theorem 2
  separately identified as the characteristic-prime version);
- Bennett--Walsh, Theorem 1.2, the occurrence fact in the proof of Lemma
  3.3, Lemma 5.1, and Corollary 1.5, together with Cohn's 1997 theorem and
  Granville Corollary 5, in the separate odd-valuation companion;
- Dirichlet's theorem, Hensel's lemma, quadratic reciprocity, CRT, and the
  standard square criteria over `Z_2` and `Z_3`;
- cyclicity of the multiplicative group of a finite field;
- the elementary simultaneous squarefree sieve for two primitive linear
  forms in a fixed admissible progression;
- the elementary Pell minimality argument of Section 6 used to call the
  template unit fundamental; and
- deterministic primality/factorization computation in the companion
  script.

No accepted interface is installed as a Lean axiom.

### 10.3 Not claimed

- no global integer solution is produced by the local construction;
- no single ordinary integer is claimed to follow an arbitrary infinite
  five-adic path;
- no quartic reciprocity obstruction is asserted without a fourth-power
  input;
- no odd-valuation conclusion is inferred from BHV or the failed direct
  Granville-Theorem-3 normalization alone; the separate companion obtains
  it from Bennett--Walsh/Cohn plus Granville Corollary 5;
- no open squarefree-value conjecture for nonlinear polynomials is used;
  only two linear forms are sieved; and
- no conclusion about the abc conjecture follows from this no-go package
  alone.

## 11. Primary sources

1. R. D. Carmichael, *On the Numerical Factors of the Arithmetic Forms
   alpha^n +/- beta^n*, Part II, Annals of Mathematics 15 (1913--1914),
   49--70, Theorem XXI.
   [DOI 10.2307/1967798](https://doi.org/10.2307/1967798).
2. Y. Bilu, G. Hanrot, and P. M. Voutier, *Existence of primitive divisors
   of Lucas and Lehmer numbers*, Journal fuer die reine und angewandte
   Mathematik 539 (2001), 75--122, Theorem 1.4.
   [DOI 10.1515/crll.2001.080](https://doi.org/10.1515/crll.2001.080).
3. A. Granville, *Primitive prime factors in second-order linear recurrence
   sequences*, Acta Arithmetica 155 (2012), 431--452, Theorems 2--3,
   Corollaries 3--5, and Section 7.
   [Author PDF](https://dms.umontreal.ca/~andrew/PDF/PrimitivePrimeFactors.pdf),
   [DOI 10.4064/aa155-4-7](https://doi.org/10.4064/aa155-4-7).
4. G. Alecci, P. Miska, N. Murru, and G. Romeo, *On alternative definition
   of Lucas atoms and their p-adic valuations*, Monatshefte fuer Mathematik
   207 (2025), 175--196, Theorem 14.
   [DOI 10.1007/s00605-025-02087-w](https://doi.org/10.1007/s00605-025-02087-w),
   [author repository copy](https://iris.polito.it/retrieve/handle/11583/3005009/948935).
5. C. L. Stewart, *On divisors of Lucas and Lehmer numbers*, Acta
   Mathematica 211 (2013), Theorem 1.
   [Author preprint, arXiv:1008.1274](https://arxiv.org/abs/1008.1274).
6. M. A. Bennett and G. Walsh, *The Diophantine equation
   `b^2 X^4-dY^2=1`*, Proceedings of the American Mathematical Society 127
   (1999), 3481--3491, Theorem 1.2, the proof of Lemma 3.3, Lemma 5.1, and
   Corollary 1.5.
   [DOI 10.1090/S0002-9939-99-05041-8](https://doi.org/10.1090/S0002-9939-99-05041-8).
7. J. H. E. Cohn, *The Diophantine equation `x^4-Dy^2=1`, II*, Acta
   Arithmetica 78 (1997), 401--403.
   [DOI 10.4064/aa-78-4-401-403](https://doi.org/10.4064/aa-78-4-401-403).
