---
title: Documentation
source: fragments/lib-v1/push-notifications/react-native/request_permissions/get-permission-status.mdx
---

# Documentation

> **Note**: 
  If you use TypeScript for your development, the string values returned can be
  represented as PushNotificationPermissionStatus enum members as well.

```js
const status = await Notifications.Push.getPermissionStatus();
// 'SHOULD_REQUEST' | 'SHOULD_EXPLAIN_THEN_REQUEST' | 'GRANTED' | 'DENIED'
```
