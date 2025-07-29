---
title: Documentation
source: fragments/lib/logging/android/flush_logs/flush_logs.mdx
---

# Documentation

Add import statement to the `AWSCloudWatchLoggingPlugin`
```java
import com.amplifyframework.logging.cloudwatch.AWSCloudWatchLoggingPlugin;
```

Execute the flush log function from the plugin.

```java
AWSCloudWatchLoggingPlugin plugin = (AWSCloudWatchLoggingPlugin)Amplify.Logging.getPlugin("awsCloudWatchLoggingPlugin");
plugin.flushLogs(
    () -> , error -> 
);
```
</Block>

Add import statement to the `AWSCloudWatchLoggingPlugin`
```kotlin
import com.amplifyframework.logging.cloudwatch.AWSCloudWatchLoggingPlugin
```

Execute the flush log function from the plugin.

```kotlin
val plugin = Amplify.Logging.getPlugin("awsCloudWatchLoggingPlugin") as? AWSCloudWatchLoggingPlugin
plugin?.flushLogs(
    ,
);
```

</Block>

Add import statement to the `AWSCloudWatchLoggingPlugin`
```java
import com.amplifyframework.logging.cloudwatch.AWSCloudWatchLoggingPlugin;
```

Execute the flush log function from the plugin.

```java
AWSCloudWatchLoggingPlugin plugin = (AWSCloudWatchLoggingPlugin)Amplify.Logging.getPlugin("awsCloudWatchLoggingPlugin");
plugin.flushLogs(
    () -> , error -> 
);
```

</Block>
</BlockSwitcher>
