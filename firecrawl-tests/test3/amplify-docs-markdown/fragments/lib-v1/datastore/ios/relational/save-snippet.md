---
title: My post with comments
source: fragments/lib-v1/datastore/ios/relational/save-snippet.mdx
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
