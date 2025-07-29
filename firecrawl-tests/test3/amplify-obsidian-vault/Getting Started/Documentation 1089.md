---
title: Documentation
topics: ['Getting Started']
primary_topic: Getting Started
source: fragments/lib/graphqlapi/ios/getting-started/30_initapi.mdx
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

Create a custom `AppDelegate` with the following imports and `application:didFinishLaunchingWithOptions` method:

```swift
import Amplify
import AWSAPIPlugin
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate  catch 

        return true
    }
}
```

Then in your `App` scene, use the `UIApplicationDelegateAdaptor` property wrapper to use your custom `AppDelegate`:

```swift
@main
struct MyAmplifyApp: App 
    }
}
```

</Block>

Add the following imports to the top of your `AppDelegate.swift` file:

```swift
import Amplify
import AWSAPIPlugin
```

Add the following code to the AppDelegate's `application:didFinishLaunchingWithOptions` method:

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
Original: `fragments/lib/graphqlapi/ios/getting-started/30_initapi.mdx`