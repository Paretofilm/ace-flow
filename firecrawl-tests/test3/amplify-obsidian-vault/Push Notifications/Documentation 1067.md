---
title: Documentation
topics: ['Push Notifications']
primary_topic: Push Notifications
source: fragments/lib/push-notifications/android/identify_user/20_send_to_pinpoint.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, push-notifications]
---


## 🧭 Navigation
**Topics**: [[Push Notifications/]]
**Primary**: [[Push Notifications/]]

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


---

## 📚 Related Topics
- [[Push Notifications/]]

## 📖 Source
Original: `fragments/lib/push-notifications/android/identify_user/20_send_to_pinpoint.mdx`