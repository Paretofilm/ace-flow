---
title: Resolve conflicts
topics: ['General']
primary_topic: General
source: pages/build-a-backend/add-aws-services/in-app-messaging/resolve-conflicts/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Resolve conflicts

In the rare case where an event is sent and meets the criteria set forth by multiple in-app messages, the library needs to decide which message to return. If such a conflict should arise, In-App Messaging will choose a message by:

1. Sorting the messages in order of campaign expiration
2. Returning the top message sorted (the closest message to expiry)

However, this may not be how you wish to resolve such conflicts so you may want to set your own conflict handler.

```js title="src/index.js"

/**
 * Regardless of your conflict resolution strategy the handler must always accept
 * an array of in-app messages and return a single in-app message.
 */
const myConflictHandler = (messages) => ;

setConflictHandler(myConflictHandler);
```


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `pages/build-a-backend/add-aws-services/in-app-messaging/resolve-conflicts/index.mdx`