# Exact finite computation for prime-packet boundary transport

**Author:** ChatGPT
**Date:** 2026-09-03
**Status:** exhaustive finite audit and independently replayed certificates;
the exact uniform PBT gate is refuted by a separate ordinary proof, while the
standard abc conjecture remains open

## 1. Question and scope

This note audits the finite optimization underlying
`UniformEndpointPrimePacketBound`.  For every normalized positive primitive
triple

\[
  1\le a\le b,\qquad a+b=c,\qquad (a,b)=1,\qquad c\le3000,
\]

we factor all three coordinates, form the actual endpoint source packets and
external radical sinks, and compute the global optimum over every indivisible
sink assignment.  Unit arms are included.  The scan therefore tests both the
one-source families which defeated earlier edge models and the multiple-source
prime-neighbour pattern which attacks exclusive ownership.

The exhaustive scan is supplemented by 1,038 structured rows: unit
prime-square endpoints, prime-hypotenuse Pythagorean squares, smooth-power
unit endpoints, and square-primorial prime-predecessor points.  No finite
absence or frequency is assigned asymptotic meaning.

## 2. Exact multiplicative optimizer

Suppose the powerful endpoint primes are

\[
 p_i^{e_i}\Vert c,\qquad e_i\ge2,
\]

and put \(S_i=p_i^{e_i-1}\).  If source \(i\) receives a set of distinct
external primes with product \(T_i\), then its logarithmic residual is

\[
 \max\{\log S_i-\log T_i,0\}
   =\log\!\left(\frac{S_i}{\min\{S_i,T_i\}}\right).
\]

Thus the exponential of the total residual is the rational number

\[
 \mathcal R(o)
   =\frac{\prod_iS_i}{\prod_i\min\{S_i,T_i(o)\}}.           \tag{2.1}
\]

### Proposition 2.1

The dynamic program which begins at \((1,\ldots,1)\) and, for each sink
prime \(q\), either leaves the state unchanged or replaces one coordinate
\(t_i\) by \(\min\{S_i,qt_i\}\), returns the exact minimum of (2.1).

### Proof

Every path through the dynamic program is an assignment of each processed
sink to `unused` or to one source.  Conversely every assignment determines
such a path.  Before saturation, a state coordinate is the exact product of
the sinks assigned to that source.  Once it reaches \(S_i\), later assignments
cannot change that source's residual, so replacing every larger product by
\(S_i\) loses no objective information.  After the last sink, maximizing the
product of the capped coordinates minimizes (2.1), whose numerator is fixed.
The transitions and comparisons use integers only.  QED.

The scalar divisible relaxation has residual factor

\[
 \mathcal D=\max\left\{\frac{\operatorname{core}(c)}
          {\operatorname{rad}(ab)},1\right\}.
\]

The packet boundary inequality gives \(\mathcal R\ge\mathcal D\).  We record
both the exact rational optimum and the exact fragmentation factor
\(\mathcal R/\mathcal D\).

For a rational threshold \(r/s\), the comparison

\[
 \frac{\log\mathcal R}{\log\operatorname{rad}(abc)}\ge \frac{r}{s}
\]

is decided by the integer inequality

\[
  \operatorname{num}(\mathcal R)^s
  \ge \operatorname{den}(\mathcal R)^s
      \operatorname{rad}(abc)^r.                             \tag{2.2}
\]

Consequently the reported ratio grid and its global enclosure do not depend
on floating-point comparisons.

## 3. Exhaustive results

The scan contains exactly 1,368,094 normalized positive primitive triples.
Of these, 962,223 have no positive source, 362,531 have one positive source,
and 43,340 have at least two.  Exact optimization gives:

| property | count |
|---|---:|
| zero optimal packet residual | 1,367,470 |
| positive optimal packet residual | 624 |
| packet optimum strictly above scalar defect | 572 |
| scalar defect zero but packet residual positive | 567 |
| packet optimum equal to scalar positive part | 1,367,522 |

This table gives useful evidence in both directions.  Complete packet
coverage is the overwhelmingly common finite mechanism.  Nevertheless,
exclusive ownership creates a genuine defect at hundreds of complete-premise
points, usually without any scalar abc defect.

