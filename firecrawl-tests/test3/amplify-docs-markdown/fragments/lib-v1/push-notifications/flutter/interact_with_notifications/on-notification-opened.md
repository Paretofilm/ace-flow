---
title: Documentation
source: fragments/lib-v1/push-notifications/flutter/interact_with_notifications/on-notification-opened.mdx
---

# Documentation

```dart
void myNotificationOpenedHandler(PushNotificationMessage notification) 

final subscription = Amplify.Notifications.Push.onNotificationOpened
  .listen(myNotificationReceivedHandler);

// Remember to cancel the subscription when it is no longer needed
subscription.cancel();
```
