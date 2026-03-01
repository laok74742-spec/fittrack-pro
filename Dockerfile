# 使用 Docker 构建 APK
FROM openjdk:17-jdk-slim

# 安装必要工具
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    git \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# 设置 Android SDK
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH=${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools

# 下载 Android SDK
RUN mkdir -p ${ANDROID_HOME}/cmdline-tools \
    && wget -q https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O /tmp/cmdline-tools.zip \
    && unzip -q /tmp/cmdline-tools.zip -d ${ANDROID_HOME}/cmdline-tools \
    && mv ${ANDROID_HOME}/cmdline-tools/cmdline-tools ${ANDROID_HOME}/cmdline-tools/latest \
    && rm /tmp/cmdline-tools.zip

# 接受许可证并安装必要组件
RUN yes | sdkmanager --licenses \
    && sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.0"

# 工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 安装 Node.js 依赖并同步 Capacitor
RUN npm install \
    && npx cap sync android

# 生成签名密钥（如果不存在）
RUN if [ ! -f android/app/fittrack-pro.keystore ]; then \
    keytool -genkey -v \
        -keystore android/app/fittrack-pro.keystore \
        -alias fittrack \
        -keyalg RSA \
        -keysize 2048 \
        -validity 10000 \
        -storepass fittrack2024 \
        -keypass fittrack2024 \
        -dname "CN=FitTrack Pro, OU=Health, O=FitTrack, L=Beijing, ST=Beijing, C=CN"; \
    fi

# 构建 APK
RUN cd android && ./gradlew assembleRelease

# 复制输出
RUN mkdir -p /output \
    && cp android/app/build/outputs/apk/release/app-release.apk /output/FitTrackPro.apk

CMD ["cp", "/output/FitTrackPro.apk", "/output/apk/"]