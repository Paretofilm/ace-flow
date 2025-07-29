---
title: Change Default Log Level
topics: ['General']
primary_topic: General
source: pages/build-a-backend/add-aws-services/logging/change-log-levels/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Change Default Log Level

In this section, you will learn about how to configure the logging level in your application when using the Amplify logger. This is helpful to help you determine the logging level that works best for your use cases, and which levels of errors or warnings you want to capture in Amazon Cloudwatch.

## Change Default Log Level

Below is an example of setting the default log level to `WARN`:

Update the `defaultLogLevel` field under `loggingConstraints`.

```json

    }
}
```

The following are supported log levels:
* `ERROR`
* `WARN`
* `INFO`
* `DEBUG`
* `VERBOSE`
* `NONE`

Setting the log level to `NONE` effectively disables logging.
  </Block>
  
Provide a default log level at initialization and configuration of the AWSCloudWatchLoggingPlugin.

```java
LoggingConstraints loggingConstraints = new LoggingConstraints(LogLevel.WARN);
AWSCloudWatchLoggingPluginConfiguration config = new AWSCloudWatchLoggingPluginConfiguration (<log-group-name>, <region>, loggingConstraints);
Amplify.addPlugin(new AWSCloudWatchLoggingPlugin(config));
```

</Block>

```kotlin
val loggingConstraints = LoggingConstraints(defaultLogLevel = LogLevel.WARN)
val config = AWSCloudWatchLoggingPluginConfiguration(logGroupName = <log-group-name>, region = <region>, loggingConstraints = loggingConstraints)
Amplify.addPlugin(AWSCloudWatchLoggingPlugin(config))
```
</Block>

```java
LoggingConstraints loggingConstraints = new LoggingConstraints(LogLevel.WARN);
AWSCloudWatchLoggingPluginConfiguration config = new AWSCloudWatchLoggingPluginConfiguration (<log-group-name>,<region>, loggingConstraints);
Amplify.addPlugin(new AWSCloudWatchLoggingPlugin(config));
```

</Block>
</BlockSwitcher>

The following are supported log levels:
```java
LogLevel.ERROR
LogLevel.WARN
LogLevel.INFO
LogLevel.DEBUG
LogLevel.VERBOSE
LogLevel.NONE
```
Setting the log level to LogLevel.NONE effectively disables logging.

  </Block>
</BlockSwitcher>

</InlineFilter>

Update the `defaultLogLevel` field under `loggingConstraints`.

```json

    }
}
```

The following are supported log levels:
* `ERROR`
* `WARN`
* `INFO`
* `DEBUG`
* `VERBOSE`
* `NONE`

Setting the log level to `NONE` effectively disables logging.
  </Block>
  
Provide a default log level at initialization and configuration of the `AWSCloudWatchLoggingPlugin`.

```swift
do  catch 
```

The following are supported log levels:
```swift
LogLevel.error
LogLevel.warn
LogLevel.info
LogLevel.debug
LogLevel.verbose
LogLevel.none
```

Setting the log level to `LogLevel.none` effectively disables logging.
  </Block>
</BlockSwitcher>

</InlineFilter>

## Configure Log Level by Category

Each Amplify category can be configured to have its own logging level.

Below is an example of setting different logging levels for the Storage and Auth categories.

Add a `categoryLogLevel` section and specify each category and its log level.

```json

        }
    }
}
```

To disable logging for a specific category, set the log level to `NONE`.

  </Block>

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

  </InlineFilter>

  Provide a dictionary of category and corresponding log levels at initialization and configuration of the `AWSCloudWatchLoggingPlugin`.

```swift
do  catch 
```

To disable logging for a specific category, set the log level to `LogLevel.none`.
  </InlineFilter>

  </Block>
</BlockSwitcher>

The following are existing Amplify category names that are used by default by Amplify when automatically logging errors from the library.
* `ANALYTICS`
* `API`
* `AUTH`
* `DATASTORE`
* `HUB`
* `LOGGING`
* `NOTIFICATIONS`
* `PREDICTIONS`
* `STORAGE`
* `GEO`

</InlineFilter>

The following are existing Amplify category names that are used by default by Amplify when automatically logging errors from the library.
* `Analytics`
* `API`
* `Authentication`
* `DataStore`
* `Geo`
* `Hub`
* `Logging`
* `Predictions`
* `PushNotifications`
* `Storage`

</InlineFilter>


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `pages/build-a-backend/add-aws-services/logging/change-log-levels/index.mdx`