# Primary-source packet: polynomial Lucas factors and Hensel specialization

This packet supports
`research/ABC_PELL_POLYNOMIAL_HENSEL_SPECIALIZATION_2026_09_02.md`.
The two arXiv records were checked on 2026-09-02 and downloaded directly
from arXiv.  The extracted TeX is retained so that hypotheses and
normalizations can be audited without relying on search snippets.

## Imported results and strict scope

1. Graeme Bates, Ryan Jesubalan, Seewoo Lee, Jane Lu, and Hyewon Shim,
   *Powerful Fibonacci polynomials over finite fields*, arXiv:2601.02664v1
   (submitted 2026-01-06).  We use only the displayed Fibonacci/Horadam
   recurrences, the discriminant/square-freeness result in characteristic
   `p` when `p` does not divide the index, and the distinction between a
   powerful polynomial and a powerful integer specialization.  We do not
   import an integer-sequence finiteness theorem from this paper.
2. Joaquim Cera Da Conceicao, *Primitive Divisors of Lucas Sequences in
   Polynomial Rings*, arXiv:2410.04957v2 (revised 2025-03-13).  We use it as
   an independent audit of the polynomial-ring Lucas/primitive-divisor
   setting and of the need to preserve every regularity and nondegeneracy
   hypothesis.  Its polynomial primitive-divisor theorem is not treated as
   an integer-specialization valuation theorem.

The central boundary is literal.  Polynomial square-freeness says that a
root modulo `p` is simple; it does not say that evaluation at a fixed integer
cannot be divisible by `p^2`.  The actual equality `F_7(2)=13^2` is the
full-premise specialization counterexample.

## Files and SHA-256

```text
9dd5999973773fb0e3218505adcd18e5cb23016246fa96ca7f58cb5c0249d587  Bates_et_al_2026_powerful_fibonacci_polynomials.pdf
ef6d5f2cb3f7bca8381c17ef63d02f11d08ab56cf75c228a6a46c3aa63ca101c  Bates_et_al_2026_source.tar
a60f0f9f32b1894ced0d32575dc8840522364d024591533f9e8921b1ec60d478  Cera_da_Conceicao_2025_primitive_divisors_polynomial_rings.pdf
89ac773dece4b4a16c7eda5be7a29549ba575c01dc12a003c1c70898faceb96b  Cera_da_Conceicao_2025_source.tar
563fb981e896de8755774505fbb74414a5dd0f57c93637269dc25af51e1ac548  Cera_source.tex
```

The extracted `Bates_source/` directory is byte-for-byte obtained from the
recorded source tarball.  The source URLs are:

* <https://arxiv.org/abs/2601.02664>
* <https://arxiv.org/abs/2410.04957>

