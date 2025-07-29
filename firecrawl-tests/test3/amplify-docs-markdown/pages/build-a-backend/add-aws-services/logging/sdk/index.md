---
title: Use AWS SDK for logging
source: pages/build-a-backend/add-aws-services/logging/sdk/index.mdx
---

# Use AWS SDK for logging

For advanced use cases where Amplify does not provide the functionality, you can retrieve the escape hatch to access the underlying Amazon CloudWatch client.

The escape hatch provides access to the underlying `CloudWatchLogsClient` instance. Then retrieve the escape hatch with this code:

**Gradle Imports**

```kotlin title="app/build.gradle.kts" 
implementation("aws.sdk.kotlin:cloudwatchlogs:KOTLIN_SDK_VERSION")
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

</InlineFilter>

Add import statements

```swift
import AWSCloudWatchLoggingPlugin
import AWSCloudWatchLogs
```

Get a direct reference to the instance of CloudWatchLogsClientProtocol and directly interact with AWSCloudWatch via the [AWS SDK for Swift](https://docs.aws.amazon.com/sdk-for-swift/index.html)

```swift
let cloudWatchPlugin = try Amplify.Logging.getPlugin(for: "awsCloudWatchLoggingPlugin") as? AWSCloudWatchLoggingPlugin
let cloudWatchClient: CloudWatchLogsClientProtocol? = cloudWatchPlugin?.getEscapeHatch()
```

</InlineFilter>
