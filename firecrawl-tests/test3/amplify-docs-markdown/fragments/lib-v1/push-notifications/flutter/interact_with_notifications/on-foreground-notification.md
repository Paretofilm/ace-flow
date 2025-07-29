---
title: Documentation
source: fragments/lib-v1/push-notifications/flutter/interact_with_notifications/on-foreground-notification.mdx
---

# Documentation

```dart
void myNotificationReceivedHandler(PushNotificationMessage notification) 

final subscription = Amplify
  .Notifications.Push.onNotificationReceivedInForeground
  .listen(myNotificationReceivedHandler);

// Remember to cancel the subscription when it is no longer needed
subscription.cancel();
```
