#!/usr/bin/env python3
"""Exact standalone replay of a repeated label supported only by singleton classes."""

from __future__ import annotations

import json
from itertools import product
from math import gcd


def factor(n: int) -> dict[int, int]:
    out: dict[int, int] = {}
    p = 2
    while p * p <= n:
        while n % p == 0:
            out[p] = out.get(p, 0) + 1
            n //= p
        p = 3 if p == 2 else p + 2
    if n > 1:
        out[n] = out.get(n, 0) + 1
    return out


def radical(n: int) -> int:
    out = 1
    for p in factor(n): out *= p
    return out


def powerful_kernel(n: int) -> int:
    out = 1
    for p, e in factor(n).items():
        if e >= 2: out *= p**e
    return out


def divisors(n: int) -> list[int]:
    out = [1]
    for p, e in factor(n).items():
        old = out[:]
        power = 1
        for _ in range(e):
            power *= p
            out += [d * power for d in old]
    return sorted(out)


def totient(n: int) -> int:
    out = n
    for p in factor(n): out -= out // p
    return out


def arms(B: int, C: int, R: int, point: tuple[int, int]) -> tuple[int, int, int]:
    h, k = point
    return (1 + R*h, 1 + R*(h + C*k), 1 + R*(h + B*k))


def large_tail(kernel: tuple[int, int, int], threshold: int):
    rows = []
    for lab in product(*(divisors(k) for k in kernel)):
        if lab[0] * lab[1] * lab[2] > threshold:
            weight = totient(lab[0]) * totient(lab[1]) * totient(lab[2])
            rows.append((lab, weight))
    return rows


def main() -> None:
    B, C = 3, 4
    R = radical(B*C)
    M = C**6 // (4*R)
    N = M-1
    common = (1, 17**2, 11**2)
    kappa1 = common
    kappa2 = (1, 17**2, 5**2 * 11**2)
    assert (R, M, N) == (6, 170, 169)
    assert common[0]*common[1]*common[2] == 34_969 > N**2 == 28_561

    admissible = 0
    fibre = []
    for h,k in product(range(1,M+1),repeat=2):
        vals=arms(B,C,R,(h,k))
        if gcd(vals[0],k)!=1: continue
        assert all(gcd(vals[i],vals[j])==1 for i,j in ((0,1),(0,2),(1,2)))
        admissible += 1
        if all(v%d==0 for v,d in zip(vals,common)):
            fibre.append((h,k))
    assert admissible == 26_399
    assert fibre == [(37,75),(138,122)]

    arm_rows=[arms(B,C,R,p) for p in fibre]
    factorizations=[[sorted(factor(v).items()) for v in row] for row in arm_rows]
    kernels=[tuple(powerful_kernel(v) for v in row) for row in arm_rows]
    assert kernels == [kappa1,kappa2]
    assert kappa1 != kappa2
    # Any point in either exact kernel class is in the common-label fibre;
    # the fibre has two points and their kernels differ, so both classes are singleton.
    multiplicities=[1,1]

    dx=fibre[1][0]-fibre[0][0];dy=fibre[1][1]-fibre[0][1]
    g=gcd(abs(dx),abs(dy));s,t=dx//g,dy//g
    coeff=(s,s+C*t,s+B*t)
    assert (s,t,g)==(101,47,1) and coeff==(101,289,242) and all(coeff)
    L=max(abs(s),abs(t));H=1
    assert H*L<=N
    captures=tuple(gcd(d,abs(a)) for d,a in zip(common,coeff))
    capture=captures[0]*captures[1]*captures[2]
    reduced=tuple(d/q for d,q in zip(common,captures))
    assert captures==common and capture==34_969 and reduced==(1,1,1)
    period=1
    assert N*L==17_069<capture

    tails=[large_tail(k,N**2) for k in (kappa1,kappa2)]
    expected1=[(common,29_920)]
    expected2=[
        ((1,17,3025),35_200),
        (common,29_920),
        ((1,289,275),54_400),
        ((1,289,605),119_680),
        ((1,289,3025),598_400),
    ]
    assert tails[0]==expected1 and tails[1]==expected2
    Ltails=[sum(w for _,w in tail) for tail in tails]
    assert Ltails==[29_920,837_600]

    union={}
    support_count={}
    for tail in tails:
        for lab,w in tail:
            assert union.setdefault(lab,w)==w
            support_count[lab]=support_count.get(lab,0)+1
    occupancies={lab: support_count[lab] for lab in union}  # both class sizes are one
    assert occupancies[common]==2
    assert all(n==1 for lab,n in occupancies.items() if lab!=common)

    W=sum(union.values())
    W1=sum(union[lab] for lab,n in occupancies.items() if n==1)
    Wrep=W-W1
    I=sum(union[lab]*n for lab,n in occupancies.items())
    E=sum(union[lab]*n**3 for lab,n in occupancies.items())
    Esh=sum(union[lab]*(n-1)**3 for lab,n in occupancies.items())
    J=I-W
    S=totient(common[0])*totient(common[1])*totient(common[2])//period**2
    assert (W,W1,Wrep,I,E,Esh,J,S)==(
        837_600,807_680,29_920,867_520,1_047_040,29_920,29_920,29_920
    )
    assert I == sum(m*tail for m,tail in zip(multiplicities,Ltails))
    assert E == W+7*Esh == I+6*Esh == W1+8*Esh

    multi_class_mass=sum(k[0]*k[1]*k[2] for k,m in zip((kappa1,kappa2),multiplicities) if m>=2)
    multi_class_tail=sum(tail for tail,m in zip(Ltails,multiplicities) if m>=2)
    false_claims={
        "S_le_sum_D_over_classes_with_m_ge_2": S<=multi_class_mass,
        "S_le_sum_L_over_classes_with_m_ge_2": S<=multi_class_tail,
        "J_le_sum_D_times_m_minus_1": J<=sum((m-1)*k[0]*k[1]*k[2] for k,m in zip((kappa1,kappa2),multiplicities)),
        "repeated_label_requires_a_class_with_m_ge_2": any(m>=2 for m in multiplicities),
    }
    assert not any(false_claims.values())

    result={
        "parameters":{"B":B,"C":C,"R":R,"M":M,"N":N,"N_squared":N**2},
        "full_box_admissible_points":admissible,
        "common_label":common,"common_product":capture,
        "fibre_points":fibre,"arms":arm_rows,"arm_factorizations":factorizations,
        "kernel_classes":[kappa1,kappa2],"class_multiplicities":multiplicities,
        "primitive_direction":[s,t],"direction_coefficients":coeff,"L":L,"H":H,
        "capture_factors":captures,"capture":capture,"period":period,
        "class_large_catalogues":tails,"class_tails_L":Ltails,
        "union_labels":[{"label":lab,"weight":union[lab],"occupancy":occupancies[lab]} for lab in sorted(union)],
        "W":W,"W_singleton":W1,"W_repeated":Wrep,"I":I,"J":J,"E":E,"E_shifted":Esh,
        "S_non":S,"sum_D_m_ge_2":multi_class_mass,"sum_L_m_ge_2":multi_class_tail,
        "false_claims":false_claims,
    }
    print(json.dumps(result,indent=2))
    print("PASS: canonical M=170 cross-singleton repeated-label witness")


if __name__=="__main__": main()
