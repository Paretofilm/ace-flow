---
title: Documentation
source: fragments/lib/auth/android/password_management/20_confirm_reset_password.mdx
---

# Documentation

```java
Amplify.Auth.confirmResetPassword(
   "Username",
   "NewPassword123",
   "confirmation code you received",
   () -> Log.i("AuthQuickstart", "New password confirmed"),
   error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.confirmResetPassword("Username", "NewPassword123", "confirmation code",
   ,
   
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```
</Block>

```java
RxAmplify.Auth.confirmResetPassword("Username","NewPassword123", "confirmation code")
    .subscribe(
        () -> Log.i("AuthQuickstart", "New password confirmed"),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>
