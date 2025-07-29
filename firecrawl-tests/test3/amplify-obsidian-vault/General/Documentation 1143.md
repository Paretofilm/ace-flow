---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib/logging/ios/change_log_levels/10_default_log_level.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Documentation

Provide a default log level at initialization and configuration of the `AWSCloudWatchLoggingPlugin`.

```swift
do  catch 
```

The following are supported log levels:
```swift
LogLevel.error
LogLevel.warn
LogLevel.info
LogLevel.debug
LogLevel.verbose
LogLevel.none
```

Setting the log level to `LogLevel.none` effectively disables logging.


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/logging/ios/change_log_levels/10_default_log_level.mdx`