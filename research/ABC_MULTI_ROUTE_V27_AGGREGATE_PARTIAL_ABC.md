# ABC multi-route research note v27: unconditional aggregate-surplus classes

**Author:** ChatGPT  
**Date:** 2026-08-30

The signed large-pair ledger

\[
2h\le\log2+2R+D_2
\]

immediately gives the general transfer

\[
D_2\le\delta R+K
\quad\Longrightarrow\quad
\boxed{
h\le
\left(1+\frac\delta2\right)R+
\frac{K+\log2}{2}.
}
\]

In particular, if

\[
D_2\le0,
\]

then

\[
\boxed{
h\le R+\frac{\log2}{2}.}
\]

This is an unconditional coefficient-one abc estimate for every primitive
triple whose two large endpoints have nonpositive signed multiplicity-two
surplus.

The class strictly extends the cube-free class. Individual primes may occur
to exponent three or higher, provided their positive excess is compensated by
sufficient exponent-one radical mass elsewhere in the two large endpoints.

More generally, any uniformly bounded aggregate surplus is absorbed into the
additive abc constant without epsilon loss.

The Lean module is

```text
Lean/IUTThreeClosures/LargeEndpointAggregatePartialABC.lean
```

with declarations

```lean
ABCPoint.height_le_of_aggregateSurplus_linear_bound
ABCPoint.height_le_conductor_add_log_two_div_two_of_aggregateSurplus_nonpos
ABCPoint.height_le_conductor_add_constant_of_aggregateSurplus_bounded
ABCPoint.height_le_one_add_half_delta
```
