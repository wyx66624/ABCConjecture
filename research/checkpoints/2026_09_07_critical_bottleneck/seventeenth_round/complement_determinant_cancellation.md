# CD1--CD3. Exact cancellation in the full-product/complement construction

Complete ordinary candidate, 2026-09-07, prepared before formalization.
This is an exact arithmetic audit of a specific proposed use of collective
content. It does not rule out the cross-prime programme or another map.

Work in O=Z[zeta], zeta^2-zeta+1=0. For Z=(a,b), use
N(Z)=a^2+ab+b^2, R(Z)=(-b,a+b), and det((a,b),(c,d))=ad-bc.
Let W=(a,b) be primitive, gcd(|a|,|b|)=1, and let V be any nonzero
Eisenstein integer. Put

    c=cont(VW)>0, d=cont(V)>0,
    U=VW/c, V0=V/d,
    x=det(U,V0), D=det(U,R(V0)), y=det(U,R^2(V0)).

All these coordinates are actual integers. The two normalized input pairs
U,V0 are primitive. W cannot be zero, so VW is nonzero and c is defined.

## CD1. The common integer factor is exact

There is a positive integer r with

    N(V)=c d r,
    (x,D,y)=r(-b,a,a+b).                              (CD1)

Consequently

    gcd(|x|,|D|,|y|)=r.                               (CD2)

Proof. Multiplication by V is a Z-linear map of determinant N(V), and
commutes with R. Alternatively its matrix is

    [[v0,-v1],[v1,v0+v1]]

for V=v0+v1 zeta. Applying this determinant identity to W and 1,zeta,zeta^2
and clearing the positive c,d gives

    cd x=-b N(V),   cd D=a N(V),   cd y=(a+b)N(V).      (CD3)

Choose integers u,v with ua+vb=1. Then

    N(V)=cd(uD-vx).

Thus cd divides N(V); let r=N(V)/(cd), which is a positive integer because
N(V)>0. Cancel cd in (CD3) to obtain (CD1). The gcd in (CD2) is r because
gcd(a,b,a+b)=1. The proof includes zero individual coordinates of W;
only primitivity and nonzeroness of V are used. QED.

The Bezout proof is important: the common scalar cannot simply be called
an integer because the determinants are integers separately. Primitivity
of W supplies the exact missing denominator cancellation.

## CD2. Primitive phase boundaries recover the original source

Assume also ab(a+b)!=0. After dividing the three phase determinants by
their full common content r, the additive relation x+y=D is precisely

    -b+(a+b)=a.

The absolute primitive boundary product, radical and signed prime-depth
ledger are exactly those of W:

    |(x/r)(D/r)(y/r)|=|ab(a+b)|,
    rad(|(x/r)(D/r)(y/r)|)=rad(|ab(a+b)|),              (CD4)
    sum_(q|primitive product)(v_q-3)log q
        =sum_(q|ab(a+b))(v_q(ab(a+b))-3)log q.        (CD5)

These are equalities, not inequalities with a neglected content term.
They follow immediately from (CD1), including permutations and signs.
Before normalization the determinant product is -r^3 ab(a+b), and the
triple is not primitive if r>1. Applying a primitive-ABC or primitive
radical assertion to that unnormalized triple would be invalid.

## CD3. Application to every actual nonrectangular owner

In the reviewed US block, fix any finite set J of actual root indices and
any k in J. Let W=w_k^n and V=product_(l in J,l!=k) w_l^n. The empty
complement is 1. Primitive unramified powers make W primitive and every
factor nonzero. Therefore (CD1)--(CD5) hold for every k simultaneously.

This construction uses a full product and a different complement for
each owner, so it does retain nonrectangular boundary labels. Nevertheless
its primitive three-phase output for each owner is exactly that owner's
original additive triple. A collective decrease of the coefficient norm
of U, such as CC3, does not by itself improve (CD4) or (CD5).

The result audits only this specific multiplication/complement map. It
does not say that no other aggregate, mixed determinant, divided difference
or simultaneous height constraint can use collective content. The actual
unbounded signed tail, non-independent and exceptional roots, and global
ABC coverage remain open. The useful next construction must differ from
these common-multiplier determinants or exploit additional relations
between their primitive outputs rather than count their cancelled factors
as new radical credit.

Possible bounded formal core after ordinary review: the literal product
matrix determinant identity, the three cleared equalities, actual Int.gcd
Bezout divisibility cd|N(V), and the resulting exact primitive determinant
triple. None requires p-adic torsion, PNT, asymptotics or the ABC conjecture.
