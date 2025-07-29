---
title: Configure your application
source: fragments/lib-v1/graphqlapi/js/react-native-configure.mdx
---

# Configure your application

## Configure your application

Add Amplify to your app with `yarn` or `npm`:

```bash
npm install aws-amplify@^5 @react-native-async-storage/async-storage @react-native-community/netinfo
```

In your app's entry point i.e. **App.js** (Expo) or **index.js** (React Native CLI), import and load the configuration file:

```javascript
Amplify.configure(awsconfig);
```
