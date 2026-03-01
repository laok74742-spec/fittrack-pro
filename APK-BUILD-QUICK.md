# 🚀 APK 快速构建指南

由于本地环境限制，我为你准备了**3种构建方式**：

---

## 方式1：GitHub Actions 自动构建（推荐）

**最简单，无需配置环境**

### 步骤：

1. **上传代码到 GitHub**
   ```bash
   # 在 fittrack-pro 目录下
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/你的用户名/fittrack-pro.git
   git push -u origin main
   ```

2. **自动构建**
   - 访问 GitHub 仓库
   - 点击 `Actions` 标签
   - 选择 `Build APK` 工作流
   - 点击 `Run workflow`

3. **下载 APK**
   - 等待构建完成（约5分钟）
   - 点击最新的 workflow run
   - 在 `Artifacts` 部分下载 `FitTrackPro-APK`

---

## 方式2：Docker 构建（本地）

**需要安装 Docker**

### 步骤：

```bash
cd fittrack-pro

# 构建 Docker 镜像
docker build -t fittrack-builder .

# 运行构建
docker run -v $(pwd)/output:/output fittrack-builder

# APK 将在 output/FitTrackPro.apk
```

---

## 方式3：Android Studio 构建（本地）

**最可靠，需要安装 Android Studio**

### 步骤：

1. **安装 Android Studio**
   - 下载：https://developer.android.com/studio
   - 安装时选择 Standard 配置

2. **打开项目**
   - 打开 Android Studio
   - 选择 `Open an existing project`
   - 选择 `fittrack-pro/android` 文件夹

3. **等待同步**
   - 首次打开会下载 Gradle 依赖（约5-10分钟）

4. **生成签名密钥**（只需一次）
   ```bash
   cd android/app
   keytool -genkey -v \
     -keystore fittrack-pro.keystore \
     -alias fittrack \
     -keyalg RSA \
     -keysize 2048 \
     -validity 10000 \
     -storepass fittrack2024 \
     -keypass fittrack2024 \
     -dname "CN=FitTrack Pro, OU=Health, O=FitTrack, L=Beijing, ST=Beijing, C=CN"
   ```

5. **构建 APK**
   - 菜单栏：`Build` → `Generate Signed Bundle / APK...`
   - 选择 `APK`
   - Key store path: `app/fittrack-pro.keystore`
   - 密码：`fittrack2024`
   - Build variants: `release`
   - 点击 `Finish`

6. **获取 APK**
   - 位置：`android/app/build/outputs/apk/release/app-release.apk`

---

## 📱 APK 信息

| 属性 | 值 |
|------|-----|
| 应用名称 | FitTrack Pro |
| 包名 | com.fittrack.pro |
| 版本 | 1.0.0 (1) |
| 最低 Android | 6.0 (API 23) |
| 目标 Android | 13 (API 33) |
| 大小 | 约 5-10 MB |

---

## 🔐 签名信息

- **密钥库**: fittrack-pro.keystore
- **别名**: fittrack
- **密码**: fittrack2024
- **有效期**: 10000 天

⚠️ **请妥善保管签名密钥，丢失后无法更新应用！**

---

## 📤 上传到 Google Play

1. 访问 https://play.google.com/console
2. 注册开发者账号（$25 USD）
3. 创建新应用
4. 上传 APK
5. 填写应用信息
6. 提交审核

---

## 🆘 常见问题

### Q: 构建失败 "Could not find JDK"
**A**: 安装 Java 17：https://adoptium.net

### Q: 构建失败 "SDK not found"
**A**: 设置 ANDROID_HOME 环境变量

### Q: 签名失败
**A**: 检查密钥库路径和密码是否正确

### Q: 没有 Android Studio
**A**: 使用 GitHub Actions 方式，无需本地环境

---

## 🎯 推荐方案

| 你的情况 | 推荐方式 | 时间 |
|---------|---------|------|
| 没有开发环境 | GitHub Actions | 10分钟 |
| 有 Docker | Docker 构建 | 15分钟 |
| 有 Android Studio | Android Studio | 10分钟 |

---

## 📞 需要帮助？

如果需要远程协助构建，请联系我！

---

**准备好后，运行对应的构建命令即可生成 APK！** 🎉