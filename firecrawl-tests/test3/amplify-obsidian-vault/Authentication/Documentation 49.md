---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib-v1/auth/ios/signin_with_custom_flow/40_signin.mdx
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
func signIn(username: String)  else 
        case .failure(let error):
            print("Sign in failed \(error)")
        }
    }
}
```

</Block>

```swift
func signIn(username: String, password: String) -> AnyCancellable 
        }
        receiveValue:  else 
        }
}
```

</Block>

</BlockSwitcher>

Since this is a custom authentication flow with a challenge, the result of the signin process has a next step `.confirmSignInWithCustomChallenge`. Implement a UI to allow the user to enter the custom challenge.


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib-v1/auth/ios/signin_with_custom_flow/40_signin.mdx`