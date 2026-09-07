# Exact modular-space exploration

This is a record of finite exact PARI/GP computations, not a proof of
non-existence of global power seeds. The necessary level list is proved
separately in FM5, using its stated published inputs.

The call is `mfinit([N,2,12],0)`: the integer character parameter 12
denotes the Kronecker character `(12/.)=psi_3`; the final zero requests
the newspace. The official PARI modular-forms documentation was opened
before using `mfeigenbasis`, `mffields`, `mfisCM`, and `mfcoefs`.

| N | Newspace dimension | Galois orbit degrees | CM discriminants reported |
|---:|---:|---|---|
| 36 | 2 | 2 | -4 |
| 72 | 0 | none | none |
| 144 | 2 | 2 | -4 |
| 288 | 4 | 4 | 0 (non-CM) |
| 576 | 8 | 2, 2, 4 | -4, -4, 0 (non-CM) |

Both quartic coefficient fields are represented as `Q[t]/(t^4+1)`.
In the displayed PARI generators, their coefficient at 13 is +4 at
level 288 and -4 at level 576. All conjugates have that same rational
coefficient. The full first 26 coefficients (including the constant term)
are preserved in `modular_spaces_probe_results.txt`.

Independent PARI replay by adversarial_audit agrees with the complete
dimension/orbit/CM table. The record deliberately distinguishes an exact
software computation from full Lean formalization of the modular-form
algorithms. Any use of it to identify a particular curve's eigenform must
first prove that curve's modularity, conductor range and non-CM property;
matching a few coefficients alone is insufficient.

The excluded boundary seed (0,1) has F=1 and gives
`E0: Y^2=X^3+12X^2+6(3+r)X`. Its raw Frobenius traces are recorded in
`boundary_probe_results.txt`. A complete local character calculation in
the adversarial agent's separate note gives twisted trace -4 at both
primes above 13. This points to the level-576 non-CM orbit under the
necessary exact global identification argument. It does not exhibit a
positive pure-power seed or disprove the modular route.
