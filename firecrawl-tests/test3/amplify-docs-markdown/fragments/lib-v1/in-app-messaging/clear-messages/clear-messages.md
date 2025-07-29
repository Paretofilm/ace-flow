---
title: Documentation
source: fragments/lib-v1/in-app-messaging/clear-messages/clear-messages.mdx
---

# Documentation

Once messages have been synced to your user’s device, `InAppMessaging.clearMessages()` can be used to clear the synced messages.

```js
await InAppMessaging.clearMessages();
```

> **Note**: 
  NOTE: If your app has authentication implemented, we recommend calling
  InAppMessaging.clearMessages() in between user log-ins to remove messages
  targeted for specific user segments. This is especially important if you
  anticipate your application will be used in shared device scenarios.
