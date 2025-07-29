---
title: Documentation
topics: ['Push Notifications', 'Authentication']
primary_topic: Push Notifications
source: fragments/lib-v1/push-notifications/flutter/identify_user/10_get_auth_user.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, push-notifications, authentication]
---


## 🧭 Navigation
**Topics**: [[Push Notifications/]] • [[Authentication/]]
**Primary**: [[Push Notifications/]]

---


# Documentation

If the user is signed in through [Amplify.Auth.signIn](/gen1/flutter/prev/build-a-backend/auth/enable-sign-in/), then you can retrieve the current user's ID as shown below:

```dart
final user = await Amplify.Auth.getCurrentUser();

final userId = user.userId
```


---

## 📚 Related Topics
- [[Push Notifications/]]
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib-v1/push-notifications/flutter/identify_user/10_get_auth_user.mdx`