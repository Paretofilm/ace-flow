---
title: Documentation
topics: ['Push Notifications', 'React']
primary_topic: Push Notifications
source: fragments/lib/push-notifications/react-native/receive_device_token/on-token-received.mdx
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

const myTokenReceivedHandler: OnTokenReceivedInput = (token) => ;

const listener: OnTokenReceivedOutput = onTokenReceived(myTokenReceivedHandler);

listener.remove(); // Remember to remove the listener when it is no longer needed
```

</Block>

```js

const myTokenReceivedHandler = (token) => ;

const listener = onTokenReceived(myTokenReceivedHandler);

listener.remove(); // Remember to remove the listener when it is no longer needed
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Push Notifications/]]
- [[React/]]

## 📖 Source
Original: `fragments/lib/push-notifications/react-native/receive_device_token/on-token-received.mdx`