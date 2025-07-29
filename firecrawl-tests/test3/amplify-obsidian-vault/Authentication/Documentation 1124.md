---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/graphqlapi/android/authz/20_oidc.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

Add the following code to your app:

```java
ApiAuthProviders authProviders = ApiAuthProviders.builder()
    .oidcAuthProvider(() -> "[OPEN-ID-CONNECT-TOKEN]")
    .build();
AWSApiPlugin plugin = AWSApiPlugin.builder()
    .apiAuthProviders(authProviders)
    .build();
Amplify.addPlugin(plugin);
```

</Block>

```kotlin
val authProviders = ApiAuthProviders.builder()
    .oidcAuthProvider 
    .build()
val plugin = AWSApiPlugin.builder()
    .apiAuthProviders(authProviders)
    .build()
Amplify.addPlugin(plugin)
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/graphqlapi/android/authz/20_oidc.mdx`