---
title: Documentation
source: fragments/lib-v1/datastore/ios/data-access/update-snippet.mdx
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
