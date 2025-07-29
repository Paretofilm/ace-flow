---
title: Documentation
topics: ['Data & APIs', 'Authentication']
primary_topic: Data & APIs
source: fragments/lib/datastore/android/setup-auth-rules/owner_based_auth_oidc.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis, authentication]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]] • [[Authentication/]]
**Primary**: [[Data & APIs/]]

---


# Documentation

When using a 3rd party OIDC auth provider, you are required to provide an instance of `ApiAuthProviders` containing an implementation of the `OidcAuthProvider` interface. The responsibility of the `OidcAuthProvider` is to return the JWT token that was provided by your OIDC provider. To do this:

* Pass your `ApiAuthProviders` to the `AWSApiPlugin` constructor, and then call `Amplify.configure(...)`

```java
Amplify.addPlugin(new AWSApiPlugin(ApiAuthProviders.builder()
    .oidcAuthProvider(() -> "token-from-your-oidc-provider")
    .build()));
Amplify.addPlugin(new AWSDataStorePlugin());
Amplify.configure(getApplicationContext());
```

</Block>

```kotlin
Amplify.addPlugin(AWSApiPlugin(ApiAuthProviders.builder()
    .oidcAuthProvider 
    .build()))
Amplify.addPlugin(AWSDataStorePlugin());
Amplify.configure(getApplicationContext());
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/datastore/android/setup-auth-rules/owner_based_auth_oidc.mdx`