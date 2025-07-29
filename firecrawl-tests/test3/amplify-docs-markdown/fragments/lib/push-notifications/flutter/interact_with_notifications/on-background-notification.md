---
title: Documentation
source: fragments/lib/push-notifications/flutter/interact_with_notifications/on-background-notification.mdx
---

# Documentation

1. You should add this listener to your app's `main` function but _before_ `runApp` and `Amplify.configure` to avoid missing events.
2. The listener function added should be a [top-level global](https://dart.dev/language/functions#lexical-scope) or [static method](https://dart.dev/language/classes#static-methods) so that it can be invoked even when the app is terminated.
3. Notifications received in a terminated state will be considered low priority by Android unless you increase the priority of the payload by setting the `priority` to `high` (you will need to create a _Raw Message_ in Amazon Pinpoint to set this priority).

```dart
// Example main.dart

// Note: This handler does not *need* to be async, but it can be!
Future<void> myAsyncNotificationReceivedHandler(
    PushNotificationMessage notification) async 

void main() 

  runApp(const MyApp());
}
```
