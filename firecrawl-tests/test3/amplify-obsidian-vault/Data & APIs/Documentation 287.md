---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/ios/relational/delete-snippet.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Documentation

```swift
Amplify.DataStore.query(Post.self, byId: "123") 
        }
    case .failure(let error):
        print("Error fetching post with id 123 - \(error.localizedDescription)")
    }
}
```

</Block>

```swift
let sink = Amplify.DataStore.query(Post.self, byId: "123")
    // postWithComments might be nil, unwrap the optional appropriately
    .compactMap 
    .flatMap 
    .sink 
    }
    receiveValue: 
```

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/ios/relational/delete-snippet.mdx`