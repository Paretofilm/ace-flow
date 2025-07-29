---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib/logging/ios/flush_logs/flush_logs.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Documentation

Add import statement to the `AWSCloudWatchLoggingPlugin`
```swift
import AWSCloudWatchLoggingPlugin
```

Execute the flush log function from the plugin.

```swift
let cloudWatchPlugin = try Amplify.Logging.getPlugin(for: "awsCloudWatchLoggingPlugin") as? AWSCloudWatchLoggingPlugin 
try await cloudWatchPlugin?.flushLogs()
```


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/logging/ios/flush_logs/flush_logs.mdx`