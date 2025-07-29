---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib/graphqlapi/flutter/advanced-workflows/30_nested.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

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


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/graphqlapi/flutter/advanced-workflows/30_nested.mdx`