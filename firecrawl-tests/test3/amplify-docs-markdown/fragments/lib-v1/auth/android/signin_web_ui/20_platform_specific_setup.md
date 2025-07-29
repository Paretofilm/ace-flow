---
title: Update AndroidManifest.xml
source: fragments/lib-v1/auth/android/signin_web_ui/20_platform_specific_setup.mdx
---

# Update AndroidManifest.xml

## Update AndroidManifest.xml

Add the following activity and queries tag to your app's `AndroidManifest.xml` file, replacing `myapp` with
your redirect URI prefix if necessary:

```xml
<queries>
  <intent>
    <action android:name="android.intent.action.VIEW" />
    <data android:scheme="https" />
  </intent>
  <intent>
    <action android:name=
        "android.support.customtabs.action.CustomTabsService" />
  </intent>
</queries>
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

</Block>

**Note:** These versions have known issues with sign-out after signing in via web UI.
Please update to the latest version and follow the updated instructions for best results.

Add the following activity to your app's `AndroidManifest.xml` file, replacing `myapp` with
whatever value you used for your redirect URI prefix:

```xml
<activity
    android:name="com.amazonaws.mobileconnectors.cognitoauth.activities.CustomTabsRedirectActivity"
    android:exported="true">
    <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data android:scheme="myapp" />
    </intent-filter>
</activity>
```

> **Note**: 
These instructions have been updated since version 1.2.0. If you set this up for a version of Amplify prior to 1.2.0, be sure to remove the `intent-filter` with `android:scheme` from your own activity as well as the `singleInstance` launch mode.

</Block>
</BlockSwitcher>

### Add Response Handler

> **Note**: 
If you are using a version of Amplify 1.17.8 or above and have already declared HostedUIRedirectActivity in your manifest file, you only need to add the result handler if you need to capture sign in cancellations that occurred before the user submitted credentials.

Add the following result handler to whichever `Activity` you are calling HostedUI from:

```java
@Override
protected void onActivityResult(int requestCode, int resultCode, Intent data) 
}
```

</Block>

```kotlin
override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) 
}
```

 </Block>
</BlockSwitcher>

> **Note**: 
If you are using a version of Amplify below 1.17.8, you must add the following sign in result handler.

```java
@Override
protected void onActivityResult(int requestCode, int resultCode, Intent data) 
}
```

</Block>

```kotlin
override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) 
}
```

</Block>

```kotlin
override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) 
}
```

</Block>

```java
@Override
protected void onActivityResult(int requestCode, int resultCode, Intent data) 
}
```

 </Block>
</BlockSwitcher>

> **Note**: 
If you set this up for a version of Amplify prior to 1.2.0, be sure to remove the `onNewIntent` method code from your `Activity` that was previously specified.
