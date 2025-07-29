---
title: Customization
topics: ['Authentication']
primary_topic: Authentication
source: fragments/sdk/auth/ios/drop-in-auth.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Customization

The `AWSMobileClient` client supports a "drop-in" UI component that allows you to easily add the full capabilities for authentication to your application.

```swift
AWSMobileClient.default().showSignIn(
    navigationController: self.navigationController!,  else if let error = error 
    }
)
```

> **Note**: The drop-in UI requires the use of a navigation controller. Please make sure your app has an active navigation controller which is passed in via the `navigationController` parameter.

## Customization

You can change the following properties of the drop-in UI with the `AWSMobileClient`:

- **Logo**: Any image file of png or jpg
- **Background Color**: Any iOS UIColor

```swift
AWSMobileClient.default()
    .showSignIn(
        navigationController: self.navigationController!,
        signInUIOptions: SignInUIOptions(
            // dismiss the sign-in process
            canCancel: false,
            logoImage: UIImage(
                named: "MyCustomLogo"
            ),
            backgroundColor: UIColor.black
        )
    ) 
```


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/sdk/auth/ios/drop-in-auth.mdx`