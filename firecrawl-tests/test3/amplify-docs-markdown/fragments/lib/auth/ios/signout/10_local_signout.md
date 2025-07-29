---
title: Documentation
source: fragments/lib/auth/ios/signout/10_local_signout.mdx
---

# Documentation

```swift
func signOutLocally() async 

    print("Local signout successful: \(signOutResult.signedOutLocally)")
    switch signOutResult 

        if let globalSignOutError = globalSignOutError 

        if let revokeTokenError = revokeTokenError 

    case .failed(let error):
        // Sign Out failed with an exception, leaving the user signed in.
        print("SignOut failed with \(error)")
    }
}
```

</Block>

```swift
func signOutLocally() -> AnyCancellable .sink(receiveValue: 
        print("Local signout successful: \(signOutResult.signedOutLocally)")
        switch signOutResult 

            if let globalSignOutError = globalSignOutError 

            if let revokeTokenError = revokeTokenError 

        case .failed(let error):
            // Sign Out failed with an exception, leaving the user signed in.
            print("SignOut failed with \(error)")
        }
    })
}
```

</Block>

</BlockSwitcher>
