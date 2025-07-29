---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib-v1/graphqlapi/ios/advanced-workflows/40_multiple.mdx
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
          getTodo(id: $todoId) 
        }
        """
        return GraphQLRequest(document: document,
                                         variables: ["postId": postId,
                                                     "todoId": todoId],
                                         responseType: JSONValue.self)
    }
}
```
Notice here that `JSONValue` is used as the `responseType`. `JSONValue` is utility type that can be used to represent an arbitrary JSON response.

Once you have the response data in a `JSONValue`, you can access each object in the JSON structure by encoding it back to Data and decoding it to the expected Model.

```swift
Amplify.API.query(request: .get(byPostId: "[POST_ID]", todoId: "[TODO_ID]")) 
            if let postJSON = data.value(at: "getPost"),
                let postData = try? JSONEncoder().encode(postJSON),
                let post = try? JSONDecoder().decode(Post.self, from: postData) 
        case .failure(let errorResponse):
            print("Response contained errors: \(errorResponse)")
        }
    case .failure(let apiError):
        print("Failed with error: \(apiError)")
    }
}
```

If you have custom models or your Model has required fields that you have decided not to include in the response, you can create a `Codable` that conforms to the structure of the response data that you expect. From the previous example, the `Codable` would look like this

```swift
struct PostAndTodoResponse: Codable 
    struct Post: Codable 
}
```
Then use `PostAndTodoResponse` as the `responseType` of the `GraphQLRequest` instead of using `JSONValue`.


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib-v1/graphqlapi/ios/advanced-workflows/40_multiple.mdx`