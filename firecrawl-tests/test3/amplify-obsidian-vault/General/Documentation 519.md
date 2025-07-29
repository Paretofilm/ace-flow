---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib-v1/in-app-messaging/sync-messages/sync-messages.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Documentation

To trigger messages, you must sync them from your In-App Messaging campaigns to your users' devices. These messages are then triggered with an analytics or In-App Messaging event. You can control when and how often this sync is performed.

```js
await InAppMessaging.syncMessages();
```

> **Note**: 
  NOTE: Syncing messages will always overwrite existing messages currently on
  the user's device so they are always up to date when the sync is performed.


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib-v1/in-app-messaging/sync-messages/sync-messages.mdx`