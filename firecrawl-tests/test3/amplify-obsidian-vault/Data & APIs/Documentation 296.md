---
title: Documentation
topics: ['Data & APIs', 'Getting Started']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/ios/getting-started/50_initDataStore.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis, getting-started]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]] • [[Getting Started/]]
**Primary**: [[Data & APIs/]]

---


# Documentation

To initialize the Amplify DataStore call `Amplify.add(plugin:)` method and add the `AWSDataStorePlugin`, then call `Amplify.configure()`.

**Add the following imports** to the top of your `AppDelegate.swift` file:

```swift
import Amplify
import AWSDataStorePlugin
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
Amplify configured with DataStore plugin
```


---

## 📚 Related Topics
- [[Data & APIs/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/ios/getting-started/50_initDataStore.mdx`