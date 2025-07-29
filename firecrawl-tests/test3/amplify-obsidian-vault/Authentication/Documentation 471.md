---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib-v1/graphqlapi/ios/authz/22_lambda.mdx
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


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib-v1/graphqlapi/ios/authz/22_lambda.mdx`