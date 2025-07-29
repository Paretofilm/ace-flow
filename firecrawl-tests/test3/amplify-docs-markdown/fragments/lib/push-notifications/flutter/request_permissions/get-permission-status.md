---
title: Documentation
source: fragments/lib/push-notifications/flutter/request_permissions/get-permission-status.mdx
---

# Documentation

```dart
final status = await Amplify.Notifications.Push.getPermissionStatus();
// PushNotificationPermissionStatus.shouldRequest |
// PushNotificationPermissionStatus.shouldExplainThenRequest |
// PushNotificationPermissionStatus.granted |
// PushNotificationPermissionStatus.denied
```
