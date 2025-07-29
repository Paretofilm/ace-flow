---
title: Documentation
source: fragments/lib/auth/android/totp/confirm_sign_in.mdx
---

# Documentation

```java
Amplify.Auth.confirmSignIn(
    "OTP code from Authenticator App",
    result -> Log.i("AuthQuickstart", result.toString()),
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.confirmSignIn("OTP code from Authenticator App",
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.confirmSignIn("OTP code from Authenticator App")
    .subscribe(
        result -> Log.i("AuthQuickstart", result.toString()),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>
