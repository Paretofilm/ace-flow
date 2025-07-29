---
title: Documentation
source: fragments/lib/logging/android/flush_logs/flush_interval.mdx
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
