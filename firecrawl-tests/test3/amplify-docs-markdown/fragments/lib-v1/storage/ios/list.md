---
title: Documentation
source: fragments/lib-v1/storage/ios/list.mdx
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
