---
title: Documentation
source: fragments/lib/graphqlapi/flutter/advanced-workflows/30_nested.mdx
---

# Documentation

```dart
const getPost = 'getPost';
const graphQLDocument = '''query GetPost(\$id: ID!) 
    }
  }
}''';
final getPostRequest = GraphQLRequest(
  document: graphQLDocument,
  modelType: Post.classType,
  variables: ,
  decodePath: getPost,
);
```

Then, query for the `Post` with nested comments included in decoded response:
```dart
Future<void> queryPostWithNestedComments(
  GraphQLRequest getPostRequest,
) async 
```
