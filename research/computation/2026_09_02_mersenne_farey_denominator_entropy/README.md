# Exact checks for Farey denominator entropy

This bundle accompanies
`research/ABC_MERSENNE_FAREY_DENOMINATOR_ENTROPY_2026_09_02.md`.

Run from the repository root:

```powershell
python research/computation/2026_09_02_mersenne_farey_denominator_entropy/verify.py
```

The verifier uses Python's exact `Fraction` arithmetic for every Farey
energy and capacity comparison.  It builds the common index

\[
  m_n=\operatorname{lcm}(1,\ldots,n)
\]

and all reduced pairs `1 <= r < H`, `q <= n/2`.  Hence `q | m_n`, the
integer `1+(m_n/q)r` exists, and all slopes are distinct.  These models omit
primality, exact order, and cube depth on purpose.  They pressure-test the
precise claim that common divisibility plus Farey injectivity alone might
force a little-oh estimate; they are not counterexamples to the actual
Mersenne route.

The same verifier re-reads, rather than recomputes, the frozen exhaustive
scan through `10^9` in `../2026_09_02_mersenne_sigma_one/`.  It checks that
the only base-two Wieferich hits are `1093` and `3511` and that both have
depth exactly two.  This is a finite no-hit statement for the depth-three
packet and is never extrapolated.

`verification_output.json` is the frozen standard output.  `SHA256SUMS`
authenticates the bundle and the two reused inputs.
