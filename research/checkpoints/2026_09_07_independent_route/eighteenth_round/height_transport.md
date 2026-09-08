# HT1--HT4. Minimal-model height recovery and the exact differential scaling

Status: complete ordinary proof with two independent full primary/source
audits and independent exact replay checks, all PASS. This new eighteenth-round
note does not change QL or any sealed source. No complete QC zero set,
bad-prime height-value set, or rational-point classification is asserted.

We retain the fixed QL curves E,E', points P,P', and good ordinary prime 5.
Write F1,F2 for the two elliptic curves in the monic even-sextic chart:

    C: W^2=z^6-27z^4+99z^2-9,
    F1: Y^2=X^3-27X^2+99X-9,
    F2: Y^2=X^3+99X^2+243X+81.

The isomorphisms i1:E->F1 and i2:E'->F2 are respectively

    (x,y) |-> (4x+9,8y),   (x,y) |-> (4x-33,8y).       (HT1)

Thus u=2, and r=9 or -33, in the common notation X=u^2 x+r,
Y=u^3 y. The minimal models are precisely the displayed E,E'.
Indeed the discriminants of E,E' are 2^4*3^6 and 2^4*3^10. They are
integral models, and at every prime their discriminant valuation is less
than12. A smaller integral model would reduce that valuation by a
positive multiple of12, impossible because an integral discriminant has
nonnegative valuation. Thus both are globally minimal. The replay also
checks the returned [u,r,0,0] and each point substitution; the curve
substitutions in (HT1) are direct polynomial identities.

## HT1. Intrinsic scalar heights, differential coordinates, and the BD ratios

Use the global cyclotomic height pairing with local character
chi_5=log_5 (log_5(5)=0) and chi_l(a)=-v_l(a)log_5(l) for l!=5,
and the unit-root splitting at five. Write H_E(Q) for its diagonal
value. This is the convention with twice Silverman's local heights.
The normalization agrees with BD's explicitly stated convention in
Section 8.3 (printed p.35); it must not be confused with the function
h_p=-1/2(P,P)_p and character log_p/p in MST's introduction.
In the present convention MST (1.1) becomes

    H_E(Q)=-2 log_5(sigma_E(mQ)/d(mQ))/m^2,             (HT2)

Here Q is an infinite-order rational point and m is a positive integer;
mQ is in the formal group at five and in the identity components
at every bad prime, and d is the square root of its minimal-model
x-denominator. This normalization fixes the sign and any factor of 5.

The ordinary intrinsic statements are

    H_F(iQ)=H_E(Q),       log_F(iQ)=log_E(Q)/u,
    s_F=u^2 s_E-r,        alpha_F=u^2 alpha_E,           (HT3)

where s is the unit-root slope in the basis (omega,eta=x omega),
and alpha=H(P)/log(P)^2 for any nonzero infinite-order rational point.
In particular both BD height/log-square ratios are FOUR times those
computed on the corresponding minimal GD models.

Proof. Pullback of differentials gives the exact identities

    i^*omega_F=omega_E/u,
    i^*eta_F=u eta_E+(r/u)omega_E.                      (HT4)

Frobenius commutes with this isomorphism. The unit-root line of F
pulls back to the unique unit-root line of E, so

    i^*(eta_F+s_F omega_F)=u(eta_E+s_E omega_E),

which proves the slope formula. Integration from the origin proves
the logarithm formula on the formal group; multiplication by a common
integer extends it to all local points. This is an exact identity,
not a precision-based numerical recognition.

For the scalar height, the definition is independent of the chosen
Weierstrass coordinates. Here this can also be checked directly in
the MST local construction, without relying on software covariance.
Their Theorem 1.3 gives the unique normalized integral sigma function.
Because u is a 5-adic unit, both coordinate maps give integral formal
parameters, and (HT4) and the slope identity show

    sigma_F(iQ)=sigma_E(Q)/u.                           (HT5)

