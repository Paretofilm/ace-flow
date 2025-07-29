---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/ios/signin_next_steps/10_signin.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

When called successfully, the signin APIs will return an `AuthSignInResult`. Inspect the `nextStep` property in the result to see if additional signin steps are required.

```swift
func signIn(username: String, password: String) async 
    } catch let error as AuthError catch 
}
```

The `nextStep` property is of enum type `AuthSignInStep`. Depending on its value, your code should take one of the following actions:


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/ios/signin_next_steps/10_signin.mdx`