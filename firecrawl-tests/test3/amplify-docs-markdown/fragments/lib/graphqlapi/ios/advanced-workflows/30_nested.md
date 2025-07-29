---
title: Documentation
source: fragments/lib/graphqlapi/ios/advanced-workflows/30_nested.mdx
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
