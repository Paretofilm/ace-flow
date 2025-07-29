---
title: Documentation
source: fragments/lib-v1/auth/android/access_credentials/10_fetchAuthSession.mdx
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
