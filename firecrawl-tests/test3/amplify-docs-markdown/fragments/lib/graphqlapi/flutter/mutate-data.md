---
title: Run a mutation
source: fragments/lib/graphqlapi/flutter/mutate-data.mdx
---

# Run a mutation

## Run a mutation

Now that the client is set up, you can run a GraphQL mutation with `Amplify.API.mutate` to create, update, and delete your data.

To update the `Todo` with a new name:

```dart
Future<void> updateTodo(Todo originalTodo) async 
```

To delete the `Todo`:

```dart
Future<void> deleteTodo(Todo todoToDelete) async 
```

```dart
// or delete by ID, ideal if you do not have the instance in memory, yet
Future<void> deleteTodoById(Todo todoToDelete) async 
```
