---
title: Documentation
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib-v1/storage/ios/configureaccess/20_protected_download.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Documentation

```swift
func downloadData(key: String, identityId: String) , resultListener: 
    })
}
```

</Block>

```swift
var progressSink: AnyCancellable?
var resultSink: AnyCancellable?
    
func downloadData(key: String, identityId: String) 
    resultSink = storageOperation.resultPublisher.sink 
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
Original: `fragments/lib-v1/storage/ios/configureaccess/20_protected_download.mdx`