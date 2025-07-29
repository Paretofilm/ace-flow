---
title: Documentation
topics: ['Analytics']
primary_topic: Analytics
source: fragments/lib-v1/analytics/ios/escapehatch.mdx
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

Add the following imports:

```swift
import AWSPinpointAnalyticsPlugin // Imports the Amplify plugin interface
import AWSPinpoint                // Imports the AWSPinpoint client escape hatch
```

</Block>

```swift
import AmplifyPlugins // Imports the Amplify plugin interface
import AWSPinpoint    // Imports the AWSPinpoint client escape hatch
```

</Block>

</BlockSwitcher>

Then retrieve the escape hatch with this code:

```swift
func getEscapeHatch()  catch 
}
```


---

## 📚 Related Topics
- [[Analytics/]]

## 📖 Source
Original: `fragments/lib-v1/analytics/ios/escapehatch.mdx`