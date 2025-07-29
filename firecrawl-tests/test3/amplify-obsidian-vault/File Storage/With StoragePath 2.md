---
title: With StoragePath
topics: ['File Storage', 'Getting Started']
primary_topic: File Storage
source: fragments/lib/storage/ios/getting-started/40_upload.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage, getting-started]
---


## 🧭 Navigation
**Topics**: [[File Storage/]] • [[Getting Started/]]
**Primary**: [[File Storage/]]

---


# With StoragePath

#### With StoragePath

```swift
func uploadData() async throws 
    }
    let value = try await uploadTask.value
    print("Completed: \(value)")
}
```

</Block>

```swift
// In your type's instance variables
var resultSink: AnyCancellable?
var progressSink: AnyCancellable?

// ...

func uploadData() 

    resultSink = uploadTask
        .resultPublisher
        .sink 
        }
        receiveValue: 
}
```

</Block>

</BlockSwitcher>

#### With Key (Deprecated)

```swift
func uploadData() async throws 
    }
    let value = try await uploadTask.value
    print("Completed: \(value)")
}
```

</Block>

```swift
// In your type's instance variables
var resultSink: AnyCancellable?
var progressSink: AnyCancellable?

// ...

func uploadData() 

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
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/storage/ios/getting-started/40_upload.mdx`