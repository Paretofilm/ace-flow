---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib-v1/auth/ios/signin/40_multi_factor_signup.mdx
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
func signUp(username: String, password: String, email: String, phonenumber: String)  else 
        case .failure(let error):
            print("An error occurred while registering a user \(error)")
        }
    }
}
```

</Block>

```swift
func signUp(username: String, password: String, email: String, phonenumber: String) -> AnyCancellable 
        }
        receiveValue:  else 
        }
    return sink
}
```

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib-v1/auth/ios/signin/40_multi_factor_signup.mdx`