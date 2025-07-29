---
title: Documentation
source: fragments/lib/auth/ios/signin_with_custom_flow/40_signin.mdx
---

# Documentation

```swift
func signIn(username: String) async  else 
    } catch let error as AuthError  catch 
}
```

</Block>

```swift
func signIn(username: String) -> AnyCancellable .sink 
    }
    receiveValue:  else 
    }
}
```

</Block>

</BlockSwitcher>

Since this is a custom authentication flow with a challenge, the result of the signin process has a next step `.confirmSignInWithCustomChallenge`. Implement a UI to allow the user to enter the custom challenge.
