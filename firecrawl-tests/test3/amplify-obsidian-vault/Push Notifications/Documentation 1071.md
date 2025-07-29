---
title: Documentation
topics: ['Push Notifications', 'Getting Started']
primary_topic: Push Notifications
source: fragments/lib/push-notifications/android/getting_started/fcm-cli-resources.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, push-notifications, getting-started]
---


## 🧭 Navigation
**Topics**: [[Push Notifications/]] • [[Getting Started/]]
**Primary**: [[Push Notifications/]]

---


# Documentation

Choose _FCM_ when promoted:

```console
? Choose the push notification channel to enable.
  APNS |  Apple Push Notifications
❯ FCM  | » Firebase Push Notifications
  In-App Messaging
  Email
  SMS

? Provide your pinpoint resource name:
    `yourPinpointResourceName`

? Apps need authorization to send analytics events. Do you want to allow guests and unauthenticated users to send analytics events? (we recommend you allow this when getting started) (Y/n)
    'Y'

```

The CLI will prompt for your _service account key (json file) path_ created from steps in [setting up push notification services](/gen1/[platform]/build-a-backend/push-notifications/set-up-push-service/). Enter the absolute path, or a path relative to the location where you ran the command.


---

## 📚 Related Topics
- [[Push Notifications/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/push-notifications/android/getting_started/fcm-cli-resources.mdx`