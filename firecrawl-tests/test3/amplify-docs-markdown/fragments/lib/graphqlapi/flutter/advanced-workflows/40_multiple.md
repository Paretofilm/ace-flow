---
title: Documentation
source: fragments/lib/graphqlapi/flutter/advanced-workflows/40_multiple.mdx
---

# Documentation

```dart
const getTodo = 'getTodo';
const getPost = 'getPost';
const graphQLDocument = '''
  query GetPostAndTodo(\$todoId: ID!, \$postId: ID!) 
    $getPost(id: \$postId) 
  }

''';
final multiOperationRequest = GraphQLRequest(
  document: graphQLDocument,
  variables: ,
);
```
Notice here that `modelType` and `decodePath` are omitted. When these decoding variables are omitted, the plugin simply returns the result as a raw `String` from the response.

Once you have the response data in a `String`, you can parse it using `json.decode()` and pass the resulting `Map` to the model's `fromJson()` method to create an instance of the model.

```dart
// Do not forget to add this to imports for json.decode
import 'dart:convert';

...

Future<void> queryMultiOperationRequest(
  GraphQLRequest operation,
) async 
}
```
