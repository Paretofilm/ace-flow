---
title: Documentation
source: fragments/lib/auth/flutter/signin_next_steps/70_done.mdx
---

# Documentation

The sign-in flow is complete when the next step is `done`, which means the user is successfully authenticated. 
As a convenience, the `SignInResult` also provides the `isSignedIn` property, which will be true if the next step is `done`.

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}
```
