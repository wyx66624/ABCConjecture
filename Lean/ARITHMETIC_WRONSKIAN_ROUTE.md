# Arithmetic Wronskian route: ordinary-derivation obstruction and a surviving
# canonical `p`-derivation

This note records a non-IUT branch of the project.  Its purpose is deliberately
narrow: determine exactly which part of the Mason--Stothers differential
argument survives over the integers, prove the surviving statements before
formalizing them, and identify the first genuinely quantitative missing
estimate.  No form of the abc conjecture, Vojta's conjecture, or Szpiro's
conjecture is used as an input.

## 1. Structural no-go for ordinary derivations

Let `M` be a `Z`-module and let `D : Z -> M` be an additive map satisfying the
Leibniz rule.  First, `D(1) = D(1*1) = 2 D(1)`, hence `D(1)=0`.  Additivity then
gives `D(n)=nD(1)=0` for positive integers, and `D(-n)=-D(n)=0`.  Thus every
ordinary derivation out of `Z` is zero.

The same obstruction persists after passing to `Q`.  A `Z`-relative
derivation on `Q` kills every integer.  If `q=a/b`, with `a,b in Z` and
`b != 0`, then the quotient rule gives

```
D(q) = D(a/b) = b^{-1} D(a) - a b^{-2} D(b) = 0.
```

In particular `Omega_{Z/Z}=0`, `Omega_{Q/Z}=0`, and of course
`Omega_{Q/Q}=0` in the corresponding universal formulation.  A literal
transport of the function-field Wronskian therefore cannot see either prime
support or multiplicity in an integer abc triple.  This rules out only the
ordinary-derivation route; it does not rule out arithmetic differential
operators with a twisted Leibniz law.

## 2. The canonical arithmetic replacement

Fix a rational prime `p`.  Fermat's congruence `n^p = n (mod p)` makes

```
delta_p(n) := (n - n^p) / p
```

an integer for every `n in Z`.  Put

```
C_p(x,y) := (x^p + y^p - (x+y)^p) / p.
```

This is also integral: its numerator is the difference of the three Fermat
numerators for `x`, `y`, and `x+y`.  Direct multiplication by `p`, followed by
cancellation, proves the two exact identities

```
delta_p(x+y) = delta_p(x) + delta_p(y) + C_p(x,y),

delta_p(xy) = x^p delta_p(y) + y^p delta_p(x)
              + p delta_p(x) delta_p(y).
```

The second identity is equivalently

```
delta_p(xy) = x delta_p(y) + y^p delta_p(x),
```

because `x = x^p + p delta_p(x)`.  Hence this operator is not an ordinary
derivation; the correction terms are precisely what avoids the no-go theorem.

For an integer relation `a+b=c` the additive identity specializes without any
loss to

```
delta_p(c) = delta_p(a) + delta_p(b) + C_p(a,b).
```

This is the exact arithmetic analogue of the differentiated relation.  Unlike
the function-field derivative, however, it contains a degree-`p` correction
term.  Any abc application must control that term without assuming the desired
height--radical inequality in another form.

## 3. Explicit failure of radical-only size bounds

The most tempting estimate is that the size of `delta_p(n)` should be bounded
by a function of the squarefree support of `n`.  This is false even for `p=2`.
For `m >= 0`,

```
delta_2(2^(m+1))
  = (2^(m+1) - 2^(2m+2))/2
  = -2^m (2^(m+1)-1),
```

whereas `rad(2^(m+1))=2`.  The absolute values on the left are unbounded.
Consequently there is no bound

```
|delta_2(n)| <= F(rad(n))
```

for any fixed function `F : N -> R`; in particular no fixed polynomial or
fixed-power radical estimate can hold.  Dividing by `n` does not help:
`|delta_2(n)|/n=(n-1)/2` for positive `n`.  Dividing by `n^p` gives a bounded
quantity, but only because the definition already has size `n^p/p`; that
normalization erases the height multiplicity one hoped to detect and supplies
no radical comparison.

This counterexample rejects only estimates that try to control an individual
raw (or linearly normalized) arithmetic derivative by the radical of the same
integer.  It does **not** reject a possible global estimate involving all of
`a`, `b`, `c` and the correction terms, so this branch remains open.

## 4. A surviving non-circular theorem: exact local multiplicity detection

The canonical operator does retain genuine arithmetic information.  If
`p | n`, write `n=pk`.  Then

```
delta_p(pk) = k (1-(pk)^(p-1)).
```

The second factor is congruent to `1 modulo p`.  Euclid's lemma therefore
gives the exact equivalence

```
p | delta_p(n)  <->  p^2 | n       (assuming p | n).
```

More generally the same factorization shows

```
v_p(delta_p(n)) = v_p(n)-1
```

whenever `n != 0` and `p | n`.  The Lean layer initially formalizes the
factorization and the divisibility equivalence; the valuation formula is an
immediate next refinement.  This theorem is not an encoding of abc: it is a
local equality, proved from Fermat congruence and Euclid's lemma, and it says
that `delta_p` detects exactly the multiplicity beyond the first occurrence of
`p`.  Summed over prime divisors, those excess multiplicities account for
`log(|n|/rad(|n|))`.

## 5. First genuine quantitative gap

The local theorem detects the powerful part of each integer, but the abc
problem asks for a *global* restriction forced by `a+b=c`.  The exact relation
in Section 2 couples three local signals to `C_p(a,b)`, whose archimedean size
is normally of order `max(|a|,|b|)^p/p`.  The local congruence information alone
does not yield cancellation of these correction terms across the different
primes dividing `abc`.

Thus the first honest missing theorem on this route is a cross-prime,
archimedean-to-local estimate for the family of normalized corrections
`C_p(a,b)` which is strong enough to turn the exact multiplicity identities
into a height bound, but which is not merely an algebraic restatement of abc.
No such estimate is proved here.  The formal results below establish the
structural no-go, the exact twisted calculus, the explicit radical-only
counterexample, and the first surviving local theorem; they do not prove abc.
