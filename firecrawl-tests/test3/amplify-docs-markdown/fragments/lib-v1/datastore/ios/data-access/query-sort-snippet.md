---
title: Documentation
source: fragments/lib-v1/datastore/ios/data-access/query-sort-snippet.mdx
---

# Documentation

```swift
Amplify.DataStore.query(Post.self, sort: .ascending(Post.keys.rating)) 
}
```

</Block>

```swift
let sink = Amplify.DataStore.query(Post.self, sort: .ascending(Post.keys.rating)).sink 
}
receiveValue: 
```

</Block>

</BlockSwitcher>
