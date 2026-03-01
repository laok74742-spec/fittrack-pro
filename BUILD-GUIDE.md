# 🚀 FitTrack Pro - 一键上架指南

## 📦 项目结构

```
fittrack-pro/
├── www/                          # Web资源
│   ├── index.html               # 主应用
│   └── privacy-policy.html      # 隐私政策
├── android/                      # Android原生项目
│   ├── app/
│   │   ├── build.gradle         # 构建配置
│   │   └── src/main/
│   │       ├── AndroidManifest.xml
│   │       └── assets/
│   └── build.gradle
├── capacitor.config.json        # Capacitor配置
├── package.json
└── BUILD-GUIDE.md              # 本文件
```

---

## 🛠️ 环境准备

### 1. 安装必要软件

| 软件 | 用途 | 下载地址 |
|------|------|----------|
| **Android Studio** | Android开发IDE | https://developer.android.com/studio |
| **Java JDK 17** | 编译环境 | https://adoptium.net |
| **Node.js** | Web构建 | https://nodejs.org |

### 2. 环境变量配置

```bash
# 添加到 ~/.zshrc 或 ~/.bash_profile
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export JAVA_HOME=/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home
```

---

## 📱 构建步骤

### 步骤 1: 打开项目

```bash
cd /Users/laosan/.openclaw/workspace/projects/fittrack-pro/android
```

### 步骤 2: 生成签名密钥（只需一次）

```bash
keytool -genkey -v \
  -keystore app/fittrack-pro.keystore \
  -alias fittrack \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000

# 密钥信息:
# 密钥库密码: fittrack2024
# 密钥别名: fittrack
# 密钥密码: fittrack2024
```

### 步骤 3: 使用 Android Studio 构建

1. **打开 Android Studio**
   ```bash
   open -a "Android Studio" android/
   ```

2. **等待 Gradle 同步完成**
   - 首次打开会自动下载依赖
   - 可能需要 5-10 分钟

3. **生成签名 APK**
   - 菜单栏: `Build` → `Generate Signed Bundle / APK...`
   - 选择: `APK`
   - Key store path: 选择 `app/fittrack-pro.keystore`
   - 输入密码: `fittrack2024`
   - Key alias: `fittrack`
   - 点击 `Next`
   - Build variants: `release`
   - 点击 `Finish`

4. **获取 APK**
   - 生成位置: `android/app/release/app-release.apk`

---

## 📤 上传到 Google Play

### 步骤 1: 访问 Google Play Console

https://play.google.com/console

### 步骤 2: 创建新应用

1. 点击 "创建应用"
2. 应用名称: `FitTrack Pro - 健身打卡`
3. 默认语言: `中文（简体）`
4. 应用类型: `应用`
5. 付费或免费: `免费`
6. 勾选声明
7. 点击 "创建应用"

### 步骤 3: 填写应用信息

#### 主要信息
- **应用名称**: FitTrack Pro - 健身打卡
- **简短说明**: 您的个人健身助手，帮助您记录每日步数、消耗卡路里...
- **完整说明**: (复制 google-play.html 中的长描述)

#### 图形资源
- **应用图标**: 上传 512×512 PNG (用 icon-generator.html 生成)
- **功能图**: 上传 1024×500 PNG (用 icon-generator.html 生成)
- **手机截图**: 上传 4-8 张 1080×1920 PNG

### 步骤 4: 设置应用内容

1. **内容分级**
   - 类别: `健康与健身`
   - 内容分级: `适合所有人`

2. **目标受众**
   - 主要受众: `成年人、青少年`
   - 不包含儿童内容

3. **新闻应用**: 否

4. **COVID-19**: 否

5. **数据安全**
   - 隐私政策 URL: https://your-domain.com/privacy-policy.html
   - 数据加密: 是
   - 数据收集: 位置、健康数据

### 步骤 5: 选择国家/地区

- 建议先选择: 印度、印尼、越南、菲律宾、泰国
- 后期再开放其他地区

### 步骤 6: 上传 APK

1. 左侧菜单: `正式版` → `创建新版本`
2. 点击 `继续`
3. 上传 APK 文件
4. 版本说明: "首个版本发布"
5. 点击 `保存` → `审核版本`

---

## 🔧 后续更新

### 修改 Web 内容

```bash
# 修改 www/index.html 后，同步到 Android
npx cap sync android
```

### 重新构建

1. 打开 Android Studio
2. `Build` → `Generate Signed Bundle / APK...`
3. 生成新版本 APK
4. 上传到 Google Play Console

---

## ⚠️ 重要提醒

### 审核前检查

- [ ] 应用能正常打开
- [ ] 所有功能正常工作
- [ ] 没有崩溃或 ANR
- [ ] 隐私政策链接可访问
- [ ] 权限说明完整
- [ ] 应用内容符合政策

### 常见拒绝原因

| 原因 | 解决方案 |
|------|----------|
| 隐私政策缺失 | 确保上传隐私政策页面 |
| 权限过多 | 只申请必要的权限 |
| 功能不完整 | 确保所有按钮有响应 |
| 误导用户 | 描述准确，不夸大功能 |
| 包含测试内容 | 移除所有测试数据和账号 |

---

## 📊 发布后监控

### 关键指标

- 下载量
- 活跃用户
- 崩溃率 (需 < 1%)
- ANR 率 (需 < 0.5%)
- 用户评分

### 定期维护

- 每周检查崩溃报告
- 回复用户评论
- 每月功能更新
- 及时修复 Bug

---

## 🆘 常见问题

### Q: Gradle 同步失败
A: 检查网络连接，尝试更换镜像源

### Q: 签名失败
A: 检查密钥库路径和密码是否正确

### Q: 应用闪退
A: 检查 WebView 是否支持，检查权限申请

### Q: Google Play 拒绝
A: 仔细阅读拒绝原因，修改后重新提交

---

## 📞 技术支持

如有问题，请联系：
- 📧 support@fittrack.pro

---

**祝上架顺利！🎉**