Indeed both sides satisfy the defining second logarithmic differential
equation, are odd, and have coefficient one in t_F; uniqueness proves
the equality. The change of formal parameters is odd with leading
coefficient 1/u. The four-point sigma quotient defining the local
height pairing (MST Section 2.3) contains two factors in numerator and
denominator, so the four factors 1/u cancel. Away from five the local
construction uses the intrinsic minimal Neron model and is unchanged
by the isomorphism (MST Section 2.4). Bilinearity extends the equality
from the good four-point representations to the entire rational group.
Equivalently one may transport all the auxiliary local data through i.
This proves H_F(iQ)=H_E(Q); division by the squared logarithm proves
the last assertion of HT3. No claim that P or P' is a global generator
is required, by QL's rank-one quadraticity argument. QED.

For local integral implementations, the unit-root complementary
differential scales by u, while omega scales by 1/u. Their cup-dual
normalization and the corresponding iterated-integral differential
are therefore transported consistently. Constants arising from
tangential basepoint conventions still have to be treated explicitly
in any particular local-height implementation; HT3 concerns the global
scalar and does not declare an arbitrary local software output equal.

## HT2. The exact PARI 2.15.4 transformation and a safe recovery formula

This paragraph is a version-specific source statement, not an assumed
mathematical covariance law for the raw two-vector.
Let [a,b] be PARI's vector on the minimal model and [A,B] its returned
vector on F for the corresponding point. Direct inspection of the
official PARI 2.15.4 source gives

    A=(a+r b)/u,          B=u b.                        (HT6)

Precisely, ellpadic.c:688--689 obtains the global minimal model and
changes the point to it; lines 741--748 apply the displayed final
two-vector transformation. elliptic.c:4993--5016 confirms the direction
of the change [u,r,s,t]. The official ellchangecurve documentation
defines X=u^2 x+r, Y=u^3 y+s u^2 x+t.

The elementary inverse of (HT6) is

    a=uA-rB/u,           b=B/u.

Since on the minimal model the canonical scalar is a-s_E b, the
source-compatible recovery rule is exactly

    H_E=uA-(r+s_E)B/u
       =uA-((u^2+1)r+s_F)B/u^3.                       (HT7)

This recovery is an exact rational linear identity. In practice the
simpler safe pipeline computes [a,b] and s_E on the minimal model and
never needs the nonminimal two-vector. It then uses (HT3) for the
BD logarithm and alpha.

In contrast, the naive raw scalar A-s_F B is generally NOT (HT7).
The final transformation in this pinned implementation and the
unit-root slope are using different transformations for this purpose.
Calling it a p-adic rounding discrepancy is incorrect. This conclusion
concerns these source bytes and inputs, not every release of PARI or
all conventions for vector-valued heights. No global installation,
upstream code patch or bug-report transmission was made.

For completeness, on the minimal short model the source computes
a=-2 log(sigma_0(mP)/d)/m^2 and b=-log_E(mP)^2/m^2.
The function ellformallogsigma_t, lines 427--440, implements the
zero-slope differential equation. Replacing sigma_0 by
sigma_s=sigma_0 exp(-s_E log_E^2/2) gives a-s_E b and (HT2).
This explains why the two-vector combination on the minimal model
has the scalar convention fixed above.

## HT3. An independent exact leading-digit certificate

The discrepancy already has valuation ONE in both actual examples.
This fact has a proof independent of PARI's height computation.
Write 9P=(A0/d^2,B0/d^3), and similarly for 9P'. The exact QL
coordinates, using integer arithmetic only, give

                   E                  E'
    (-A0/B0) mod25  14                 4
    log_5(-A0/B0)   10 mod25           20 mod25
    H(P) mod25      5                  10.

