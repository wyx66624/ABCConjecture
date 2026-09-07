# Signed-tail aggregation, a small-rho residual obstruction, and computability

Author: ChatGPT. Date: 2026-09-07.

**Status.** This is the next ordinary-mathematics note. It neither proves nor
refutes the restricted signed-tail gate. Its unconditional results are an exact
homogeneous rank decomposition, a sufficient rankwise aggregation implication,
and a complete content-one small-rho family showing why repeated lifting cannot
simply be charged to the chosen exponent g in a residual representation. The
last family is explicitly NOT a counterexample to the signed-tail bound.
No new Lean validation or integrated-manuscript status is asserted here.

## 1. The precise gate being audited

For a primitive positive triple, let T=abc and let its actual Eisenstein element
admit z=u*(1+zeta)^e0*v*w^g, with Q=N(w)>=7 and V=N(v)>=1. Set

    h=max(1,log V), rho=h*log(4+g)/g, Y=rho^(-1/6),
    W_Y(T)=product_{p|T,p>Y} p^(v_p(T)-3).

Negative exponents in W are retained. The shared-column theorem proves ABC on
the class having small rho and W_Y(T)<=g^B for a fixed B. Its large-prime
arithmetic hypothesis remains open. None of the counterfamilies for raw excess,
prime-norm terminal envelopes, or unnormalized power-descent losses supplies all
the premises of a counterexample to this restricted signed statement.

The shared-column theorem actually needs less than a polynomial bound in g.
It suffices to have a uniform bound max(0,log W_Y(T))/log c tending to zero along the
class. For example, any bound log W_Y(T)<=g*delta(g), with a fixed function
delta(g)->0, suffices: log c>=g log 7/2. This is only an absorption observation,
not an independent proof of that arithmetic bound.

## 2. An exact homogeneous rank decomposition

Let w be a primitive nonunit Eisenstein integer with no ramified factor and no
conjugate pair of split factors. Write Q=N(w)>=7. Its powers remain primitive.
Let T_n=|P(w^n)|, and rotate w^n to the positive sector when defining its height
c_n. Such a boundary is nonzero: a primitive zero-boundary element is a unit.

For a rational prime p>3 with p not dividing Q, reduce

    eta=(w/bar(w))^3

in the residue field at a place above p and let d_p be its order. At a split
prime the two choices of place give inverse residues and hence the same order;
at an inert prime the norm-one subgroup has order p+1. Thus

    d_p divides p-1 or p+1, and p does not divide d_p.

The exact cubic identity and elementary odd-prime LTE imply

    p divides T_n iff d_p divides n,
    v_p(T_n)=s_p+v_p(n) when d_p divides n,
    s_p=v_p(T_{d_p}) >= 1.                         (H1)

Indeed, the cubic identity identifies the valuation of eta^n-1 with that of
T_n because p>3 and Q is a unit. For n=d_p*m, odd-prime binomial lifting in
the unramified local quadratic ring gives v(eta^n-1)=v(eta^d_p-1)+v_p(m).
Since p does not divide d_p, the last term is v_p(n). Inert primes cause no
ramification factor; at split primes the valuation normalization is ordinary.

For Y>=3 define the finite signed rank packet

    A_d(Y;w)=product_{p>Y,d_p=d} p^(s_p-3).

Every such prime divides the fixed nonzero integer T_d, so the product is
finite. Define also

    L_{n,Y}=product_{p>Y,d_p|n} p^v_p(n).

Then prime-by-prime (H1) proves the EXACT identity

    W_Y(T_n)=L_{n,Y} * product_{d|n} A_d(Y;w),
    L_{n,Y} divides n.                            (H2)

The rank packet retains negative low-depth contributions. Replacing it by its
positive part discards arithmetic credit and constitutes a stronger hypothesis.
For n with the homogeneous rho=log(4+n)/n sufficiently small, its prescribed
cutoff Y_n=rho^(-1/6) is at least three, so (H2) applies exactly to that cutoff.

