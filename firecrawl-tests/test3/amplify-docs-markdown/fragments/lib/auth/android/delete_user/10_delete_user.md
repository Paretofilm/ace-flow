---
title: Documentation
source: fragments/lib/auth/android/delete_user/10_delete_user.mdx
---

# Documentation

```java
Amplify.Auth.deleteUser(
    () -> Log.i("AuthQuickStart", "Delete user succeeded"),
    error -> Log.e("AuthQuickStart", "Delete user failed with error " + error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.deleteUser(
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.deleteUser()
    .subscribe(
      () -> Log.i("AuthQuickStart", "Delete user succeeded"),
      error -> Log.e("AuthQuickStart", "Delete user failed with error " + error.toString())
    );
```

</Block>
</BlockSwitcher>
