---
title: Documentation
source: fragments/lib/restapi/ios/getting-started/40_postTodo.mdx
---

# Documentation

```swift
func postTodo() async "#
    let request = RESTRequest(path: "/todo", body: message.data(using: .utf8))
    do  catch let error as APIError  catch 
}
```

</Block>

```swift
func postTodo() -> AnyCancellable "#
    let request = RESTRequest(path: "/todo", body: message.data(using: .utf8))
    let sink = Amplify.Publisher.create 
    .sink 
    }
    receiveValue: 
    return sink
}
```

</Block>

</BlockSwitcher>
