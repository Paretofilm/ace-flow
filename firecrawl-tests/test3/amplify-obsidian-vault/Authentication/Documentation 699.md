---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/flutter/signin_next_steps/50_reset_password.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

If the next step is `resetPassword`, Amplify Auth requires that the user reset their password before proceeding.
Use the `resetPassword` API to guide the user through resetting their password, then call `Amplify.Auth.signIn`
when that's complete to restart the sign-in flow.

See the [reset password](/gen1/[platform]/build-a-backend/auth/manage-passwords/) docs for more information.

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}

Future<void> _handleResetPasswordResult(ResetPasswordResult result) async 
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
Original: `fragments/lib/auth/flutter/signin_next_steps/50_reset_password.mdx`