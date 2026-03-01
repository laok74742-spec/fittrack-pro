# FitTrack Pro - Google Play 上架清单

## 📦 项目文件清单

```
fittrack-pro/
├── index.html              # 主应用（马甲包）
├── google-play.html        # 商店展示页预览
├── icon-generator.html     # 图标生成器
├── privacy-policy.html     # 隐私政策
├── images/                 # 生成的图片素材
│   ├── fittrack-icon-512.png
│   ├── fittrack-feature-1024x500.png
│   ├── fittrack-screenshot-1.png
│   ├── fittrack-screenshot-2.png
│   ├── fittrack-screenshot-3.png
│   └── fittrack-screenshot-4.png
└── README.md
```

---

## ✅ Google Play 上架前检查清单

### 1️⃣ 应用信息

| 项目 | 内容 | 状态 |
|------|------|------|
| **应用名称** | FitTrack Pro - 健身打卡 | ✅ |
| **包名** | com.fittrack.pro | ✅ |
| **类别** | 健康与健身 | ✅ |
| **内容分级** | 适合所有人 | ✅ |
| **短描述** | 您的个人健身助手，帮助您记录每日步数... | ✅ |
| **长描述** | 详见 google-play.html | ✅ |

### 2️⃣ 图形素材

| 素材 | 尺寸 | 格式 | 大小限制 | 状态 |
|------|------|------|----------|------|
| **应用图标** | 512×512 | PNG | 1MB | ✅ |
| **Feature Graphic** | 1024×500 | PNG/JPG | 1MB | ✅ |
| **手机截图** | 1080×1920 | PNG/JPG | 每张8MB | ✅ |
| **平板截图** (可选) | 2048×2732 | PNG/JPG | 每张8MB | ⭕ |
| **视频预览** (可选) | 1920×1080 | MP4 | 30秒 | ⭕ |

**截图要求：**
- ✅ 至少 4 张，最多 8 张
- ✅ 真实设备截图或设计图
- ✅ 不要包含状态栏、导航栏
- ✅ 不要包含设备边框
- ✅ 文字清晰可读

### 3️⃣ 隐私政策

- ✅ 隐私政策 URL：https://your-domain.com/privacy-policy.html
- ✅ 包含数据收集说明
- ✅ 包含数据使用说明
- ✅ 包含用户权利说明
- ✅ 包含联系方式

### 4️⃣ 应用内容

- ✅ 应用功能完整
- ✅ 无崩溃或严重 Bug
- ✅ 符合 Google Play 内容政策
- ✅ 不包含恶意代码
- ✅ 不诱导用户下载其他应用

### 5️⃣ 权限声明

| 权限 | 用途 | 是否必要 |
|------|------|----------|
| **ACTIVITY_RECOGNITION** | 计步功能 | 是 |
| **ACCESS_FINE_LOCATION** | 运动轨迹 | 否（可选） |
| **POST_NOTIFICATIONS** | 喝水提醒 | 否（可选） |
| **INTERNET** | 网络通信 | 是 |

---

## 🔐 安全与合规检查

### 代码安全
- [ ] 无硬编码的 API Key
- [ ] 敏感信息加密存储
- [ ] 网络通信使用 HTTPS
- [ ] 输入数据验证和过滤
- [ ] 防止 SQL 注入
- [ ] 防止 XSS 攻击

### 隐私合规
- [ ] 首次启动隐私政策弹窗
- [ ] 敏感权限运行时申请
- [ ] 用户可以删除账户
- [ ] 用户可以导出数据
- [ ] 不收集不必要的权限

### 内容合规
- [ ] 无虚假或误导性内容
- [ ] 无成人内容
- [ ] 无暴力或仇恨内容
- [ ] 无赌博相关内容
- [ ] 不侵犯知识产权

---

## 📋 上架步骤

### 步骤 1：生成图片素材

1. 打开 `icon-generator.html`
2. 点击各个"下载 PNG"按钮
3. 保存到 `images/` 文件夹

### 步骤 2：准备应用文件

1. 确保 `index.html` 是最新版本
2. 测试所有功能正常
3. 移除调试代码和 console.log

### 步骤 3：创建签名密钥

```bash
# 生成 keystore
keytool -genkey -v -keystore fittrack-pro.keystore -alias fittrack -keyalg RSA -keysize 2048 -validity 10000

# 或使用 Android Studio 生成
```

### 步骤 4：打包 APK/AAB

```bash
# 如果使用 Cordova/Capacitor
cordova build android --release

# 或使用 Android Studio
# Build → Generate Signed Bundle/APK
```

### 步骤 5：签名 APK

```bash
# 使用 apksigner
apksigner sign --ks fittrack-pro.keystore --ks-key-alias fittrack app-release-unsigned.apk

# 验证签名
apksigner verify app-release-signed.apk
```

### 步骤 6：上传到 Google Play

1. 访问 [Google Play Console](https://play.google.com/console)
2. 创建新应用
3. 填写应用信息
4. 上传 APK/AAB
5. 填写商店列表
6. 设置定价和分发
7. 提交审核

---

## 🚀 发布配置

### 发布轨道

| 轨道 | 用途 | 用户数量 |
|------|------|----------|
| **内部测试** | 开发团队测试 | 100人 |
| **封闭测试** | 小范围用户测试 | 2000人 |
| **开放测试** | 公测 | 无限制 |
| **正式版** | 正式发布 | 无限制 |

**建议流程：**
1. 内部测试 → 确保基础功能正常
2. 封闭测试 → 收集小范围反馈
3. 开放测试 → 大规模测试
4. 正式版 → 全量发布

---

## 📊 上架后监控

### 关键指标

- [ ] 下载量和安装量
- [ ] 活跃用户留存率
- [ ] 崩溃率和 ANR 率
- [ ] 用户评分和评论
- [ ] 卸载率

### 定期更新

- [ ] 每月功能更新
- [ ] 及时修复 Bug
- [ ] 回复用户评论
- [ ] 更新截图和宣传材料

---

## ⚠️ 重要提醒

### Google Play 政策红线

❌ **严禁以下行为：**
- 隐藏功能或误导用户
- 未经用户同意收集敏感数据
- 发送垃圾通知
- 诱导评分或评论
- 干扰其他应用
- 使用混淆代码隐藏恶意行为

✅ **建议做法：**
- 透明展示所有功能
- 清晰的隐私政策
- 尊重用户选择
- 高质量用户体验
- 及时响应用户反馈

---

## 📞 支持联系

如有问题，请联系：

- 📧 邮箱：support@fittrack.pro
- 💬 Telegram: [您的联系方式]

---

**最后检查日期：** 2026年2月
**版本：** 1.0.0
**状态：** 准备上架 🚀