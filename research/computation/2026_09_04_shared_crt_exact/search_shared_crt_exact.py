#!/usr/bin/env python3
"""Exact finite audit of the SCRT-0 shared-CRT boundary.

All optimization decisions are made with integers and fractions.  A source
attached to p^e has multiplicative capacity p^(e-1), while a sink attached to
q has capacity q.  Thus exp(B_SCRT) is an exact rational number.  Logarithms
are used only for human-readable diagnostics after an optimum is fixed.

The primary optimizer has two exhaustive layers:

1. enumerate every compatible saturated block (S,T) and every reachable
   union of pairwise source-disjoint and sink-disjoint blocks;
2. for each such union, enumerate every residual exclusive packet assignment
   by a capped-product dynamic program.

The finite scans in this file do not decide the quantified SCRT-0 gate.
"""

from __future__ import annotations

import argparse
import csv
import itertools
import json
import math
from collections import Counter, deque
from decimal import Decimal, localcontext
from fractions import Fraction
from pathlib import Path
from typing import Dict, Iterable, Iterator, List, Mapping, Optional, Sequence, Tuple

import sympy


Factorization = Tuple[Tuple[int, int], ...]
Source = Tuple[int, int, int, int]  # p, e, p^(e-1), p^e
Block = Tuple[int, int]  # source mask, sink mask
Owners = Tuple[int, ...]  # global source index, or -1 for unused/consumed


def smallest_prime_factors(limit: int) -> List[int]:
    spf = list(range(limit + 1))
    if limit >= 1:
        spf[1] = 1
    for p in range(2, math.isqrt(limit) + 1):
        if spf[p] == p:
            for n in range(p * p, limit + 1, p):
                if spf[n] == n:
                    spf[n] = p
    return spf


def factor_from_spf(n: int, spf: Sequence[int]) -> Factorization:
    out: List[Tuple[int, int]] = []
    while n > 1:
        p = spf[n]
        e = 0
        while n % p == 0:
            n //= p
            e += 1
        out.append((p, e))
    return tuple(out)


def factor_sympy(n: int) -> Factorization:
    if n < 1:
        raise ValueError("factorization requires a positive integer")
    if n == 1:
        return tuple()
    raw = sympy.factorint(n)
    out = tuple(sorted((int(p), int(e)) for p, e in raw.items()))
    assert math.prod(p**e for p, e in out) == n
    assert all(sympy.isprime(p) for p, _ in out)
    return out


def radical(factors: Factorization) -> int:
    return math.prod(p for p, _ in factors)


def sources_from_endpoint(factors_c: Factorization) -> Tuple[Source, ...]:
    return tuple(
        (p, e, p ** (e - 1), p**e) for p, e in factors_c if e >= 2
    )


def sink_data(
    factors_a: Factorization, factors_b: Factorization
) -> Tuple[Tuple[int, int, int], ...]:
    """Return (prime, complete a-arm factor, complete b-arm factor)."""
    rows = [(p, p**e, 1) for p, e in factors_a]
    rows.extend((p, 1, p**e) for p, e in factors_b)
    rows.sort()
    assert len({p for p, _, _ in rows}) == len(rows)
    return tuple(rows)


def subset_products(values: Sequence[int]) -> Tuple[int, ...]:
    products = [1] * (1 << len(values))
    for mask in range(1, len(products)):
        bit = mask & -mask
        i = bit.bit_length() - 1
        products[mask] = products[mask ^ bit] * values[i]
    return tuple(products)


def mask_indices(mask: int) -> Tuple[int, ...]:
    return tuple(i for i in range(mask.bit_length()) if mask & (1 << i))


def enumerate_blocks(
    sources: Sequence[Source], sinks: Sequence[Tuple[int, int, int]]
) -> Tuple[Tuple[Block, ...], Tuple[Block, ...], Dict[str, Tuple[int, ...]]]:
    """Enumerate all CRT-compatible blocks and their saturated subfamily."""
    source_caps = subset_products([row[2] for row in sources])
    source_moduli = subset_products([row[3] for row in sources])
    sink_caps = subset_products([row[0] for row in sinks])
    arm_a = subset_products([row[1] for row in sinks])
    arm_b = subset_products([row[2] for row in sinks])
    compatible: List[Block] = []
    saturated: List[Block] = []
    for smask in range(1, 1 << len(sources)):
        modulus = source_moduli[smask]
        capacity = source_caps[smask]
        for tmask in range(1, 1 << len(sinks)):
            if (arm_a[tmask] + arm_b[tmask]) % modulus != 0:
                continue
            block = (smask, tmask)
            compatible.append(block)
            if capacity <= sink_caps[tmask]:
                saturated.append(block)
    tables = {
        "source_caps": source_caps,
        "source_moduli": source_moduli,
        "sink_caps": sink_caps,
        "arm_a": arm_a,
        "arm_b": arm_b,
    }
    return tuple(compatible), tuple(saturated), tables


def disjoint_block_unions(blocks: Sequence[Block]) -> Dict[Block, Tuple[int, ...]]:
    """All masks attainable by a pairwise-disjoint block family.

    Only the two union masks affect the residual exclusive problem, so one
    deterministic family certificate is retained for each reachable pair.
    """
    paths: Dict[Block, Tuple[int, ...]] = {(0, 0): tuple()}
    queue = deque([(0, 0)])
    while queue:
        used_s, used_t = queue.popleft()
        path = paths[(used_s, used_t)]
        for index, (smask, tmask) in enumerate(blocks):
            if used_s & smask or used_t & tmask:
                continue
            state = (used_s | smask, used_t | tmask)
            if state in paths:
                continue
            paths[state] = path + (index,)
            queue.append(state)
    return paths


def exclusive_optimum(
    capacities: Sequence[int], sink_primes: Sequence[int]
) -> Tuple[Fraction, Tuple[int, ...], Tuple[int, ...], int, int]:
    """Exact residual factor for indivisible one-owner sink packets."""
    if not capacities:
        return Fraction(1, 1), tuple(-1 for _ in sink_primes), tuple(), 1, 1
    initial = tuple(1 for _ in capacities)
    dp: Dict[Tuple[int, ...], Tuple[int, ...]] = {initial: tuple()}
    layer_total = 1
    for q in sink_primes:
        nxt: Dict[Tuple[int, ...], Tuple[int, ...]] = {}
        for state, word in dp.items():
            candidates = [(-1, state)]
            for local_index, cap in enumerate(capacities):
                changed = list(state)
                changed[local_index] = min(cap, changed[local_index] * q)
                candidates.append((local_index, tuple(changed)))
            for owner, state2 in candidates:
                word2 = word + (owner,)
                old = nxt.get(state2)
                if old is None or word2 < old:
                    nxt[state2] = word2
        dp = nxt
        layer_total += len(dp)
    reward = max(math.prod(state) for state in dp)
    choices = sorted(
        (word, state)
        for state, word in dp.items()
        if math.prod(state) == reward
    )
    word, capped = choices[0]
    return (
        Fraction(math.prod(capacities), reward),
        word,
        capped,
        len(dp),
        layer_total,
    )


