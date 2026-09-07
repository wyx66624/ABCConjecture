# Very large prime incidence on the actual boundary arms

2026-09-07. Complete ordinary candidate VG1--VG4, pending independent full review. This is new fourteenth-round work. All thirteenth-round publication material remains frozen. No graph-membership or prime-count hypothesis is added.

## VG1. Actual inputs and the two-endpoint property

Let n>324 be prime, B=n^4, r=ceil(sqrt(6n)), and L=log(8B). Put

    I_B={k in Z:B<=k<2B}, a_k=3k, w_k=a_k+zeta,
    zeta^2=zeta-1, Q_k=a_k^2+a_k+1, alpha_k=w_k/bar(w_k).

Let I be any fixed subset of I_B whose actual ratios alpha_k are multiplicatively independent. For example, the established private-norm set has this property, as does any fixed norm-support color. No independence assertion for an arbitrary subset of the whole block is made.

Write w_k^n=A_k+C_k*zeta, and let the three positive arm sizes be

    b_(k,1)=|A_k|, b_(k,2)=|C_k|, b_(k,3)=|A_k+C_k|,
    T_k=product_j b_(k,j), c_k=max_j b_(k,j), t_k=log c_k.

These actual powers are primitive and unramified. Thus the arm sizes are nonzero and pairwise coprime. This is the established primitive-power statement, not an extra unproved membership condition. For clarity, a zero boundary would make w_k^n a unit times a rational integer, contradicting the nonzero oriented split-prime valuations of w_k/bar(w_k). Also gcd(A_k,C_k)=1 implies pairwise coprimality of all three arms.

The actual norm bounds 9B^2<=Q_k<36B^2 and the quadratic-coordinate bound give

    n log(3B)<=t_k<nL.                              (VG1)

Indeed c_k>=Q_k^(n/2), while c_k<=(2/sqrt(3))Q_k^(n/2)<(2/sqrt(3))(6B)^n<(8B)^n. The norm and every arm are coprime: reducing the norm modulo a prime dividing one of A_k,C_k,A_k+C_k leaves the square of a nonzero coordinate.

Consider all rational primes q satisfying

    log q >= (r/2)L.                               (VG2)

For each such q let E_q={k in I:v_q(T_k)>=4}. Then |E_q|<=2.

Proof. Condition (VG2) implies q>8B>n and q^4>=(8B)^(2r). Any hit supplies a norm-unit ratio modulo q^4. The identity

    (A+C*zeta)^3-(A+C*bar(zeta))^3
       =3AC(A+C)(zeta-bar(zeta))

shows that alpha_k^(3n)=1 modulo q^4. Since q does not divide 3n, the norm-one torsion group has at most 3n elements; this is the established split/inert simple-lifting count. The uniform tuple determinant bound is strictly below (8B)^(2r). Hence equal products of r hit ratios modulo q^4 give exactly equal ratios in Q(zeta). Multiplicative independence recovers all multiplicities, so

    choose(|E_q|+r-1,r)<=3n.

If |E_q|>=3, the left side is at least (r+1)(r+2)/2>r^2/2>=3n, a contradiction. Empty I and empty hit sets require no separate assumption. This is the reviewed OC support theorem, with its full actual hypotheses restated.

The tuple bound and finite-group count are established ordinary inputs from UM/AP/OC. They are not asserted to be newly formalized here.

## VG2. Simultaneous prime packets and the per-arm degree

Let V=I x {1,2,3}. The graph labels are precisely those primes satisfying (VG2) with E_q nonempty. Its endpoint set is

    e(q)={(k,j):k in E_q and q divides b_(k,j)}.

Pairwise coprimality gives one and only one arm j for each hit root. Thus each label has one or two endpoints, with distinct roots when there are two. Different prime labels may have the same endpoint set. Singleton edges are allowed. There are finitely many labels since every label divides the nonzero integer product_k T_k.

For an endpoint v=(k,j), write e_v(q)=v_q(b_v), so e_v(q)>=4 at incidence. For any subset U of V and any subset P of the graph labels, the following actual positive-integer divisibility holds:

    product_(q in P) q^(sum_(v in U intersect e(q)) e_v(q))
           divides product_(v in U) b_v.          (VG3)

For each prime q, the exponent on the left is at most the q-valuation of the product on the right. This proves simultaneous divisibility for all distinct primes, not merely one prime at a time. In particular, writing d_U(q)=|U intersect e(q)|,

    4 sum_q d_U(q) log q
       <=sum_q sum_(v in U intersect e(q)) e_v(q) log q
       <=sum_(v in U) log b_v.                    (VG4)

