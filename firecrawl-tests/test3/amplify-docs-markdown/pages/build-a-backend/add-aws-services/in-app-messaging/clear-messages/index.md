---
title: Clear messages
source: pages/build-a-backend/add-aws-services/in-app-messaging/clear-messages/index.mdx
---

# Clear messages

Once messages have been synced to your user's device, `clearMessages()` can be used to clear the synced messages.

```js title="src/index.js"

await clearMessages();
```

> **Note**: 

**Note:** If your app has authentication implemented, we recommend calling `clearMessages()` in between user log-ins to remove messages targeted for specific user segments. This is especially important if you anticipate your application will be used in shared device scenarios.
