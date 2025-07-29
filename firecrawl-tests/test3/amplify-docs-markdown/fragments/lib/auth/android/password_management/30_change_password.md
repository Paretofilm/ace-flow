---
title: Documentation
source: fragments/lib/auth/android/password_management/30_change_password.mdx
---

# Documentation

```java
Amplify.Auth.updatePassword(
    "existingPassword",
    "newPassword",
    () -> Log.i("AuthQuickstart", "Updated password successfully"),
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.updatePassword("existingPassword", "newPassword",
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.updatePassword("existingPassword", "newPassword")
    .subscribe(
        () -> Log.i("AuthQuickstart", "Updated password successfully"),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>
