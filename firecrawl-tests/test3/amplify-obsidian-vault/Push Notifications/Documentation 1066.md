---
title: Documentation
topics: ['Push Notifications']
primary_topic: Push Notifications
source: fragments/lib/push-notifications/android/identify_user/30_send_to_pinpoint_profile.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, push-notifications]
---


## 🧭 Navigation
**Topics**: [[Push Notifications/]]
**Primary**: [[Push Notifications/]]

---


# Documentation

Alternatively, you can provide additional information about the user by passing a user profile:

```java
AWSNotificationsUserProfile profile = AWSNotificationsUserProfile.builder()
    .name("Name")
    .build()

Amplify.Analytics.identifyUser(
    user,
    profile,
   () -> Log.i("MyAmplifyApp", "Identified user successfully"),
    error -> Log.e("MyAmplifyApp", "Error identifying user", error)
);
```

</Block>

```kotlin
val profile = AWSNotificationsUserProfile.builder()
    .name("Name")
    .build()

Amplify.Analytics.identifyUser(
    user,
    profile,
    ,
    
)
```

</Block>

```kotlin
val profile = AWSNotificationsUserProfile.builder()
    .name("Name")
    .build()

try  catch (error: PushNotificationsException) 
```

</Block>

```java
AWSNotificationsUserProfile profile = AWSNotificationsUserProfile.builder()
    .name("Name")
    .build()
    
RxAmplify.Notifications.Push.identifyuser(user, profile).subscribe(
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
Original: `fragments/lib/push-notifications/android/identify_user/30_send_to_pinpoint_profile.mdx`