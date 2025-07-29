---
title: Documentation
source: fragments/lib/auth/ios/signin_next_steps/60_confirm_signup.mdx
---

# Documentation

If you receive `confirmSignUp` as a next step, sign up could not proceed without confirming user information such as email or phone number. The next step is to invoke the `confirmSignUp` API and follow the confirm signup flow.

```swift
func confirmSignUp(for username: String, with confirmationCode: String) async  catch let error as AuthError  catch 
}
```

</Block>

```swift
func confirmSignUp(for username: String, with confirmationCode: String) -> AnyCancellable .sink 
        }
        receiveValue: 
}
```

</Block>

</BlockSwitcher>
