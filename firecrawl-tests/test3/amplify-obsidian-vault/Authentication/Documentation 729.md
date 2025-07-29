---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/android/sms/sign_up.mdx
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
AuthSignUpOptions options = AuthSignUpOptions.builder()
    .userAttribute(AuthUserAttributeKey.email(), "my@email.com")
    .userAttribute(AuthUserAttributeKey.phoneNumber(), "+18885551234")
    .build();
Amplify.Auth.signUp("username", "Password123", options,
    result -> Log.i("AuthQuickStart", "Result: " + result.toString()),
    error -> Log.e("AuthQuickStart", "Sign up failed", error)
);
```

</Block>

```kotlin
val options = AuthSignUpOptions.builder()
    .userAttribute(AuthUserAttributeKey.email(), "my@email.com")
    .userAttribute(AuthUserAttributeKey.phoneNumber(), "+18885551234")
    .build()
Amplify.Auth.signUp("username", "Password123", options,
    ,
    
)
```

</Block>

```kotlin
val options = AuthSignUpOptions.builder()
    .userAttribute(AuthUserAttributeKey.email(), "my@email.com")
    .userAttribute(AuthUserAttributeKey.phoneNumber(), "+18885551234")
    .build()
try  catch (error: AuthException) 
```

</Block>

 ```java
RxAmplify.Auth.signUp(
    "username",
    "Password123",
    AuthSignUpOptions.builder()
    .userAttribute(AuthUserAttributeKey.email(), "my@email.com")
    .userAttribute(AuthUserAttributeKey.phoneNumber(), "+18885551234")
    .build())
    .subscribe(
        result -> Log.i("AuthQuickStart", "Result: " + result.toString()),
        error -> Log.e("AuthQuickStart", "Sign up failed", error)
    );
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/android/sms/sign_up.mdx`