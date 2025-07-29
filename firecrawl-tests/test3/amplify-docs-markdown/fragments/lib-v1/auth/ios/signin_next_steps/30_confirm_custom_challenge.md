---
title: Documentation
source: fragments/lib-v1/auth/ios/signin_next_steps/30_confirm_custom_challenge.mdx
---

# Documentation

If the next step is `confirmSignInWithCustomChallenge`, Amplify Auth is awaiting completion of a custom authentication challenge. The challenge is based on the Lambda trigger you setup when you configured a [custom sign in flow](/gen1/[platform]/prev/build-a-backend/auth/sign-in-custom-flow/). To complete this step, you should prompt the user for the custom challenge answer, and pass the answer to the `confirmSignIn` API.

```swift
func confirmSignIn(challengeAnswerFromUser: String)  else 
        case .failure(let error):
            print("Confirm sign in failed \(error)")
        }
    }
}
```

</Block>

```swift
func confirmSignIn(challengeAnswerFromUser: String) -> AnyCancellable 
        }
        receiveValue:  else 
        }
}
```

</Block>

</BlockSwitcher>
