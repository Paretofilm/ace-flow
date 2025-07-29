---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/graphqlapi/flutter/authz/10_userpool.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

In case you have not added the Cognito libraries to your application, be sure to add them:

```yaml
dependencies:
  flutter:
    sdk: flutter

   amplify_flutter: ^2.0.0
   amplify_api: ^2.0.0
   # Be sure that this is added
   amplify_auth_cognito: ^2.0.0
```

Afterwards add the following code to your app before you configure Amplify:

```dart
await Amplify.addPlugins([
  AmplifyAuthCognito(), 
  AmplifyAPI(
    options: APIPluginOptions(modelProvider: ModelProvider.instance),
  ),
]);
```


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/graphqlapi/flutter/authz/10_userpool.mdx`