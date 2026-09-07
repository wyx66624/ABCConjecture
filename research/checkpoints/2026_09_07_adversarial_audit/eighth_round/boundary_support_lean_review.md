# Final read-only review of BoundarySupportArithmetic

Date: 2026-09-07. Status: complete signature/proof/scope review PASS.
The reviewed source was not edited by this reviewer.

Source:
`2026_09_07_cm_image/Lean/BoundarySupportArithmetic.lean`, SHA256
`347807a83ae6c6772dc6741f245e22b50b44178bb93966e0f643651a2815d8d1`.

The source was read in full, including all ten theorem statements,
their proofs, the module scope comment and every axiom query. The
actual `second` definition was independently checked in its imported
LocalPowerArithmetic module: it is the Eisenstein norm of
`(a*b, norm(a,b))`, and the imported `second_quartic` expands it to
the quartic F used in the ordinary manuscript. It is not a new
uninterpreted symbol standing for an assumed Diophantine conclusion.

## Statement and proof fidelity

1. `hasse_strict_interval` proves the strict integer interval from
   q>=7 and t^2<=4q. Its nonnegative product establishes the required
   square separation. There is no square-root approximation premise.
2. `small_multiple_zero` uses the two strict interval endpoints and
   actual integer divisibility, handling both signs of the multiple.
3. `even_hasse_excludes_unit_residues` proves the arithmetic
   contradiction between the Hasse interval, an even integer trace,
   and either residue 1 or -1. It does not derive those residues from
   a local elliptic representation inside Lean.
4. `odd_divisor_of_even` uses the explicit congruences modulo two
   and a divisibility witness to prove divisibility by 2p.
5. `even_trace_prime_cutoff` proves p<q for integer inputs. Its
   antecedent `hc` is explicitly the already split disjunction
   `p | q+1-t` or `p | q+1+t`. It does not claim to derive that
   disjunction from primality and divisibility of the product, nor
   does it prove the modular origin of that product divisibility.
   The parity and Hasse conditions are also explicit. This is the
   integer consequence of the ordinary TS cutoff, not the complete
   real bound q>=(sqrt(2p)-1)^2.
6. `second_sum_height_identity` proves the actual quartic identity
   `(a+b)^4-F=a*b*(a^2+a*b+b^2)`.
7. `second_le_sum_fourth` derives its inequality for nonnegative
   integer a,b from actual nonnegative products.
8. `second_le_thirteen_left_fourth` proves F<=13a^4 for 0<=b<=a.
   Its polynomial factor is precisely
   `(a-b)*(12a^3+9a^2*b+4a*b^2+b^3)=13a^4-F`.
9. `second_le_thirteen_height_fourth` handles either ordering via
   the actual symmetry of the quartic and the integer maximum.
10. `pure_power_height_budget` uses natural p,Q with p nonzero,
    the explicit antecedent `hroot : p<Q`, and the actual equation
    `second a b=(Q:Int)^p`. Strict natural power monotonicity and
    the checked coercion to Int give p^p<Q^p; the proved quartic
    height inequality then gives p^p<13(max a b)^4.

The last theorem deliberately allows nonnegative, not necessarily
primitive, coordinates. This stronger arithmetic signature is sound:
the separate ordinary TS/BT theorem supplies the root inequality for
the actual positive primitive pure-power application. `hroot` is an
ordinary parameter, not a custom axiom or a formally derived modular
statement. No analytic logarithm estimate is claimed here.

## Fixed bytes and compiler evidence

The reviewer independently recomputed all four source hashes in
`2026_09_07_cm_image/verification/lean_validation.json`; all matched:

| Module | Declarations | Hash |
| --- | ---: | --- |
| EisensteinDescent | 29 | e5e15c14c4771fcf6bffd1d87bac67d23895cf02f40606188b2059d4cf3c944e |
| LocalPowerArithmetic | 15 | b17af29c82e564816d09ef9d581535f2a110ec1ba5d23dff6ca2490128ce8661 |
| QuarticSupportArithmetic | 11 | 4faafbf700665bd43afa65509ee9c7df0740353328b6bc6b3ac5283c50de6aea |
| BoundarySupportArithmetic | 10 | 347807a83ae6c6772dc6741f245e22b50b44178bb93966e0f643651a2815d8d1 |

The manifest itself had SHA256
`42e64d8b2548da772820f93db37e229819023177af9e6f2420c57011810f75e6`.
Root reported and the manifest records a fresh scoped Lake build
with Lean 4.32.0, commit
`8c9756b28d64dab099da31a4c09229a9e6a2ef35`, for 10 new and 55
dependency declarations. The complete axiom inventory has only
`propext`, `Classical.choice`, and `Quot.sound`. This reviewer checked
the evidence and fixed bytes rather than claiming to have rerun that
build personally. A source scan found no sorry, admit, custom axiom,
or unsafe declaration in the new module.

This is a scoped formal integer-arithmetic result. It is not a full
repository build, a formalization of Tate curves, modularity, Sturm,
the representation-theoretic support implication, or an ABC proof.
