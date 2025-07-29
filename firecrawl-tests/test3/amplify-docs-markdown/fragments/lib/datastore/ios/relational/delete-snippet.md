---
title: Documentation
source: fragments/lib/datastore/ios/relational/delete-snippet.mdx
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
