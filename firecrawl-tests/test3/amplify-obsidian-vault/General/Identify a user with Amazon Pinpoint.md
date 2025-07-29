---
title: Identify a user with Amazon Pinpoint
topics: ['General']
primary_topic: General
source: fragments/lib-v1/in-app-messaging/identify-user/identify-user.mdx
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

```js
const userInfo = ,
  demographic: ,
  location: ,
  metrics: 
};

await InAppMessaging.identifyUser('some-user-id', userInfo);
```

## Identify a user with Amazon Pinpoint

When using `identifyUser` with Amazon Pinpoint, you can configure the `address` and `optOut` properties in addition to the other user info properties.

```js
const userInfo = ;

await InAppMessaging.identifyUser('some-user-id', userInfo);
```


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib-v1/in-app-messaging/identify-user/identify-user.mdx`