# abc 多路线续研：素数支撑、同源类高度与局部来源

作者：ChatGPT。研究日期：2026-08-31。

**本轮证明与 PDF 核验已经通过；标准的无条件 `ABCConjecture` 尚未证明，
也没有得到严格证伪。** 下述局部或子类结果不改变这个结论。
上一份完成验收的 705 项记录及 66 页论文已经逐字保存；本轮不会覆盖
它们的快照或校验表。本轮验收独立记录在
`Lean/verification/2026_08_31_uniform_continuation/`。

## 1. 保持的目标和证明纪律

目标仍是原定义

\[
 \forall\varepsilon>0\ \exists C_\varepsilon\ \forall(a,b,c),
 \qquad \log c\le(1+\varepsilon)\log\operatorname{rad}(abc)+C_\varepsilon,
\]

其中三元组是实际的正整数、两两互素并满足 \(a+b=c\)。原始定义、
下游接口、Lean 工具链和依赖版本没有为了获得“证明”而更换。
证伪必须固定一个正的 \(\varepsilon\)，构造不能被任何常数吸收的
无界反例族；有限个高质量三元组不够。

每个新增 Lean 命题先有数学证明。原始文献中的外部定理、纸面证明、
Lean 已核查的实际对象，以及仍缺的全局步骤分别记载。没有以假设
所需结论、声明新数学公理或重定义标准目标的办法填补缺口。
跨智能体审查是内部核对，不是外部人类同行评审、期刊接收或优先权认证。

## 2. 解析路线：完整的两素数子类

对所有正的本原三元组，只要
\(\omega(abc)\le2\)，就有

\[
             2c\le3\operatorname{rad}(abc).
\]

等号仅发生在 \((1,8,9)\) 和 \((8,1,9)\)。除这两个有序三元组外，
还成立 \(c\le\operatorname{rad}(abc)\)。这不是在假定一个素数幂
分类表之后得到的条件推论：证明从实际素数支撑出发，先迫使一个加数
等于 1，再证明剩余的互素素数幂分类和指数限制。

`ABCTwoPrimeSupport20260831.lean` 的 22 个公开命题已经完整核查。
它们使用原来的 `abcRadical`。没有调用 abc、Catalan 猜想或一个
未证明的分类接口。这给出了完整子类上的绝对常数，但没有控制三个
或更多移动素数的情形。

证明与文献使用见
[解析路线报告](E:/AImath/abc猜想/research/ANALYTIC_UNIFORM_GATE_2026_08_31.md)。

## 3. 实际迹、理性返回与大小为二的纤维

若实际代数迹满足
\(\operatorname{Tr}_T(Fx)=u\operatorname{Tr}_S(x)\)，则一个标量
\(a\) 返回标量 \(b\) 时，先得到带维数的精确恒等式

\[
                 [T:K]b=u[S:K]a.
\]

同为正维数、特征为零时可消去维数，即使维数被剩余特征整除。
一次非零标量返回还迫使整个标量线按 \(t\mapsto ut\) 作用；要由此
推出赋值保持，必须另有 \(v(u)=0\)。形式化使用真正的 `Algebra.trace`、
`algebraMap` 和 `Module.finrank`，而不是给一个函数冠以“迹”的名称。
Galois/Kummer 输入在数学应用中证明和引用，在 Lean 中没有冒充
无假设的已证结论。

对原始 `ABCPoint` 的三个有标签奇数部分定义纤维，可无条件证明

\[
 \#\{(a,b,c):\operatorname{oddPart}(a)=A,
                \operatorname{oddPart}(b)=B,
                \operatorname{oddPart}(c)=C\}\le2.
\]

Lean 先构造到 `Fin 2` 的单射并证明纤维有限，再使用 `Nat.card`，
没有利用无限类型的基数定义得到空洞的上界。
\((4,3,7)\) 与 \((1,6,7)\) 给出 \((A,B,C)=(1,3,7)\) 上恰为二的
实际纤维。相关 7 个迹命题和 18 个纤维命题已核查。

当所有奇素数处同时满足精确的素数支撑、有标签端点保持和逐点的
理性返回时，这一纤维结果可用于限制输出数。单纯属于共同的模包络
不提供这些条件。允许自由改变 Tate 系数单位的较大范畴有上述锐性
例子；不能据此宣布固定系数标记的严格 Galois 自同构范畴也达到上界。

先于代码的证明见
[迹证明](E:/AImath/abc猜想/research/TRACE_COVARIANT_RATIONAL_RETURN_PROOFS_2026_08_31.md) 和
[纤维证明](E:/AImath/abc猜想/research/ABC_ODD_PART_FIBRE_FORMAL_PROOFS_2026_08_31.md)。

## 4. 算术几何路线：完整同源类与全局高度

对无界族 \(c=1792n+2\)、\(n\ge1\)，取真实曲线

\[
                E_c:\ y^2=x(x-1)(x+c-1).
\]

