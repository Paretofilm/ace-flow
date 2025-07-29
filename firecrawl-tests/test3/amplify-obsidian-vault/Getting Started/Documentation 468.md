---
title: Documentation
topics: ['Getting Started']
primary_topic: Getting Started
source: fragments/lib-v1/graphqlapi/ios/getting-started/30_initapi.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, getting-started]
---


## 🧭 Navigation
**Topics**: [[Getting Started/]]
**Primary**: [[Getting Started/]]

---


# Documentation

To initialize the Amplify API category, you are required to use the `Amplify.add()` method for the plugin followed by calling `Amplify.configure()`.

**Add the following imports** to the top of your `AppDelegate.swift` file:

```swift
import Amplify
import AWSAPIPlugin
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
Amplify configured with API plugin
```


---

## 📚 Related Topics
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/graphqlapi/ios/getting-started/30_initapi.mdx`