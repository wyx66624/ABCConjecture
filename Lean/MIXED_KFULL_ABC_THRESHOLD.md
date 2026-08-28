# Mixed k-full signatures and the exact abc threshold

## Status

This note records a deterministic reduction.  It does **not** assert the
existence of an unbounded family and therefore does not prove or disprove the
abc conjecture by itself.

The corresponding Lean files are:

- `IUTThreeClosures/KFullABCThreshold.lean`;
- `IUTThreeClosures/MixedKFullABCSignature.lean`;
- their two axiom-audit modules.

## 1. Coordinate radical budgets

For a positive integer `n`, write

\[
\operatorname{rad}(n)=\prod_{p\mid n}p.
\]

Call `n` `k`-full when

\[
\operatorname{rad}(n)^k\mid n.
\]

Hence

\[
\operatorname{rad}(n)^k\le n.
\]

Let `(a,b,c)` be a primitive positive abc triple.  Suppose

\[
\operatorname{rad}(a)^{k_a}\mid a,
\qquad
\operatorname{rad}(b)^{k_b}\mid b,
\qquad
\operatorname{rad}(c)^{k_c}\mid c.
\]

Since `a,b\le c`, taking logarithms gives

\[
k_a\log\operatorname{rad}(a)\le\log c,
\quad
k_b\log\operatorname{rad}(b)\le\log c,
\quad
k_c\log\operatorname{rad}(c)\le\log c.
\]

Submultiplicativity of the radical gives

\[
\log\operatorname{rad}(abc)
 \le
 \log\operatorname{rad}(a)+
 \log\operatorname{rad}(b)+
 \log\operatorname{rad}(c).
\]

Multiplying through by `k_a k_b k_c` yields the denominator-free exact
inequality

\[
 k_a k_b k_c\,\log\operatorname{rad}(abc)
 \le
 (k_bk_c+k_ak_c+k_ak_b)\log c.
\]

For positive exponents this is equivalent to

\[
 \log\operatorname{rad}(abc)
 \le
 \left(\frac1{k_a}+\frac1{k_b}+\frac1{k_c}\right)\log c.
\]

Thus the exact strict-saving boundary is

\[
\boxed{
\frac1{k_a}+\frac1{k_b}+\frac1{k_c}<1.
}
\]

This is the same reciprocal-exponent boundary that occurs in the
Fermat--Catalan problem, but the present formulation applies to all k-full
coordinates, not only exact powers.

## 2. Homogeneous threshold

For `k_a=k_b=k_c=k`,

\[
k\log\operatorname{rad}(abc)\le3\log c.
\]

Therefore:

- `k=3` is critical and gives coefficient exactly one;
- every fixed `k\ge4` gives a strict coefficient saving;
- an unbounded primitive family of k-full triples with `k\ge4` would disprove
  abc.

Nitaj proved that there are infinitely many primitive 3-full triples.  This
lands exactly on the critical coefficient and therefore does not contradict
abc.

## 3. First mixed strict signature

The first symmetric improvement of `(3,3,3)` is `(3,3,4)`.  In this case

\[
\frac13+\frac13+\frac14=\frac{11}{12}<1,
\]

and Lean proves

\[
36\,\log\operatorname{rad}(abc)\le33\log c.
\]

Consequently an unbounded primitive family having only **one** 4-full
coordinate and two 3-full coordinates would already disprove abc.  This is a
strictly weaker construction target than requiring all three coordinates to
be 4-full.

The formal contradiction uses `\varepsilon=1/24`, leaving a positive gap
between `36` and `(1+\varepsilon)33`.

## 4. Correction to a common printed proof

De Koninck and Luca, *Analytic Number Theory: Exploring the Anatomy of
Integers*, Theorem 11.9, state the standard implication from abc to finiteness
of primitive 4-powerful solutions of `x+y=z`.  The displayed proof says to use
`\varepsilon=1/3` and obtains

\[
z\ll z^{3(1+\varepsilon)/4}.
\]

At the literal value `\varepsilon=1/3`, the exponent on the right is exactly
one, so this inequality alone does not bound `z`.  The argument is repaired by
choosing any

\[
0<\varepsilon<\frac13.
\]

The Lean theorem uses the explicit safe value `\varepsilon=1/6` for the
homogeneous 4-full case and `\varepsilon=1/24` for `(3,3,4)`.

This is a correction of the displayed epsilon choice, not a challenge to the
mathematical implication.

## 5. Construction targets

The deterministic part is now closed.  The remaining mathematical targets are
existence or no-go questions:

1. construct an unbounded primitive `(3,3,4)`-full family;
2. prove that a proposed recurrence preserves a fixed valuation exactly three,
   thereby excluding it as a `(3,3,4)` source;
3. search generalized-Fermat signatures such as `(2,3,7)`, `(3,3,4)`, and
   `(3,4,4)` for a source with controlled non-power coefficients;
4. distinguish genuine primitive constructions from common-factor scaling,
   which can create k-full numbers before primitive reduction but lose the
   exponent budget after division by the common gcd.

A route is not retired merely because it is difficult.  It is retired only
when an explicit counterexample or no-go theorem invalidates its defining
mechanism.

## References

- A. Nitaj, *On a Conjecture of Erdős on 3-Powerful Numbers*, Bulletin of the
  London Mathematical Society **27** (1995), 317--318,
  DOI: `10.1112/blms/27.4.317`.
- J.-M. De Koninck and F. Luca, *Analytic Number Theory: Exploring the Anatomy
  of Integers*, AMS, 2012, Chapter 11.
