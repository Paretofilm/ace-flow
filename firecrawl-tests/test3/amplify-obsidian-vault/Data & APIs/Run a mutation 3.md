---
title: Run a mutation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/graphqlapi/ios/mutate-data.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Run a mutation

## Run a mutation

Now that the client is set up, you can run a GraphQL mutation with `Amplify.API.mutate` to create, update, and delete your data.

Make sure you have the following imports at the top of your file
```swift
import Amplify
```

```swift
func updateTodo() async 
    } catch let error as APIError  catch 
}
```
</Block>

Make sure you have the following imports at the top of your file
```swift
import Amplify
import Combine
```

```swift
func updateTodo() -> AnyCancellable 
    .sink 
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
try await Amplify.API.mutate(request: .create(todo))
```
To delete data, replace the request with `.delete`
```swift
try await Amplify.API.mutate(request: .delete(todo))
```


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/graphqlapi/ios/mutate-data.mdx`