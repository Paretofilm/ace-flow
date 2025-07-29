---
title: Documentation
source: fragments/lib/auth/android/signin/30_signIn.mdx
---

# Documentation

```java
Amplify.Auth.signIn(
    "username",
    "password",
    result -> Log.i("AuthQuickstart", result.isSignedIn() ? "Sign in succeeded" : "Sign in not complete"),
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.signIn("username", "password",
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
RxAmplify.Auth.signIn("username", "password")
    .subscribe(
        result -> Log.i("AuthQuickstart", result.isSignedIn() ? "Sign in succeeded" : "Sign in not complete"),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>

You will know the sign in flow is complete if you see the following in your console window:

```console
Sign in succeeded
```