通过完整的有理循环同源次数分类、模 7 的实际八点计数、模 3 的
Frobenius 多项式，以及最小次数同源的循环核论证，证明整个
\(\mathbb Q\)-同源类由原曲线与三个二同源商组成。
这是对整个同源类的数学结论，不是把四元素枚举类型定义成同源类。

类内最大最小判别式和最小复绝对值满足

\[
 \frac{c^5}{32}\le\max_F|\Delta_{\min}(F)|\le256c^5,
 \qquad 2c\le\min_F|j(F)|_\infty\le32c.
\]

因此，仅在此同源类内选择代表，不能普遍从其最小判别式恢复
\(c^{6-o(1)}\)。这个无界族反驳的是明确的替换命题，没有证明它的
radical 足够小，故不证伪 Szpiro 或 abc。

进一步将四个真实 \(j\) 值约分。令 \(u=c/2\)、
\(Q=c^2-16c+16\)，则零核商的既约值为

\[
                 j(E_0)=-\frac{Q^3}{(c-1)u^4}.
\]

所有分母互素性和 2 部分已分别证明。整个同源类的唯一高度最小者
也是 \(E_0\)，并有精确的全局绝对对数 Weil 高度

\[
                \min_F\mathrm h(j(F))=3\log Q.
\]

特别地，它除以 \(\log c\) 趋于 6，而复绝对值的对数除以
\(\log c\) 趋于 1。二者差恰为
\(\log((c-1)u^4)\)，不能漏掉这个有限处贡献。优化代表只节省一个
有界的加法常数。

原四模型的 23 个公开算术命题已经形式化，包括真实 Weierstrass
曲线、真实有限域点类型和判别式/绝对值界。新增高度模块的 27 个公开
命题使用真实 `Rat.num`、`Rat.den`、`Height.mulHeight₁`、
`Height.logHeight₁` 和 `Heights.normalizedLogHeight`，证明既约分式、
实际四模型的最小值和唯一性；没有新定义一个代理“高度”。
最小值结论保留必要的 \(n\ge1\)：\(n=0\) 时唯一性确会失败。
完整同源类分类、最小模型理论与全类渐近障碍仍有明确的纸面证明边界。

详见
[完整同源类证明](E:/AImath/abc猜想/research/ARITHMETIC_GEOMETRY_UNIFORM_GATE_2026_08_31.md) 和
[精确 Weil 高度证明](E:/AImath/abc猜想/research/FREY_ENTIRE_ISOGENY_WEIL_HEIGHT_2026_08_31.md)。

## 5. IUT 路线：有限 theta 点源与算术对象

先前已构造完整局部 Galois 群的实际自同构、共同最小层算子和完整
初始 theta 数据。本轮将局部输入缩小到原文 standard-type theta
值的有限歧义

\[
                   x_j\in\mu_{2\ell}r_0^{j^2}.
\]

原文允许不同标签独立选择这些根单位。对每个这样的标签元组，证明
存在一个共同的实际 Kummer 算子，使所声明的 native 加法张量点源
取得精确包络

\[
 \overline{\operatorname{span}_{B_{m_j}}
    \{F^{\otimes m_j}(1\otimes\cdots\otimes x_j)\}}
 =P_j=\beta^{e k_j-(e-1)m_j}B_{m_j}.
\]

这里 \(e=15\ell\)、\(m_j=j+1\)、
\(k_j=\lfloor2j^2/\ell\rfloor+1\)。量词是
“每个根单位元组，存在一个共同算子”，没有偷换成“一个算子对
所有元组通用”，也没有假定任意整线性变换都来自 Galois 群。

对 \(\lambda(x)=p^{-1}\log(1+px)\)，误差在每个允许算子下仍处于
更深的一层，故两个点张量在每个算子之后生成相同的主理想。
这不等于说原 theta 乘法 Kummer 类就是 \(\operatorname{Kum}(1+px)\)。
标准 log-field 中的环单位是 1；shell 定义里的 \(1/p\) 不能被当作
整个字段坐标也被除以 \(p\)。若确实改变整个字段的坐标，乘法、
单位、赋值、标量嵌入和参考格都必须同步运输。

另一路从这些明确的局部格构造真实算术向量丛，选定所有有限处和
无穷处的数据，证明每秩算术度等于相应局部归一化体积。
适当整数次的加权行列式不只数值相同，而且作为带度量对象下降到
\(\mathbb Q\)。在 \(\ell=43\) 时平均值为
\(18836\log p/4515\)。这些对象的构造不自动证明它们就是原文完整
输出族中的同一个 global pilot。

进一步的同列局部来源包含已通过原文审查。一个全局副本恒等映射
给出同步的 standard-log 代表；原文的局部互反比较明确给出
\(\sigma_E(x)=p^{-N}[\operatorname{rec}_E(\exp(p^Nx))]\)。
canonical core 的作用为逆向 transfer，即 \(M_\alpha^{-1}\)，没有
加入任意的 Tate 系数单位。前层、对数字段和当前层的三套乘法
cyclotome、前一层 carrier 和交换图分别核对。

