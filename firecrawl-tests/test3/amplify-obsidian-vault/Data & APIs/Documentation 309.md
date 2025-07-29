---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/ios/data-access/delete-snippet.mdx
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
Amplify.DataStore.delete(post) 
}
```

</Block>

```swift
let sink = Amplify.DataStore.delete(post).sink 
}
receiveValue: 
```

</Block>

</BlockSwitcher>

A delete can also be achieved by a `type` and its `id`.

```swift
Amplify.DataStore.delete(Post.self, withId: "123") 
}
```

</Block>

```swift
let sink = Amplify.DataStore.delete(Post.self, withId: "123").sink 
}
receiveValue: 
```

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/ios/data-access/delete-snippet.mdx`