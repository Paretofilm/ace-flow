---
title: Documentation
source: fragments/lib-v1/auth/flutter/signin_with_custom_flow/20_signup.mdx
---

# Documentation

Because authentication flows in Cognito can be switched via your configuration, it is still required that users register with a password.

```dart
Future<void> signUpCustomFlow() async ;
    final result = await Amplify.Auth.signUp(
      username: 'myusername',
      password: 'mysupersecurepassword',
      options: SignUpOptions(userAttributes: userAttributes),
    );
    safePrint('Sign up result: $result');
  } on AuthException catch (e) ');
  }
}
```
