---
title: Documentation
topics: ['Analytics']
primary_topic: Analytics
source: fragments/lib/analytics/ios/escapehatch.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, analytics]
---


## 🧭 Navigation
**Topics**: [[Analytics/]]
**Primary**: [[Analytics/]]

---


# Documentation

For advanced use cases where Amplify does not provide the functionality, you can retrieve the escape hatch to access the underlying Amazon Pinpoint client.

Add the following import:

```swift
import AWSPinpointAnalyticsPlugin
```

Then retrieve the escape hatch with this code:

```swift
do 

    // Retrieve the reference to PinpointClientProtocol
    let pinpointClient = analyticsPlugin.getEscapeHatch()

    // Make requests using pinpointClient...
    // ...
} catch 
```


---

## 📚 Related Topics
- [[Analytics/]]

## 📖 Source
Original: `fragments/lib/analytics/ios/escapehatch.mdx`