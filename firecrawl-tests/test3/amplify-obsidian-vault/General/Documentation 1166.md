---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib/logging/android/setup_logging/20_initialize_with_config.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Documentation

In your mobile app, create and add a `amplifyconfiguration_logging.json` to the same location as the `amplifyconfiguration.json` file.

The `<log-group-name>` and `<region>` is the value you specified in the CDK construct as part of provisioning your backend resources.  These values can also be found at the end of the output logs when deploying the sample CDK construct.  The configuration file is the data source for the logging plugin to know where, when and what logs to sends.  The example below configures the logging plugin to automatically send all logs at log level `ERROR` at 60 seconds interval and store logs locally up to 1MB.

```json

    }
}
```

To use the Amplify Logger and Amplify Auth categories in your app, you need to create and configure their corresponding plugins by calling the `Amplify.addPlugin()` and `Amplify.configure()` methods.

Add the following imports to the top of your main `Application` file:

```java
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin;
import com.amplifyframework.core.Amplify;
import com.amplifyframework.logging.cloudwatch.AWSCloudWatchLoggingPlugin;
```

```java
Amplify.addPlugin(new AWSCognitoAuthPlugin());
Amplify.addPlugin(new AWSCloudWatchLoggingPlugin());
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

Add the following code to your onCreate() method in your application class. When Amplify initializes the logging plugin, it will automatically find and load the configuration in the `amplifyconfiguration_logging.json` that is bundled with your app.

```kotlin
Amplify.addPlugin(AWSCognitoAuthPlugin())
Amplify.addPlugin(AWSCloudWatchLoggingPlugin())
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
RxAmplify.addPlugin(new AWSCloudWatchLoggingPlugin());
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
Original: `fragments/lib/logging/android/setup_logging/20_initialize_with_config.mdx`