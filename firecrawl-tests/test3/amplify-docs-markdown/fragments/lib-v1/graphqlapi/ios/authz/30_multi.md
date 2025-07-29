---
title: Documentation
source: fragments/lib-v1/graphqlapi/ios/authz/30_multi.mdx
---

# Documentation

When you have configured multiple APIs, you can specify the name of the API as a parameter as the target for an operation:

```swift
let request = GraphQLRequest(apiName: "[FRIENDLY-NAME-API-WITH-API-KEY]", ...)
Amplify.API.mutate(request: request, listener: ...)
```
