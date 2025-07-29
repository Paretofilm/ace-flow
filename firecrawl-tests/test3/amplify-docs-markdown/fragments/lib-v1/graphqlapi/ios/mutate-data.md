---
title: Run a mutation
source: fragments/lib-v1/graphqlapi/ios/mutate-data.mdx
---

# Run a mutation

## Run a mutation

Now that the client is set up, you can run a GraphQL mutation with `Amplify.API.mutate` to create, update, and delete your data.

Make sure you have the following imports at the top of your file
```swift
import Amplify
import AWSPluginsCore
```

```swift
func updateTodo() 
        case .failure(let error):
            print("Got failed event with error \(error)")
        }
    }
}
```
</Block>

Make sure you have the following imports at the top of your file
```swift
import Amplify
import AWSPluginsCore
import Combine
```

```swift
func updateTodo() -> AnyCancellable 
        }
        receiveValue: 
        }
    return sink
}
```

</Block>

</BlockSwitcher>

To create data, replace the request with `.create`
```swift
Amplify.API.mutate(request: .create(todo))
```
To delete data, replace the request with `.delete`
```swift
Amplify.API.mutate(request: .delete(todo))
```
