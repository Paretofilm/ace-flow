---
title: Documentation
topics: ['Data & APIs', 'Authentication']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/flutter/setup-auth-rules/owner_based_auth_oidc.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis, authentication]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]] • [[Authentication/]]
**Primary**: [[Data & APIs/]]

---


# Documentation

When using a third-party OIDC auth provider, you are required to subclass `OIDCAuthProvider` and configure the API plugin with an instance of this class. The responsibility of the auth provider is to return the JWT token that was minted by your OIDC service. To do this:

* Create a class which extends `OIDCAuthProvider`

```dart
import 'package:amplify_api/amplify_api.dart';

class CustomOIDCProvider extends OIDCAuthProvider 
}
```

* Register your instance of `APIAuthProvider` prior to calling `Amplify.configure()`:

```dart
Future<void> initialize() async  on Exception catch (e) 
}
```


---

## 📚 Related Topics
- [[Data & APIs/]]
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/flutter/setup-auth-rules/owner_based_auth_oidc.mdx`