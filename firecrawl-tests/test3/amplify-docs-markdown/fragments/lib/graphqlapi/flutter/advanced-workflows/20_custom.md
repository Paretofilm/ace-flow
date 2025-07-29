---
title: Documentation
source: fragments/lib/graphqlapi/flutter/advanced-workflows/20_custom.mdx
---

# Documentation

```dart
const getTodo = 'getTodo';
const graphQLDocument = '''query GetTodo(\$id: ID!) 
}''';
final getTodoRequest = GraphQLRequest(
  document: graphQLDocument,
  modelType: Todo.classType,
  variables: ,
  decodePath: getTodo,
);
```
The `decodePath` specifies which part of the response to deserialize to the `modelType`. You'll need to specify the operation name (as `decodePath`) and `modelType` to deserialize the object at "data.getTodo" successfully into a `Todo` model.

Then, query for the Todo by a todo id:
```dart
Future<void> queryTodo(GraphQLRequest getTodoRequest) async 
```
