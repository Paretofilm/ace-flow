---
title: Create an Amplify DataStore app
source: fragments/lib-v1/datastore/ios/getting-started/60_saveSnippet.mdx
---

# Create an Amplify DataStore app

```swift
let post = Post(title: "Create an Amplify DataStore app",
                status: .active)

Amplify.DataStore.save(post) 
}
```

</Block>

```swift
let post = Post(title: "Create an Amplify DataStore app",
                status: .active)
let saveSink = Amplify.DataStore.save(post).sink 
}
receiveValue: 
```

</Block>

</BlockSwitcher>
