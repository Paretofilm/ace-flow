---
title: iOS
source: fragments/lib-v1/project-setup/flutter/platform-setup/platform-setup.mdx
---

# iOS

### iOS
From your project root, navigate to the `ios/` directory and modify the `Podfile` using a text editor of your choice and update the target iOS platform to 11.0 or higher.

```bash
platform :ios, '11.0'
```

> **Note**: 

When preparing your application for deployment, you should also update your iOS Deployment Target to at least 11.0. See the [Flutter docs](https://docs.flutter.dev/deployment/ios) to learn more about building your iOS app for release.

### Android
From your project root, navigate to the `android/app/` directory and modify `build.gradle` using a text editor of your choice and update the target Android SDK version to 21 or higher:

```bash
minSdkVersion 21
```
