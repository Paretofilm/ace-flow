---
title: Documentation
source: fragments/lib-v1/auth/android/signin/20_confirmSignUp.mdx
---

# Documentation

```java
Amplify.Auth.confirmSignUp(
    "username",
    "the code you received via email",
    result -> Log.i("AuthQuickstart", result.isSignUpComplete() ? "Confirm signUp succeeded" : "Confirm sign up not complete"),
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.confirmSignUp(
    "username", "the code you received via email",
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
RxAmplify.Auth.confirmSignUp("username", "the code you received via email")
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
