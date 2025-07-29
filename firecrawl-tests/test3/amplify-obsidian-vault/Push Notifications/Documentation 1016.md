---
title: Documentation
topics: ['Push Notifications', 'React']
primary_topic: Push Notifications
source: fragments/lib/push-notifications/react-native/interact_with_notifications/on-foreground-notification.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, push-notifications, react]
---


## 🧭 Navigation
**Topics**: [[Push Notifications/]] • [[React/]]
**Primary**: [[Push Notifications/]]

---


# Documentation

```ts
import  from 'aws-amplify/push-notifications';

const myNotificationReceivedHandler: OnNotificationReceivedInForegroundInput = (
  notification
) => ;

const listener: OnNotificationReceivedInForegroundOutput = onNotificationReceivedInForeground(
  myNotificationReceivedHandler
);

listener.remove(); // Remember to remove the listener when it is no longer needed
```

</Block>

```js

const myNotificationReceivedHandler = (notification) => ;

const listener = onNotificationReceivedInForeground(
  myNotificationReceivedHandler
);

listener.remove(); // Remember to remove the listener when it is no longer needed
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Push Notifications/]]
- [[React/]]

## 📖 Source
Original: `fragments/lib/push-notifications/react-native/interact_with_notifications/on-foreground-notification.mdx`