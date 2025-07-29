---
title: Documentation
topics: ['Data & APIs', 'Getting Started']
primary_topic: Data & APIs
source: fragments/lib/datastore/ios/getting-started/50_initDataStore.mdx
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

**Add the following code**

In your `App` scene, configure Amplify in the initializer:

```swift

@main
struct MyAmplifyApp: App 
    }

    init()  catch 
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
Original: `fragments/lib/datastore/ios/getting-started/50_initDataStore.mdx`