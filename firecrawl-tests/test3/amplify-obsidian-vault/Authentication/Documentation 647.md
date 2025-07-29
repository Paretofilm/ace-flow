---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/ios/signin_next_steps/50_reset_password.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

If you receive `resetPassword`, authentication flow could not proceed without resetting the password. The next step is to invoke `resetPassword` api and follow the reset password flow.

```swift
func resetPassword(username: String) async  catch let error as AuthError  catch 
}
```

</Block>

```swift
func resetPassword(username: String) -> AnyCancellable .sink 
        }
        receiveValue: 
}
```

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/ios/signin_next_steps/50_reset_password.mdx`