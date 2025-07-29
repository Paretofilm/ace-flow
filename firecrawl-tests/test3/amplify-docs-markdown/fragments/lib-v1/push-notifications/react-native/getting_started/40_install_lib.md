---
title: Documentation
source: fragments/lib-v1/push-notifications/react-native/getting_started/40_install_lib.mdx
---

# Documentation

In your project directory, you should first install the necessary dependencies for using Amplify Push Notifications.

```bash
npm install aws-amplify@^5 @aws-amplify/rtn-push-notification@~1.1.x amazon-cognito-identity-js @react-native-community/netinfo @react-native-async-storage/async-storage react-native-get-random-values react-native-url-polyfill
```

> **Note**: 

Note: Amplify JavaScript v5 is only compatible with @aws-amplify/rtn-push-notification version 1.1.x

You will also need to add the crypto.getRandomValues and URL polyfills to your application's entry point file (in most React Native apps this will be the top level `index.js`).

```js
// Example index.js
import 'react-native-get-random-values';
import 'react-native-url-polyfill/auto';
...
```
