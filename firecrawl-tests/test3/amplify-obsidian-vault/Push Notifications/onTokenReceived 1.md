---
title: onTokenReceived
topics: ['Push Notifications']
primary_topic: Push Notifications
source: fragments/lib/push-notifications/common/receive-device-token.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, push-notifications]
---


## 🧭 Navigation
**Topics**: [[Push Notifications/]]
**Primary**: [[Push Notifications/]]

---


# onTokenReceived

Push notifications are delivered to your user's devices through a device token which uniquely identifies your app. Although Amplify will automatically register this token with Amazon Pinpoint, it can still be useful to have access to this token for your app's use cases (e.g. to send direct notifications to a specific device).

## onTokenReceived

Add `onTokenReceived` listeners to respond to a token being received by your app.

A token will be received by your app:

- On every app launch, including the first install
- When a token changes (this may happen if the service invalidates the token for any reason)


---

## 📚 Related Topics
- [[Push Notifications/]]

## 📖 Source
Original: `fragments/lib/push-notifications/common/receive-device-token.mdx`