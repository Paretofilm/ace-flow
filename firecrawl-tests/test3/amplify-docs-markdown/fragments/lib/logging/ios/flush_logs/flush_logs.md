---
title: Documentation
source: fragments/lib/logging/ios/flush_logs/flush_logs.mdx
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
