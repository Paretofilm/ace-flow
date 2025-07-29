---
title: Documentation
topics: ['Data & APIs', 'Getting Started']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/ios/getting-started/40_codegen.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis, getting-started]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]] • [[Getting Started/]]
**Primary**: [[Data & APIs/]]

---


# Documentation

On iOS the `amplify` CLI offers an Xcode integration that automatically adds the Amplify-specific files to your project.

1. **Run the command**:
    ```
    amplify codegen models
    ```

2. The `amplify codegen models` command adds a new `AmplifyModels` group to your Xcode project. It will contain the following files:

  - `AmplifyModels/`
    - `AmplifyModels.swift`
    - `Post.swift`
    - `Post+Schema.swift`
    - `PostStatus.swift`

1. **Build the project (`Cmd+b`)**.


---

## 📚 Related Topics
- [[Data & APIs/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/ios/getting-started/40_codegen.mdx`