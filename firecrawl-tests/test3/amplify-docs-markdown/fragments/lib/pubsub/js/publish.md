---
title: Documentation
source: fragments/lib/pubsub/js/publish.mdx
---

# Documentation

To send a message to a topic, use `publish()` method with your topic name and the message:
```javascript
await pubsub.publish( });
```

If multiple providers are defined in your app you can pass the message to a specific provider:
```javascript
await pubsub.publish(,
  options: 
});
```

You can also publish a message to multiple topics:
```javascript
await pubsub.publish( });
```
