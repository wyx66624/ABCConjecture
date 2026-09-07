# Actual integer radicals and the strict logarithmic residual threshold

Ordinary proof recorded before the corresponding Lean implementation.
This bridge connects the actual finite prime sums to positive integers;
it does not supply the oriented local depth premise or a uniform tail bound.

For any natural C, define D(C) as the product of its actual prime divisors.
The empty product is one, including the chosen total convention at C=0.
Every factor is a positive prime, so D(C)>0. The previously defined
radical(0,C) is the sum of log p over these same primes, because each
prime is greater than zero. The finite product law for logarithms gives

    radical(0,C) = log D(C).

For positive natural V,Vprime and any natural n, positivity of V Vprime
and 7^n and strict monotonicity of log give the equivalence

    log V + log Vprime < n log 7  iff  V Vprime < 7^n.

Indeed the two sides of the logarithmic inequality are log(V Vprime)
and log(7^n). Thus if positive C has every prime divisor at least seven,
and the already proved actual bill D(C)^n divides V Vprime holds, the
strict logarithmic inequality forces C=1 by the integer threshold theorem.
Equality is deliberately excluded: the norm-seven cancellation family
has equality and content seven. For positive n, division of the displayed
inequality by n gives the ordinary normalized residual threshold.

Finally the independently proved global signed bridge has

    signedCost(0,N) = log N - 3 radical(0,N).

Replacing the actual prime sum by log D(N) is an identity. In particular,
its finite height-transfer conclusion

    t - (delta+cost+low)/3 <= radical(0,N)

is exactly a lower bound for log D(N). Its explicit premises remain:
3t-delta <= log N, signedCost(Y,N) <= cost, smallMass(Y,N) <= low.
They have not been proved for all actual orbit inputs by this bridge.
The natural N=0 convention is harmless for these total identities;
arithmetic applications use positive N. No ABC theorem is asserted.
