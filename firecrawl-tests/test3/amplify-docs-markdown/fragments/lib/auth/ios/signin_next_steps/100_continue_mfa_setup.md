---
title: Documentation
source: fragments/lib/auth/ios/signin_next_steps/100_continue_mfa_setup.mdx
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
