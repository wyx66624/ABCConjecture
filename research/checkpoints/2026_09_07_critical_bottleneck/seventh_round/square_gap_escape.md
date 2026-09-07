# Elementary square gaps at an axis and at the diagonal

Status: ordinary proof, 2026-09-07. All of SG1--SG3, including the
residue-sensitive strengthening and divisor classification, passed
independent final review by adversarial_audit. The exact replay also
passed its independent read-only re-execution. Earlier rounds remain
unchanged.

Write F(a,b)=a^4+3a^3b+5a^2b^2+3ab^3+b^4. All seed variables a,b
are positive coprime integers. These results control actual even-power
profiles in two residual square classes. They are not obstructions to
all power profiles, and no prime-distribution or transcendence theorem
is needed.

## SG1. A residue-sensitive axis gap for square norms

If F(a,b)=q^2 for an integer q>0, put

    S=8a^2+12ab+11b^2,
    r=the unique integer in {1,...,8} congruent to S modulo 8.

Then

    2 r a < 9 b^3.                                         (SG1)

For a primitive pair r belongs to {3,4,7,8}. Consequently

    max(a,b) < (3/2) min(a,b)^3.                            (SG2)

Proof. Exact expansion gives

    S^2-64F(a,b)=72ab^3+57b^4=:D>0.                        (SG3)

Thus 8q<S. Because 8q is a multiple of eight, 8q<=S-r. Squaring
these nonnegative integers proves D>=r(2S-r). Suppose instead that
2ra>=9b^3. Then 72ab^3<=16ra^2 and 24rab>=108b^4. Hence

    r(2S-r)-D
      =16ra^2-72ab^3+24rab+22rb^2-r^2-57b^4
      >=51b^4+22rb^2-r^2>0,

since b>=1 and 1<=r<=8. This contradicts the preceding square gap.
If b is odd, S is congruent to 4a+3 modulo eight, giving r=3 or 7.
If b is even, primitivity makes a odd; then r=4 or 8 according as
b is twice an odd integer or is divisible by four. Therefore r>=3,
so (SG1) gives 2a<3b^3. Apply the same argument after interchanging
a and b to obtain (SG2).

In particular no positive primitive pair with min(a,b)=1 has square
F. By symmetry take b=1. The bound gives a=1, but F(1,1)=13 is not
a square.

For fixed b this is an explicit finite search bound on a and q, with
no appeal to an ineffective finiteness theorem. For actual profiles
F=VQ^g with g even and V a square, it applies to q=sqrt(V)Q^(g/2).
It places no such restriction on arbitrary nonsquare V or odd g.

## SG2. A diagonal gap in residual square class thirteen

Suppose F(a,b)=13q^2, q>0. Put c=a-b and

    A=7a^2+12ab+7b^2=26ab+7c^2.

If c=0, the only primitive seed is (1,1), with q=1. Otherwise

    52ab+14c^2+1 <= 3c^4.                                 (SG4)

Proof. The exact complementary identity is

    52F(a,b)=A^2+3c^4.                                    (SG5)

Thus (26q)^2-A^2=3c^4>0. The two positive integers 26q and A differ
by at least one. Their difference of squares is at least 2A+1.
Substitute the expression for A to get (SG4).

It follows that |a-b|>=(52ab/3)^(1/4) for every such non-diagonal
seed. The already proved primitive depth-one theorem at thirteen also
gives 13|(a-b) and 13 not dividing q; these extra conclusions are not
needed for the gap proof. For an actual even-exponent profile whose
residual square class is thirteen, absorb its square factor into q
and apply this result.

## SG3. An explicit divisor parametrization on each diagonal slice

For a fixed nonzero integer c, every positive integer solution of
F(b+c,b)=13q^2 is obtained by the following finite exact procedure.
No primitive restriction is needed for its completeness.

Choose positive divisor pairs d1<d2 with d1*d2=3c^4. Retain those
for which

    q=(d1+d2)/52 is a positive integer,
    A=(d2-d1)/2 is an integer,
    u=(A-7c^2)/26 is a positive integer.

Retain only those for which c^2+4u=h^2 with h a positive integer,
h>|c|, and h-c even. Set b=(h-c)/2 and a=(h+c)/2; impose gcd(a,b)=1
if primitive seeds are wanted. Each retained choice is an actual
solution, and every solution occurs.

Indeed a solution gives d1=26q-A and d2=26q+A. Conversely these
tests give a-b=c, ab=u and A=26ab+7c^2. The divisor product then
gives (26q)^2-A^2=3c^4. Identity (SG5) proves F=13q^2. The positive
sum h=a+b is uniquely determined. Thus this is a finite divisor
classification, not only a height estimate.

## Relation to the open problem

SG1 gives an explicit exclusion of highly imbalanced axes in the
actual square-norm class, including all pure even powers. SG2 gives
an explicit exclusion of a thin diagonal region in the different
residual square class thirteen, apart from its exact boundary seed.
SG3 makes every fixed nonzero diagonal slice in that class decidable
by a finite divisor computation. The preceding AS theorem applies
much more generally using an external effective theorem; these SG
subclasses have elementary bounds and identities instead.

The existence of infinitely many actual positive square second norms
established earlier is compatible with SG1. None of these arguments
controls odd prime exponents, arbitrary moving residual square classes,
the private first depth of a top-rank cyclotomic packet, or the full
signed W tail. Those routes and questions remain open.
