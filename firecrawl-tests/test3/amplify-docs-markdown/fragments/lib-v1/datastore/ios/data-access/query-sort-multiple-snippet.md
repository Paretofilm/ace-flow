---
title: Documentation
source: fragments/lib-v1/datastore/ios/data-access/query-sort-multiple-snippet.mdx
---

# Documentation

```swift
Amplify.DataStore.query(Post.self, sort: .by(.ascending(Post.keys.rating),
                                             .descending(Post.keys.title))) 
}
```

</Block>

```swift
let sink = Amplify.DataStore.query(Post.self, sort: .by(.ascending(Post.keys.rating),
                                                        .descending(Post.keys.title))).sink 
}
receiveValue: 
```

</Block>

</BlockSwitcher>
