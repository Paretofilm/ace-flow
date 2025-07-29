---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/ios/signin_web_ui/30_signin.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

Sweet! You're now ready to launch sign in with web UI. The `signInWithWebUI` api require a presentationAnchor and for an iOS app it will be the main UIWindow of the app. The example code below assume that you are in a UIViewController where you can fetch the UIWindow instance by `self.view.window`.

```swift
func signInWithWebUI() async 
    } catch let error as AuthError  catch 
}
```

</Block>

```swift
func signInWithWebUI() -> AnyCancellable .sink 
        }
        receiveValue: 
        }
}
```

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/ios/signin_web_ui/30_signin.mdx`