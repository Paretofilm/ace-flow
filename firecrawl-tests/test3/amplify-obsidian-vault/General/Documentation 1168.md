---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib/logging/android/change_log_levels/10_default_log_level.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Documentation

Provide a default log level at initialization and configuration of the AWSCloudWatchLoggingPlugin.

```java
LoggingConstraints loggingConstraints = new LoggingConstraints(LogLevel.WARN);
AWSCloudWatchLoggingPluginConfiguration config = new AWSCloudWatchLoggingPluginConfiguration (<log-group-name>, <region>, loggingConstraints);
Amplify.addPlugin(new AWSCloudWatchLoggingPlugin(config));
```

</Block>

```kotlin
val loggingConstraints = LoggingConstraints(defaultLogLevel = LogLevel.WARN)
val config = AWSCloudWatchLoggingPluginConfiguration(logGroupName = <log-group-name>, region = <region>, loggingConstraints = loggingConstraints)
Amplify.addPlugin(AWSCloudWatchLoggingPlugin(config))
```
</Block>

```java
LoggingConstraints loggingConstraints = new LoggingConstraints(LogLevel.WARN);
AWSCloudWatchLoggingPluginConfiguration config = new AWSCloudWatchLoggingPluginConfiguration (<log-group-name>,<region>, loggingConstraints);
Amplify.addPlugin(new AWSCloudWatchLoggingPlugin(config));
```

</Block>
</BlockSwitcher>

The following are supported log levels:
```java
LogLevel.ERROR
LogLevel.WARN
LogLevel.INFO
LogLevel.DEBUG
LogLevel.VERBOSE
LogLevel.NONE
```
Setting the log level to LogLevel.NONE effectively disables logging.


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/logging/android/change_log_levels/10_default_log_level.mdx`