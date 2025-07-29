---
title: Documentation
source: fragments/lib/auth/ios/signin_next_steps/10_signin.mdx
---

# Documentation

When called successfully, the signin APIs will return an `AuthSignInResult`. Inspect the `nextStep` property in the result to see if additional signin steps are required.

```swift
func signIn(username: String, password: String) async 
    } catch let error as AuthError catch 
}
```

The `nextStep` property is of enum type `AuthSignInStep`. Depending on its value, your code should take one of the following actions:
