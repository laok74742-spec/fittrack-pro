# FitTrack Pro - APK 构建指南

## 🚀 快速构建

### macOS/Linux
```bash
cd fittrack-pro
./build.sh
```

### Windows
```cmd
cd fittrack-pro
build.bat
```

## 📦 手动构建步骤

### 1. 环境要求
- Java 17 (JDK)
- Android SDK
- Node.js 18+

### 2. 安装依赖
```bash
cd fittrack-pro
npm install
```

### 3. 生成签名密钥（只需一次）
```bash
cd android/app
keytool -genkey -v \
  -keystore fittrack-pro.keystore \
  -alias fittrack \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -storepass fittrack2024 \
  -keypass fittrack2024
```

### 4. 同步项目
```bash
npx cap sync android
```

### 5. 构建 APK
```bash
cd android
./gradlew assembleRelease
```

APK 输出位置：`android/app/build/outputs/apk/release/app-release.apk`

## 🎯 使用 Android Studio 构建

1. 打开 Android Studio
2. 选择 `Open an existing project`
3. 选择 `fittrack-pro/android` 文件夹
4. 等待 Gradle 同步完成
5. 菜单栏：`Build` → `Generate Signed Bundle / APK...`
6. 选择 `APK`
7. 填写签名信息：
   - Key store path: `app/fittrack-pro.keystore`
   - Key store password: `fittrack2024`
   - Key alias: `fittrack`
   - Key password: `fittrack2024`
8. Build variants: `release`
9. 点击 `Finish`

## ⚠️ 常见问题

### 1. Gradle 同步失败
**解决**: 检查网络连接，尝试使用镜像
```gradle
// 在 build.gradle 中添加
repositories {
    maven { url 'https://maven.aliyun.com/repository/public' }
    google()
    mavenCentral()
}
```

### 2. 签名失败
**解决**: 确保密钥库路径正确，密码是 `fittrack2024`

### 3. 构建成功但安装失败
**解决**: 卸载旧版本再安装，或检查签名是否一致

## 📋 APK 信息

| 属性 | 值 |
|------|-----|
| 包名 | com.fittrack.pro |
| 版本 | 1.0.0 |
| 最低 Android 版本 | 6.0 (API 23) |
| 目标 Android 版本 | 13 (API 33) |
| 签名算法 | RSA |
| 有效期 | 10000 天 |

## 🔐 签名信息

- **密钥别名**: fittrack
- **密钥密码**: fittrack2024
- **密钥库密码**: fittrack2024

⚠️ **重要**: 请妥善保管签名密钥文件 `fittrack-pro.keystore`，丢失后无法更新应用！

## 📤 上传到 Google Play

1. 访问 https://play.google.com/console
2. 创建新应用
3. 选择 `正式版` → `创建新版本`
4. 上传 `app-release.apk`
5. 填写版本说明
6. 提交审核

## 🛠️ 技术栈

- **框架**: Capacitor 5
- **平台**: Android
- **Web技术**: HTML5, CSS3, JavaScript
- **最低API**: 23 (Android 6.0)
- **目标API**: 33 (Android 13)

## 📞 技术支持

如有问题，请参考 BUILD-GUIDE.md 或联系技术支持。

---

**构建日期**: 2026-02-28
**版本**: 1.0.0