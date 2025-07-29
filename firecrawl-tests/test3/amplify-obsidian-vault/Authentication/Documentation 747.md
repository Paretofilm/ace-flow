---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/android/signin/40_multi_factor_signup.mdx
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
ArrayList attributes = new ArrayList<>();
attributes.add(new AuthUserAttribute(AuthUserAttributeKey.email(), "my@email.com"));
attributes.add(new AuthUserAttribute(AuthUserAttributeKey.phoneNumber(), "+15551234567"));

Amplify.Auth.signUp(
    "username",
    "Password123",
    AuthSignUpOptions.builder().userAttributes(attributes).build(),
    result -> Log.i("AuthQuickstart", result.toString()),
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
val attrs = mapOf(
    AuthUserAttributeKey.email() to "my@email.com",
    AuthUserAttributeKey.phoneNumber() to "+15551234567"
)
val options = AuthSignUpOptions.builder()
    .userAttributes(attrs.map )
    .build()
Amplify.Auth.signUp("username", "Password123", options,
    ,
    
)
```

</Block>

```kotlin
val attrs = mapOf(
    AuthUserAttributeKey.email() to "my@email.com",
    AuthUserAttributeKey.phoneNumber() to "+15551234567"
)
val options = AuthSignUpOptions.builder()
    .userAttributes(attrs.map )
    .build()
try  catch (error: AuthException) 
```

</Block>

```java
ArrayList attributes = new ArrayList<>();
attributes.add(new AuthUserAttribute(AuthUserAttributeKey.email(), "my@email.com"));
attributes.add(new AuthUserAttribute(AuthUserAttributeKey.phoneNumber(), "+15551234567"));

RxAmplify.Auth.signUp(
    "username",
    "Password123",
    AuthSignUpOptions.builder().userAttributes(attributes).build())
    .subscribe(
        result -> Log.i("AuthQuickstart", result.toString()),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/android/signin/40_multi_factor_signup.mdx`