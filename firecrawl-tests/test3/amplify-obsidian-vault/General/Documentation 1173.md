---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib/logging/android/escapehatch/escapehatch.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

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


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/logging/android/escapehatch/escapehatch.mdx`