def eligible_item_optimum(
    capacities: Sequence[int],
    items: Sequence[Tuple[Tuple[int, Fraction], ...]],
) -> Tuple[Fraction, Tuple[int, ...], Tuple[Fraction, ...], int, int]:
    """Assign indivisible rational-weight items subject to eligibility.

    Each item lists its eligible local source indices and the multiplicative
    weight delivered to that source.  The unused choice is always present.
    Capping each accumulated product at its source capacity is lossless because
    every item has weight at least one.
    """
    if not capacities:
        return Fraction(1, 1), tuple(-1 for _ in items), tuple(), 1, 1
    initial = tuple(Fraction(1, 1) for _ in capacities)
    dp: Dict[Tuple[Fraction, ...], Tuple[int, ...]] = {initial: tuple()}
    layer_total = 1
    for options in items:
        assert all(weight >= 1 for _, weight in options)
        nxt: Dict[Tuple[Fraction, ...], Tuple[int, ...]] = {}
        for state, word in dp.items():
            candidates = [(-1, state)]
            for local_index, weight in options:
                changed = list(state)
                changed[local_index] = min(
                    Fraction(capacities[local_index], 1),
                    changed[local_index] * weight,
                )
                candidates.append((local_index, tuple(changed)))
            for owner, state2 in candidates:
                word2 = word + (owner,)
                old = nxt.get(state2)
                if old is None or word2 < old:
                    nxt[state2] = word2
        dp = nxt
        layer_total += len(dp)
    reward = max(math.prod(state, start=Fraction(1, 1)) for state in dp)
    choices = sorted(
        (word, state)
        for state, word in dp.items()
        if math.prod(state, start=Fraction(1, 1)) == reward
    )
    word, capped = choices[0]
    return (
        Fraction(math.prod(capacities), 1) / reward,
        word,
        capped,
        len(dp),
        layer_total,
    )


def token_delivery_options(
    block: Block,
    sources: Sequence[Source],
    tables: Mapping[str, Sequence[int]],
) -> Tuple[Tuple[int, Fraction, int], ...]:
    """Return (source, reusable factor, witnessing U mask).

    A proper compatible subset U caps the reusable surplus by rad(U).  For a
    fixed target source the largest exact admissible cap is optimal; ties use
    the least mask for a deterministic certificate.
    """
    smask, tmask = block
    surplus = Fraction(tables["sink_caps"][tmask], tables["source_caps"][smask])
    best: Dict[int, Tuple[Fraction, int]] = {}
    submask = (tmask - 1) & tmask
    while submask:
        truncated_sum = tables["arm_a"][submask] + tables["arm_b"][submask]
        subset_cap = Fraction(tables["sink_caps"][submask], 1)
        for i, source in enumerate(sources):
            if smask & (1 << i) or truncated_sum % source[3] != 0:
                continue
            delivery = min(surplus, subset_cap)
            old = best.get(i)
            if old is None or delivery > old[0] or (delivery == old[0] and submask < old[1]):
                best[i] = (delivery, submask)
        submask = (submask - 1) & tmask
    return tuple((i, value, witness) for i, (value, witness) in sorted(best.items()))


def fcrt_optimum(
    sources: Sequence[Source],
    sinks: Sequence[Tuple[int, int, int]],
    saturated: Sequence[Block],
    tables: Mapping[str, Sequence[int]],
) -> Dict[str, object]:
    """Complete FCRT search over block families and eligible surplus tokens."""
    token_data = []
    for block in saturated:
        smask, tmask = block
        token_data.append(
            (
                Fraction(tables["sink_caps"][tmask], tables["source_caps"][smask]),
                token_delivery_options(block, sources, tables),
            )
        )

    best_key = None
    best: Optional[Dict[str, object]] = None
    family_count = 0

    def visit(start: int, path: Tuple[int, ...], used_s: int, used_t: int) -> None:
        nonlocal best_key, best, family_count
        family_count += 1
        remaining_sources = tuple(i for i in range(len(sources)) if not used_s & (1 << i))
        remaining_sinks = tuple(j for j in range(len(sinks)) if not used_t & (1 << j))
        local_of_global = {global_i: local_i for local_i, global_i in enumerate(remaining_sources)}
        capacities = tuple(sources[i][2] for i in remaining_sources)
        item_meta: List[Tuple[str, int]] = []
        items: List[Tuple[Tuple[int, Fraction], ...]] = []
        for j in remaining_sinks:
            item_meta.append(("sink", j))
            items.append(
                tuple((local_i, Fraction(sinks[j][0], 1)) for local_i in range(len(remaining_sources)))
            )
        for block_index in path:
            _, delivery_global = token_data[block_index]
            delivery_local = tuple(
                (local_of_global[i], factor)
                for i, factor, _ in delivery_global
                if i in local_of_global
            )
            item_meta.append(("token", block_index))
            items.append(delivery_local)
        residual, local_word, capped, final_states, layer_total = eligible_item_optimum(
            capacities, items
        )
        chosen_weights = tuple(
            Fraction(1, 1)
            if owner < 0
            else next(weight for local_i, weight in options if local_i == owner)
            for options, owner in zip(items, local_word)
        )
        global_word = tuple(
            -1 if owner < 0 else remaining_sources[owner] for owner in local_word
        )
        key = (residual, len(path), path, global_word, used_s, used_t)
        if best_key is None or key < best_key:
            best_key = key
            best = {
                "residual": residual,
                "path": path,
                "used_s": used_s,
                "used_t": used_t,
                "remaining_source_indices": remaining_sources,
                "remaining_sink_indices": remaining_sinks,
                "item_meta": tuple(item_meta),
                "item_weights": chosen_weights,
                "item_options": tuple(items),
                "owners": global_word,
                "capped": capped,
                "final_states": final_states,
                "layer_state_sum": layer_total,
            }
        for index in range(start, len(saturated)):
            smask, tmask = saturated[index]
            if used_s & smask or used_t & tmask:
                continue
            visit(index + 1, path + (index,), used_s | smask, used_t | tmask)

    visit(0, tuple(), 0, 0)
    assert best is not None
    best["family_count"] = family_count
    best["token_data"] = tuple(token_data)
    return best


def scalar_factor(core: int, external: int) -> Fraction:
    return Fraction(core, external) if core > external else Fraction(1, 1)


