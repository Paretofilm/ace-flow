---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib-v1/auth/flutter/signin_next_steps/10_signin.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

The `Amplify.Auth.signIn` API returns a `SignInResult` object which indicates whether the sign-in flow is
complete or whether additional steps are required before the user is signed in.

To see if additional signin steps are required, inspect the sign in result's `nextStep.signInStep` property.
- If the sign-in step is `done`, the flow is complete and the user is signed in.
- If the sign-in step is not `done`, one or more additional steps are required. These are explained in detail below.

> **Note**: 

The `signInStep` property is an enum of type `AuthSignInStep`. Depending on its value, your code should take one of the actions mentioned on this page.

```dart
Future signInWithCognito(
  String username,
  String password,
) async 

Future<void> _handleSignInResult(SignInResult result) async 
}
```


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib-v1/auth/flutter/signin_next_steps/10_signin.mdx`