---
title: Documentation
source: fragments/lib/logging/android/change_local_storage/10_local_storage_size.mdx
---

# Documentation

```java
AWSCloudWatchLoggingPluginConfiguration config = new AWSCloudWatchLoggingPluginConfiguration (<log-group-name>, <region>, true, 2);
Amplify.addPlugin(new AWSCloudWatchLoggingPlugin(config));
```

</Block>

```kotlin
val config = AWSCloudWatchLoggingPluginConfiguration(logGroupName = <log-group-name>, region = <region>, localStoreMaxSizeInMB = 2)
Amplify.addPlugin(AWSCloudWatchLoggingPlugin(config))
```
</Block>

```java
AWSCloudWatchLoggingPluginConfiguration config = new AWSCloudWatchLoggingPluginConfiguration (<log-group-name>, <region>, true, 2);
Amplify.addPlugin(new AWSCloudWatchLoggingPlugin(config));
```

</Block>
</BlockSwitcher>
