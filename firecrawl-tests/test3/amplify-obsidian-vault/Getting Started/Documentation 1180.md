---
title: Documentation
topics: ['Getting Started']
primary_topic: Getting Started
source: fragments/lib/predictions/ios/getting-started/40_init.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, getting-started]
---


## 🧭 Navigation
**Topics**: [[Getting Started/]]
**Primary**: [[Getting Started/]]

---


# Documentation

To initialize the Amplify Predictions and Auth categories, use the `Amplify.add(plugin:)` method to add **AWSCognitoAuthPlugin** and **AWSPredictionsPlugin**. Next finish configuring Amplify by calling `Amplify.configure()`.

Open the main file of your application - `AppDelegate.swift` or `App.swift` - and **add the following import statements** to the top of the file.
```swift
import Amplify
import AWSCognitoAuthPlugin
import AWSPredictionsPlugin
```

**Configure Amplify at app launch**

```swift
@main
struct MyAmplifyApp: App 
    }

    init()  catch 
    }
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

```bash
Amplify configured with Auth and Predictions plugins
```


---

## 📚 Related Topics
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/predictions/ios/getting-started/40_init.mdx`