To prove the final row, first check that 9P and 9P' are nonsingular
on the minimal models at both bad primes 2 and 3. If the denominator
is divisible by the prime they reduce to the origin; otherwise at
least one of 2y and 3x^2+a is nonzero modulo that prime. The exact
certificate checks both alternatives. Their formal parameter t at
five has valuation one by QL. The normalized canonical sigma function
is odd and belongs to t Z_5[[t]] by MST Theorem 1.3. Consequently

    sigma(t)/t in 1+t^2 Z_5[[t]],
    log_5(sigma(t)/t) in 25 Z_5.

This gives a rigorous bound on ALL omitted series terms, rather than
comparing two truncations. Since t/d=-A0/B0 is a unit,

    H(P)=-2/81 log_5(-A0/B0) mod25.

For a 5-adic unit q, log_5(q)=(q^4-1)/4 mod25: after writing
q^4=1+5k the entire logarithm tail is in25Z_5. This evaluates the
table by modular integer inverses. The same argument applies to P'.

Furthermore b=-log_E(P)^2 has valuation two, s_E and s_F are integral,
and u=2 is a unit. Thus (HT6) proves

    A-s_F B-H_E = (1/2-1)H_E mod25.

The residues are respectively 10 and 20 modulo25, both nonzero
multiples of five. This proves the exact valuation-one discrepancy,
independently of a high-precision height library. QED.

## HT4. Certified scope and the next finite calculation

The exact transport formulas settle the previously isolated GLOBAL
model/differential mismatch: use H on the minimal models, log/u on
the standard BD models, and alpha multiplied by u^2=4. This is enough
to supply the global height coefficients in the prospective QC formula.
It does not by itself supply all local height functions or their finite
value sets. The next required calculation is therefore still to prove
the bad-prime values on the actual image of C and implement compatible
local integrals and chart constants. Only after those data are certified
may one certify all analytic zeros and apply the rational sieve.

replay_height_transport.py --check first performs an independent exact
binary elliptic addition and the mod25 proof above. It also verifies
the rational inverse matrices exactly. It then checks source-predicted
relations using explicit p-adic balls from PARI at precisions 12 and24.
For each run, the residual of EVERY relation must vanish to at least
the common stated absolute precision; merely agreeing between two
runs is not used as the proof of HT3. The high-precision sigma/Frobenius
algorithms remain trusted PARI computations; this certificate is not a
formal verification of their whole implementations.

Canonical certificate SHA256:
70ec75594f205336757496605750b1302e5f3b271afd6acf5b12275a36c9de05.
No Lean, Jacobian rank, finite QC zero list, or complete rational-point
classification is claimed by this replay.

## Primary source inventory

Actually opened/read for this note:

* PARI official 2.15.4 source archive:
  https://pari.math.u-bordeaux.fr/pub/pari/OLD/2.15/pari-2.15.4.tar.gz
  SHA256 c3545bfee0c6dfb40b77fb4bbabaf999d82e60069b9f6d28bcb6cf004c8c5c0f.
  Local copies of the relevant C files and function documentation were
  inspected during the audit. They can be recovered from this pinned
  versioned archive; the publication does not distribute those copies.
* PARI official ellpadicheight, ellpadics2, ellpadiclog and
  ellchangecurve documentation:
  https://pari.math.u-bordeaux.fr/dochtml/html-stable/Elliptic_curves.html .
* Mazur--Stein--Tate, Computation of p-adic heights and log convergence,
  author-hosted preprint, (1.1), Theorem1.3, Sections2.3--2.4:
  https://bpb-us-e1.wpmucdn.com/sites.harvard.edu/dist/a/189/files/2023/01/Computation-of-p-Adic-Heights-and-Log-Convergence.pdf .
  The introduction uses a DIFFERENT normalized scalar hp; the conversion
  to our diagonal pairing with chi5=log5 is made explicitly in HT2.
* Balakrishnan--Dogra, arXiv1601.00388, Theorem1.4,
  Algorithm8.3 step2 (minimal models) and Section8.3's character convention:
  https://arxiv.org/pdf/1601.00388 .

The formal identities and scalar transport are ordinary mathematics;
the raw-output correction is explicitly version-specific source analysis.