## 3. A rankwise polynomial budget already suffices

**Theorem H3.** Fix a real kappa>=0. Consider the actual homogeneous pairs
(w,n) above with n>=1 and Y_n>=3, for which every divisor d of n satisfies

    A_d(Y_n;w) <= (Q*d)^kappa.                    (H3)

Then, uniformly in Q and the prime support,

    log W_{Y_n}(T_n)
      <= log n + kappa*tau(n)*log Q
         + (kappa/2)*tau(n)*log n.               (H4)

Consequently max(0,log W_{Y_n}(T_n))/log c_n -> 0 as n->infinity uniformly on this
class. For every epsilon>0 all sufficiently large n in this class satisfy
c_n<=rad(T_n)^(1+epsilon). The threshold is independent of w.

**Proof.** Take logarithms in (H2), use L_{n,Y}<=n, and sum (H3). The divisor
pairing d <-> n/d gives

    sum_{d|n} log d = tau(n)*log n/2.

This proves (H4), including the square case where sqrt(n) pairs with itself.
There are at most sqrt(n) divisors at most sqrt(n), and each remaining divisor
pairs with one of them, so tau(n)<=2sqrt(n). Since log c_n>=n log Q/2 and
Q>=7, (H4) implies

    log W_{Y_n}(T_n)/log c_n
      <= 2 log n/(n log 7)
         + 4 kappa/sqrt(n)
         + 2 kappa log n/(sqrt(n) log 7) -> 0.    (H5)

The right side of (H5) is nonnegative and tends to zero, so it also bounds
the positive part of the left side. The signed logarithm itself need not tend
to zero after normalization; it can retain negative linear credit.
The homogeneous shared-column penalty is uniformly o(log c_n), as is its full
small-prime mass at Y_n. Insert (H5) into the exact compensated cubic height
inequality and absorb below 3epsilon/(1+epsilon). This proves the conclusion.

**What is and is not new.** The aggregation and implication are proved here.
The arithmetic rank-packet premise (H3) is NOT proved for all w,d. It is a
precise smaller target for first-appearance research, not a solved global bridge.
It permits polynomial dependence on Q as well as d; treating w as fixed was
not used in the uniform absorption. The cutoff in every rank packet must be
the actual Y_n. A bound on the full signed packet at Y=0 does not automatically
persist after small negative-credit primes are removed.

A common aggregation shortcut is false: local estimates A_d<=d^kappa do not
logically imply product_{d|n} A_d<=n^B for one fixed B. The abstract equality
model A_d=d^kappa has product n^(kappa*tau(n)/2), and tau(n) is unbounded
(take n=2^j). This refutes only that abstract aggregation inference, not an
arithmetically realized rank-packet claim. The slower bound (H5) is precisely
why the false shortcut is unnecessary for the restricted ABC implication.

## 4. A complete residual family with small rho and content one

The division L_{n,Y}|n in (H2) is genuinely homogeneous. The following family
shows that it must not be transplanted to an arbitrary chosen exponent g in
z=v*w^g, even after demanding small rho and total exponent gcd one.

Fix w=2+zeta, so Q=7 and w^2=3+5zeta. For each integer k>=1 put g_k=2^k and
write w^g_k=A_k+B_k*zeta. Since g_k is even,

    w^g_k = 3^(g_k/2) modulo 5.

Thus A_k+B_k is invertible modulo 5^k. Let y_k be the unique representative
in [0,84*5^k) satisfying

    B_k+y_k*(A_k+B_k) = 0 modulo 5^k,
    y_k = 42 modulo 84.                          (R1)

Existence and uniqueness follow from the modular inverse and CRT. Set

    v_k=1+y_k*zeta, V_k=1+y_k+y_k^2,
    z_k=v_k*w^g_k, T_k=|P(z_k)|.                 (R2)

