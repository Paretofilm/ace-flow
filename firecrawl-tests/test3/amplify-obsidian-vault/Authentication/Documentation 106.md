---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib-v1/auth/flutter/signin/30_signIn.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

> **Note**: 

Please note that you will be prevented from successfully calling `signIn` if a user has already signed in and a valid session is active.  You must first call `signOut` to remove the original session.

```dart
Future<void> signInUser(String username, String password) async  on AuthException catch (e) ');
  }
}
```

Depending on your configuration and how the user signed up, one or more confirmations will be necessary.
Use the `SignInResult` returned from `Amplify.Auth.signIn` to check the next step for signing in. When
the value is `done`, the user has successfully signed in.

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}

void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) . '
    'Please check your $ for the code.',
  );
}
```


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib-v1/auth/flutter/signin/30_signIn.mdx`