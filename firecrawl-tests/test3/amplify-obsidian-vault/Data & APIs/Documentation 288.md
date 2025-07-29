---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/ios/relational/query-snippet.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Documentation

Models with one-to-many connections are lazy-loaded when accessing the connected property, so accessing a relation is as simple as:

```swift
Amplify.DataStore.query(Post.self, byId: "123") 
            }
        } else 
    case .failure(let error):
        print("Post not found - \(error.localizedDescription)")
    }
}
```

</Block>

```swift
let sink = Amplify.DataStore.query(Post.self, byId: "123")
    .compactMap 
    .flatMap 
    .sink 
    }
    receiveValue: 
    }
```

</Block>

</BlockSwitcher>

The connected properties are of type `List`, where `M` is the model type, and that type is a custom [Swift Collection](https://developer.apple.com/documentation/swift/collection), which means that you can `filter`, `map`, etc:

```swift
let excitedComments = postWithComments
    .comments?
    .compactMap 
    .filter 
```


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/ios/relational/query-snippet.mdx`