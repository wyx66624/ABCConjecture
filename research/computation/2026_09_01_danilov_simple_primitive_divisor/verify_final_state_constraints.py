#!/usr/bin/env python3
import json,math,sys
from pathlib import Path
sys.set_int_max_str_digits(10000)
base=Path('research/computation/2026_09_01_danilov_recursive_lift')
files=['search_stage0_1m.json','search_stage1_1m.json','search_stage2_1m.json','search_stage3_1m.json','search_stage4_1m.json','search_stage5_1m.json','search_stage6_1m.json','search_stage7_10m.json','search_stage8_10m.json','search_stage9_10m.json','search_stage10_50m.json','search_stage11_50m.json','search_stage12_100m.json','search_stage13_100m.json']
Q0=183205432548847538951714173666260521306741
basef=[11,89,179,199,331,661,1069,9791,39161,68531,474541,1801361]
assert math.prod(basef)==Q0 and len(set(basef))==len(basef)
allp=list(basef); Q=Q0
for fn in files:
 d=json.load(open(base/fn))
 assert int(d['current_Q'])==Q
 ps=[int(x['p']) for x in d['recursive_lift_packets']]
 assert not(set(ps)&set(allp)) and len(ps)==len(set(ps))
 Q*=math.prod(ps)
 assert int(d['batch_next_Q'])==Q
 allp.extend(ps)
final=json.load(open(base/'search_stage13_100m.json'))
Qstar=int(final['current_Q']); assert Qstar==Q
assert len(allp)==638 and len(set(allp))==638 and max(allp)<=100_000_000 and math.prod(allp)==Qstar
n=10*Qstar
assert len(str(Qstar))==4398 and len(str(n))==4399
# all prime divisors q of n are <=1e8 and n > q(q+1), excluding a nonprimitive cyclotomic correction by Yabuta Lemma 1
assert n>100_000_000*100_000_001
# elementary source-table threshold check: log(10)>2.3, hence log(n)>4398*2.3>10036
assert 4398*2.3>10036
out={'status':'PASS','Q_digits':len(str(Qstar)),'n_digits':len(str(n)),'Q_distinct_factors':len(allp),'n_distinct_factors':len(allp)+2,'max_Q_factor':max(allp),'no_nonprimitive_cyclotomic_correction_size_test':True,'hong_kappa_40_source_threshold_n0':10036,'digit_lower_bound_log_n':4398*2.3,'conclusion':'Hong Theorem 1.1 plus the split congruence p = 1 mod n supplies a primitive p >= 41n+1; if no simple primitive divisor exists, that p is WSS'}
print(json.dumps(out,indent=2))
