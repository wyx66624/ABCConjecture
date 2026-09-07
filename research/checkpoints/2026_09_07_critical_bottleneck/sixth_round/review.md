# Sixth-round ordinary review notes

Date: 2026-09-07. Earlier manuscript rounds remain frozen.

## Parent's universal actual Lucas bridge

Let O=Z[zeta], zeta^2-zeta+1=0, N(a+b*zeta)=a^2+ab+b^2 and
P(a+b*zeta)=ab(a+b). For every w=a+b*zeta define

    tau(w)=w^3+bar(w)^3=2a^3+3a^2b-3ab^2-2b^3,
    q=N(w)^3.

The parent proposed the universal polynomial identity

    P(w^2 z)+q P(z)=tau(w)P(w z).                               (L1)

I independently checked its ordinary proof and its unrestricted scope.
Set eta=w^3. Its quadratic identity is eta^2-tau(w)eta+q=0.
Multiplying by z^3 and subtracting the conjugate gives (L1), because

    x^3-bar(x)^3=3sqrt(-3)P(x)

for every x in O. This is an identity of integer polynomials in the
four coordinates of w,z; no primitive, nonzero or unramified assumption
is needed, and cancellation can equally be replaced by direct polynomial
expansion for a formal implementation.

Define the integer Lucas sequence U_0=0, U_1=1 and
U_(n+2)=tau(w)U_(n+1)-q U_n. The actual sequence D_n=P(w^n)
has D_0=0, D_1=P(w), and the same recurrence by (L1). Induction proves

    P(w^n)=P(w)U_n                                              (L2)

for all n>=0, including zero w or P(w)=0. Thus P(w) divides P(w^n)
as an actual integer divisibility statement for every n. A useful
general shifted version, also proved by the same recurrence and its
two initial values, is

    P(w^(n+1)z)=U_(n+1)P(wz)-q U_n P(z)                         (L3)

for n>=0. These ordinary statements are appropriate for the parent's
proposed actual polynomial/recurrence formalization. They do not assert
that the full cyclotomic packet budget or analytic saving is formalized.

## Adversarial actual root-height block: preliminary full derivation check

The adversarial agent proposed a new actual averaging block. Fix n>=1,
B>=1, take the B integer roots w_k=3k+zeta with B<=k<2B, and let
t_k be the logarithmic largest-side height of w_k^n. For p>3 set
m=n/p^{v_p(n)} and G_m(T)=P((3T+zeta)^m).

Every root of G_m modulo p is norm-unit: if one conjugate factor were
zero, the cubic difference equation would force both to be zero,
contradicting the second coordinate one. Therefore the fractional-linear
ratio derivative is valid in either the split algebra or its quadratic
residue field. Since p does not divide 3m, every root is simple.
There are at most 3m roots, and each lifts uniquely to every precision.
The number of k in the actual integer interval with p^e dividing G_m(k)
is therefore at most 3m(B/p^e+1).

The homogeneous rank law gives the first depth at this prime as
v_p(G_m(k)) on a hit; the additional exponent lifting is v_p(n).
The height cap is log|G_m(k)|<=3m log(6B+1), and t_k>=n log(3B).
Summing e>=4 gives, per prime, the total first-depth positive cost at
most

    3m B log p/[p^3(p-1)] + 9m^2 log(6B+1).

After summing Y<p<=Z and dividing by the common block height lower
bound, the asserted mean estimate is

    mean_k [sum_{Y<p<=Z}(v_p(P(w_k^n))-3)_+ log p]/t_k
      <=10 log Y/[Y^3 log(3B)]
        +18n pi(Z)/B+log n/[n log(3B)].                          (L4)

I checked the constants: m<=n, the elementary convergent prime sum has
the displayed generous coefficient ten, and 6B+1<=(3B)^2 gives the
factor eighteen. The final lifting sum is at most log n. For B=n^2,
Z=floor(n/(log n)^2), and Y=n^(1/6), the crude bound pi(Z)<=Z alone
gives a mean of order (log n)^(-2)+n^(-1/2). Markov at threshold
1/log n leaves an exceptional proportion of order 1/log n.

