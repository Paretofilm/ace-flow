---
title: Documentation
source: fragments/lib-v1/graphqlapi/ios/advanced-workflows/30_nested.mdx
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
Query with `Amplify.API.query(request: .getPostWithComments(byId: "[POST_ID]"))`.
