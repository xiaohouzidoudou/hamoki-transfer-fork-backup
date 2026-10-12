# Hamoki 独立化迁移状态

## 已完成
- 仓库公开（Public），二次开发在 `feat/hamoki-transfer`。
- 停止继承自原项目的自动发布和主分支镜像自动构建（分支改动，待合并到主分支）。
- Compose 改为从 Hamoki 当前源码构建，不再直接部署 `lanol/filecodebox` 官方镜像。
- 使用 Hamoki 自有功能规划与版本审批原则，不例行同步原项目。

## 尚未完成，禁止宣称完全脱离上游
- Dockerfile 构建阶段仍从 `vastsa/FileCodeBoxFronted` 和 `vastsa/FileCodeBoxFronted2023` 拉取源码。必须将这两套前端完整、按许可证要求保留声明地迁入我们的仓库并替换 Dockerfile、CI 中的拉取步骤，然后构建验证。
- 需为 `ghcr.io/xiaohouzidoudou/hamoki-transfer` 配置 GHCR 发布权限，完整运行安全测试和实际 Docker Build。
- 可选择在 GitHub Settings 里移除 GitHub fork 关系；这是仓库元数据操作，和代码是否独立构建是两回事。当前仍标注为 fork。
- 应审查 `.github/dependabot.yml` 是否符合只允许经过批准的依赖升级的原则。
- 因许可证为 LGPL-3.0，不能简单更换为 MIT 或移除原作者版权及原许可证。

## 验收标准
1. 克隆单个 `hamoki-transfer` 仓库且不接触任何 `vastsa/` 的 Git 仓库，也可构建后端和前端。
2. 发布镜像只引用我方账号及经我方批准固定版本的基础依赖。
3. 按手动审批发布，运行测试通过，公开文档准确标注原项目版权来源。
4. 上线前验证上传、下载、过期、限流、鉴权、二维码及备份恢复。
