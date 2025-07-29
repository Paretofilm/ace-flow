---
title: Documentation
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib/storage/ios/configureaccess/20_protected_download.mdx
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
func downloadData(key: String, identityId: String) async throws 
    }
    let data = try await downloadTask.value
    print("Completed: \(data)")
}

```

</Block>

```swift
var progressSink: AnyCancellable?
var resultSink: AnyCancellable?

func downloadData(key: String, identityId: String) 

    resultSink = downloadTask
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
Original: `fragments/lib/storage/ios/configureaccess/20_protected_download.mdx`