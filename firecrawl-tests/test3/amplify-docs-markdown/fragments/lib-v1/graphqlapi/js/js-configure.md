---
title: Configure your application
source: fragments/lib-v1/graphqlapi/js/js-configure.mdx
---

# Configure your application

## Configure your application

Add Amplify to your app with `yarn` or `npm`:

```bash
npm install aws-amplify@^5
```

In your app's entry point i.e. App.ts or App.js, import and load the configuration file:

```javascript
Amplify.configure(awsconfig);
```
