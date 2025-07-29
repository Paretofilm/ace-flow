---
title: Documentation
source: fragments/lib/datastore/android/sync/40-clear.mdx
---

# Documentation

```java
// Listen for sign out events.
final String signedOutEventName = AuthChannelEventName.SIGNED_OUT.toString();

Amplify.Hub.subscribe(HubChannel.AUTH,
    anyAuthEvent -> signedOutEventName.equals(anyAuthEvent.getName()),
    // When one arrives, clear the DataStore.
    signedOutEvent -> Amplify.DataStore.clear(
        () -> Log.i("MyAmplifyApp", "DataStore is cleared."),
        failure -> Log.e("MyAmplifyApp", "Failed to clear DataStore.")
    )
);
```

</Block>

```kotlin
Amplify.Hub.subscribe(HubChannel.AUTH,
    ,
    ,
            
        )
    }
)
```

</Block>

```kotlin
Amplify.Hub.subscribe(HubChannel.AUTH)
    
    // When sign out event arrives, clear the DataStore.
    .onEach 
    .catch 
    .collect 
```

</Block>

```java
// Listen for sign out events.
final String signedOutEventName = AuthChannelEventName.SIGNED_OUT.toString();

RxAmplify.Hub.on(HubChannel.AUTH)
    .filter(event -> signedOutEventName.equals(event.getName()))
    .flatMapObservable(RxAmplify.DataStore::clear)
    .subscribe(
        () -> Log.i("MyAmplifyApp", "DataStore is cleared."),
        failure -> Log.e("MyAmplifyApp", "Failed to clear DataStore.")
    );
```

</Block>
</BlockSwitcher>
