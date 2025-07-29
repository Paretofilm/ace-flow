---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/android/sms/sign_in.mdx
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
    result -> 
    },
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.signIn("username", "password",
    
    },
    
)
```

</Block>

```kotlin
try 
} catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.signIn("username", "password")
    .subscribe(
        result -> 
        },
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/android/sms/sign_in.mdx`