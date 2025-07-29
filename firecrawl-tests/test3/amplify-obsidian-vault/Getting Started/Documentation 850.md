---
title: Documentation
topics: ['Getting Started']
primary_topic: Getting Started
source: fragments/lib/utilities/ios/hub/10_listen_start.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, getting-started]
---


## 🧭 Navigation
**Topics**: [[Getting Started/]]
**Primary**: [[Getting Started/]]

---


# Documentation

You can use `Amplify.Hub.listen(to: HubChannel) ` (listener) or `Amplify.Hub.publisher(for: HubChannel).sink ` (Combine) to listen for messages that have been dispatched. Additionally, you can pass `isIncluded: HubFilter` or `eventName: HubPayloadEventName` to the `listen` method to further filter Hub events. You can add multiple listeners to your application for different combinations of channels, filters, and events.


---

## 📚 Related Topics
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/utilities/ios/hub/10_listen_start.mdx`