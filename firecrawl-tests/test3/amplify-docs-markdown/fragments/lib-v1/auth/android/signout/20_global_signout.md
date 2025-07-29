---
title: Documentation
source: fragments/lib-v1/auth/android/signout/20_global_signout.mdx
---

# Documentation

```java
Amplify.Auth.signOut(
    AuthSignOutOptions.builder().globalSignOut(true).build(),
    () -> Log.i("AuthQuickstart", "Signed out globally"),
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
val options = AuthSignOutOptions.builder()
    .globalSignOut(true)
    .build()
Amplify.Auth.signOut(options,
    ,
    
)
```

</Block>

```kotlin
val options = AuthSignOutOptions.builder()
    .globalSignOut(true)
    .build()
try  catch (error: AuthException) {
    Log.e("AuthQuickstart", "Sign out failed", error)
)
```

</Block>

```java
RxAmplify.Auth.signOut(AuthSignOutOptions.builder().globalSignOut(true).build())
    .subscribe(
        () -> Log.i("AuthQuickstart", "Signed out globally"),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>
