---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/ios/signin_next_steps/100_continue_mfa_setup.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

```swift 
// Confirm sign in with TOTP setup
case .continueSignInWithTOTPSetup(let setUpDetails):
    
    /// appName parameter will help distinguish the account in the Authenticator app
    let setupURI = try setUpDetails.getSetupURI(appName: ">") 
    
    print("TOTP Setup URI: \(setupURI)")
```

```swift
func confirmSignInWithTOTPSetup(totpCodeFromAuthenticatorApp: String) async  else 
    } catch 
}
```

</Block>

```swift
func confirmSignInWithTOTPSetup(totpCodeFromAuthenticatorApp: String) -> AnyCancellable .sink 
        }
        receiveValue:  else 
        }
}
```

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/ios/signin_next_steps/100_continue_mfa_setup.mdx`