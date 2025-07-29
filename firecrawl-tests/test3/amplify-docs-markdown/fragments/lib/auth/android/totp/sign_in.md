---
title: Documentation
source: fragments/lib/auth/android/totp/sign_in.mdx
---

# Documentation

```java
Amplify.Auth.signIn(
    "username",
    "password",
    result -> 
    },
    error -> Log.e("SignIn", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.signIn(
    "username", 
    "password",
    
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
