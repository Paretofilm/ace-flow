---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/ios/sync/40-clear.mdx
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


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/ios/sync/40-clear.mdx`