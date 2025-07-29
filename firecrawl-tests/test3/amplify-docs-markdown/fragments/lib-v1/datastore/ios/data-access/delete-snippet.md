---
title: Documentation
source: fragments/lib-v1/datastore/ios/data-access/delete-snippet.mdx
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
