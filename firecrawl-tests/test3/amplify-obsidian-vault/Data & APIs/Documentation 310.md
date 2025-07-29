---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/ios/data-access/update-snippet.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Documentation

```swift
let existingPost: Post = /* get an existing post */
existingPost.title = "[updated] My first post"

Amplify.DataStore.save(existingPost) 
}
```

</Block>

```swift
let existingPost: Post = /* get an existing post */
existingPost.title = "[updated] My first post"

let saveSink = Amplify.DataStore.save(existingPost).sink 
}
receiveValue: 
```

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/ios/data-access/update-snippet.mdx`