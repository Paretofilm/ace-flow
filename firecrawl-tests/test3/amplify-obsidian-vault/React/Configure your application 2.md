---
title: Configure your application
topics: ['React']
primary_topic: React
source: fragments/lib/graphqlapi/js/react-native-configure.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, react]
---


## 🧭 Navigation
**Topics**: [[React/]]
**Primary**: [[React/]]

---


# Configure your application

## Configure your application

Add Amplify to your app with `yarn` or `npm`:

```bash
npm install aws-amplify @react-native-async-storage/async-storage @react-native-community/netinfo
```

In your app's entry point i.e. **App.js** (Expo) or **index.js** (React Native CLI), import and load the configuration file:

```javascript
Amplify.configure(config);
```


---

## 📚 Related Topics
- [[React/]]

## 📖 Source
Original: `fragments/lib/graphqlapi/js/react-native-configure.mdx`