---
title: Change automatic log flush interval
topics: ['General']
primary_topic: General
source: pages/build-a-backend/add-aws-services/logging/flush-logs/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Change automatic log flush interval

When using the Amplify Logger, all logged messages are saved locally on the user's device first and then flushed at a set interval that you can [customize](#change-automatic-log-flush-interval). You can also choose to flush events manually if needed by following the steps outlined in this section.

## Change automatic log flush interval

You can customize the time interval for when logs are automatically flushed and sent to CloudWatch.

Below is an example of setting the time interval to 120 seconds:

Update the `flushIntervalInSeconds` field in the logging configuration file.

```json

    }
}
```

  </Block>
  
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

  </Block>
</BlockSwitcher>

</InlineFilter>

Update the `flushIntervalInSeconds` field in the logging configuration file.

```json

    }
}
```

  </Block>
  
Provide a `flushIntervalInSeconds` parameter initialization and configuration of the `AWSCloudWatchLoggingPlugin`.

```swift
do  catch 
```

  </Block>
</BlockSwitcher>

</InlineFilter>

## Manually flush logs

You can choose at anytime to flush the log messages that are saved locally on the user's device, to then send them immediately to Amazon CloudWatch.

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

</InlineFilter>

Add import statement to the `AWSCloudWatchLoggingPlugin`
```swift
import AWSCloudWatchLoggingPlugin
```

Execute the flush log function from the plugin.

```swift
let cloudWatchPlugin = try Amplify.Logging.getPlugin(for: "awsCloudWatchLoggingPlugin") as? AWSCloudWatchLoggingPlugin
try await cloudWatchPlugin?.flushLogs()
```

</InlineFilter>


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `pages/build-a-backend/add-aws-services/logging/flush-logs/index.mdx`