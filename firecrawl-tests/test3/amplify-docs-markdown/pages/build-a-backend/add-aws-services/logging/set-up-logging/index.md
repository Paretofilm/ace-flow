---
title: Prerequisites
source: pages/build-a-backend/add-aws-services/logging/set-up-logging/index.mdx
---

# Prerequisites

The Amplify Logger enables you to troubleshoot and debug issues with your apps, to help you provide the best experience for your customers. You can log messages for errors by the Amplify library and add custom logs as well and send them to Amazon CloudWatch. With the Amplify Logger, you also can remotely change your logging configuration to adjust your logging levels, or add an allow list of customer IDs to help you detect issues more granularly for your apps in production.

## Prerequisites

* An Android application targeting Android SDK API level 24 (Android 7.0) or above with Amplify libraries integrated
    * For a full example, please follow the [quickstart](/android/start/quickstart/).
* The Amplify Logger is available for versions 2.11.0 and beyond of the Amplify Android SDK

### Install the Amplify library

Expand **Gradle Scripts**, open **build.gradle (Module: app)**. You will already have configured Amplify by following the steps in the [quickstart guide](/[platform]/start/quickstart/).

Add these libraries into the `dependencies` block:
```kotlin title="app/build.gradle.kts"  
android 
}

dependencies 
```

`aws-auth-cognito` is used to provide authentication for Amazon CloudWatch.

Click **Sync Now**.

</InlineFilter>

An application with Amplify libraries integrated and a minimum target of any of the following:
- **iOS 13.0**, using **Xcode 14.1** or later.
- **macOS 10.15**, using **Xcode 14.1** or later.
- **tvOS 13.0**, using **Xcode 14.3** or later.
- **watchOS 9.0**, using **Xcode 14.3** or later.
- **visionOS 1.0**, using **Xcode 15 beta 2** or later. (Preview support - see below for more details.)

For a full example, please follow the [mobile support walkthrough](/swift/start/quickstart/) .

> **Note**: 

