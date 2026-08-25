# Frey 实周期—超几何—AGM 路线：正规化、高度守恒与严格边界

## 1. 结论

考虑 primitive 正整数三元组

```text
a+b=c,    gcd(a,b)=gcd(a,c)=gcd(b,c)=1
```

和 Frey 曲线

```text
E : y^2=x(x-a)(x+b).
```

本轮对“实周期→超几何函数→Landen/AGM→G-function/Padé”路线得到了一个完整审计，但没有得到 abc 证明。

经过固定周期与微分的约定，原始实周期确实是

```text
Omega+ = 2 c^(-1/2) K(sqrt(b/c))
       = pi c^(-1/2) 2F1(1/2,1/2;1;b/c)
       = pi / AGM(sqrt(c),sqrt(a)).                 (1.1)
```

互补的虚周期绝对值把 `b/c` 换成 `a/c`。这解释了公式中 `sqrt(a/c)` 或 `sqrt(b/c)` 的来源：它们不是可以混用的同一参数，而是互补模数。

关键负结论是：

1. 第一次下降 Landen 变换虽然在选定实嵌入中收缩，但其新的符号共轭精确地把它变成倒数；
2. 一次 Landen 参数的绝对高度仍是 `(1/2) log c+O(1)`，而次数通常是 `2`，所以“次数 × 高度”保留 `log c` 的主项；
3. 即使仅看扩张的 reduced ramification support，幂次也会转移到二次序的 index/conductor；
4. 超几何参数 `b/c` 的绝对 Weil 高度精确是 `log c`，而非 `log rad(abc)`；在一个显式 primitive 族上，连级数的一次项已经有完整分母 `4c`；
5. 真正能导出 abc 的新桥必须是临界指数 `1/2` 的 **radical-sensitive 周期下界**。这正是 Goldfeld 的 period-conjecture 强度，不是经典 AGM 恒等式或一般 G-function 性质的结论。

因此，该路线不应被称为“已证 abc”。它的有效产出是两个可复用的严格障碍：**Landen 共轭—index 守恒**和 **hypergeometric specialization-height 障碍**。

## 2. 实周期的正规化

令

```text
f(x)=x(x-a)(x+b),       omega=dx/(2y).
```

`E(R)` 有两个连通分支。取穿过无界分支的正向闭路，由上、下两张 sheet 各走一次可得

```text
Omega+ = integral_a^infinity dx/sqrt(f(x)).          (2.1)
```

置

```text
x=a/(1-t^2),       0<=t<1.
```

则

```text
dx=2at(1-t^2)^(-2)dt,

f(x)=a^2 c t^2 (1-(b/c)t^2)(1-t^2)^(-3).
```

因而

```text
Omega+
=2/sqrt(c) integral_0^1 dt /
  sqrt((1-t^2)(1-(b/c)t^2))
=2/sqrt(c) K(sqrt(b/c)).                              (2.2)
```

在有界分支 `[-b,0]` 上令 `x=-b+bt^2`，得到同一数值；这也可以由有理二扭点的平移看出。中间区间 `[0,a]` 给出互补的虚周期，其绝对值是

```text
2/sqrt(c) K(sqrt(a/c)).                               (2.3)
```

必须区分三种常用约定：

- `(2.2)` 是 Néron 微分 `dx/(2y)` 的 primitive positive lattice period；
- 若用 `dx/y`，数值再乘 `2`；
- 若把 `integral_{E(R)} |omega|` 定义为实体积，因为本曲线有两个实连通分支，还要再乘一个 `2`。

任何周期—导子公式都必须先声明用的是哪一种。本文以 `(2.2)` 为 `Omega+`。

## 3. 超几何与 AGM 恒等式

完全椭圆积分第一类的级数是

```text
K(k)=pi/2 sum_{n>=0} ((1/2)_n/n!)^2 k^(2n)
    =pi/2 2F1(1/2,1/2;1;k^2).                       (3.1)
```

因此，取 `z=b/c`，

```text
Omega+=pi/sqrt(c) 2F1(1/2,1/2;1;z).                (3.2)
```

Gauss 的 AGM 恒等式给出

```text
K(k)=pi/[2 AGM(1,sqrt(1-k^2))].                     (3.3)
```

用 `1-k^2=a/c` 和 AGM 的齐次性，得

```text
Omega+=pi/[sqrt(c) AGM(1,sqrt(a/c))]
      =pi/AGM(sqrt(c),sqrt(a)).                     (3.4)
```

