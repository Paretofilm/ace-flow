---
title: Sync messages
source: pages/build-a-backend/add-aws-services/in-app-messaging/sync-messages/index.mdx
---

# Sync messages

To trigger messages, you must sync them from your In-App Messaging campaigns to your users' devices. These messages are then triggered with an analytics or In-App Messaging event. You can control when and how often this sync is performed.

```js title="src/index.js"

await syncMessages();
```

> **Note**: 

**Note:** Syncing messages will always overwrite existing messages currently on the user's device so that they are always up to date when the sync is performed.
