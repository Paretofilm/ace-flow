---
title: Documentation
topics: ['Push Notifications', 'React']
primary_topic: Push Notifications
source: fragments/lib-v1/push-notifications/react-native/interact_with_notifications/on-foreground-notification.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, push-notifications, react]
---


## 🧭 Navigation
**Topics**: [[Push Notifications/]] • [[React/]]
**Primary**: [[Push Notifications/]]

---


# Documentation

```js
const myNotificationReceivedHandler = (notification) => ;

const listener = Notifications.Push.onNotificationReceivedInForeground(
  myNotificationReceivedHandler
);

listener.remove(); // Remember to remove the listener when it is no longer needed
```


---

## 📚 Related Topics
- [[Push Notifications/]]
- [[React/]]

## 📖 Source
Original: `fragments/lib-v1/push-notifications/react-native/interact_with_notifications/on-foreground-notification.mdx`