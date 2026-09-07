# Ordinary proof before adaptive precision and owner formalization

The complete AP1--AP4 and OC1--OC3 ordinary arguments were independently
reviewed by root, adversarial_audit and independent_route, all PASS.
The following bounded finite core is selected for formalization in
Lean/AdaptiveOwnerArithmetic.lean. It will not claim ideal valuations,
finite-ring torsion, sieve, density or global signed membership.

## 1. Cubic and two-owner multiset thresholds

For natural M,n, the identity

    6 choose(M+2,3)=M(M+1)(M+2)

implies M^3<=18n whenever choose(M+2,3)<=3n.
It includes M=0. For a positive natural r with r^2>=6n, the inequality
choose(M+r-1,r)<=3n forces M<=2: if M>=3 its left side is at least
(r+1)(r+2)/2>r^2/2>=3n. These are actual combinatorial consequences,
not assumptions defining the root counts.

## 2. Two maximal indices in a finite set

For a finite index set s and a natural depth function e, choose an
index of maximal e when s is nonempty, and then an index of maximal
e in the remaining set when it is nonempty. Their set O has size
min(2,|s|), and every member has depth at least every remaining depth.
Existence follows by the maximum-image property of a finite nonempty
set, with the empty and singleton cases treated separately.

If at most two members of s have e>=h, then every such member belongs
to O. Otherwise an omitted deep member and the two selected members
would give three distinct members at depth at least h.

## 3. Complete finite cost after removing these indices

Suppose 4<=h0<=h1. For any remaining index with e<h1,

    (e-3)_+ <= (h0-4) 1_(e>=4)
                         +(h1-h0) 1_(e>=h0).

For e<4 it is zero. For 4<=e<h0 the first term bounds it. For
h0<=e<h1 the sum of the right coefficients is h1-4 and e<=h1-1.
Thus a finite sum over s\O is bounded by these two coefficients times
the actual numbers of indices at depths at least 4 and h0.
This pays every positive layer and does not require distinct depths.

With a nonnegative real weight w, conditions

    (h0-4)w<=6L,    (h1-h0)w<=2rL

give the weighted remaining cost at most

    (6 |s_4|+2r |s_(h0)|) L.

If cap is nonnegative and every index has e*w<=cap, adding back the at most two removed
indices costs at most 2cap. The removed indices will be chosen by
their actual depths, not supplied as a hypothetical matching owner set.

## 4. Adaptive ceiling interfaces

For L,w>0 and positive r, put h=max(4,ceil(2rL/w)). Then

    h*w>=2rL,       (h-4)w<=2rL.

The first inequality is the defining ceiling bound. If h=4 the second
is immediate. Otherwise h is the ceiling and its error is less than
one; subtracting four absorbs that error. Analogously, with

    h0=max(4,ceil(6L/w)),
    h1=max(h0,ceil(2rL/w)),

the two inequalities in section 3 hold. This is a statement about
actual integer ceilings, including empty intermediate ranges.

The arithmetic construction of a finite group and the implication from
this real precision bound to actual determinant rigidity remain in
the ordinary proof. A later connection may reuse the previously
formalized private-witness symmetric-count theorem with these explicit
interfaces. No formal claim will turn a supplied depth function into
an automatically constructed p-adic valuation.

The final constants 39 and 78 in OC use elementary fractional powers
of n. The completed twelve-declaration implementation stops at the
exact finite weighted expression above, and the real-power asymptotic
remains ordinary mathematics. It includes the actual maximum selection,
complete finite sum, natural ceilings and composition into the weighted
remaining and total budgets. Its final source received three full source
reviews and passed the fresh 12+15 local-dependency compilation.