由同一个实际 global pilot 的局部理想，证明共同 canonical 轨道点
属于原文 raw 输出集的一个固定基本分支。因此 \(P_j\) 下包含于这个
raw 集的闭模包络，没有证明整个包络等于 \(P_j\)。这里
\(F_{\rm mod}=\mathbb Q\)，选定地点集在每个有理素数上只有一个成员；
一般多地点张量只能得到指定分量的投影成员关系，不能零延拓回整体。
运输乘法算子时还必须同时运输测试向量 \(\Phi(1)\) 与测试模
\(\Phi(R)\)。纯 theta 点的迹为零，而相应一加单位对数点的迹非零；
两者生成同样主理想不代表它们属于同一个点轨道。

这些结论没有证明完整的水平 theta、Ind3、IPL/SHE 或全局度比较，
也没有把来源重构理论写成未经证明的 Lean 假设以增加形式化数量。

详见
[有限 theta 点源证明](E:/AImath/abc猜想/research/IUT_NATIVE_THETA_TORSION_POINT_HULL_2026_08_31.md)、
[算术丛与归一化报告](E:/AImath/abc猜想/research/IUT_GLOBAL_COMPARISON_NEXT_GATE_2026_08_31.md) 和
[对数字段独立审查](E:/AImath/abc猜想/research/IUT_LOGFIELD_SHELL_COORDINATE_CROSS_REVIEW_2026_08_31.md)，以及
[同步基本分支来源证明](E:/AImath/abc猜想/research/IUT_IDENTITY_LOG_LINK_LOCAL_MEMBERSHIP_2026_08_31.md)。

## 6. 当前核查状态与尚未完成的工作

五个新增模块包含 97 个公开定理，以及另外 9 个含证明的
构造，共 106 项依赖报告。3 项不依赖公理，其余只使用
`propext`、`Classical.choice`、`Quot.sound` 的子集。
此次完整构建为 9135 个任务，265 条警告逐项对应既有警告，没有
新增模块警告。前阶段的 145、89、43 项审计均已重新运行并解析通过。
构建和审计期间，五模块、统一入口、审计源和声明清单的八项输入哈希
保持不变。独立复核还逐项比对了源码声明、公理日志和真正的库对象。

| 新模块 | 公开定理 | 额外构造 |
|---|---:|---:|
| ABCTwoPrimeSupport20260831 | 22 | 0 |
| TraceCovariantRationalReturn20260831 | 7 | 0 |
| ABCOddPartFibre20260831 | 18 | 4 |
| FreyEntireIsogenyArithmetic20260831 | 23 | 5 |
| FreyIsogenyWeilHeight20260831 | 27 | 0 |

705、506、447 项旧清单已经用各自记录的快照映射重新核对，均为零
失败。不能把旧核查器直接用在已改变的当前 PDF 上，再声称旧清单失败
或修改旧清单来消除差异。
本轮独立清单覆盖 1051 个明确纳入验收的文件，默认核验器只读，不会
重新生成清单或修改旧快照。用户正在 WPS 中查看的旧中间 PDF 不纳入
当前交付范围；被验收的旧 66 页 PDF 始终由其精确快照保护。

英文论文作者为 ChatGPT；新增章节已经有完整数学证明。
[最终 93 页 PDF](E:/AImath/abc猜想/output/pdf/ChatGPT_ABC_Uniformity_2026_08_31.pdf)
编译无最终 TeX 警告，四名智能体已实际查看全部 93 页。
文件为 741229 字节，SHA256 为
`0dfc4b7be5f7b32c65d357bf43d1e0df91a4ec8c35eb68cec7f46c56898e4e9f`。
所有单页图像、配对图像的像素对应和带具体页码的审稿记录均重新核对。
原同名中间 PDF 正被 WPS 打开，所以终版另存为带日期文件，未关闭用户
会话；旧 66 页已验收论文仍由单独快照保护。论文不是一般 abc 的证明稿，
没有提交期刊或发送给外部人员。

本轮核对 13 份原始 PDF，其中 3 份新归档、10 份复用并逐字校验。
完整循环同源次数分类以 Balakrishnan–Mazur (2025) 的明确完成定理为据，
不归到仅处理素数次数的 Mazur (1978) 原文。AbsTopIII 的引用使用
首页标明 November 2015 的作者版本及具体页码；相关重构定理仍是明示的
外部数学来源，不假装在本工作中全部重证。

所有广义路线继续保留。解析路线仍缺一般支撑下的统一估计或满足
必要窗口的放大下界；几何路线仍缺移动支撑、导子和全局高度间的
全 epsilon 控制；IUT 路线仍缺同一完整输出族、相同标记和参考下的
全局比较。局部正体积、真实初始数据、行列式下降和若干特定替换
命题的反例都不能代替这一缺失步骤。
