---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/android/user_attributes/40_resend_code.mdx
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
Amplify.Auth.resendUserAttributeConfirmationCode(AuthUserAttributeKey.email(),
    result -> Log.i("AuthDemo", "Code was sent again: " + result.toString()),
    error -> Log.e("AuthDemo", "Failed to resend code.", error)
);
```

</Block>

```kotlin
Amplify.Auth.resendUserAttributeConfirmationCode(
    AuthUserAttributeKey.email(),
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.resendUserAttributeConfirmationCode(AuthUserAttributeKey.email())
    .subscribe(
        result -> Log.i("AuthDemo", "Code was resent: " + result.toString()),
        error -> Log.e("AuthDemo", "Failed to resend code.", error)
    );
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/android/user_attributes/40_resend_code.mdx`