#!/usr/bin/env sage
"""Exact balanced rational-prime ranges for the p31 80M factor base."""

from sage.all import ZZ, prime_range


BOUND = ZZ(80_000_000)
EXPECTED = ZZ(4_668_356)
SHARDS = ZZ(16)


def order_mod_31(q):
    residue = int(q % 31)
    value = residue
    order = 1
    while value != 1:
        value = (value * residue) % 31
        order += 1
    return order


def ideal_count(q):
    q = ZZ(q)
    if q in (2, 31):
        return ZZ(1)
    if q % 31 == 1:
        return ZZ(31) if pow(2, int((q - 1) // 31), int(q)) == 1 else ZZ(0)
    count = ZZ(1)
    if q * q < BOUND:
        order = order_mod_31(q)
        if q ** order < BOUND:
            count += 30 // order
    return count


boundaries = [ZZ(2)]
cumulative = ZZ(0)
next_shard = ZZ(1)
for q in prime_range(2, BOUND):
    cumulative += ideal_count(ZZ(q))
    if next_shard < SHARDS and cumulative * SHARDS >= next_shard * EXPECTED:
        boundaries.append(ZZ(q) + 1)
        print("BOUNDARY_INDEX={} VALUE={} CUMULATIVE_IDEALS={}".format(
            next_shard, ZZ(q) + 1, cumulative
        ))
        next_shard += 1

boundaries.append(BOUND)
if cumulative != EXPECTED or len(boundaries) != SHARDS + 1:
    raise ArithmeticError("factor-base total or boundary count mismatch")
print("BOUNDARIES={}".format(" ".join(str(value) for value in boundaries)))
print("TOTAL_FACTOR_BASE_IDEALS={}".format(cumulative))
print("P31_BDF_PRINCIPAL_BOUNDARY_PLAN_PASS")
