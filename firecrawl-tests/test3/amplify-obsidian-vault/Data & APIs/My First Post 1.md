---
title: My first post
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/ios/data-access/save-snippet.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# My first post

```swift
Amplify.DataStore.save(
    Post(title: "My first post",
         description: "Amplify.DataStore is awesome!",
         status: .draft)
) 
}
```

</Block>

```swift
let saveSink = Amplify.DataStore.save(
    Post(
        title: "My first post",
        description: "Amplify.DataStore is awesome!",
        status: .draft
    )
)
.sink 
}
receiveValue: 
```

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/ios/data-access/save-snippet.mdx`