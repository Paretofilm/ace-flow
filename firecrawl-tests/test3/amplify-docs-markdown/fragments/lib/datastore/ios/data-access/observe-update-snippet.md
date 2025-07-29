---
title: Documentation
source: fragments/lib/datastore/ios/data-access/observe-update-snippet.mdx
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

    func updateTitle(_ title: String) async 
        post.title = title
        do  catch let error as DataStoreError  catch 
    }
}
struct PostView: View 

    var body: some View 
            }
        }.onAppear(perform: 
        })
    }
}
```
