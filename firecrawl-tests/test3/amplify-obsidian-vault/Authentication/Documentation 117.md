---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib-v1/auth/flutter/signin_next_steps/70_done.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

The sign-in flow is complete when the next step is `done`, which means the user is successfully authenticated. 
As a convenience, the `SignInResult` also provides the `isSignedIn` property, which will be true if the next step is `done`.

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}
```


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib-v1/auth/flutter/signin_next_steps/70_done.mdx`