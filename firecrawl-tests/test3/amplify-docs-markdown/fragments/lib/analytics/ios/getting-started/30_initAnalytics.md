---
title: Documentation
source: fragments/lib/analytics/ios/getting-started/30_initAnalytics.mdx
---

# Documentation

To use the Amplify Analytics and Authentication categories in your app, you need to create and configure their corresponding plugins by calling the `Amplify.add(plugin:)` and `Amplify.configure()` methods.

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
