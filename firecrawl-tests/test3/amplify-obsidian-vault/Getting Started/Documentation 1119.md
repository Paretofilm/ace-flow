---
title: Documentation
topics: ['Getting Started']
primary_topic: Getting Started
source: fragments/lib/graphqlapi/android/getting-started/50_createtodo.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, getting-started]
---


## 🧭 Navigation
**Topics**: [[Getting Started/]]
**Primary**: [[Getting Started/]]

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


---

## 📚 Related Topics
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/graphqlapi/android/getting-started/50_createtodo.mdx`