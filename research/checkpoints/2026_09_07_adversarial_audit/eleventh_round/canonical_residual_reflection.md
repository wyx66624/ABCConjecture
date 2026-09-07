# CR1--CR3. Exact canonical residual reflection after projective cancellation

Date: 2026-09-07. Complete ordinary proof, reviewed in full by
independent_route, critical_bottleneck, and the root agent: PASS.
This is a restricted strengthening
of IL1--IL2, not a replacement of their general non-n-free domain.

## Domain and the previously proved local allocation

Work in O=Z[zeta], zeta^2-zeta+1=0, and let gamma=1+zeta.
Let n>=2 be an integer. Let

    tau=u gamma^e v,   e in {0,1},   V=N(v),

where u is a unit, and v is primitive and unramified. Let w be primitive
and unramified with R=N(w)>1. Assume additionally that V is n-free:
for every rational prime p, 0<=v_p(V)<n. This includes V=1.
No coprimality between V and R is assumed.

Let C be the positive integer content of tau w^n, and set

    D=rad(C),      M=N(tau w^n/C)=3^e V R^n/C^2.

The unramified primitive norm supports consist only of split primes
p=1 mod 3, necessarily p>=7. The first ramified exponent remains e and
does not contribute to C. For p appearing in both V and R, put
a=v_p(V), f=v_p(R). Each primitive factor selects one of the two prime
elements over p. The reviewed IL1 local allocation says:

* same orientation: v_p(C)=0 and v_p(M)=a+n f;
* opposite orientation: v_p(C)=min(a,n f) and
  v_p(M)=|a-n f|.

Primes in only one of V,R have their evident single-factor valuations.
This follows directly by multiplying the two oriented prime powers and
removing their common rational p-power. The primitive and unramified
assumptions are material, as documented by the counterexamples in the
separate integral-profile review.

## CR1. The exact canonical pair

Let V_can and R_can be the unique positive integers with V_can n-free,
3 not dividing V_can R_can, and

    M=3^e V_can R_can^n.

Then

    C | V,       gcd(C,V/C)=1,       D | R,

    V_can = V D^n/C^2,             R_can = R/D.             (CR1)

The displayed rational expression for V_can is an integer. In particular,
each canceled prime removes precisely one layer from the root norm,
irrespective of its positive content depth a.

Proof. Consider a prime with opposite orientations. By n-freeness,
1<=a<n, whereas n f>=n. Thus its content depth is exactly a and its
reduced output depth is

    n f-a = (n-a)+n(f-1),        1<=n-a<n.                  (CR2)

Its full contribution p^a to V belongs to C; its contribution to D is p;
its canonical residual exponent changes from a to n-a; its root exponent
changes from f to f-1. At every other prime there is no cancellation:
if it belongs to V its residual exponent stays a<n, and its root exponent
stays f (with zero exponents allowed). Thus C consists of the complete
prime-power factors of V at the canceled support, proving the first two
divisibility assertions and the coprimality. Each such prime divides R,
so D|R. Combining the primewise descriptions gives (CR1).

Alternatively, V/C and D^n/C are coprime integers with all prime
exponents strictly between zero and n; their product is exactly
V D^n/C^2. Its n-freeness and the norm identity prove it is the unique
canonical residual. The ramified contribution 3^e is unchanged since
3 divides neither C nor V R. This proves all claims. QED.

The canonical root is allowed to be one. More precisely, it remains a
nonunit exactly when R>D. If R=D, all root primes occur once and all are
canceled against the opposite residual orientation. This criterion does
not claim that the original oriented root itself is merely divided by D
in O; the canonical statement concerns its norm and the actual output
orientation after primitive reduction.

## CR2. Exact residual budget and sharpness

The preceding formulas yield the identity

    V V_can = (V/C)^2 D^n.                                 (CR3)

Equivalently,

    (log V + log V_can)/n
       = log D + (2/n) log(V/C).                           (CR4)

Thus if C>1, the left side is at least log D, hence at least log 7.
Equality with log D holds if and only if V=C. Equality with log 7
holds exactly when D=7 and V=C. This sharpens the general divisibility
rad(C)^n | V V' of IL2 to a complete expression for the canonical bill
on the n-free subdomain.

It also identifies the only possible smaller-root adjustment. Every
positive integer decomposition M=3^e V' (R')^n has

    V'=V_can S^n,      R_can=S R'

for a positive integer S. Indeed the prime exponents of V' have the
canonical residual as their remainder modulo n, while the remaining
quotients are nonnegative. In particular, arbitrary noncanonical
residual choices can only increase the residual bill; they cannot bypass
the log 7 obstruction.

The norm-seven family PC2 has V=7, C=D=7, R=7 for every n>=2.
Consequently R_can=1 and V_can=7^(n-1), and (CR4) is exactly log 7.
This family verifies sharpness in the actual ring, including primitive
positive output after unit rotation. It is still only a single-map
inverse boundary, not a point on a prescribed double fiber product.

## CR3. Necessary qualification: the n-free assumption

The exact formulas (CR1) are false without the stated n-free hypothesis,
even though the general IL2 residual bill remains true. Let pi=2+zeta,
bar(pi)=3-zeta, n>=3, tau=pi^(n+1), and w=bar(pi). Both tau and w
are primitive and unramified, with

    V=7^(n+1), R=7, tau w^n=7^n pi, C=7^n, D=7.

The primitive output norm is 7, hence its canonical pair is
(V_can,R_can)=(7,1). The expression V D^n/C^2 also equals 7 here,
but C no longer consists of a complete prime-power factor of V and
the primewise residual-reflection description a -> n-a is inapplicable.
To exhibit an actual failure of the exact root formula, instead take
tau=pi^(n+1) and w=bar(pi)^2. Then

    V=7^(n+1), R=7^2, C=7^(n+1),
    N(tau w^n/C)=7^(n-1).

Its canonical pair is (7^(n-1),1), whereas R/D=7 and
V D^n/C^2=1/7. Thus the n-free premise is necessary for this precise
formula. No such hypothesis was introduced into the broader IL results.

## Remaining boundary

The theorem decides the exact numerical effect of cancellation for an
already supplied actual input and its orientations. It supplies neither
the rational points in the simultaneous inverse problem nor bounds for
their heights. It does not resolve arbitrary-root signed-tail membership
and does not prove or disprove ABC. Any later finite arithmetic replay
is supplemental; the proof above is primewise and covers all n>=2.