All sums are finite. Primes omitted from the graph, and depths below four at other vertices, only contribute additional nonnegative mass on the right.

Set d=floor(n/(2r)). Every actual arm vertex has degree at most d. Indeed if m distinct graph labels meet v, (VG2)--(VG4) imply

    2rL m <=sum_(q incident to v)4log q
            <=log b_v<=t_k<nL.

Thus m<n/(2r). Since n is odd and 2r is even, n/(2r) is not an integer; hence m<=d. The uncontracted graph on whole roots has degree at most 3d. This is an O(sqrt(n)) degree bound simultaneously for all labels, without assuming that their number is o(B).

Summing incidences gives |labels|<=3d|I|. If all labels had two endpoints, the improved bound |labels|<=3d|I|/2 would follow, but singleton labels have not been excluded. The actual logarithmic packet inequality is more precise than this unweighted consequence and remains available for further work.

## VG3. An actual joint matching decomposition

For n>324 one has d>=1. The entire prime-labelled graph on arm vertices can be partitioned into at most 2d-1 matchings. Here a matching means a set of distinct prime labels whose endpoint sets are pairwise disjoint. Two labels in one matching cannot use the same actual arm; different arms of one root are still permitted.

Proof. Process the finite prime labels in increasing order. At an edge with two endpoints, at most 2(d-1) earlier labels meet either endpoint, because the total degree at each endpoint is at most d and the current edge itself occupies one incidence. At a singleton edge there are at most d-1 such earlier labels. Multiple edges cause overcounting in this estimate, not an increase. Therefore among 2d-1 colors there is always a color not used by any adjacent earlier edge. Assign the first available color. The resulting color classes are the required matchings. No multigraph-coloring theorem or generic matroid partition is assumed.

For completeness, d>=1 follows from 2r<=2sqrt(6n)+2<n for n>324. With empty I there are simply no labels to color.

This decomposes the actual simultaneous many-prime incidence into O(sqrt(n)) families. It does not assert small total weight in one matching, a bounded number of labels across all matchings, or a decomposition of the still unproved full-block independent complement.

## VG4. The remaining weighted interface

Subtracting the graph's three radical units from (VG4) gives, for every U,

    sum_q sum_(v in U intersect e(q)) (e_v(q)-3) log q
       <=sum_(v in U) log b_v
          -3 sum_q d_U(q) log q.                  (VG5)

This is a genuine simultaneous inequality for the actual graph. For U=V it counts exactly the positive excess in the region (VG2), since each prime depth belongs to one arm of each hit root. It preserves the graph's radical saving, but does not incorporate the negative global contributions at depths one and two.

The currently proved estimates do not make the right side o(sum_k t_k). Even the total-label estimate is O(|I|sqrt(n)), rather than the o(B) sufficient interface in AP. The matching decomposition alone gives no improvement of this weight budget.

A precise boundary for these finite inequalities can be exhibited without claiming an actual arithmetic counterexample. For sufficiently large n, take N formal root vertices with three arms each and m=floor(n/(4r)) private labels per arm. Give each label depth four and logarithmic weight w=(r/2)L. Every edge is a singleton. On each arm the full weighted mass is 4mw=2rmL<=nL/2, and its degree m is at most d. All higher-moment support counts at a fixed label are one. Thus the finite degree, two-endpoint, moment-cardinality, and strict arm-cap inequalities hold in this abstract weighted ledger. But its positive excess per root is 3mw, asymptotic to 3nL/8, and hence is linear in the available height scale.

The formal labels and weights in this example are not constructed from distinct rational primes or from Eisenstein powers. Therefore this is only a counterexample to deriving a sublinear conclusion from those finite ledger inequalities alone. It is not a counterexample to an actual root statement, a signed-compensation conjecture, or ABC. The additional simultaneous arithmetic content of (VG3), and more restrictive actual cross-prime structure, remain possible sources of improvement.

Open interfaces retained: a stronger actual bound on private labels or their total cost, signed credits outside the positive graph, interactions between different prime labels, and the roots outside the established independent domain. None is declared impossible or automatically satisfied.

## Scope and references

Ordinary inputs: reviewed UM uniform determinant and norm-one simple lifting; reviewed primitive powers and actual height bounds; reviewed AP/OC precision and support arguments. New conclusions here are the complete per-arm degree proof, its all-subset actual prime-packet formulation, and the finite greedy matching decomposition. No density replacement for actual membership, new software certificate, or Lean theorem is claimed.
