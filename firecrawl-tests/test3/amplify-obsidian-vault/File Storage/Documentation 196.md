---
title: Documentation
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib-v1/storage/ios/remove.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

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


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib-v1/storage/ios/remove.mdx`