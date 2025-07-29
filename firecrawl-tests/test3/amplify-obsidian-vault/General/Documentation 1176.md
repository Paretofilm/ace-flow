---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib/logging/android/flush_logs/flush_interval.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Documentation

Provide a `flushIntervalInSeconds` parameter initialization and configuration of the `AWSCloudWatchLoggingPlugin`.

```java
AWSCloudWatchLoggingPluginConfiguration config = new AWSCloudWatchLoggingPluginConfiguration (<log-group-name>, <region>, 120);
Amplify.addPlugin(new AWSCloudWatchLoggingPlugin(config));
```

</Block>

```kotlin
val config = AWSCloudWatchLoggingPluginConfiguration(logGroupName = <log-group-name>, region = <region>, flushIntervalInSeconds = 120)
Amplify.addPlugin(AWSCloudWatchLoggingPlugin(config))
```
</Block>

```java
AWSCloudWatchLoggingPluginConfiguration config = new AWSCloudWatchLoggingPluginConfiguration (<log-group-name>,<region>, 120);
Amplify.addPlugin(new AWSCloudWatchLoggingPlugin(config));
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/logging/android/flush_logs/flush_interval.mdx`