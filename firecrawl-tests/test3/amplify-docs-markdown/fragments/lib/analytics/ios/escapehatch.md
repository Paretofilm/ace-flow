---
title: Documentation
source: fragments/lib/analytics/ios/escapehatch.mdx
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
