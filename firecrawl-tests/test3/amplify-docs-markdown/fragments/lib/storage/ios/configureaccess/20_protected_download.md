---
title: Documentation
source: fragments/lib/storage/ios/configureaccess/20_protected_download.mdx
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
