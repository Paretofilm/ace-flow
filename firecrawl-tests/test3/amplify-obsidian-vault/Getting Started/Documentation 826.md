---
title: Documentation
topics: ['Getting Started']
primary_topic: Getting Started
source: fragments/lib/restapi/js/getting-started/30_initapi.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, getting-started]
---


## 🧭 Navigation
**Topics**: [[Getting Started/]]
**Primary**: [[Getting Started/]]

---


# Documentation

To initialize the Amplify API category you need to configure Amplify with `Amplify.configure()`.

Import and load the configuration file in your app. It's recommended you add the Amplify configuration step to your app's root entry point. For example `index.js` in React or `main.ts` in Angular.

```javascript

Amplify.configure(amplifyconfig);
```

> **Note**: 

Make sure you call `Amplify.configure` as early as possible in your application’s life-cycle. A missing configuration or `NoCredentials` error is thrown if `Amplify.configure` has not been called before other Amplify JavaScript APIs. Review the [Library Not Configured Troubleshooting guide](/gen1/[platform]/build-a-backend/troubleshooting/library-not-configured/) for possible causes of this issue.


---

## 📚 Related Topics
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/restapi/js/getting-started/30_initapi.mdx`