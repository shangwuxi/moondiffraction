# MoonDiffraction

[![Verify diffraction](https://github.com/shangwuxi/moondiffraction/actions/workflows/ci.yml/badge.svg)](https://github.com/shangwuxi/moondiffraction/actions/workflows/ci.yml)

源代码版本：`0.1.0`；[GitHub Releases](https://github.com/shangwuxi/moondiffraction/releases)。

**MoonBit 常数散射点倒易衍射内核**：已有晶胞参数与分数坐标 → 完整有限反射 → 复结构因子/消光 → Bragg 角 → 粉末峰与有限采样谱。

这不是 MoonINI 的改名版本，也不是 CIF/通用晶体解析器。面向教学工具与离线数值原型；**不是元素相关 X 射线仿真、实验标定、结构精修或完整空间群库**。

## 为什么独立建设：与已有项目的互补边界

MoonCakes 已有 `IvanAXu/BioSeqs@0.1.9` 的晶胞/原子模型、CIF、坐标转换。我们不重复这些 API，接收其已有模型的六个晶胞标量和 fractional atom 标量，新增倒易反射计算下游。没有强制依赖或复制 BioSeqs 源码；桥接契约见 [上游接入](docs/UPSTREAM.md)。

相对于旧 MoonINI，本项目核心数据是 `hkl / reciprocal Gram matrix / complex amplitudes / multiplicities`，不是配置 AST。查重包含多个不同领域候选、MoonCakes 搜索、相邻源码和全登记表：[查重报告](docs/competition/duplicate-check.md)。只对已检索范围作判断，保留中等相邻风险，不承诺报名通过。

## 本地安装与运行

安装 MoonBit 官方工具链后：

```sh
git clone https://github.com/shangwuxi/moondiffraction.git
cd moondiffraction
moon test --deny-warn
moon run cmd/cubic
moon run cmd/extinction
moon run cmd/powder
python scripts/oracle.py wasm-gc
```

当前代码仅依赖 `moonbitlang/core/math` 及标准库内建能力。**新项目尚未发布 MoonCakes**，不能把 `moon add shangwuxi/moondiffraction` 当作已可用安装命令。库 API 可在此仓库中的新 package 导入，或将本仓库作为本地模块依赖；请参照当前 MoonBit 本地依赖配置。

已本地验证工具链：moon 0.1.20260904；moonc v0.10.12+1634b282e（2026-09-07）。不修改其他项目/全局工具链。原生构建需要 C 编译器；本机仅验证 native check，native build 因缺少 cl/cc/gcc/clang 未运行成功；CI 已使用 Ubuntu C 工具链完成 native check/build/test、三个示例和独立 oracle；这不等同于本地 native 构建通过。

## 三个分别可运行的完整场景

### 1. 教学工具：立方晶面间距和区轴

`moon run cmd/cubic`：输入 a=b=c=3 Å、(122)、波长 1 Å，验证 d=1 Å、2θ=60°，并验证 [001] 区轴第一反射壳层含 4 个点。失败会 abort，不是只打印预设答案。

### 2. 点阵课程：BCC/FCC 消光

`moon run cmd/extinction`：把体心和面心平移显式转换为散射点，分别对 26 个带符号反射求复振幅；验证 14/18 个消光，并与独立整数选择规则逐项一致。规则只预测平移消光，不能预测全部基元或滑移/螺旋消光。

### 3. 原型开发者：三斜晶胞到粉末谱与峰位比较

`moon run cmd/powder`：输入三斜六参数和两个带占据率/常数权重的点，生成 70 个反射、35 个峰组与 7201 个谱采样，检查积分强度守恒；一个合成观测峰匹配、179° 观测保持未匹配。输出可读摘要和带单位 CSV，不强制把观测分配给“最近的”峰。

## 最小 API 使用

在子包 `moon.pkg` 中：

```moonbit
import { "shangwuxi/moondiffraction" @diff }
pkgtype(kind: "executable")
```

```moonbit
fn main {
  let m = @diff.reciprocal(3.0, 3.0, 3.0, 90.0, 90.0, 90.0).unwrap()
  let points = [@diff.site(0.0, 0.0, 0.0, 1.0).unwrap()]
  let reflections = m.simulate(points, 1.0, 1.0).unwrap()
  let peaks = @diff.powder(reflections).unwrap()
  println(peaks.length())
}
```

以上 unwrap 仅用于固定演示输入。生产调用须处理 `Err(Invalid(message))` 与 `Err(Budget(message))`；不能自动忽略失败或截断后声称完整。

|API|语义|
|---|---|
|`reciprocal` / `hkl` / `site`|验证输入并构造只读字段模型|
|`Metric.q2` / `spacing` / `plane_angle`|倒易度量、间距、带方向晶面角|
|`reflections` / `zone`|有界完整枚举、整数区轴过滤|
|`amplitude` / `sensitivity`|补偿求和复振幅；单点六参数强度局部导数|
|`Centering.allows` / `translations`|P/I/F/A/B/C/R（R obverse hex）平移规则/点|
|`two_theta` / `spacing_from_angle`|一阶 Bragg；不可达返回 `Ok(None)`|
|`simulate`|同时限制候选数和相位项数；保留相消/不可达反射|
|`powder`|拒绝重复 hkl 和混合波长；锚点分组，不做链式聚类|
|`gaussian_profile` / `Profile.area`|单位连续面积 Gaussian；有限窗口梯形积分|
|`match_peaks`|所有容差内候选及残差；不做物相识别|
|`reflections_csv` / `reflections_json` / `Profile.csv`|数值导出，JSON 带版本和模型声明|

完整签名：[pkg.generated.mbti](pkg.generated.mbti)。数值与复杂度边界：[架构](docs/ARCHITECTURE.md)。

## 重要约定和限制

- 长度/波长 Å，B_iso Å²，角度 degree；`q²=1/d²`，**没有 2π 因子**。
- `F=Σ occ*w*exp(-B*q²/4)*exp(2πi(hx+ky+lz))`；w 是实常数，可为负。没有元素散射表或异常色散。
- 默认枚举保留 Friedel 两侧；粉末强度为成员强度之和，不再额外乘多重度。显式设置 Friedel 唯一时，应理解多重度减半；`simulate` 固定保留两侧。
- centering 参数只过滤，不扩增 site；使用 translations 创建完整点阵，或自己输入完整 conventional-cell 点。没有空间群对称扩增。
- d_min 边界允许 1e-12 相对 q² 容差，拒绝归一化 Gram determinant ≤1e-10 的近奇异晶胞。
- Gaussian 的 sigma 是标准差，不是 FWHM；要求 step ≤ sigma/4。窗外面积丢失会如实反映，不重归一化、不加背景/仪器校正。
- 峰组使用最小角为锚点（不是强度质心），width 报告组内角跨度。数组字段是调用者可变容器，改动输出后不再代表原始仿真结果。

## 验证

```sh
moon fmt --check
moon check --target wasm-gc --deny-warn
moon build --target wasm-gc --deny-warn
moon test --target wasm-gc --deny-warn
python scripts/oracle.py wasm-gc
```

把 target 换成 wasm / js / native 做相同验证（native 需 C 编译器）。2026-09-11 四目标 CI 首次全部通过（[验证记录](https://github.com/shangwuxi/moondiffraction/actions/runs/34609667244)）。当前 24 个 MoonBit 测试组；其中含 2394 个平移规则交叉检查、立方壳计数、NaN/Infinity、非对称三斜、资源失败及六维导数差分。另有 **496 组独立 Python 标准库 oracle**，以笛卡尔叉积重建倒易基，避免与被测余子式公式共用同一算法。测试组数不等于断言数，不能混报。

## 开源与发布

MIT；唯一项目 Git 提交身份 `shangwuxi`。AI 协助范围见 [AI_USAGE.md](AI_USAGE.md)，数学/生态来源及未复制声明见 [THIRD_PARTY.md](THIRD_PARTY.md)。开发快照 21 个非空提交，经逐提交重跑保守计入 20 个，另 1 个粉末修复不单独计入；后续发布文档提交不用于凑门槛，见 [逐 SHA 审计](docs/competition/commit-audit.md)。CI、发布版本以 GitHub 实际状态为准。MoonCakes 发布和组委会复核是独立步骤。
