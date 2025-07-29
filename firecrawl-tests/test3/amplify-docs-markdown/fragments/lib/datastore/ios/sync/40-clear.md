---
title: Documentation
source: fragments/lib/datastore/ios/sync/40-clear.mdx
---

# Documentation

```swift
let isSignedOut = HubFilters.forEventName(HubPayload.EventName.Auth.signedOut)
let token = Amplify.Hub.listen(to: .auth, isIncluded: isSignedOut)  catch let error as DataStoreError  catch 
    }
}
```

</Block>

```swift
let isSignedOut = HubFilters.forEventName(HubPayload.EventName.Auth.signedOut)
let sink = Amplify.Hub.publisher(for: .auth)
    .setFailureType(to: DataStoreError.self)
    .filter 
    .sink 
    receiveValue:  catch 
        }
    }
```

</Block>

</BlockSwitcher>
