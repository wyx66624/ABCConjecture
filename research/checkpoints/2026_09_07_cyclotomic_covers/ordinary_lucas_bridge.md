# Ordinary proof of the general actual Lucas bridge

Let O=Z[zeta], zeta^2-zeta+1=0, N its norm, and P(a+b*zeta)=ab(a+b).
For arbitrary w=a+b*zeta define

    tau(w)=2a^3+3a^2b-3ab^2-2b^3,   R(w)=N(w)^3.

The exact identities are w^3+bar(w)^3=tau(w) and
w^3-bar(w)^3=3*sqrt(-3)*P(w). Thus eta=w^3 satisfies
eta^2-tau(w)*eta+R(w)=0. Multiply this by z^3 for any z in O, subtract
its conjugate, and divide by the nonzero constant 3*sqrt(-3). This gives

    P(w^2 z)+R(w)P(z)=tau(w)P(wz).

No primitivity, nonzero boundary, positive coordinates, or nonzero norm is
needed. The same calculation gives tau(w)^2+27P(w)^2=4N(w)^3.

For arbitrary integers t,r define U_0=0, U_1=1,
U_{n+2}=t U_{n+1}-r U_n. Any sequence satisfying the same recurrence obeys

    f(n+1)=U_{n+1}f(1)-r U_n f(0).

The formula follows for n=0 and n=1 from the initial values and recurrence;
the recurrence carries two consecutive instances to the next one. Apply
it to f(n)=P(w^n z), t=tau(w), r=R(w). In particular, with z=1,

    P(w^n)=P(w)U_n(tau(w),N(w)^3),  and P(w) divides P(w^n)

for every natural n, including n=0 and the degenerate case P(w)=0.
The norm is N(w^n)=N(w)^n by induction and norm multiplicativity.

The critical-bottleneck agent independently reviewed this complete ordinary
proof before formalization. These exact actual polynomial and recurrence
identities are useful input to the cyclotomic packet construction. They do
not, by themselves, formalize all cyclotomic factors, their prime ranks,
the totient budget, or the signed saving condition, and they prove no ABC
statement. The subsequent Lean signature and axiom review records that scope.
