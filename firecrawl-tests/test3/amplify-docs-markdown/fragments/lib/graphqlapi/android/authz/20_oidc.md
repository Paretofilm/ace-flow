---
title: Documentation
source: fragments/lib/graphqlapi/android/authz/20_oidc.mdx
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
