---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/android/signout/10_local_signout.mdx
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
Amplify.Auth.signOut( signOutResult ->  else if (signOutResult instanceof AWSCognitoAuthSignOutResult.PartialSignOut) 

        GlobalSignOutError globalSignOutError = partialSignOutResult.getGlobalSignOutError();
        if (globalSignOutError != null) 

        RevokeTokenError revokeTokenError = partialSignOutResult.getRevokeTokenError();
        if (revokeTokenError != null) 
    } else if (signOutResult instanceof AWSCognitoAuthSignOutResult.FailedSignOut) 
});
```

</Block>

```kotlin
Amplify.Auth.signOut 
        is AWSCognitoAuthSignOutResult.PartialSignOut -> 
            signOutResult.globalSignOutError?.let 
            signOutResult.revokeTokenError?.let 
        }
        is AWSCognitoAuthSignOutResult.FailedSignOut -> 
    }
}
```

</Block>

```kotlin
val signOutResult = Amplify.Auth.signOut()
when(signOutResult) 
    is AWSCognitoAuthSignOutResult.PartialSignOut -> 
        signOutResult.globalSignOutError?.let 
        signOutResult.revokeTokenError?.let 
    }
    is AWSCognitoAuthSignOutResult.FailedSignOut -> 
}
```

</Block>

```java
RxAmplify.Auth.signOut()
    .subscribe(signOutResult ->  else if (signOutResult instanceof AWSCognitoAuthSignOutResult.PartialSignOut) 

            GlobalSignOutError globalSignOutError = partialSignOutResult.getGlobalSignOutError();
            if (globalSignOutError != null) 

            RevokeTokenError revokeTokenError = partialSignOutResult.getRevokeTokenError();
            if (revokeTokenError != null) 
        } else if (signOutResult instanceof AWSCognitoAuthSignOutResult.FailedSignOut) 
    });
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/android/signout/10_local_signout.mdx`