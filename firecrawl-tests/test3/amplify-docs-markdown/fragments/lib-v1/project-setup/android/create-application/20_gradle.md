---
title: Documentation
source: fragments/lib-v1/project-setup/android/create-application/20_gradle.mdx
---

# Documentation

Amplify for Android is distributed as Apache Maven packages. In this section, you'll add the packages and other required directives to your build configuration.

Under **Gradle Scripts**, open **build.gradle (Module :app)**.

Add the following lines:

```groovy
android 
}

dependencies 
```

- Set `coreLibraryDesugaringEnabled`, `sourceCompatibility`, and `targetCompatibility` to allow your application to make use of Java 8 features like Lambda expressions
- Add Amplify Core and Desugaring libraries to the `dependencies` block

> **Note**: 

  Amplify Android supports API levels 16 and higher. If your are supporting a min SDK less than 21, follow [Android's documentation on adding multidex support](https://developer.android.com/studio/build/multidex#mdex-pre-l).

Run **Gradle Sync**

Android Studio requires you to sync your project with your new configuration. To do this, click **Sync Now** in the notification bar above the file editor.

![Screenshot with an arrow pointing to the Sync Now button in the file's notification bar](/images/lib/getting-started/android/set-up-android-studio-sync-gradle.png)

When complete, you will see _CONFIGURE SUCCESSFUL_ in the output in the _Build_ tab at the bottom of your screen.

![Shows Android studio gradle sync successful](/images/lib/getting-started/android/set-up-android-studio-configure-successful.png)
