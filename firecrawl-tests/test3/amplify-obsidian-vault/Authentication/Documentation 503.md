---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib-v1/graphqlapi/android/authz/22_lambda.mdx
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
    .functionAuthProvider(() -> "[AWS-LAMBDA-AUTH-TOKEN]")
    .build();
AWSApiPlugin plugin = AWSApiPlugin.builder()
    .apiAuthProviders(authProviders)
    .build();
Amplify.addPlugin(plugin);
```

</Block>

```kotlin
val authProviders = ApiAuthProviders.builder()
    .functionAuthProvider 
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
Original: `fragments/lib-v1/graphqlapi/android/authz/22_lambda.mdx`