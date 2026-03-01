@echo off
chcp 65001 > nul

echo 🚀 FitTrack Pro APK 构建脚本
echo =============================
echo.

echo 📋 检查构建环境...

:: 检查 Java
java -version > nul 2>&1
if errorlevel 1 (
    echo [ERROR] Java 未安装
    echo 请安装 Java 17: https://adoptium.net
    pause
    exit /b 1
)
echo [OK] Java 已安装

:: 检查 Android SDK
if "%ANDROID_HOME%"=="" (
    echo [WARNING] ANDROID_HOME 未设置
    echo 尝试自动检测...
    
    if exist "%LOCALAPPDATA%\Android\Sdk" (
        set ANDROID_HOME=%LOCALAPPDATA%\Android\Sdk
        echo [OK] 找到 Android SDK: %ANDROID_HOME%
    ) else (
        echo [ERROR] 未找到 Android SDK
        echo 请安装 Android Studio 并设置 ANDROID_HOME
        pause
        exit /b 1
    )
)
echo [OK] Android SDK: %ANDROID_HOME%

:: 生成签名密钥
if not exist "android\app\fittrack-pro.keystore" (
    echo 🔐 生成签名密钥...
    keytool -genkey -v -keystore android\app\fittrack-pro.keystore -alias fittrack -keyalg RSA -keysize 2048 -validity 10000 -storepass fittrack2024 -keypass fittrack2024 -dname "CN=FitTrack Pro, OU=Health, O=FitTrack, L=Beijing, ST=Beijing, C=CN"
    if errorlevel 1 (
        echo [ERROR] 签名密钥生成失败
        pause
        exit /b 1
    )
    echo [OK] 签名密钥生成成功
) else (
    echo [OK] 签名密钥已存在
)

:: 同步 Capacitor
echo 🔄 同步 Capacitor...
npx cap sync android
if errorlevel 1 (
    echo [ERROR] Capacitor 同步失败
    pause
    exit /b 1
)
echo [OK] Capacitor 同步成功

:: 构建 APK
echo 📦 构建 APK...
cd android

:: 清理旧构建
gradlew clean
if errorlevel 1 (
    echo [WARNING] 清理失败，继续构建...
)

:: 构建 Release APK
gradlew assembleRelease
if errorlevel 1 (
    echo [ERROR] APK 构建失败
    cd ..
    pause
    exit /b 1
)

echo [OK] APK 构建成功

:: 复制到根目录
if not exist "..\release" mkdir "..\release"
copy "app\build\outputs\apk\release\app-release.apk" "..\release\FitTrackPro-v1.0.0.apk"

cd ..

echo.
echo 🎉 APK 构建完成！
echo 位置: release\FitTrackPro-v1.0.0.apk
echo.
echo 📊 APK 信息:
dir release\FitTrackPro-v1.0.0.apk

pause