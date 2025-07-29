---
title: Documentation
topics: ['Push Notifications', 'React']
primary_topic: Push Notifications
source: fragments/lib-v1/push-notifications/react-native/receive_device_token/on-token-received.mdx
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
const myTokenReceivedHandler = (token) => ;

const listener = Notifications.Push.onTokenReceived(myTokenReceivedHandler);

listener.remove(); // Remember to remove the listener when it is no longer needed
```


---

## 📚 Related Topics
- [[Push Notifications/]]
- [[React/]]

## 📖 Source
Original: `fragments/lib-v1/push-notifications/react-native/receive_device_token/on-token-received.mdx`