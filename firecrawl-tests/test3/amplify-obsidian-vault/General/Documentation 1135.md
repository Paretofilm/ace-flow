---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib/in-app-messaging/clear-messages/clear-messages.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Documentation

Once messages have been synced to your user’s device, `clearMessages()` can be used to clear the synced messages.

```js

await clearMessages();
```

> **Note**: 
  NOTE: If your app has authentication implemented, we recommend calling
  clearMessages() in between user log-ins to remove messages targeted for
  specific user segments. This is especially important if you anticipate your
  application will be used in shared device scenarios.


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/in-app-messaging/clear-messages/clear-messages.mdx`