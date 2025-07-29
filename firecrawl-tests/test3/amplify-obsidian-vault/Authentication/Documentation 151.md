---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib-v1/auth/android/access_credentials/10_fetchAuthSession.mdx
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
Amplify.Auth.fetchAuthSession(
    result -> 
        },
        error -> Log.e("AuthQuickStart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.fetchAuthSession(
    ")
            AuthSessionResult.Type.FAILURE ->
                Log.w("AuthQuickStart", "IdentityId not found", session.identityId.error)
        }
    },
    
)
```

</Block>

```kotlin
try ")
    } else if (id.type == AuthSessionResult.Type.FAILURE) ")
    }
} catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.fetchAuthSession()
    .subscribe(
        result -> 
        },
        error -> Log.e("AuthQuickStart", error.toString())
    );
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib-v1/auth/android/access_credentials/10_fetchAuthSession.mdx`