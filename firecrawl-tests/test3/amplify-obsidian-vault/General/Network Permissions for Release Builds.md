---
title: Network Permissions for Release Builds
topics: ['General']
primary_topic: General
source: fragments/lib/project-setup/flutter/platform-setup/android.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Network Permissions for Release Builds

Amplify Flutter supports API level 24+ (Android 7.0+), and requires Gradle 8+, Kotlin 1.9+, and Java 17+ when targeting Android. Follow the steps below to apply these changes in your app. 

> **Note**: 
The steps below are intended for Flutter apps created with Flutter version 3.16+. If your app was created prior to version 3.16, please follow the guide [here](https://docs.flutter.dev/release/breaking-changes/flutter-gradle-plugin-apply) to migrate to Gradle's declarative plugins block before following the steps below.

1. Open `android/settings.gradle.kts` and update the Android Gradle plugin and kotlin versions:

```diff title="android/settings.gradle.kts"
plugins 
```

2. Open `android/gradle/wrapper/gradle-wrapper.properties` and update the Gradle `distributionUrl`.

```diff title="android/gradle/wrapper/gradle-wrapper.properties"
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
-distributionUrl=https\://services.gradle.org/distributions/gradle-8.10.2-all.zip
+distributionUrl=https\://services.gradle.org/distributions/gradle-8.4-all.zip
```

3. Open `android/app/build.gradle.kts` and update the Java version and minimum Android SDK version.

```diff title="android/app/build.gradle.kts"
android 

    kotlinOptions 

    defaultConfig 
    
    buildTypes 
    }
}
```
</Block>

1. Open `android/settings.gradle` and update the Android Gradle plugin and kotlin versions:

```diff title="android/settings.gradle"
plugins 
```

2. Open `android/gradle/wrapper/gradle-wrapper.properties` and update the Gradle `distributionUrl`.

```diff title="android/gradle/wrapper/gradle-wrapper.properties"
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
-distributionUrl=https\://services.gradle.org/distributions/gradle-7.0-all.zip
+distributionUrl=https\://services.gradle.org/distributions/gradle-8.4-all.zip
```

3. Open `android/app/build.gradle` and update the Java version and minimum Android SDK version.

```diff title="android/app/build.gradle"
android 

    defaultConfig 
    
    buildTypes 
    }
}
```
</Block>
</BlockSwitcher>

> **Note**: 
If you would like to use a higher version of Gradle or Android Gradle plugin see the compatibility matrix [here](https://developer.android.com/build/releases/gradle-plugin#updating-gradle).

### Network Permissions for Release Builds

Flutter apps have access to make network requests by default in debug mode. This permission needs to be added when building in release mode. To do this, open `android/app/src/main/AndroidManifest.xml` and make the following addition.

```xml title="android/app/src/main/AndroidManifest.xml"
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
// highlight-start
   <uses-permission android:name="android.permission.INTERNET"/>
// highlight-end
...
</manifest>
```


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/project-setup/flutter/platform-setup/android.mdx`