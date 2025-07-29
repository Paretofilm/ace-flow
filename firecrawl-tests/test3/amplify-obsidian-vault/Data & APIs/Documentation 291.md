---
title: Documentation
topics: ['Data & APIs', 'Authentication']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/ios/setup-auth-rules/10_multiauth-snippet.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis, authentication]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]] • [[Authentication/]]
**Primary**: [[Data & APIs/]]

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


---

## 📚 Related Topics
- [[Data & APIs/]]
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/ios/setup-auth-rules/10_multiauth-snippet.mdx`