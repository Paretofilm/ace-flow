---
title: Identify a user with Amazon Pinpoint
topics: ['General']
primary_topic: General
source: pages/build-a-backend/add-aws-services/in-app-messaging/identify-user/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Identify a user with Amazon Pinpoint

To fully harness the potential of In-App Messaging, you must segment and target your In-App Messaging campaigns to specific user subsets. By identifying users with additional information, including their device demographics, location and any attributes of your choosing, you will be able to display intelligent, targeted in-app messages to the right users.

```js title="src/index.js"

await identifyUser(,
    demographic: ,
    location: ,
    metrics: ,
  },
});
```

## Identify a user with Amazon Pinpoint

When using `identifyUser` with Amazon Pinpoint, in addition to the other user info properties you can configure the `address`, `optOut`, and `userAttributes` properties under `options`.

```js title="src/index.js"

await identifyUser(
  },
});
```


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `pages/build-a-backend/add-aws-services/in-app-messaging/identify-user/index.mdx`