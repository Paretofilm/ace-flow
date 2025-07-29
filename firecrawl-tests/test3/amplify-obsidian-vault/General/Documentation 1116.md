---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib/graphqlapi/android/advanced-workflows/10_example.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Documentation

```java
Todo todo = Todo.builder()
    .name("My first todo")
    .description("todo description")
    .build();

Amplify.API.mutate(ModelMutation.create(todo),
    result -> Log.i("ApiDemo", "Mutation succeeded."),
    failure -> Log.e("ApiDemo", "Mutation failed.", failure)
);
```

</Block>

```kotlin
val todo = Todo.builder()
    .name("My first todo")
    .description("todo description")
    .build()

Amplify.API.mutate(ModelMutation.create(todo),
    ,
    
)
```

</Block>

```kotlin
val todo = Todo.builder()
    .name("My first todo")
    .description("todo description")
    .build()

try  catch (error: ApiException) 
```

</Block>

```java
Todo todo = Todo.builder()
    .name("My first todo")
    .description("todo description")
    .build();

Amplify.API.mutate(ModelMutation.create(todo))
    .subscribe(
        result -> Log.i("ApiDemo", "Mutation succeeded"),
        failure -> Log.e("ApiDemo", "Mutation failed", failure)
    );
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/graphqlapi/android/advanced-workflows/10_example.mdx`