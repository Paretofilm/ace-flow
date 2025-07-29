---
title: Update AndroidManifest.xml
source: fragments/lib/auth/android/signin_web_ui/20_platform_specific_setup.mdx
---

# Update AndroidManifest.xml

## Update AndroidManifest.xml

Add the following activity and queries tag to your app's `AndroidManifest.xml` file, replacing `myapp` with
your redirect URI prefix if necessary:

```xml
<application ...>
  ...
  <activity
      android:name="com.amplifyframework.auth.cognito.activities.HostedUIRedirectActivity"
      android:exported="true">
      <intent-filter>
          <action android:name="android.intent.action.VIEW" />
          <category android:name="android.intent.category.DEFAULT" />
          <category android:name="android.intent.category.BROWSABLE" />
          <data android:scheme="myapp" />
      </intent-filter>
  </activity>
  ...
</application>
```
