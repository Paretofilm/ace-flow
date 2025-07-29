---
title: Documentation
source: fragments/lib-v1/auth/flutter/signin_next_steps/100_totp_setup.mdx
---

# Documentation

If the next step is `continueSignInWithTOTPSetup`, then the user must provide a TOTP code to complete the sign in process. The step returns an associated value of type `TOTPSetupDetails` which would be used for generating TOTP. `TOTPSetupDetails` provides a helper method called `getSetupURI` that can be used to generate a URI, which can be used by native password managers for TOTP association. For example. if the URI is used on Apple platforms, it will trigger the platform's native password manager to associate TOTP with the account. For more advanced use cases, `TOTPSetupDetails` also contains the `sharedSecret` that will be used to either generate a QR code or can be manually entered into an authenticator app.

Once the authenticator app is set up, the user can generate a TOTP code and provide it to the library to complete the sign in process.

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}

// Then, pass the TOTP code to `confirmSignIn`

Future<void> confirmTotpUser(String totpCode) async  on AuthException catch (e) ');
  }
}
```
