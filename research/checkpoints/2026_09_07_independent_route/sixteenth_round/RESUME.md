# Bounded resumption entry: independent geometry

The parent reported the active goal paused. The current bounded work is
saved here; no further iterative computation is running. The fifteenth GD
publication, its fifteen-theorem fresh build and three-page visual review
are complete and remain frozen.

Completed sixteenth ordinary result: read rational_simple_quotients.md.
QS1--QS4 proves the actual Q-order-three conic quotients, even rational
Jacobian ranks, Q-simplicity of the remaining J2 and J3 and their mutual
non-isogeny, zero rational torsion and rank at least two for each. The
full genus-six Jacobian rank is therefore at least six. These are ordinary
results supported by complete small finite tables and three full reviews,
not rank upper bounds or complete rational-point calculations.

The exact replay is:

    python replay_rational_simple_quotients.py --check

Its only dependencies are Python's standard library. Source and canonical
certificate are in this directory. Review evidence is in REVIEW.md.

Next bounded proof review: finish the two-peer review of
quadratic_chabauty_entry.md, QH1--QH3. The most economical new entry is H1:
its already proved rank is two and its rational Picard rank is at least
three, so the source criterion makes H1(Q5)_2 finite without any new rank
upper bound. The finite degree-two preimage in D(Q5) contains D(Q).
This is an existence statement for a finite p-adic container; its elements
have not been computed. It does not identify D(Q5)_2 with that container.

A separate conditional route works on D itself: rho_Q(J_D)>=5 and an
upper bound rank J2+rank J3<=6 would ensure the source criterion. That
upper bound is not proved; total rank could still exceed eight.

Only after reviewing these statements, choose a bounded next calculation:
exact p-adic heights/integrals on H1 with certified precision and local
height values, plus an actual rational-point/Mordell--Weil sieve; or an
independent certified upper-rank descent on J2/J3. The known point (-2,1)
is not proved to generate all of E(Q), so an implementation must not treat
its multiples as a complete group or point set. Avoid installing a broad
computer-algebra system without a concrete required method.

Keep the original unresolved positive source constraints and both unit
classes. Neither QS nor QH supplies an ABC proof, a positive seed, a
complete D(Q) list, or a uniform result as exponents/residuals vary.
