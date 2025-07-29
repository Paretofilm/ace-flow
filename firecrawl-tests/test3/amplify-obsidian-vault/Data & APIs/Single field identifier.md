---
title: Single-field identifier
topics: ['Data & APIs']
primary_topic: Data & APIs
source: pages/build-a-backend/data/data-modeling/identifiers/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Single-field identifier

Identifiers are defined using the `.identifier()` method on a model definition. Usage of the `.identifier()` method is optional; when it's not present, the model will automatically have a field called `id` of type `ID` that is automatically generated unless manually specified.

```typescript
const schema = a.schema()
  .authorization(allow => [allow.publicApiKey()]),
});
```

```ts
const client = generateClient();

const todo = await client.models.Todo.create();
console.log(`New Todo created: $`); // New Todo created: 5DB6B4CC-CD41-49F5-9844-57C0AB506B69
```

</InlineFilter>

```swift
let todo = Todo(
    content: "Buy Milk", 
    completed: false)
let createdTodo = try await Amplify.API.mutate(request: .create(todo)).get()
print("New Todo created: \(createdTodo)")
```

</InlineFilter>

If you want, you can use Amplify Data to define single-field and composite identifiers:
- Single-field identifier with a consumer-provided value (type: `id` or `string`, and must be marked `required`)
- Composite identifier with a set of consumer-provided values (type: `id` or `string`, and must be marked `required`)

## Single-field identifier

If the default `id` identifier field needs to be customized, you can do so by passing the name of another field.

```typescript
const schema = a.schema()
  .identifier(['todoId'])
  .authorization(allow => [allow.publicApiKey()]),
});
```

```ts
const client = generateClient();

const  = await client.models.Todo.create();
console.log(`New Todo created: $`); // New Todo created: MyUniqueTodoId
```
</InlineFilter>

```swift
let todo = Todo(
    todoId: "MyUniqueTodoId",
    content: "Buy Milk",
    completed: false)
let createdTodo = try await Amplify.API.mutate(request: .create(todo)).get()
print("New Todo created: \(createdTodo)")
```

</InlineFilter>

## Composite identifier

For cases where items are uniquely identified by more than a single field, you can pass an array of the field names to the `identifier()` function:

```typescript
const schema = a.schema().identifier(['geoId', 'name'])
  .authorization(allow => [allow.publicApiKey()]),
});
```

```ts
const client = generateClient();

const branch = await client.models.StoreBranch.get(); // All identifier fields are required when retrieving an item
```
</InlineFilter>

```swift
let queriedStoreBranch = try await Amplify.API.query(
  request: .get(
      StoreBranch.self,
      byIdentifier: .identifier(
          geoId: "123",
          name: "Downtown")))
```
</InlineFilter>


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `pages/build-a-backend/data/data-modeling/identifiers/index.mdx`