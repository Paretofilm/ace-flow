---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/ios/datastore-events.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

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


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/ios/datastore-events.mdx`