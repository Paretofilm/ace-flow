---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib/graphqlapi/ios/advanced-workflows/30_nested.mdx
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
          }
        }
        """
        return GraphQLRequest(
            document: document,
            variables: ["id": id],
            responseType: Post.self,
            decodePath: "getPost"
        )
    }
}

```
Query with `try await Amplify.API.query(request: .getPostWithComments(byId: "[POST_ID]"))`.


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/graphqlapi/ios/advanced-workflows/30_nested.mdx`