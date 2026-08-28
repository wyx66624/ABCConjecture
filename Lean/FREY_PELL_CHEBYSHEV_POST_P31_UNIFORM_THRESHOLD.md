# Post-prime-31 uniform threshold: the exact `4/37` residual

## Result and scope

The accepted Stoll--Coleman certificate at prime index `31` moves the
unresolved prime-index family from primes `p>=31` to primes `p>=37`.  This
strictly strengthens the elementary fundamental-unit size obstruction.

For a hypothetical remaining four-consecutive residual, retain the notation

```text
D=3*A*B,       Z=b^2+3*b+1=T_p(T),
A=22 (mod 24), B=23 (mod 24), p>=37 prime.
```

The kernel-checked generic inequality now gives

```text
(3*A*B+1)^37 <= Z^2 < (b+2)^4.                 (1)
```

Consequently a pointwise estimate just beyond

```text
A*B of size b^(4/37)
```

would close every remaining prime index after a finite calculation.  This is
weaker than the former `4/31` target, but no accepted unconditional theorem
currently supplies it.  This note improves the residual; it does not prove
that estimate, the uniform prime-index exclusion, or `abc`.

## Exact derivation

The norm-one coordinate gives

```text
D+1 <= T^2.
```

For `T>=1`, Chebyshev convexity gives `T^p<=T_p(T)=Z`.  Raising the first
inequality to the `p`-th power and then using `37<=p` yields

```text
(D+1)^37 <= (D+1)^p <= T^(2*p) <= Z^2.
```

Substituting `D=3*A*B` proves the first half of (1).  The identity
`Z=b^2+3*b+1` gives `Z<(b+2)^2`, hence the strict second half.

The residue classes of the actual branch force

```text
A*B >= 22*23 = 506,       3*A*B+1 >= 1519.
```

An exact integer comparison is

```text
1519^37 >
  260000000000000000000000000000^4.
```

Combining it with (1) gives the unconditional height floor

```text
b+2 > 260000000000000000000000000000.
```

This removes a still larger finite initial segment than the historical
exponent-31 floor.  It is only a necessary condition.

## Formal companion and trust boundary

`IUTThreeClosures/FreyPellChebyshevPrimeIndexLocalPermutationBarrier.lean`
now contains:

- `pellPrimeLocal_thirtySevenThreshold`;
- `pellPrimeLocal_fourThirtySevenParityThreshold`;
- `pellPrimeLocal_strictParityBoundThirtySeven_excludes`; and
- `pellPrimeLocal_activeHeightFloorAfterThirtyOne`.

The Lean proofs use the already formalized generic natural-number power
inequality, exact residue-product floor, and exact integer normalization.
They do not formalize Stoll, Coleman, the accepted external prime-31
rational-point certificate, Chebyshev convexity, or the derivation of the
four-consecutive residual.  Those inputs remain separately and explicitly
tracked.  No axiom, `sorry`, conjectural squarefree-kernel estimate, GRH,
BSD, Szpiro, or `abc` is introduced.

The fixed-modulus and bare moving-prime barriers from the earlier audit are
unchanged.  In particular, known recurrence-support estimates remain
index-subexponential and control prime support rather than valuation parity;
after conversion along the Pell orbit they still give only `b^(o(1))`, below
the required `b^(4/37)` power scale.
