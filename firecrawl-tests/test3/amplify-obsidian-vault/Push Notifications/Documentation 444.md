---
title: Documentation
topics: ['Push Notifications']
primary_topic: Push Notifications
source: fragments/lib-v1/push-notifications/flutter/request_permissions/request-permissions.mdx
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
final result = await Amplify.Notifications.Push.requestPermissions(
  // permissions are true by default
  // alert: true
  badge: true,
  sound: true,
);
// true if granted (or already granted), false otherwise
```


---

## 📚 Related Topics
- [[Push Notifications/]]

## 📖 Source
Original: `fragments/lib-v1/push-notifications/flutter/request_permissions/request-permissions.mdx`