---
title: Create an item
topics: ['Data & APIs']
primary_topic: Data & APIs
source: pages/build-a-backend/data/mutate-data/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Create an item

}

In this guide, you will learn how to create, update, and delete your data using Amplify Libraries' Data client.

Before you begin, you will need:

- An [application connected to the API](/[platform]/build-a-backend/data/connect-to-API/)

## Create an item

You can create an item by first generating the Data client with your backend Data schema. Then you can add an item:

```ts

const client = generateClient();

const  = await client.models.Todo.create()
```

> **Note**: 

**Note:** You do not need to specify `createdAt` or `updatedAt` fields because Amplify automatically populates these fields for you.

</InlineFilter>

You can run a GraphQL mutation with `Amplify.API.mutate` to create an item.

Make sure you have the following imports at the top of your file:

```swift
import Amplify
```

```swift
func createTodo() async 
    } catch let error as APIError  catch 
}
```

</Block>

You can run a GraphQL mutation with `Amplify.API.mutate`. Make sure you have the following imports at the top of your file:

```swift
import Amplify
import Combine
```

```swift
func createTodo() -> AnyCancellable 
    .sink 
    }
    receiveValue: 
    }
    return sink
}
```

</Block>

</BlockSwitcher>

</InlineFilter>

Now that the client is set up, you can run a GraphQL mutation with `Amplify.API.mutate` to create your data.

```java
Todo todo = Todo.builder()
    .name("My todo")
    .build();

Amplify.API.mutate(ModelMutation.create(todo),
    response -> Log.i("MyAmplifyApp", "Todo with id: " + response.getData().getId()),
    error -> Log.e("MyAmplifyApp", "Create failed", error)
);
```

</Block>

```kotlin
val todo = Todo.builder()
    .name("My todo")
    .build()

Amplify.API.mutate(ModelMutation.create(todo),
    ") }
    
)
```

</Block>

```kotlin
val todo = Todo.builder()
    .name("My todo")
    .build()
try ")
} catch (error: ApiException) 
```

</Block>

```java
Todo todo = Todo.builder()
        .name("My todo")
        .build();

RxAmplify.API.mutate(ModelMutation.create(todo))
        .subscribe(
            response -> Log.i("MyAmplifyApp", "Todo with id: " + response.getData().getId()),
            error -> Log.e("MyAmplifyApp", "Create failed", error)
        );
```

</Block>
</BlockSwitcher>

</InlineFilter>

You can run a GraphQL mutation with `Amplify.API.mutate` to create your data.

```dart
Future<void> createTodo() async ');
      return;
    }
    safePrint('Mutation result: $');
  } on ApiException catch (e) 
}
```

</InlineFilter>

## Update an item

To update the item, use the `update` function:

```ts

const client = generateClient();

const todo = ;

const  = await client.models.Todo.update(todo);
```

> **Note**: 

**Notes:**

- You do not need to specify the `updatedAt` field. Amplify will automatically populate this field for you.
- If you specify _extra_ input fields not expected by the API, this query will fail. You can see this in the `errors` field returned by the query. With Amplify Data, errors are not thrown like exceptions. Instead, any errors are captured and returned as part of the query result in the `errors` field.

</InlineFilter>

To update data, replace the request with `.update`.

```swift
try await Amplify.API.mutate(request: .update(todo))
```

</InlineFilter>

To update data, use `ModelMutation.update(todo)` instead.

</InlineFilter>

To update the `Todo` with a new name:

```dart
Future<void> updateTodo(Todo originalTodo) async 
```

</InlineFilter>

## Delete an item

You can then delete the Todo by using the delete mutation. To specify which item to delete, you only need to provide the `id` of that item:

```js

const client = generateClient();

const toBeDeletedTodo = 

const  = await client.models.Todo.delete(toBeDeletedTodo)
```

> **Note**: 

**Note:** When deleting items in many-to-many relationships, the join table records must be deleted before deleting the associated records. For example, for a many-to-many relationship between Posts and Tags, delete the PostTags join record before deleting a Post or Tag. Review [Many-to-many relationships](/[platform]/build-a-backend/data/data-modeling/relationships/) for more details.

Each API request uses an authorization mode. If you get unauthorized errors, you may need to update your authorization mode. To override the default authorization mode defined in your **amplify/data/resource.ts** file, pass an `authMode` property to the request or the client. The following examples show how you can mutate data with a custom authorization mode:

```ts

const client = generateClient();

const  = await client.models.Todo.create(
  ,
  
);
```

</Accordion>

</InlineFilter>

To delete data, replace the request with `.delete`.

```swift
try await Amplify.API.mutate(request: .delete(todo))
```

</InlineFilter>

To delete data, use `ModelMutation.delete(todo)`.

</InlineFilter>

To delete the `Todo`:

```dart
Future<void> deleteTodo(Todo todoToDelete) async 
```

Or you can delete by ID, which is ideal if you do not have the instance in memory yet:

```dart
Future<void> deleteTodoById(Todo todoToDelete) async 
```

</InlineFilter>

## Cancel create, update, and delete requests

You can cancel any mutation API request by calling `.cancel` on the mutation request promise that's returned by `.create(...)`, `.update(...)`, or `.delete(...)`.

```ts
const promise = client.models.Todo.create();
//  ^ Note: we're not awaiting the request, we're returning the promise

try  catch (error) 
}

//...

// To cancel the above request
client.cancel(promise, 'my message for cancellation');
```

You need to ensure that the promise returned from `.create()`, `.update()`, and `.delete()` has not been modified. Typically, async functions wrap the promise being returned into another promise. For example, the following will **not** work:

```ts
async function makeAPICall() );
}
const promise = makeAPICall();

// The following will NOT cancel the request.
client.cancel(promise, 'my error message');
```

</InlineFilter>

## Conclusion

Congratulations! You have finished the **Create, update, and delete application data** guide. In this guide, you created, updated, and deleted your app data.

### Next steps

Our recommended next steps include using the API to query data and subscribe to real-time events to look for mutations in your data. Some resources that will help with this work include:

- [Read application data](/[platform]/build-a-backend/data/query-data/)
- [Subscribe to real-time events](/[platform]/build-a-backend/data/subscribe-data/)


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `pages/build-a-backend/data/mutate-data/index.mdx`