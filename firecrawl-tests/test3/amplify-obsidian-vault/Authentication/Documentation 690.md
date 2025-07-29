---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/flutter/signin/10_signUp.mdx
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
/// Signs a user up with a username, password, and email. The required
/// attributes may be different depending on your app's configuration.
Future<void> signUpUser() async ;
    final result = await Amplify.Auth.signUp(
      username: username,
      password: password,
      options: SignUpOptions(
        userAttributes: userAttributes,
      ),
    );
    await _handleSignUpResult(result);
  } on AuthException catch (e) ');
  }
}
```

```dart
Future<void> _handleSignUpResult(SignUpResult result) async 
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
Original: `fragments/lib/auth/flutter/signin/10_signUp.mdx`