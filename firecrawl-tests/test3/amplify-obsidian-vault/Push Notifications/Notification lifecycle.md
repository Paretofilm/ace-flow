---
title: Notification lifecycle
topics: ['Push Notifications']
primary_topic: Push Notifications
source: fragments/lib-v1/push-notifications/common/interact_with_notifications/notification-lifecycle.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, push-notifications]
---


## 🧭 Navigation
**Topics**: [[Push Notifications/]]
**Primary**: [[Push Notifications/]]

---


# Notification lifecycle

## Notification lifecycle

Before delving into details about the various functions Amplify provides, it can be helpful to better understand the lifecycle of a notification as it moves through your app in its various states once you've integrated Amplify Push Notifications.

For the purposes of this guide, we will simplify the terminology as follows

### In a foreground state

![Chart of the foreground state lifecycle](/images/push-notifications/cross-platform-lifecycle/pn-lifecycle-foreground.png)

- Notifications are not displayed when received in foreground
- It is possible for notifications to arrive in your user's notification center but not be opened until a later time
- Since it is possible to interact with the notification center at any time on a device, your user could even open a notification while your app is in the active foreground

### In a background state

![Chart of the background state lifecycle](/images/push-notifications/cross-platform-lifecycle/pn-lifecycle-background.png)

- _Notification A_ represents an example of a notification which was received but never interacted with
- Recall that, in a background state, your app is still running and therefore does not need to be launched — only brought back into the foreground

### In a terminated state

![Chart of the terminated state lifecycle](/images/push-notifications/cross-platform-lifecycle/pn-lifecycle-terminated.png)

- _Notification A_ represents an example of a notification which was received but never interacted with
- Recall that, in a terminated state, your app is no longer running and therefore needs to be launched


---

## 📚 Related Topics
- [[Push Notifications/]]

## 📖 Source
Original: `fragments/lib-v1/push-notifications/common/interact_with_notifications/notification-lifecycle.mdx`