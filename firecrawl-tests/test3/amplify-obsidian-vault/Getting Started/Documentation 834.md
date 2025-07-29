---
title: Documentation
topics: ['Getting Started']
primary_topic: Getting Started
source: fragments/lib/restapi/ios/getting-started/40_postTodo.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, getting-started]
---


## 🧭 Navigation
**Topics**: [[Getting Started/]]
**Primary**: [[Getting Started/]]

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


---

## 📚 Related Topics
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/restapi/ios/getting-started/40_postTodo.mdx`