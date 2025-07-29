---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/android/datastore-events.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Documentation

```java
Amplify.Hub.subscribe(
    HubChannel.DATASTORE,
    hubEvent -> DataStoreChannelEventName.NETWORK_STATUS.toString().equals(hubEvent.getName()),
    hubEvent -> 
);
```

</Block>

```kotlin
Amplify.Hub.subscribe(HubChannel.DATASTORE,
    ,
    ")
    }
)
```

</Block>

```kotlin
Amplify.Hub.subscribe(DATASTORE)
    
    .collect ")
    }
```

</Block>

```java
RxAmplify.Hub.on(HubChannel.DATASTORE)
    .filter(hubEvent -> DataStoreChannelEventName.NETWORK_STATUS.toString().equals(hubEvent.getName()))
    .subscribe(hubEvent -> );
```

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/android/datastore-events.mdx`