# Exact fibres of the labelled odd parts of a primitive abc triple

Author: ChatGPT. Date: 2026-08-31.

This proof note is written before the corresponding Lean module. It
supplies elementary arithmetic proofs of the auxiliary statements needed
to formalize Section 4 of `ANALYTIC_UNIFORM_GATE_2026_08_31.md`.
It does not assume a Galois correspondence, a logarithmic transport, or
the abc conjecture. Such applications require their own hypotheses.

For a natural number n define its actual odd part by

\[
              o(n)=n/2^{v_2(n)},\qquad o(0)=0,
\]

where the implementation uses Mathlib's `ordCompl[2] n`, and hence its
actual natural-number factorization. Let P=(a,b,c) be an `ABCPoint`:
a,b,c are positive, a+b=c, and they are pairwise coprime.

## 1. Elementary facts about the odd part and parity

For every n, o(n) divides n and is at most n. If n is odd, its 2-adic
exponent is zero, so o(n)=n. If n>0 is even, its 2-adic exponent is
positive, so o(n)<n. Equivalently, the last strict inequality follows
from o(n)≤n and the fact that o(n) is not divisible by 2, whereas n is.
The zero case is excluded in this last assertion.

Exactly one of a,b,c is even. Indeed, if a and b were both even, 2
would divide their gcd. If precisely one of a,b is even, c is odd. If
both a,b are odd, c is even. These exhaust the two residue classes
modulo 2. In particular, an even endpoint forces the other two to be
odd. This proof uses positivity only when applying the strict odd-part
inequality, not for the elementary parity alternatives themselves.

The three actual natural-number coordinates determine an ABCPoint:
all its remaining fields are proofs of propositions, and proof
irrelevance identifies those fields when the coordinates agree.

## 2. Uniqueness for a specified even endpoint

Suppose P and Q have identical labelled odd parts, so

\[
 o(a_P)=o(a_Q),\quad o(b_P)=o(b_Q),\quad o(c_P)=o(c_Q).
\]

If both a-coordinates are even, their b- and c-coordinates are odd;
these coordinates therefore equal their prescribed odd parts and
agree. Subtracting b from c gives equality of the a-coordinates.
If both b-coordinates are even, the same argument uses the a- and
c-coordinates. If both c-coordinates are even, it uses the a- and
b-coordinates and then their sum. Thus a specified even endpoint
admits at most one point in a labelled odd-part fibre.

## 3. An even addend cannot coexist with an even sum in a fibre

Write the fixed labelled odd parts as A,B,C. At a point with b even,
a=A and c=C, while B=o(b)<b. Consequently

\[
                         A+B<C.
\]

At a point with c even, a=A and b=B, while C=o(c)<c=a+b. Consequently

\[
                         C<A+B.
\]

These strict inequalities are incompatible. The same argument applies
to an even a-coordinate by exchanging the two addends. Notice that
this rules out coexistence of types within one fixed fibre; it does
not rule out either parity type among all primitive abc triples.

## 4. An injection into a set of two elements

Let F(A,B,C) be the set (or subtype) of all ABCPoints with these three
labelled odd parts. Map it to the two residue classes by a mod 2.
This map is injective. To prove this, let P,Q have the same image.
If their a-coordinates are even, Section 2 applies. Otherwise both
a-coordinates are odd. Each of P,Q then has either b even or c even.
If they have the same even endpoint, Section 2 again applies. If they
have different even endpoints, Section 3 gives a contradiction.

It follows from the explicit injection into `Fin 2` that F(A,B,C) is
finite and that its cardinality is at most two. No finite-support,
height, or size restriction on A,B,C is used. Empty fibres are
included.

## 5. The bound is attained by actual primitive triples

The points

\[
                    P=(4,3,7),\qquad Q=(1,6,7)
\]

are positive, satisfy the sum equation, and have pairwise coprime
coordinates. Their labelled odd parts are both (1,3,7): 4=2^2,
6=2\cdot3, and 1,3,7 are odd. They are distinct because their first
coordinates are different. Section 4 bounds that fibre by two, and
these two distinct members give the opposite bound. Hence

\[
                        \#F(1,3,7)=2.
\]

For a constructive enumeration, send the two values of `Fin 2` to
P and Q. This is injective by their different first coordinates. The
upper cardinality bound then makes it bijective. Alternatively, any
member whose a-coordinate is even equals P by Section 4, and every
remaining member equals Q. This also proves directly that the fibre
is exactly the two displayed points.

## 6. Formalization boundary

The Lean module will prove statements about actual natural-number odd
parts and the repository's unchanged `ABCPoint`. Proof-carrying
definitions of the two sample points and the finite-fibre instance
will be included in the dependency audit, separately from named
theorems. It will not replace the actual odd part by a free label.

The theorem does not establish that a Galois action preserves these
three labels, nor that every point in the fibre occurs in any fixed
Galois orbit. The latter issue distinguishes the strict fixed-Tate
framing from the enlarged coefficient-pair category in the analytic
report. An application must also rule out new primes, or explicitly
assume equality of the full prime support.
