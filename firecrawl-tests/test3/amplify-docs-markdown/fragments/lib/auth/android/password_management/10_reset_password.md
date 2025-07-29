---
title: Documentation
source: fragments/lib/auth/android/password_management/10_reset_password.mdx
---

# Documentation

```java
Amplify.Auth.resetPassword(
   "username",
   result -> Log.i("AuthQuickstart", result.toString()),
   error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.resetPassword("username",
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.resetPassword("username")
    .subscribe(
        result -> Log.i("AuthQuickstart", result.toString()),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>
