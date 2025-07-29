---
title: Documentation
topics: ['Push Notifications', 'React', 'Getting Started']
primary_topic: Push Notifications
source: fragments/lib-v1/push-notifications/react-native/getting_started/60_init_push_notifications.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, push-notifications, react, getting-started]
---


## 🧭 Navigation
**Topics**: [[Push Notifications/]] • [[React/]] • [[Getting Started/]]
**Primary**: [[Push Notifications/]]

---


# Documentation

To initialize Amplify Push Notifications, you will first need to configure Amplify.

Import and load the configuration file in your app. It's recommended you add the Amplify configuration step to your app's root entry point. For example, `index.js`

```js
// Example index.js
...

Amplify.configure(awsconfig);
...
```

Next, enable Amplify Push Notifications. You should do this in your app's root entry point after configuring Amplify as push notifications can occur even while your app is in a terminated state.

```js
// Example index.js
...
Notifications.Push.enable();
...
```

Your resulting entry file should look something like the following:

```js
import 'react-native-get-random-values';
import 'react-native-url-polyfill/auto';

Amplify.configure(awsconfig);
Notifications.Push.enable();

AppRegistry.registerComponent(appName, () => App);
```


---

## 📚 Related Topics
- [[Push Notifications/]]
- [[React/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/push-notifications/react-native/getting_started/60_init_push_notifications.mdx`