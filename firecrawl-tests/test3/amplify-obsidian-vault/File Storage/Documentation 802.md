---
title: Documentation
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib/storage/ios/configureaccess/10_protected_upload.mdx
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
func uploadData(key: String, data: Data) async throws 
    }
    let data = try await uploadTask.value
    print("Completed: \(data)")
}
```

</Block>

```swift
var resultSink: AnyCancellable?
var progressSink: AnyCancellable?

func uploadData(key: String, data: Data) 

    resultSink = uploadTask
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
Original: `fragments/lib/storage/ios/configureaccess/10_protected_upload.mdx`