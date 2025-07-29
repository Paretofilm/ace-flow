---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib/logging/ios/escapehatch/escapehatch.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Documentation

Add import statements

```swift
import AWSCloudWatchLoggingPlugin
import AWSCloudWatchLogs
```

Get a direct reference to the instance of CloudWatchLogsClientProtocol and directly interact with AWSCloudWatch via the [AWS SDK for Swift](https://docs.aws.amazon.com/sdk-for-swift/index.html)

```swift
let cloudWatchPlugin = try Amplify.Logging.getPlugin(for: "awsCloudWatchLoggingPlugin") as? AWSCloudWatchLoggingPlugin
let cloudWatchClient: CloudWatchLogsClientProtocol? = cloudWatchPlugin?.getEscapeHatch()
```


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/logging/ios/escapehatch/escapehatch.mdx`