---
title: Install Amplify and its dependencies
topics: ['React']
primary_topic: React
source: fragments/lib-v1/react-native-polyfills.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, react]
---


## 🧭 Navigation
**Topics**: [[React/]]
**Primary**: [[React/]]

---


# Install Amplify and its dependencies

## Install Amplify and its dependencies

```bash
npm install aws-amplify@^5 amazon-cognito-identity-js @react-native-community/netinfo @react-native-async-storage/async-storage react-native-get-random-values react-native-url-polyfill
```

You need to add the crypto.getRandomValues and URL polyfills to your application's entry point file (in most React Native apps this will be the top level index.js).

```js
// Example index.js
import 'react-native-get-random-values';
import 'react-native-url-polyfill/auto';

AppRegistry.registerComponent(appName, () => App);
```


---

## 📚 Related Topics
- [[React/]]

## 📖 Source
Original: `fragments/lib-v1/react-native-polyfills.mdx`