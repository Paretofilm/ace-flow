---
title: Documentation
source: fragments/lib/logging/android/remote_configuration/10_remote_config_provider.mdx
---

# Documentation

```java
LoggingConstraints loggingConstraints = new LoggingConstraints(LogLevel.WARN);
RemoteLoggingConstraintProvider remoteLoggingConstraintProvider = new DefaultRemoteLoggingConstraintProvider(<endpoint-url>, <region>)
AWSCloudWatchLoggingPluginConfiguration config = new AWSCloudWatchLoggingPluginConfiguration (<log-group-name>, <region>, loggingConstraints);
Amplify.addPlugin(new AWSCloudWatchLoggingPlugin(config, remoteLoggingConstraintProvider));
```

</Block>

```kotlin
val loggingConstraints = LoggingConstraints(defaultLogLevel = LogLevel.WARN)
val remoteLoggingConstraintProvider = DefaultRemoteLoggingConstraintProvider(<endpoint-url>, <region>)
val config = AWSCloudWatchLoggingPluginConfiguration(logGroupName = <log-group-name>, region = <region>, loggingConstraints = loggingConstraints)
Amplify.addPlugin(AWSCloudWatchLoggingPlugin(config, remoteLoggingConstraintProvider))
```
</Block>

```java
LoggingConstraints loggingConstraints = new LoggingConstraints(LogLevel.WARN);
RemoteLoggingConstraintProvider remoteLoggingConstraintProvider = new DefaultRemoteLoggingConstraintProvider(<endpoint-url>, <region>)
AWSCloudWatchLoggingPluginConfiguration config = new AWSCloudWatchLoggingPluginConfiguration (<log-group-name>,<region>, loggingConstraints);
Amplify.addPlugin(new AWSCloudWatchLoggingPlugin(config, remoteLoggingConstraintProvider));
```

</Block>
</BlockSwitcher>
