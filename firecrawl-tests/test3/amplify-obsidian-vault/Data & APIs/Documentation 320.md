---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/flutter/advanced-workflows/custom-primary-key/query-snippet.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Documentation

A record of a model with custom primary key can be queried with query predicate in the following ways:

```dart
final book = (
  await Amplify.DataStore.query(
    Book.classType,
    where: Book.ISBN.eq('12345'),
  ),
)[0];
```
</Block>

You should always query by model identifier if the model has a composite primary key.

If you know the value of each field of the composite primary key, you can create a instance of the model identifier by using codegen generated class to create a query predicate:

```dart
final book = (
  await Amplify.DataStore.query(
    Book.classType,
    where: Book.MODEL_IDENTIFIER.eq(
      // BookModelIdentifier is a codegen generated class
      // that is exported from ModelProvider.dart
      BookModelIdentifier(
        isbn: '12345',
      ),
    ),
  ),
)[0];
```

If you have the reference of a model instance, you can use the getter `modelIdentifier` to get the identifier of this instance, and to create a query predicate with it.

```dart
final reQueriedBook = (
  await Amplify.DataStore.query(
    Book.classType,
    where: Book.MODEL_IDENTIFIER.eq(
      book.modelIdentifier,
    ),
  ),
)[0];
```
</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/flutter/advanced-workflows/custom-primary-key/query-snippet.mdx`