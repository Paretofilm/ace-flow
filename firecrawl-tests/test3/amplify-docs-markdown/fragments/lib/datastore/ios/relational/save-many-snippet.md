---
title: My first post
source: fragments/lib/datastore/ios/relational/save-many-snippet.mdx
---

# My first post

```swift
let post = Post(
    title: "My first post",
    status: .active
)
let user = User(
    username: "Nadia"
)
let postEditor = PostEditor(
    post: post,
    user: user
)
do  catch let error as DataStoreError  catch 
```

</Block>

```swift
let post = Post(
    title: "My first post",
    status: .active
)
let user = User(
    username: "Nadia"
)
let postEditor = PostEditor(
    post: post,
    user: user
)
let sink = Amplify.Publisher.create
    .flatMap 
    }
    .flatMap 
    }
    .sink 
    }
    receiveValue: 
```

</Block>

</BlockSwitcher>

> **Note**: 

This example illustrates the complexity of working with multiple dependent persistence operations. The callback model is flexible but imposes some challenges when dealing with such scenarios. Prefer to use the Combine model if your app supports iOS 13 or higher. If not, the recommendation is that you use multiple functions to simplify the code.
