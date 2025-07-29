---
title: Documentation
source: fragments/lib-v1/graphqlapi/android/getting-started/50_createtodo.mdx
---

# Documentation

```java
Todo todo = Todo.builder()
    .name("My first todo")
    .description("todo description")
    .build();

Amplify.API.mutate(
    ModelMutation.create(todo),
    response -> Log.i("MyAmplifyApp", "Added Todo with id: " + response.getData().getId()),
    error -> Log.e("MyAmplifyApp", "Create failed", error)
);
```

</Block>

```kotlin
val todo = Todo.builder()
    .name("My first todo")
    .description("todo description")
    .build()

Amplify.API.mutate(ModelMutation.create(todo),
    ") },
    
)
```

</Block>

```kotlin
val todo = Todo.builder()
    .name("My first todo")
    .description("todo description")
    .build()
try ")
} catch (error: ApiException) 
```

</Block>

```java
Todo todo = Todo.builder()
        .name("My first todo")
        .description("todo description")
        .build();

RxAmplify.API.mutate(ModelMutation.create(todo))
        .subscribe(
              response -> Log.i("MyAmplifyApp", "Added Todo with id: " + response.getData().getId()),
              error -> Log.e("MyAmplifyApp", "Create failed", error)
        );
```

</Block>
</BlockSwitcher>
