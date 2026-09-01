# Additional arithmetic proof details for the level-43 formalization

Author: ChatGPT. Date: 2026-08-30.

These proofs precede the corresponding additions to
`Frey43BalancedRealization20260830.lean`. The base notation and all
arithmetic data are those of
`FREY_43_1289_BALANCED_LEGENDRE_REALIZATION_2026_08_30.md`.

Let A=1289(1289^16+428), a=A^2, b=A^2+1, c=2A^2+1 and
N=abc/2. Since A is odd, N is a positive integer. The earlier proof gives

    1289^17 < A < 2*1289^17,
    A^6 < N < 3*A^6,
    3^6 < 1289 < (8/3)^8.

Consequently there are exact integer certificates

    3^1224 < N^2,
    3^1648 * N^2 < 8^1648.

For the first, N^2>A^12>1289^204>3^(6*204).
For the second,

    N^2 < 9*A^12 < 9*2^12*1289^204
        < 9*2^12*(8/3)^1632 < (8/3)^1648.

The last strict inequality follows from
9*2^12=36864<3^12=531441<(8/3)^16. Clearing the positive denominator
3^1648 gives the claimed integer inequality.

The exponential series gives 8/3<exp(1)<3. Raising these inequalities
to the positive integer powers, and using strict monotonicity of the
real logarithm, therefore proves

    1224 < 2*log N < 1648 < 43^2.

This is the actual real logarithm of the explicitly constructed integer,
not a bound on an independently assigned height variable. Identifying
this logarithm with the curve's normalized Tate sum still uses the
separately stated uniformization and semistability theorems.

The generic Frey discriminant identity applies to the curve with
parameters a=A^2 and b=A^2+1. It gives

    Delta = 16*(abc)^2,
    c4 = 16*(3*A^4+3*A^2+1).

These are the invariants of the actual Weierstrass model. Positivity
of abc proves its discriminant is nonzero over Q. Modulo 5, A=1,
so it is the same reduced model as y^2=x(x-1)(x+2); the latter has
exactly four elliptic-curve points including infinity, as already
proved and formalized. Modulo 43, the parameters are 1 and 2 and
the discriminant is nonzero. The polynomial X^2-2X+5 has no root
in F43 because its discriminant -16 is a nonsquare there. A direct
check of its 43 possible arguments is an equivalent finite proof.

The all-prime exponent statement follows without factoring abc.
The actual primorial through 511 has gcd 102 with abc. Hence every
prime q<512 dividing abc is one of 2,3,17; none of their 43rd powers
divides abc, by the exact terminal residues in the previous report.
For q>=512, q^43>=2^387, whereas each endpoint is below 2^377.
Pairwise coprimality implies that a prime power dividing the product
divides one endpoint, which is impossible at this size. Thus

    q^43 does not divide abc for every prime q,
    (abc).factorization(q) < 43 for every prime q.

All uses of the primorial and factorization in the proposed Lean proof
are the standard arithmetic definitions. Increasing the elaborator's
finite exponentiation or recursion threshold for these integer
certificates does not change a theorem or introduce a new axiom.
These finite arithmetic facts are not a proof of the abc conjecture.
