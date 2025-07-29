---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/flutter/signin_next_steps/40_confirm_new_password.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

If the next step is `confirmSignInWithNewPassword`, Amplify Auth requires the user choose a new password they proceeding with the sign in. 

Prompt the user for a new password and pass it to the `confirmSignIn` API.

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}
```

```dart
Future<void> confirmNewPassword(String newPassword) async  on AuthException catch (e) ');
  }
}
```


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/flutter/signin_next_steps/40_confirm_new_password.mdx`