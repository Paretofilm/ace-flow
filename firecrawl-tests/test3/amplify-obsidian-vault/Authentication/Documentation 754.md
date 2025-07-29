---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/android/totp/set_up_totp.mdx
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
Amplify.Auth.setUpTOTP(
    result -> ,
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.setUpTOTP(
    ")
        // appName parameter will help distinguish the account in the Authenticator app
        val setupURI = result.getSetupURI(">")
        // Prompt the user to enter the TOTP code generated in their authenticator app
        // Then invoke `verifyTOTP` api with the code
    },
    
)
```

</Block>

```kotlin
try ")
    // appName parameter will help distinguish the account in the Authenticator app
    val setupURI = result.getSetupURI(">")
    // Prompt the user to enter the TOTP code generated in their authenticator app
    // Then invoke `verifyTOTP` api with the code
} catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.setUpTOTP()
    .subscribe(
        result -> ,
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/android/totp/set_up_totp.mdx`