This is an average over actual integer roots of norm comparable to n^4,
not an assertion that the output of a power map is uniform. It controls
only the stated moving prime window. The primes above Z and the
exceptional roots remain uncontrolled. The complete ordinary draft is
subsequently written by the adversarial agent. I read its complete
`sixth_round/root_height_windows.md` RW1--RW6 and approved all ordinary
proofs, including the rank-stratified improvement and its explicit
Markov constants. The window up to B/(log n)^2 has only the stated
finite-window conclusion; no exceptional root or larger prime is
implicitly included.

## Independent exact rank-stratified replay

I wrote and ran `rank_root_replay.py`, then ran its stored-payload
`--check` mode. Both passed. The payload covers 21 complete local
precision enumerations (including depths four at primes five and seven),
24 actual integer blocks, 1,592 first-depth/LTE values, 891 actual
interval-depth inequalities, and 632 progression/totient checks.
The canonical SHA-256 is
d4dfd5aeebe2d2eb55dcf119aa578a4f392d10ae67360afa9508c7afaf84ebe4.
Finite probabilities and counts are exact integers or fractions. The
local lift counts are obtained by enumerating every residue parameter,
not by generating counts from the asserted Hensel formula.

## Parent's actual quartic-subfield cover refinement

I checked the complete derivation supplied by the parent before its
full draft. For L=Q(alpha), alpha a root of F, one has degree four and
signature (0,2). Since the order discriminant is 117, the field
discriminant has absolute value at most 117. The Minkowski class bound
is (3/(2*pi^2))*sqrt(117)<11/6<2. Every ideal class therefore has
an integral norm-one representative, so the class number is one.
I independently reopened Milne's primary `ANT.pdf`, Theorem 4.3 on
printed page 70, to check the exact class bound and its signature factor.

For actual a-alpha*b and a good prime dividing its norm, b is a unit
modulo p. The linear residue alpha=a/b and good index condition select
exactly one degree-one prime ideal; no other prime over p divides that
element. At thirteen, norm depth one forces exactly one prime ideal
of residue degree one and ideal valuation one. Three is absent.
Consequently the g-free remainder ideal has norm exactly V, not V^4
or V^8, and admits at most 4*4^omega(V) choices. Class number one
makes both ideal factors principal. The rank-one unit quotient has
at most w_L*g classes, and all four embeddings of the one actual
element are coupled. Thus at most 4*w_L*4^omega(V)*g constructed
three-ratio covers are required. This works for g>=3, with no g>8
restriction and no adjoining of all g-th roots of unity arithmetically.

The proposed coefficient bound h(xi)<=0.5log(V)+C*g follows from
balanced principal generators in L and the usual height inequalities.
I additionally supplied the following valid improvement: balance delta
so every complex log modulus is log(V)/4+O_L(1). All archimedean
ratios of its conjugates are then bounded independently of V. The
denominator ideal of xi in the degree-eight splitting field divides
the ideal of one conjugate of delta, of norm V^2. Its normalized finite
height contribution is at most log(V)/4. Unit representatives add
O_L(g) only archimedean height. Thus h(xi)<=log(V)/4+C*g is also
available if the full coefficient proof records both places separately.
Neither estimate bounds the height of an actual rational point on a
cover. A final review of the parent's written refinement remains pending.

## Root-window final TeX transcription

I read the complete adversarial file
`sixth_round/paper/root_height_windows.tex` after the RW5--RW6 integration.
The transcription passes: the actual integer interval is retained; the
exact-rank root count is `3 phi(d)-1_(d=1)`; the progression counting
removes the rank from the endpoint error; and the resulting error is
`12(Z+1)/B`. Both the `B=n^4,Z=n^3` application and the window up to
`B/(log n)^2` keep their stated exceptional sets and larger-prime boundary.
The internal compact-payload seal of my rank replay is the `d4df...` value
above; the UTF-8 JSON file's byte SHA is
`7eefa2aa8936d2125dc5851456d9036eaf4666a00ea4daf211c4b54dc02a56fd`.
These are different hash objects. The adversarial reviewer independently
read the replay and ran its read-only `--check` successfully.

## Frey Q-curve modular entry: FM1--FM5 independent review

I read `2026_09_07_independent_route/sixth_round/frey_modular_entry.md`
in full and checked the representation chain separately from its local
Tate proof. The ordinary necessary-condition statement passes, subject
to the explicitly named established modularity, big-image and Serre
inputs. It is not a non-existence result and has no Lean verification.