The first pure fragmentation certificate is

\[
                         (a,b,c)=(1,71,72).
\]

Here

\[
 72=2^3 3^2,\qquad \operatorname{core}(72)=12,\qquad
 \operatorname{rad}(ab)=71.
\]

There are two source capacities, \(4\) and \(3\), and one sink, \(71\).
The sink saturates whichever source owns it and cannot touch the other.  The
optimal residual factor is therefore \(\min\{4,3\}=3\), while the scalar
positive-part factor is one.  The archived assignment sends `71` to the
source at `2`; the capped reward is `4`, so (2.1) gives `12/4=3`.

The largest residual factor in the exhaustive range is `16`, at

\[
                         (1,2591,2592),
 \qquad 2592=2^5 3^4.
\]

The unique sink `2591` saturates the source of capacity `27`, leaving the
capacity-`16` source uncovered.  Again the scalar defect is zero.

The largest residual/conductor ratio falls in the globally certified cell

\[
 \frac{5468}{12000}
 \le \max_{c\le3000}\frac{\log\mathcal R}
        {\log\operatorname{rad}(abc)}
 <\frac{5469}{12000}.                                       \tag{3.1}
\]

The sole point in this cell is `(1,2400,2401)`.  It has one source of
capacity `343`, external radical `30`, conductor `210`, and residual factor
`343/30`.  This is a scalar deficit rather than a fragmentation gap.

## 4. Structured positive and adversarial tests

The structured CSV contains the exact factorization, source capacities, sink
set, attaining assignment, packet products, capped reward, residual, scalar
defect, fragmentation factor, conductor, and exact ratio cell for every row.

* Among 669 unit prime-square rows with \(p\le5000\), 652 have zero residual.
  The 17 positive rows are one-source scalar deficits; indivisibility adds
  nothing.
* Among 329 prime-hypotenuse Pythagorean-square rows with \(p\le5000\), 324
  have zero residual.  The five positive rows are likewise one-source scalar
  deficits.  This confirms that the old edge-order and edge-cost obstructions
  do not automatically obstruct one aggregate packet.
* Among 35 rows `(1,N^k-1,N^k)`, with
  `N in {6,10,12,18,30}` and `2<=k<=8` subject to `N^k<=10^12`, 21 have zero
  residual and 14 have positive residual.  These finite patterns prove no
  fixed-base theorem.
* For the square-primorial sanity rows, let \(M_k\) be the product of the
  first \(k\) primes and choose the first searched multiplier \(t\le1000\)
  for which \(tM_k^2-1\) is prime, under the frozen size cap.  Rows exist for
  `k=2,...,6`; their optimal residual factors are respectively
  `3, 10, 70, 1260, 4620`.  Each has one external sink and several compulsory
  powerful endpoint sources.

The last five rows are finite witnesses of the exact mechanism used in
Theorem 5.1 of
`research/ABC_PRIME_PACKET_BOUNDARY_THEORETICAL_AUDIT_2026_09_03.md`.
That theorem invokes Linnik's least-prime theorem to construct an infinite
complete-premise family and unconditionally refutes the exclusive-ownership
PBT gate.  The theoretical proof does not infer an infinite statement from
these rows and does not use the computation.

## 5. Independent validation and conclusion

The validator does not import the producer.  It independently constructs a
smallest-prime-factor table, re-enumerates all 1,368,094 triples, recomputes
every packet optimum with a separate state-set dynamic program, and checks
the five headline classifications, first certificates, largest residual,
threshold counts, and exact coarse and fine ratio cells.  It also validates
all 1,038 structured rows and then reruns the producer in a temporary
directory.  Both generated artifacts agree byte for byte.  The frozen
validation status is `PASS`.

The computation therefore supplies exact finite confirmation of both sides
of the route analysis: aggregation often covers every source, while
exclusive ownership loses simultaneous congruence information when one
prime is related to many powerful endpoint primes.  The complete Linnik
family retires this exact PBT gate.  It does not retire shared-incidence,
congruence-labelled, multi-face, homological, or IUT routes, and it neither
proves nor disproves the standard abc conjecture.
