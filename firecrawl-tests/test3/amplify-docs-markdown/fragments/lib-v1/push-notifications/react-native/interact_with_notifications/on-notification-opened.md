---
title: Documentation
source: fragments/lib-v1/push-notifications/react-native/interact_with_notifications/on-notification-opened.mdx
---

# Documentation

```js
const myNotificationOpenedHandler = (notification) => ;

const listener = Notifications.Push.onNotificationOpened(
  myNotificationOpenedHandler
);

listener.remove(); // Remember to remove the listener when it is no longer needed
```
