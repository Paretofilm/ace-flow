---
title: Documentation
topics: ['File Storage', 'Getting Started']
primary_topic: File Storage
source: fragments/lib/storage/ios/getting-started/30_initStorage.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage, getting-started]
---


## 🧭 Navigation
**Topics**: [[File Storage/]] • [[Getting Started/]]
**Primary**: [[File Storage/]]

---


# Documentation

To use the Amplify Storage and Authentication categories in your app, you need to create and configure their corresponding plugins by calling the `Amplify.add(plugin:)` and `Amplify.configure()` methods.

Add the following imports to the top of your `App` scene and configure Amplify in the `init`:
```swift
import Amplify
import AWSCognitoAuthPlugin
import AWSS3StoragePlugin

@main
struct MyAmplifyApp: App 
    }

    init()  catch 
    }
}
```

</Block>

Add the following imports to the top of your `AppDelegate.swift` file:

```swift
import Amplify
import AWSCognitoAuthPlugin
import AWSS3StoragePlugin
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
Amplify configured with Auth and Storage plugins
```


---

## 📚 Related Topics
- [[File Storage/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/storage/ios/getting-started/30_initStorage.mdx`