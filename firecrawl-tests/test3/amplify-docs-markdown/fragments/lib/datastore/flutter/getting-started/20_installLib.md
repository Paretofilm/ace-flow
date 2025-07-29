---
title: Install Amplify Libraries
source: fragments/lib/datastore/flutter/getting-started/20_installLib.mdx
---

# Install Amplify Libraries

## Install Amplify Libraries

Add the following dependencies to your `pubspec.yaml` file and install dependencies when asked:

```yaml
dependencies:
  flutter:
    sdk: flutter

  amplify_datastore: 2.0.0
  amplify_flutter: ^2.0.0
```

### Update The Android Project

1. Open `android/app/build.gradle.kts` and enable `isCoreLibraryDesugaringEnabled` in `compileOptions` to support the Java8 feature used in the DataStore plugin.

```diff title="android/app/build.gradle.kts"
compileOptions 
```

2. Add the following dependency in `dependencies`.

```diff title="android/app/build.gradle.kts"
dependencies 
```
</Block>

Open `build.gradle` located under `android/app`, and enable `coreLibraryDesugaringEnabled` in `compileOptions` to support the Java8 feature used in the DataStore plugin.

```groovy
compileOptions 
```

Add the following dependency in `dependencies`.

```groovy
dependencies 
```
</Block>
</BlockSwitcher>
