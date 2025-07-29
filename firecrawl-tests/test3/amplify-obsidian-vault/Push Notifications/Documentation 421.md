---
title: Documentation
topics: ['Push Notifications', 'React']
primary_topic: Push Notifications
source: fragments/lib-v1/push-notifications/react-native/request_permissions/get-permission-status.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, push-notifications, react]
---


## 🧭 Navigation
**Topics**: [[Push Notifications/]] • [[React/]]
**Primary**: [[Push Notifications/]]

---


# Documentation

> **Note**: 
  If you use TypeScript for your development, the string values returned can be
  represented as PushNotificationPermissionStatus enum members as well.

```js
const status = await Notifications.Push.getPermissionStatus();
// 'SHOULD_REQUEST' | 'SHOULD_EXPLAIN_THEN_REQUEST' | 'GRANTED' | 'DENIED'
```


---

## 📚 Related Topics
- [[Push Notifications/]]
- [[React/]]

## 📖 Source
Original: `fragments/lib-v1/push-notifications/react-native/request_permissions/get-permission-status.mdx`