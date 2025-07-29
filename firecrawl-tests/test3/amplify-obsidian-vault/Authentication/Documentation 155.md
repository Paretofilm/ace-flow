---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib-v1/auth/android/signin/30_signIn.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

```java
Amplify.Auth.signIn(
    "username",
    "password",
    result -> Log.i("AuthQuickstart", result.isSignInComplete() ? "Sign in succeeded" : "Sign in not complete"),
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
        result -> Log.i("AuthQuickstart", result.isSignInComplete() ? "Sign in succeeded" : "Sign in not complete"),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>

You will know the sign in flow is complete if you see the following in your console window:

```console
Sign in succeeded
```


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib-v1/auth/android/signin/30_signIn.mdx`