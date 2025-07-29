---
title: Documentation
topics: ['Push Notifications']
primary_topic: Push Notifications
source: fragments/lib-v1/push-notifications/flutter/receive_device_token/on-token-received.mdx
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
void myTokenReceivedHandler(String token) 

final subscription = Amplify.Notifications.Push.onTokenReceived
  .listen(myTokenReceivedHandler);

// Remember to cancel the subscription when it is no longer needed
subscription.cancel();
```


---

## 📚 Related Topics
- [[Push Notifications/]]

## 📖 Source
Original: `fragments/lib-v1/push-notifications/flutter/receive_device_token/on-token-received.mdx`