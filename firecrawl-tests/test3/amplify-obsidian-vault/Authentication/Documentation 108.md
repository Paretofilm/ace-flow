---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib-v1/auth/flutter/signin/40_multi_factor_signup.mdx
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


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib-v1/auth/flutter/signin/40_multi_factor_signup.mdx`