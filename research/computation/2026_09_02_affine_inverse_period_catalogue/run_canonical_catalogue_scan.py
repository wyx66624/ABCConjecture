import json
import catalogue_novelty_search as q

cases=[]
keys=['B','C','R','M','N','admissible_selected','exceptional_in_full','classes',
      'singleton_classes','multi_classes','large_labels','repeated_labels',
      'sumD','sumD_singleton_classes','sum_class_tails','sumLT_singleton_classes',
      'W','W1','Wrep','I','E','Esh','E_minus_I','class_pressure',
      'S_non','nonarm_labels','support_cover_exact','support_cover_full',
      'support_cover_capture_rho','support_terms','ratios']
for b,m in [(1,8),(2,30),(3,170),(4,390),(5,388),(6,700)]:
    print(f'RUN B={b} M={m}',flush=True)
    x=q.clean(q.build(b,m))
    cases.append({k:x[k] for k in keys})
totals={
    'parameter_cases':len(cases),
    'admissible_selected':sum(x['admissible_selected'] for x in cases),
    'kernel_classes':sum(x['classes'] for x in cases),
    'large_labels':sum(x['large_labels'] for x in cases),
    'repeated_labels':sum(x['repeated_labels'] for x in cases),
    'nonarm_labels':sum(x['nonarm_labels'] for x in cases),
}
assert totals=={
    'parameter_cases':6,
    'admissible_selected':755322,
    'kernel_classes':3885,
    'large_labels':7641,
    'repeated_labels':631,
    'nonarm_labels':34,
}
print(json.dumps({'schema':'canonical-catalogue-scan-v1','totals':totals,'cases':cases},indent=2))
print('PASS: canonical catalogue identities and support covers in all six cases')

