---
title: My post with comments
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/ios/relational/save-snippet.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# My post with comments

```swift
let postWithComments = Post(title: "My post with comments",
                            rating: 5,
                            status: .active)

let comment = Comment(content: "Loving Amplify DataStore", post: postWithComments)

Amplify.DataStore.save(postWithComments) 
        }
    }
}
```

</Block>

```swift
let postWithComments = Post(title: "My post with comments",
                            rating: 5,
                            status: .active)

let comment = Comment(content: "Loving Amplify DataStore", post: postWithComments)

let sink = Amplify.DataStore.save(postWithComments)
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
Original: `fragments/lib-v1/datastore/ios/relational/save-snippet.mdx`