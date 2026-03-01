#!/bin/bash

echo "🚀 FitTrack Pro - 上架前检查脚本"
echo "================================"
echo ""

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

check_result=0

# 检查文件是否存在
echo "📁 检查必要文件..."

files=(
    "www/index.html"
    "www/privacy-policy.html"
    "android/app/build.gradle"
    "android/app/src/main/AndroidManifest.xml"
    "capacitor.config.json"
    "BUILD-GUIDE.md"
)

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✓${NC} $file"
    else
        echo -e "${RED}✗${NC} $file (缺失)"
        check_result=1
    fi
done

echo ""
echo "📱 检查 Android 项目..."

# 检查 Android 项目是否存在
if [ -d "android" ]; then
    echo -e "${GREEN}✓${NC} Android 项目已创建"
else
    echo -e "${RED}✗${NC} Android 项目不存在，请先运行: npx cap add android"
    check_result=1
fi

# 检查签名密钥配置
if grep -q "fittrack-pro.keystore" android/app/build.gradle; then
    echo -e "${GREEN}✓${NC} 签名配置已添加"
else
    echo -e "${RED}✗${NC} 签名配置未找到"
    check_result=1
fi

echo ""
echo "🔐 检查权限配置..."

# 检查必要权限
permissions=(
    "INTERNET"
    "ACTIVITY_RECOGNITION"
)

for perm in "${permissions[@]}"; do
    if grep -q "android.permission.$perm" android/app/src/main/AndroidManifest.xml; then
        echo -e "${GREEN}✓${NC} 权限: $perm"
    else
        echo -e "${RED}✗${NC} 权限缺失: $perm"
        check_result=1
    fi
done

echo ""
echo "📦 检查应用信息..."

# 检查包名
if grep -q 'com.fittrack.pro' capacitor.config.json; then
    echo -e "${GREEN}✓${NC} 包名: com.fittrack.pro"
else
    echo -e "${YELLOW}⚠${NC} 包名检查失败"
fi

# 检查应用名称
if grep -q 'FitTrackPro' capacitor.config.json; then
    echo -e "${GREEN}✓${NC} 应用名称: FitTrackPro"
else
    echo -e "${YELLOW}⚠${NC} 应用名称检查失败"
fi

echo ""
echo "🌐 检查网络配置..."

# 检查是否允许明文传输（开发环境）
if grep -q 'usesCleartextTraffic="true"' android/app/src/main/AndroidManifest.xml; then
    echo -e "${YELLOW}⚠${NC} 允许明文HTTP传输 (仅开发环境)"
else
    echo -e "${GREEN}✓${NC} 仅允许HTTPS"
fi

echo ""
echo "📊 检查结果统计"
echo "================"

if [ $check_result -eq 0 ]; then
    echo -e "${GREEN}✅ 所有检查通过！可以开始构建 APK${NC}"
    echo ""
    echo "下一步操作:"
    echo "1. 生成签名密钥:"
    echo "   cd android/app && keytool -genkey -v -keystore fittrack-pro.keystore -alias fittrack -keyalg RSA -keysize 2048 -validity 10000"
    echo ""
    echo "2. 用 Android Studio 打开项目:"
    echo "   open -a 'Android Studio' android/"
    echo ""
    echo "3. 构建签名 APK:"
    echo "   Build → Generate Signed Bundle / APK..."
    echo ""
    exit 0
else
    echo -e "${RED}❌ 发现 $check_result 个问题，请修复后再构建${NC}"
    echo ""
    echo "参考 BUILD-GUIDE.md 解决问题"
    exit 1
fi