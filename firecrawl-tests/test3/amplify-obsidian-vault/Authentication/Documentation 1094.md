---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/graphqlapi/ios/authz/30_multi.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

When you have configured multiple APIs, you can specify the name of the API as a parameter as the target for an operation:

```swift
let request = GraphQLRequest(apiName: "[FRIENDLY-NAME-API-WITH-API-KEY]", ...)
try await Amplify.API.mutate(request: request)
```


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/graphqlapi/ios/authz/30_multi.mdx`