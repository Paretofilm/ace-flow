---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib/graphqlapi/ios/advanced-workflows/20_custom.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Documentation

```swift
extension GraphQLRequest 
        }
        """
        return GraphQLRequest(
            document: document,
            variables: ["id": id],
            responseType: Todo.self,
            decodePath: operationName
        )
    }
}
```
The decode path specifies which part of the response to deserialize to the `responseType`. You'll need to specify the operation name to deserialize the object at "data.getTodo" successfully into a Todo model.

Then, query for the Todo by a todo id
```swift
try await Amplify.API.query(request: .getWithoutDescription(byId: "[UNIQUE_ID]"))
  // handle result
```


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/graphqlapi/ios/advanced-workflows/20_custom.mdx`