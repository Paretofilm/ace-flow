---
title: Force refreshing session
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/android/access_credentials/10_fetchAuthSession.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Force refreshing session

However, if you need to access them in relation to working with an API outside Amplify or want access to AWS specific identifying information (e.g. IdentityId), you can access these implementation details by casting the result of fetchAuthSession as follows:

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
                Log.w("AuthQuickStart", "IdentityId not found", session.identityIdResult.error)
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

## Force refreshing session

You can ask the plugin to force refresh the internal session by setting the `forceRefresh` option when calling the fetchAuthSession API.

```java
AuthFetchSessionOptions options = AuthFetchSessionOptions.builder().forceRefresh(true).build();
```

</Block>

```kotlin
val option = AuthFetchSessionOptions.builder().forceRefresh(true).build()
```

</Block>

```kotlin
val option = AuthFetchSessionOptions.builder().forceRefresh(true).build()
```

</Block>

```java
AuthFetchSessionOptions options = AuthFetchSessionOptions.builder().forceRefresh(true).build();
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/android/access_credentials/10_fetchAuthSession.mdx`