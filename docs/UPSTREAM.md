# 与 BioSeqs 的上游/下游接口

检查源码：https://github.com/paipai-Studio/BioSeqs/blob/7dfa3c22ec304fa0b4a97610e097340c371209e4/src/crystal.mbt

MoonCakes：IvanAXu/BioSeqs 0.1.9。下表是字段提取契约，而不是本项目已经编译验证的 BioSeqs 二进制依赖；本项目未打包/复制上游代码。

|上游公开字段|下游入口|责任边界|
|---|---|---|
|UnitCell.a/b/c/alpha/beta/gamma|`reciprocal(a,b,c,alpha,beta,gamma)`|上游解析与模型；下游验证并算倒易度量|
|CrystalAtom.x/y/z|`site(x,y,z,weight,occupancy=...)`|必须 `is_fractional==true`；笛卡尔坐标不能直接传入|
|CrystalAtom.occupancy|site 的 occupancy 参数|必须满足 [0,1]；不默认夹取|
|CrystalAtom.element|无自动映射|调用者明确指定常数 weight；不得暗示真实元素散射精度|
|SpaceGroup|不自动消费|centering 只覆盖平移规则；完整对称扩增须上游先完成|

概念调用为 `reciprocal(cell.a, cell.b, cell.c, cell.alpha, cell.beta, cell.gamma)`，再对已经扩增到 conventional-cell 的分数坐标构建 site。错误上抛，不自动转换/补齐未知物理字段。不调用 BioSeqs orthogonalization_matrix，从而不依赖其坐标转换约定。

为何不强制依赖：被检视的 src 是包含大量其他生物功能的大包，本库不需要它们；六参数加分数点足以建立类型无关的互补接口。这不是把上游重新写一遍：本项目没有 CIF parser、CrystalStructure、键、密度或笛卡尔编辑 API。整合适配器的编译兼容性需要上游消费项目单独验证，当前不宣称已经完成真实 BioSeqs 端到端测试。