这些都是经典恒等式。DLMF 的 [完全椭圆积分级数](https://dlmf.nist.gov/19.5.E1)、[AGM 与二次变换](https://dlmf.nist.gov/19.8) 和 [Gauss 超几何级数](https://dlmf.nist.gov/15.2.E1) 给出了相同规范。它们本身没有 conductor 或 radical 上界。

## 4. 第一 Landen 步：收缩与共轭精确守恒

令

```text
r=sqrt(a/c),
t=(1-r)/(1+r)=(sqrt(c)-sqrt(a))/(sqrt(c)+sqrt(a)).   (4.1)
```

下降 Gauss--Landen 公式是

```text
K(sqrt(b/c))=2 sqrt(c)/(sqrt(c)+sqrt(a)) K(t),

Omega+=4/(sqrt(c)+sqrt(a)) K(t).                    (4.2)
```

置 `s=sqrt(ac)`。有理化 `(4.1)` 给出

```text
t=(a+c-2s)/b,
t^sigma=(a+c+2s)/b=t^(-1),                          (4.3)
```

因为

```text
(a+c-2s)(a+c+2s)=b^2.                              (4.4)
```

故 `t` 满足

```text
b T^2-2(a+c)T+b=0,                                 (4.5)

disc_T=4(a+c)^2-4b^2=16ac.                         (4.6)
```

这是本轮的第一个核心守恒律：选定实嵌入下 `0<t<1`，但二次扩张的另一嵌入精确给出 `t^(-1)>1`。所以只使用实嵌入中的收缩会遗漏整个共轭成本。

## 5. 绝对高度没有下降

设 `ac` 不是平方数。由 primitive 性，

```text
g=gcd(b,2(a+c))=gcd(b,4) in {1,2,4}.               (5.1)
```

因此 `(4.5)` 除以 `g` 后就是 `t` 的 primitive irreducible 最小多项式。其两根是 `t,t^(-1)`，于是 Mahler measure 为

```text
M(t)=(b/g)t^(-1)
    =(a+c+2sqrt(ac))/g
    =(sqrt(a)+sqrt(c))^2/g.                         (5.2)
```

绝对对数 Weil 高度精确是

```text
h(t)=1/2 log((a+c+2sqrt(ac))/g).                    (5.3)
```

因为 `1<=g<=4`、`0<a<c`，

```text
c/4 < (a+c+2sqrt(ac))/g < 4c,
```

所以

```text
1/2 log c-log 2 < h(t) < 1/2 log c+log 2.          (5.4)
```

特别地，通常 `[Q(t):Q]=2`，并且

```text
[Q(t):Q] h(t)=log c+O(1).                          (5.5)
```

初始根式 `sqrt(a/c)` 的高度本来也是 `(1/2)log c`。Landen 的实收缩没有产生新的全局高度收缩。

若 `ac` 是平方，由 `gcd(a,c)=1` 可写成 `a=A^2,c=C^2`。此时

```text
t=(C-A)/(C+A),
gcd(C-A,C+A) divides 2.
```

约分后同样有

```text
1/2 log c-log 2 <= h(t) < 1/2 log c+log 2.         (5.6)
```

因此平方特例也不提供 uniform 的系数收益。

一个完全量词化的 no-go 是：

> 对任意 `theta<1/2` 和任意常数 `C0`，存在 primitive 三元组使 `h(t)>theta log c+C0`。

证明只需在下节的 `(n,1,n+1)` 族上令 `n` 足够大，再用 `(5.4)`。因此不存在系数小于 `1/2` 的 uniform 第一步 Landen 高度上界。

## 6. 显式族：实精度、二次共轭与 order index

取

```text
(a,b,c)=(n,1,n+1),       n>=1.                    (6.1)
```

这始终是 primitive Frey 三元组。此时

```text
t=(sqrt(n+1)-sqrt(n))/(sqrt(n+1)+sqrt(n))
 =1/(sqrt(n+1)+sqrt(n))^2,                         (6.2)

T^2-2(2n+1)T+1=0.                                 (6.3)
```

而且

```text
4n+1 < (sqrt(n+1)+sqrt(n))^2 < 4n+2,

1/(4n+2) < t < 1/(4n+1).                          (6.4)
```

`n(n+1)` 不是平方：否则由相邻两数互素，`n` 和 `n+1` 都必须是平方，但两个正平方不可能相差 `1`。因此 `(6.3)` 不可约，并且

```text
2h(t)=log(t^(-1))
     =log((sqrt(n+1)+sqrt(n))^2)
     =log n+O(1).                                  (6.5)
```

这是“二次收敛与共轭成本精确对消”的显式无穷族。

现在固定奇素数 `p=3`，取

```text
n=3^(2(m+1)).                                      (6.6)
```

则 `t` 是二次整单位，

```text
disc(Z[t])=16 n(n+1)
           =16*3^(2(m+1))*(3^(2(m+1))+1),          (6.7)

v_3(disc(Z[t]))=2(m+1).                            (6.8)
```

但

```text
Q(t)=Q(sqrt(n(n+1)))=Q(sqrt(n+1)),                 (6.9)
```

且 `3` 不整除 `n+1`，所以该二次域在 `3` 处不分歧。序判别式公式

```text
disc(Z[t])=[O_K:Z[t]]^2 disc(O_K)                  (6.10)
```

因而给出

```text
v_3([O_K:Z[t]])=m+1.                               (6.11)
```

这是严格的 local no-go：

> 对每个 `B`，存在 `m`，使扩张域在 `3` 处仍然不分歧，但 `v_3([O_K:Z[t]])>B`。

所以“只保留扩张域的 reduced ramification support”不能控制 Landen 算术复杂度。被删掉的幂次并没有消失，而是精确地进入了 order index。

## 7. 迭代 AGM 的精确守恒

从

```text
A_0=sqrt(c),      G_0=sqrt(a)
```

开始，令

```text
A_(j+1)=(A_j+G_j)/2,
G_(j+1)=sqrt(A_j G_j).                              (7.1)
```

经典 AGM 不变性是

```text
AGM(A_j,G_j)=AGM(sqrt(c),sqrt(a)).                  (7.2)
```

为了观察二次收敛，选择 `u_j^2=A_j`、`v_j^2=G_j`。则

```text
(A_(j+1)-G_(j+1))/(A_(j+1)+G_(j+1))
=((u_j-v_j)/(u_j+v_j))^2.                          (7.3)
```

这就是实嵌入中误差的平方。但产生 `(7.3)` 的同一新根式符号变换 `v_j mapsto -v_j` 给出

```text
(u_j-v_j)/(u_j+v_j)  mapsto
(u_j+v_j)/(u_j-v_j).                               (7.4)
```

即取倒数。对任意代数数 `q` 和包含这两个嵌入的数域 `L`，高度定义直接给出

```text
-log |q| <= [L:Q] h(q)       if 0<|q|<1 and q^sigma=q^(-1).   (7.5)
```

因此 AGM 的实二次收敛不是免费的算术高度下降：

- 若新平方根产生真的二次扩张，则共轭次数增长并且 `(7.5)` 偿还实收缩；
- 若新根式已在原域中，则不增加次数，但根式的原有高度/分母成本仍在；
- 即使额外假设整个塔的分歧素数集可控，`(6.11)` 也表明 order conductor 的指数仍然可以无界。

本文不声称对任意选根的无穷 AGM 塔已证明统一的 `S`-整性定理。更强的事实是：即使把“没有新 reduced support”当作有利假设，上述次数—高度—index 守恒仍足以阻止从经典 Landen 恒等式直接获得 radical 系数收益。

## 8. G-function/Padé 为什么重新看到 `c`

由 `(3.1)`，

```text
2F1(1/2,1/2;1;z)
=sum_{j>=0} binom(2j,j)^2 z^j/16^j
=1+z/4+9z^2/64+... .                               (8.1)
```

对 Frey 参数 `z=b/c`，由 `gcd(b,c)=1`有

```text
h(z)=log max(b,c)=log c.                            (8.2)
```

这不只是一个粗糙上界，而是精确 Weil 高度。在显式族 `(6.1)` 上，`z=1/(n+1)`，所以 `(8.1)` 的第一个非常数项就是

```text
z/4=1/[4(n+1)],                                    (8.3)
```

已经是最简分数。于是

> 对每个 `B`，存在 primitive Frey 三元组，使超几何级数线性项的分母大于 `B`。

更高次项在评估 `z=b/c` 时自然带有 `c^j`。Padé 组合可以在特定次数间产生消去，但一般 G-function 定义只控制级数系数的分母增长，并不把评估点的高度 `(8.2)` 替换成 radical。Fischler--Rivoal 的 [G-function 值论文](https://ems.press/journals/cmh/articles/12624) 确认椭圆积分与有理参数超几何值处在 G-function 框架内；该框架没有包含本文所需的 radical-sensitive specialization 定理。

严格限定是：`(8.3)` 不反驳所有可想象的、特别为 Frey 族设计的 Padé 组合。它反驳的是“标准 G-function 分母控制已经自动变成 radical 控制”。若存在跨阶的 Frey-specific 消去定理，它必须作为新的主定理单独证明。

## 9. 真正足够的周期桥，以及它的精确系数

记

```text
H=log c,
R=log rad(abc),
Q=log(2K(sqrt(b/c))),
P=-log Omega+.
```

由 `(1.1)` 精确有

```text
P=H/2-Q.                                            (9.1)
```

对 `k'=sqrt(a/c)`，把 `K` 的 `tan`-积分在 `1`和 `1/k'` 处分段，得到一个足够的初等上界

```text
K(sqrt(b/c)) <= 2+log(1/k')
              <= 2+(1/2)log c.                     (9.2)
```

因此

```text
Q=O(log(2+log c)),                                 (9.3)
```

并且对每个 `delta>0`都存在 `B_delta`，使

```text
Q <= delta H+B_delta.                              (9.4)
```

现在把真正缺失的 period/radical 输入明写为

```text
P <= (1/2+eta) R+C_eta.                            (9.5)
```

它等价于

```text
Omega+ >= exp(-C_eta) rad(abc)^(-1/2-eta).         (9.6)
```

把 `(9.1)`、`(9.4)`、`(9.5)` 相加不需要任何椭圆曲线理论，只得到精确标量预算

```text
(1-2delta)H
<= (1+2eta)R+2(C_eta+B_delta).                     (9.7)
```

给定目标 `epsilon>0`，例如取

```text
eta=epsilon/8,
delta=epsilon/[8(1+epsilon)],                      (9.8)
```

则

```text
(1+2eta)/(1-2delta) <= 1+epsilon.                  (9.9)
```

于是 `(9.5)` 在全称量词下导出

```text
log c <= (1+epsilon) log rad(abc)+O_epsilon(1).    (9.10)
```

对 Frey 曲线，真实 conductor 与 `rad(abc)` 只相差有界的 `2`-进制因子，所以用 conductor 改写 `(9.6)` 只改变常数。Goldfeld 在 1988 年提出的 period conjecture 正是对 Frey 曲线要求 `N^(-1/2-eta)` 级别的周期下界；可参见他的[ABC、模形式与椭圆曲线讲义第 7 页](https://www.math.columbia.edu/~goldfeld/ABC-Conjecture)。

这给出了本路线的精确逻辑边界：

- `(1.1)`--`(4.6)` 是经典、无条件的周期/AGM/Landen 恒等式；
- `(5.3)`--`(8.3)` 是无条件的代数高度和分母记账；
- `(9.4)` 是初等的 archimedean 次线性误差吸收；
- `(9.5)` 是未证的 abc-strength 输入，绝不能从 AGM 计算速度或普通 G-function 性质中省略。

## 10. 封版结论与仍存的创新点

已被严格排除的版本是：

```text
“AGM 二次收敛”
  + “扩张只在有限个坏素数处分歧”
  + “一般 G-function/Padé 分母增长”
  => radical 系数 `1+epsilon`.
```

失败原因不是模糊的“常数太大”，而是三个精确守恒：

```text
real contraction  <-> reciprocal conjugate,
reduced ramification <-> order index/conductor,
hypergeometric argument <-> full height log c.
```

仍然可能的 genuinely new bridge 必须同时使用不同坏素数之间的信息，并且证明一个形如 `(9.6)` 的 radical-sensitive 周期下界。可以继续试验的方向包括：

1. 同时结合 archimedean 超几何解和所有 `p`-进 unit-root 解的 adelic Padé 行列式，并对高幂消去做 **truncated** 而非 full-height 估计；
2. 找到 Frey-specific 的正系数超几何/模符号生成函数，避免一般模符号中的大量符号消去；
3. 对 Landen 塔的 order index 与不同坏素数的分解行为建立一个全局 repulsion 定理。

但这三项目前都是研究目标，不是本轮已证结果。特别是，任何完成 `(9.6)` 的论证都必须接受 abc 级别的独立审查。

## 11. Lean 边界

Lean 文件

```text
IUTThreeClosures/FreyRealPeriodAGMBarrier.lean
```

只形式化了不循环的核心：

- Landen 比率的倒数共轭和二次方程；
- 判别式 `16ac`；
- AGM normalized gap 精确是 Landen 比率的平方；
- `(n,1,n+1)` 族上的精确 reciprocal-square 成本；
- 固定素数 `3` 的 order-discriminant 深度无界；
- `b/c` 的实际 Weil 高度等于 abc 高度；
- 相邻族的超几何线性项分母精确为 `4c`；
- period/radical 下界与次线性 kernel 的精确标量系数。

Lean 文件没有形式化实积分、椭圆积分特殊函数、AGM 收敛、数域绝对高度、二次序的 index 公式、G-function/Padé 定理、真实 Frey conductor，也没有形式化 Goldfeld period conjecture 或 abc 猜想。标量桥的困难输入始终显式出现在定理前提中。
