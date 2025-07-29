---
title: Update data
source: fragments/lib/restapi/ios/update.mdx
---

# Update data

## Update data

Put data to the API endpoint:

```swift
func putTodo() async "#
    let request = RESTRequest(path: "/todo", body: updatedMessage.data(using: .utf8))
    do  catch let error as APIError  catch 
}
```

</Block>

```swift
func putTodo() -> AnyCancellable "#
    let request = RESTRequest(path: "/todo", body: updatedMessage.data(using: .utf8))
    let sink = Amplify.Publisher.create 
    .sink 
    }
    receiveValue: 
    return sink
}
```

</Block>

</BlockSwitcher>
