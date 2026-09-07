# Two-owner concentration of actual large-prime excess

Fourteenth-round ordinary proof, 2026-09-07. Root, adversarial_audit
and independent_route independently read the complete proof, all PASS,
before any new formal implementation.
This uses the independently reviewed UM determinant and finite-group
inputs, together with the explicitly restated adaptive-precision step
below. It does not modify the current UM paper or Lean source.

## OC1. All precision levels and the two largest depths

Use the actual independent root set I, prime n>324, B=n^4 and
L=log(8B) of adaptive_precision.md. For a prime q>8B put
e_k=v_q(T_k) and M_h=#{k in I:e_k>=h}.

Whenever e and nu are positive integers and

    e log q >= 2 nu L,

the strict UM determinant bound and divisibility by q^e imply exact
ratio equality of two nu-fold products. The norm-one 3n-torsion
group at precision e has at most 3n elements. Actual multiplicative
independence therefore gives

    choose(M_e+nu-1,nu)<=3n                      (OC1)

when M_e>0, with the empty case interpreted as zero multisets.

Set

    r=ceil(sqrt(6n)),
    h0=max(4,ceil(6L/log q)),
    h1=max(h0,ceil(2rL/log q)).

Then

    M_4<=sqrt(6n),     M_(h0)<3 n^(1/3),
    M_(h1)<=2.                                  (OC2)

The first estimate uses nu=2 and q>8B. For the second, use nu=3:
6 choose(M+2,3)=M(M+1)(M+2)>=M^3, so M^3<=18n<27n.
For the third, if M>=3, monotonicity of the multiset count gives

    3n>=choose(r+2,2)=(r+1)(r+2)/2>r^2/2>=3n,

a contradiction. The ceilings give the required precisions exactly.

Choose O_q to consist of the min(2,|I|) roots of largest depth, breaking
ties by the actual index ordering. It contains every root with
e_k>=h1. This is an actual prime-dependent set of at most two roots;
it is not claimed to be independent of q.

## OC2. Complete cost outside these two owners

For every prime q>8B,

    sum_(k in I\O_q) (e_k-3)_+ log q
       <=39 n^(5/6) L,                          (OC3)

and the complete positive cost satisfies

    sum_(k in I) (e_k-3)_+ log q
       <=(2n+39 n^(5/6)) L.                     (OC4)

Proof. All roots outside O_q have depth below h1. The identity for the
positive excess as the sum of all layers j>=4 leaves exactly two
ranges to pay.

If h0>4 then h0=ceil(6L/log q), and h0-4<=6L/log q. If h0=4 the
first range is empty. In both cases the layers 4<=j<h0 cost at most

    6 sqrt(6n) L <15 sqrt(n) L.                  (OC5)

If h1>h0 then h1=ceil(2rL/log q) and h1-h0<=2rL/log q. Otherwise
the second range is empty. Since

    r<=sqrt(6n)+1<=4sqrt(n),

the layers h0<=j<h1 cost at most

    2r M_(h0) L <=24 n^(5/6) L.                 (OC6)

Adding and using sqrt(n)<=n^(5/6) proves OC3. No rounding error has
been discarded and no assumption on which of the two ranges is
nonempty is necessary.

At any q>8B the actual primitive boundary coordinates are pairwise
coprime. The full q-adic multiplicity of T_k belongs to one coordinate,
so e_k log q<=t_k<nL. Paying the at most two members of O_q by this
single-coordinate cap proves OC4.

In particular the whole-block normalized cost outside O_q is at most

    (78/B) n^(-1/6),                            (OC7)

using t_k>=n log(3B) and L<=2log(3B). This bound is uniform in q.
It cannot be summed over an unrestricted number of primes and then
called sublinear.

## OC3. An actual support graph for very large primes

If

    log q >= (r/2) log(8B),                     (OC8)

then h0=h1=4, because r>=3. Hence M_4<=2 exactly. Every prime above
the threshold in OC8 with positive excess is supported at depth at
least four on at most two roots of I.

Thus the actual positive-excess incidence structure in this very
large-prime region is a graph with possible one-vertex edges: each
prime labels one edge whose endpoints are the one or two actual roots
with v_q(T_k)>=4. Repeated edges carrying different prime labels and
unbounded numbers of private one-vertex edges are allowed.

This is not an absence theorem for positive excess. The choice of
O_q varies with q, and the currently proved estimates do not control
the sum of their costs over all q. In particular an arbitrary
number of one-vertex edges is not excluded by multiplicative
independence alone. The original signed tail can also benefit from
depth-one and depth-two credit not represented by this positive
incidence graph.

The theorem supplies a concrete actual structure for the remaining
large-prime problem, not a proof of the global signed gate, a
distribution assertion about these prime labels, or a new formal
Lean theorem.
