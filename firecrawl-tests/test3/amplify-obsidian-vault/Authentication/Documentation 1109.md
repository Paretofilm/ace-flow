---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/graphqlapi/flutter/authz/2X_add_plugin.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

Then, include it, along with any other auth providers, in the call to `addPlugin`.

```dart
await Amplify.addPlugin(
  AmplifyAPI(
    options: APIPluginOptions(
      authProviders: const [
        CustomOIDCProvider(),
        CustomFunctionProvider(),
      ],
    ),
  ),
);
```

> **Note**: 

**Note**: When using custom auth providers, `getLatestAuthToken` must be called before every API call, so it's important to minimize the amount of work this method performs. Consider caching your token in-memory so that it's available synchronously to the plugin, and only refresh it when necessary.


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/graphqlapi/flutter/authz/2X_add_plugin.mdx`