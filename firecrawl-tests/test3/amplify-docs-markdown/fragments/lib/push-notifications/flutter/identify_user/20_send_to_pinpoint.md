---
title: Documentation
source: fragments/lib/push-notifications/flutter/identify_user/20_send_to_pinpoint.mdx
---

# Documentation

```dart
final userProfile = AWSPinpointUserProfile(
  userAttributes: ,
);

await Amplify.Notifications.Push.identifyUser(
  userId: userId,
  userProfile: userProfile,
);
```
