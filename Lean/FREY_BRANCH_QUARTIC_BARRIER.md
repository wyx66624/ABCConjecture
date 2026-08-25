# Frey 四分支二元四次式：精确不变量、稳定边界与 radical 障碍

## 1. 结论

考虑 primitive 正整数三元组

```text
a+b=c,     gcd(a,b)=gcd(a,c)=gcd(b,c)=1
```

以及 Frey 双覆盖的四个分支点

```text
{infinity, 0, a, -b}.
```

对应二元四次式取为

```text
F(X,Z)=Z X (X-aZ)(X+bZ).
```

本轮得到一个完整的否定性审计，而不是 abc 证明：

1. `F` 的 `I,J` 只是 Frey 曲线 `c4,c6` 的经典重写；
2. primitive 情形下 `I` 在每个 `p|abc` 处都是单位，所以当前模型已经局部最小，`PGL2`/GIT 最小化不能删掉高重数；
3. 有标号稳定边界保留接触深度 `e_p`，无序四次式判别除子保留 `2e_p`，只有把 base 上的 pullback 人为取 reduced 才变成一次；
4. 固定素数的实际 primitive Frey 无限族严格否定任何仅依赖 reduced 特殊纤维或 mod-`p` GIT orbit 的局部上界；
5. 若改用全局 GIT/stable height 对 truncated boundary 作所需上界，就回到了 `P^1-{0,1,infinity}` 上的 abc/Vojta；若直接控制 branch discriminant，则所需系数精确等价于 slope-six Szpiro 型输入。

因此，这条路线没有产生新的 radical-level 上界。它确实把障碍定位得更精确：待控量是粗 GIT cusp 的高阶接触，或等价地是

```text
J^2 congruent to 4 I^3
```

在坏素数处的异常高阶消去；它不是模型的 common content，也不是 reduced special fiber 能看见的数据。

配套 Lean 文件只形式化无循环的代数和算术核心，不把 GIT、稳定模型或最小化写成公理。

## 2. 三套判别式约定必须分开

采用非二项式系数约定

```text
f=alpha X^4+beta X^3 Z+gamma X^2 Z^2+delta X Z^3+epsilon Z^4.
```

经典不变量是

```text
I=12 alpha epsilon-3 beta delta+gamma^2,

J=72 alpha gamma epsilon-27 alpha delta^2-27 beta^2 epsilon
  +9 beta gamma delta-2 gamma^3.
```

对本轮的 `F`，系数为

```text
(alpha,beta,gamma,delta,epsilon)=(0,1,b-a,-ab,0).
```

直接展开得到

```text
I=a^2+ab+b^2=c^2-ab,                              (2.1)

J=(a-b)(2a+b)(a+2b),                              (2.2)

4I^3-J^2=27 a^2 b^2 c^2.                          (2.3)
```

必须区分：

```text
D_br  = (4I^3-J^2)/27 = a^2 b^2 c^2,              (2.4)

Delta_E = 16 D_br,                                 (2.5)

4I^3-J^2 = 27 D_br.                                (2.6)
```

`D_br` 是四条分支直线的 determinant-product discriminant。`Delta_E` 是双覆盖

```text
y^2=x(x-a)(x+b)
```

的 displayed genus-one/elliptic discriminant。在这一约定下

```text
c4=16I,     c6=32J,

j=256 I^3/D_br.                                    (2.7)
```

