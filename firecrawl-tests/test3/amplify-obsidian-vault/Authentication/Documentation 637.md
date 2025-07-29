---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/ios/escapehatch/10_awsmobileclient_escape.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

For advanced use cases where Amplify does not provide the functionality you're looking for, you can retrieve the escape hatch to access the underlying SDK.

The escape hatch provides access to the underlying `AWSCognitoIdentityProvider` instance. Import the necessary types:

```swift
import AWSCognitoAuthPlugin
import AWSCognitoIdentityProvider
```

Then retrieve the escape hatch with this code:

```swift
func getEscapeHatch()  else if case .userPool(let userPoolClient) = plugin?.getEscapeHatch()  else 
    print("Fetched escape hatch - \(String(describing: client))")
}
```


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/ios/escapehatch/10_awsmobileclient_escape.mdx`