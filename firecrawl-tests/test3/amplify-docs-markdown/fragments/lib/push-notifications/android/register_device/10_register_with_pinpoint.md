---
title: Documentation
source: fragments/lib/push-notifications/android/register_device/10_register_with_pinpoint.mdx
---

# Documentation

> **Note**: 

You do not need to add these APIs to your app if you want to use Amplify with Amazon Pinpoint. You should use these APIs if you are interested in supporting multiple push providers.

You can use the `Amplify.Notifications.Push.registerDevice()` method to register the device with Pinpoint.

```java
class MyAppService : FirebaseMessagingService() 
}
```

</Block>

```kotlin
class MyAppService : FirebaseMessagingService() ,
            
        )
    }
}
```

</Block>

```kotlin
class MyAppService : FirebaseMessagingService()  catch (error: PushNotificationsException) 
    }
}
```

</Block>

```java
class MyAppService : FirebaseMessagingService() 
}
```

</Block>
</BlockSwitcher>

You must also add the custom service extension to `AndroidManifest.xml` in the `application` tag:

```xml
<service android:name=".MyAppService"
    android:exported="false">
    <intent-filter>
        <action android:name="com.google.firebase.MESSAGING_EVENT" />
    </intent-filter>
</service>
```
