---
title: Query by `id`
source: fragments/lib-v1/datastore/ios/data-access/query-basic-snippet.mdx
---

# Query by `id`

```swift
Amplify.DataStore.query(Post.self) 
}
```

</Block>

```swift
let sink = Amplify.DataStore.query(Post.self).sink 
}
receiveValue: 
```

</Block>

</BlockSwitcher>

### Query by `id`

Query has an alternative signature that allows to fetch a single item by its `id`:

```swift
Amplify.DataStore.query(Post.self, byId: "123") 
}
```

</Block>

```swift
let sink = Amplify.DataStore.query(Post.self, byId: "123").sink 
}
receiveValue: 
```

</Block>

</BlockSwitcher>
