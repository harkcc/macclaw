# eMAG 前台抓取策略（thin slice）

## 结论
- 类目页 **不依赖 JSON-LD**：可能没有或信息不足。
- 页面内有大对象 `window.EM.listingGlobals`（含 `items`），可作为第一来源：
  - 商品：id、name、category（类目路径）
  - offer/vendor：vendor.name、availability.text、unified_badges 等
- **价格通常在 DOM 渲染**（而非上述 JSON 内），需要解析卡片价签文本。
- SKU/PNK 这类代码可从商品 URL 提取（例如 `/pd/<CODE>/`）。

## 反爬/验证码
- 风控：AWS WAF Captcha，触发敏感。
- 推荐路线：
  1) 用**有头浏览器**低频访问并完成验证码一次，获取可用 cookie。
  2) 复用 cookie/token 做 **request 高频采集**（你同事已验证可行）。
  3) 检测到 403/Captcha/`awswaf` 相关特征 → 立即暂停并留档（HTML快照/时间/URL），等待人工介入。

## 第一阶段薄切片
- 单类目 Top30 抓取 + 字段对照表（ERP已有 vs 前台缺口）。

## 待你确认
- 高频 request 采集需要复用的关键 cookie 键名/有效期/刷新方式。
- 第一版报告必须字段 Top10。
