---
title: Documentation
source: fragments/lib-v1/graphqlapi/android/authz/22_lambda.mdx
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
