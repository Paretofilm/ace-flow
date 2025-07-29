---
title: Documentation
source: fragments/lib-v1/auth/flutter/signin/40_multi_factor_signup.mdx
---

# Documentation

```dart
Future<void> setUpMFASignUp() async ;
    final result = await Amplify.Auth.signUp(
      username: 'myusername',
      password: 'mysupersecurepassword',
      options: SignUpOptions(userAttributes: userAttributes),
    );
    await _handleSignUpResult(result);
  } on AuthException catch (e) ');
  }
}
```
