---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib/logging/android/setup_logging/30_initialize_without_config.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Documentation

To use the Amplify Logger and Amplify Auth categories in your app, you need to create and configure their corresponding plugins by calling the `Amplify.addPlugin()` and `Amplify.configure()` methods.

Add the following imports to the top of your main `Application` file:

```java
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin;
import com.amplifyframework.core.Amplify;
import com.amplifyframework.logging.cloudwatch.AWSCloudWatchLoggingPlugin;
```
Add the following code to its initializer. If there is none, you can create a default.  The `<log-group-name>` and `<region>` are values you specified in the CDK construct as part of provisioning your backend resources.  These values can also be found at the end of the output logs when deploying the sample CDK construct.
The example below configures the logging plugin to automatically send all logs at log level `ERROR` at 60 seconds interval and store logs locally up to 1MB.
```java
Amplify.addPlugin(new AWSCognitoAuthPlugin());
AWSCloudWatchLoggingPluginConfiguration config = new AWSCloudWatchLoggingPluginConfiguration (<log-group-name>,<region>,1, 60);
Amplify.addPlugin(new AWSCloudWatchLoggingPlugin(config));
```

Your class will look like this:

```java
public class MyAmplifyApp extends Application  catch (AmplifyException error) 
    }
}
```

</Block>

```kotlin
import com.amplifyframework.core.Amplify
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin
import com.amplifyframework.logging.cloudwatch.AWSCloudWatchLoggingPlugin
```

Add the following code to your onCreate() method in your application class.

```kotlin
Amplify.addPlugin(AWSCognitoAuthPlugin())
val config = AWSCloudWatchLoggingPluginConfiguration(logGroupName = <log-group-name>, region = <region>, localStoreMaxSizeInMB = 1, flushIntervalInSeconds = 60)
Amplify.addPlugin(AWSCloudWatchLoggingPlugin(config))
```

Your class will look like this:

```kotlin
class MyAmplifyApp : Application()  catch (error: AmplifyException) 
    }
}
```

</Block>

```java
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin;
import com.amplifyframework.rx.RxAmplify;
import com.amplifyframework.logging.cloudwatch.AWSCloudWatchLoggingPlugin;
```

```java
RxAmplify.addPlugin(new AWSCognitoAuthPlugin());
AWSCloudWatchLoggingPluginConfiguration config = new AWSCloudWatchLoggingPluginConfiguration (<log-group-name>,<region>, 1,60);
RxAmplify.addPlugin(new AWSCloudWatchLoggingPlugin(config));
```

Your class will look like this:

```java
public class MyAmplifyApp extends Application  catch (AmplifyException error) 
    }
}
```
</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/logging/android/setup_logging/30_initialize_without_config.mdx`