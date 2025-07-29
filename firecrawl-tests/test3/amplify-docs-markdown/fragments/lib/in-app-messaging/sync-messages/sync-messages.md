---
title: Documentation
source: fragments/lib/in-app-messaging/sync-messages/sync-messages.mdx
---

# Documentation

To trigger messages, you must sync them from your In-App Messaging campaigns to your users' devices. These messages are then triggered with an analytics or In-App Messaging event. You can control when and how often this sync is performed.

```js

await syncMessages();
```

> **Note**: 
  NOTE: Syncing messages will always overwrite existing messages currently on
  the user's device so they are always up to date when the sync is performed.
