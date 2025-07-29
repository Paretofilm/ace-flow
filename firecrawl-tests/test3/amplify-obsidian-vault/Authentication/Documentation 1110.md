---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/graphqlapi/flutter/authz/30_multi.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

When you have multiple authorization modes, you can specify the mode with the `authorizationMode` parameter. You can also specify the API name with the `apiName` parameter.

```dart
Future<void> mutateWithApiKey() async 

Future<void> mutateWithIam() async 

Future<void> mutateByApiName() async 
```


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/graphqlapi/flutter/authz/30_multi.mdx`