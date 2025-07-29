---
title: Documentation
source: fragments/lib/push-notifications/flutter/receive_device_token/on-token-received.mdx
---

# Documentation

```dart
void myTokenReceivedHandler(String token) 

final subscription = Amplify.Notifications.Push.onTokenReceived
  .listen(myTokenReceivedHandler);

// Remember to cancel the subscription when it is no longer needed
subscription.cancel();
```
