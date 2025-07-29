---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib/utilities/ios/hub/20_listen_stop.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Documentation

Hub provides a way to stop listening for messages. This is useful if you no longer need to receive messages in your application flow.

```swift
// Assumes `unsubscribeToken` references the token
// returned by Amplify.Hub.listen(...)
Amplify.Hub.removeListener(unsubscribeToken)
```

</Block>

```swift
// Assumes `sink` references the sink
// returned by Amplify.Hub.publisher(...).sink
sink.cancel()
```

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/utilities/ios/hub/20_listen_stop.mdx`