---
title: Documentation
source: fragments/lib/logging/android/escapehatch/escapehatch.mdx
---

# Documentation

The escape hatch provides access to the underlying `CloudWatchLogsClient` instance. Then retrieve the escape hatch with this code:

**Gradle Imports**

```groovy
implementation "aws.sdk.kotlin:cloudwatchlogs:KOTLIN_SDK_VERSION"
```

```java
AWSCloudWatchLoggingPlugin plugin = (AWSCloudWatchLoggingPlugin)Amplify.Logging.getPlugin("awsCloudWatchLoggingPlugin");
CloudWatchLogsClient client = plugin.getEscapeHatch();
```

</Block>

```kotlin
val plugin = Amplify.Logging.getPlugin("awsCloudWatchLoggingPlugin") as AWSCloudWatchLoggingPlugin
val client = plugin.escapeHatch
```

</Block>

```java
AWSCloudWatchLoggingPlugin plugin = (AWSCloudWatchLoggingPlugin)Amplify.Logging.getPlugin("awsCloudWatchLoggingPlugin");
CloudWatchLogsClient client = plugin.getEscapeHatch();
```

</Block>
</BlockSwitcher>
