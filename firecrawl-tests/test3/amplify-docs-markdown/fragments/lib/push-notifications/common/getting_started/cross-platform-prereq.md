---
title: Set Entitlements
source: fragments/lib/push-notifications/common/getting_started/cross-platform-prereq.mdx
---

# Set Entitlements

You should have [completed the CLI and project setup steps.](/gen1/[platform]/start/project-setup/prerequisites/)

An application targeting at least iOS 13.0, using Xcode 14.1 or later.

### Set Entitlements

Using Amplify Push Notifications with APNs requires the following capabilities:

- Push Notifications
- Background Processing -> Remote Notifications

To add these capabilities:

</Block>

An application targeting at least Android SDK API level 24.

### Applying the Google services plugin

The Firebase documentation directs you to add the Google services plugin to your app `build.gradle` using the [Gradle plugins DSL](https://docs.gradle.org/current/userguide/plugins.html#sec:plugins_block). However, we recommend you continue to use the [Legacy Plugin Application](https://docs.gradle.org/current/userguide/plugins.html#sec:old_plugin_application) instead:

```groovy
apply plugin: 'com.google.gms.google-services'
```

If you prefer using the plugins DSL, you should add the `plugins` block to the very top of the file or you may experience issues when building your app for Android.

</InlineFilter>

1. Open `android/settings.gradle.kts` and add the Google Services plugin:
```diff title="android/settings.gradle.kts"
plugins 
```
2. Open `android/app/build.gradle.kts` and add the Google Services plugin:
```diff title="android/app/build.gradle.kts"
plugins 
```
</Block>

The Firebase documentation directs you to add the Google services plugin to your app `settings.gradle` using the [Gradle plugins DSL](https://docs.gradle.org/current/userguide/plugins.html#sec:plugins_block). However, we recommend you continue to use the [Legacy Plugin Application](https://docs.gradle.org/current/userguide/plugins.html#sec:old_plugin_application) instead:

```groovy
id "com.google.gms.google-services" version "4.3.14" apply false
```
</Block>
</BlockSwitcher>

</InlineFilter>

</Block>
</BlockSwitcher>
