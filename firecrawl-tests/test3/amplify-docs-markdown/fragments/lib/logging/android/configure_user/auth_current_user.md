---
title: Documentation
source: fragments/lib/logging/android/configure_user/auth_current_user.mdx
---

# Documentation

```java
Amplify.Auth.getCurrentUser(
   user.userId,
   error -> // failed to fetch user
);
```
</Block>

```kotlin
Amplify.Auth.getCurrentUser()
```

</Block>

```java
RxAmplify.Auth.getCurrentUser().subscribe(
        result -> result.userId,
        error -> // failed to get user
 );
```

</Block>
</BlockSwitcher>
