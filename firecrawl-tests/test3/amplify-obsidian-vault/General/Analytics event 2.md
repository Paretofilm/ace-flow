---
title: Analytics event
topics: ['General']
primary_topic: General
source: pages/build-a-backend/add-aws-services/in-app-messaging/display-messages/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Analytics event

In-app messages are displayed when an In-App Messaging or analytics event is sent and matches the criteria defined by your active In-App Messaging campaigns.

## Analytics event

Now that messages have been synced to your users' devices, Amplify In-App Messaging will allow you to start displaying them with Amplify Analytics events with no additional integration steps. Any events you record or are already recording using the Analytics' `record` API are automatically picked up and processed by In-App Messaging. If the event matches the attributes and criteria defined in an in-app message, that message will be displayed.

```js title="src/index.js"

record(,
  metrics: 
});
```

If the event name, attributes, and metrics match those set forth by one of your In-App Messaging campaigns, you should see the in-app message displayed in your app.

## In-App Messaging events

In addition to or instead of Amplify Analytics events, you can also dispatch In-App Messaging events to trigger an in-app message display programmatically.

```js title="src/index.js"

dispatchEvent(,
  metrics: 
});
```

If the event name, attributes, and metrics match those set forth by one of your In-App Messaging campaigns, you should see the in-app message displayed in your app.


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `pages/build-a-backend/add-aws-services/in-app-messaging/display-messages/index.mdx`