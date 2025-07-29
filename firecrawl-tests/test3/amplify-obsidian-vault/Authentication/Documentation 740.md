---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/android/signout/20_global_signout.mdx
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
AuthSignOutOptions options = AuthSignOutOptions.builder()
    .globalSignOut(true)
    .build();

Amplify.Auth.signOut(options, signOutResult ->  else if (signOutResult instanceof AWSCognitoAuthSignOutResult.PartialSignOut)  else if (signOutResult instanceof AWSCognitoAuthSignOutResult.FailedSignOut) 
});
```

</Block>

```kotlin
val options = AuthSignOutOptions.builder()
    .globalSignOut(true)
    .build()

Amplify.Auth.signOut(options) 
        is AWSCognitoAuthSignOutResult.PartialSignOut -> 
        is AWSCognitoAuthSignOutResult.FailedSignOut -> 
    }
}
```

</Block>

```kotlin
val options = AuthSignOutOptions.builder()
    .globalSignOut(true)
    .build()

val signOutResult = Amplify.Auth.signOut(options)

when(signOutResult) 
    is AWSCognitoAuthSignOutResult.PartialSignOut -> 
    is AWSCognitoAuthSignOutResult.FailedSignOut -> 
}
```

</Block>

```java
AuthSignOutOptions options = AuthSignOutOptions.builder()
    .globalSignOut(true)
    .build();
    
RxAmplify.Auth.signOut(options)
    .subscribe(signOutResult ->  else if (signOutResult instanceof AWSCognitoAuthSignOutResult.PartialSignOut)  else if (signOutResult instanceof AWSCognitoAuthSignOutResult.FailedSignOut) 
    });
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/android/signout/20_global_signout.mdx`