---
title: Documentation
source: fragments/lib-v1/auth/flutter/signin_next_steps/90_mfa_selection.mdx
---

# Documentation

If the next step is `continueSignInWithMFASelection`, the user must select the MFA method to use. Amplify Auth currently only supports SMS and TOTP as MFA methods. After the user selects an MFA method, your implementation must pass the selected MFA method to Amplify Auth using `confirmSignIn` API.

The MFA types which are currently supported by Amplify Auth are:

- `MfaType.sms`
- `MfaType.totp`

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}

Future _promptUserPreference(Set allowedTypes) async 

Future<void> _handleMfaSelection(MfaType selection) async  on AuthException catch (e) ');
  }
}
```
