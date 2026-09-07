# Ordinary proof before the cubic local arithmetic formalization

The complete CL1--CL3 ordinary proof was reviewed by root,
critical_bottleneck and adversarial_audit, all PASS, before compiling
the local arithmetic module. All new files belong to round thirteen.

`Lean/CubicUnitLocalArithmetic.lean` contains six proved statements:

1. The exact identity for C(T+3K,T) used in the local argument.
2. Reduction of the actual binary sextic modulo any integer modulus.
3. The complete Fin 27 table: a square value modulo 27 forces both
   projective coordinates to be zero modulo 3. It uses kernel decide
   and has no axiom dependencies.
4. Transfer of that finite table to every integer triple by actual
   integer remainders, including negative coordinates.
5. An actual integer square equation forces 3 to divide both axes.
6. For every integer pair with Int.gcd equal to one, the sextic cannot
   equal an integer square.

The finite table is an arithmetic certificate of the local gate.
The independent Python replay also checks all 648 coordinate pairs
primitive modulo 3 in the complete mod-27 square table. The Lean
proof does not depend on that Python certificate.

The source imports only Std and was actually compiled with Lean 4.32.0.
All six axiom queries completed; dependencies were either empty or
subsets of propext, Classical.choice and Quot.sound. Q_3, the weighted
projective curve, its rational points, and the morphism for all odd
multiples of three remain ordinary mathematics, not formal claims of
this module.
