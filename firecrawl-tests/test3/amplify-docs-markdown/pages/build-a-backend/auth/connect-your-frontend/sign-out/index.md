---
title: Practical Example
source: pages/build-a-backend/auth/connect-your-frontend/sign-out/index.mdx
---

# Practical Example

Amplify provides a client library that enables you to interact with backend resources such as Amplify Auth.

> **Note**: 

The quickest way to get started with Amplify Auth in your frontend application is with the [Authenticator component](https://ui.docs.amplify.aws/react/connected-components/authenticator), which provides a customizable UI and complete authentication flows.

</InlineFilter>

> **Note**: 

The quickest way to get started with Amplify Auth in your frontend application is with the [Authenticator component](https://ui.docs.amplify.aws/swift/connected-components/authenticator), which provides a customizable UI and complete authentication flows.

</InlineFilter>

> **Note**: 

The quickest way to get started with Amplify Auth in your frontend application is with the [Authenticator component](https://ui.docs.amplify.aws/flutter/connected-components/authenticator), which provides a customizable UI and complete authentication flows.

</InlineFilter>

> **Note**: 

The quickest way to get started with Amplify Auth in your frontend application is with the [Authenticator component](https://ui.docs.amplify.aws/android/connected-components/authenticator), which provides a customizable UI and complete authentication flows.

</InlineFilter>

To sign a user out of your application use the `signOut` API.

```ts

await signOut();
```

</InlineFilter>

```dart
Future<void> signOutCurrentUser() async  else if (result is CognitoFailedSignOut) ');
  }
}
```

</InlineFilter>

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

</InlineFilter>

```swift
func signOutLocally() async 

    print("Local signout successful: \(signOutResult.signedOutLocally)")
    switch signOutResult 

        if let globalSignOutError = globalSignOutError 

        if let revokeTokenError = revokeTokenError 

    case .failed(let error):
        // Sign Out failed with an exception, leaving the user signed in.
        print("SignOut failed with \(error)")
    }
}
```

</Block>

```swift
func signOutLocally() -> AnyCancellable .sink(receiveValue: 
        print("Local signout successful: \(signOutResult.signedOutLocally)")
        switch signOutResult 

            if let globalSignOutError = globalSignOutError 

            if let revokeTokenError = revokeTokenError 

        case .failed(let error):
            // Sign Out failed with an exception, leaving the user signed in.
            print("SignOut failed with \(error)")
        }
    })
}
```

</Block>

</BlockSwitcher>

</InlineFilter>

You can also sign out users from all devices by performing a global sign-out. This will also invalidate all refresh tokens issued to a user. The user's current access and ID tokens will remain valid on other devices until the refresh token expires (access and ID tokens expire one hour after they are issued).

```ts

await signOut();
```

</InlineFilter>

```dart
Future<void> signOutGlobally() async  else if (result is CognitoPartialSignOut) ');
  } else if (result is CognitoFailedSignOut) ');
  }
}
```

</InlineFilter>

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

</InlineFilter>

```swift
import AWSCognitoAuthPlugin

func signOutGlobally() async 

    print("Local signout successful: \(signOutResult.signedOutLocally)")
    switch signOutResult 
}
```

</Block>

```swift
func signOutGlobally() -> AnyCancellable .sink(receiveValue: 
        print("Local signout successful: \(signOutResult.signedOutLocally)")
        switch signOutResult 
    })
}
```

</Block>
</BlockSwitcher>

</InlineFilter>

## Practical Example

```tsx title="src/App.tsx"
// highlight-next-line

Amplify.configure(outputs)

  return (
    <button type="button" onClick=>
      Sign out
    </button>
  )
}
```

</InlineFilter>
</InlineFilter>
