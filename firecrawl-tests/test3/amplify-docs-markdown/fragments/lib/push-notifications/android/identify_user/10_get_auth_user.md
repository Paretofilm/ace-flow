---
title: Documentation
source: fragments/lib/push-notifications/android/identify_user/10_get_auth_user.mdx
---

# Documentation

If the user is signed in through [Amplify.Auth.signIn](/gen1/[platform]/build-a-backend/auth/enable-sign-in/), then you can retrieve the current user's ID as shown below:

```java
Amplify.Auth.getCurrentUser(
    authUser -> String userId = authUser.getUserId(),
    error -> Log.e("MyAmplifyApp", "Error getting current user", error)
);
```

</Block>

```kotlin
Amplify.Auth.getCurrentUser(
    , 
    
)
```

</Block>

```kotlin
try  catch (error: PushNotificationsException) 
```

</Block>

```java
RxAmplify.Auth.getCurrentUser().subscribe(
    authUser -> String userId = authUser.getUserId(),
    error -> Log.e("MyAmplifyApp", "Error getting current user", error)
);
```

</Block>
</BlockSwitcher>
