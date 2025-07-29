---
title: Documentation
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib-v1/storage/ios/list.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Documentation

You can list all of the objects uploaded:

```swift
Amplify.Storage.list 
    case let .failure(storageError):
        print("Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
    }
}
```

</Block>

```swift
let sink = Amplify.Storage.list()
    .resultPublisher
    .sink 
    }
    receiveValue: 
    }
```

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib-v1/storage/ios/list.mdx`