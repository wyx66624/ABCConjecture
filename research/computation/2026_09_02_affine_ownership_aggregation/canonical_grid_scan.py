from __future__ import annotations

import json
from collections import defaultdict, Counter
from fractions import Fraction
from itertools import combinations, product
from math import gcd

import ownership_aggregation as oa

def canon_line(points):
    (h0,k0),(h1,k1)=points[0],points[1]
    dx,dy=h1-h0,k1-k0;g=gcd(abs(dx),abs(dy));s,t=dx//g,dy//g
    if s<0 or (s==0 and t<0):s,t=-s,-t
    z=t*h0-s*k0
    for h,k in points: assert t*h-s*k==z
    return s,t,z,g

def div3(a,b): return all(y%x==0 for x,y in zip(a,b))
def prod3(a): return a[0]*a[1]*a[2]
def gcd3(a,b): return tuple(gcd(x,y) for x,y in zip(a,b))

def canonical_box(B,M):
    C=B+1;R=1
    for p,_ in oa.factor(B*C):R*=p
    classes=defaultdict(list)
    for h,k in product(range(1,M+1),repeat=2):
        u=1+R*h;v=1+R*(h+C*k);w=1+R*(h+B*k)
        if gcd(u,k)!=1:continue
        assert gcd(u,v)==gcd(u,w)==gcd(v,w)==1
        ker=tuple(oa.powerful_kernel(x) for x in (u,v,w))
        classes[ker].append((h,k))
    return classes

def tail(kernel,N):
    for lab in product(*(oa.divisors(k) for k in kernel)):
        if prod3(lab)>N*N:
            yield lab,oa.phi(lab[0])*oa.phi(lab[1])*oa.phi(lab[2])

def line_coeff(B,C,line):
    s,t,_,_=line
    return s,s+C*t,s+B*t

def qvalue(lab,weight,coeff):
    cap=1
    for d,a in zip(lab,coeff):cap*=gcd(d,abs(a))
    T=prod3(lab)//cap
    return Fraction(weight,T*T),T

def degeneracy(adj):
    rem=set(adj);deg=0
    while rem:
        v=min(rem,key=lambda x:len(adj[x]&rem))
        deg=max(deg,len(adj[v]&rem));rem.remove(v)
    return deg

def exact_minmax_load(vertices,label_support,limit=2_000_000):
    forced={v:Fraction(0) for v in vertices};vars=[];states=1
    for qv,supp in label_support:
        if len(supp)==1: forced[next(iter(supp))]+=qv
        else:
            vars.append((qv,tuple(supp)));states*=len(supp)
            if states>limit:return None,states
    vars.sort(reverse=True,key=lambda z:z[0])
    best=[None]
    loads=forced.copy()
    suffix=[Fraction(0)]*(len(vars)+1)
    for i in range(len(vars)-1,-1,-1):suffix[i]=suffix[i+1]+vars[i][0]
    def dfs(i):
        cur=max(loads.values(),default=Fraction(0))
        if best[0] is not None and cur>=best[0]:return
        if i==len(vars):best[0]=cur;return
        w,supp=vars[i]
        # symmetric equal-load targets need only one branch
        seen=set()
        for v in sorted(supp,key=lambda x:loads[x]):
            if loads[v] in seen:continue
            seen.add(loads[v]);loads[v]+=w;dfs(i+1);loads[v]-=w
    dfs(0)
    return best[0],states

