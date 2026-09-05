#!/usr/bin/env python3
"""Exact multiplicative max-flow and an independently enumerated cut formula.
Capacities are positive rationals >= 1, encoding their logarithms.
No numerical logarithms enter any decision. Not a proof of ABC.
"""
from __future__ import annotations
from collections import deque
from fractions import Fraction as F
from itertools import product
from math import prod
import random


def require(test: bool, message: str) -> None:
    if not test:
        raise AssertionError(message)


def validate(demands, budgets, face_caps):
    r, s = list(map(F, demands)), list(map(F, budgets))
    w = [list(map(F, row)) for row in face_caps]
    if len(w) != len(s) or any(len(row) != len(r) for row in w):
        raise ValueError('Network dimensions do not match')
    if any(x < 1 for x in r + s + [v for row in w for v in row]):
        raise ValueError('Multiplicative capacities must be >= 1')
    return r, s, w


def cut_residual(demands, budgets, face_caps):
    """Enumerate all subsets of demand vertices, not paths or flows."""
    r, s, w = validate(demands, budgets, face_caps)
    best, witness = F(1), 0
    for mask in range(1 << len(r)):
        selected = [i for i in range(len(r)) if mask >> i & 1]
        numerator = prod((r[i] for i in selected), start=F(1))
        denominator = prod((min(s[k], prod((w[k][i] for i in selected), start=F(1)))
                            for k in range(len(s))), start=F(1))
        value = numerator / denominator
        if value > best:
            best, witness = value, mask
    return best, witness


def augmenting_residual(demands, budgets, face_caps):
    """Multiplicative Edmonds--Karp; returns residual, flow factors, iterations."""
    r, s, w = validate(demands, budgets, face_caps)
    K, I = len(s), len(r)
    src, dst, size = K + I, K + I + 1, K + I + 2
    residual = [[F(1) for _ in range(size)] for _ in range(size)]
    neighbors = [[] for _ in range(size)]
    original = []

    def edge(u, v, cap):
        if cap == 1:
            return
        neighbors[u].append(v)
        neighbors[v].append(u)
        residual[u][v] = cap
        original.append((u, v, cap))

    for k in range(K):
        edge(src, k, s[k])
        for i in range(I):
            edge(k, K + i, w[k][i])
    for i in range(I):
        edge(K + i, dst, r[i])
    total, iterations = F(1), 0
    while True:
        parent = [-1] * size
        parent[src] = src
        todo = deque([src])
        while todo and parent[dst] == -1:
            u = todo.popleft()
            for v in neighbors[u]:
                if parent[v] == -1 and residual[u][v] > 1:
                    parent[v] = u
                    todo.append(v)
        if parent[dst] == -1:
            break
        path, v = [], dst
        while v != src:
            u = parent[v]
            path.append((u, v))
            v = u
        alpha = min(residual[u][v] for u, v in path)
        require(alpha > 1, 'Nonpositive augmentation')
        for u, v in path:
            residual[u][v] /= alpha
            residual[v][u] *= alpha
        total *= alpha
        iterations += 1
        if iterations > size * (len(original) + 1) * 2:
            raise RuntimeError('Unexpectedly many shortest augmenting paths')
    incoming, outgoing = [F(1)] * size, [F(1)] * size
    for u, v, cap in original:
        flow = residual[v][u]
        require(1 <= flow <= cap and residual[u][v] * flow == cap,
                'Invalid edge flow')
        outgoing[u] *= flow
        incoming[v] *= flow
    for u in range(K + I):
        require(incoming[u] == outgoing[u], 'Flow conservation failed')
    require(outgoing[src] == incoming[dst] == total, 'Value mismatch')
    factors = [[residual[K + i][k] for i in range(I)] for k in range(K)]
    return prod(r, start=F(1)) / total, factors, iterations


def test_networks(count=5000):
    rng = random.Random(20260905)
    maximum_steps = 0
    strict = 0
    for _ in range(count):
        I, K = rng.randrange(1, 7), rng.randrange(0, 5)
        def cap():
            a, b = rng.randrange(1, 40), rng.randrange(1, 40)
            return F(max(a, b), min(a, b))
        r, s = [cap() for _ in range(I)], [cap() for _ in range(K)]
        w = [[cap() if rng.randrange(3) else F(1) for _ in range(I)] for _ in range(K)]
        expected, _ = cut_residual(r, s, w)
        actual, _, steps = augmenting_residual(r, s, w)
        require(actual == expected, 'Independent cut/augmentation mismatch')
        maximum_steps = max(maximum_steps, steps)
    # s=log4, two edge capacities log2, two demands log2.
    value, factors, _ = augmenting_residual([2, 2], [4], [[2, 2]])
    require(value == 1 and factors == [[F(2), F(2)]], 'Two-output witness failed')
    return {'seed': 20260905, 'random_networks': count,
            'cut_augmenting_agreements': count, 'maximum_augmentations': maximum_steps,
            'abstract_two_output_residual': str(value),
            'abstract_single_output_residual': '2',
            'arithmetic_realizability_of_abstract_witness': 'not asserted'}

if __name__ == '__main__':
    import json
    print(json.dumps(test_networks(), indent=2, sort_keys=True))
