---
title: Documentation
source: fragments/lib-v1/auth/flutter/signin_next_steps/60_confirm_signup.mdx
---

# Documentation

If the next step is `resetPassword`, Amplify Auth requires that the user confirm their email or phone number before proceeding.
Use the `resendSignUpCode` API to send a new sign up code to the registered email or phone number, followed by `confirmSignUp` 
to complete the sign up.

See the [confirm sign up](/gen1/[platform]/prev/build-a-backend/auth/enable-sign-in/#register-a-user) docs for more information.

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
Future<void> confirmSignUp() async  on AuthException catch (e) ');
  }
}
```

Once the sign up is confirmed, call `Amplify.Auth.signIn` again to restart the sign-in flow.
