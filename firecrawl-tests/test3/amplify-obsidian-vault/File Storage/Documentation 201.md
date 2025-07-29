---
title: Documentation
topics: ['File Storage', 'Getting Started']
primary_topic: File Storage
source: fragments/lib-v1/storage/ios/getting-started/40_upload.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage, getting-started]
---


## 🧭 Navigation
**Topics**: [[File Storage/]] • [[Getting Started/]]
**Primary**: [[File Storage/]]

---


# Documentation

```swift
func uploadData() , resultListener: 
    })
}
```

</Block>

```swift
// In your type's instance variables
var resultSink: AnyCancellable?
var progressSink: AnyCancellable?

// ...

func uploadData() 

    resultSink = storageOperation
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
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/storage/ios/getting-started/40_upload.mdx`