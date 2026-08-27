# Prime 19: Stoll–Gamma closure on the Pell 2-adic disk

This is the standalone closure ledger for the only 2-adic disk required by
the Pell branch. It uses no BSD, GRH, parity conjecture, or finiteness of a
Tate–Shafarevich group.

## 1. The disk and its regular parameter

On the monic curve C: y²=f(X), put X=4T and y=512(2z+1). The integral
characteristic-two model is

    z²+z = T_19(T)+1.

Its partial derivative with respect to z is 1. Thus the model is smooth at
T=-1, and t=T+1 is a valid analytic parameter in the proper regular model
used in Stoll Section 3. The Pell condition T=23 mod 24 implies

    t ∈ 8 Z₂,   X=-4+4t ∈ -4+32 Z₂.

We first use P0=(-4,512) and the analytic y-branch through P0.

## 2. The rational subgroup

Let J=Jac(C). Define H1=[U1,512] and H9=[U9,1536], where

    U1 = x^9-2x^8-32x^7+56x^6+336x^5-480x^4
         -1280x^3+1280x^2+1280x-512,

    U9 = x^9+2x^8-32x^7-56x^6+336x^5+480x^4
         -1280x^3-1280x^2+1280x+512.

The subgroup used in the proof is Γ2=<H1,H9>. The exact rational Magma
certificate proves

    f-512²=(x+4)U1²,   f-1536²=(x-4)U9².

With O=(1:0:0), it also fixes the sign convention:

    [(-4,512)-O] = -2H1,
    [(4,1536)-O] = -2H9.

It computes H1+H9=[UG,VG], with

    UG = x^9-x^8-32x^7+28x^6+336x^5-240x^4
         -1280x^3+640x^2+1280x-256,

    VG = -3x^8+84x^6-720x^4+1920x^2-768.

In the frozen nine-dimensional local Kummer basis,

    loc(H1)=e1,   loc(H9)=e2,
    π2(Γ2)=A=<e1,e2>.

The four elements 0,e1,e2,e1+e2 are distinct. Therefore
Γ2 ∩ 2J(Q2)=2Γ2. The closure of a rank-at-most-two subgroup cannot have
finite index in the nine-dimensional 2-adic Lie group J(Q2).

## 3. Local torsion and Selmer localization

The final Γ2-only script repeats the exact number-field assertion

    MinimalPolynomial(-(2a+a^18)) = f,   a^19=2.

It also constructs the Eisenstein degree-19 field Q2(a), verifies the same
theta is a root, and verifies that the 19 powers of theta have an invertible
change-of-basis matrix from the powers of a. Hence Q2(theta) has degree 19,
so f is irreducible over Q2. For an odd-degree hyperelliptic curve this gives
J(Q2)[2]=0, hence J(Q2)[2^∞]=0 and Stoll's n_tors is zero. Every divisible
branch in Lemma 2.4 has a unique half.

The strengthened frozen global descent proves that the full 2-Selmer group
has dimension three and that localization at 2 is injective. It also closes
the representative bridge in the same run. From the displayed coefficient

    extra=(0,1,1,1,0,0,1,1,0)

it forms the product of the nine `Wglobal` representatives and, independently,
the product specified by the resulting fourteen-dimensional coordinate

    (0,1,1,1,0,1,0,1,1,0,0,0,0,1).

Their quotient is asserted to be a square. It then defines

    delta = -14a^18+4a^17+7a^16-26a^15+6a^14+4a^13
            -21a^12+2a^11+10a^10-8a^9-8a^8+30a^7
            -7a^6-8a^5+37a^4-8a^3-7a^2+20a+5

in Q(a), a^19=2, and asserts both `Norm(delta)=1` and that the quotient of
the global extra product by `delta` is a square. The Gamma2 script embeds
this same displayed `delta` into Q2(a) and asserts that its exact local
coordinate is `e6+e8+e9`. Thus no abstract-basis coordinate is carried by
hand between the global descent and the local recursion. The full image is

    S2=<e1,e2,e6+e8+e9>.

Hence ker σ=0 in Stoll Theorem 2.1. This proves condition (1).

The `GRH` class-group switch in Magma is used only to reproduce the ordered
candidate basis. Unconditional completeness comes from the separately
certified PARI class-number-one computation together with the exact S-support
check and the check of all `2^14-1=16383` nontrivial square relations in this
run.

## 4. Literal Lemma 2.4 recursion

