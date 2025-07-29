---
title: Initialize In-App Messaging
topics: ['General']
primary_topic: General
source: fragments/lib/in-app-messaging/integrate-your-application/integrate-your-application.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Initialize In-App Messaging

In your application directory, you should first install the necessary dependencies for using In-App Messaging.

```bash
npm install aws-amplify
```

## Initialize In-App Messaging

To finish setting up your application with Amplify, you need to configure it using the `configure` API. Next, to interact with In-App Messaging APIs, you need to first initialize In-App Messaging by calling the `initializeInAppMessaging` API directly imported from the `in-app-messaging` sub-path. This is required to be called as early as possible in the app lifecycle.

```js

Amplify.configure(amplifyconfig);
initializeInAppMessaging();
```

> **Note**: 

Make sure you call `Amplify.configure` as early as possible in your application’s life-cycle. A missing configuration or `NoCredentials` error is thrown if `Amplify.configure` has not been called before other Amplify JavaScript APIs. Review the [Library Not Configured Troubleshooting guide](/gen1/[platform]/build-a-backend/troubleshooting/library-not-configured/) for possible causes of this issue.

## Integrate Amplify UI

Amplify UI provides a Higher-Order Component for ease of integrating the In-App Messaging UI with your application. Simply wrap your application root component in, for example, `App.js`.

Below is an example of what your entry file should look like:

You can now build and run your app in your terminal. If you click on one of the buttons shown in the above example, the in-app message you defined in the Pinpoint console should be displayed in your app.


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/in-app-messaging/integrate-your-application/integrate-your-application.mdx`