把 `(2.4)`、`(2.5)` 和未除以 `27` 的 `(2.6)` 都写成 `Delta` 会造成局部次数差 `2`、`16` 或 `27` 的错误。Cremona--Fisher--Stoll 的二元四次式规范和最小化群作用可见其[原论文](https://msp.org/ant/2010/4-6/ant-v4-n6-p05-s.pdf)。

## 3. cross-ratio 与三个局部 cluster

取有标号 cross-ratio

```text
lambda=cr(infinity,0;a,-b)=-b/a.                   (3.1)
```

于是

```text
1-lambda=c/a,       1/lambda=-a/b.                 (3.2)
```

标号置换给出六个 anharmonic 变换

```text
-b/a, c/a, -a/b, a/c, b/c, c/b.
```

它们只是在 `0,1,infinity` 三个 cusp 之间换名，不改变接触深度。并且

```text
j(lambda)=256(1-lambda+lambda^2)^3 /
          (lambda^2(1-lambda)^2).                  (3.3)
```

设 `p|abc`，`e=v_p(abc)`。primitive 性保证 `p` 只整除 `a,b,c` 中的一个。局部 cluster 表为

| 条件 | 唯一 twin cluster | 稳定边界参数 | 深度 |
|---|---|---|---|
| `p|a` | `{0,a}` | `1/lambda=-a/b` | `e` |
| `p|b` | `{0,-b}` | `lambda=-b/a` | `e` |
| `p|c` | `{a,-b}` | `1-lambda=c/a` | `e` |

其余两两差都是单位。因此

```text
v_p(D_br)=2e.                                       (3.4)
```

这不是估计，而是完整的局部 cluster picture。

## 4. 当前 integral quartic 已经最小

令

```text
I_N(a,b)=a^2+ab+b^2.
```

若 `gcd(a,b)=1`，则

```text
gcd(I_N,a)=gcd(I_N,b)=gcd(I_N,a+b)=1,              (4.1)

gcd(I_N,abc)=1.                                    (4.2)
```

例如模 `a` 有 `I_N congruent b^2`，模 `b` 有 `I_N congruent a^2`，模 `a+b` 仍可写成 `b^2` 加上 `a+b` 的倍数。故每个 `p|abc` 都满足

```text
v_p(I)=0.                                           (4.3)
```

在放大的 branch-form `K^times times GL_2(K)` 作用中，若

```text
F'=s (F circle M),       M in GL_2(K),
```

则经典权重公式是

```text
I'=s^2(det M)^4 I,
J'=s^3(det M)^6 J,
D'_br=s^6(det M)^12 D_br.                          (4.4)
```

置

```text
r=s(det M)^2.
```

则 `(I',J',D')=(r^2I,r^3J,r^6D)`。如果 `F'` 仍 integral，`I'` 也 integral。由 `(4.3)` 得

```text
2v_p(r)=v_p(I') >= 0,
```

所以 `v_p(r)>=0`，进而

```text
v_p(D'_br)>=v_p(D_br)=2e.                           (4.5)
```

原模型达到等号。这证明在普通 integral binary-quartic 等价类中，它已经在每个 branch-bad prime 处最小。非幺正 `PGL2` 变换可以把碰撞的一对根搬到别处，却不能降低 cross-ratio 的 cusp 接触。

标准 genus-one binary-quartic 的 `K`-等价把 scalar 限制为 `s=mu^2`。上面的论证刻意对更大的任意 scalar 作用成立，因而当然也覆盖这个标准子群；这里没有借扩大等价关系来增强最小性结论。

奇素数处 `J` 也为单位，并且 Frey Weierstrass 模型是乘法型 `I_(2e)`。素数 `2` 处 binary quartic 的 `(4.5)` 仍由 `I` 为单位成立；但 generalized binary quartic、Kodaira 类型和 elliptic minimal discriminant 有额外二进修正，所以这些椭圆曲线陈述在本文只用于奇素数。

## 5. 三种“边界次数”不能偷换

在有标号稳定模空间

```text
Mbar_(0,4) isomorphic to P^1
```

上，边界的局部参数是 `lambda`、`1-lambda` 或 `1/lambda`。所以 base section 与边界的交数是

```text
e.                                                   (5.1)
```

无序四点/GIT 粗商在 `Z[1/6]` 上可用 `j` 线描述。由 `(3.3)`，取绝对不变量

```text
D_br/I^3=256/j.
```

它拉回为单位乘 `lambda^2`、`(1-lambda)^2` 或 `lambda^(-2)`（在相应 cusp chart 中）。由于 branch-bad prime 处 `I` 为单位，这个有理不变量在每个此类素数处的估值都精确为 `2e`；在 residue characteristic 不整除 `6` 时，它就是通常的 coarse GIT cusp 接触。因此粗判别边界接触为

```text
2e.                                                  (5.2)
```

在 residue characteristic `2` 或 `3`，把同一个估值陈述解释为 integral coarse-GIT chart 的交数需要小特征 quotient-stack 修正；本文不作该解释。后面的严格 GIT family 取 `p>=5`，不依赖这个小特征边界。

最后，若把 base 上的 pullback divisor 取 reduced，才得到

```text
1.                                                   (5.3)
```

局部稳定总空间也把差别展示得很直观。若稳定参数 `t` 拉回为 `u*pi^e`，节点附近是

```text
xy=u*pi^e.                                          (5.4)
```

special fiber reduced 后只有一个稳定节点；但 `e>1` 时总空间有 `A_(e-1)` 奇点。最小解消插入 `e-1` 个 exceptional components，并把一个稳定节点展开成 `e` 个 regular-model nodes。恰好丢失的数量是

```text
e-1.                                                (5.5)
```

所以“稳定模型只有一个 reduced node”绝不等于“arithmetical contact 只算一次”。

## 6. 严格的固定素数 no-go

固定任意 `p>=5`，取实际 primitive family

```text
(a,b,c)=(1,p^n,p^n+1),       n>=1.                  (6.1)
```

它满足 `a+b=c` 且两两互素。模 `p` 时

```text
F_n congruent Z X^2 (X-Z).                          (6.2)
```

因此对所有 `n`：

- reduced branch configuration 完全相同；
- mod-`p` binary quartic 完全相同；
- special fiber 都是一个二重根而无三重根，即 strictly semistable；
- conductor exponent 都是 `1`；
- `I_n congruent 1`、`J_n congruent 2 (mod p)`，GIT 最小化已经停止。

然而

```text
v_p(D_br(F_n))=2n,                                  (6.3)

twin depth=n,

local powerful excess=(n-1)log p -> infinity.       (6.4)
```

故以下任何局部命题都严格为假：

```text
full contact <= function(reduced boundary),

full contact <= function(mod-p GIT orbit),

full contact <= function(number of stable nodes),

full contact <= function(conductor exponent).
```

Lean 中形式化的是同样严格、并复用现有 Frey 端点的 `p=3` family

```text
(a,b,c)=(3^(m+1),2,3^(m+1)+2).
```

其 reduced 特殊纤维固定，而 branch discriminant 的 `3`-指数是 `2(m+1)`，半指数减去 reduced copy 后恰为 `m`。文件证明：任意依赖 reduced multiplicity `1` 的自然数函数都会被 full contact 以及 powerful excess 分别超过。

限定也必须写清：`(6.1)` 中 `rad(p^n+1)` 会变化，所以这个 family 不反驳一个真正使用所有素数的全局 radical 不等式；它严格否定的是“GIT/reduced special fiber 自己已经给出所缺上界”。

## 7. 全局 GIT height 没有缩小高度

由

```text
I+ab=c^2,                                           (7.1)

4I=3c^2+(a-b)^2,                                   (7.2)
```

可得

```text
(3/4)c^2 <= I <= c^2.                              (7.3)
```

进一步，primitive 情形满足

```text
gcd(I,J) divides 3.                                 (7.4)
```

证明是：若素数 `q` 同时整除 `I,J`，则 `(2.3)` 迫使 `q|27abc`；`(4.2)` 排除 `q|abc`，所以 `q=3`。若 `3|I`，由

```text
I=(a-b)^2+3ab
```

和 primitive 性可见 `v_3(I)=1`。于是

```text
gcd(I^3,J^2) divides 27.                            (7.5)
```

另一方面 `|J|<=4c^3`。若以 primitive coarse coordinates 定义

```text
H_GIT=max(I^3,J^2)/gcd(I^3,J^2),
```

则有绝对常数界

```text
c^6/64 <= H_GIT <= 16c^6.                          (7.6)
```

因此

```text
h_GIT=6 log c+O(1).                                 (7.7)
```

同一事实也来自 `j(lambda)` 是 `P^1 -> P^1` 的六次映射，而

```text
h(lambda)=log max(a,b)=log c+O(1).                  (7.8)
```

所以 GIT quotient 没有制造 height contraction。要证明

```text
h_GIT <= (6+epsilon) log rad(abc)+O_epsilon(1)
```

就是把 abc 高度不等式乘以六并换坐标，而不是 GIT 自动给出的新结论。

## 8. 一个严格的系数守恒 family

取另一 primitive family

```text
(a,b,c)=(n,n+1,2n+1),       n>=1.                  (8.1)
```

令 `A=n(n+1)`。则

```text
I=3A+1,

D_br=A^2(4A+1).                                    (8.2)
```

直接展开给出

```text
D_br <= I^3 <= 16 D_br.                            (8.3)
```

Lean 对 `(8.2)`--`(8.3)` 作了精确证明。于是 `log I^3-log D_br` 在一个无穷 family 上有界。特别地，对任意固定 `delta>0` 和 `C`，不可能由坐标最小化或换成 `I`-height 得到

```text
log I^3 <= (1-delta) log D_br + C                  (8.4)
```

对所有该 family 成立。这是一个严格的 coefficient no-go；它排除的是“换 invariant 后自动节省固定比例”，而不是全局 abc radical 不等式。

## 9. Arakelov 交点与 truncated boundary 的循环位置

写

```text
T=sum_(p|abc) e_p log p=log(abc),

R=sum_(p|abc) log p=log rad(abc),

E=T-R=sum_(p|abc)(e_p-1)log p.                     (9.1)
```

则

```text
log D_br=2T,                                       (9.2)

degree(marked stable boundary pullback)=T,         (9.3)

degree(reduced base boundary)=R.                   (9.4)
```

判别 section 的有效性、Deligne pairing 或 arithmetic Noether formula 都自然产生 `(9.2)` 或 `(9.3)`；有效除子的正性不会把 `e_p` 截成 `1`。从 `(9.3)` 跳到 `(9.4)` 正是需要证明的截断步骤。

Paul Vojta 的[原始论文](https://arxiv.org/abs/math/9806171)明确把经典 abc 识别为 `P^1` 上除子 `[0]+[1]+[infinity]` 的 truncated Second Main Theorem。这里的 `lambda=-b/a` 正是那个三点模型。因此，若 stable-height/Arakelov 方法给出足够强的全局 truncated inequality，它不是绕过 abc，而是在证明 abc 的核心形式。

若只瞄准本项目当前的 exponent-excess upper，则精确标量关系是

```text
E <= (2+epsilon/2)R+C

iff

log D_br <= (6+epsilon)R+2C.                       (9.5)
```

所以 branch-discriminant 路线所需上界就是 slope-six Szpiro 型判别式--conductor 输入。Lean 证明了 `(9.5)` 的抽象实数等价，但没有证明任一侧。

Arakelov 理论确有无条件正结果，但数量级远远不够。例如 von Kanel 的[原论文](https://arxiv.org/abs/1310.7980)证明 elliptic/hyperelliptic discriminant 的有效 exponential 版本，典型形状是

```text
log Delta <= c N^kappa,
```

而目标是

```text
log Delta <= (6+epsilon)log N+O(1).
```

前者不能给出 `(9.5)` 所需的 radical-linear 系数。

## 10. 唯一仍可能提供新信息的非 IUT 方向

由于 `gcd(I,abc)=1`，在奇坏素数处 `4I^3` 是单位。因此 `(2.3)` 可重写为

```text
1-J^2/(4I^3)=27D_br/(4I^3).                        (10.1)
```

对 `p|abc, p` 为奇素数且 `p!=3`（即 `p` 不整除 `6`），有

```text
v_p(1-J^2/(4I^3))=2e_p.                            (10.2)
```

这给出一个不依赖 IUT 的精确新定位：powerful excess 是平方 `J^2` 与立方尺度 `4I^3` 的同时高阶 `p`-adic 接近。若要继续推进，必须利用这些接近在所有素数之间的全局耦合，而不能只保留 reduced GIT orbit。

一个可供下一轮研究的辅助事实是：若素数 `q!=3` 整除 `I`，primitive 性使 `a/b mod q` 成为非平凡三次单位根，故

```text
q congruent 1 (mod 3).                              (10.3)
```

这把 auxiliary invariant support 限制在 split primes，可能与 cubic characters、Eisenstein 整数分解或 large-sieve 方法结合。但目前没有无条件论证把 `(10.2)` 的总深度压到 `O(R)`；若直接对 `(10.1)` 使用三点截断高度或对 `(2.3)` 使用 abc，仍然循环。

## 11. Lean 边界

文件

```text
IUTThreeClosures/FreyBranchQuarticBarrier.lean
```

形式化：

1. 非二项式约定下 `I,J` 的展开；
2. `4I^3-J^2=27D_br`；
3. 权重 `(2,3,6)` 的 scalar rescaling 恒等式；
4. `lambda`、`1-lambda`、`1/lambda` 三个 cusp 参数；
5. `gcd(I,abc)=1` 的算术核心；
6. `I+ab=c^2` 和精确平方余项；
7. adjacent family 上 `D_br <= I^3 <= 16D_br`；
8. branch discriminant 的 factorization exponent；
9. 固定 `3` 的实际 primitive Frey family 中 full contact 与 powerful excess 的两个 reduced-boundary no-go；
10. exponent-excess upper 与 slope-six branch-discriminant upper 的精确实数等价。

Lean 没有形式化 `GL_2` 作用、binary quartic minimization、Hilbert--Mumford 稳定性、`Mbar_(0,4)`、cluster pictures、局部稳定方程、regular resolution、Arakelov 交点、Szpiro 或 abc。正文中所有这些都属于 paper mathematics；没有以结构字段或假设偷偷送入 kernel。
