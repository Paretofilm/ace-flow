---
title: Documentation
source: fragments/lib/graphqlapi/ios/authz/20_oidc.mdx
---

# Documentation

Add the following code to your app:

* Create a subclass of `APIAuthProviderFactory`
```swift
class MyAPIAuthProviderFactory: APIAuthProviderFactory 
}
```

* Implement your class which conforms to `AmplifyOIDCAuthProvider`:
```swift
class MyOIDCAuthProvider : AmplifyOIDCAuthProvider 
}
```
* Finally, register your instance of `APIAuthProviderFactory` prior to calling `Amplify.configure()`:
```swift
try Amplify.add(plugin: AWSAPIPlugin(apiAuthProviderFactory: MyAPIAuthProviderFactory()))
try Amplify.configure()
```
