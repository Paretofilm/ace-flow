---
title: Documentation
source: fragments/lib-v1/push-notifications/react-native/receive_device_token/on-token-received.mdx
---

# Documentation

```js
const myTokenReceivedHandler = (token) => ;

const listener = Notifications.Push.onTokenReceived(myTokenReceivedHandler);

listener.remove(); // Remember to remove the listener when it is no longer needed
```
