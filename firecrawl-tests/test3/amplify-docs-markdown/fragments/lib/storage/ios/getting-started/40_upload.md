---
title: With StoragePath
source: fragments/lib/storage/ios/getting-started/40_upload.mdx
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
