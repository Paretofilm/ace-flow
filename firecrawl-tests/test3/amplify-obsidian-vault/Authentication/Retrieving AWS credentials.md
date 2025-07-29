---
title: Retrieving AWS credentials
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/flutter/access_credentials/10_fetchAuthSession.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Retrieving AWS credentials

However, if you need to access them in relation to working with an API outside Amplify or want access to AWS specific identifying information (e.g. IdentityId), you can access these implementation details by calling fetchAuthSession on the Cognito Auth Plugin. This will return a `CognitoAuthSession`, which has additional attributes compared to `AuthSession`, which is typically returned by fetchAuthSession. See the example below:

```dart
Future<void> fetchAuthSession() async ');
  } on AuthException catch (e) ');
  }
}
```

## Retrieving AWS credentials

Sometimes it can be helpful to retrieve the instance of the underlying plugin
which has more specific typing. In the case of Cognito, calling `fetchAuthSession`
on the Cognito plugin returns AWS-specific values such as the identity ID,
AWS credentials, and Cognito User Pool tokens.

```dart
Future<void> fetchCognitoAuthSession() async  on AuthException catch (e) ');
  }
}
```


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/flutter/access_credentials/10_fetchAuthSession.mdx`