---
title: Documentation
topics: ['Push Notifications', 'React']
primary_topic: Push Notifications
source: fragments/lib-v1/push-notifications/react-native/interact_with_notifications/on-background-notification.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, push-notifications, react]
---


## 🧭 Navigation
**Topics**: [[Push Notifications/]] • [[React/]]
**Primary**: [[Push Notifications/]]

---


# Documentation

1. You should add this listener to your app's root entry point, i.e. _before_ registering your app component because it will be run via React Native's [Headless JS](https://reactnative.dev/docs/headless-js-android) and your app will not mount/render.
2. Notifications received in a terminated state will be considered low priority by Android unless you increase the priority of the payload by setting the `priority` to `high` (you will need to create a _Raw Message_ in Amazon Pinpoint to set this priority).

```js
// Example index.js
...
Amplify.configure(config);
Notifications.Push.enable();

// Note: This handler does not *need* to be async, but it can be!
const myAsyncNotificationReceivedHandler = async (notification) => ;

// It is recommended that you add this before registering your app component.
// You also shouldn't need to remove this listener if it is added here.
Notifications.Push.onNotificationReceivedInBackground(
  myAsyncNotificationReceivedHandler
);

AppRegistry.registerComponent(appName, () => App);
```


---

## 📚 Related Topics
- [[Push Notifications/]]
- [[React/]]

## 📖 Source
Original: `fragments/lib-v1/push-notifications/react-native/interact_with_notifications/on-background-notification.mdx`