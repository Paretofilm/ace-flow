---
title: Run a mutation
source: fragments/lib/graphqlapi/android/mutate-data.mdx
---

# Run a mutation

## Run a mutation

Now that the client is set up, you can run a GraphQL mutation with `Amplify.API.mutate` to create, update, and delete your data.

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

To update data, use `ModelMutation.update(todo)` instead. To delete data, use `ModelMutation.delete(todo)`.
