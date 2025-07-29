---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/flutter/signin_with_custom_flow/30_signin.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

```dart
// Create state variables for the sign in status
var isSignedIn = false;
String? challengeHint;

Future<void> signInCustomFlow(String username) async );
  } on AuthException catch (e) ');
  }
}
```

> **Note**: 

Please note that you will be prevented from successfully calling `signIn` if a
user has already signed in and a valid session is active. You must first call
`signOut` to remove the original session.


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/flutter/signin_with_custom_flow/30_signin.mdx`