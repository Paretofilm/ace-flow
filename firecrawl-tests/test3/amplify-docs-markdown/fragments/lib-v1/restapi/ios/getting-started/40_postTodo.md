---
title: Documentation
source: fragments/lib-v1/restapi/ios/getting-started/40_postTodo.mdx
---

# Documentation

```swift
func postTodo() "#
    let request = RESTRequest(path: "/todo", body: message.data(using: .utf8))
    Amplify.API.post(request: request) 
    }
}
```

</Block>

```swift
func postTodo() -> AnyCancellable "#
    let request = RESTRequest(path: "/todo", body: message.data(using: .utf8))
    let sink = Amplify.API.post(request: request)
        .resultPublisher
        .sink 
        }
        receiveValue: 
    return sink
}
```

</Block>

</BlockSwitcher>
