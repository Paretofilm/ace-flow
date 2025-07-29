---
title: Documentation
source: fragments/lib-v1/push-notifications/flutter/request_permissions/request-permissions.mdx
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
