---
title: Documentation
source: fragments/lib-v1/auth/flutter/signin_with_custom_flow/30_signin.mdx
---

# Documentation

```dart
// Create state variables for the sign in status
bool isSignedIn = false;
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
