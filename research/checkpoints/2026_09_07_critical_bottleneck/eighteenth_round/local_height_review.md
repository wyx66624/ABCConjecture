# LH1--LH3 full ordinary and primary-source review

2026-09-07. Read the complete independent_route/eighteenth_round/
local_height_value_set.md. Source SHA-256:
05572c7e4740badfe093aad999f719fcbca892bda8a47252feb6173df6cad22a.
Full ordinary mathematical and primary-source review: PASS.

The review concerns the full local curve, rather than a sample of its
residue classes. The two minimal-model transformations have the same
scale u=2. Their normalized local height constants therefore agree and
cancel in J_l. The sign of the change rule follows from the principal
term -2 chi_l(t) and t_F=t_E/u+O(t_E^3). This is consistent with the
global normalization already reviewed in HT.

At three, m=v_3(z)>0 and z=0 are excluded by the nonsquare unit -1.
For m<=0 the second minimal point always has valuations (1,2), and
X=x/3 is 2 modulo 3. The displayed division-polynomial identity gives
C0>=6; the other hypotheses of Cremona's case (c) hold, yielding
-4/3 times log_5(3). The first height is -2m times log_5(3), so the
character term cancels exactly. Both points at infinity are covered by
the constant punctured neighborhoods. Thus the complete value set is
{(4/3) log_5(3)}.

At two, the two negative-valuation cases use the unit leading term of
3x^2+a4. In the unit-z case both minimal x coordinates are even and
their derivative is odd, so both heights vanish. At every prime above
three except five, good reduction and the three z-valuation ranges
give zero. The arguments include the actual projective extensions;
they do not separately substitute the undefined height of the origin
into a singular expression. Nonemptiness follows from (1,8).

Actually opened and read the author-hosted Cremona chapter 3, printed
page 72, Proposition 3.4.1 and its preceding convention. The text
explicitly applies the formula to E/Q_l and points in E(Q_l), and
uses twice Silverman's normalization. Cases (a) and (c), including
the threshold C0>=3B, support exactly the branches used here:
https://johncremona.github.io/book/fulltext/chapter3.pdf .

Also actually opened Balakrishnan--Dogra arXiv:1601.00388, Theorem 1.4
(printed page 6) and the character convention on printed page 35:
https://arxiv.org/pdf/1601.00388 . Omega is the negative sum of the
away-from-five J_l values. Consequently Omega is exactly
{-(4/3) log_5(3)}, with the sign in the proposed five-adic equation
correct. HT's alpha and logarithm transformations cancel as claimed.

No unfinished infinite-prime enumeration remains in this local-value
statement. This review does not claim that the five-adic analytic
equation has been solved, that all its zeros have been certified, or
that the rational sieve or the second square test has been completed.
The z=0 fiber has Q5-points but no rational points, while the rational
infinity points still need explicit treatment in any chart computation.
The text correctly uses direct Theorem 1.4 without assuming (0,3i) is
rational over Q. There is no new compiler, Lean or finite replay claim
in this review.
