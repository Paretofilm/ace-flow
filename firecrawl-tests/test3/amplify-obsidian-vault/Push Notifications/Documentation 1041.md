---
title: Documentation
topics: ['Push Notifications', 'Getting Started']
primary_topic: Push Notifications
source: fragments/lib/push-notifications/ios/getting_started/70_init_push_notifications.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, push-notifications, getting-started]
---


## 🧭 Navigation
**Topics**: [[Push Notifications/]] • [[Getting Started/]]
**Primary**: [[Push Notifications/]]

---


# Documentation

To initialize the Amplify Push Notifications, you will use the `Amplify.addPlugin()` method to add the **AWSPinpointPushNotificationsPlugin** and then call `Amplify.configure()` to finish configuring Amplify.

Open the main file of the application - `AppDelegate.swift` or `App.swift` depending on the app's life cycle - and **add the following** import statements at the top of the file:

```swift
import Amplify
import AWSCognitoAuthPlugin
import AWSPinpointPushNotificationsPlugin
```

In the same file, **create a function** to configure Amplify:
```swift
func configureAmplify()  catch 
}
```

Now **call the `configureAmplify()` function** in the starting point of your application.

```swift
@main
struct App: App 
    // ...
}
```

</Block>

```swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate 
    // ...
}
```

</Block>
</BlockSwitcher>

Upon building and running this application you should see the following in your console window:

```console
Initialized Amplify
```


---

## 📚 Related Topics
- [[Push Notifications/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/push-notifications/ios/getting_started/70_init_push_notifications.mdx`