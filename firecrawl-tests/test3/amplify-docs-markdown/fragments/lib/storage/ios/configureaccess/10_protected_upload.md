---
title: Documentation
source: fragments/lib/storage/ios/configureaccess/10_protected_upload.mdx
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
