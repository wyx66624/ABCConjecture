# Integer support assembly for PP and EP

Ordinary proofs, stated before the Lean implementation. The divisor and
mass premises below are explicit interfaces to the separately reviewed
ordinary support allocation; they do not assert that allocation in Lean.

1. If n is an odd integer, n divides q-1, and a positive integer d divides
both n and q+1, then d=1. Transitivity gives d|(q-1), so subtraction
gives d|2. Thus 1<=d<=2. The option d=2 would make n even.
This needs no prime-power premise, and applies to EP's inert rank.

2. For every pair of integers x,y, writing R=x^2+xy+y^2,
4R-3x^2=(x+2y)^2 and 4R-3(x+y)^2=(x-y)^2. Hence either relevant
actual input arm ell=x or ell=x+y obeys 3ell^2<=4R. If a positive
integer J divides the nonzero ell, then J^2<=ell^2, so 3J^2<=4R.
The sum-arm identity already occurs in EisensteinDescent; reuse it.
The first-arm identity and both inequalities complete the required
actual arm bounds. Divisor allocation remains an ordinary interface.

3. If R>=0, 9B^2<=4U and 3J^2<=4R, then
27(BJ)^2<=16UR. Indeed multiply the first inequality by 3J^2>=0
and the second by 4U>=0; the first premise implies U>=0.
Taking U=K*R^e gives 27(BJ)^2<=16K*R^(e+1), for K>=0.
This contains PP with K=1,e=2m and EP with K=kappa,e=2(n-phi).

4. The final EP support-existence step has an entirely integer form.
Suppose R>=1, K>0, N>0, K<=N, 9N<=4R^2, rho>=2, and
16K*G^2>27R^rho. Then G^2>1. Since R^rho>=R^2, the contrary
G^2<=1 would give 16K>27R^2>=243N/4>=243K/4, impossible.
No prime factorization, real logarithm, or correspondence between G
and an actual progression part is built into this arithmetic interface.
