---
title: Documentation
topics: ['Push Notifications', 'Authentication']
primary_topic: Push Notifications
source: fragments/lib/push-notifications/ios/identify_user/10_get_auth_user.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, push-notifications, authentication]
---


## 🧭 Navigation
**Topics**: [[Push Notifications/]] • [[Authentication/]]
**Primary**: [[Push Notifications/]]

---


# Documentation

If the user is signed in through [Amplify.Auth.signIn](/gen1/[platform]/build-a-backend/auth/enable-sign-in/), then you can retrieve the current user's ID as shown below:

```swift
let user = try await Amplify.Auth.getCurrentUser().userId
```


---

## 📚 Related Topics
- [[Push Notifications/]]
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/push-notifications/ios/identify_user/10_get_auth_user.mdx`