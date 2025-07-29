---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/flutter/signin_with_custom_flow/40_custom_challenge.mdx
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
Future<void> confirmSignIn(String generatedNumber) async  on AuthException catch (e) ');
  }
}
```

Once the user provides the correct response, they should be authenticated in your application.

> **Note**: 

<b>Special Handling on ConfirmSignIn</b>

During a `confirmSignIn` call, if `failAuthentication: true` is returned by the Lambda, the session of the request gets invalidated by Cognito, and a `NotAuthorizedException` is thrown. To recover, the user must initiate a new sign in by calling `Amplify.Auth.signIn`.


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/flutter/signin_with_custom_flow/40_custom_challenge.mdx`