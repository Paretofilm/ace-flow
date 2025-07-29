---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/ios/data-access/observe-update-snippet.mdx
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
import SwiftUI
import Amplify
import Combine

/*
 Example showing how to observe the model and keep the state updated before performing a save. This uses the
 `@Published` property for views to observe and re-render changes to the model.
 */
class PostViewModel: ObservableObject 
    
    func observe(postId: String)  receiveValue: 
            DispatchQueue.main.async 
        }
    }
    
    func updateTitle(_ title: String) 
        post.title = title
        Amplify.DataStore.save(post) 
        }
    }
}
struct PostView: View 
    
    var body: some View 
        }.onAppear(perform: )
    }
}
```


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/ios/data-access/observe-update-snippet.mdx`