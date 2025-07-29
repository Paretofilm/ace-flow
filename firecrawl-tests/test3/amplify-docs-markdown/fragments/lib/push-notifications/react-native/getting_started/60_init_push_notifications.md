---
title: Documentation
source: fragments/lib/push-notifications/react-native/getting_started/60_init_push_notifications.mdx
---

# Documentation

To initialize Amplify Push Notifications, you will first need to configure Amplify.

Import and load the configuration file in your app.

```js
// Example index.js
// ...

Amplify.configure(amplifyconfig);
// ...
```

Next, initialize Amplify Push Notifications. It is recommended to do this in your app's root entry point after configuring Amplify if your app requires push notification handling even while in a terminated state.

```js
// Example index.js
// ...

initializePushNotifications();
// ...
```

Your resulting entry file should look something like the following:

```js

Amplify.configure(amplifyconfig);
initializePushNotifications();

AppRegistry.registerComponent(appName, () => App);
```
