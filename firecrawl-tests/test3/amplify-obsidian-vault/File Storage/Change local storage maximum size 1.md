---
title: Change local storage maximum size
topics: ['File Storage']
primary_topic: File Storage
source: pages/build-a-backend/add-aws-services/logging/change-local-storage/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Change local storage maximum size

When using the Amplify Logger, all logged messages are saved locally on the user's device first before sending them to CloudWatch.

In this section, you will learn about how to configure the maximum amount of local logs are stored. This can be helpful to determine how much logs are stored locally depending on your network availability and offline use cases.

## Change local storage maximum size

Below is an example of setting the local storage size to 2 MB:

Update the `localStoreMaxSizeInMB` field in the configuration file.

```json

    }
}
```
  </Block>

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

</InlineFilter>

Provide a `localStoreMaxSizeInMB` parameter initialization and configuration of the `AWSCloudWatchLoggingPlugin`.

```swift
do  catch 
```
</InlineFilter>

  </Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `pages/build-a-backend/add-aws-services/logging/change-local-storage/index.mdx`