---
title: Documentation
source: fragments/lib-v1/datastore/ios/datastore-events.mdx
---

# Documentation

```swift
let hubEventListener = Amplify.Hub.listen(to: .dataStore) 
        print("User receives a network connection status: \(networkStatus.active)")
    }
}
```

</Block>

```swift
let hubEventSubscriber = Amplify.Hub.publisher(for: .dataStore).sink 
        print("User receives a network connection status: \(networkStatus.active)")
    }
}
```

</Block>

</BlockSwitcher>

> **Note**: 

An initial `networkStatus` event is always dispatched, in which `active` is set to `false`. Shortly thereafter, you will receive an updated event that reflects the true status of the network connectivity.

> **Note**: 

You may want to setup your Hub Listener or Subscriber before calling `Amplify.configure()`, otherwise you may miss some of the `DataStore` events that are emitted.
