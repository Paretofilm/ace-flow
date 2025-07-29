---
title: Prerequisites
topics: ['Analytics']
primary_topic: Analytics
source: pages/build-a-backend/add-aws-services/analytics/set-up-analytics/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, analytics]
---


## 🧭 Navigation
**Topics**: [[Analytics/]]
**Primary**: [[Analytics/]]

---


# Prerequisites

Amplify enables you to collect analytics data for your app. In order to use Analytics, you will enable [Amazon Kinesis](https://aws.amazon.com/kinesis/) or [Amazon Pinpoint](https://aws.amazon.com/pinpoint/) using the AWS Cloud Development Kit (AWS CDK). The Analytics category uses [Amazon Cognito identity pools](https://docs.aws.amazon.com/cognito/latest/developerguide/identity-pools.html) to _identify_ users in your app. Cognito allows you to receive data from authenticated, and unauthenticated users in your app.

## Prerequisites

An application with Amplify libraries integrated and a minimum target of any of the following:
- **iOS 13.0**, using **Xcode 14.1** or later.
- **macOS 10.15**, using **Xcode 14.1** or later.
- **tvOS 13.0**, using **Xcode 14.3** or later.
- **watchOS 9.0**, using **Xcode 14.3** or later.
- **visionOS 1.0**, using **Xcode 15** or later. (Preview support - see below for more details.)

> **Note**: 

visionOS support is currently in **preview** and can be used by using the latest [Amplify Release](https://github.com/aws-amplify/amplify-swift/releases). 
As new Xcode and visionOS versions are released, the support will be updated with any necessary fixes on a best effort basis.

</InlineFilter>

## Prerequisites

* An Android application targeting Android API level 24 (Android 7.0) or above

</InlineFilter>

Amplify Flutter requires a minimum target platform for iOS (13.0), Android (API level 24), and macOS (10.15). Refer to [Flutter's supported deployment platforms](https://docs.flutter.dev/reference/supported-platforms) when targeting Web, Windows, or Linux.

</InlineFilter>
## Set up Analytics backend

Use the [AWS CDK](https://docs.aws.amazon.com/cdk/latest/guide/home.html) to create an analytics resource powered by [Amazon Pinpoint](https://aws.amazon.com/pinpoint/).

```ts title="amplify/backend.ts"

const backend = defineBackend();

const analyticsStack = backend.createStack("analytics-stack");

// create a Pinpoint app
const pinpoint = new CfnApp(analyticsStack, "Pinpoint", );

// create an IAM policy to allow interacting with Pinpoint
const pinpointPolicy = new Policy(analyticsStack, "PinpointPolicy", ),
  ],
});

// apply the policy to the authenticated and unauthenticated roles
backend.auth.resources.authenticatedUserIamRole.attachInlinePolicy(pinpointPolicy);
backend.auth.resources.unauthenticatedUserIamRole.attachInlinePolicy(pinpointPolicy);

// patch the custom Pinpoint resource to the expected output configuration
backend.addOutput(
  },
});
```

## Install Amplify Libraries

First, install the `aws-amplify` library:

```sh title="Terminal" showLineNumbers=
npm add aws-amplify
```
</InlineFilter>

1. To install the Amplify Libraries in your application, open your project in Xcode and select **File > Add Packages...**.

2. Enter the **Amplify Library for Swift** GitHub repo URL (`https://github.com/aws-amplify/amplify-swift`) into the search bar and click **Add Package**.

  > **Note**: 

  **Note:** **Up to Next Major Version** should be selected from the **Dependency Rule** dropdown.

3. Lastly, add **AWSPinpointAnalyticsPlugin**, **AWSCognitoAuthPlugin**, and **Amplify** to your target. Then click **Add Package**.

</InlineFilter>

Expand **Gradle Scripts**, open **build.gradle.kts (Module :app)**. You will already have configured Amplify by following the steps in the quickstart guide.

Add Analytics by adding these libraries into the dependencies block:
```kotlin title="app/build.gradle.kts"
android 
}

dependencies 
```

Click **Sync Now**.
</InlineFilter>

In your Flutter project directory, open **pubspec.yaml**.
Add Analytics by adding these libraries into your dependencies block:

```yaml
dependencies:
  amplify_analytics_pinpoint: ^2.0.0
  amplify_auth_cognito: ^2.0.0
  amplify_flutter: ^2.0.0
```
</InlineFilter>

## Initialize Amplify Analytics

Import and load the configuration file in your app. It's recommended you add the Amplify configuration step to your app's root entry point.

```js title="src/index.js"

Amplify.configure(outputs);
```
</InlineFilter>

```js title="pages/_app.tsx"

Amplify.configure(outputs);
```
</InlineFilter>

> **Note**: 
Make sure to generate the `amplify_outputs.json` file by running the following command: 

```bash title="Terminal" showLineNumbers=
npx ampx sandbox
```

Next, move the file to your project. You can do this by dragging and dropping the file into your Xcode project.

To use the Amplify Analytics and Authentication categories in your app, you need to create and configure their corresponding plugins by calling the `Amplify.add(plugin:)` and `Amplify.configure(with:)` methods.

Add the following imports to the top of your main `App` file:

```swift
import Amplify
import AWSCognitoAuthPlugin
import AWSPinpointAnalyticsPlugin
```

Add the following code to its initializer. If there is none, you can create a default `init`:

```swift
init()  catch 
}
```

</Block>

Add the following imports to the top of your `AppDelegate.swift` file:

```swift
import Amplify
import AWSCognitoAuthPlugin
import AWSPinpointAnalyticsPlugin
```

Add the following code to the `application:didFinishLaunchingWithOptions` method:

```swift
func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool  catch 

    return true
}
```

</Block>

</BlockSwitcher>

Upon building and running this application you should see the following in your console window:

```console
Amplify configured with Auth and Analytics plugin
```
</InlineFilter>

Add the Auth and Analytics plugin, along with any other plugins you may have added as described in the **Project Setup** section;

```dart
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import 'amplify_outputs.dart';

Future<void> _configureAmplify() async 
```

> **Note**: 

When running your app on macOS you will need to enable keychain sharing in Xcode, as described in the [Project setup guide](/gen1/[platform]/start/project-setup/platform-setup/#enable-keychain).

Make sure that the amplify_outputs.dart file generated in the project setup is included and sent to Amplify.configure:

```dart
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import 'amplify_outputs.dart';

Future<void> _configureAmplify() async  on AmplifyAlreadyConfiguredException 
}
```

Your class will look like this:

```dart
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';

import 'amplify_outputs.dart';

Future<void> _configureAmplify() async  on AmplifyAlreadyConfiguredException 
}

Future<void> main() async 

class MyApp extends StatefulWidget ): super(key: key);

  // ...
}
```
</InlineFilter>

To initialize the Amplify Auth and Analytics categories you call `Amplify.addPlugin()` method for each category. To complete initialization call `Amplify.configure()`.

Add the following code to your `onCreate()` method in your application class:

> **Note**: 
Before calling the `Amplify.configure` function, make sure to either download the `amplify_outputs.json` file from the console, or generate it with the following command: 

```bash title="Terminal" showLineNumbers=
npx ampx generate outputs --app-id <app-id> --branch main --out-dir app/src/main/res/raw
```

Next, be sure the file you generated or downloaded is in the appropriate resource directory for your application (for example, `app/src/main/res/raw`) in your Android project. Otherwise, you will not be able to compile your application.

```java
import android.util.Log;
import com.amplifyframework.AmplifyException;
import com.amplifyframework.analytics.pinpoint.AWSPinpointAnalyticsPlugin;
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin;
import com.amplifyframework.core.Amplify;
import com.amplifyframework.core.configuration.AmplifyOutputs;

```

```java
Amplify.addPlugin(new AWSCognitoAuthPlugin());
Amplify.addPlugin(new AWSPinpointAnalyticsPlugin());
```

Your class will look like this:

```java
public class MyAmplifyApp extends Application  catch (AmplifyException error) 
    }
}
```

</Block>

```kotlin
import android.util.Log
import com.amplifyframework.AmplifyException
import com.amplifyframework.analytics.pinpoint.AWSPinpointAnalyticsPlugin
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin
import com.amplifyframework.core.Amplify
import com.amplifyframework.core.configuration.AmplifyOutputs
```

```kotlin
Amplify.addPlugin(AWSCognitoAuthPlugin())
Amplify.addPlugin(AWSPinpointAnalyticsPlugin())
```

Your class will look like this:

```kotlin
class MyAmplifyApp : Application()  catch (error: AmplifyException) 
    }
}
```

</Block>

```java
import android.util.Log;
import com.amplifyframework.AmplifyException;
import com.amplifyframework.analytics.pinpoint.AWSPinpointAnalyticsPlugin;
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin;
import com.amplifyframework.core.configuration.AmplifyOutputs;
import com.amplifyframework.rx.RxAmplify;
```

```java
RxAmplify.addPlugin(new AWSCognitoAuthPlugin());
RxAmplify.addPlugin(new AWSPinpointAnalyticsPlugin());
```

Your class will look like this:

```java
public class MyAmplifyApp extends Application  catch (AmplifyException error) 
    }
}
```

</Block>
</BlockSwitcher>

</InlineFilter>

Next Steps:

Congratulations! Now that you have Analytics' backend provisioned and Analytics library installed. Check out the following links to see Amplify Analytics use cases:

- [Record Events](/[platform]/build-a-backend/add-aws-services/analytics/record-events/)
- [Track Sessions](/[platform]/build-a-backend/add-aws-services/analytics/auto-track-sessions/)
- [Identify User](/[platform]/build-a-backend/add-aws-services/analytics/identify-user/)

### References

[Amazon Pinpoint Construct Library](https://docs.aws.amazon.com/cdk/api/v2/docs/aws-cdk-lib.aws_pinpoint-readme.html)

## Known Issues

You may encounter the following error when starting the bundler when using Amazon Kinesis (`aws-amplify/analytics/kinesis`), Amazon Kinesis Data Firehose (`aws-amplify/analytics/kinesis-firehose`), Personalize Event (`aws-amplify/analytics/personalize`):

> Error: Unable to resolve module stream from /path/to/node_modules/@aws-sdk/... This is a [known issue](https://github.com/aws/aws-sdk-js-v3/issues/4877). Please follow [the steps](https://github.com/aws/aws-sdk-js-v3/issues/4877#issuecomment-1656007484) outlined in the issue to resolve the error.

</InlineFilter>


---

## 📚 Related Topics
- [[Analytics/]]

## 📖 Source
Original: `pages/build-a-backend/add-aws-services/analytics/set-up-analytics/index.mdx`