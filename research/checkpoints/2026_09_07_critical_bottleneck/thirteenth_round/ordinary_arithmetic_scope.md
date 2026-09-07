# Ordinary proof before the bounded UM arithmetic formalization

The complete UM1--UM4 proof was independently read in full by root,
adversarial_audit and independent_route, all PASS, before this file
and the planned UniformMomentArithmetic module were created.
The twelfth-round source remains unchanged.

The planned statements retain the actual finite-depth ledger and
explicit interfaces. They do not formalize prime torsion, norm-support
independence, Brun--Titchmarsh, or the analytic membership theorem.

1. For natural r, the exact identity
   6 choose(r+3,3)=(r+1)(r+2)(r+3) follows twice from
   (N+1) choose(N,k)=(k+1) choose(N+1,k+1).
2. If 324<n and n<=r^2, then r>18, whence
   r^3>18r^2>=18n. The identity shows choose(r+3,3)>3n.
   If M>=4, monotonicity and symmetry of choose give
   choose(M+r-1,r)>=choose(r+3,r)=choose(r+3,3).
   Hence the explicit multiset-count bound <=3n forces M<=3.
3. The completely explicit choice r=floor(sqrt n)+1 satisfies
   n<=r^2 and r^2<=4n for every positive n. It is at least the
   required ceiling; using it also covers perfect-square n.
   No primality input is needed for these numeric implications.
4. If r^2<=4n and M^2<=6n, then
   (2rM)^2<=96n^2<100n^2 for n>0, so 2rM<=10n.
5. For a finite list of actual nonnegative integer depths e, all
   bounded by H, and a threshold h>=4, the complete excess sum
   sum(e-3)_+ is at most h times the number with e>=4 plus H
   times the number with e>=h. This is proved term by term;
   no equality of the two support sets is assumed. With h=2r,
   the preceding low-count bound and a high count at most three
   give a sum bound 10n+3H.
6. With a nonnegative real prime weight w and H w<=3nL, this
   yields the full weighted bound 10nw+9nL. The explicit
   inequalities w<=2s, L<=2s, s>0 then imply the normalized
   bound 38/B. These are the interfaces for log q, log(6B+1)
   and log B; their analytic interpretation is not presumed.
7. The additional explicit eligible-prime bound
   2Z/((n-1)ell), with ell,B positive and Z nonnegative,
   converts 38/B per prime to 80Z/(Bn ell) when n>324.

The actual finite multiset-to-image construction is assigned to
root's separate module. The formulas here start from its explicit
cardinality bound and do not duplicate the construction.
