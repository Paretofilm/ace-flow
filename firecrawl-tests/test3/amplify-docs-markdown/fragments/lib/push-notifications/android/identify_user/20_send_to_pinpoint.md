---
title: Documentation
source: fragments/lib/push-notifications/android/identify_user/20_send_to_pinpoint.mdx
---

# Documentation

```java
Amplify.Notifications.Push.identifyUser(user,
   () -> Log.i("MyAmplifyApp", "Identified user successfully"),
    error -> Log.e("MyAmplifyApp", "Error identifying user", error)
);
```

</Block>

```kotlin
Amplify.Notifications.Push.identifyUser(user,
    ,
    
)
```

</Block>

```kotlin
try  catch (error: PushNotificationsException) 
```

</Block>

```java
RxAmplify.Notifications.Push.identifyuser(user).subscribe(
    () -> Log.i("MyAmplifyApp", "Identified user successfully"),
    error -> Log.e("MyAmplifyApp", "Error identifyUser user", error)
);
```

</Block>
</BlockSwitcher>
