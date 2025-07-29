---
title: Documentation
topics: ['Maps & Location', 'Getting Started']
primary_topic: Maps & Location
source: fragments/lib-v1/geo/ios/getting_started/40_init_geo.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, maps-&-location, getting-started]
---


## 🧭 Navigation
**Topics**: [[Maps & Location/]] • [[Getting Started/]]
**Primary**: [[Maps & Location/]]

---


# Documentation

To initialize the Amplify Geo, use the `Amplify.addPlugin()` method to add the AWSLocationGeoPlugin. Next, finish configuring Amplify by calling `Amplify.configure()`.

Open the main file of the application - `AppDelegate.swift` or `App.swift` depending on the app's life cycle - and **add the following** import statements at the top of the file:

```swift
import Amplify
import AWSLocationGeoPlugin
```

</Block>

```swift
import Amplify
import AmplifyPlugins
```

</Block>

</BlockSwitcher>

In the same file, **create a function** to configure Amplify:
```swift
func configureAmplify()  catch 
}
```

Now **call the `configureAmplify()` function** in the starting point of your application.

```swift
@main
struct App: App 
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
- [[Maps & Location/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/geo/ios/getting_started/40_init_geo.mdx`