---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib-v1/graphqlapi/android/authz/21_oidc.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

Add the following code to your app to initialize API plugin with OIDC auth provider:

This implementation uses `CompletableFuture`, which requires `minSdkVersion >= 24`.

```java
ApiAuthProviders authProviders = ApiAuthProviders.builder()
    .oidcAuthProvider(() ->  catch (Exception e) 
        return null;
    })
    .build();
AWSApiPlugin plugin = AWSApiPlugin.builder()
    .apiAuthProviders(authProviders)
    .build();
Amplify.addPlugin(plugin);
```

</Block>

This implementation uses `CompletableFuture`, which requires `minSdkVersion >= 24`.

```kotlin
val authProviders = ApiAuthProviders.builder()
    .oidcAuthProvider ,
            
        )
        future.get()
    }
    .build()
val plugin = AWSApiPlugin.builder()
    .apiAuthProviders(authProviders)
    .build()
Amplify.addPlugin(plugin)
```

</Block>

This implementation uses `CompletableFuture`, which requires `minSdkVersion >= 24`.

```kotlin
val authProviders = ApiAuthProviders.builder()
    .oidcAuthProvider 
        return (session as AWSCognitoAuthSession).userPoolTokens.value?.idToken
    }
    .build()
val plugin = AWSApiPlugin.builder()
    .apiAuthProviders(authProviders)
    .build()
Amplify.addPlugin(plugin)
```

</Block>

Using the `rxbindings` module can simplify this further.

```groovy
dependencies 
```

```java
ApiAuthProviders authProviders = ApiAuthProviders.builder()
    .oidcAuthProvider(() -> RxAmplify.Auth.fetchAuthSession()
        .map(session -> ((AWSCognitoAuthSession) session)
            .getUserPoolTokens()
            .getValue()
            .getIdToken())
        .blockingGet())
    .build();
AWSApiPlugin plugin = AWSApiPlugin.builder()
    .apiAuthProviders(authProviders)
    .build();
Amplify.addPlugin(plugin);
```

</Block>

Using the `rxbindings` module can simplify this further.

```groovy
dependencies 
```

```kotlin
val authProviders = ApiAuthProviders.builder()
    .oidcAuthProvider 
        .blockingGet() }
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
Original: `fragments/lib-v1/graphqlapi/android/authz/21_oidc.mdx`