The exact quartic and inverse square gate in FM1 are correct. The model
in FM3 is the generic degree-two Frey construction with parameters
`A=3y,B=3x`, so its isogeny identity applies without a primitive Fermat
equation hypothesis. Its local conductor must be recomputed; FM4 does
this with actual Tate branch tests. I checked the displayed coordinate
changes and parity congruences. The inert-prime integral basis test
uses the norm valuation with residue degree two correctly. FM4 yields
`a_2(E)=6,a_3(E)=2`; the adversarial agent independently audited that
full local proof as well.

I actually opened Pacetti--Villagra Torcomian, arXiv 2007.11486v3,
Theorem 3.2 and Table 3.3, the proof of Theorem 4.2, Theorem 4.1 and
Theorem 5.2. At d=3 their character has order four, conductor dividing
the third power of the prime above two, and no ramification at three.
Its square is the restriction of the even quadratic character of
conductor twelve, and it cancels the conjugation twist by minus two.
The extension proof is applicable to the actual non-CM Q-curve. Its
oddness step explicitly invokes Ribet's general Q-curve result; Schur's
lemma alone only supplies an extension, not its oddness. Oddness then
fixes the determinant to epsilon times the cyclotomic character.

Here is the independent local conductor argument after twisting.
At two, `v(c4)=6,v(Delta)=12`, so the curve is potentially good.
The finite inertia representation has trivial determinant. On any
higher ramification subgroup its invariant space therefore has dimension
zero or two: finite-group semisimplicity in characteristic zero and a
fixed line force the other character to be trivial. Its single upper
break is two, since its Artin conductor is six. Twisting by a character
with break at most two keeps conductor at most six. Unramified quadratic
restriction at two preserves the conductor. The determinant already
has conductor exponent two, giving the lower bound two.

At three, the original representation is tame and the twisting character
is unramified. The wild inertia of Q_3 lies in G_(K_3), so both descents
are tame. Induction of the restriction is the sum of the two quadratic
twist descents; its conductor is `2*1+1*2=4`. Each tame two-dimensional
representation has conductor at most two, forcing both to have
conductor exactly two. The finite inertia images at two and three have
orders supported at two and three, including the character twist and
quadratic descent. Reduction modulo p>7 preserves their invariants
and conductors.

Away from 2,3,p the actual minimal discriminant valuations `m,2m`
are multiples of p when `F=Q^p`, and the residual representation is
unramified. At p the same multiplicative-reduction case has a Tate
parameter with valuation divisible by p. Its Kummer class is represented
by a unit, which supplies a finite flat model for the residual extension;
good reduction supplies one directly. Unramified twisting and descent
through the unramified extension at p preserve this condition.

I also opened Koutsianas, arXiv 1805.07127, Propositions 3.6--3.9,
5.1--5.4 and the following p=13 discussion. Proposition 5.4 supplies
the small-prime auxiliary-form improvement used by the general
Q-curve theorem in the version of Pacetti--Villagra Torcomian just
checked. I use that complete published big-image input with N_3=7,
not only the split-Cartan proposition that excludes p=13 from its
own statement. The displayed two-isogeny has minimal degree two:
otherwise a degree-one isomorphism to the conjugate would produce a
degree-two endomorphism of a non-CM elliptic curve, impossible since
its endomorphism degrees are squares. Thus the squarefree-degree
hypothesis has been verified rather than assumed.

These facts, with the established strong Serre theorem and its finite
flat weight-two criterion, imply the necessary levels
`36,72,144,288,576`, character epsilon=psi_3, for a prime exponent p>7.
No primitive-equation conductor from the source is imported. Computing
the newform spaces and ruling out their actual seed congruences are
separate tasks; this review asserts no elimination of a surviving form.

Primary sources inspected:

* https://arxiv.org/html/2007.11486v3
* https://arxiv.org/pdf/1805.07127

## FM6 and the final modular-entry transcription

The moving residual-support extension passes independent ordinary
review. If `F=V Q^p`, V is p-power-free and p does not divide V,
then at a prime q>3 the residual multiplicative monodromy is nonzero
exactly when q divides V. The prime-to-p level is therefore exactly
`2^e*9*rad(V)`, with `2<=e<=6`. The finite flat argument at p still
holds under its explicit extra premise. Small lambda does not imply
that premise, and the omitted branch p|V remains open.

