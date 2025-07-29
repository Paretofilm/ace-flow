---
title: Documentation
source: fragments/lib-v1/datastore/ios/setup-auth-rules/10_multiauth-snippet.mdx
---

# Documentation

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
