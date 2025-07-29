---
title: Integrate In-App Messaging
topics: ['General']
primary_topic: General
source: fragments/lib-v1/in-app-messaging/integrate-your-application/integrate-your-application.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Integrate In-App Messaging

In your application directory, you should first install the necessary dependencies for using In-App Messaging.

## Integrate In-App Messaging

Amplify UI provides a Higher-Order Component for ease of integrating the In-App Messaging UI with your application. Simply wrap your application root component in, for example, `App.js`.

Now your application is set up with Amplify In-App Messaging. To interact with Amplify In-App Messaging APIs, you will first need to import the `Notifications` category.

```js
```

The In-App Messaging feature is a subcategory of Notifications. To make it easier to access throughout your application, you can de-structure it.

```js
const  = Notifications;
```

Below is an example of what your entry file should look like:

You can now build and run your app in your terminal. If you click on one of the buttons shown in the above example, the in-app message you defined in the Pinpoint console should be displayed in your app.


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib-v1/in-app-messaging/integrate-your-application/integrate-your-application.mdx`