def analyze(B,M,mode):
    classes=canonical_box(B,M);C=B+1;N=M-1
    selected={k:(ps if mode=='full' else [ps[0]]) for k,ps in classes.items()}
    mult={k:len(ps) for k,ps in selected.items()}

    # Global class-tail ledger.
    fibres=defaultdict(lambda:{'classes':[],'n':0,'points':[],'w':0})
    for ker,ps in selected.items():
        for lab,w in tail(ker,N):
            f=fibres[lab];f['classes'].append(ker);f['n']+=len(ps);f['points']+=ps;f['w']=w
    Lt={k:sum(w for _,w in tail(k,N)) for k in selected}
    A0=sum(Lt[k] for k in selected);A1=sum((mult[k]-1)*Lt[k] for k in selected)
    W=sum(f['w'] for f in fibres.values());Omega=A0-W
    Esh=sum(f['w']*(f['n']-1)**3 for f in fibres.values())
    J=A1+Omega
    assert J==sum(f['w']*(f['n']-1) for f in fibres.values())

    # Actual repeated non-arm set against which both owner systems are audited.
    actual={};actual_T={}
    for lab,f in fibres.items():
        if f['n']<2:continue
        pts=sorted(set(f['points']));line=canon_line(pts);coeff=line_coeff(B,C,line)
        if not all(coeff):continue
        qv,T=qvalue(lab,f['w'],coeff);actual[lab]=qv;actual_T[lab]=T
    S=sum(actual.values(),Fraction(0))
    W_non=sum(fibres[lab]['w'] for lab in actual)
    J_non=sum(fibres[lab]['w']*(fibres[lab]['n']-1) for lab in actual)
    E_non=sum(fibres[lab]['w']*(fibres[lab]['n']-1)**3 for lab in actual)
    K=(B+1)*(C+1);c=K*N

    def edge_system(all_pairs):
        """Loops plus either singleton pairs (cover skeleton) or all class pairs."""
        edge_map={}
        def add_edge(top,pts,orig,kind):
            if prod3(top)<=N*N:return
            line=canon_line(pts);coeff=line_coeff(B,C,line)
            if not all(coeff):return
            key=(line[:3],top)
            if key not in edge_map:
                edge_map[key]={'line':line,'top':top,'origins':set(),'pairs':0,
                               'generators':set(),'kinds':set()}
            edge_map[key]['origins'].update(orig);edge_map[key]['pairs']+=1
            edge_map[key]['generators'].add(tuple(sorted(pts[:2])))
            edge_map[key]['kinds'].add(kind)
        for ker,ps in selected.items():
            if len(ps)>=2:add_edge(ker,ps[:2],{ker},'loop')
        items=list(selected.items())
        for (ka,pa),(kb,pb) in combinations(items,2):
            if all_pairs or (len(pa)==len(pb)==1):
                add_edge(gcd3(ka,kb),[pa[0],pb[0]],{ka,kb},'pair')
        return edge_map

    def profile(edge_map,name,require_support_linear):
        # Global coordinate-divisibility maxima.  Any comparable large tops must
        # have the same line because the smaller top itself is a common fibre label.
        es=list(edge_map.values())
        for e,f in combinations(es,2):
            if e['top']!=f['top'] and (div3(e['top'],f['top']) or div3(f['top'],e['top'])):
                assert e['line'][:3]==f['line'][:3]
            if e['top']==f['top']:
                assert e['line'][:3]==f['line'][:3]
        maximal=[e for e in es if not any(
            e['top']!=f['top'] and div3(e['top'],f['top']) for f in es)]
        vids=list(range(len(maximal)))

        catalogues=[];sumQ=Fraction(0);label_to_vids=defaultdict(set);label_q={}
        for i,e in enumerate(maximal):
            coeff=line_coeff(B,C,e['line']);cat=[];Q=Fraction(0)
            for lab,w in tail(e['top'],N):
                qv,T=qvalue(lab,w,coeff);cat.append((lab,qv,T));Q+=qv
                label_to_vids[lab].add(i)
                if lab in label_q:assert label_q[lab]==qv
                label_q[lab]=qv
            e['Q']=Q;e['catalogue_labels']=len(cat);catalogues.append(cat);sumQ+=Q

        assert set(actual)==set(label_q)
        assert all(actual[x]==label_q[x] for x in actual)

        top_support={i:set() for i in vids}
        for i,e in enumerate(maximal):
            top_support[i]={ker for ker in selected if div3(e['top'],ker)}
            for ker in top_support[i]:
                s,t,z=e['line'][:3]
                assert all(t*h-s*k==z for h,k in selected[ker])
        support_intersections=[]
        for i,j in combinations(vids,2):
            q=top_support[i]&top_support[j]
            support_intersections.append((len(q),i,j,q))
            if require_support_linear: assert len(q)<=1
        perclass=Counter();class_vids=defaultdict(list)
        for i in vids:
            for ker in top_support[i]:
                perclass[ker]+=1;class_vids[ker].append(i)
        perdirection=Counter((e['line'][0],e['line'][1]) for e in maximal)
        perline=Counter(e['line'][:3] for e in maximal)

        # Catalogue-overlap graph and exact owner load.
        adj={i:set() for i in vids}
        for i,j in combinations(vids,2):
            if prod3(gcd3(maximal[i]['top'],maximal[j]['top']))>N*N:
                assert maximal[i]['line'][:3]==maximal[j]['line'][:3]
                adj[i].add(j);adj[j].add(i)
        rtop=max((len(v) for v in label_to_vids.values()),default=0)
        label_support=[(label_q[l],v) for l,v in label_to_vids.items()]
        opt,states=exact_minmax_load(vids,label_support)
        # Every maximal top containing a label is injected into a distinct
        # support pair for that label, so full-catalogue multiplicity is paid
        # by the non-arm cubic energy (Proposition 4.4 of the report).
        assert S<=sumQ<=E_non<=Esh
        H3=Fraction(0)
        for i,e in enumerate(maximal):
            rp=sum(len(selected[ker]) for ker in top_support[i])
            assert rp>=2
            e['support_points']=rp
            e['weight']=oa.phi(e['top'][0])*oa.phi(e['top'][1])*oa.phi(e['top'][2])
            e['beta']=e['Q']/e['weight']
            H3 += e['Q']/((rp-1)**3)
        if S:
            assert S*S<=E_non*H3
            assert S<c*H3
            assert E_non<c*c*H3
        theta=Fraction(J,W) if W else Fraction(0)
        normalized=Fraction(c*c)*H3*W*W/(J**3) if J else None

        return {
          'name':name,'raw_distinct_tops':len(edge_map),'maximal_tops':len(maximal),
          'lines_with_tops':len(perline),'directions_with_tops':len(perdirection),
          'max_tops_per_line':max(perline.values(),default=0),
          'max_tops_per_direction':max(perdirection.values(),default=0),
          'max_tops_contained_in_one_class':max(perclass.values(),default=0),
          'max_support_intersection':max((x[0] for x in support_intersections),default=0),
          'sum_Q_maximal':str(sumQ),'sumQ_over_S':str(sumQ/S) if S else None,
          'sumQ_over_A0':str(sumQ/A0) if A0 else None,
          'sumQ_over_A1':str(sumQ/A1) if A1 else None,
          'sumQ_over_Omega':str(sumQ/Omega) if Omega else None,
          'sumQ_over_J':str(sumQ/J) if J else None,
          'sumQ_over_Enon':str(sumQ/E_non) if E_non else None,
          'sumQ_over_Esh':str(sumQ/Esh) if Esh else None,
          'H3':str(H3),'H3_over_W':str(H3/W) if W else None,
          'H3_over_J':str(H3/J) if J else None,
          'normalized_c2H3_over_theta3W':str(normalized) if normalized is not None else None,
          'max_beta':str(max((e['beta'] for e in maximal),default=Fraction(0))),
          'S2_le_Enon_H3':S*S<=E_non*H3,
          'S_lt_cH3':(S<c*H3) if S else True,
          'Enon_lt_c2H3':(E_non<c*c*H3) if S else True,
          'max_tops_per_label':rtop,'overlap_graph_edges':sum(map(len,adj.values()))//2,
          'overlap_graph_degeneracy':degeneracy(adj),
          'exact_owner_minmax_load':str(opt) if opt is not None else None,
          'owner_assignment_states':states,
          'tops':[{'top':e['top'],'line':e['line'][:3],'Q':str(e['Q']),
                   'weight':e['weight'],'beta':str(e['beta']),
                   'labels':e['catalogue_labels'],'coeff':line_coeff(B,C,e['line']),
                   'catalogue':[(lab,str(qv),T) for lab,qv,T in catalogues[i]],
                   'support_classes':len(top_support[i]),'support_points':e['support_points'],
                   'support_kernels':[{'kernel':k,'points':selected[k]}
                                      for k in sorted(top_support[i])],
                   'origin_classes':len(e['origins']),'origin_kernels':sorted(e['origins']),
                   'generator_pairs':sorted(e['generators']),'kinds':sorted(e['kinds'])}
                  for i,e in enumerate(maximal)],
          'classes_in_multiple_tops':[
              {'kernel':k,'points':selected[k],'top_ids':class_vids[k]}
              for k in sorted(class_vids) if len(class_vids[k])>=2],
          'labels_in_multiple_tops':[
              {'label':lab,'q':str(label_q[lab]),'top_ids':sorted(vs),
               'occupancy':fibres[lab]['n'],'points':fibres[lab]['points']}
              for lab,vs in sorted(label_to_vids.items()) if len(vs)>=2],
          'largest_support_intersections':[
              {'size':z,'top_ids':[i,j],'kernels':sorted(q)}
              for z,i,j,q in sorted(support_intersections,reverse=True)[:5] if z],
        }

    skeleton=profile(edge_system(False),'reduced_cover_skeleton',False)
    all_pair=profile(edge_system(True),'all_pair_global_divisibility_maximal',True)
    return {
      'B':B,'C':C,'M':M,'N':N,'mode':mode,'points':sum(mult.values()),
      'classes':len(selected),'A0':A0,'A1':A1,'W':W,'Omega':Omega,'J':J,
      'theta':str(Fraction(J,W)) if W else None,
      'W_non':W_non,'J_non':J_non,'E_non':E_non,'Esh':Esh,'K':K,'c':c,
      'S_non':str(S),'skeleton':skeleton,'all_pair':all_pair,
    }

