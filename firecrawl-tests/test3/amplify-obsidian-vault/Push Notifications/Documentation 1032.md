---
title: Documentation
topics: ['Push Notifications']
primary_topic: Push Notifications
source: fragments/lib/push-notifications/ios/identify_user/30_send_to_pinpoint_profile.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, push-notifications]
---


## 🧭 Navigation
**Topics**: [[Push Notifications/]]
**Primary**: [[Push Notifications/]]

---


# Documentation

Alternatively, you can provide additional information about the user by passing a user profile:

```swift
let userProfile = BasicUserProfile(
    name: "Name",
    customProperties: [
        "attribute": "value"
    ]
)

try await Amplify.Notifications.Push.identifyUser(
    userId: user,
    userProfile: userProfile
)
```


---

## 📚 Related Topics
- [[Push Notifications/]]

## 📖 Source
Original: `fragments/lib/push-notifications/ios/identify_user/30_send_to_pinpoint_profile.mdx`