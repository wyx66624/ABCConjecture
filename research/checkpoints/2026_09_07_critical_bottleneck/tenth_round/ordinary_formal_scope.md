# Reciprocal-depth integer kernel: exact formal scope

The ordinary RC1--RC4 proof was reviewed completely by root and
adversarial_audit before this formalization. `ReciprocalDepthArithmetic`
imports the frozen actual signed-arm integer module and proves seventeen
new theorems, with all helper declarations included in that count.

`weightedExcessAt h` is an actual recursive function on finite lists of
natural depths and integer weights. Under nonnegative weights, local and
finite theorems prove S-E_h<=hR. For a common denominator d and coefficient
numerator b with b>=0 and b*h=3d, the module proves b(S-E_h)<=3dR.
An unrestricted arm instead has b=0 and keeps its entire radical credit.
The rational interpretation b/d=3/h uses d>0 outside these cleared
integer statements; no real division is defined inside the module.

The positive coefficient function is max(b-d,0), implemented by its
integer case split. Its nonnegativity, domination and uniform bounds are
proved. The coefficient-height theorem is derived from the two explicit
interval bounds for each S, not merely assumed. The finite low-mass
inequality follows from nonnegative L_i and their total bound. The main
canonical three-arm theorem composes these facts and discharges those
coefficient and low-mass interfaces. The cap inequalities remain explicit
antecedents of that general algebra theorem, with proved finite-list
lemmas available to instantiate them.

The last three theorems classify one, two or three finite positive
integer caps in sorted order, after multiplication by their positive
denominators. For three caps the criterion is

    a*b*c <= a*b+a*c+b*c,

and the exact iff has a=1; a=b=2; (a,b)=(2,3) with c<=6;
(a,b,c)=(2,4,4); or (a,b,c)=(3,3,3). With the one- and two-finite-cap
cases this gives the five maximal patterns in the ordinary proof.
Infinity is not encoded as an integer cap; missing finite caps represent
the unrestricted arms in that comparison.

The complete fresh build passed on Lean 4.32.0 with warnings as errors:
seventeen new theorems, seventy-one imported dependency theorems and
complete axiom-query coverage. The only axioms are `propext`,
`Classical.choice`, `Quot.sound`. The final source SHA256 is
`ec42e21085ad65c1a3ffdd939a742a0f5276c728ff4ca8a564b3d79c8d1e934c`.
The inventory and captured output are in `verification/lean_validation.json`
and `verification/fresh-lake-build.log`; `verify_lean.py` builds a fresh
temporary project from the exact source bytes.

This module does not define actual prime factorizations, Real.log or
prime-weighted products. It does not formalize the analytic input, full
RC asymptotics, the FM average theorem, the abstract sharpness family, or
membership of actual roots in any cap class. Root's separate Mathlib
prime/log bridge is independently developed and is not included in this
seventeen-theorem or seventy-one-dependency count.
