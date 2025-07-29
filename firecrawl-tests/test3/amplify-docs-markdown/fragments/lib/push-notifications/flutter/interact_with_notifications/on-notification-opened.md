---
title: Documentation
source: fragments/lib/push-notifications/flutter/interact_with_notifications/on-notification-opened.mdx
---

# Documentation

```dart
void myNotificationOpenedHandler(PushNotificationMessage notification) 

final subscription = Amplify.Notifications.Push.onNotificationOpened
  .listen(myNotificationReceivedHandler);

// Remember to cancel the subscription when it is no longer needed
subscription.cancel();
```
