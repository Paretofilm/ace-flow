---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/android/signin_with_custom_flow/40_signin.mdx
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
AWSCognitoAuthSignInOptions options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.CUSTOM_AUTH_WITHOUT_SRP)
    .build();
Amplify.Auth.signIn(
    "username",
    "password",
    options,
    result -> Log.i("AuthQuickstart", result.isSignedIn() ? "Sign in succeeded" : "Sign in not complete"),
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
val options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.CUSTOM_AUTH_WITHOUT_SRP)
    .build()
Amplify.Auth.signIn(
    "username", 
    "password", 
    options,
     else 
    },
    
)
```

</Block>

```kotlin
val options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.CUSTOM_AUTH_WITHOUT_SRP)
    .build()
try  else 
} catch (error: AuthException) 
```

</Block>

```java
AWSCognitoAuthSignInOptions options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.CUSTOM_AUTH_WITHOUT_SRP)
    .build();
RxAmplify.Auth.signIn("username", "password", options)
    .subscribe(
        result -> Log.i("AuthQuickstart", result.isSignedIn() ? "Sign in succeeded" : "Sign in not complete"),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>

Since this is a custom authentication flow with a challenge, the result of the signin process has a next step `.confirmSignInWithCustomChallenge`. Implement a UI to allow the user to enter the custom challenge.


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/android/signin_with_custom_flow/40_signin.mdx`