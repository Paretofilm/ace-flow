---
title: Documentation
source: fragments/lib/logging/ios/change_log_levels/10_default_log_level.mdx
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