I checked the dimension budget independently. The index of Gamma_0(N)
is `2N product_(q|V)(1+1/q) <= 1152 V^2`, since V is prime to six.
The weight-two Sturm bound gives dimension at most `1+I/6`; the sum
over the five candidate levels is at most `965V^2`. Summing over
all V<=exp(Lp), including inadmissible V as an upper bound, gives
`965 exp(3Lp)`. This is a subexponential candidate-space dimension
budget for L tending to zero. It does not eliminate a form or bound
the height of a compatible seed.

I read the full `sixth_round/paper/frey_modular_entry.tex` and specifically
approved both `fm-five-levels` and `fm-residual-budget` and their proofs.
I reported one transcription typo outside those two subsections:
the integral-basis display contained literal `quad` rather than
the spacing command. The author was notified to fix it and to state
the positive integer domains of V,Q explicitly. Neither changes
the reviewed mathematics.

## Actual non-CM boundary shadow: independent full review

I read the adversarial `sixth_round/boundary_shadow.md`, BS1--BS3,
and the complete `replay_boundary_shadow.py`. I independently ran
its read-only `--check`: PASS, all three complete field point counts
and sixteen illustrative integer shadows matched the stored UTF-8 LF
file SHA
`fecf29fe68b332d60cfdd3143f6a1639b335b5db94d3557b8ba41fa09862f5fa`.

The non-CM proof is valid. The norm-25 Frobenius roots are -4+3i,
-4-3i, and the norm-seven roots are plus or minus two together with
plus or minus sqrt(-3). Their ratios are not roots of unity, as the
given real parts exclude the roots of unity in the respective quadratic
fields. All positive Frobenius powers therefore have the same regular
two-dimensional centralizers. The two centralizers over Q_17 are a
split product and a field, because -1 is a square modulo seventeen
whereas -3 is not. If geometric CM existed, its quadratic algebra
tensored with Q_17 would inject into and hence equal each centralizer;
finite definition of endomorphisms suffices to make it commute with
suitable positive powers. This is impossible.

I actually opened Milne, *Elliptic Curves*, second edition, II.6.7 and
V.8.3 at https://www.jmilne.org/math/Books/EC2.pdf to check Tate-module
injectivity and the reduction/Frobenius trace comparison. The latter
is stated over Q in that chapter, but its proof is the local good
reduction comparison and applies unchanged at a number-field place.
No classification table of CM curves is required. I suggested replacing
the phrase "field M tensor Q17" by "algebra M tensor Q17", since that
tensor product is precisely allowed to split.

BS2 is the exact unbounded actual family `a=Lk,b=Lk+1`. It preserves
positivity, primitivity and the inverse square gate, while its norm is
one modulo every prescribed finite precision included in L. BS3 keeps
an indispensable premise: the boundary newform must first be exactly
identified. Conditional on that identification, a Mazur product over
all those admissible residue states has a literal zero factor. This
only excludes that specified finite local-state elimination procedure.
It does not exclude global cover constraints, extra restrictions deduced
from the global power equation, or the modular route as a whole.

## Full actual quartic-subfield descent SC1--SC5

I read the complete parent draft
`2026_09_07_quartic_compatibility/single_quartic_descent.md`.
SC1--SC5 pass independent ordinary review. The detailed ideal extraction
handles thirteen by its actual norm depth one, without an unramified
assumption. The remainder and extracted ideals have norms exactly V,Q;
shared support is permitted. The single unit choice controls all three
ratios, giving the stated cover count and coefficient-height bound.

In the new rational normal form SC5, the field embedding coordinates
are an invertible linear change over the algebraic closure. The diagonal
g-th-power map has inverse image of the specified projective line, so
the intersection is nonempty and one-dimensional. The four coordinate
functions on the line vanish at distinct points; thus a point in its
preimage has at most one zero coordinate. Any dependence between the
two gradients would give a line-annihilator vector supported on that
coordinate only. No such vector annihilates the line. Hence the Jacobian
has rank two everywhere. Kummer divisor independence proves geometric
connectedness even for composite g, and the smooth complete
intersection has the stated genus. The monic multiplication table and
multinomial coefficient sum bound the coefficient growth exponentially
in g, giving logarithmic coefficient height O(log V+g). None of this
bounds the height of an individual rational point.

