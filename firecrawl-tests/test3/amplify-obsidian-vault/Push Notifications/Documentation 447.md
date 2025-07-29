---
title: Documentation
topics: ['Push Notifications']
primary_topic: Push Notifications
source: fragments/lib-v1/push-notifications/flutter/identify_user/20_send_to_pinpoint.mdx
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
final userProfile = AWSPinpointUserProfile(
  userAttributes: ,
);

await Amplify.Notifications.Push.identifyUser(
  userId: userId,
  userProfile: userProfile,
);
```


---

## 📚 Related Topics
- [[Push Notifications/]]

## 📖 Source
Original: `fragments/lib-v1/push-notifications/flutter/identify_user/20_send_to_pinpoint.mdx`