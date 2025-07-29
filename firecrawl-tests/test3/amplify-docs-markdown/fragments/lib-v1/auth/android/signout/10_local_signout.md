---
title: Documentation
source: fragments/lib-v1/auth/android/signout/10_local_signout.mdx
---

# Documentation

```java
Amplify.Auth.signOut(
    () -> Log.i("AuthQuickstart", "Signed out successfully"),
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.signOut(
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.signOut()
    .subscribe(
        () -> Log.i("AuthQuickstart", "Signed out successfully"),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>