I supplied an optional additional elementary consequence, not needed
for the current proof. The order index can only be one or three. If it
were three, the field discriminant would be thirteen, and the same
Minkowski theorem would require an integral ideal of norm at most
`(3/(2*pi^2))*sqrt(13)<1`. That is impossible. Thus the index is
actually one and the field discriminant is exactly 117; the displayed
power basis is an integral basis. The existing weaker bound is already
sufficient and correct, so this is an optional strengthening.

## FM7: full review of the formerly non-finite-flat branch

I read `2026_09_07_independent_route/sixth_round/nonflat_weight_budget.md`
in full. Its ordinary necessary level/weight statement and dimension
budget pass independent review. This extends the earlier FM6 review;
the branch p|V is now accounted for, not discarded.

When p divides the p-power-free V, the actual norm forces p to split
in Q(sqrt(-3)). At either completion the curve is multiplicative over
Q_p, its j-valuation is -m or -2m, and neither is divisible by p.
The unramified character twist leaves the local inertia unchanged.
The precise Serre weight is therefore p+1. The prime-to-p level is
`2^e*9*rad(V/p^(v_p(V)))`, with the same e range. If p does not divide
V the weight is two as previously proved. For a fixed V only its one
specified weight is counted. The five newspace dimensions are at
most `485(p+1)V^2`; summing V<=exp(Lp) gives
`485(p+1)exp(3Lp)`. Its logarithm divided by p tends to zero when
L tends to zero and p tends to infinity.

I independently opened Serre's 1987 institution-hosted primary PDF,
Section 2.9 Proposition 5, and Section 3.1.6. The former gives the exact
semistable local weight recipe; the latter lifts the residual eigen-system
in the same weight and level, with the Teichmuller character. Exact
residual conductor excludes a lift coming from a proper lower level.
I also opened the Khare--Wintenberger author PDF, introduction and
Section 9 Theorem 9.1, including its explicit statement that the Kisin
input is completed. The new note correctly separates these modern
modularity inputs from the local and lifting results of Serre's 1987
paper; it does not attribute the completed conjecture to that paper.

I requested one precision in the composite-exponent discussion. A
g-power-free V need not be p-power-free when p divides g. Before
applying FM7, factor V=V_p*C^p canonically and replace Q^(g/p) by
C*Q^(g/p). Then the actual p-parameter is at most
`max(1,log V)/p`, with equality not asserted. The stated implication
when p>=theta*g is unchanged. Also, the necessary modular statement
is valid even for Q=1, but a final nontrivial-power exclusion must keep
Q>1 explicit. Neither refinement affects the reviewed budget.

Additional primary sources inspected:

* https://www.college-de-france.fr/media/jean-pierre-serre/UPL5835292064138487263_Serre_Repr.modulaires_Galois.pdf
* https://www.math.ucla.edu/~shekhar/papers/results.pdf

## Final sixth-round transcriptions: SC and FM7

I read the complete final `2026_09_07_quartic_compatibility/paper/single_quartic_descent.tex` and `2026_09_07_independent_route/sixth_round/paper/nonflat_weight_budget.tex`. Both pass final independent transcription review against the ordinary proofs reviewed above.

The SC text retains the actual unique degree-one prime above each supported rational prime, the special depth-one argument at 13 without assuming unramifiedness, the single unit class count, and the complete-intersection nonemptiness and Jacobian argument. Its connected chart has finite complement, excluding hidden curve components. The fixed multiplication table supplies the claimed coefficient-height bound. It does not claim an individual point-height bound or introduce the optional exact discriminant or root-of-unity refinements.

FM7 now explicitly canonicalizes the residual integer when extracting a prime exponent from a composite exponent. Its actual parameter satisfies an inequality, not an unjustified equality. The necessary modular theorem includes Q=1, while the nontrivial compression target explicitly has Q>1. Both weight branches, the exact prime-to-p level, the modern modularity and older lifting inputs, and the dimension budget match the reviewed ordinary proof. No further substantive transcription issue was found. These are ordinary mathematical/source reviews, not claims that the number-field or modularity arguments have been formalized in Lean.
