---
title: Documentation
source: fragments/lib/logging/android/configure_user/configure_user.mdx
---

# Documentation

Provide a map of `UserLogLevel` at initialization and configuration of the `AWSCloudWatchLoggingPlugin`.

```java
Map categoryOverrides = new HashMap<>();
categoryOverrides.put(CategoryType.AUTH, LogLevel.VERBOSE);
categoryOverrides.put(CategoryType.STORAGE, LogLevel.DEBUG);

UserLogLevel userLogLevel = new UserLogLevel(LogLevel.WARN, categoryOverrides);

Map userOverrides = new HashMap<>();
userOverrides.put("USER_ID", userLogLevel);

LoggingConstraints loggingConstraints = new LoggingConstraints(LogLevel.WARN, categoryOverrides, userOverrides);

AWSCloudWatchLoggingPluginConfiguration config = new AWSCloudWatchLoggingPluginConfiguration (<log-group-name>, <region>, loggingConstraints);
Amplify.addPlugin(new AWSCloudWatchLoggingPlugin(config));
```

</Block>

```kotlin
val categoryOverrides = mapOf(CategoryType.AUTH to LogLevel.VERBOSE, CategoryType.STORAGE to LogLevel.DEBUG)
val userOverrides = mapOf("USER_ID" to UserLogLevel(LogLevel.WARN, categoryOverrides))

val loggingConstraints = LoggingConstraints(defaultLogLevel = LogLevel.WARN, userLogLevel = userOverrides)

val config = AWSCloudWatchLoggingPluginConfiguration(logGroupName = <log-group-name>, region = <region>, loggingConstraints = loggingConstraints)
Amplify.addPlugin(AWSCloudWatchLoggingPlugin(config))
```
</Block>

```java
Map categoryOverrides = new HashMap<>();
categoryOverrides.put(CategoryType.AUTH, LogLevel.VERBOSE);
categoryOverrides.put(CategoryType.STORAGE, LogLevel.DEBUG);

UserLogLevel userLogLevel = new UserLogLevel(LogLevel.WARN, categoryOverrides);

Map userOverrides = new HashMap<>();
userOverrides.put("USER_ID", userLogLevel);

LoggingConstraints loggingConstraints = new LoggingConstraints(LogLevel.WARN, categoryOverrides, userOverrides);

AWSCloudWatchLoggingPluginConfiguration config = new AWSCloudWatchLoggingPluginConfiguration (<log-group-name>, <region>, loggingConstraints);
Amplify.addPlugin(new AWSCloudWatchLoggingPlugin(config));
```

</Block>
</BlockSwitcher>
