---
title: Update data
topics: ['General']
primary_topic: General
source: fragments/lib-v1/restapi/ios/update.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Update data

## Update data

Put data to the API endpoint:

```swift
func putTodo() "#
    let request = RESTRequest(path: "/todo", body: updatedMessage.data(using: .utf8))
    Amplify.API.put(request: request) 
    }
}
```

</Block>

```swift
func putTodo() -> AnyCancellable "#
    let request = RESTRequest(path: "/todo", body: updatedMessage.data(using: .utf8))
    let sink = Amplify.API.put(request: request)
        .resultPublisher
        .sink 
        }
        receiveValue: 
    return sink
}
```

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib-v1/restapi/ios/update.mdx`