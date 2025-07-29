---
title: Documentation
source: fragments/lib-v1/storage/ios/remove.mdx
---

# Documentation

Delete an object uploaded to S3 by using `Amplify.Storage.remove` and specify the key:

```swift
Amplify.Storage.remove(key: "myKey") 
}
```

</Block>

```swift
let sink = Amplify.Storage.remove(key: "myKey")
    .resultPublisher
    .sink 
    }
    receiveValue: 
```

</Block>

</BlockSwitcher>
