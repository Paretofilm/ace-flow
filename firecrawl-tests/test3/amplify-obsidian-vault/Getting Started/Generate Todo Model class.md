---
title: Generate Todo Model class
topics: ['Getting Started']
primary_topic: Getting Started
source: fragments/lib-v1/graphqlapi/ios/getting-started/40_codegen.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, getting-started]
---


## 🧭 Navigation
**Topics**: [[Getting Started/]]
**Primary**: [[Getting Started/]]

---


# Generate Todo Model class

## Generate Todo Model class

To generate the `Todo` model, change directories to your project folder and **execute the command**:

```bash
amplify codegen models
```

The generated files will be under the `amplify/generated/models` directory. It is strongly advised not to put any hand written code in `amplify/generated` directory as it gets re-generated each time codegen is run. 
```
AmplifyModels.swift
Todo.swift
Todo+Schema.swift
```
Drag and place the entire `models` directory into Xcode to add them to your project.


---

## 📚 Related Topics
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/graphqlapi/ios/getting-started/40_codegen.mdx`