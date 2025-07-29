---
title: Documentation
source: fragments/lib-v1/graphqlapi/flutter/authz/30_multi.mdx
---

# Documentation

When you have multiple authorization modes, you can specify the mode with the `authorizationMode` parameter. You can also specify the API name with the `apiName` parameter.

```dart
Future<void> mutateWithApiKey() async 

Future<void> mutateWithIam() async 

Future<void> mutateByApiName() async 
```
