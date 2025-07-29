---
title: Documentation
source: fragments/lib/auth/android/totp/verify_totp_setup.mdx
---

# Documentation

```java
Amplify.Auth.verifyTOTPSetup(
    totpCodeFromAuthenticatorApp,
    () ->Log.d("AuthQuickstart","TOTP Verification Succeeded"),
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.verifyTOTPSetup(
    totpCodeFromAuthenticatorApp,
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.verifyTOTPSetup(totpCodeFromAuthenticatorApp)
    .subscribe(
        result -> Log.d("AuthQuickstart","TOTP Verification Succeeded"),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>