def brief(r,p):
    return {
      'B':r['B'],'M':r['M'],'N':r['N'],'mode':r['mode'],'points':r['points'],
      'classes':r['classes'],'A0':r['A0'],'A1':r['A1'],'W':r['W'],
      'Omega':r['Omega'],'J':r['J'],'E_non':r['E_non'],'Esh':r['Esh'],
      'K':r['K'],'c':r['c'],'S_non':r['S_non'],
      **{k:p[k] for k in [
        'raw_distinct_tops','maximal_tops','lines_with_tops','directions_with_tops',
        'max_tops_per_line','max_tops_per_direction','max_tops_contained_in_one_class',
        'max_support_intersection','sum_Q_maximal','sumQ_over_S','sumQ_over_A0',
        'sumQ_over_A1','sumQ_over_Omega','sumQ_over_J','sumQ_over_Enon',
        'sumQ_over_Esh',
        'H3','H3_over_W','H3_over_J','normalized_c2H3_over_theta3W','max_beta',
        'max_tops_per_label','overlap_graph_edges','overlap_graph_degeneracy',
        'exact_owner_minmax_load','owner_assignment_states','tops',
        'classes_in_multiple_tops','labels_in_multiple_tops',
        'largest_support_intersections']}
    }

def main():
    Bs=range(1,13)
    Ms=list(range(3,81))+[90,100,120,140,160,180,200,225,250,254,300,350,388,400]
    modes=('full','singleton')
    first={};maxima={};errors=[];nonzero=0;systems_equal=0
    predicates={
      'two_tops':lambda p,r:p['maximal_tops']>=2,
      'two_same_line':lambda p,r:p['max_tops_per_line']>=2,
      'two_same_direction':lambda p,r:p['max_tops_per_direction']>=2,
      'class_in_two_tops':lambda p,r:p['max_tops_contained_in_one_class']>=2,
      'label_in_two_tops':lambda p,r:p['max_tops_per_label']>=2,
      'overlap_edge':lambda p,r:p['overlap_graph_edges']>=1,
      'degeneracy_two':lambda p,r:p['overlap_graph_degeneracy']>=2,
      'sumQ_gt_A0':lambda p,r:Fraction(p['sum_Q_maximal'])>r['A0'],
      'sumQ_gt_A1':lambda p,r:r['A1'] and Fraction(p['sum_Q_maximal'])>r['A1'],
      'sumQ_gt_Omega':lambda p,r:r['Omega'] and Fraction(p['sum_Q_maximal'])>r['Omega'],
      'sumQ_gt_J':lambda p,r:r['J'] and Fraction(p['sum_Q_maximal'])>r['J'],
      'sumQ_eq_Esh':lambda p,r:r['Esh'] and Fraction(p['sum_Q_maximal'])==r['Esh'],
      'beta_gt_1':lambda p,r:Fraction(p['max_beta'])>1,
      'beta_gt_2':lambda p,r:Fraction(p['max_beta'])>2,
    }
    metric_names=['maximal_tops','max_tops_per_line','max_tops_per_direction',
      'max_tops_contained_in_one_class','max_support_intersection','max_tops_per_label',
      'overlap_graph_edges','overlap_graph_degeneracy']
    ratio_names=['sumQ_over_S','sumQ_over_A0','sumQ_over_A1','sumQ_over_Omega',
      'sumQ_over_J','sumQ_over_Enon','sumQ_over_Esh','H3_over_W','H3_over_J',
      'normalized_c2H3_over_theta3W','max_beta']

    for B in Bs:
      for M in Ms:
        for mode in modes:
          try:
            r=analyze(B,M,mode);p=r['all_pair'];s=r['skeleton']
            sig=lambda z:sorted((tuple(x['top']),tuple(x['line'])) for x in z['tops'])
            assert sig(p)==sig(s)
            assert p['sum_Q_maximal']==s['sum_Q_maximal'] and p['H3']==s['H3']
            systems_equal+=1
          except Exception as exc:
            errors.append((B,M,mode,type(exc).__name__,str(exc)));continue
          if p['maximal_tops']:nonzero+=1
          key0=(M,B,0 if mode=='full' else 1)
          for name,pred in predicates.items():
            if pred(p,r) and (name not in first or key0<first[name][0]):first[name]=(key0,r,p)
          for name in metric_names:
            key=(p[name],-M,-B,1 if mode=='full' else 0)
            if name not in maxima or key>maxima[name][0]:maxima[name]=(key,r,p)
          for name in ratio_names:
            if p[name] is None:continue
            key=(Fraction(p[name]),-M,-B,1 if mode=='full' else 0)
            if name not in maxima or key>maxima[name][0]:maxima[name]=(key,r,p)
      print('DONE B',B,flush=True)

    directed=[]
    for B,M in [(351,2),(55123,3)]:
      r=analyze(B,M,'full');directed.append(brief(r,r['all_pair']))
    assert directed[0]['max_beta']=='6/5'
    assert directed[1]['max_beta']=='9187/4200'
    cases=len(list(Bs))*len(Ms)*len(modes)
    out={
      'status':'PASS' if not errors and systems_equal==cases else 'FAIL',
      'scan':{'B':[1,12],'M_values':Ms,'modes':modes,'cases':cases,
              'nonzero_top_cases':nonzero,'errors':errors,
              'exact_skeleton_all_pair_maximal_system_equalities':systems_equal},
      'first_hits_ordered_by_M_then_B':{k:brief(v[1],v[2]) for k,v in first.items()},
      'finite_no_hits':[name for name in predicates if name not in first],
      'maxima':{k:{'value':str(v[0][0]),'case':brief(v[1],v[2])} for k,v in maxima.items()},
      'directed_beta_witnesses':directed,
      'scope_note':'Finite no-hit entries are observations, not proofs.',
    }
    print('RESULT_JSON');print(json.dumps(out,indent=2,default=str))

if __name__=='__main__':main()
