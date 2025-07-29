---
title: Documentation
topics: ['Push Notifications', 'React', 'Authentication']
primary_topic: Push Notifications
source: fragments/lib-v1/push-notifications/react-native/identify_user/10_get_auth_user.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, push-notifications, react, authentication]
---


## 🧭 Navigation
**Topics**: [[Push Notifications/]] • [[React/]] • [[Authentication/]]
**Primary**: [[Push Notifications/]]

---


# Documentation

If the user is signed in through [Auth.signIn](/gen1/[platform]/prev/build-a-backend/auth/enable-sign-up/#sign-in), then you can retrieve the current user's ID as shown below:

```js
const user = await Auth.currentAuthenticatedUser();

// sub is a unique identifier of the authenticated user
const userId = user.attributes.sub;
```


---

## 📚 Related Topics
- [[Push Notifications/]]
- [[React/]]
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib-v1/push-notifications/react-native/identify_user/10_get_auth_user.mdx`