---
title: Documentation
source: fragments/lib-v1/auth/flutter/signin_next_steps/80_totp.mdx
---

# Documentation

If the next step is `confirmSignInWithTOTPCode`, you should prompt the user to enter the TOTP code from their associated authenticator app during set up. The code is a six-digit number that changes every 30 seconds. The user must enter the code before the 30-second window expires.

After the user enters the code, your implementation must pass the value to Amplify Auth `confirmSignIn` API.

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}

// Then, pass the TOTP code to `confirmSignIn`

Future<void> confirmTotpUser(String totpCode) async  on AuthException catch (e) ');
  }
}
```
