---
title: Documentation
source: fragments/lib/auth/android/signin/10_signUp.mdx
---

# Documentation

```java
AuthSignUpOptions options = AuthSignUpOptions.builder()
    .userAttribute(AuthUserAttributeKey.email(), "my@email.com")
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
    .build()
Amplify.Auth.signUp("username", "Password123", options,
    ,
    
)
```

</Block>

```kotlin
val options = AuthSignUpOptions.builder()
    .userAttribute(AuthUserAttributeKey.email(), "my@email.com")
    .build()
try  catch (error: AuthException) 
```

</Block>

 ```java
RxAmplify.Auth.signUp(
    "username",
    "Password123",
    AuthSignUpOptions.builder().userAttribute(AuthUserAttributeKey.email(), "my@email.com").build())
    .subscribe(
        result -> Log.i("AuthQuickStart", "Result: " + result.toString()),
        error -> Log.e("AuthQuickStart", "Sign up failed", error)
    );
```

</Block>
</BlockSwitcher>
