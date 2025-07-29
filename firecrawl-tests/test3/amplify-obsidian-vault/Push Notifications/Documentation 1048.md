---
title: Documentation
topics: ['Push Notifications']
primary_topic: Push Notifications
source: fragments/lib/push-notifications/flutter/interact_with_notifications/on-foreground-notification.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, push-notifications]
---


## 🧭 Navigation
**Topics**: [[Push Notifications/]]
**Primary**: [[Push Notifications/]]

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


---

## 📚 Related Topics
- [[Push Notifications/]]

## 📖 Source
Original: `fragments/lib/push-notifications/flutter/interact_with_notifications/on-foreground-notification.mdx`