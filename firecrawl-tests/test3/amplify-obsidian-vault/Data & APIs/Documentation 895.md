---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/ios/sync/40-clear.mdx
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


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/ios/sync/40-clear.mdx`