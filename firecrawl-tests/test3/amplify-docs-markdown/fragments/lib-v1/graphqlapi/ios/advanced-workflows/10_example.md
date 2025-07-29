---
title: Documentation
source: fragments/lib-v1/graphqlapi/ios/advanced-workflows/10_example.mdx
---

# Documentation

```swift
let todo = Todo(name: "my first todo", description: "todo description")
Amplify.API.mutate(request: .create(todo))
```
