---
title: Documentation
topics: ['Analytics', 'Getting Started']
primary_topic: Analytics
source: fragments/lib-v1/analytics/ios/getting-started/30_initAnalytics.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, analytics, getting-started]
---


## 🧭 Navigation
**Topics**: [[Analytics/]] • [[Getting Started/]]
**Primary**: [[Analytics/]]

---


# Documentation

To initialize the Amplify Analytics and Authentication categories, you are required to use the `Amplify.add()` method for each category you want.  When you are done calling `add()` on each category, you finish configuring Amplify by calling `Amplify.configure()`.

**Add the following imports** to the top of your `AppDelegate.swift` file:

```swift
import Amplify
import AWSPinpointAnalyticsPlugin
```

</Block>

```swift
import Amplify
import AmplifyPlugins
```

</Block>

</BlockSwitcher>

**Add the following code**

Create a custom `AppDelegate`, and add to your `application:didFinishLaunchingWithOptions` method
```swift
class AppDelegate: NSObject, UIApplicationDelegate  catch 

        return true
    }
}
```

Then in the `App` scene, use `UIApplicationDelegateAdaptor` property wrapper to use your custom `AppDelegate`
```swift
@main
struct MyAmplifyApp: App 
    }
}
```

</Block>

Add to your AppDelegate's `application:didFinishLaunchingWithOptions` method

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


---

## 📚 Related Topics
- [[Analytics/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/analytics/ios/getting-started/30_initAnalytics.mdx`