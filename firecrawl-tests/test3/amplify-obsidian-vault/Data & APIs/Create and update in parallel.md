---
title: Create and update in parallel
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/guides/datastore/parallel-processing-ios.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Create and update in parallel

Amplify DataStore provides APIs that allow you to create, read, update, and delete items individually. Sometimes you need to perform multiple operations in parallel, like creating and updating several objects or querying and deleting objects by their IDs. In this guide, you will learn how to perform parallel processing using the Combine framework to extend the functionality of the Amplify DataStore APIs.

> **Note**: 

For simplicity, this Guide demonstrates how to perform parallel processing using the Combine framework. To follow along, you must include `import Combine` at the top of your file.

## Create and update in parallel

To write data to the DataStore in parallel, pass an array of models to a Combine `Publishers.Sequence` and perform `Amplify.DataStore.save(_ model:)` on each object:

```swift
let todos = [
    Todo(name: "Learn Amplify"),
    Todo(name: "Build app"),
    Todo(name: "Profit")
]

let sink = Publishers.Sequence<[Todo], Never>(sequence: todos)
    .flatMap 
    }
    .collect()
    .sink 
    } receiveValue: 
```

`Publishers.Sequence` creates a `Publisher` where each model is passed to `.flatMap()` individually, allowing for each object to be saved to DataStore. `.collect()` emits a single array of all the elements collected, returning the saved models in `receiveValue`.

## Delete in parallel

To delete items in parallel, pass an array of IDs to `Publishers.Sequence` and perform `Amplify.DataStore.delete(_withId:)` for each ID:

```swift
let todoIds = ["123", "456", "789"]

let sink = Publishers.Sequence<[String], Never>(sequence: todoIds)
    .flatMap 
    }
    .collect()
    .sink 
    } receiveValue: 
```

`Amplify.DataStore.delete(_withId:)` emits a `Void` when successful. The `receiveValue` of parallel deletes will pass `[Void]`.

## Query in parallel

To query items in parallel, pass an array of IDs to `Publishers.Sequence` and perform `Amplify.DataStore.query(_:byId:)` for each ID:

```swift
let todoIds = ["123", "456", "789"]

let sink = Publishers.Sequence<[String], Never>(sequence: todoIds)
    .flatMap 
    }
    .compactMap 
    .collect()
    .sink 
    } receiveValue: 
```

`Amplify.DataStore.query(_:byId:)` emits an optional model in the event an object is not found with that ID. `compactMap()` prevents `receiveValue` from providing an array with `nil` values. To include `nil` values in the result, omit `compactMap `.


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/guides/datastore/parallel-processing-ios.mdx`