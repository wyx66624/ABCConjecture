# Independent five-primary sieve: full bridge and separate F13 implementation

Status: **ordinary argument PASS**. The global-index hypothesis already
proved in QL2 is sufficient. A global-generator assumption, saturation at
13, or an index bound at other primes is not needed. The independent finite
implementation was actually run in write mode and then with `--check`;
both returned PASS with identical canonical bytes.

The fixed curve and two actual quotient maps are

    C: W^2=z^6-27z^4+99z^2-9,
    E1: y^2=x^3-9x-9,       P=(-2,1),
    E2: y^2=x^3-189x+999,   P'=(6,9),
    R1=((z^2-9)/4,W/8),
    R2=((33-9/z^2)/4,-9W/(8z^3)).

## 1. What the known global index proves

For either E_i, QL2 proves that E_i(Q) is torsion-free of rank one and
that d_i=[E_i(Q):Z P_i] is finite and not divisible by five. This exact
statement, not just local density, was actually reread in
`independent_route/seventeenth_round/padic_closure_entry.md`, SHA256
`f3e82469f2bc3199089ecf80b77f92c7865f9758500360bfaa80ac7fc7e0949b`.

For any actual Q in E_i(Q), the finite quotient by Z P_i is annihilated
by its order d_i. Therefore

    [d_i] Q = [a] P_i

for an integer a. Additivity of the five-adic logarithm and the proved
nonzero logarithm of P_i give

    m_i(Q)=log_i(Q)/log_i(P_i)=a/d_i in Z_(5) subset Z5.

Thus this local logarithmic coefficient has a well-defined residue modulo
five, even though its value need not be an integer and P_i need not be a
global generator. Changing the integral representation does not change
that residue, since it is the residue of the same logarithmic ratio.

At good reduction 13, reduction is a group homomorphism. The finite
enumeration below proves #E_i(F13)=15. Let T=[3]red(Q) and
U=[3]red(P_i). Lagrange's theorem gives [5]T=[5]U=O, while reduction of
the displayed global relation gives [d_i]T=[a]U. Choose an integer b
with b*d_i=1 modulo five. Multiplying this relation by b therefore gives

    [3]red(Q) = [a*b] [3]red(P_i)
               = [m_i(Q) mod5] [3]red(P_i).           (FS1)

Every scalar in this formula is interpreted on a group killed by five.
We never invert d_i modulo 13 or on the full order-fifteen group; d_i may
be divisible by three or thirteen. This is precisely why the known
prime-to-five index suffices. The same proof would even allow torsion
provided the stated finite-index premise held for the whole group.

## 2. The actual residue class of each additional local zero

UD proves that the extra zero on the disk z=1+5s, W=8 mod5 has s=4 mod5.
Its complete elliptic logarithm reductions, already proved with all tails,
are

    ell1/5=4+4s,       ell2/5=3+s          modulo5,
    log(P)/5=4,        log(P')/5=2         modulo5.

Consequently this extra zero has m1=0 and m2=1 modulo five. Under the
hyperelliptic involution both elliptic images change sign; under z->-z
only the second one changes sign. Its other three DS images therefore
all have

    m1=0,             m2 in {1,-1}        modulo5.   (FS2)

If any of these four local points were rational, its two quotient images
would be actual elements of E1(Q),E2(Q). Applying FS1 would force its
reduction modulo thirteen to satisfy

    [3]R1=O,          [3]R2=+/-[3]P'.                 (FS3)

This implication does not assert that an arbitrary Q5 point can be
reduced at thirteen. It is used only after assuming rationality of the
candidate point.

## 3. Complete finite obstruction, independently recomputed

The new script `next_replay_f13_independent.py` imports none of root's
probe or its affine group-law routines. It enumerates every residue pair
(x,y) for each elliptic curve and every pair (z,W) for the hyperelliptic
curve, and computes [3] by normalized division polynomials. These are the
same standard multiplication-map identities previously source-checked
against Sutherland's Lecture 5, not the probe's repeated additions.

It verifies that both elliptic discriminants are nonzero mod13, and
computes the entire polynomial Euclidean chain to check that the sextic
is coprime to its derivative. The monic degree-six equation has two
smooth rational infinity points because 2 is invertible. Thus these
tables describe the smooth projective good reduction of C.

The complete affine pairs are

    z=0:  W=2,11;       z=1:  W=5,8;
    z=3:  W=3,10;       z=6:  W=3,10;
    z=7:  W=3,10;       z=10: W=3,10;
    z=12: W=5,8.

All other z residues have no ordinate. There are fourteen affine points
and two infinity points. Both elliptic groups have fifteen points, and
the independently computed triples are

    [3]P=(3,2),        [3]P'=(11,2),
    -[3]P'=(11,11).

Only the following six C(F13) points have [3]R1=O:

| Point on C(F13) | [3]R2 |
|---|---|
| (6,3) | O |
| (6,10) | O |
| (7,3) | O |
| (7,10) | O |
| infinity with W/z^3=1 | (8,8) |
| infinity with W/z^3=-1 | (8,5) |

None has [3]R2=(11,2) or (11,11). The canonical output includes all
sixteen points, both complete elliptic tables, all images and triples,
and the sextic Euclidean trace, not just this short exclusion table.

The projective image conventions are explicit: at z=0, R2=O; at infinity,
R1=O and R2=(33/4,-9*sign/8). Reduction of actual rational quotient
points agrees with these values. Indeed if v13(z)>0 the second quotient
has negative x valuation and reduces to O; if v13(z)<0 the first quotient
does, while W/z^3 reduces to the indicated sign. When z is a unit the
displayed formulas reduce directly. The same charts cover rational points
already at zero or infinity. There is no discarded denominator case.

## 4. Consequence and precise verification boundary

FS3 contradicts the complete finite table for either sign. Therefore
none of the four additional UD local zeros is rational. Combined with
the independently audited UD/SU/ZD/IF full twelve-disk zero inventory
and the proved LH/ZS necessary height equation for rational points, this
proves the fixed-curve classification

    C(Q) = {(1,8),(1,-8),(-1,8),(-1,-8),infinity+,infinity-}.

All six displayed points really are rational points of the smooth curve;
the four affine equations and the two monic infinity points verify
existence. This is a classification of this fixed genus-two C only.
It does not itself classify a varying exponent/residual family, establish
the second-square/positive-source test on D, give a uniform point-height
bound, or prove ABC.

The independent script has SHA256
`605a477fd97d1851ded47f99d5a3b74ab789de3762d8686aca4a43273ac44a72`.
Its output `next_verification/f13_independent.json` has SHA256
`c806cba4c93ce98628556464990a3be735d98fd45abcfb68c1c81ca48f6486f0`.
Write and subsequent `--check` were both actually executed successfully.
The existing root probe was read, SHA256
`18f0646928c77364887f7d19a6f2e9187693dd8fbe87ae9c2378ac0e17b23bbd`,
but was not reused in this independent implementation. These exact finite
computations are distinct from the ordinary global-index/logarithm proof
and the previously proved complete analytic disk certificates. No new
Lean classification or global-generator computation is claimed.
