---
title: Documentation
topics: ['Analytics']
primary_topic: Analytics
source: fragments/lib/analytics/ios/record-event-code.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, analytics]
---


## 🧭 Navigation
**Topics**: [[Analytics/]]
**Primary**: [[Analytics/]]

---


# Documentation

```swift
let properties: AnalyticsProperties = [
    "eventPropertyStringKey": "eventPropertyStringValue",
    "eventPropertyIntKey": 123,
    "eventPropertyDoubleKey": 12.34,
    "eventPropertyBoolKey": true
]

let event = BasicAnalyticsEvent(
    name: "eventName",
    properties: properties
)

Amplify.Analytics.record(event: event)
```


---

## 📚 Related Topics
- [[Analytics/]]

## 📖 Source
Original: `fragments/lib/analytics/ios/record-event-code.mdx`