#!/bin/bash

# FitTrack Pro APK 构建脚本

echo "🚀 FitTrack Pro APK 构建脚本"
echo "============================="
echo ""

# 颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 检查环境
check_env() {
    echo "📋 检查构建环境..."
    
    # 检查 Java
    if ! command -v java &> /dev/null; then
        echo -e "${RED}✗ Java 未安装${NC}"
        echo "请安装 Java 17: https://adoptium.net"
        exit 1
    fi
    echo -e "${GREEN}✓ Java 已安装${NC}"
    
    # 检查 Android SDK
    if [ -z "$ANDROID_HOME" ]; then
        echo -e "${YELLOW}⚠ ANDROID_HOME 未设置${NC}"
        echo "尝试自动检测..."
        
        # macOS 常见路径
        if [ -d "$HOME/Library/Android/sdk" ]; then
            export ANDROID_HOME="$HOME/Library/Android/sdk"
            echo -e "${GREEN}✓ 找到 Android SDK: $ANDROID_HOME${NC}"
        else
            echo -e "${RED}✗ 未找到 Android SDK${NC}"
            echo "请安装 Android Studio 并设置 ANDROID_HOME"
            exit 1
        fi
    fi
    
    echo -e "${GREEN}✓ Android SDK: $ANDROID_HOME${NC}"
}

# 生成签名密钥
generate_keystore() {
    if [ -f "android/app/fittrack-pro.keystore" ]; then
        echo -e "${GREEN}✓ 签名密钥已存在${NC}"
        return
    fi
    
    echo "🔐 生成签名密钥..."
    
    keytool -genkey -v \
        -keystore android/app/fittrack-pro.keystore \
        -alias fittrack \
        -keyalg RSA \
        -keysize 2048 \
        -validity 10000 \
        -storepass fittrack2024 \
        -keypass fittrack2024 \
        -dname "CN=FitTrack Pro, OU=Health, O=FitTrack, L=Beijing, ST=Beijing, C=CN"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ 签名密钥生成成功${NC}"
    else
        echo -e "${RED}✗ 签名密钥生成失败${NC}"
        exit 1
    fi
}

# 同步 Capacitor
sync_capacitor() {
    echo "🔄 同步 Capacitor..."
    
    npx cap sync android
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Capacitor 同步成功${NC}"
    else
        echo -e "${RED}✗ Capacitor 同步失败${NC}"
        exit 1
    fi
}

# 构建 APK
build_apk() {
    echo "📦 构建 APK..."
    
    cd android
    
    # 清理旧构建
    ./gradlew clean
    
    # 构建 Release APK
    ./gradlew assembleRelease
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ APK 构建成功${NC}"
        
        # 复制到根目录
        mkdir -p ../release
        cp app/build/outputs/apk/release/app-release.apk ../release/FitTrackPro-v1.0.0.apk
        
        echo ""
        echo -e "${GREEN}🎉 APK 构建完成！${NC}"
        echo "位置: release/FitTrackPro-v1.0.0.apk"
        echo ""
        echo "📊 APK 信息:"
        ls -lh ../release/FitTrackPro-v1.0.0.apk
    else
        echo -e "${RED}✗ APK 构建失败${NC}"
        exit 1
    fi
}

# 主流程
main() {
    check_env
    generate_keystore
    sync_capacitor
    build_apk
}

# 运行
main