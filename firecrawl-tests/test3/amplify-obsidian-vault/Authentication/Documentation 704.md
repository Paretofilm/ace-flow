---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/flutter/signin_next_steps/30_confirm_custom_challenge.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

If the next step is `confirmSignInWithCustomChallenge`, Amplify Auth is awaiting completion of a custom authentication challenge. The challenge is based on the Lambda trigger you configured as part of a [custom sign in flow](/gen1/[platform]/build-a-backend/auth/sign-in-custom-flow/).

For example, your custom challenge Lambda may pass a prompt to the frontend which requires the user to enter a secret code.

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}
```

To complete this step, you should prompt the user for the custom challenge answer, and pass the answer to the `confirmSignIn` API.

```dart
Future<void> confirmCustomChallenge(String answer) async  on AuthException catch (e) ');
  }
}
```

> **Note**: 

<b>Special Handling on confirmSignIn</b>

If `failAuthentication=true` is returned by the Lambda, Cognito will invalidate the session of the request. This is represented by a `NotAuthorizedException` and requires restarting the sign-in flow by calling `Amplify.Auth.signIn` again.


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/flutter/signin_next_steps/30_confirm_custom_challenge.mdx`