---
title: Documentation
source: fragments/lib-v1/datastore/ios/data-access/query-predicate-snippet.mdx
---

# Documentation

```swift
let p = Post.keys
Amplify.DataStore.query(Post.self, where: p.rating > 4) 
}
```

</Block>

```swift
let p = Post.keys
let sink = Amplify.DataStore.query(Post.self, where: p.rating > 4).sink 
}
receiveValue: 
```

</Block>

</BlockSwitcher>
