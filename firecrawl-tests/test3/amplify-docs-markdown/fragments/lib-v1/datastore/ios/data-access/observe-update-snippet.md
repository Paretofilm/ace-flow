---
title: Documentation
source: fragments/lib-v1/datastore/ios/data-access/observe-update-snippet.mdx
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
