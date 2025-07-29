---
title: Update data
topics: ['General']
primary_topic: General
source: fragments/lib/restapi/ios/update.mdx
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


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/restapi/ios/update.mdx`