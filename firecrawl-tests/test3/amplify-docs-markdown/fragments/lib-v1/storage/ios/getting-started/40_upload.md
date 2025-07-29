---
title: Documentation
source: fragments/lib-v1/storage/ios/getting-started/40_upload.mdx
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
