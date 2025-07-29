---
title: My post with comments
source: fragments/lib-v1/datastore/ios/relational/save-many-snippet.mdx
---

# My post with comments

```swift
let post = Post(title: "My post with comments",
                rating: 5,
                status: .active)
let editor = User(username: "Nadia")

Amplify.DataStore.save(post) 
                }
            }
        }
    }
}
```

</Block>

```swift
let post = Post(title: "My post with comments",
                rating: 5,
                status: .active)
let editor = User(username: "Nadia")

let sink = Amplify.DataStore.save(post)
    .flatMap 
    .flatMap 
    .sink 
    }
    receiveValue: 
```

</Block>

</BlockSwitcher>

> **Note**: 

This example illustrates the complexity of working with multiple dependent persistence operations. The callback model is flexible but imposes some challenges when dealing with such scenarios. Prefer to use the Combine model if your app supports iOS 13 or higher. If not, the recommendation is that you use multiple functions to simplify the code.
