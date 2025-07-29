---
title: Documentation
source: fragments/lib-v1/utilities/ios/hub/20_listen_stop.mdx
---

# Documentation

Hub provides a way to stop listening for messages. This is useful if you no longer need to receive messages in your application flow.

```swift
// Assumes `unsubscribeToken` references the token
// returned by Amplify.Hub.listen(...)
Amplify.Hub.removeListener(unsubscribeToken)
```

</Block>

```swift
// Assumes `sink` references the sink
// returned by Amplify.Hub.publisher(...).sink
sink.cancel()
```

</Block>

</BlockSwitcher>
