---
title: Documentation
source: fragments/lib/push-notifications/android/getting_started/40_install_lib.mdx
---

# Documentation

Open **build.gradle (Module :app)** and add these libraries into the `dependencies` block.

```groovy
dependencies 
```
Click **Sync Now** when prompted.

Add the following service to your app's AndroidManifest.xml file:

```xml
<application ...>
  ...
    <service android:name="com.amplifyframework.pushnotifications.pinpoint.FCMPushNotificationService" 
    android:exported="false">
        <intent-filter>
            <action android:name="com.google.firebase.MESSAGING_EVENT" />
        </intent-filter>
    </service>
  ...
</application>
```
