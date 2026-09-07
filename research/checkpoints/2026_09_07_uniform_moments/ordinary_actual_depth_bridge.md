# Finite actual root-index bridge, before implementation

Let I be a finite index type with actual natural depths e_i. Assume roots
a_i in a commutative monoid have the private integer-valued homomorphisms
proved sufficient in ordinary_private_valuation_multisets.md. For each
threshold h, use the actual subtype I_h={i:e_i>=h}. Restrict both the
roots and the private witnesses to this subtype. Distinct subtype indices
have distinct original values, so every off-diagonal witness still
vanishes and every diagonal witness remains nonzero.

For a chosen moment nu suppose a finite commutative target H_h has at
most 3n elements, and equality of the actual mapped products of nu
indices in I_h implies equality of their original products. The proved
private-valuation symmetric-product theorem then gives

    choose(|I_h|+nu-1,nu)<=3n.

In particular at threshold four and moment two,
2 choose(M+1,2)=M(M+1) gives M^2<=6n. For n>324, take the explicit
r=floor(sqrt n)+1. At threshold 2r and moment r, the independently
proved numerical theorem gives |I_(2r)|<=3.

If all e_i<=H, the actual complete excess satisfies term by term

    (e_i-3)_+ <= 2r*1_(e_i>=4)+H*1_(e_i>=2r).

Summing over the actual finite index type counts each index exactly
once; equal depth values do not merge indices. The two indicator sums
are precisely the cardinalities of the two depth subtypes. Since
r^2<=4n and |I_4|^2<=6n, the lower part is at most 10n. The higher
part is at most 3H. Thus

    sum_i(e_i-3)_+ <=10n+3H.

For a nonnegative weight w and H*w<=3nL, multiplication gives

    w*sum_i(e_i-3)_+ <=10nw+9nL.

The already proved normalization, with B,n,s positive, w<=2s and
L<=2s, then gives 38/B after division by Bns. The actual arithmetic
application chooses depths v_q(T_n(i)) and w=log q. This finite bridge
does not supply the arithmetic valuation homomorphisms, modular rigidity,
finite torsion target, height cap or logarithmic comparisons by itself.

The planned module uses genuine depth subtypes and finite sums, with
the two actual symmetric-product interfaces. It removes the stand-alone
binomial-count and high-depth-count premises from the final finite root
statement by deriving them from private witnesses. No list enumeration
or unproved equality between two different root sets is assumed.