For a reduced Mumford pair R=[a,b], the script represents its Kummer class
by (-1)^deg(a) a(theta) in K2*/K2*². At every recursion node it tests all
four classes R+T for

    T ∈ {0,H1,H9,H1+H9}.

If loc(R) lies in A, exactly one of these four classes is zero. Its half is
unique. The script constructs it using Stoll Proposition 5.1 when T=0 and
the two-Mumford system of Remark 5.2 otherwise. At every step it asserts
the defining polynomial identity and the output Mumford identity.

When loc(R) is outside A, recursion stops. The script compares the terminal
class with all eight localized Selmer squareclasses and asserts it is not
in S2. Since A is contained in S2, the full terminal coset loc(R)+A is then
disjoint from S2. This is exactly Lemma 2.4, not a point search.

For every finite representative below the exact result is

    q(i_P0(P)+Γ2) ∩ S2 = A.

For X=28 and X=92 the terminal primitive coordinate is

    (0,0,0,0,0,1,0,0,1),

which is outside S2.

## 5. Corollary 3.2 and Lemma 3.10

For each m=3,4,5, the script uses all sixteen odd residues u modulo 32 and
t0=2^m u. The official transcript gives, for every representative:

    m                         3   4   5
    max nu(i_P0(P(t0))+Γ2)    5   6   7

Points with the same u modulo 32 satisfy v2(t-t0)≥m+5. Here n_m=m+2, so
m+5=n_m+3, exactly the Q2 threshold in Stoll Corollary 3.2. The sixteen
representatives therefore cover the whole shell v2(t)=m, for both nu and q.

At m=5 the standard non-Weierstrass bound in Lemma 3.10 is

    2m-3 = 7 ≥ n_(5,Γ2) = 7.

All other hypotheses were checked above. Consequently the m=5 shell,
together with q(Γ2)=A, controls all shells m≥5. Combining m=3, m=4, and
the tail proves

    q(i_P0(X)+Γ2) ∩ S2 = A

throughout X=-4+32Z2 on the positive y-branch. This proves condition (2) of
Stoll Theorem 2.1.

The negative branch needs a correction because P0 is not Weierstrass. If
iota is the hyperelliptic involution and D0=[P0-O]=-2H1, then

    i_P0(iota(P)) = -i_P0(P)-2D0 = -i_P0(P)+4H1.

Because 4H1 lies in Γ2, the negative-branch coset is the negative of the
positive-branch coset. Negation is invisible in the mod-two Kummer quotient,
so the same q statement holds. This is why Γ2, rather than the rank-one
diagnostic subgroup <H1+H9>, is used for the two-branch closure.

Stoll Theorem 2.1 now gives

    [P-P0] ∈ saturation_J(Q)(Γ2)

for every rational point in the target disk.

## 6. Exact 5-adic finish

The Coleman model is

    y_c^2=(4*T_19(x)+5)/2^20.

The closure-specific Sage input asserts the exact polynomial identity

    fm(4x)=2^18*(4*T_19(x)+5).

Thus `X=4x`, `Y=2^19*y_c` is an isomorphism to the monic model used in the
dyadic Stoll computation. In particular

    (-1,1/1024) -> (-4,512),
    ( 1,3/1024) -> ( 4,1536),

so the two Coleman logarithms below are exactly those of the classes Dm and
Dp fixed in Section 2, not merely analogous points on a scaled curve.

The frozen Sage script computes the two Coleman logarithms lm and lp of
Dm=-2H1 and Dp=-2H9. Each logarithm row has 5-adic content of valuation
exactly one (that is, an overall factor 5). For
L=(lm/5,lp/5), columns zero and one have unit determinant.

Keep coefficients 2 through 8 of

    (1,0,0,0,0,0,0,0,3)

fixed and solve the two exact equations for coefficients 0 and 1. The
resulting differential omega satisfies exact dot products zero with both
lm and lp and has the displayed reduction modulo 5. Here omega is the
actual Q5-vector *defined* from the actual logarithms by the inverse of the
unit minor. The finite-precision Sage computation certifies the unit minor,
its reduction, and high-precision stability; exact annihilation is the
algebraic identity `B*(-B^-1*rhs)+rhs=0`, not an inference from printed
truncated zeros. The independent SageMath 10.9 replay retains normalized
absolute precision 57 and prints `[O(5^57),O(5^57)]`; these are numerical
consistency witnesses only. Thus omega annihilates Γ2. Its reduction evaluates to
1,4,4,3 at the residue types
x=0,1,-1,infinity, so its Coleman primitive has at most one zero in each of
the six Q5 residue disks.

