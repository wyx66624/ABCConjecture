# Exact residue counts and an actual stopping tower

Author: ChatGPT. Date: 2026-09-07.

This ordinary proof is the source for the new scoped Lean module. It does not
assume or prove ABC, the global signed-tail estimate, or the geometric
classification of norm-one groups.

For positive integers d, residues 0<=a<d and N>=0, define

    C(d,a,N)=0                           if N<=a,
    C(d,a,N)=floor((N-1-a)/d)+1          if N>a.

Then the actual integers n with 0<=n<N and n mod d=a are in bijection with
the integers j with 0<=j<C(d,a,N), via n=a+d*j. Uniqueness follows from d>0.
If N<=a both sets are empty. Otherwise write N-1-a=d*q+r, 0<=r<d. The
condition a+d*j<N is exactly j<=q, hence j<q+1=C. This proves the count
without postulating an approximation for it.

The same division identity gives N=a+d*q+r+1 and d*C=d*q+d. Consequently

    d*C <= N+d-1,             N <= d*C+d-1.

Equivalently |C-N/d|<1 as a real inequality. The precise inequalities also
cover d=1 and N=0. Applied to every nonempty shifted depth class, these
proved count bounds supply the per-level errors in the finite signed
discrepancy formula. An empty class contributes exactly zero. Summing H
errors and subtracting three copies of the first-level error gives H+3.
The full real weighted sum and global limits are not claimed as formalized
by the counting module.

For an independent arithmetic realization of a finite stopping tower, use
Eisenstein multiplication (x,y)*(u,v)=(xu-yv,xv+yu+yv), and recursively set

    z_0=(1,5),              z_{n+1}=z_n*(1,50).

Modulo 25 the multiplier is (1,0). Thus z_n=(1,5) modulo 25 for every n.
The boundary P(x,y)=xy(x+y) is consequently 30=5 modulo 25 for every n.
Hence 5 divides P(z_n) and 25 does not divide it, at every n. This is an
actual infinite family with precisely depth one at five; it is not an
abstract tower predicate. The step element has P(1,50)=2550, of exact depth
two at five, so the stopping depth is strictly below the step first depth,
as the ordinary tower classification requires.

The primitive-coordinate and compatible-factor arguments for this example
are proved in the critical-bottleneck note. The companion Lean module
checks the actual recursive multiplication, modular coordinates, exact
boundary depth and exact residue counting. It does not claim to formalize
those separate global factorization facts.
