---
title: My first post
source: fragments/lib-v1/datastore/ios/data-access/save-snippet.mdx
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