**Theorem R3.** These are primitive nonzero-boundary Eisenstein elements whose
positive rotations give actual primitive ABC triples. Their split-norm exponent
gcd is exactly one, their shared representation has rho_k->0, and

    5^k divides T_k, whereas 5 does not divide g_k. (R3)

**Proof.** The factor v_k has coprime coordinates (1,y_k). Also y_k is divisible
by 3 and 7, so V_k is divisible by neither prime. In particular multiplication
by w^g_k introduces no rational 7 divisor or conjugate pair; primitivity follows
from the established oriented factorization criterion. There is no ramified
factor. The norm is greater than one, so the primitive boundary cannot be zero.

Since y_k=2 modulo 4, V_k=3 modulo 4. Its prime factorization has at least one
odd exponent; otherwise it would be a square and have residue one modulo four.
That exponent belongs to a prime other than seven. The norm exponent at seven
is 2^k. Their gcd is one, so the complete split-exponent gcd is one.

The second coordinate of z_k is B_k+y_k*(A_k+B_k), divisible by 5^k by (R1).
The first coordinate is A_k-y_k B_k. Modulo five, B_k=0, A_k is nonzero and
y_k=0, so the first coordinate and the sum of the two coordinates are units.
Thus v_5(T_k) is the valuation of the second coordinate and is at least k.
Finally 5 does not divide 2^k.

The residual is small on the logarithmic scale:

    log V_k < log(3*84^2)+2k log 5,
    log(4+2^k) <= (k+2)log 2.

Therefore rho_k=log V_k*log(4+2^k)/2^k=O(k^2/2^k)->0. This also proves the
claimed small-rho property without factoring V_k. All premises hold for every
k; this is not an abstract incidence or valuation model.

**Exact limitation.** This disproves the inference that residual-family
valuation growth can always be assigned to prime powers dividing the chosen g
while retaining the homogeneous first-depth data from w. More precisely, for
this w one has d_5=2 and s_5=v_5(P(w^2))=v_5(120)=1. Thus the exact proposed
extension

    v_5(P(v*w^g)) <= s_5+v_5(g)

would give a bound of one on this family, whereas the actual valuation is at
least k. This displayed claim, with d_5 and s_5 taken from w, is refuted for
arbitrarily small rho and content-one profiles. A formula defining NEW
residual-dependent first depths is a different claim and is not refuted here.
It does NOT disprove W_{rho^-1/6}(T)<=g^B. The prime five eventually lies BELOW
the moving cutoff, since rho_k->0. Moreover nothing in (R3) controls all the
other boundary primes or the signed low-depth credits. In particular the
family must not be used as an ABC counterexample or as a counterexample to
the restricted signed-tail hypothesis.

The critical-bottleneck agent is independently developing the correct residual
replacement: shifted congruence classes in the exponent, whose spacing follows
from the full two-boundary gcd identity and homogeneous LTE. That structure
retains the displacement from an actual rank representative, rather than
replacing it by divisibility of g.

## 5. Independent exact modular replay of the residual family

The following rows were calculated with integer-pair modular exponentiation,
exact modular inverses and CRT. For each reported exact valuation e, the second
coordinate was checked to vanish modulo 5^e and not modulo 5^(e+1); both other
boundary coordinates were checked to be units modulo five. No growing boundary
integer was factored. The rho and digit columns are floating-point diagnostics,
not certificates of an effective logarithmic-form constant.

| k | g=2^k | y_k | exact v_5(T_k) | approximate rho | approximate decimal digits of c |
|---|---:|---:|---:|---:|---:|
| 1 | 2 | 210 | 1 | 9.585 | 4 |
| 2 | 4 | 630 | 3 | 6.703 | 5 |
| 4 | 16 | 26670 | 4 | 3.816 | 12 |
| 8 | 256 | 8653470 | 10 | 0.6939 | 116 |
| 12 | 4096 | 7276917270 | 12 | 0.09224 | 1741 |
| 16 | 65536 | 7181029215570 | 16 | 0.01002 | 27706 |
| 18 | 262144 | 144280296684930 | 20 | 0.003103 | 110783 |
| 20 | 1048576 | 5276983743390870 | 21 | 0.0009572 | 443091 |
| 30 | 1073741824 | 52088276646721754406030 | 30 | 0.000002026 | 453708579 |

