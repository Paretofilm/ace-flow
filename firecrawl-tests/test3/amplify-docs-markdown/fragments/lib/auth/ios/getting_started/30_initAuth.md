---
title: Documentation
source: fragments/lib/auth/ios/getting_started/30_initAuth.mdx
---

# Documentation

To initialize the Amplify Auth category, pass in the AWSCognitoAuthPlugin to `Amplify.add()`.  When you are done calling `add()` on each category that you need, you finish configuring Amplify by calling `Amplify.configure()`.

**Add the following imports**:

```swift
import Amplify
import AWSCognitoAuthPlugin
```

**Configure Amplify at app launch**

Configure Amplify in the App `init`

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

```bash
Amplify configured with auth plugin
```
