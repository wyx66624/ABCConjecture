# Ordinary finite proof before the signed-moment arithmetic module

The complete US1--US4 ordinary proof received root and both peer full
reviews before this selected formal scope was prepared. The historical
fourteenth-round next note remains byte-for-byte unchanged. The module
proposed here is SignedMomentArithmetic.lean. Root separately owns the
actual Gram, unit-rotation and signed-product-injectivity core.

## 1. The finite signed-ball count and its numerical consequences

For natural M and nu define the finite natural sum

    ballCount(M,nu)=sum_(j=0)^nu 2^j choose(M,j) choose(nu,j).

Terms j>M vanish, so this equals US7's expression. The combinatorial
interpretation as an actual integer l1 ball belongs to the separately
proved count-product connection; this numeric module will not pretend
that interpretation follows merely by naming the sum.

Expansion and the standard Pascal/binomial identities give

    ballCount(M,2)=2M^2+2M+1,
    3 ballCount(M,3)=4M^3+6M^2+8M+3,
    ballCount(2,nu)=2nu^2+2nu+1.

These include M=0 and nu=0 when applicable. The finite sum is
monotone in M, since each binomial choose(M,j) is monotone.
Thus ballCount(M,2)<=n gives 2M^2<=n, and
ballCount(M,3)<=n gives 4M^3<=3n.
If r>0 and 2r^2>=n, ballCount(M,r)<=n forces M<=1:
M>=2 would give

    n>=ballCount(2,r)=2r^2+2r+1>n.

The actual integer threshold may be

    r=floor(sqrt(floor(n/2)))+1.

It always has r>0 and 2r^2>=n. For n>=18, it also has r^2<=n.
Indeed write s=floor(sqrt(floor(n/2))). Then s>=3,
s^2<=n/2<(s+1)^2, and
(s+1)^2<=2s^2<=n because 2s+1<=s^2. This slightly conservative
natural threshold includes perfect-square half-exponents and proves
the same numerical interfaces needed for the following complete budget.
It is not asserted to equal the real ceiling in every even-square case.

## 2. A single genuine maximum in an actual finite index set

For a finite set s and natural depth function e, a nonempty s has an
index of maximal e. Take its singleton O, or O empty if s is empty.
Then O is a subset of s, |O|=min(1,|s|), and every selected depth
is at least every depth outside O.

If the actual filtered set s_h={i in s:e_i>=h} has at most one
element, it is contained in O. Otherwise an omitted h-deep index
and the selected maximum would be two distinct h-deep indices.
This is a construction from actual depths, not an owner supplied as
an unproved matching hypothesis.

The signed-count consequence in section 1 will prove |s_h|<=1 from
the explicit bound ballCount(|s_h|,r)<=n. The arithmetic construction
of the finite n-torsion target is not hidden inside that input.

## 3. Every positive layer and the full 5/2 budget

Let n,r be natural, r>0, 2r^2>=n and r^2<=n. Let L>=0,w>0, and put

    h=max(4,ceil(2rL/w)).

The already proved actual natural-ceiling inequality gives
(h-4)w<=2rL, including h=4. Suppose the actual cardinalities
M4=|s_4| and Mh=|s_h| satisfy the two signed-count bounds

    ballCount(M4,2)<=n,     ballCount(Mh,r)<=n.

Then 2M4^2<=n and Mh<=1. Choose O as in section 2. Every remaining
depth is below h, and its complete positive excess obeys

    (e_i-3)_+ <= (h-4) 1_(e_i>=4).

Summing all remaining indices and weighting gives

    remaining_cost <= 2r M4 L.

The entire depth of each index is assumed to satisfy e_i*w<=nL,
which is exactly the actual individual-arm cap supplied by US.
Adding back at most one selected index therefore gives

    total_cost <= (2r M4+n)L.

There is a purely polynomial integer proof of the desired constant:

    4r M4 <= r^2+4M4^2 <= 3n,

where the first inequality is (r-2M4)^2>=0. Multiplying the total
cost bound by two yields

    2 total_cost <= 5nL.

This avoids any fractional-power or real-square-root theorem in the
final finite estimate. The proof must preserve natural truncated
subtraction before real casts. The actual finite sums, actual filters
and actual maximum construction are retained in the final signature.

With positive t0 and B, lower bounds t_i>=t0>=nL/2 and nonnegative
individual costs yield the normalized whole-block mean at most 5/B.
If formalized, this normalization will retain those actual per-index
height assumptions. It will not assume a desired averaged bound.

## 4. Complete two-range single-owner remainder

For the same r define h0=max(4,ceil(6L/w)) and
h1=max(h0,ceil(2rL/w)). The two actual ceiling inequalities are

    (h0-4)w<=6L,     (h1-h0)w<=2rL.

If ballCount(|s_(h1)|,r)<=n, the actual maximum contains that deep
filter. Every remaining e<h1 satisfies

    (e-3)_+ <= (h0-4)1_(e>=4)+(h1-h0)1_(e>=h0).

The complete actual finite remaining cost is at most
(6|s_4|+2r|s_(h0)|)L. This can reuse the published fourteen-round
finite summation theorem, whose proof works for any set containing the
deep filter. Only the actual one-index selection is new here.
The further bounds 7 n^(5/6)L and 14 n^(-1/6)/B in US remain
ordinary real fractional-power estimates unless separately proved.

## Explicit separation from the arithmetic inputs

This selected module will not formalize the field units, p-adic
valuations, norm-one n-torsion group, Gram height argument, prime
distribution, density or global signed tail. Root's disjoint finite
core may later connect actual signed products to the numeric count.
Even the complete per-prime finite budget does not bound the number
or total weight of different prime labels. All independent-domain
complements and pointwise exceptions remain unproved.
