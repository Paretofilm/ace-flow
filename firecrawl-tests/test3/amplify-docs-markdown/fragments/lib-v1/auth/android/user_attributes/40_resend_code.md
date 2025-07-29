---
title: Documentation
source: fragments/lib-v1/auth/android/user_attributes/40_resend_code.mdx
---

# Documentation

```java
Amplify.Auth.resendUserAttributeConfirmationCode(AuthUserAttributeKey.email(),
    result -> Log.i("AuthDemo", "Code was sent again: " + result.toString()),
    error -> Log.e("AuthDemo", "Failed to resend code.", error)
);
```

</Block>

```kotlin
Amplify.Auth.resendUserAttributeConfirmationCode(
    AuthUserAttributeKey.email(),
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.resendUserAttributeConfirmationCode(AuthUserAttributeKey.email())
    .subscribe(
        result -> Log.i("AuthDemo", "Code was resent: " + result.toString()),
        error -> Log.e("AuthDemo", "Failed to resend code.", error)
    );
```

</Block>
</BlockSwitcher>
