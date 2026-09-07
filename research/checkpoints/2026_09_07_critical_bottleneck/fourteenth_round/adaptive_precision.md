# Adaptive precision for the complete cost at every large prime

Fourteenth-round ordinary proof, 2026-09-07. The complete argument
received independent full PASS from root, adversarial_audit and
independent_route before any new formal implementation. This does
not modify the published UM result or its fifteen declarations.
No global signed-tail membership is asserted.

## AP1. Setup and an individual-arm height cap

Let n>324 be prime, B=n^4, and let I be any subset of the actual block
B<=k<2B on which the ratios

    alpha_k=(3k+zeta)/(3k+bar(zeta))

are multiplicatively independent. In particular I can be the actual
private-norm class from PN, or one color of NC. Put w_k=3k+zeta,
T_k=|P(w_k^n)|, c_k=max of the three absolute boundary coordinates,
and t_k=log c_k. All powers are primitive and unramified.

Write L=log(8B). If w_k^n=A+C zeta, then each of A,C,A+C has absolute
value at most 2 sqrt(N(w_k^n))/sqrt(3). Also N(w_k)<36B^2. Therefore

    c_k < (2/sqrt(3)) (6B)^n < (8B)^n,
    n log(3B) <= t_k < n L.                         (AP1)

The second strict inequality follows from 2/sqrt(3)<4/3 and
(4/3)^n>=4/3. This proof only needs n>=1.

For every q>8B dividing T_k, exactly one of the three integer boundary
coordinates is divisible by q: they are pairwise coprime. Consequently

    v_q(T_k) log q <= t_k < n L.                   (AP2)

Using the entire product height here would lose a factor three.
The prime is automatically different from 2,3 and from all supported
norm primes of this particular root. Since q>8B>3k+1, its homogeneous
rank cannot be one; its rank is n. Thus q=1 or -1 modulo 3n.

## AP2. Precision and moment can be chosen separately

The reviewed UM determinant proof shows the following slightly more
general statement without any additional estimate. For any positive
integer nu and integer e>=1, if

    q>8B,       q^e >= (8B)^(2 nu),                (AP3)

then two nu-fold products of actual block roots which have the same
ratio modulo q^e have the same ratio over Q(zeta). Indeed their integer
phase determinant has absolute value strictly below (8B)^(2 nu), by
the uniform finite geometric-series bound, and q^e divides it.

Restrict to the M_e roots of I with q^e|T_k. Their ratios belong to
the norm-one 3n-torsion group modulo q^e, of cardinality at most 3n.
The finite-ring statement applies also when q splits or is inert,
because q does not divide 3n and the norm denominators are units.
The independent ratios and AP3 make the map from nu-multisets to this
finite group injective. Therefore, if M_e>0,

    choose(M_e+nu-1,nu) <= 3n.                     (AP4)

There are zero positive-length multisets if M_e=0.

Let r=ceil(sqrt(n)), and set

    h_q=max(4, ceil(2r L/log q)).                 (AP5)

For e=4 and nu=2, AP3 holds, so M_4<=sqrt(6n).
For e=h_q and nu=r, AP3 again holds. Since n>324, the reviewed
binomial threshold gives M_(h_q)<=3. In particular this remains
valid when h_q=4; no nonempty range of intermediate depths is presumed.

## AP3. Complete positive cost, without an upper bound on q

For every prime q>8B,

    sum_(k in I) (v_q(T_k)-3)_+ log q
        <= 13 n log(8B).                         (AP6)

Proof. If h_q=4, there are at most three roots with positive excess.
Their entire multiplicities satisfy AP2, giving the stronger bound
3nL.

Otherwise put u=2rL/log q. Since h_q>4, h_q=ceil(u), and

    h_q-4 <= u.

The full layers j=4,...,h_q-1 are bounded by

    (h_q-4) M_4 log q
       <= 2r sqrt(6n) L
       <= 4 sqrt(6) n L
       < 10 n L.                                (AP7)

Here r<=2sqrt(n). Every layer from h_q onward is supported on at most
three roots. Paying their entire multiplicities by AP2 contributes
at most 3nL. The identity

    (e-3)_+ = sum_(j>=4) 1_(j<=e)

shows that no intermediate or high layer has been omitted. It is
not necessary to bound the rounding error by a multiple of log q:
the subtraction of four in AP7 already absorbs it. This proves AP6.

Since log(8B)<=2log(3B) for B>=1, AP1 now gives the actual normalized
per-prime statement

    (1/B) sum_(k in I) (v_q(T_k)-3)_+ log q / t_k
        <= 26/B                                 (AP8)

for every q>8B, with no restriction q<=B^2.

More generally, if an actual norm-support set is partitioned into D
independent colors fixed before q is chosen, the right sides of AP6
and AP8 are multiplied by D.

## AP4. Consequences and the precise missing condition

For any real Z>8B, summing AP8 only over eligible primes and applying
the same Brun--Titchmarsh input as UM gives

    (1/B) sum_(k in I)
      [sum_(8B<q<=Z) (v_q(T_k)-3)_+ log q] / t_k
        <= 52 Z / [B(n-1) log(Z/(3n))]
        <= 55 Z / [Bn log(Z/(3n))].              (AP9)

The last inequality uses n>324. It holds also for Z>B^2, although the
right side is then generally too large for a sublinear conclusion.
On the previously proved logarithmic window this only improves a
constant; it is not an enlarged asymptotic window theorem.

There is an exact finite-support variant which does not count every
eligible rational prime. For a real Z>=8B define

    D_Z(I)={q>Z prime : v_q(T_k)>=4 for some k in I}.

This is a finite, data-dependent set because I is finite and all T_k
are nonzero integers. AP8 applies to every one of these primes, so

    (1/B) sum_(k in I)
      [sum_(q>Z) (v_q(T_k)-3)_+ log q] / t_k
        <= 26 |D_Z(I)| / B.                      (AP10)

In particular |D_Z(I)|=o(B), if independently proved along actual
blocks, would give an averaged o(height) bound for the entire far
positive excess while allowing arbitrarily deep valuations at its
remaining primes. This cardinality hypothesis has NOT been proved.
The currently known multiset estimates concern the number of roots
at a fixed prime; they do not bound the number of different primes
owned by different roots. In particular they do not imply AP10 is
small. A selected example or a typical reference residue distribution
cannot supply that missing actual cardinality estimate.

The original signed tail can retain cancellation even when this
positive target is too strong. No equivalence between AP10's
cardinality hypothesis and the global signed target is claimed.
The roots outside I and any exceptional roots are also still open.

Dependencies: UM all-length determinant rigidity and the binomial
threshold; MC finite-ring norm-one lifting and homogeneous rank;
the elementary actual block height; finite sums and the previously
reviewed primary Brun--Titchmarsh input. AP1--AP10 are ordinary
mathematics only, now independently reviewed; no new Lean assertion.
