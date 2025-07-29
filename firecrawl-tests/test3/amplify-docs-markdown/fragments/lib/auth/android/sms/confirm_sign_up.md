---
title: Documentation
source: fragments/lib/auth/android/sms/confirm_sign_up.mdx
---

# Documentation

```java
Amplify.Auth.confirmSignUp(
    "username",
    "the code you received",
    result -> Log.i("AuthQuickstart", result.isSignUpComplete() ? "Confirm signUp succeeded" : "Confirm sign up not complete"),
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.confirmSignUp(
    "username", "the code you received",
     else 
    },
    
)
```

</Block>

```kotlin
try  else 
} catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.confirmSignUp("username", "the code you received")
    .subscribe(
        result -> Log.i("AuthQuickstart", result.isSignUpComplete() ? "Confirm signUp succeeded" : "Confirm sign up not complete"),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>

You will know the sign up flow is complete if you see the following in your console window:

```console
Confirm signUp succeeded
```
