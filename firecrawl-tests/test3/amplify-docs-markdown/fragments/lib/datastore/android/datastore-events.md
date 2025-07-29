---
title: Documentation
source: fragments/lib/datastore/android/datastore-events.mdx
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
