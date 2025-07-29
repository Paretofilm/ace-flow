---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib/logging/android/change_log_levels/20_category_log_level.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Documentation

Provide a map of category and corresponding log levels at initialization and configuration of the `AWSCloudWatchLoggingPlugin`.

```java
Map categoryOverrides = new HashMap<>();
categoryOverrides.put(CategoryType.AUTH, LogLevel.VERBOSE);
categoryOverrides.put(CategoryType.STORAGE, LogLevel.DEBUG);
LoggingConstraints loggingConstraints = new LoggingConstraints(LogLevel.WARN, categoryOverrides);
AWSCloudWatchLoggingPluginConfiguration config = new AWSCloudWatchLoggingPluginConfiguration (<log-group-name>, <region>, loggingConstraints);
Amplify.addPlugin(new AWSCloudWatchLoggingPlugin(config));
```

</Block>

```kotlin
val categoryOverrides = mapOf(CategoryType.AUTH to LogLevel.VERBOSE, CategoryType.STORAGE to LogLevel.DEBUG)
val loggingConstraints = LoggingConstraints(defaultLogLevel = LogLevel.WARN, categoryLogLevel = categoryOverrides)
val config = AWSCloudWatchLoggingPluginConfiguration(logGroupName = <log-group-name>, region = <region>, loggingConstraints = loggingConstraints)
Amplify.addPlugin(AWSCloudWatchLoggingPlugin(config))
```
</Block>

```java
Map categoryOverrides = new HashMap<>();
categoryOverrides.put(CategoryType.AUTH, LogLevel.VERBOSE);
categoryOverrides.put(CategoryType.STORAGE, LogLevel.DEBUG);
LoggingConstraints loggingConstraints = new LoggingConstraints(LogLevel.WARN, categoryOverrides);
AWSCloudWatchLoggingPluginConfiguration config = new AWSCloudWatchLoggingPluginConfiguration (<log-group-name>,<region>, loggingConstraints);
Amplify.addPlugin(new AWSCloudWatchLoggingPlugin(config));
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/logging/android/change_log_levels/20_category_log_level.mdx`