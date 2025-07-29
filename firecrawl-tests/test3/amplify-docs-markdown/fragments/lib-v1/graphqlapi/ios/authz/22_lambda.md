---
title: Documentation
source: fragments/lib-v1/graphqlapi/ios/authz/22_lambda.mdx
---

# Documentation

Add the following code to your app:

* Create a subclass of `APIAuthProviderFactory`
```swift
class MyAPIAuthProviderFactory: APIAuthProviderFactory 
}
```

* Implement your class which conforms to `AmplifyFunctionAuthProvider`:
```swift
class MyFunctionAuthProvider : AmplifyFunctionAuthProvider 
}
```
* Finally, register your instance of `APIAuthProviderFactory` prior to calling `Amplify.configure()`:
```swift
try Amplify.add(plugin: AWSAPIPlugin(apiAuthProviderFactory: MyAPIAuthProviderFactory()))
try Amplify.configure()
```
