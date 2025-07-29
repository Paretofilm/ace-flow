---
title: Documentation
source: fragments/lib-v1/utilities/android/hub/20_listen_stop.mdx
---

# Documentation

Hub provides a way to stop listening for messages. This is useful if you no longer need to receive messages in your application flow (ex: changing Activities or Fragments), as well as to avoid any memory leaks.

```java
// Subscribe to Hub Auth events and capture the returned SubscriptionToken
SubscriptionToken subscriptionToken = Amplify.Hub.subscribe(HubChannel.AUTH, event -> );

// Unsubscribe by passing the captured SubscriptionToken
Amplify.Hub.unsubscribe(subscriptionToken);
```

</Block>

```kotlin
// Subscribe to Hub Auth events and capture the returned SubscriptionToken
val subscriptionToken = Amplify.Hub.subscribe(HubChannel.AUTH) 

// Unsubscribe by passing the captured SubscriptionToken 
Amplify.Hub.unsubscribe(subscriptionToken)
```

</Block>

</BlockSwitcher>
