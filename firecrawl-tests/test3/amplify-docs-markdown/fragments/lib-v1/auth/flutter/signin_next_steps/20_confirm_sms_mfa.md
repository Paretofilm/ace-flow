---
title: Documentation
source: fragments/lib-v1/auth/flutter/signin_next_steps/20_confirm_sms_mfa.mdx
---

# Documentation

If the next step is `confirmSignInWithSmsMfaCode`, Amplify Auth has sent the user a random code over SMS and is waiting for the user to verify that code. 
To handle this step, your app's UI must prompt the user to enter the code. After the user enters the code, pass the value to the `confirmSignIn` API.

> **Note**: 

The result includes an `AuthCodeDeliveryDetails` member. It includes additional information about the code delivery, such as the partial phone number of 
the SMS recipient, which can be used to prompt the user on where to look for the code.

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}

void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) . '
    'Please check your $ for the code.',
  );
}
```

```dart
Future<void> confirmMfaUser(String mfaCode) async  on AuthException catch (e) ');
  }
}
```
