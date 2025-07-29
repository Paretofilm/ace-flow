---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib/logging/common/hub_events/hub_events.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Documentation

The Amplify Logger sends errors that occur when using it through Amplify Hub. To ensure that errors do not occur when logging, log messages should be validated and follow the best security practices. Additionally, you should ensure that log messages do not exceed the [Amazon CloudWatch log event size of 256 KB](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutLogEvents.html).

You can get logging error events by listening/subscribing to the logging events from the Amplify Hub.


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/logging/common/hub_events/hub_events.mdx`