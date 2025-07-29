---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib-v1/pubsub/js/publish.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Documentation

To send a message to a topic, use `publish()` method with your topic name and the message:
```javascript
await PubSub.publish('myTopic1', );
```

If multiple providers are defined in your app you can pass the message to a specific provider:
```javascript
await PubSub.publish('myTopic1', , );
```

You can also publish a message to multiple topics:
```javascript
await PubSub.publish(['myTopic1','myTopic2'], );
```

> **Note**: 

**Note:** If you do not include a specific provider it will publish a message to all of the configured PubSub providers in your app.


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib-v1/pubsub/js/publish.mdx`