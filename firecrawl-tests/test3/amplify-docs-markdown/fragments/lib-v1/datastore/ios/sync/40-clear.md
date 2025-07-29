---
title: Documentation
source: fragments/lib-v1/datastore/ios/sync/40-clear.mdx
---

# Documentation

```swift
let isSignedOut = HubFilters.forEventName(HubPayload.EventName.Auth.signedOut)
_ = Amplify.Hub.listen(to: .auth, isIncluded: isSignedOut) 
    }
}
```

</Block>

```swift
let isSignedOut = HubFilters.forEventName(HubPayload.EventName.Auth.signedOut)
let sink = Amplify.Hub.publisher(for: .auth)
    .setFailureType(to: DataStoreError.self)
    .filter 
    .flatMap 
    .sink 
    }
    receiveValue: 
```

</Block>

</BlockSwitcher>