If [P-P0] lies in saturation(Γ2), choose n≥1 with n[P-P0] in Γ2. Then
n times the integral from P0 to P is zero. Characteristic zero makes the
integral itself zero. The script also anchors the integral from O to P0 at
zero, so F(P)=integral_O^P(omega)=0.

Five rational anchors occupy five disks. The remaining zero is the unique
Q5 Weierstrass point W=(alpha,0), alpha=0 mod 5. Irreducibility of f over Q
shows W is not rational. Hence the target 2-adic disk contains no further
rational point.

## 7. Reproduction and trust boundary

The canonical byte manifest is
`Lean/audit_scripts/p19_chebyshev_stoll_gamma2.sha256`.

Official Magma V2.29-9 inputs:

    load "Lean/audit_scripts/p19_chebyshev_stoll_gamma_rational.m";
    load "Lean/audit_scripts/p19_chebyshev_dyadic_obstruction.m";
    load "Lean/audit_scripts/p19_chebyshev_stoll_gamma2.m";

The strengthened dyadic input completed on the official calculator in
48.840 seconds (seed 1004454347). Its full output, including the two exact
extra-to-delta squareclass assertions, is in
`Lean/audit_scripts/p19_chebyshev_dyadic_obstruction_bridge.transcript`.

The Gamma2 input uses precision 4000 and completed in 23.670 seconds. Its
complete output is in
`Lean/audit_scripts/p19_chebyshev_stoll_gamma2.transcript`.
An independent precision-5000 replay (30.500 seconds, with byte-identical
stdout body) is in
`Lean/audit_scripts/p19_chebyshev_stoll_gamma2_review_prec5000.transcript`.
The
decisive final lines are:

    SHELL_SUMMARY RANK=2 M=3 UNIT_MODULUS=32 REPS=16 MAX_NU=5
    SHELL_SUMMARY RANK=2 M=4 UNIT_MODULUS=32 REPS=16 MAX_NU=6
    SHELL_SUMMARY RANK=2 M=5 UNIT_MODULUS=32 REPS=16 MAX_NU=7
    TAIL_LEMMA_3_10 RANK=2 M_TAIL=5 BOUND=7 MAX_NU=7 PASS=true
    FULL_DISK_Q_CAP_LOCSEL_EQUALS_GAMMA_IMAGE
    P19_STOLL_GAMMA_FULL_DISK_CERTIFICATE_PASS

Exact SageMath 10.9 finishing input:

    sage Lean/audit_scripts/p19_chebyshev_stoll_gamma2_coleman.sage

This closure-specific copy uses `Qp(5,60)` and embeds the reduced
coefficients through `K(ZZ(...))`, rather than coercing directly from GF(5).
The original boundary script remains unchanged. An independent read-only
SageMath 10.9 container replay exited zero; its complete stdout is in
`Lean/audit_scripts/p19_chebyshev_stoll_gamma2_coleman_review.transcript`.

The exact rational Mumford/sign computation has its official output in
`Lean/audit_scripts/p19_chebyshev_stoll_gamma_rational.transcript`.

Scalar Lean companion:

    lake env lean IUTThreeClosures/FreyPellChebyshevIndexNineteenStollGammaCertificate.lean

This ledger accepts Stoll Theorem 2.1, Lemma 2.4, Corollary 3.2,
Lemma 3.10, Proposition 5.1 and Remark 5.2, standard hyperelliptic Kummer
theory, and Coleman integration. A Lean scalar ledger does not formalize
those external theories or the Magma/Sage kernels.

Reference: Michael Stoll, “Chabauty Without the Mordell-Weil Group,” in
*Algorithmic and Experimental Methods in Algebra, Geometry, and Number
Theory*, Springer (2017), pp. 623–663,
DOI [10.1007/978-3-319-70566-8_28](https://doi.org/10.1007/978-3-319-70566-8_28).
In the author's 7 December 2017 preprint pagination, the precise results used
here are Theorem 2.1 (Section 2, pp. 4–5), Lemma 2.4 (Section 2, p. 6),
Corollary 3.2 (Section 3, p. 10), Lemma 3.10 (Section 3, pp. 13–14),
Proposition 5.1 (Section 5, pp. 18–20), and Remark 5.2 (Section 5, p. 21).
