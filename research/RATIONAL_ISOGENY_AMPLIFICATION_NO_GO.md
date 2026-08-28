# Rational cyclic isogenies are not a polynomial amplifier

By the Mazur--Kenku classification, the degrees of rational cyclic isogenies of
elliptic curves over `Q` belong to one finite set `N_iso`. For each fixed `N`,
the number of cyclic subgroups of order `N` is at most

\[
  \psi(N)=N\prod_{p\mid N}(1+1/p).
\]

Therefore

\[
  M_{\rm iso}=\sum_{N\in N_{\rm iso}}\psi(N)
\]

is an absolute upper bound for the number of rational cyclic subgroup schemes
of any elliptic curve over `Q`.

Consequently an exceptional-set amplification mechanism producing at most one
abc output per rational cyclic subgroup has only `O(1)` outputs per input. Its
amplification exponent is `beta=0`, so it cannot satisfy

\[
  \beta>\gamma+\kappa\alpha
\]

for a positive exceptional-set exponent `alpha` and nonnegative overlap/height
exponents.

This eliminates only rational-isogeny amplification over `Q`. Isogenies over
growing number fields, Galois-orbit norms, and iterated isogeny graphs remain
active only if their descent, radical growth, and overlap are controlled.
