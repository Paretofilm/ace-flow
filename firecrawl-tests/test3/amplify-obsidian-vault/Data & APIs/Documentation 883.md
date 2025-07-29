---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/ios/relational/delete-snippet.mdx
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
do 
    try await Amplify.DataStore.delete(postWithComments)
    print("Post with id 123 deleted with success")
} catch let error as DataStoreError  catch 
```

</Block>

```swift
let sink = Amplify.Publisher.create 
    try await Amplify.DataStore.delete(postWithComments)
}.sink 
} receiveValue: 
```

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/ios/relational/delete-snippet.mdx`