def solve_full(
    a: int,
    b: int,
    c: int,
    factors_a: Factorization,
    factors_b: Factorization,
    factors_c: Factorization,
) -> Dict[str, object]:
    """Run the complete two-layer SCRT optimizer."""
    assert a + b == c and math.gcd(a, b) == 1
    sources = sources_from_endpoint(factors_c)
    sinks = sink_data(factors_a, factors_b)
    core = c // radical(factors_c)
    external = radical(factors_a) * radical(factors_b)
    assert core == math.prod(row[2] for row in sources)
    assert external == math.prod(row[0] for row in sinks)
    compatible, saturated, tables = enumerate_blocks(sources, sinks)
    unions = disjoint_block_unions(saturated)
    pbt_result = exclusive_optimum(
        tuple(source[2] for source in sources), tuple(sink[0] for sink in sinks)
    )
    pbt_residual, pbt_owners, pbt_capped, pbt_final_states, pbt_layer_total = pbt_result

    best_key = None
    best: Optional[Dict[str, object]] = None
    all_s = (1 << len(sources)) - 1
    all_t = (1 << len(sinks)) - 1
    for (used_s, used_t), path in sorted(unions.items()):
        remaining_source_indices = tuple(i for i in range(len(sources)) if not used_s & (1 << i))
        remaining_sink_indices = tuple(j for j in range(len(sinks)) if not used_t & (1 << j))
        capacities = tuple(sources[i][2] for i in remaining_source_indices)
        primes = tuple(sinks[j][0] for j in remaining_sink_indices)
        ex = exclusive_optimum(capacities, primes)
        residual, local_word, capped, final_states, layer_total = ex
        global_owners = [-1] * len(sinks)
        for j, local_owner in zip(remaining_sink_indices, local_word):
            if local_owner >= 0:
                global_owners[j] = remaining_source_indices[local_owner]
        key = (
            residual,
            len(path),
            tuple(saturated[i] for i in path),
            tuple(global_owners),
            used_s,
            used_t,
        )
        if best_key is None or key < best_key:
            best_key = key
            best = {
                "residual": residual,
                "used_s": used_s,
                "used_t": used_t,
                "path": path,
                "owners": tuple(global_owners),
                "remaining_source_indices": remaining_source_indices,
                "remaining_sink_indices": remaining_sink_indices,
                "capped": capped,
                "exclusive_final_states": final_states,
                "exclusive_layer_state_sum": layer_total,
            }
    assert best is not None
    residual = best["residual"]
    scalar = scalar_factor(core, external)
    assert isinstance(residual, Fraction) and residual >= scalar
    assert residual <= pbt_residual

    # Replay the attaining certificate without using the DP state.
    used_s = int(best["used_s"])
    used_t = int(best["used_t"])
    packet_products = [1] * len(sources)
    owners = best["owners"]
    for j, owner in enumerate(owners):
        if used_t & (1 << j):
            assert owner == -1
        elif owner >= 0:
            assert not used_s & (1 << owner)
            packet_products[owner] *= sinks[j][0]
    replay = Fraction(1, 1)
    for i, source in enumerate(sources):
        if not used_s & (1 << i):
            replay *= max(Fraction(source[2], packet_products[i]), Fraction(1, 1))
    assert replay == residual
    for block_index in best["path"]:
        smask, tmask = saturated[block_index]
        assert smask & used_s == smask and tmask & used_t == tmask
        assert tables["source_caps"][smask] <= tables["sink_caps"][tmask]
        assert (
            tables["arm_a"][tmask] + tables["arm_b"][tmask]
        ) % tables["source_moduli"][smask] == 0

    fcrt = fcrt_optimum(sources, sinks, saturated, tables)
    fcrt_residual = fcrt["residual"]
    assert isinstance(fcrt_residual, Fraction)
    assert scalar <= fcrt_residual <= residual

    return {
        "abc": (a, b, c),
        "factorizations": (factors_a, factors_b, factors_c),
        "sources": sources,
        "sinks": sinks,
        "core": core,
        "external": external,
        "conductor": external * radical(factors_c),
        "scalar": scalar,
        "compatible": compatible,
        "saturated": saturated,
        "tables": tables,
        "reachable_unions": len(unions),
        "best": best,
        "packet_products": tuple(packet_products),
        "pbt": {
            "residual": pbt_residual,
            "owners": pbt_owners,
            "capped": pbt_capped,
            "final_states": pbt_final_states,
            "layer_state_sum": pbt_layer_total,
        },
        "pbt_residual": pbt_residual,
        "residual": residual,
        "fcrt": fcrt,
        "fcrt_residual": fcrt_residual,
        "method": "complete_block_union_plus_exclusive_dp",
        "all_source_mask": all_s,
        "all_sink_mask": all_t,
    }


def solve_with_shortcuts(
    a: int,
    b: int,
    c: int,
    factors_a: Factorization,
    factors_b: Factorization,
    factors_c: Factorization,
) -> Dict[str, object]:
    """Use proved easy strata, invoking the full optimizer on the hard stratum."""
    sources = sources_from_endpoint(factors_c)
    core = c // radical(factors_c)
    external = radical(factors_a) * radical(factors_b)
    conductor = external * radical(factors_c)
    scalar = scalar_factor(core, external)
    if not sources:
        residual = Fraction(1, 1)
        method = "no_endpoint_sources"
    elif core <= external:
        residual = Fraction(1, 1)
        method = "full_block_saturated_X_le_Y"
    elif len(sources) == 1:
        residual = scalar
        method = "one_source_exact_scalar"
    else:
        return solve_full(a, b, c, factors_a, factors_b, factors_c)
    return {
        "abc": (a, b, c),
        "factorizations": (factors_a, factors_b, factors_c),
        "sources": sources,
        "core": core,
        "external": external,
        "conductor": conductor,
        "scalar": scalar,
        "residual": residual,
        "fcrt_residual": residual,
        "method": method,
    }