At k=60 the same exact modular check gave v_5(T_k)=60 and

    y_k=68241954801651958276479102681562535685228870.

Its full c has on the order of 4.87*10^17 decimal digits. The modular
certificate remains inexpensive because its modulus has only O(k) digits.
This illustrates the distinction between computing a local arithmetic witness
and computing its complete radical.

## 6. Size audit of the two shared-column example families

For the Section 4 rapidly growing family with the first two primes 7 and 13,
D=2+log 7+log 13 gives D^2 approximately 42.3913. Consequently

    g=ceil(exp(D^2)) is approximately 2.5722*10^18,
    log_10 c is approximately 2.5195*10^18.

Already the first two-prime example is far beyond a feasible explicit boundary
construction or factorization. Its ordinary existence proof is valid; it must
not be described as a numerically tested quality or signed-tail example.

For the slower strict-separation family, take all q=1 modulo 3 primes in [X,2X]
and g=ceil(r^4*(log X)^2). Elementary trial division certified each listed small
prime set. The following estimates use logarithms only; no boundary factoring
was performed.

| X | r | g | approximate rho | approximate log_10 c |
|---:|---:|---:|---:|---:|
| 7 | 2 | 61 | 0.4842 | 61.287 |
| 19 | 3 | 703 | 0.1927 | 1529.401 |
| 31 | 4 | 3019 | 0.1019 | 9787.422 |
| 100 | 10 | 212076 | 0.01627 | 2303867.624 |
| 127 | 12 | 486595 | 0.01113 | 6591119.224 |
| 1000 | 68 | 1020256894 | 0.0003529 | 1.09756*10^11 |

For X=127 the prime list is
127,139,151,157,163,181,193,199,211,223,229,241. It reaches rho<1/64, but
the actual height already has about 6.6 million decimal digits. This does not
invalidate the theorem; it limits any claim of a complete radical computation.
For all entries, the norm-to-height comparison contributes at most
log_10(sqrt(4/3)) to log_10 c, so it does not affect these size assessments.

## 7. Remaining exact obligations

1. Prove arithmetic rank-packet budgets such as (H3), or give an actual
   complete-premise counterfamily to the proposed rank bound. The abstract
   divisor aggregation model is not such an arithmetic counterfamily.
2. In the nonunit-residual setting replace homogeneous ranks by their actual
   shifted progression data. The content-one family (R1)--(R3) proves that a
   direct lifting-divides-g shortcut is false even when rho tends to zero.
3. Obtain a uniform signed aggregate bound from those shifted data, retaining
   prime support, negative credits and the actual moving cutoff.
4. Keep the independent mixed-map search separate: small norm radical plus
   an actual input quality above one half, or two consecutive small compressed
   norms, would give a sufficient disproof criterion. Neither existence premise
   follows from the balance theorem, the local modular witnesses, or (H2).

No complete-premise counterfamily to the current restricted signed-tail gate
has been found in this round. That gate and its parent routes remain active.

## 8. Independent in-session review

The critical-bottleneck agent independently reviewed H3 and R3, including the
signed product, cutoff dependence, uniformity in Q, content-one CRT premises,
primitivity and the fact that five eventually leaves the tail. The proofs were
accepted with one domain clarification: H3 now explicitly states Y_n>=3, the
domain in which the rank packets are defined. This is in-session agent review,
not external peer review or formal verification of this new note.

During second-round manuscript transcription, the reviewer caught and corrected
an additional precision issue: the one-sided upper bound (H5) proves decay of
the positive part, not a two-sided little-oh claim for a signed logarithm.
This correction does not change the sufficient ABC absorption conclusion.
