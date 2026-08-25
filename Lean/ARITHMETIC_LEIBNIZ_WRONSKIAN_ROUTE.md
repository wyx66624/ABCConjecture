# Arithmetic Leibniz--Wronskian route

This note develops a non-IUT arithmetic-differential interface.  Every
mathematical assertion below is proved before its Lean counterpart.  No abc,
Szpiro, Vojta, small-vector, or target height estimate is stored as data.

## 1. Powerful parts

For a positive integer `n`, put

```text
rad(n) = product of the distinct prime divisors of n,
pow(n) = n / rad(n).
```

Unique factorization gives the exact identity

```text
rad(n) * pow(n) = n.                                      (1.1)
```

If `m` and `n` are coprime, every divisor of `m` is coprime to every divisor
of `n`; in particular `pow(m)` and `pow(n)` are coprime.  For a primitive
positive triple `a+b=c`, the three powerful parts are therefore pairwise
coprime.  Moreover radical is multiplicative on coprime inputs, so

```text
rad(abc) * pow(a) * pow(b) * pow(c) = abc.                 (1.2)
```

## 2. The exact Wronskian divisibility chain

Let `D_a,D_b,D_c` be integers satisfying

```text
D_a + D_b = D_c,
pow(a) | D_a,   pow(b) | D_b,   pow(c) | D_c.
```

Define

```text
W = a D_b - b D_a.
```

Because `pow(a)` divides both `a` and `D_a`, it divides both terms of `W`.
Likewise `pow(b) | W`.  The two additive relations give the alternative
identity

```text
W = c D_b - b D_c,
```

so `pow(c) | W`.  Pairwise coprimality now gives the exact conclusion

```text
pow(a) pow(b) pow(c) | W.                                 (2.1)
```

If `W != 0`, divisibility implies

```text
pow(a) pow(b) pow(c) <= |W|.
```

Combining this with (1.2) and the triangle inequality yields

```text
abc <= rad(abc) |W|
    <= rad(abc) (a |D_b| + b |D_a|).
```

Cancelling the positive factor `ab` gives the precise real inequality

```text
c <= rad(abc) (|D_a|/a + |D_b|/b).                        (2.2)
```

When `W != 0`, the radical and the total parenthesized mass on the right of
(2.2) are positive (either individual summand may still be zero).  Applying
the monotonicity and product law of the real logarithm gives the corresponding
logarithmic statement.  This is a conditional arithmetic lemma, not abc: it
does not manufacture the `D` values or bound their normalized size.

## 3. Free prime weights

For arbitrary integer weights `x_p`, define

```text
D_x(n) = sum_{p | n} (n/p) v_p(n) x_p.                    (3.1)
```

This is an honest integer.  The logarithmic version

```text
L_x(n) = sum_p v_p(n) x_p / p
```

satisfies `D_x(n)=n L_x(n)` in `Q`.  Since
`v_p(mn)=v_p(m)+v_p(n)`, it follows that

```text
D_x(mn) = m D_x(n) + n D_x(m).                            (3.2)
```

For every prime `p | n`, equation (1.1) and `p | rad(n)` imply

```text
pow(n) | n/p.
```

Thus `pow(n)` divides every summand in (3.1), and hence

```text
pow(n) | D_x(n).                                          (3.3)
```

Consequently the chain in Section 2 applies to `D_x` as soon as the single
linear relation

```text
D_x(a)+D_x(b)=D_x(c)
```

and the nondegeneracy `W_x != 0` are proved for the selected weights.

## 4. Why ordinary Siegel is insufficient

The remaining selection problem is not solved by a generic one-equation
Siegel lemma.  For `H>0`, consider the two integral linear forms on triples

```text
A_H(X,Y,Z) = H X + Y,
B(X,Y,Z)   = X.
```

The kernel of `A_H` contains the short vector `(0,0,1)`, but it is degenerate:
`B(0,0,1)=0`.  If `A_H(X,Y,Z)=0` and `B(X,Y,Z)!=0`, then

```text
Y = -H X,
|Y| = H |X| >= H.
```

Hence every nondegenerate kernel vector has sup norm at least `H`, even though
the kernel contains a vector of norm one.  A theorem producing merely a short
nonzero kernel vector therefore says nothing about Wronskian nondegeneracy.

## 5. First genuine missing estimate

For an abc triple, the compatibility equation for the weights is one explicit
homogeneous linear relation and the Wronskian is a second linear form.  The
exact chain above reduces the route to finding an integral point in the first
kernel but outside the second, with

```text
sum_{p|a} v_p(a)|x_p|/p + sum_{p|b} v_p(b)|x_p|/p
```

small enough uniformly in the varying prime support.  Generic Siegel or
Minkowski existence does not provide this avoidance estimate, as Section 4
shows.  Exploiting the special signed coefficients forced by `a+b=c` is the
first unresolved quantitative problem.  The present route proves the exact
algebraic and analytic consequences of such a vector, but neither assumes nor
constructs it.
