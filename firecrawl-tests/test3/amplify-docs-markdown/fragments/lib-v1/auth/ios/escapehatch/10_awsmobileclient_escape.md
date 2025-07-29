---
title: Documentation
source: fragments/lib-v1/auth/ios/escapehatch/10_awsmobileclient_escape.mdx
---

# Documentation

For advanced use cases where Amplify does not provide the functionality you're looking for,
you can retrieve the escape hatch to access the underlying SDK.

The escape hatch provides access to the underlying `AWSMobileClient` instance.

```swift
import AWSCognitoAuthPlugin // Imports the Amplify plugin interface
```

</Block>

```swift
import AmplifyPlugins // Imports the Amplify plugin interface
```

</Block>

</BlockSwitcher>

Then retrieve the escape hatch with this code:

```swift
func getEscapeHatch() 
        print("Fetched escape hatch - \(awsmobileclient)")
    } catch 
}
```

It is not recommended to use`AWSMobileClient` credentials apis like `getToken`, `getAWSCredentials` through the escape hatch object.

You can use the escape hatch to `federatedSignIn` with a valid token from other social providers. Find more details [here](/gen1/[platform]/sdk/auth/federated-identities/)

```swift
awsmobileclient.federatedSignIn(providerName: IdentityProvider.apple.rawValue,
                                token: "") 

        guard let userState = userState else 
        print("federatedSignIn successful: \(userState)")
}
```
