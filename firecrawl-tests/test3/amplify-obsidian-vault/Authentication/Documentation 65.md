---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib-v1/auth/ios/signin_next_steps/20_confirm_sms_mfa.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

If the next step is `confirmSignInWithSMSMFACode`, Amplify Auth has sent the user a random code over SMS, and is waiting to find out if the user successfully received it. To handle this step, your app's UI must prompt the user to enter the code. After the user enters the code, your implementation must pass the value to Amplify Auth `confirmSignIn` API.

Note: the signin result also includes an `AuthCodeDeliveryDetails` member. It includes additional information about the code delivery such as the partial phone number of the SMS recipient.

```swift
func confirmSignIn(confirmationCodeFromUser: String)  else 
        case .failure(let error):
            print("Confirm sign in failed \(error)")
        }
    }
}
```

</Block>

```swift
func confirmSignIn(confirmationCodeFromUser: String) -> AnyCancellable 
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
Original: `fragments/lib-v1/auth/ios/signin_next_steps/20_confirm_sms_mfa.mdx`