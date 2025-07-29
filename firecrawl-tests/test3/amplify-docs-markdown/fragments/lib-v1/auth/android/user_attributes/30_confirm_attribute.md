---
title: Documentation
source: fragments/lib-v1/auth/android/user_attributes/30_confirm_attribute.mdx
---

# Documentation

```java
Amplify.Auth.confirmUserAttribute(AuthUserAttributeKey.email(), "344299",
    () -> Log.i("AuthDemo", "Confirmed user attribute with correct code."),
    error -> Log.e("AuthDemo", "Failed to confirm user attribute. Bad code?", error)
);
```

</Block>

```kotlin
Amplify.Auth.confirmUserAttribute(AuthUserAttributeKey.email(), "344299",
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.confirmUserAttribute(AuthUserAttributeKey.email(), "344299")
    .subscribe(
        () -> Log.i("AuthDemo", "Confirmed user attribute using correct code."),
        error -> Log.e("AuthDemo", "Failed to confirm user attribute. Bad code?", error)
    );
```

</Block>
</BlockSwitcher>
