---
title: Documentation
source: fragments/lib-v1/push-notifications/react-native/interact_with_notifications/on-foreground-notification.mdx
---

# Documentation

```js
const myNotificationReceivedHandler = (notification) => ;

const listener = Notifications.Push.onNotificationReceivedInForeground(
  myNotificationReceivedHandler
);

listener.remove(); // Remember to remove the listener when it is no longer needed
```