visionOS support is currently in **preview** and can be used by using the latest [Amplify Release](https://github.com/aws-amplify/amplify-swift/releases). 
As new Xcode and visionOS versions are released, the support will be updated with any necessary fixes on a best effort basis.

</InlineFilter>

## Set up the backend

> **Note**: 

To add custom CDK resources, please follow the guide [here](/[platform]/build-a-backend/add-aws-services/custom-resources/).

You will need to create a log group in Amazon CloudWatch to send logs to. You can create and provision a log group by going through the AWS Console and creating your log group manually or using Amplify and AWS CDK to provision and deploy the AWS resources.

Below is a sample CDK construct to create the Amazon CloudWatch log group as well as creating and assigning the permission policies to Amplify roles.

The `<log-group-name>` and `<region>` configured in the CDK construct will be used later to initialize the Amplify Logger plugin.

### Replace the placeholder values with your own values:

- `<log-group-name>` is the log group that logs will be sent to. Note that this CDK construct sample includes logic to create the CloudWatch log group that you may have already created in previous steps.
- `<amplify-authenticated-role-name>` and `<amplify-unauthenticated-role-name>` are Amplify roles created as part of Amplify Auth configuration via Amplify CLI.

```ts

    const region = cdk.Stack.of(this).region
    const account = cdk.Stack.of(this).account
    const logGroupName = <log-group-name>
    const authRoleName = <amplify-authenticated-role-name>
    const unAuthRoleName = <amplify-unauthenticated-role-name>

    new logs.LogGroup(this, 'Log Group', )

    const authRole = iam.Role.fromRoleName(this, "Auth-Role", authRoleName)
    const unAuthRole = iam.Role.fromRoleName(this, "UnAuth-Role", unAuthRoleName)
    const logResource = `arn:aws:logs:$:$:log-group:$:log-stream:*`
    const logIAMPolicy = new iam.PolicyStatement()

    authRole.addToPrincipalPolicy(logIAMPolicy)
    unAuthRole.addToPrincipalPolicy(logIAMPolicy)

    new cdk.CfnOutput(this, 'CloudWatchLogGroupName', );
    new cdk.CfnOutput(this, 'CloudWatchRegion', );
  }
}
```

The `<log-group-name>` and `<region>` will be printed out in the in the terminal. You can use this information to setup the Amplify library in the next section.

## Initialize Amplify Logging

In this section, we will initialize and setup the Amplify library. The Logger can be configured via a configuration file or in code when your app is initializing.

    In your mobile app, create and add a `amplifyconfiguration_logging.json` to the same location as the `amplify_outputs.json` file.

The `<log-group-name>` and `<region>` is the value you specified in the CDK construct as part of provisioning your backend resources.  These values can also be found at the end of the output logs when deploying the sample CDK construct.  The configuration file is the data source for the logging plugin to know where, when and what logs to sends.  The example below configures the logging plugin to automatically send all logs at log level `ERROR` at 60 seconds interval and store logs locally up to 1MB.

```json

    }
}
```

To use the Amplify Logger and Amplify Auth categories in your app, you need to create and configure their corresponding plugins by calling the `Amplify.addPlugin()` and `Amplify.configure()` methods.

Add the following imports to the top of your main `Application` file:

> **Note**: 
Before calling the `Amplify.configure` function, make sure to either download the `amplify_outputs.json` file from the console, or generate it with the following command: 

```bash title="Terminal" showLineNumbers=
npx ampx generate outputs --app-id <app-id> --branch main --out-dir app/src/main/res/raw
```

Next, be sure the file you generated or downloaded is in the appropriate resource directory for your application (for example, `app/src/main/res/raw`) in your Android project. Otherwise, you will not be able to compile your application.

```java
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin;
import com.amplifyframework.core.Amplify;
import com.amplifyframework.core.configuration.AmplifyOutputs;
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
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin
import com.amplifyframework.core.Amplify
import com.amplifyframework.core.configuration.AmplifyOutputs
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
import com.amplifyframework.core.configuration.AmplifyOutputs;
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

  </Block>

To use the Amplify Logger and Amplify Auth categories in your app, you need to create and configure their corresponding plugins by calling the `Amplify.addPlugin()` and `Amplify.configure()` methods.

Add the following imports to the top of your main `Application` file:

```java
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin;
import com.amplifyframework.core.Amplify;
import com.amplifyframework.core.configuration.AmplifyOutputs;
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
import com.amplifyframework.core.configuration.AmplifyOutputs
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
import com.amplifyframework.core.configuration.AmplifyOutputs;
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

</Block>

</BlockSwitcher>

</InlineFilter>

In your mobile app, create and add a `amplifyconfiguration_logging.json` to the same location as the `amplify_outputs.json` file.  Ensure that the file is included in the `Copy Bundle Resources` build phase.

The `<log-group-name>` and `<region>` is the value you specified in the CDK construct as part of provisioning your backend resources.  These values can also be found at the end of the output logs when deploying the sample CDK construct.  The configuration file is the data source for the logging plugin to know where, when and what logs to sends.  The example below configures the logging plugin to automatically send all logs at log level `ERROR` at 60 seconds interval and store logs locally up to 1MB.

```json

    }
}
```

To use the Amplify Logger and Amplify Auth categories in your app, you need to create and configure their corresponding plugins by calling the `Amplify.add(plugin:)` and `Amplify.configure()` methods.

Add the following imports to the top of your main `App` file:

```swift
import Amplify
import AWSCognitoAuthPlugin
import AWSCloudWatchLoggingPlugin
```

Add the following code to its initializer. If there is none, you can create a default `init`. When Amplify initializes the logging plugin, it will automatically find and load the configuration in the `amplifyconfiguration_logging.json` that is bundled with your app.

```swift
init()  catch 
}
```

  </Block>

To use the Amplify Logger and Amplify Auth categories in your app, you need to create and configure their corresponding plugins by calling the `Amplify.add(plugin:)` and `Amplify.configure()` methods.

Add the following imports to the top of your main `App` file:

```swift
import Amplify
import AWSCognitoAuthPlugin
import AWSCloudWatchLoggingPlugin
```

Add the following code to its initializer. If there is none, you can create a default `init`.  The `<log-group-name>` and `<region>` are values you specified in the CDK construct as part of provisioning your backend resources.  These values can also be found at the end of the output logs when deploying the sample CDK construct.
The example below configures the logging plugin to automatically send all logs at log level `ERROR` at 60 seconds interval and store logs locally up to 1MB.

```swift
init()  catch 
}
```

</Block>

</BlockSwitcher>

</InlineFilter>
