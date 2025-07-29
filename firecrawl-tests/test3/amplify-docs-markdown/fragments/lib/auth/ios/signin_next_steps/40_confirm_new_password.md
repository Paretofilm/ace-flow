---
title: Documentation
source: fragments/lib/auth/ios/signin_next_steps/40_confirm_new_password.mdx
---

# Documentation

If the next step is `confirmSignInWithNewPassword`, Amplify Auth requires a new password for the user before they can proceed. Prompt the user for a new password and pass it to the `confirmSignIn` API.

```swift
func confirmSignIn(newPasswordFromUser: String) async  else 
    } catch let error as AuthError  catch 
}
```

</Block>

```swift
func confirmSignIn(newPasswordFromUser: String) -> AnyCancellable .sink 
        }
        receiveValue:  else 
        }
}
```

</Block>

</BlockSwitcher>
