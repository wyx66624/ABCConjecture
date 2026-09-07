# Independent review of the all-index sieved root window

Date: 2026-09-07. Read all AW1--AW2 and the scope paragraph in
critical_bottleneck's `eighth_round/all_index_sieved_window.md`.
Full ordinary proof review PASS.

The positive logarithmic Euler-product difference is bounded term by
term using 1-exp(-u)<=u. Its inner sum is exactly log(p)/(p-1),
with no additional harmonic or prime-counting factor. Partial summation
from two and theta(t)<=3t give the stated loose bound 6+6log(x).
For s=1+1/log(x), x>=2, the logarithmic correction is at most
6+6/log(2)<15; the finite s-Euler product is at most zeta(s), and
integral comparison gives zeta(s)<=1+log(x).

For x=log(n)>=2 the count of distinct prime factors exceeding x is
at most x/log(x). Their logarithmic factors are individually at most
1/(x-1); both factors of x/((x-1)log(x)) decrease for x>=2, so
the total is at most 2/log(2)<3. Therefore the claimed absolute
exp(18)(1+log(log(n))) bound on sigma(n)/n holds for all n>=8.
The source explicitly treats this as an elementary standard estimate,
not a new sharp maximal-order theorem.

Substituting B=n^4 and
Z=floor(B sqrt(log(n))/(1+log(log(n)))) into the previously proved
actual root-interval inequality cancels this extra divisor-sum factor.
The logarithmic denominator is asymptotic to 3log(n), so the mean is
O(log(n)^(-1/2)) for all sufficiently large integer indices, without
a subsequence hypothesis. Both the other terms and the positive-floor
error are harmless on that domain. Markov's inequality applies only
to the nonnegative positive-depth cost and gives the claimed
O(log(n)^(-1/4)) exception proportion.

The endpoint divided by B tends to infinity; however it remains a
specified finite endpoint. No bound for larger primes or a chosen
exceptional root is obtained, and the proof does not substitute a
reference measure for the distribution of actual roots. The previous
larger window on bounded-divisor-sum subclasses remains valid.

The complete `paper/all_index_sieved_window.tex` was subsequently read.
Final transcription PASS: every Euler-product constant and domain is
preserved, the normalized mean explicitly places division by t_k inside
the sum, and the all-index, finite-endpoint and exceptional-root scopes
match the ordinary proof. No correction was requested.