def primitive_triples(limit: int) -> Iterator[Tuple[int, int, int]]:
    for c in range(2, limit + 1):
        for a in range(1, c // 2 + 1):
            b = c - a
            if math.gcd(a, b) == 1:
                yield a, b, c


def fraction_json(value: Fraction) -> Dict[str, int]:
    return {"numerator": value.numerator, "denominator": value.denominator}


def factor_json(factors: Factorization) -> List[List[int]]:
    return [[p, e] for p, e in factors]


def decimal_ln(value: Fraction) -> str:
    if value == 1:
        return "0"
    with localcontext() as ctx:
        ctx.prec = 60
        result = Decimal(value.numerator).ln() - Decimal(value.denominator).ln()
        return format(result, ".40f")


def decimal_log_ratio(value: Fraction, conductor: int) -> str:
    if value == 1:
        return "0"
    with localcontext() as ctx:
        ctx.prec = 60
        numerator = Decimal(value.numerator).ln() - Decimal(value.denominator).ln()
        return format(numerator / Decimal(conductor).ln(), ".40f")


def exact_ratio_ge(value: Fraction, conductor: int, num: int, den: int) -> bool:
    if value < 1 or conductor <= 1 or num < 0 or den <= 0:
        raise ValueError("invalid logarithmic-ratio comparison")
    return value.numerator**den >= value.denominator**den * conductor**num


def exact_ratio_floor(value: Fraction, conductor: int, denominator: int) -> int:
    if value == 1:
        return 0
    with localcontext() as ctx:
        ctx.prec = 60
        guess = int(
            (
                (Decimal(value.numerator).ln() - Decimal(value.denominator).ln())
                / Decimal(conductor).ln()
            )
            * denominator
        )
    k = max(0, guess)
    while k and not exact_ratio_ge(value, conductor, k, denominator):
        k -= 1
    while exact_ratio_ge(value, conductor, k + 1, denominator):
        k += 1
    assert exact_ratio_ge(value, conductor, k, denominator)
    assert not exact_ratio_ge(value, conductor, k + 1, denominator)
    return k


def block_json(data: Mapping[str, object], block: Block) -> Dict[str, object]:
    smask, tmask = block
    sources: Sequence[Source] = data["sources"]  # type: ignore[assignment]
    sinks: Sequence[Tuple[int, int, int]] = data["sinks"]  # type: ignore[assignment]
    tables: Mapping[str, Sequence[int]] = data["tables"]  # type: ignore[assignment]
    return {
        "source_primes": [sources[i][0] for i in mask_indices(smask)],
        "sink_primes": [sinks[j][0] for j in mask_indices(tmask)],
        "source_modulus": tables["source_moduli"][smask],
        "source_capacity_product": tables["source_caps"][smask],
        "sink_capacity_product": tables["sink_caps"][tmask],
        "truncated_a": tables["arm_a"][tmask],
        "truncated_b": tables["arm_b"][tmask],
        "truncated_sum": tables["arm_a"][tmask] + tables["arm_b"][tmask],
    }


def detailed_record(data: Dict[str, object], ratio_denominator: int) -> Dict[str, object]:
    """Force a complete solve and emit a replayable optimum certificate."""
    if data["method"] != "complete_block_union_plus_exclusive_dp":
        fa, fb, fc = data["factorizations"]
        a, b, c = data["abc"]
        data = solve_full(a, b, c, fa, fb, fc)
    a, b, c = data["abc"]
    fa, fb, fc = data["factorizations"]
    sources: Sequence[Source] = data["sources"]
    sinks: Sequence[Tuple[int, int, int]] = data["sinks"]
    residual: Fraction = data["residual"]
    scalar: Fraction = data["scalar"]
    best: Mapping[str, object] = data["best"]
    used_s = int(best["used_s"])
    used_t = int(best["used_t"])
    owners: Sequence[int] = best["owners"]  # type: ignore[assignment]
    path: Sequence[int] = best["path"]  # type: ignore[assignment]
    saturated: Sequence[Block] = data["saturated"]
    assignments = []
    for j, (q, _, _) in enumerate(sinks):
        if used_t & (1 << j):
            owner = "consumed_by_shared_block"
        elif owners[j] < 0:
            owner = "unused"
        else:
            owner = str(sources[owners[j]][0])
        assignments.append({"sink_prime": q, "owner": owner})
    source_rows = []
    packet_products: Sequence[int] = data["packet_products"]
    for i, (p, e, cap, modulus) in enumerate(sources):
        covered = bool(used_s & (1 << i))
        packet = packet_products[i]
        local = Fraction(1, 1) if covered else max(Fraction(cap, packet), Fraction(1, 1))
        source_rows.append(
            {
                "prime": p,
                "endpoint_exponent": e,
                "capacity_product": cap,
                "prime_power_modulus": modulus,
                "covered_by_shared_block": covered,
                "exclusive_packet_product": packet,
                "local_residual_factor": fraction_json(local),
            }
        )
    pbt: Mapping[str, object] = data["pbt"]
    pbt_residual: Fraction = data["pbt_residual"]
    pbt_owners: Sequence[int] = pbt["owners"]  # type: ignore[assignment]
    pbt_packets = [1 for _ in sources]
    pbt_assignment = []
    for j, owner in enumerate(pbt_owners):
        if owner >= 0:
            pbt_packets[owner] *= sinks[j][0]
        pbt_assignment.append(
            {
                "sink_prime": sinks[j][0],
                "owner_prime": None if owner < 0 else sources[owner][0],
            }
        )
    pbt_source_rows = []
    pbt_replay = Fraction(1, 1)
    for source, packet in zip(sources, pbt_packets):
        local = max(Fraction(source[2], packet), Fraction(1, 1))
        pbt_replay *= local
        pbt_source_rows.append(
            {
                "prime": source[0],
                "exclusive_packet_product": packet,
                "local_residual_factor": fraction_json(local),
            }
        )
    assert pbt_replay == pbt_residual
    fcrt: Mapping[str, object] = data["fcrt"]
    fcrt_residual: Fraction = data["fcrt_residual"]
    fcrt_path: Sequence[int] = fcrt["path"]  # type: ignore[assignment]
    fcrt_used_s = int(fcrt["used_s"])
    fcrt_item_meta: Sequence[Tuple[str, int]] = fcrt["item_meta"]  # type: ignore[assignment]
    fcrt_item_weights: Sequence[Fraction] = fcrt["item_weights"]  # type: ignore[assignment]
    fcrt_owners: Sequence[int] = fcrt["owners"]  # type: ignore[assignment]
    token_data: Sequence[
        Tuple[Fraction, Tuple[Tuple[int, Fraction, int], ...]]
    ] = fcrt["token_data"]  # type: ignore[assignment]
    fcrt_supplies = [Fraction(1, 1) for _ in sources]
    fcrt_items = []
    for meta, weight, owner in zip(fcrt_item_meta, fcrt_item_weights, fcrt_owners):
        kind, index = meta
        row: Dict[str, object] = {
            "kind": kind,
            "weight_factor": fraction_json(weight),
            "owner_prime": None if owner < 0 else sources[owner][0],
        }
        if kind == "sink":
            row["sink_prime"] = sinks[index][0]
            row["eligible_source_primes"] = [
                sources[i][0] for i in range(len(sources)) if not fcrt_used_s & (1 << i)
            ]
        else:
            row["originating_block"] = block_json(data, saturated[index])
            surplus, deliveries = token_data[index]
            row["surplus_token_factor"] = fraction_json(surplus)
            row["eligible_deliveries"] = [
                {
                    "source_prime": sources[i][0],
                    "delivered_factor": fraction_json(delivery),
                    "witness_U_sink_primes": [
                        sinks[j][0] for j in mask_indices(witness_mask)
                    ],
                }
                for i, delivery, witness_mask in deliveries
            ]
            if owner >= 0:
                _, _, witness_mask = next(
                    option for option in deliveries if option[0] == owner
                )
                row["chosen_witness_U_sink_primes"] = [
                    sinks[j][0] for j in mask_indices(witness_mask)
                ]
        if owner >= 0:
            fcrt_supplies[owner] *= weight
        fcrt_items.append(row)
    fcrt_source_rows = []
    fcrt_replay = Fraction(1, 1)
    for i, source in enumerate(sources):
        covered = bool(fcrt_used_s & (1 << i))
        local = Fraction(1, 1) if covered else max(
            Fraction(source[2], 1) / fcrt_supplies[i], Fraction(1, 1)
        )
        fcrt_replay *= local
        fcrt_source_rows.append(
            {
                "prime": source[0],
                "covered_by_shared_block": covered,
                "received_factor": fraction_json(fcrt_supplies[i]),
                "local_residual_factor": fraction_json(local),
            }
        )
    assert fcrt_replay == fcrt_residual
    floor = exact_ratio_floor(residual, int(data["conductor"]), ratio_denominator)
    fcrt_floor = exact_ratio_floor(fcrt_residual, int(data["conductor"]), ratio_denominator)
    return {
        "abc": [a, b, c],
        "factorization": {"a": factor_json(fa), "b": factor_json(fb), "c": factor_json(fc)},
        "radical_abc": data["conductor"],
        "endpoint_core": data["core"],
        "external_radical": data["external"],
        "sources": source_rows,
        "sinks": [row[0] for row in sinks],
        "block_enumeration": {
            "compatible_count": len(data["compatible"]),
            "compatible_saturated_count": len(saturated),
            "reachable_pairwise_disjoint_union_count": data["reachable_unions"],
            "all_compatible_blocks": [block_json(data, block) for block in data["compatible"]],
            "all_compatible_saturated_blocks": [block_json(data, block) for block in saturated],
        },
        "PBT": {
            "attaining_exclusive_assignment": pbt_assignment,
            "source_replay": pbt_source_rows,
            "optimal_residual_factor_exp_B": fraction_json(pbt_residual),
            "B_decimal": decimal_ln(pbt_residual),
        },
        "attaining_configuration": {
            "shared_blocks": [block_json(data, saturated[i]) for i in path],
            "exclusive_assignment": assignments,
            "exclusive_final_capped_state_count": best["exclusive_final_states"],
            "exclusive_layer_state_count_sum": best["exclusive_layer_state_sum"],
        },
        "optimal_residual_factor_exp_B": fraction_json(residual),
        "B_decimal": decimal_ln(residual),
        "scalar_positive_defect_factor": fraction_json(scalar),
        "fragmentation_factor_exp_B_minus_Delta": fraction_json(residual / scalar),
        "B_over_log_radical": {
            "diagnostic_decimal": decimal_log_ratio(residual, int(data["conductor"])),
            "certified_grid_lower_numerator": floor,
            "certified_grid_upper_numerator": floor + 1,
            "certified_grid_denominator": ratio_denominator,
        },
        "FCRT": {
            "complete_pairwise_disjoint_block_family_count": fcrt["family_count"],
            "attaining_shared_blocks": [block_json(data, saturated[i]) for i in fcrt_path],
            "indivisible_items_and_owners": fcrt_items,
            "source_replay": fcrt_source_rows,
            "optimal_residual_factor_exp_B": fraction_json(fcrt_residual),
            "B_decimal": decimal_ln(fcrt_residual),
            "improvement_factor_exp_B_SCRT_minus_B_FCRT": fraction_json(residual / fcrt_residual),
            "fragmentation_factor_exp_B_minus_Delta": fraction_json(fcrt_residual / scalar),
            "B_over_log_radical": {
                "diagnostic_decimal": decimal_log_ratio(fcrt_residual, int(data["conductor"])),
                "certified_grid_lower_numerator": fcrt_floor,
                "certified_grid_upper_numerator": fcrt_floor + 1,
                "certified_grid_denominator": ratio_denominator,
            },
        },
    }


def scan_exhaustive(cmax: int, ratio_denominator: int) -> Tuple[Dict[str, object], Dict[Tuple[int, int, int], Dict[str, object]]]:
    spf = smallest_prime_factors(cmax)
    factors = [tuple() for _ in range(cmax + 1)]
    for n in range(1, cmax + 1):
        factors[n] = factor_from_spf(n, spf)
    counts: Counter[str] = Counter()
    method_counts: Counter[str] = Counter()
    maxima: Dict[str, Tuple[Fraction, Tuple[int, int, int], Dict[str, object]]] = {}
    max_grid = -1
    max_grid_example: Optional[Tuple[int, int, int]] = None
    max_fcrt_grid = -1
    max_fcrt_grid_example: Optional[Tuple[int, int, int]] = None
    selected: Dict[Tuple[int, int, int], Dict[str, object]] = {}
    for a, b, c in primitive_triples(cmax):
        data = solve_with_shortcuts(a, b, c, factors[a], factors[b], factors[c])
        counts["triples"] += 1
        method_counts[str(data["method"])] += 1
        sources: Sequence[Source] = data["sources"]
        residual: Fraction = data["residual"]
        fcrt_residual: Fraction = data["fcrt_residual"]
        scalar: Fraction = data["scalar"]
        assert scalar <= fcrt_residual <= residual
        if sources:
            counts["endpoint_with_source"] += 1
        if len(sources) >= 2:
            counts["endpoint_with_at_least_two_sources"] += 1
        if residual > 1:
            counts["positive_B"] += 1
        else:
            counts["zero_B"] += 1
        if residual > scalar:
            counts["strict_fragmentation_beyond_scalar"] += 1
        if residual == scalar:
            counts["equal_to_scalar"] += 1
        if fcrt_residual > 1:
            counts["FCRT_positive_B"] += 1
        else:
            counts["FCRT_zero_B"] += 1
        if fcrt_residual > scalar:
            counts["FCRT_strict_fragmentation_beyond_scalar"] += 1
        else:
            counts["FCRT_equal_to_scalar"] += 1
        if fcrt_residual < residual:
            counts["FCRT_strict_improvement_over_SCRT"] += 1
        abc = (a, b, c)
        for name, value in (
            ("residual", residual),
            ("fragmentation", residual / scalar),
            ("fcrt_residual", fcrt_residual),
            ("fcrt_fragmentation", fcrt_residual / scalar),
            ("fcrt_improvement", residual / fcrt_residual),
        ):
            old = maxima.get(name)
            if old is None or value > old[0] or (value == old[0] and abc < old[1]):
                maxima[name] = (value, abc, data)
        floor = exact_ratio_floor(residual, int(data["conductor"]), ratio_denominator)
        if floor > max_grid or (floor == max_grid and (max_grid_example is None or abc < max_grid_example)):
            max_grid = floor
            max_grid_example = abc
            selected[abc] = data
        fcrt_floor = exact_ratio_floor(fcrt_residual, int(data["conductor"]), ratio_denominator)
        if fcrt_floor > max_fcrt_grid or (
            fcrt_floor == max_fcrt_grid
            and (max_fcrt_grid_example is None or abc < max_fcrt_grid_example)
        ):
            max_fcrt_grid = fcrt_floor
            max_fcrt_grid_example = abc
            selected[abc] = data
        if residual > scalar or fcrt_residual < residual:
            selected[abc] = data
    for _, abc, data in maxima.values():
        selected[abc] = data
    assert max_grid_example is not None
    assert max_fcrt_grid_example is not None
    summary = {
        "normalization": "1 <= a <= b, a+b=c, gcd(a,b)=1",
        "c_max": cmax,
        "counts": dict(sorted(counts.items())),
        "solution_method_counts": dict(sorted(method_counts.items())),
        "largest_exact_residual_factor": {
            "factor": fraction_json(maxima["residual"][0]),
            "abc": list(maxima["residual"][1]),
        },
        "largest_exact_fragmentation_factor": {
            "factor": fraction_json(maxima["fragmentation"][0]),
            "abc": list(maxima["fragmentation"][1]),
        },
        "largest_observed_B_over_log_radical_grid_cell": {
            "lower_numerator": max_grid,
            "upper_numerator": max_grid + 1,
            "denominator": ratio_denominator,
            "example": list(max_grid_example),
        },
        "FCRT_largest_exact_residual_factor": {
            "factor": fraction_json(maxima["fcrt_residual"][0]),
            "abc": list(maxima["fcrt_residual"][1]),
        },
        "FCRT_largest_exact_fragmentation_factor": {
            "factor": fraction_json(maxima["fcrt_fragmentation"][0]),
            "abc": list(maxima["fcrt_fragmentation"][1]),
        },
        "FCRT_largest_improvement_factor_over_SCRT": {
            "factor": fraction_json(maxima["fcrt_improvement"][0]),
            "abc": list(maxima["fcrt_improvement"][1]),
        },
        "FCRT_largest_observed_B_over_log_radical_grid_cell": {
            "lower_numerator": max_fcrt_grid,
            "upper_numerator": max_fcrt_grid + 1,
            "denominator": ratio_denominator,
            "example": list(max_fcrt_grid_example),
        },
    }
    return summary, selected


def point_from_sympy(a: int, b: int) -> Dict[str, object]:
    if a > b:
        a, b = b, a
    c = a + b
    if math.gcd(a, b) != 1:
        raise ValueError("structured point is not primitive")
    return solve_full(a, b, c, factor_sympy(a), factor_sympy(b), factor_sympy(c))


def structured_cases(
    generalized_base_max: int,
    generalized_value_max: int,
) -> List[Tuple[str, str, Dict[str, object]]]:
    cases: List[Tuple[str, str, Dict[str, object]]] = []

    # The exact stress-test family for every tractably factored exponent here.
    for n in range(2, 25):
        cases.append(("two_fifteen_power", f"n={n}", point_from_sympy(2, 15**n - 2)))

    # Fixed composite bases with several endpoint sources.
    for base in (6, 10, 12, 15, 18, 30, 42):
        for exponent in range(2, 11):
            cases.append(
                (
                    "composite_base_unit_power",
                    f"base={base};exponent={exponent}",
                    point_from_sympy(1, base**exponent - 1),
                )
            )

    # Balanced input-arm powers.
    for r in range(1, 21):
        cases.append(("balanced_4r_3r", f"r={r}", point_from_sympy(4**r, 3**r)))

    # Mixed-power generalized-Fermat-style points.  Retain cases whose endpoint
    # itself has at least two powerful prime factors.
    seen: set[Tuple[int, int, int]] = set()
    for u, v in itertools.product(range(2, 6), repeat=2):
        for x in range(2, generalized_base_max + 1):
            ax = x**u
            for y in range(2, generalized_base_max + 1):
                by = y**v
                if ax + by > generalized_value_max or math.gcd(ax, by) != 1:
                    continue
                a, b = sorted((ax, by))
                abc = (a, b, a + b)
                if abc in seen:
                    continue
                fc = factor_sympy(a + b)
                if len(sources_from_endpoint(fc)) < 2:
                    continue
                seen.add(abc)
                data = solve_full(a, b, a + b, factor_sympy(a), factor_sympy(b), fc)
                cases.append(
                    (
                        "mixed_power_generalized_fermat",
                        f"x={x};u={u};y={y};v={v}",
                        data,
                    )
                )
    known = (343, 625, 968)
    if known not in seen:
        cases.append(("mixed_power_generalized_fermat", "7^3+5^4", point_from_sympy(343, 625)))

    cases.append(
        (
            "forced_hard_witness",
            "four-layer-strict-chain",
            point_from_sympy(1, 65024),
        )
    )

    # Small complete instances of ell == -1 mod M^2 from the Linnik mechanism.
    predecessor_rows = (
        (2, 6, 2, 71),
        (3, 30, 3, 2699),
        (4, 210, 3, 132299),
        (5, 2310, 6, 32016599),
        (6, 30030, 2, 1803601799),
    )
    for k, modulus_root, multiplier, ell in predecessor_rows:
        assert ell == multiplier * modulus_root**2 - 1 and sympy.isprime(ell)
        cases.append(
            (
                "linnik_prime_predecessor_finite",
                f"k={k};M={modulus_root};multiplier={multiplier};ell={ell}",
                point_from_sympy(1, ell),
            )
        )

    # Shifted finite representatives ell == -2 mod M^2, with odd primorial M.
    M = 1
    for k, p in enumerate((3, 5, 7, 11, 13), start=1):
        M *= p
        if k < 2:
            continue
        ell = None
        multiplier = None
        for t in range(1, 2001):
            candidate = t * M * M - 2
            if sympy.isprime(candidate):
                ell = candidate
                multiplier = t
                break
        assert ell is not None and multiplier is not None
        cases.append(
            (
                "linnik_shifted_minus_two_finite",
                f"k={k};M={M};multiplier={multiplier};ell={ell}",
                point_from_sympy(2, ell),
            )
        )
    cases.sort(key=lambda row: (row[0], row[1], row[2]["abc"]))
    return cases


def structured_csv_row(
    family: str, parameters: str, data: Dict[str, object], ratio_denominator: int
) -> Dict[str, object]:
    a, b, c = data["abc"]
    sources: Sequence[Source] = data["sources"]
    sinks: Sequence[Tuple[int, int, int]] = data["sinks"]
    residual: Fraction = data["residual"]
    fcrt_residual: Fraction = data["fcrt_residual"]
    pbt_residual: Fraction = data["pbt_residual"]
    scalar: Fraction = data["scalar"]
    best: Mapping[str, object] = data["best"]
    saturated: Sequence[Block] = data["saturated"]
    path: Sequence[int] = best["path"]  # type: ignore[assignment]
    owners: Sequence[int] = best["owners"]  # type: ignore[assignment]
    used_t = int(best["used_t"])
    assignment = []
    for j, (q, _, _) in enumerate(sinks):
        if used_t & (1 << j):
            label = "block"
        elif owners[j] < 0:
            label = "unused"
        else:
            label = str(sources[owners[j]][0])
        assignment.append(f"{q}->{label}")
    block_word = []
    for index in path:
        smask, tmask = saturated[index]
        ps = "+".join(str(sources[i][0]) for i in mask_indices(smask))
        qs = "+".join(str(sinks[j][0]) for j in mask_indices(tmask))
        block_word.append(f"[{ps}|{qs}]")
    fcrt: Mapping[str, object] = data["fcrt"]
    fcrt_path: Sequence[int] = fcrt["path"]  # type: ignore[assignment]
    fcrt_block_word = []
    for index in fcrt_path:
        smask, tmask = saturated[index]
        ps = "+".join(str(sources[i][0]) for i in mask_indices(smask))
        qs = "+".join(str(sinks[j][0]) for j in mask_indices(tmask))
        fcrt_block_word.append(f"[{ps}|{qs}]")
    fcrt_item_word = []
    fcrt_meta: Sequence[Tuple[str, int]] = fcrt["item_meta"]  # type: ignore[assignment]
    fcrt_weights: Sequence[Fraction] = fcrt["item_weights"]  # type: ignore[assignment]
    fcrt_owners: Sequence[int] = fcrt["owners"]  # type: ignore[assignment]
    for meta, weight, owner in zip(fcrt_meta, fcrt_weights, fcrt_owners):
        kind, index = meta
        item = str(sinks[index][0]) if kind == "sink" else f"token#{index}:{weight.numerator}/{weight.denominator}"
        owner_label = "unused" if owner < 0 else str(sources[owner][0])
        fcrt_item_word.append(f"{item}->{owner_label}")
    return {
        "family": family,
        "parameters": parameters,
        "a": a,
        "b": b,
        "c": c,
        "factorization_c": ";".join(f"{p}^{e}" for p, e in data["factorizations"][2]),
        "source_capacities": ";".join(f"{p}:{cap}" for p, _, cap, _ in sources),
        "sink_primes": ";".join(str(q) for q, _, _ in sinks),
        "compatible_blocks": len(data["compatible"]),
        "saturated_blocks": len(saturated),
        "reachable_disjoint_unions": data["reachable_unions"],
        "chosen_blocks": ";".join(block_word),
        "exclusive_assignment": ";".join(assignment),
        "residual_numerator": residual.numerator,
        "residual_denominator": residual.denominator,
        "pbt_residual_numerator": pbt_residual.numerator,
        "pbt_residual_denominator": pbt_residual.denominator,
        "scalar_numerator": scalar.numerator,
        "scalar_denominator": scalar.denominator,
        "fragmentation_numerator": (residual / scalar).numerator,
        "fragmentation_denominator": (residual / scalar).denominator,
        "fcrt_chosen_blocks": ";".join(fcrt_block_word),
        "fcrt_item_assignment": ";".join(fcrt_item_word),
        "fcrt_residual_numerator": fcrt_residual.numerator,
        "fcrt_residual_denominator": fcrt_residual.denominator,
        "fcrt_fragmentation_numerator": (fcrt_residual / scalar).numerator,
        "fcrt_fragmentation_denominator": (fcrt_residual / scalar).denominator,
        "fcrt_improvement_numerator": (residual / fcrt_residual).numerator,
        "fcrt_improvement_denominator": (residual / fcrt_residual).denominator,
        "fcrt_block_family_count": fcrt["family_count"],
        "radical_abc": data["conductor"],
        "ratio_grid_floor": exact_ratio_floor(residual, int(data["conductor"]), ratio_denominator),
        "fcrt_ratio_grid_floor": exact_ratio_floor(fcrt_residual, int(data["conductor"]), ratio_denominator),
    }


def structured_summary(cases: Sequence[Tuple[str, str, Dict[str, object]]]) -> Dict[str, object]:
    result: Dict[str, object] = {}
    for family in sorted({row[0] for row in cases}):
        family_rows = [row for row in cases if row[0] == family]
        positive = [row for row in family_rows if row[2]["residual"] > 1]
        strict = [row for row in family_rows if row[2]["residual"] > row[2]["scalar"]]
        fcrt_positive = [row for row in family_rows if row[2]["fcrt_residual"] > 1]
        fcrt_strict = [row for row in family_rows if row[2]["fcrt_residual"] > row[2]["scalar"]]
        fcrt_improved = [row for row in family_rows if row[2]["fcrt_residual"] < row[2]["residual"]]
        worst = max(family_rows, key=lambda row: (row[2]["residual"], tuple(-x for x in row[2]["abc"])))
        fcrt_worst = max(family_rows, key=lambda row: (row[2]["fcrt_residual"], tuple(-x for x in row[2]["abc"])))
        result[family] = {
            "rows": len(family_rows),
            "positive_B": len(positive),
            "strict_fragmentation_beyond_scalar": len(strict),
            "largest_residual_factor": fraction_json(worst[2]["residual"]),
            "largest_residual_abc": list(worst[2]["abc"]),
            "largest_residual_parameters": worst[1],
            "FCRT_positive_B": len(fcrt_positive),
            "FCRT_strict_fragmentation_beyond_scalar": len(fcrt_strict),
            "FCRT_strict_improvement_over_SCRT": len(fcrt_improved),
            "FCRT_largest_residual_factor": fraction_json(fcrt_worst[2]["fcrt_residual"]),
            "FCRT_largest_residual_abc": list(fcrt_worst[2]["abc"]),
            "FCRT_largest_residual_parameters": fcrt_worst[1],
        }
    return result


def partial_n284_audit() -> Dict[str, object]:
    n = 284
    b = 15**n - 2
    divisor = 31**2
    assert b % divisor == 0
    valuation = 0
    temp = b
    while temp % 31 == 0:
        valuation += 1
        temp //= 31
    # Deliberately record only certified elementary information.  Treating the
    # remaining 331-digit cofactor as one prime sink would not be an exact SCRT
    # computation, so no optimum is claimed here.
    return {
        "abc_description": "(2, 15^284-2, 15^284)",
        "primitive": math.gcd(2, b) == 1,
        "certified_divisibility": "31^2 divides 15^284-2",
        "exact_31_adic_valuation": valuation,
        "b_decimal_digits": len(str(b)),
        "remaining_cofactor_decimal_digits_after_31_power": len(str(temp)),
        "status": "not an exact B_SCRT computation because complete factorization of the external arm was not attempted",
        "logical_force": "finite/partial diagnostic only; neither proves nor refutes SCRT-0",
    }


def write_csv(path: Path, rows: Sequence[Dict[str, object]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    if not rows:
        raise ValueError("no structured rows")
    with path.open("w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--cmax", type=int, default=3000)
    parser.add_argument("--ratio-grid-denominator", type=int, default=12000)
    parser.add_argument("--generalized-base-max", type=int, default=20)
    parser.add_argument("--generalized-value-max", type=int, default=10_000_000)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--structured-csv", type=Path, required=True)
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    if args.cmax < 2 or args.ratio_grid_denominator < 1:
        raise ValueError("invalid scan parameters")
    exhaustive, selected = scan_exhaustive(args.cmax, args.ratio_grid_denominator)
    cases = structured_cases(args.generalized_base_max, args.generalized_value_max)
    regression_675 = point_from_sympy(1, 675)
    assert regression_675["pbt_residual"] == Fraction(2, 1)
    assert regression_675["residual"] == Fraction(2, 1)
    assert regression_675["scalar"] == Fraction(26, 15)
    assert regression_675["fcrt_residual"] == Fraction(26, 15)
    regression_224 = point_from_sympy(1, 224)
    assert regression_224["pbt_residual"] == Fraction(3, 2)
    assert regression_224["residual"] == Fraction(3, 2)
    assert regression_224["scalar"] == Fraction(15, 14)
    assert regression_224["fcrt_residual"] == Fraction(3, 2)
    regression_968 = point_from_sympy(343, 625)
    assert regression_968["pbt_residual"] == Fraction(11, 7)
    assert regression_968["residual"] == Fraction(11, 7)
    assert regression_968["scalar"] == Fraction(44, 35)
    assert regression_968["fcrt_residual"] == Fraction(44, 35)
    regression_65025 = point_from_sympy(1, 65024)
    assert regression_65025["pbt_residual"] == Fraction(15, 2)
    assert regression_65025["residual"] == Fraction(3, 1)
    assert regression_65025["fcrt_residual"] == Fraction(3, 2)
    assert regression_65025["scalar"] == Fraction(255, 254)
    structured_rows = [
        structured_csv_row(family, parameters, data, args.ratio_grid_denominator)
        for family, parameters, data in cases
    ]
    write_csv(args.structured_csv, structured_rows)

    # Include every finite strict-gap point in this small range, the headline
    # maxima, the published witness, and one representative from each family.
    detail_points = dict(selected)
    published = point_from_sympy(343, 625)
    detail_points[published["abc"]] = published
    for family in sorted({row[0] for row in cases}):
        candidates = [row for row in cases if row[0] == family]
        chosen = max(candidates, key=lambda row: (row[2]["residual"], tuple(-x for x in row[2]["abc"])))
        detail_points[chosen[2]["abc"]] = chosen[2]
    detailed = [
        detailed_record(detail_points[key], args.ratio_grid_denominator)
        for key in sorted(detail_points)
    ]
    payload = {
        "schema": "scrt_fcrt_exact_audit_v2",
        "model": {
            "source_capacity": "p^(v_p(c)-1) for v_p(c)>=2",
            "sink_capacity": "q for each distinct q|ab",
            "compatibility": "product(p^v_p(c), p in S) divides a_T+b_T",
            "saturation": "product(source capacities in S) <= product(q, q in T)",
            "block_rule": "chosen source masks and sink masks are separately pairwise disjoint",
            "exclusive_rule": "each residual sink is unused or assigned to exactly one residual source",
            "objective": "exp(B_SCRT)=product residual sources max(capacity/assigned_sink_product,1)",
            "arithmetic": "all feasibility and optimizer comparisons exact over integers/Fraction",
        },
        "FCRT_model": {
            "surplus_token": "each selected saturated (S,T) creates the indivisible factor rad(T)/core(S)",
            "token_eligibility": "a token may serve one remaining p only if some nonempty proper U subset T has p^e | a_U+b_U",
            "target_delivery": "the factor delivered to p is min(rad(T)/core(S), rad(U)); the optimizer chooses the largest eligible exact U-cap and records U",
            "assignment": "each token has at most one owner; multiple tokens and residual sinks may share one owner",
            "charging": "sinks consumed by a block are absent from residual packets, so original sink capacity is charged once",
            "optimizer": "all pairwise-disjoint block families, then exact eligibility-constrained capped-product DP",
            "forced_regressions": {
                "(1,675,676)": {
                    "PBT_exp_B": fraction_json(regression_675["pbt_residual"]),
                    "SCRT_exp_B": fraction_json(regression_675["residual"]),
                    "FCRT_exp_B": fraction_json(regression_675["fcrt_residual"]),
                    "scalar_exp_Delta": fraction_json(regression_675["scalar"]),
                },
                "(1,224,225)": {
                    "PBT_exp_B": fraction_json(regression_224["pbt_residual"]),
                    "SCRT_exp_B": fraction_json(regression_224["residual"]),
                    "FCRT_exp_B": fraction_json(regression_224["fcrt_residual"]),
                    "scalar_exp_Delta": fraction_json(regression_224["scalar"]),
                },
                "(343,625,968)": {
                    "PBT_exp_B": fraction_json(regression_968["pbt_residual"]),
                    "SCRT_exp_B": fraction_json(regression_968["residual"]),
                    "FCRT_exp_B": fraction_json(regression_968["fcrt_residual"]),
                    "scalar_exp_Delta": fraction_json(regression_968["scalar"]),
                },
                "(1,65024,65025)": {
                    "PBT_exp_B": fraction_json(regression_65025["pbt_residual"]),
                    "SCRT_exp_B": fraction_json(regression_65025["residual"]),
                    "FCRT_exp_B": fraction_json(regression_65025["fcrt_residual"]),
                    "scalar_exp_Delta": fraction_json(regression_65025["scalar"]),
                },
            },
        },
        "parameters": {
            "c_max": args.cmax,
            "ratio_grid_denominator": args.ratio_grid_denominator,
            "generalized_base_max": args.generalized_base_max,
            "generalized_value_max": args.generalized_value_max,
        },
        "exhaustive_scan": exhaustive,
        "structured_family_summary": structured_summary(cases),
        "structured_family_csv": args.structured_csv.name,
        "n284_partial_audit": partial_n284_audit(),
        "detailed_certificates": detailed,
        "claim_discipline": {
            "finite_scope": "Every exhaustive or structured result is finite evidence only.",
            "SCRT_0_status": "No bounded no-hit, frequency, or growing finite pattern proves or refutes the quantified gate.",
            "refutation_threshold": "Only a complete-premise family with B_SCRT - epsilon*log(rad(abc)) unbounded for some fixed epsilon>0 refutes SCRT-0.",
            "current_conclusion": "This computation supplies no such unbounded family.",
            "FCRT_status": "FCRT is evaluated as a finite candidate successor only; no uniform theorem is asserted.",
            "standard_abc": "not proved or disproved by this computation",
        },
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n", encoding="utf-8", newline="\n")
    print(json.dumps({
        "output": str(args.output),
        "structured_csv": str(args.structured_csv),
        "exhaustive_counts": exhaustive["counts"],
        "largest_residual": exhaustive["largest_exact_residual_factor"],
        "largest_fragmentation": exhaustive["largest_exact_fragmentation_factor"],
        "FCRT_largest_fragmentation": exhaustive["FCRT_largest_exact_fragmentation_factor"],
        "structured_rows": len(structured_rows),
    }, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
