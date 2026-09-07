# Independent review of the final actual single-owner bridge

This is a supplemental review artifact created after the eleven-file
critical delivery seal. It does not alter any sealed source or paper.

I read the complete final root source
`2026_09_07_signed_moment_descent/Lean/ActualSingleOwnerBridge.lean`,
including PairRigid, both theorem signatures and all proof terms:
full source and semantic-scope review PASS.

Source SHA-256:
`20520467eda7614a2a3c0ebeba14f7f95892ecffc93c6d2c6ece298337068468`.

PairRigid compares literal two-element arrays of actual group elements
and their finite images, evaluated on the actual signed diamond.
Restricting the private homomorphisms preserves both off-diagonal and
nonzero diagonal conditions, including the orientation of distinctness.
The actual diamond capacity gives the contradiction and proves the
actual finite set has at most one element.

The second theorem applies this result to the actual high-depth filter
and directly invokes the reviewed complete actual_single_owner_budget.
All natural truncated excesses are formed before their real casts.
The entire layer sum, and not just the high filter, satisfies the
resulting 5/2 bound. The lower-layer cardinal-square inequality, finite
target size, private homomorphism construction and actual-product
rigidity remain explicit inputs. No primewise arithmetic construction
or cross-prime summation is silently included.

I independently recalculated all seven source hashes in the current
root validation manifest and matched its complete 96 axiom queries
against the full compiler log: PASS, with only propext,
Classical.choice and Quot.sound. The root manifest records fresh
compilation of 40 new and 56 unchanged dependency theorems. I did not
repeat this compiler execution; my separate author execution remains
the previously recorded 22+27 source run.
