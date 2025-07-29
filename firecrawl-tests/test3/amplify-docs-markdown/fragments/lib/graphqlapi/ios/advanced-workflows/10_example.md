---
title: Documentation
source: fragments/lib/graphqlapi/ios/advanced-workflows/10_example.mdx
---

# Documentation

```swift
let todo = Todo(name: "my first todo", description: "todo description")
try await Amplify.API.mutate(request: .create(todo))
```
